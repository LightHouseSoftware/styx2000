module styx2000.extrautil.dir;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.stat;
}

public {
	import styx2000.protobj.perm;
	import styx2000.protobj.qid;
}

// directory entry representation in some 9P messages
class Dir : Stat
{
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
		super(type, dev, qid, mode, atime, mtime, length, name, uid, gid, muid);
	}
		
	override ubyte[] pack()
	{
		return _representation[2..$];
	}
	
	override void unpack(ubyte[] bytes...)
	{
		auto _contents = VariableLengthSequence.pack(bytes);
		return super.unpack(_contents);
	}
	
	override string toString()
	{
		return format(
			`Dir(type=%s, dev=%s, qid=%s, mode=%s, atime=%d, mtime=%d, length=%s, name="%s", uid="%s", gid="%s", muid="%s")`,
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

// convert Stat object to Dir object
Dir fromStat(Stat stat)
{
	auto _contents = stat.pack;
	Dir dir = new Dir;
	dir.unpack(_contents[2..$]);
	return dir;
}

// convert Dir object to Stat object
Stat toStat(Dir dir)
{
	auto _contents = VariableLengthSequence.pack(dir.pack);
	Stat stat = new Stat;
	stat.unpack(_contents);
	return stat;
}
