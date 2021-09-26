// Written in the D programming language.

/**
A type for representing the fid object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.fid;

private {
	import std.string : format;

	import styx2000.lowlevel.endianness;
	
	import styx2000.protoconst.base : STYX_NOFID;
	
	import styx2000.protobj.styxobject;
}

/**
	A class that provides a type for the fid field in some Styx messages. Inherits methods from the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Fid : StyxObject
{
	protected {
		uint _fid;
		
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Fid class with the given parameter in the form of some integer value representing fid. 
	If called without parameters, then the default parameter is the STYX_NOFID value from styx2000.protoconst.base. 
    Params:
    fid = Unique 32-bit value assigned by the Styx client.
    
    Typical usage:
    ----
    Fid fid = new Fid(0);
    ----
    */
	this(uint fid = STYX_NOFID)
	{
		_fid = fid;
		_representation = toLEBytes!uint(fid);
	}
	
	/// Get unsigned value from Fid object
	uint getFid()
	{
		return _fid;
	}
	
	/// Set value for data from unsigned value
	void setFid(uint fid)
	{
		_fid = fid;
		_representation = toLEBytes!uint(fid);
	}
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..4];
		_fid = fromLEBytes!uint(bytes[0..4]);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`Fid(fid=%d)`,
			_fid
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
