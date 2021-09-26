// Written in the D programming language.

/**
A type for representing the stat object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
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


/**
	A class that provides a type for the stat field in some Styx messages. Inherits methods from the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
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
	
	/**
	A constructor that creates an object of the Stat class with the given parameters. 
	If called without parameters, then the default parameter for type, dev, atime, mtime, length is zero;
	default value for Perm and Qid parameter is standard initialized values for their (see Perm and Qid
	classes); the default parameter for name, uid, gid and muid is empty string.
	Params:
    type = Major server version.
    dev = Minor server version.
    qid = Unique server id for filesystem object.
    perm = Permission.
    atime = Last acess time (in Unix epoch format).
    mtime = Last modification time (in Unix epoch format).
    length = Filesystem object size (in bytes).
    name = Filesystem object name.
    uid = Owner name.
    gid = Group of owner name.
    muid = Name of user, who modified file.
    
    Typical usage:
    ----
    // chmod 775 (drwxrwxr-x)
		Perm perm = new Perm;
		perm.setPerm(
			STYX_FILE_PERMISSION.DMDIR | STYX_FILE_PERMISSION.OWNER_EXEC | STYX_FILE_PERMISSION.OWNER_READ | STYX_FILE_PERMISSION.OWNER_WRITE |
			STYX_FILE_PERMISSION.GROUP_READ | STYX_FILE_PERMISSION.GROUP_WRITE | STYX_FILE_PERMISSION.GROUP_EXEC | 
			STYX_FILE_PERMISSION.OTHER_READ | STYX_FILE_PERMISSION.OTHER_EXEC 
		);
			
		Stat stat = new Stat(
			// type and dev for kernel use (taken from some experiments with styxdecoder, see above)
			77, 4,
			new Qid,
			// permissions
			perm,
			// access time
			123456789,
			// modification time
			123456,
			// conventional length for all directories is 0
			0,
			// file name (this, directory name)
			"test",
			// user name (owner of file)
			"user",
			// user group name
			"users",
			// others group name
			""
		);
    ----
    */
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
	
	/// Set type from unsigned value 
	void setType(ushort type)
	{
		_type = type;
		_representation[4..6] = toLEBytes!ushort(type);
	}
	
	/// Set device from unsigned value 
	void setDev(uint dev)
	{
		_dev = dev;
		_representation[6..10] = toLEBytes!uint(dev);
	}
	
	/// Set Qid from Qid type 
	void setQid(Qid qid)
	{
		_qid = qid;
		_representation[10..23] = qid.pack;
	}
	
	/// Set mode from Perm type
	void setMode(Perm mode)
	{
		_mode = mode;
		_representation[23..27] = mode.pack;
	}
	
	/// Set access time from unsigned value 
	void setAtime(uint atime)
	{
		_atime = atime;
		_representation[27..31] = toLEBytes!uint(atime);
	}
	
	/// Set modification time from unsigned value 
	void setMtime(uint mtime)
	{
		_mtime = mtime;
		_representation[31..35] = toLEBytes!uint(mtime);
	}
	
	/// Set size (in bytes) from unsigned value 
	void setLength(ulong length)
	{
		_length = length;
		_representation[35..43] = toLEBytes!ulong(length);
	}
	
	/// Set name from string
	void setName(string name)
	{
		_name = name;
		updateVLSFields;
	}
	
	/// Set user name from string 
	void setUid(string uid)
	{
		_uid = uid;
		updateVLSFields;
	}
	
	/// Set user group name from string
	void setGid(string gid)
	{
		_gid = gid;
		updateVLSFields;
	}
	
	/// Set modificator's name from string
	void setMuid(string muid)
	{
		_muid = muid;
		updateVLSFields;
	}
	
	/// Get type from Stat object
	ushort getType()
	{
		return _type;
	}
	
	/// Get device from Stat object
	uint getDev()
	{
		return _dev;
	}
	
	/// Get Qid from Stat object
	Qid getQid()
	{
		return _qid;
	}
	
	/// Get mode from Stat object
	Perm getMode()
	{
		return _mode;
	}
	
	/// Get access time from Stat object
	uint getAtime()
	{
		return _atime;
	}
	
	/// Get modification time from Stat object
	uint getMtime()
	{
		return _mtime;
	}
	
	/// Get size from Stat object
	ulong getLength()
	{
		return _length;
	}
	
	/// Get name from Stat object
	string getName()
	{
		return _name;
	}
	
	/// Get user name from Stat object
	string getUid()
	{
		return _uid;
	}
	
	/// Get user group name from Stat object
	string getGid()
	{
		return _gid;
	}
	
	/// Get modificator's name from Stat object
	string getMuid()
	{
		return _muid;
	}
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
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
	
	/// Convenient string representation of an object for printing
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
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
