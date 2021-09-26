// Written in the D programming language.

/**
A type for representing the offset object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.offset;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

/**
	A class that provides a type for the offset field in some Styx messages. Inherits methods from StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Offset : StyxObject
{
	protected {
		ulong _offset;
		
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Offset class with the given parameter in the form of unsigned value. 
	If called without parameters, then the default parameter is zero.
	Params:
    size = Number of unsigned bytes.
    
    Typical usage:
    ----
    Offset offset = new Offset(1);
    ----
    */
	this(ulong offset = 0)
	{
		_offset = offset;
		_representation = toLEBytes!ulong(offset);
	}
	
	/// Get offset from Offset object
	ulong getOffset()
	{
		return _offset;
	}
	
	/// Set offset from unsigned value
	void setOffset(ulong offset)
	{
		_offset = offset;
		_representation = toLEBytes!ulong(offset);
	}
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..8];
		_offset = fromLEBytes!ulong(bytes[0..8]);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(`Offset(offset=%d)`, _offset);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
