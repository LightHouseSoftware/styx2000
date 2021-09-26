// Written in the D programming language.

/**
A type for representing the nwqid object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.nwqid;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protobj.qid;
}

/**
	A class that provides a type for the Nwqid field in some Styx messages. Inherits methods from the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Nwqid : StyxObject
{
	protected {
		Qid[] _nwqid;
		
		ubyte[] _representation;
	}
	
	private {
		// update qids list
		void updateQids()
		{
			if (_nwqid.length == 0)
			{
				_representation = [0, 0];
			}
			else
			{
				_representation = toLEBytes!ushort(
					cast(ushort) _nwqid.length
				);
				foreach (e; _nwqid)
				{
					_representation ~= e.pack;
				}
			}
		}
	}
	
	/**
	A constructor that creates an object of the Nwqid class with the given parameter in the form of qid's array. 
	If called without parameters, then the default parameter is empty qid's array. 
    Params:
    nwname = Full file path as qid's array.
    
    Typical usage:
    ----
    Nwqid nwqid = new Nwqid([new Qid, new Qid]);
    ----
    */
	this(Qid[] nwqid = [])
	{
		_nwqid = nwqid;
		_representation = [];
		updateQids;
	}
	
	/// Get all qids in path as qid's array
	Qid[] getQid()
	{
		return _nwqid;
	}
	
	/// Number of qids
	ushort countOfQids()
	{
		return fromLEBytes!ushort(_representation[0..2]);
	}
	
	/// Set all qids in path as qid's array
	void setQid(Qid[] nwqid...)
	{
		_nwqid = nwqid;
		_representation = [];
		updateQids;
	}
	
	/// Pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	/// Unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes;
		_nwqid = [];
		ushort length = fromLEBytes!ushort(bytes[0..2]);
		auto vlsPosition = 2;
		
		foreach (_; 0..length)
		{
			Qid qid = new Qid;
			qid.unpack(bytes[vlsPosition..$]);
			_nwqid ~= qid;
			vlsPosition += 13;
		}
	}
	
	/// Convenient string representation of an object for printing
	override string toString()
	{
		return format(
			`Nwqid(nwqid=%d, wqid=%s)`,
			fromLEBytes!ushort(_representation[0..2]),
			_nwqid.to!string
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
