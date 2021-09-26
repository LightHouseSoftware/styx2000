// Written in the D programming language.

/**
A type for representing the aqid object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.aqid;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.qid;
}

public {
	import styx2000.protoconst.qids;
}

/**
	A class that provides a type for the aqid field in some Styx messages. Inherits methods from the Qid class and the StyxObject class. 
	See_Also:
		https://web.archive.org/web/20201029184954/https://powerman.name/Inferno/man/5/0intro.html
*/
class Aqid : Qid
{
	/**
	A constructor that creates a unique qid number based on the parameters passed to it. 
	If it is called without parameters, then the type will be STYX_QID_TYPE.QTFILE and zero values for the remaining parameters. 
    Params:
	type = Type of qid,
    vers = Unique 32-bit version number for file or directory,
    path = Unique 64-bit path number for file or directory.
    Typical usage:
    ----
    Aqid aname = new Aname(STYX_QID_TYPE.QTFILE, 0, 12345678);
    ----
    */
	this(STYX_QID_TYPE type = STYX_QID_TYPE.QTFILE, uint vers = 0, ulong path = 0)
	{
		super(type, vers, path);
	}
	
	/// Convenient string representation of an object for printing 
	override string toString()
	{
		return format(
			`Aqid(type=%s, vers=%d, path=%d)`,
			_type.to!string,
			_vers,
			_path
		);
	}
	
	/// An alias for easier packing into a byte array without having to manually call the pack() method
	alias pack this;
}
