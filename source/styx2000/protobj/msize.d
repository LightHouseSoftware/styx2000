module styx2000.protobj.msize;

private {
	import std.string : format;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.size;
}

// count of bytes
class Msize : Size
{
	this(uint size = 0)
	{
		super(size);
	}
	
	// string representation
	override string toString()
	{
		return format(`MaximalSize(msize=%d)`, _size);
	}
	
	alias pack this;
}
