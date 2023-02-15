// Written in the D programming language.

/**
Common type for representing all of the 9P / Styx protocol objects. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.styxobject;

/**
	A interface that provides a type for basic pack/unpack operations and used in encode/decode procedures. 
	Base class for all objects of 9P / Styx protocol. 
*/
interface StyxObject 
{
	/// Pack (serialize) Styx object to byte array
	ubyte[] pack();
	
	/// Unpack (deserialize) Styx object from byte array
	void unpack(ubyte[] bytes...);
}
