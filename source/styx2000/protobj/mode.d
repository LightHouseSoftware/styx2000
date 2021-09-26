// Written in the D programming language.

/**
A type for representing the mode object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.mode;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protoconst.modes;
}

/**
	A class that provides a type for the mode field in some Styx messages. Inherits methods from StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Mode : StyxObject
{
	protected {
		STYX_FILE_MODE _mode;
		ubyte[] _representation;
	}
	
	/**
	A constructor that creates an object of the Mode class with the given parameter in the form of STYX_FILE_MODE type. 
	If called without parameters, then the default parameter is STYX_FILE_MODE.OREAD. 
    Params:
    mode = File mode.
    
    Typical usage:
    ----
    Mode mode = new Mode(STYX_FILE_MODE.OWRITE);
    ----
    */
	this(STYX_FILE_MODE mode = STYX_FILE_MODE.OREAD)
	{
		_mode = mode;
		_representation = [cast(ubyte) mode];
	}
	
	/// Get mode from Mode object
	STYX_FILE_MODE getMode()
	{
		return _mode;
	}
	
	/// Set mode from STYX_FILE_MODE value
	void setMode(STYX_FILE_MODE mode)
	{
		_mode = mode;
		_representation = [cast(ubyte) mode];
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
		_mode = cast(STYX_FILE_MODE) bytes[0];
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`Mode(mode=%s)`,
			_mode.to!string
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
