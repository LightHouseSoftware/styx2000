module styx2000.protobj.perm;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protoconst.permissions;
}

// tag identificator
class Perm : StyxObject
{
	protected {
		uint _perm;
		
		ubyte[] _representation;
	}
	
	// create from value
	this(uint perm = 0)
	{
		_perm = perm;
		_representation = toLEBytes!uint(perm);
	}
	
	// getter
	uint getPerm()
	{
		return _perm;
	}
	
	// setter
	void setPerm(uint perm)
	{
		_perm = perm;
		_representation = toLEBytes!uint(perm);
	}
	
	void setPerm(STYX_FILE_PERMISSION[] perm...)
	{
		uint permissions;
		
		foreach (e; perm)
		{
			permissions |= cast(uint) e;
		}
		_perm = permissions;
		_representation = toLEBytes!uint(permissions);
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
		_perm = fromLEBytes!uint(bytes[0..4]);
	}
	
	// string representation
	override string toString()
	{
		return format(`Permissions(perm=0x%0.8x)`, _perm);
	}
	
	alias pack this;
}
