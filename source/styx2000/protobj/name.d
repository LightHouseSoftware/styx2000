// Written in the D programming language.

/**
A type for representing the name object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.name;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	
	import styx2000.protobj.styxobject;
}

/**
	A class that provides a type for the name field in some Styx messages. Inherits methods from the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Name : StyxObject
{
	protected {
		string _name;
		
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Name class with the given parameter in the form of some string value representing names. 
	If called without parameters, then the default parameter is empty string value. 
    Params:
    name = String value for name.
    
    Typical usage:
    ----
    Name name = new Name(`test`);
    ----
    */
	this(string name = "")
	{
		_name = name;
		_representation = VariableLengthSequence.pack(cast(ubyte[]) name);
	}
	
	/// Get name from Name object
	string getName()
	{
		return _name;
	}
	
	/// Set mode from string object
	void setName(string name)
	{
		_name = name;
		_representation = VariableLengthSequence.pack(cast(ubyte[]) name);
	}
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_name = cast(string) (VariableLengthSequence.unpack(bytes));
		_representation = VariableLengthSequence.pack(cast(ubyte[]) _name);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`Name(name="%s")`, 
			_name == "" ? `` : _name
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
