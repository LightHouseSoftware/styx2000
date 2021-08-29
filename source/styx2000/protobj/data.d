module styx2000.protobj.data;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.protobj.styxobject;
}

// raw bytes in messages
class Data : StyxObject
{
	protected {		
		ubyte[] _representation;
	}
	
	// create from value
	this(ubyte[] data = [])
	{
		_representation = data;
	}
	
	// getter
	ubyte[] getData()
	{
		return _representation;
	}
	
	// setter
	void setData(ubyte[] data)
	{
		_representation = data;
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return this.getData;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		this.setData(bytes);
	}
	
	// string representation
	override string toString()
	{
		return format(`Data(bytes=%s)`, _representation.to!string);
	}
	
	alias pack this;
}
