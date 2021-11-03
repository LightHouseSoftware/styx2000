// Written in the D programming language.

/**
This module provides a DirStat structure, which is a folder view containing the Strat structures for a folder. The description of the structure is absent in the Styx protocol, but it can be useful in the formation of some types of messages.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.extrautil.dirstat;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.extrautil.dir;
	
	import styx2000.protobj.perm;
	import styx2000.protobj.qid;
}


/// Data structure to represent directory with Stat data
class DirStat : StyxObject
{
	protected {
		Dir[] _dirs;
		ubyte[] _representation;
	}
	
	/// Construct DirStat
	this(Dir[] dirs...)
	{
		_dirs = dirs;
		
		foreach (dir; dirs)
		{
			_representation ~= dir.pack;
		}
	}
	
	/// Get directory entries
	Dir[] getDirs()
	{
		return _dirs;
	}
	
	/// Set directory entries
	void setDirs(Dir[] dirs...)
	{
		_dirs = dirs;
		_representation = [];
		
		foreach (dir; dirs)
		{
			_representation ~= dir.pack;
		}
	}
	
	/// Save to byte array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Restore from bytes
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes;
		_dirs = [];
		auto _contents = bytes;
		
		while (_contents.length != 0)
		{
			auto dirSize = fromLEBytes!ushort(_contents[0..2]) + 2;
			auto dir = _contents[0..dirSize];
			Dir d = new Dir;
			d.unpack(dir);
			_dirs ~= d;
			_contents = _contents[dirSize..$];
		}
	}
	
	/// String representation of DirStat
	override string toString()
	{
		return format(
			`DirStat(dirs=%s)`,
			_dirs.to!string
		);
	}
	
	/// Pack to binary data
	alias pack this;	
}
