module styx2000.protobj.size;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

// tag identificator
class Size : StyxObject
{
	protected {
		uint _size;
		
		ubyte[] _representation;
	}
	
	// create from value
	this(uint size = 0)
	{
		_size = size;
		_representation = toLEBytes!uint(size);
	}
	
	// getter
	uint getSize()
	{
		return _size;
	}
	
	// setter
	void setSize(uint size)
	{
		_size = size;
		_representation = toLEBytes!uint(size);
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..4];
		_size = fromLEBytes!uint(bytes[0..4]);
	}
	
	// string representation
	override string toString()
	{
		return format(`Size(size=%d)`, _size);
	}
	
	alias pack this;
}
