// Written in the D programming language.

/**
A type for representing the version object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.styxversion;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	
	import styx2000.protoconst.base : STYX_VERSION;
	
	import styx2000.protobj.name;
	import styx2000.protobj.styxobject;
}

/**
	A class that provides a type for the version field in some Styx messages. Inherits methods from the Name class and the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Version : Name
{
	/**
	A constructor that creates an object of the Version class with the given parameter in the form of some string value representing protocol version. 
	If called without parameters, then the default parameter is empty string value. 
    Params:
    name = String value for protocol version.
    
    Typical usage:
    ----
    Version vers = new Version(`9P2000`);
    ----
    */
	this(string name = "")
	{
		if (name == "")
		{
			_name = STYX_VERSION;
			_representation = cast(ubyte[]) [6, 0] ~ cast(ubyte[]) STYX_VERSION;
		}
		else
		{
			_name = name;
			_representation = VariableLengthSequence.pack(cast(ubyte[]) name);
		}
	}
	
	/// An alias that allows you to call a setter method without accessing the base Name class
	alias setVersion = setName;
	/// An alias that allows you to call a getter method without accessing the base Name class
	alias getVersion = getName;
		
	/// Convenient string representation of an object for printing 	
	override string toString()
	{
		return format(
			`Version(version="%s")`, 
			_name == "" ? `""` : _name
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
