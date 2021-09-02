module styx2000.protobj.tag;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protoconst.base : STYX_NOTAG;
	
	import styx2000.protobj.styxobject;
}

// tag identificator
class Tag : StyxObject
{
	protected {
		ushort _tag;
		
		ubyte[] _representation;
	}
	
	// create from value
	this(ushort tag = STYX_NOTAG)
	{
		_tag = tag;
		_representation = toLEBytes!ushort(tag);
	}
	
	// getter
	ushort getTag()
	{
		return _tag;
	}
	
	// setter
	void setTag(ushort tag)
	{
		_tag = tag;
		_representation = toLEBytes!ushort(tag);
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..2];
		_tag = fromLEBytes!ushort(bytes[0..2]);
	}
	
	// string representation
	override string toString()
	{
		return format(`Tag(tag=0x%0.4x)`, _tag);
	}
	
	alias pack this;
}
