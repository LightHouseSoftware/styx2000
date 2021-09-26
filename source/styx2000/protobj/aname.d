// Written in the D programming language.

/**
A type for representing the aname object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.aname;

private {
	import std.string : format;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.name;
}

/**
	A class that provides a type for the aname field in some Styx messages. Inherits methods from the Name class and the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Aname : Name
{
	/**
	A constructor that creates an object of the Aname class with the given parameter in the form of some string value representing aname. 
	If called without parameters, then the default parameter is empty string value. 
    Params:
    name = String value for selected file tree on server.
    Typical usage:
    ----
    Aname aname = new Aname(`test`);
    ----
    */
	this(string name = "")
	{
		super(name);
	}
	
	/// An alias that allows you to call a getter method without accessing the base Name class
	alias getAname = getName;
	/// An alias that allows you to call a setter method without accessing the base Name class	
	alias setAname = setName;	
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`Aname(aname=%s)`, 
			_name == "" ? `""` : _name
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
