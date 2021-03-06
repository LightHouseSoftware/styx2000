# styx2000
Low-level, minimal implementation of Styx protocol (9P protocol from Plan 9/Inferno).

# Examples
### Working with basic protocol structures
In this example, we consider a method for unpacking a certain data structure, which is some aspect of the Styx protocol from its low-level representation into a data object and vice versa. 
It looks like this:
```d
#!/usr/bin/env dub
/+ dub.sdl:
	dependency "styx2000" version="~main"
+/

import std.stdio : writeln, writefln;
    
import styx2000.extrautil;
import styx2000.protobj;
import styx2000.protomsg;

void main()
{
	// sample byte array for dirstat
	ubyte[] data = [66, 0, 77, 0, 18, 0, 0, 0, 0, 253, 111, 52, 97, 102, 3, 16, 0, 0, 0, 3, 8, 180, 1, 0, 0, 239, 111, 52, 97, 253, 111, 52, 97, 18, 0, 0, 0, 0, 0, 0, 0, 3, 0, 97, 98, 99, 8, 0, 97, 113, 117, 97, 114, 101, 106, 105, 8, 0, 97, 113, 117, 97, 114, 101, 106, 105, 0, 0, 70, 0, 77, 0, 18, 0, 0, 0, 0, 79, 112, 52, 97, 100, 3, 16, 0, 0, 0, 3, 8, 180, 1, 0, 0, 79, 112, 52, 97, 79, 112, 52, 97, 28, 0, 0, 0, 0, 0, 0, 0, 7, 0, 116, 109, 112, 46, 116, 120, 116, 8, 0, 97, 113, 117, 97, 114, 101, 106, 105, 8, 0, 97, 113, 117, 97, 114, 101, 106, 105, 0, 0];
	DirStat ds = new DirStat;
	// restore from byte view
	ds.unpack(data);
	ds.writeln;
	
	// another sample for restoring structure
	Dir d = new Dir;
	d.unpack([66, 0, 77, 0, 18, 0, 0, 0, 0, 253, 111, 52, 97, 102, 3, 16, 0, 0, 0, 3, 8, 180, 1, 0, 0, 239, 111, 52, 97, 253, 111, 52, 97, 18, 0, 0, 0, 0, 0, 0, 0, 3, 0, 97, 98, 99, 8, 0, 97, 113, 117, 97, 114, 101, 106, 105, 8, 0, 97, 113, 117, 97, 114, 101, 106, 105, 0, 0]);
	d.writeln;
	// explicit conversion to byte representation
	d.pack.writeln;
}
```
The source file for this example can be compiled with the command:
```
dub build --single dir.d
```

