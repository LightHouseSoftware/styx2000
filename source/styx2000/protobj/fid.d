module styx2000.protobj.fid;

private {
	import std.string : format;

	import styx2000.lowlevel.endianness;
	
	import styx2000.protoconst.base : STYX_NOFID;
	
	import styx2000.protobj.styxobject;
}

// file identificator
class Fid : StyxObject
{
	protected {
		uint _fid;
		
		ubyte[] _representation;
	}
	
	// create from value
	this(uint fid = STYX_NOFID)
	{
		_fid = fid;
		_representation = toLEBytes!uint(fid);
	}
	
	// getter
	uint getFid()
	{
		return _fid;
	}
	
	// setter
	void setFid(uint fid)
	{
		_fid = fid;
		_representation = toLEBytes!uint(fid);
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
		_fid = fromLEBytes!uint(bytes[0..4]);
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Fid(fid=%d)`,
			_fid
		);
	}
	
	alias pack this;
}

// pseudoname for NewFid element for convenience
alias NewFid = Fid;
