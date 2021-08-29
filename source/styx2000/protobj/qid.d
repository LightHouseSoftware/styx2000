module styx2000.protobj.qid;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protoconst.qidtypes;
}

// qid identificator (unique number on server)
class Qid : StyxObject
{
	protected {
		// file type
		STYX_QID_TYPE _type;
		// version of file
		uint _vers;
		// unique path
		ulong _path;
		
		ubyte[] _representation;
	}
	
	// create from value
	this(STYX_QID_TYPE type = STYX_QID_TYPE.QTFILE, uint vers = 0, ulong path = 0)
	{
		_type = type;
		_vers = vers;
		_path = path;
		_representation ~= toLEBytes!ubyte(type);
		_representation ~= toLEBytes!uint(vers);
		_representation ~= toLEBytes!ulong(path);
	}
	
	// getter
	STYX_QID_TYPE getType()
	{
		return _type;
	}
	
	uint getVers()
	{
		return _vers;
	}
	
	ulong getPath()
	{
		return _path;
	}
	
	// setter
	void setType(STYX_QID_TYPE type)
	{
		_type = type;
		_representation[0] = cast(ubyte) type;
	}
	
	void setVers(uint vers)
	{
		_vers = vers;
		_representation[1..5] = toLEBytes!uint(vers);
	}
	
	void setPath(ulong path)
	{
		_path = path;
		_representation[5..13] = toLEBytes!ulong(path);
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..13];
		_type = cast(STYX_QID_TYPE) fromLEBytes!ubyte(bytes[0]);
		_vers = fromLEBytes!uint(bytes[1..5]);
		_path = fromLEBytes!ulong(bytes[5..13]);
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Qid(type=%s, vers=%d, path=%d)`,
			_type.to!string,
			_vers,
			_path
		);
	}
	
	alias pack this;
}
