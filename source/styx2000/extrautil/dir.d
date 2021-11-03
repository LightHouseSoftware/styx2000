// Written in the D programming language.

/**
This module contains the basic definition of the Dir structure, which is a representation of a folder or file. This structure is not found in the protocol description, but can be useful in the construction of some protocol messages, such as a read message.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.extrautil.dir;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.stat;
}

public {
	import styx2000.protobj.perm;
	import styx2000.protobj.qid;
}

/// Directory entry representation in some 9P messages. The constructor parameters are the same as the constructor parameters of the Stat structure.
class Dir : Stat
{
	/// Contruct from raw values: The constructor parameters are the same as the constructor parameters of the Stat structure.
	this(
		ushort  type    = 0,
		uint    dev     = 0,
		Qid     qid     = new Qid,
		Perm    mode    = new Perm,
		uint    atime   = 0,
		uint    mtime   = 0,
		ulong   length  = 0,
		string  name    = "",
		string  uid     = "",
		string  gid     = "",
		string  muid    = ""
	)
	{
		super(type, dev, qid, mode, atime, mtime, length, name, uid, gid, muid);
	}
		
	/// Pack to byte array	
	override ubyte[] pack()
	{
		return _representation[2..$];
	}
	
	/// Unpack from byte array
	override void unpack(ubyte[] bytes...)
	{
		auto _contents = VariableLengthSequence.pack(bytes);
		return super.unpack(_contents);
	}
	
	/// String representation of Dir structure
	override string toString()
	{
		return format(
			`Dir(type=%s, dev=%s, qid=%s, mode=%s, atime=%d, mtime=%d, length=%s, name="%s", uid="%s", gid="%s", muid="%s")`,
			_type.to!string,
			_dev.to!string,
			_qid.to!string,
			_mode.to!string,
			_atime,
			_mtime,
			_length,
			(_name == "") ? `` : _name,
			(_uid  == "") ? `` : _uid,
			(_gid  == "") ? `` : _gid,
			(_muid == "") ? `` : _muid
		);
	}
	
	/// Pack to binary data
	alias pack this;
}

/// Convert Stat object to Dir object
Dir stat2dir(Stat stat)
{
	auto _contents = stat.pack;
	Dir dir = new Dir;
	dir.unpack(_contents[2..$]);
	return dir;
}

/// Convert Dir object to Stat object
Stat dir2stat(Dir dir)
{
	auto _contents = VariableLengthSequence.pack(dir.pack);
	Stat stat = new Stat;
	stat.unpack(_contents);
	return stat;
}
