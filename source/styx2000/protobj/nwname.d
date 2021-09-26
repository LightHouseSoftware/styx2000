// Written in the D programming language.

/**
A type for representing the name object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.nwname;

private {
	import std.conv : to;
	import std.path : buildPath;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	
	import styx2000.protobj.styxobject;
}

/**
	A class that provides a type for the Nwname field in some Styx messages. Inherits methods from the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Nwname : StyxObject
{
	protected {
		string[] _nwname;
		
		ubyte[] _representation;
	}
	
	private {
		// update names list
		void updateNames()
		{
			if (_nwname.length == 0)
			{
				// ????
				// if empty walk then nwname = 1, wname = [0, 0] (in inferno)
				// in plan9 is [0, 0]
				_representation = [0, 0];
			}
			else
			{
				_representation = toLEBytes!ushort(
					cast(ushort) _nwname.length
				);
				foreach (e; _nwname)
				{
					_representation ~= VariableLengthSequence.pack(cast(ubyte[]) e);
				}
			}
		}
	}
	
	/**
	A constructor that creates an object of the Nwname class with the given parameter in the form of string's array. 
	If called without parameters, then the default parameter is empty string's array. 
    Params:
    nwname = Full file path as string's array.
    
    Typical usage:
    ----
    Nwname aname = new Nwname([`test`]);
    ----
    */
	this(string[] nwname = [])
	{
		_nwname = nwname;
		_representation = [];
		updateNames;
	}
	
	/// Set name to Nwname objects as string's array
	void setName(string[] nwname...)
	{
		_nwname = nwname;
		_representation = [];
		updateNames;
	}
	
	/// Number of names in path
	ushort countOfNames()
	{
		return fromLEBytes!ushort(_representation[0..2]);
	}

	/// Get all names in path as string's array
	string[] getName()
	{
		return _nwname;
	}
	
	/// An alias that allows you to call a getter method without accessing the base Name class
	alias getNwname = getName;	
	/// An alias that allows you to call a setter method without accessing the base Name class
	alias setNwname = setName;	
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes;
		_nwname = [];
		ushort length = fromLEBytes!ushort(bytes[0..2]);
		auto vlsPosition = 2;
		
		foreach (_; 0..length)
		{
			string n = cast(string) VariableLengthSequence.unpack(
				bytes[vlsPosition..$]
			);
			_nwname ~= n;
			vlsPosition += n.length + 2;
		}
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`Nwname(nwname=%d, wmname="%s")`,
			fromLEBytes!ushort(_representation[0..2]),
			buildPath(_nwname)
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
