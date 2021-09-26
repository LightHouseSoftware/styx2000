// Written in the D programming language.

/**
A type for representing the perm object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.perm;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protoconst.permissions;
}

/**
	A class that provides a type for the perm field in some Styx messages. Inherits methods from StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Perm : StyxObject
{
	protected {
		uint _perm;
		
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Perm class with the given parameter in the form of unsigned value. 
	If called without parameters, then the default parameter is zero.
	Params:
    perm = Permissions as unsigned value.
    
    Typical usage:
    ----
    Perm perm = new Perm(0x0000);
    ----
    */
	this(uint perm = 0)
	{
		_perm = perm;
		_representation = toLEBytes!uint(perm);
	}
	
	/// Get value from Perm object as unsigned value
	uint getPerm()
	{
		return _perm;
	}
	
	/// Set Perm object from unsigned value
	void setPerm(uint perm)
	{
		_perm = perm;
		_representation = toLEBytes!uint(perm);
	}
	
	/// Set Perm object from STYX_FILE_PERMISSION list
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
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..4];
		_perm = fromLEBytes!uint(bytes[0..4]);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(`Permissions(perm=0x%0.8x)`, _perm);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
