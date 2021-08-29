module styx2000.protobj.iounit;

private {
	import std.string : format;

	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

// io unit for atomic operations
class Iounit : StyxObject
{
	protected {
		uint _iounit;
		
		ubyte[] _representation;
	}
	
	// create from value
	this(uint iounit = 0)
	{
		_iounit = iounit;
		_representation = toLEBytes!uint(iounit);
	}
	
	// getter
	uint getUnit()
	{
		return _iounit;
	}
	
	// setter
	void setUnit(uint iounit)
	{
		_iounit = iounit;
		_representation = toLEBytes!uint(iounit);
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
		_iounit = fromLEBytes!uint(bytes[0..4]);
	}
	
	// string representation
	override string toString()
	{
		return format(
			`IOunit(iounit=%d)`,
			_iounit
		);
	}
	
	alias pack this;
}
