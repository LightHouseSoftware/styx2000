// Written in the D programming language.

/**
A type for representing the tag object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.tag;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protoconst.base : STYX_NOTAG;
	
	import styx2000.protobj.styxobject;
}

/**
	A class that provides a type for the tag field in some Styx messages. Inherits methods from the Fid class and the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Tag : StyxObject
{
	protected {
		ushort _tag;
		
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Afid class with the given parameter in the form of some integer value representing fid. 
	If called without parameters, then the default parameter is the STYX_NOTAG value from styx2000.protoconst.base. 
    Params:
    tag = Unique 16-bit value for tagging messages.
    
    Typical usage:
    ----
    Tag tag = new Tag(10);
    ----
    */
	this(ushort tag = STYX_NOTAG)
	{
		_tag = tag;
		_representation = toLEBytes!ushort(tag);
	}
	
	/// Get as unsigned value
	ushort getTag()
	{
		return _tag;
	}
	
	/// Set Tag from unsigned value
	void setTag(ushort tag)
	{
		_tag = tag;
		_representation = toLEBytes!ushort(tag);
	}
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes[0..2];
		_tag = fromLEBytes!ushort(bytes[0..2]);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(`Tag(tag=0x%0.4x)`, _tag);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
