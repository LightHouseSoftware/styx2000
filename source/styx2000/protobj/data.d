// Written in the D programming language.

/**
A type for representing the data object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.data;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.protobj.styxobject;
}

/**
	A class that provides a type for the data field in some Styx messages. Inherits methods from StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Data : StyxObject
{
	protected {		
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Data class with the given parameter in the form of byte array. 
	If called without parameters, then the default parameter is empty unsigned byte array. 
    Params:
    data = Array of unsigned bytes.
    
    Typical usage:
    ----
    Data data = new Data(0);
    ----
    */
	this(ubyte[] data = [])
	{
		_representation = data;
	}
	
	/// Get value from Data object
	ubyte[] getData()
	{
		return _representation;
	}
	
	/// Set value for Data from bytes array
	void setData(ubyte[] data...)
	{
		_representation = data;
	}
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return this.getData;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		this.setData(bytes);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(`Data(bytes=%s)`, _representation.to!string);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
