// Written in the D programming language.

/**
A type for representing the size object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.size;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

/**
	A class that provides a type for the size field in some Styx messages. Inherits methods from StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Size : StyxObject
{
	protected {
		uint _size;
		
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Size class with the given parameter in the form of unsigned value. 
	If called without parameters, then the default parameter is zero.
	Params:
    size = Number of unsigned bytes.
    
    Typical usage:
    ----
    Size offset = new Size(17);
    ----
    */
	this(uint size = 0)
	{
		_size = size;
		_representation = toLEBytes!uint(size);
	}
	
	/// Get size from Size object
	uint getSize()
	{
		return _size;
	}
	
	/// Set size from unsigned value
	void setSize(uint size)
	{
		_size = size;
		_representation = toLEBytes!uint(size);
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
		_size = fromLEBytes!uint(bytes[0..4]);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(`Size(size=%d)`, _size);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
