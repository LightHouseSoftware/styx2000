// Written in the D programming language.

/**
Module for encoding objects of the 9P / Styx protocol into raw bytes.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protomsg.encoder;

private {
	import styx2000.protomsg.typeconv;
	import styx2000.protomsg.verificators;
}

public {
	import styx2000.protoconst.messages;
	import styx2000.protoconst.sizes;
	
	import styx2000.protobj;
}


/**
Encodes a set of 9P / Styx protocol objects into byte representation (array of unsigned bytes)
Params:
msg = Array of 9P / Styx protocol objects that represents message.

Typical usage:
----
import std.stdio;
// Example of server message (R_STAT)

// initially, zero size of message
Size size = new Size;
// tag (mark foir message)
Tag tag = new Tag(1);
// R-message, type: stat
Type type = new Type(STYX_MESSAGE_TYPE.R_STAT);
// unique server object
Qid qid = new Qid(STYX_QID_TYPE.QTDIR, 0, 0);

// chmod 775 (drwxrwxr-x)
Perm perm = new Perm;
perm.setPerm(
	STYX_FILE_PERMISSION.DMDIR | STYX_FILE_PERMISSION.OWNER_EXEC | STYX_FILE_PERMISSION.OWNER_READ | STYX_FILE_PERMISSION.OWNER_WRITE |
	STYX_FILE_PERMISSION.GROUP_READ | STYX_FILE_PERMISSION.GROUP_WRITE | STYX_FILE_PERMISSION.GROUP_EXEC | 
	STYX_FILE_PERMISSION.OTHER_READ | STYX_FILE_PERMISSION.OTHER_EXEC 
);
	
// construct stat	
Stat stat = new Stat(
	// type and dev for kernel use 
	77, 4,
	qid,
	// permissions
	perm,
	// access time (as unix timestamp)
	0,
	// modification time (as unix timestamp)
	0,
	// conventional length for all directories is 0
	0,
	// file name (this, directory name)
	"test",
	// user name (owner of file)
	"duser",
	// user group name
	"d_user",
	// others group name
	""
);

// all 9P object in one array with general type
StyxObject[] msg = cast(StyxObject[]) [size, type, tag, stat];
msg.encode.writeln;
----
*/
auto encode(StyxObject[] msg)
{
	ubyte[] _representation;
	
	if (msg.length == 0)
	{
		throw new Exception(`Bad Styx message length: empty message`);
	}
	else
	{
		if (msg.length < 3)
		{
			throw new Exception(`Bad Styx message length: message contains no Styx header`);
		}
		else
		{
			auto size = fromStyxObject!Size(msg[0]);
			if (size is null)
			{
				throw new Exception(`Bad message content: wrong Size object`);
			}
			
			auto type = fromStyxObject!Type(msg[1]);
			if (type is null)
			{
				throw new Exception(`Bad message content: wrong Type object`);
			}
			
			auto tag = fromStyxObject!Tag(msg[2]);
			if (tag is null)
			{
				throw new Exception(`Bad message content: wrong Tag object`);
			}
			
			if (!hasValidFieldsCount(type, msg))
			{
				throw new Exception(`Bad message content: wrong fields count`);
			}
			
			if (!hasValidFieldsTypes(type, msg))
			{
				throw new Exception(`Bad message content: wrong Styx type in message`);
			}
			
			size_t length = 0;
			
			foreach (f; msg[1..$])
			{
				if (f is null)
				{
					throw new Exception("Bad message content: null Styx object");
				}
				
				auto packed = f.pack;
				length += packed.length;
				_representation ~= packed;
			}
			
			size.setSize(length + 4);
			_representation = size ~ _representation;
		}
	}
	
	return _representation;
}
