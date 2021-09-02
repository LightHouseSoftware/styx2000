module styx2000.protobj.aqid;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.qid;
}

public {
	import styx2000.protoconst.qids;
}

// aqid identificator (unique number on server)
class Aqid : Qid
{
	this(STYX_QID_TYPE type = STYX_QID_TYPE.QTFILE, uint vers = 0, ulong path = 0)
	{
		super(type, vers, path);
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Aqid(type=%s, vers=%d, path=%d)`,
			_type.to!string,
			_vers,
			_path
		);
	}
	
	alias pack this;
}
