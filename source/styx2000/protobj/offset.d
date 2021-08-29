module styx2000.protobj.offset;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

// offset 
class Offset : StyxObject
{
	protected {
		ulong _offset;
		
		ubyte[] _representation;
	}
	
	// create from value
	this(ulong offset = 0)
	{
		_offset = offset;
		_representation = toLEBytes!ulong(offset);
	}
	
	// getter
	ulong getOffset()
	{
		return _offset;
	}
	
	// setter
	void setOffset(ulong offset)
	{
		_offset = offset;
		_representation = toLEBytes!ulong(offset);
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..8];
		_offset = fromLEBytes!ulong(bytes[0..8]);
	}
	
	// string representation
	override string toString()
	{
		return format(`Offset(offset=%d)`, _offset);
	}
	
	alias pack this;
}
