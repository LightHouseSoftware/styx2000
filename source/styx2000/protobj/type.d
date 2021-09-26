// Written in the D programming language.

/**
A type for representing the type object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.type;

private {
	import std.conv : to;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protoconst.messages;
}

/**
	A class that provides a type for the type field in some Styx messages. Inherits methods from StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Type : StyxObject
{
	protected {
		STYX_MESSAGE_TYPE _type;
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Type class with the given parameter in the form of STYX_MESSAGE_TYPE. 
	If called without parameters, then the default parameter is STYX_MESSAGE_TYPE.R_ERROR.
	Params:
    type = type of Styx message.
    
    Typical usage:
    ----
    Type type = new Type(STYX_MESSAGE_TYPE.T_ATTACH);
    ----
    */
	this(STYX_MESSAGE_TYPE type = STYX_MESSAGE_TYPE.R_ERROR)
	{
		_type = type;
		_representation = [cast(ubyte) type];
	}
	
	/// Get as STYX_MESSAGE_TYPE value
	STYX_MESSAGE_TYPE getType()
	{
		return _type;
	}
	
	/// Set from STYX_MESSAGE_TYPE value
	void setType(STYX_MESSAGE_TYPE type)
	{
		_type = type;
		_representation = [cast(ubyte) type];
	}
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = [bytes[0]];
		_type = cast(STYX_MESSAGE_TYPE) bytes[0];
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return _type.to!string;
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
