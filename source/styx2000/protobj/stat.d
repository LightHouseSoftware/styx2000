module styx2000.protobj.stat;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protobj.perm;
	import styx2000.protobj.qid;
}

class Stat : StyxObject
{
	protected {
		ushort  _type;
		uint    _dev;
		Qid     _qid;
		Perm    _mode;
		uint    _atime;
		uint    _mtime;
		ulong   _length;
		string  _name;
		string  _uid;
		string  _gid;
		string  _muid;
		
		ubyte[] _representation;
	}
	
	private {
		// update internal byte representation: assume name, uid, gid and muid is setted correctly
		void updateVLSFields()
		{
			// position of first VLS
			auto vlsPosition = 43;
			// 4 is position of field named "type"
			ubyte[] _internals = _representation[4..vlsPosition];
			
			_internals ~= VariableLengthSequence.pack(cast(ubyte[]) _name);
			_internals ~= VariableLengthSequence.pack(cast(ubyte[]) _uid);
			_internals ~= VariableLengthSequence.pack(cast(ubyte[]) _gid);
			_internals ~= VariableLengthSequence.pack(cast(ubyte[]) _muid);
			
			_representation = VariableLengthSequence.pack(
				VariableLengthSequence.pack(_internals)
			);
		}
	}
	
	this(
		ushort  type    = 0,
		uint    dev     = 0,
		Qid     qid     = new Qid,
		Perm    mode    = new Perm,
		uint    atime   = 0,
		uint    mtime   = 0,
		ulong   length  = 0,
		string  name    = "",
		string  uid     = "",
		string  gid     = "",
		string  muid    = ""
	)
	{
		_type 	= type;
		_dev  	= dev;
		_qid  	= qid;
		_mode 	= mode;
		_atime  = atime;
		_mtime  = mtime;
		_length = length;
		_name   = name;
		_uid	= uid;
		_gid	= gid;
		_muid   = muid;
		
		ubyte[] _internals;
		// type
		_internals ~= toLEBytes!ushort(type);
		// dev
		_internals ~= toLEBytes!uint(dev);
		// qid
		_internals ~= qid.pack;
		// mode
		_internals ~= mode.pack;
		// atime
		_internals ~= toLEBytes!uint(atime);
		// mtime
		_internals ~= toLEBytes!uint(mtime);
		// length
		_internals ~= toLEBytes!ulong(length);
		// name
		_internals ~= VariableLengthSequence.pack(cast(ubyte[]) name);
		// uid
		_internals ~= VariableLengthSequence.pack(cast(ubyte[]) uid);
		// gid
		_internals ~= VariableLengthSequence.pack(cast(ubyte[]) gid);
		// muid
		_internals ~= VariableLengthSequence.pack(cast(ubyte[]) muid);
		
		// build internal representation
		_representation = VariableLengthSequence.pack(
			VariableLengthSequence.pack(_internals)
		);
	}
	
	// setters
	void setType(ushort type)
	{
		_type = type;
		_representation[4..6] = toLEBytes!ushort(type);
	}
	
	void setDev(uint dev)
	{
		_dev = dev;
		_representation[6..10] = toLEBytes!uint(dev);
	}
	
	void setQid(Qid qid)
	{
		_qid = qid;
		_representation[10..23] = qid.pack;
	}
	
	void setMode(Perm mode)
	{
		_mode = mode;
		_representation[23..27] = mode.pack;
	}
	
	void setAtime(uint atime)
	{
		_atime = atime;
		_representation[27..31] = toLEBytes!uint(atime);
	}
	
	void setMtime(uint mtime)
	{
		_mtime = mtime;
		_representation[31..35] = toLEBytes!uint(mtime);
	}
	
	void setLength(ulong length)
	{
		_length = length;
		_representation[35..43] = toLEBytes!ulong(length);
	}
	
	void setName(string name)
	{
		_name = name;
		updateVLSFields;
	}
	
	void setUid(string uid)
	{
		_uid = uid;
		updateVLSFields;
	}
	
	void setGid(string gid)
	{
		_gid = gid;
		updateVLSFields;
	}
	
	void setMuid(string muid)
	{
		_muid = muid;
		updateVLSFields;
	}
	
	// getters
	ushort getType()
	{
		return _type;
	}
	
	uint getDev()
	{
		return _dev;
	}
	
	Qid getQid()
	{
		return _qid;
	}
	
	Perm getMode()
	{
		return _mode;
	}
	
	uint getAtime()
	{
		return _atime;
	}
	
	uint getMtime()
	{
		return _mtime;
	}
	
	ulong getLength()
	{
		return _length;
	}
	
	string getName()
	{
		return _name;
	}
	
	string getUid()
	{
		return _uid;
	}
	
	string getGid()
	{
		return _gid;
	}
	
	string getMuid()
	{
		return _muid;
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes;
		// unpack all
		ubyte[] _content = VariableLengthSequence.unpack(VariableLengthSequence.unpack(bytes));
		_type = fromLEBytes!ushort(_content[0..2]);
		_dev = fromLEBytes!uint(_content[2..6]);
		_qid = new Qid;
		_qid.unpack(_content[6..19]);
		_mode = new Perm;
		_mode.unpack(_content[19..23]);
		_atime = fromLEBytes!uint(_content[23..27]);
		_mtime = fromLEBytes!uint(_content[27..31]);
		_length = fromLEBytes!uint(_content[31..39]);
		_name = cast(string) VariableLengthSequence.unpack(_content[39..$]);
		// position for Variable Length Sequences (aka VLS) (name, uid, gid, muid)
		// 39 - beginning of first VLS, _name.length - size of first VLS, 2 - two bytes is marker of VLS size
		size_t vlsPosition = 39 + _name.length + 2;
		_uid = cast(string) VariableLengthSequence.unpack(_content[vlsPosition..$]);
		// next VLS started on position vlsPosition + size of previous VLS + 2 bytes (size of VLS size marker)
		vlsPosition += _uid.length + 2;
		_gid = cast(string) VariableLengthSequence.unpack(_content[vlsPosition..$]);
		vlsPosition += _gid.length + 2;
		_muid = cast(string) VariableLengthSequence.unpack(_content[vlsPosition..$]);
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Stat(type=%s, dev=%s, qid=%s, mode=%s, atime=%d, mtime=%d, length=%s, name="%s", uid="%s", gid="%s", muid="%s")`,
			_type.to!string,
			_dev.to!string,
			_qid.to!string,
			_mode.to!string,
			_atime,
			_mtime,
			_length,
			(_name == "") ? `` : _name,
			(_uid  == "") ? `` : _uid,
			(_gid  == "") ? `` : _gid,
			(_muid == "") ? `` : _muid
		);
	}
	
	alias pack this;
}