### Parsing the file with the captured stream from the client to the server
The source file for the example is compiled with the command:
```
dub build --single styxdecoder.d
```
Content of styxdecoder.d file:
```d
#!/usr/bin/env dub
/+ dub.sdl:
	dependency "styx2000" version="~main"
+/

private {
	import std.file : exists;
	import std.stdio;

	import styx2000.extrautil.msgranges : byTextMessage;
}

alias readBinaryFile = function(string filename) {
	static import std.file;
	return cast(ubyte[]) std.file.read(filename);
};

void main(string[] args)
{
	if (args.length < 2)
	 {
		 writeln(`Usage: styxdecoder <file1> [<file2> ... <fileN>]`);
	 }
	 else
	 {
		 foreach (f; args[1..$])
		 {
			 if (f.exists)
			 {
				 foreach (msg; f.readBinaryFile.byTextMessage)
				 {
					msg.writeln;
				 }
			 }
		 }
	 }
}
```
The working data for this script can be obtained by capturing traffic from the client to the server (or vice versa), for example, using the [tcpflow](https://github.com/simsong/tcpflow) utility.

### Empty folder, generated by server and shared via Styxprotocol
A minimal example of a production server that creates an empty folder and distributes it using the Styx protocol. This example is not intended for real use and serves as a demonstration of the library's capabilities. However, the folder can be mounted as a real filesystem using the 9pfuse (from Plan9port project) utility:
```
9pfuse 'tcp!127.0.0.1!4445' /mnt/
```
or can be accessed within the plan9 / Inferno operating systems. Real-world mount example from Inferno OS:
```
mount -A 'tcp!127.0.0.1!4444' /n
```
The source file for the example is compiled with the command:
```
dub build --single emptyfolder.d
```
Content of styxdecoder.d file:
```d
#!/usr/bin/env dub
/+ dub.sdl:
	dependency "styx2000" version="~main"
+/

private
{
    import std.algorithm : remove;
    import std.conv : to;
    import std.datetime.systime;
    import std.random : Random, uniform, unpredictableSeed;
    import std.socket;
    import std.stdio : writeln, writefln;

    import styx2000.extrautil;
    import styx2000.protoconst;
    import styx2000.protomsg;
    import styx2000.protobj;
    
    // convenience alias for Styx message datastructure
    alias StyxMessage = StyxObject[];
}

class EmptyFolderServer
{	
	private
	{
		// size of message
		Size _size = new Size;
		// type of R-message or T-message
		Type _type = new Type;
		// current tag
		Tag  _tag = new Tag;
		// current qid
		Qid _qid;
		// current time
		uint _time;
	}
	
	this()
	{
		auto rng = Random(unpredictableSeed);
		// current time for version in qid, atime, mtime
		_time = cast(uint) Clock.currTime.toUnixTime;
		// unique path identifier for qid
		ulong path = uniform(0, ulong.max, rng);
		_qid = new Qid(STYX_QID_TYPE.QTDIR, _time, path);
	}
	
	// minimal handler
	StyxMessage handle(StyxMessage query)
	{
		StyxMessage reply;
		
		Type type = cast(Type) query[1];
		_tag = cast(Tag) query[2];
		
		switch (type.getType)
		{
			case STYX_MESSAGE_TYPE.T_VERSION:
				reply = handleVersion(query);
 				break;
			case STYX_MESSAGE_TYPE.T_ATTACH:
				reply = handleAttach(query);
				break;
			case STYX_MESSAGE_TYPE.T_WALK:
				reply = handleWalk(query);
				break;
			case STYX_MESSAGE_TYPE.T_OPEN:
				reply = handleOpen(query);
				break;
			case STYX_MESSAGE_TYPE.T_READ:
				reply = handleRead(query);
				break;
			case STYX_MESSAGE_TYPE.T_STAT:
				reply = handleStat(query);
				break;
			case STYX_MESSAGE_TYPE.T_CLUNK:
				reply = handleClunk(query);
				break;
			default:
				reply = handleError(query, `wrong query to server`);
				break;
		}
		return (cast(StyxMessage) [_size, _type, _tag]) ~ reply;
	}
	
	// handle error and generate R-error message
	StyxMessage handleError(StyxMessage query, string error)
	{
		_type.setType(STYX_MESSAGE_TYPE.R_ERROR);
		Ename ename = new Ename(error);
		
		return cast(StyxMessage) [ename];
	}
	
	StyxMessage handleVersion(StyxMessage query)
	{
		_type.setType(STYX_MESSAGE_TYPE.R_VERSION);
		// maximal filesize (same on the client)
		Msize msize = cast(Msize) query[3];
		// current protocol version
		Version vers = new Version(`9P2000`);
		
		return cast(StyxMessage) [msize, vers];
	}
	
	StyxMessage handleAttach(StyxMessage query)
	{
		_type.setType(STYX_MESSAGE_TYPE.R_ATTACH);
		// initial qid: unique file identifier on server
		Qid qid = new Qid(STYX_QID_TYPE.QTDIR, 0, 0);
		 
		return cast(StyxMessage) [qid];
	}
	
	StyxMessage handleWalk(StyxMessage query)
	{
		_type.setType(STYX_MESSAGE_TYPE.R_WALK);
		// current file name: empty folder, name is ""
		Nwname name = cast(Nwname) query[5];
		// associated unique file identifier on server: empty
		Nwqid nwqid = new Nwqid;
		
		if (name.getName != [])
		{
			return handleError(query, `File does not exist`);
		}
		 
		return cast(StyxMessage) [nwqid];
	}
	
	StyxMessage handleStat(StyxMessage query)
	{
		_type.setType(STYX_MESSAGE_TYPE.R_STAT);
		
		// chmod 775 (drwxrwxr-x)
		Perm perm = new Perm;
		perm.setPerm(
			STYX_FILE_PERMISSION.DMDIR | STYX_FILE_PERMISSION.OWNER_EXEC | STYX_FILE_PERMISSION.OWNER_READ | STYX_FILE_PERMISSION.OWNER_WRITE |
			STYX_FILE_PERMISSION.GROUP_READ | STYX_FILE_PERMISSION.GROUP_WRITE | STYX_FILE_PERMISSION.GROUP_EXEC | 
			STYX_FILE_PERMISSION.OTHER_READ | STYX_FILE_PERMISSION.OTHER_EXEC 
		);
			
		Stat stat = new Stat(
			// type and dev for kernel use (taken from some experiments with styxdecoder, see above)
			77, 4,
			_qid,
			// permissions
			perm,
			// access time
			_time,
			// modification time
			_time,
			// conventional length for all directories is 0
			0,
			// file name (this, directory name)
			"test",
			// user name (owner of file)
			"test",
			// user group name
			"test",
			// others group name
			""
		);
		 
		return cast(StyxMessage) [stat];
	}
	
	StyxMessage handleOpen(StyxMessage query)
	{
		_type.setType(STYX_MESSAGE_TYPE.R_OPEN);
		// standard value from some clients
		Iounit io = new Iounit(8168);
		 
		return cast(StyxMessage) [_qid, io];
	}
	
	StyxMessage handleRead(StyxMessage query)
	{
		_type.setType(STYX_MESSAGE_TYPE.R_READ);
		// length of data is zero
		Count count = new Count(0);
		// empty data array
		Data data = new Data;
		 
		return cast(StyxMessage) [count, data];
	}
	
	StyxMessage handleClunk(StyxMessage query)
	{
		_type.setType(STYX_MESSAGE_TYPE.R_CLUNK);
		
		return cast(StyxMessage) [];
	}
}

void main()
{
    auto listener = new Socket(AddressFamily.INET, SocketType.STREAM);
    listener.bind(new InternetAddress("127.0.0.1", 4445));
    listener.listen(10);
    
    SocketSet readSet = new SocketSet;
    Socket[] connectedClients; 
    ubyte[1024] buffer;
    
    bool isRunning = true;
    
    EmptyFolderServer fs = new EmptyFolderServer;
    
    while (isRunning)
    {
        readSet.reset;
        readSet.add(listener);
        foreach (client; connectedClients)
        {
            readSet.add(client);
        }

        if (Socket.select(readSet, null, null))
        {
            foreach (client; connectedClients)
            {
                if (readSet.isSet(client))
                {
                    auto got = client.receive(buffer);
                    auto tmsg = buffer.decode;
                    auto rmsg = fs.handle(tmsg).encode;
                    client.send(rmsg);
                }
            }
            
            if (readSet.isSet(listener))
            {
                auto newSocket = listener.accept;
                connectedClients ~= newSocket; 
            }
        }
    }
}
```
