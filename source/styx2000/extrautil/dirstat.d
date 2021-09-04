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


// data structure to represent directory with Stat data
class DirStat : StyxObject
{
	protected {
		Dir[] _dirs;
		ubyte[] _representation;
	}
	
	// construct
	this(Dir[] dirs...)
	{
		_dirs = dirs;
		
		foreach (dir; dirs)
		{
			_representation ~= dir.pack;
		}
	}
	
	// get directory entries
	Dir[] getDirs()
	{
		return _dirs;
	}
	
	// set directory entries
	void setDirs(Dir[] dirs...)
	{
		_dirs = dirs;
		_representation = [];
		
		foreach (dir; dirs)
		{
			_representation ~= dir.pack;
		}
	}
	
	// save to byte array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// restore from bytes
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes;
		_dirs = [];
		auto _contents = bytes;
		
		while (_contents.length != 0)
		{
			auto dirSize = fromLEBytes!ushort(_contents[0..2]) + 2;
			auto dir = VariableLengthSequence.pack(_contents[0..dirSize]);
			Dir d = new Dir;
			d.unpack(dir);
			_dirs ~= d;
			_contents = _contents[dirSize..$];
		}
	}
	
	// string representation
	override string toString()
	{
		return format(
			`DirStat(wmname="%s")`,
			_dirs.to!string
		);
	}
	
	alias pack this;	
}
