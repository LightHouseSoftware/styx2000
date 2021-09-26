// Written in the D programming language.

/**
A type for representing the uname object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.uname;

private {
	import std.string : format;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.name;
}

/**
	A class that provides a type for the uname field in some Styx messages. Inherits methods from the Name class and the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Uname : Name
{
	/**
	A constructor that creates an object of the Uname class with the given parameter in the form of some string value representing uname. 
	If called without parameters, then the default parameter is empty string value. 
    Params:
    name = String value for user name.
    
    Typical usage:
    ----
    Uname uname = new Uname(`user`);
    ----
    */
	this(string name = "")
	{
		super(name);
	}
	
	/// An alias that allows you to call a getter method without accessing the base Name class
	alias getUname = getName;	
	/// An alias that allows you to call a setter method without accessing the base Name class
	alias setUname = setName;	
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`Uname(uname=%s)`, 
			_name == "" ? `""` : _name
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
