// Written in the D programming language.

/**
A type for representing the afid object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/

module styx2000.protobj.afid;

private {
	import std.string : format;

	import styx2000.protobj.styxobject;
	
	import styx2000.protoconst.base : STYX_NOFID;
	
	import styx2000.protobj.fid;
}

/**
	A class that provides a type for the afid field in some Styx messages. Inherits methods from the Fid class and the styxObject class. 
*/
class Afid : Fid
{
	/**
	A constructor that creates an object of the Afid class with the given parameter in the form of some integer value representing fid. 
	If called without parameters, then the default parameter is the STYX_NOFID value from styx2000.protoconst.base. 
    Params:
    fid = Unique 32-bit value assigned by the Styx client.
    Typical usage:
    ----
    Afid afid = new Afid(0);
    ----
    */
	this(uint fid = STYX_NOFID)
	{
		super(fid);
	}
	
	/// An alias that allows you to call a getter method without accessing the base Fid class
	alias getAfid = getFid;	
	/// An alias that allows you to call a setter method without accessing the base Fid class
	alias setAfid = setFid;	
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`Afid(afid=%d)`,
			_fid
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack () method
	alias pack this;
}
