// Written in the D programming language.

/**
A type for representing the qid object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.qid;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protoconst.qids;
}

/**
	A class that provides a type for the qid field in some Styx messages. Inherits methods from the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
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
	
	/**
	A constructor that creates a unique qid number based on the parameters passed to it. 
	If it is called without parameters, then the type will be STYX_QID_TYPE.QTFILE and zero values for the remaining parameters. 
    Params:
	type = Type of qid.
    vers = Unique 32-bit version number for file or directory.
    path = Unique 64-bit path number for file or directory.
    
    Typical usage:
    ----
    Qid qid = new Qid(STYX_QID_TYPE.QTFILE, 0, 12345678);
    ----
    */
	this(STYX_QID_TYPE type = STYX_QID_TYPE.QTFILE, uint vers = 0, ulong path = 0)
	{
		_type = type;
		_vers = vers;
		_path = path;
		_representation ~= toLEBytes!ubyte(type);
		_representation ~= toLEBytes!uint(vers);
		_representation ~= toLEBytes!ulong(path);
	}
	
	/// Get Qid type from Qid object
	STYX_QID_TYPE getType()
	{
		return _type;
	}
	
	/// Get version from Qid object
	uint getVers()
	{
		return _vers;
	}
	
	/// Get path from Qid object
	ulong getPath()
	{
		return _path;
	}
	
	/// Set type from STYX_QID_TYPE value
	void setType(STYX_QID_TYPE type)
	{
		_type = type;
		_representation[0] = cast(ubyte) type;
	}
	
	/// Set version from unsigned value
	void setVers(uint vers)
	{
		_vers = vers;
		_representation[1..5] = toLEBytes!uint(vers);
	}
	
	/// Set path from unsigned value
	void setPath(ulong path)
	{
		_path = path;
		_representation[5..13] = toLEBytes!ulong(path);
	}
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..13];
		_type = cast(STYX_QID_TYPE) fromLEBytes!ubyte(bytes[0]);
		_vers = fromLEBytes!uint(bytes[1..5]);
		_path = fromLEBytes!ulong(bytes[5..13]);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`Qid(type=%s, vers=%d, path=%d)`,
			_type.to!string,
			_vers,
			_path
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
