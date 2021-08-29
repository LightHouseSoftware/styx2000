module styx2000.protobj.afid;

private {
	import std.string : format;

	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.fid;
}

// file identificator (afid) 
class Afid : Fid
{
	this(uint fid = 0xFFFFFFFF)
	{
		super(fid);
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Afid(afid=%d)`,
			_fid
		);
	}
	
	alias pack this;
}
