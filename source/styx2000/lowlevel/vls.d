// Written in the D programming language.

/**
The module provides tools for assembling and disassembling variable-length byte sequences that are found in different messages in the 9P / Styx protocol.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.lowlevel.vls;

private {
	import styx2000.lowlevel.endianness : fromLEBytes, toLEBytes;
}

/**
	A class that provides methods for unpacking and packing sequences of bytes into an array of unsigned bytes with an indicator of the number of elements in the sequence. 
	The number of elements is written in little-endian byte order at the beginning of each variable-length sequence and is the two bytes preceding the main data. 
	The static methods of this class allow packing and unpacking 9P / Styx protocol sequences (hereinafter we will denote such sequences as `VLS` - `Variable Length Sequences`).
*/
class VariableLengthSequence
{
	/**
	Encode byte sequence as VLS
    Params:
    bytes = Array of unsigned bytes for constructing VLS.
    
    Typical usage:
    ----
    // return array [3, 0, 0, 1, 2]
    auto vls = VariableLengthSequence.pack([0x00, 0x01, 0x02]);
    ----
    */
	static ubyte[] pack(ubyte[] bytes...)
	{
		ubyte[] rawBytes;
		
		auto fieldSize = cast(ushort) bytes.length;
		rawBytes ~= toLEBytes!ushort(fieldSize);
		rawBytes ~= bytes;
		
		return rawBytes;
	}
	
	/**
	Decode byte sequence from VLS
    Params:
    bytes = Array of unsigned bytes for constructing VLS.
    Throws:
    Exception on empty bytes array.
    
    Typical usage:
    ----
    // return array [0, 1, 2]
    auto vls = VariableLengthSequence.unpack([3, 0, 0, 1, 2]);
    ----
    */
	static ubyte[] unpack(ubyte[] bytes...)
	{
		ubyte[] rawBytes;
		
		if (bytes.length == 0)
		{
			throw new Exception(`Wrong size of Variable Length Sequence (VLS)`);
		}
		else
		{
			auto fieldSize = fromLEBytes!ushort(bytes[0..2]);
			rawBytes = bytes[2..2+fieldSize];
		}
		
		return rawBytes;
	}
}
