// Written in the D programming language.

/**
This module contains the base class of the server that can be used to create various kinds of servers.

Copyright: LightHouse Software, 2023
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.protosrv.baseserver;

private {
    import std.algorithm : remove;
    import std.socket;
}

class BaseServer(uint BUFFER_SIZE, uint MAXIMAL_NUMBER_OF_CONNECTIONS)
{
    protected
    {
        ubyte[BUFFER_SIZE] _buffer;

        string _address;
        ushort _port;
        bool _immediate;
        Socket _listener;
        Socket[] _readable;
        SocketSet _sockets;
    }

	
	
	/**
	An abstract method that must be implemented in a derived class and that is necessary for the server to process incoming data.
	Params:
	request = Array of unsigned bytes that represents message.
	*/
    abstract ubyte[] handle(ubyte[] request);

	/**
	Runs a configured server.
	*/
    final void run()
    {
        while (true)
        {
            serve;

            scope (failure)
            {
                _sockets = null;
                _listener.close;
            }
        }
    }


	/**
	An abstract method that must be implemented in a derived class and that is necessary for the server to process incoming data.
	Params:
	address = IPv4 address as string.
	port = Unsigned port number.
	backlog = An integer that means the number of established connections that can be processed at any time.
	immediate = The logical value showing whether the server will close the connection after processing the request from the client.
	*/
    final void setup4(string address, ushort port, int backlog = 10, bool immediate = false)
    {
        _address = address;
        _port = port;
        _listener = new Socket(AddressFamily.INET, SocketType.STREAM);
        _immediate = immediate;

        with (_listener)
        {
            bind(new InternetAddress(_address, _port));
            listen(backlog);
        }

        _sockets = new SocketSet(MAXIMAL_NUMBER_OF_CONNECTIONS + 1);
    }


	/**
	An abstract method that must be implemented in a derived class and that is necessary for the server to process incoming data.
	Params:
	address = IPv4 address as string.
	port = Unsigned port number.
	backlog = An integer that means the number of established connections that can be processed at any time.
	immediate = The logical value showing whether the server will close the connection after processing the request from the client.
	*/
    final void setup6(string address, ushort port, int backlog = 10, bool immediate = false)
    {
        _address = address;
        _port = port;
        _listener = new Socket(AddressFamily.INET6, SocketType.STREAM);
        _immediate = immediate;

        with (_listener)
        {
            bind(new Internet6Address(_address, _port));
            listen(backlog);
        }

        _sockets = new SocketSet(MAXIMAL_NUMBER_OF_CONNECTIONS + 1);
    }

    private
    {
		/// Serve a connection. For internal use.
        final void serve()
        {
            _sockets.add(_listener);

            foreach (socket; _readable)
            {
                _sockets.add(socket);
            }

            Socket.select(_sockets, null, null);

            for (uint i = 0; i < _readable.length; i++)
            {
                if (_sockets.isSet(_readable[i]))
                {
                    auto realBufferSize = _readable[i].receive(_buffer);

                    if (realBufferSize != 0)
                    {
                        auto data = _buffer[0 .. realBufferSize];

                        _readable[i].send(handle(data));
                    }

                    if (_immediate)
                    {
                        _readable[i].close;
                        _readable = _readable.remove(i);
                        i--;
                    }
                }
            }

            if (_sockets.isSet(_listener))
            {
                Socket currentSocket = null;

                scope (failure)
                {
                    if (currentSocket)
                    {
                        currentSocket.close;
                    }
                }

                currentSocket = _listener.accept;

                if (_readable.length < MAXIMAL_NUMBER_OF_CONNECTIONS)
                {
                    _readable ~= currentSocket;
                }
                else
                {
                    currentSocket.close;
                }
            }
            _sockets.reset;
        }
    }
}
