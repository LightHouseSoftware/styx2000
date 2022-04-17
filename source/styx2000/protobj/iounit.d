// Written in the D programming language.

/**
A type for representing the iounit object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.iounit;

private {
	import std.string : format;

	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

/**
	A class that provides a type for the iounit field in some Styx messages. Inherits methods from StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Iounit : StyxObject
{
	protected {
		uint _iounit;
		
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Iounit class with the given parameter in the form of unsigned value. 
	If called without parameters, then the default parameter is zero. 
    Params:
    iounit = Maximal size for atomic I/O operations.
    
    Typical usage:
    ----
    Iounit unit = new Iounit(0);
    ----
    */
	this(uint iounit = 0)
	{
		_iounit = iounit;
		_representation = toLEBytes!uint(iounit);
	}
	
	/// Get value from Iounit object
	uint getUnit()
	{
		return _iounit;
	}
	
	/// Set value for Iounit from value
	void setUnit(uint iounit)
	{
		_iounit = iounit;
		_representation = toLEBytes!uint(iounit);
	}
	
	/// Convenient aliases for set/get
	alias getIounit = getUnit;
	alias setIounit = setUnit;
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..4];
		_iounit = fromLEBytes!uint(bytes[0..4]);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`IOunit(iounit=%d)`,
			_iounit
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
