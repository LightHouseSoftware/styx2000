module styx2000.protomsg.decoder;

private {
	import styx2000.lowlevel.endianness;
	
	import styx2000.protomsg.typeconv;
}

public {
	import styx2000.protoconst.messages;

	import styx2000.protobj;
}

private {
	/// Decode fields with using only types list
	auto decodeMessageFields(E...)(ubyte[] bytes...)
	{
		E listOfTypes;
		StyxObject[] msg;
		
		ulong vlsPosition = 0;
	
		foreach (e; listOfTypes)
		{
			auto messageField = new typeof(e);
			messageField.unpack(bytes[vlsPosition..$]);
			vlsPosition += (messageField.length);
			msg ~= cast(StyxObject) messageField;
		}
		
		return msg;
	}
	
	/// Decode message based on message type
	auto decodeMessageFields(Type type, ubyte[] bytes...)
	{
		StyxObject[] msg;
		
		with (STYX_MESSAGE_TYPE)
		{
			switch(type.getType) {
				// version
				case R_VERSION:
					msg = decodeMessageFields!Rversion(bytes);
					break;
				case T_VERSION:
					msg = decodeMessageFields!Tversion(bytes);
					break;
				// auth
				case R_AUTH:
					msg = decodeMessageFields!Rauth(bytes);
					break;
				case T_AUTH:
					msg = decodeMessageFields!Tauth(bytes);
					break;
				// error
				case R_ERROR:
					msg = decodeMessageFields!Rerror(bytes);
					break;
				// flush
				case R_FLUSH:
					msg = decodeMessageFields!Rflush(bytes);
					break;
				case T_FLUSH:
					msg = decodeMessageFields!Tflush(bytes);
					break;
				// attach
				case R_ATTACH:
					msg = decodeMessageFields!Rattach(bytes);
					break;
				case T_ATTACH:
					msg = decodeMessageFields!Tattach(bytes);
					break;
				// walk
				case R_WALK:
					msg = decodeMessageFields!Rwalk(bytes);
					break;
				case T_WALK:
					msg = decodeMessageFields!Twalk(bytes);
					break;
				// open
				case R_OPEN:
					msg = decodeMessageFields!Ropen(bytes);
					break;
				case T_OPEN:
					msg = decodeMessageFields!Topen(bytes);
					break;
				// create
				case R_CREATE:
					msg = decodeMessageFields!Rcreate(bytes);
					break;
				case T_CREATE:
					msg = decodeMessageFields!Tcreate(bytes);
					break;
				// read
				case R_READ:
					msg = decodeMessageFields!Rread(bytes);
					break;
				case T_READ:
					msg = decodeMessageFields!Tread(bytes);
					break;
				// write
				case R_WRITE:
					msg = decodeMessageFields!Rwrite(bytes);
					break;
				case T_WRITE:
					msg = decodeMessageFields!Twrite(bytes);
					break;
				// clunk
				case R_CLUNK:
					msg = decodeMessageFields!Rclunk(bytes);
					break;
				case T_CLUNK:
					msg = decodeMessageFields!Tclunk(bytes);
					break;
				// remove
				case R_REMOVE:
					msg = decodeMessageFields!Rremove(bytes);
					break;
				case T_REMOVE:
					msg = decodeMessageFields!Tremove(bytes);
					break;
				// stat
				case R_STAT:
					msg = decodeMessageFields!Rstat(bytes);
					break;
				case T_STAT:
					msg = decodeMessageFields!Tstat(bytes);
					break;
				// wstat
				case R_WSTAT:
					msg = decodeMessageFields!Rwstat(bytes);
					break;
				case T_WSTAT:
					msg = decodeMessageFields!Twstat(bytes);
					break;
				default:
					//throw new Exception("Bad message type");
					break;
			}
		}
		return msg;
	}
}

/**
Decodes the received set of bytes into 9P / Styx protocol objects.
Params:
bytes = Array of unsigned bytes that represents message.

Typical usage:
----
import std.stdio;
auto msg = decode([73, 0, 0, 0, 125, 1, 0, 64, 0, 62, 0, 77, 0, 4, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 253, 1, 0, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 116, 101, 115, 116, 5, 0, 100, 117, 115, 101, 114, 6, 0, 100, 95, 117, 115, 101, 114, 0, 0]
);
// prints [Size(size=73), R_STAT, Tag(tag=0x0001), Stat(type=77, dev=4, qid=Qid(type=QTDIR, vers=0, path=0), mode=Permissions(perm=0x800001fd), atime=0, mtime=0, length=0, name="test", uid="duser", gid="d_user", muid="")
msg.writeln;
----
*/
auto decode(ubyte[] bytes...)
{
	StyxObject[] msg; 
	
	if (bytes.length == 0)
	{
		throw new Exception(`Bad Styx message length: empty message`);
	}
	else
	{
		if (bytes.length < 7)
		{
			throw new Exception(`Bad Styx message length: message contains no Styx header`);
		}
		else
		{
			size_t messageLength = fromLEBytes!size_t(bytes[0..4]);
			
			if (bytes.length < messageLength)
			{
				throw new Exception(`Bad Styx message length: size in header exceeded real message length`);
			}
			else
			{
				ubyte type = bytes[4];
				
				if ((type < 100) || (type > 127))
				{
					throw new Exception(`Bad message content: wrong message type`);
				}
				else
				{
					auto msgType = new Type(cast(STYX_MESSAGE_TYPE) type);
					msg = decodeMessageFields(msgType, bytes);
				}
			}
		}
	}
	
	return msg;
}
