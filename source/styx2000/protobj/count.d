// Written in the D programming language.

/**
A type for representing the count object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.count;

private {
	import std.string : format;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.size;
}

/**
	A class that provides a type for the count field in some Styx messages. Inherits methods from the Size class and the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Count : Size
{
	/**
	A constructor that creates an object of the Count class with the given parameter in the form of some integer value representing number of bytes. 
	If called without parameters, then the default parameter is zero.
	Params:
    count = Count of bytes.
    
	Typical usage:
    ----
    Count count = new Count(0);
    ----
    */
	this(uint size = 0)
	{
		super(size);
	}
	
	/// An alias that allows you to call a getter method without accessing the base Size class
	alias getCount = getSize;
	/// An alias that allows you to call a setter method without accessing the base Size class
	alias setCount = setSize;
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(`Count(size=%d)`, _size);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
