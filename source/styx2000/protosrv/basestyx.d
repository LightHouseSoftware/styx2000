// Written in the D programming language.

/**
This module contains the base class of the 9P / Styx server for implementing your own server.

Copyright: LightHouse Software, 2023
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.protosrv.basestyx;

private {
	import styx2000.extrautil.casts;
    import styx2000.extrautil.miscerrors;
    import styx2000.extrautil.mischelpers;
    import styx2000.extrautil.styxmessage;
    
    import styx2000.protoconst;
    import styx2000.protobj;
    
    import styx2000.protosrv.baseserver;
}

/// Alias for arguments of Styx handlers
alias StyxArguments = StyxObject[];


/// Base class for all Styx servers
class BaseStyxServer(uint BUFFER_SIZE, uint MAXIMAL_NUMBER_OF_CONNECTIONS, uint MAXIMAL_MESSAGE_SIZE = 8_192) : BaseServer!(BUFFER_SIZE, MAXIMAL_NUMBER_OF_CONNECTIONS)
{
	bool DEBUG_MODE = false;
	
	override ubyte[] handle(ubyte[] request)
	{
		StyxMessage response;
		
		if (request.length < 3)
		{
			response = createRmsgError(STYX_NOTAG, cast(string) STYX_ERROR_MESSAGE.ETOOSMALL);
		}
		else
		{
			/// decoded message
			auto msg = decode(request);
			/// header from message
			auto header = extractHeader(msg);
			
			switch (header.type)
			{
				case STYX_MESSAGE_TYPE.T_VERSION:
				    response = handleVersion(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_AUTH:
				    response = handleAuth(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_ATTACH:
					response = handleAttach(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_WALK:
					response = handleWalk(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_OPEN:
					response = handleOpen(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_READ:
					response = handleRead(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_STAT:
					response = handleStat(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_CLUNK:
					response = handleClunk(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_FLUSH:
					response = handleFlush(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_CREATE:
					response = handleCreate(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_WRITE:
					response = handleWrite(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_REMOVE:
					response = handleRemove(header.tag, msg[3..$]);
					break;
				case STYX_MESSAGE_TYPE.T_WSTAT:
					response = handleWstat(header.tag, msg[3..$]);
					break;
				default:
					response = createRmsgError(header.tag, cast(string) STYX_ERROR_MESSAGE.EINVALIDMSGTYPE);
					break;
			}
			
			/// if response length less than 3 (minimal styx m,essage length) then functional not implemented by programmer
			if (response.length < 3)
			{
				response = createRmsgError(header.tag, "Functional not implemented");
			}
		}
		
		if (DEBUG_MODE)
		{
			import std.stdio : writeln;
			
			if (request.length < 3)
			{
				writeln(`-> `, "Invalid 9P/Styx message");
				writeln(`<- `, response.toPlan9Message);
			}
			else
			{
				auto query = decode(request);
				
				writeln(`-> `, query.toPlan9Message);
				writeln(`<- `, response.toPlan9Message);
			}
		}
			
		return encode(fixMessageSize(response));
	}
	
	protected {
		alias StyxArguments = StyxObject[];
		
		/// 1. version message
		StyxMessage handleVersion(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 2. auth message
		StyxMessage handleAuth(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 3. attach message
		StyxMessage handleAttach(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 4. walk message
		StyxMessage handleWalk(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 5. open message
		StyxMessage handleOpen(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 6. read message
		StyxMessage handleRead(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 7. stat message
		StyxMessage handleStat(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 8. clunk message
		StyxMessage handleClunk(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 9. flush message
		StyxMessage handleFlush(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 10. create message
		StyxMessage handleCreate(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 11. write message
		StyxMessage handleWrite(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 12. remove message
		StyxMessage handleRemove(ushort tag, StyxArguments args)
		{
			return [];
		}
		
		/// 13. wstat message
		StyxMessage handleWstat(ushort tag, StyxArguments args)
		{
			return [];
		}
	}
}
