module styx2000.protobj.count;

private {
	import std.string : format;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.size;
}

// count of bytes
class Count : Size
{
	this(uint size = 0)
	{
		super(size);
	}
	
	alias getCount = getSize;
	alias setCount = setSize;
	
	// string representation
	override string toString()
	{
		return format(`Count(size=%d)`, _size);
	}
	
	alias pack this;
}
