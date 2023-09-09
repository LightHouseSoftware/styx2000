// Written in the D programming language.

/**
Module for manipulating bytes in constructing and deconstructing various byte orders. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.lowlevel.endianness;

/// Endianess (i.e byte-order)
enum BYTE_ORDER
{
	/// Little-endian byte-order
	LITTLE_ENDIAN,
	/// Big-endian byte-order
	BIG_ENDIAN
}


/**
	A class that provides functionality for construct and deconstruct values. All methods is static.
*/
class EndianSequence(BYTE_ORDER byteOrder)
{	
	/**
	Constructs (restores) a value from the passed in byte array.
    Params:
	byteOrder = Byte order for value (little or big endian).
    bytes = Array of unsigned bytes for reconstructing value.
    
    Typical usage:
    ----
    uint tmp = EndianSequence!(BYTE_ORDER.LITTLE_ENDIAN).unpack!uint([0xab, 0xcd, 0xef, 0x00]);
    ----
    */
    private {
		import std.traits : isBasicType;
		
		static auto shiftOf(T)(T i) if (isBasicType!T)
		{
			static if (byteOrder == BYTE_ORDER.LITTLE_ENDIAN)
	            return i << 3;
	        else
	            return (T.sizeof - i - 1) << 3;
		}
	}
    
	static T unpack(T)(ubyte[] bytes...)
    {
        T result;
       
        foreach (i, e; bytes)
        {
            result |= (e << shiftOf(i));
        }

        return result;
    }

	/**
	Deconstructs (saves) a passed value to unsigned byte array.
    Params:
	byteOrder = Byte order for value (little or big endian).
    value = Value for deconstructing.
    
    Typical usage:
    ----
    ubyte[] tmp = EndianSequence!(BYTE_ORDER.LITTLE_ENDIAN).pack!uint(150_000);
    ----
    */
    static ubyte[] pack(T)(T value)
    {
        ubyte[] data;
        T mask = T(0xff);

        foreach (i; 0 .. T.sizeof)
        {
			auto shift = shiftOf(i);
            data ~= cast(ubyte) ((value & (mask << shift)) >> shift);
        }

        return data;
    }
}


/**
Parse a value into bytes in little-endian order. Helper for EndianSequence.pack with preset Little Endian byte order (LE).
Params:
value = Value for parsing.
Returns: An array of unsigned bytes representing the value passed as a parameter in little-endian order


Typical usage:
----
ubyte[] tmp = toLEBytes!uint(150_000);
----
*/
alias toLEBytes = EndianSequence!(BYTE_ORDER.LITTLE_ENDIAN).pack;

/**
Construct a value from bytes fed in little-endian order. Helper for EndianSequence.unpack with preset Little Endian byte order (LE).
Params:
bytes = An array of unsigned bytes (little-endian-order).
Returns: The value retrieved from the array


Typical usage:
----
// value is 0x00efcdab in hex or 15715755 in dec  
uint tmp = fromLEBytes!uint([0xab, 0xcd, 0xef, 0x00]);
----
*/
alias fromLEBytes = EndianSequence!(BYTE_ORDER.LITTLE_ENDIAN).unpack;

/**
Parse a value into bytes in big-endian order. Helper for EndianSequence.pack with preset Big Endian byte order (BE).
Params:
value = Value for parsing.
Returns: An array of unsigned bytes representing the value passed as a parameter in little-endian order


Typical usage:
----
ubyte[] tmp = toBEBytes!uint(150_000);
----
*/
alias toBEBytes = EndianSequence!(BYTE_ORDER.BIG_ENDIAN).pack;

/**
Construct a value from bytes fed in big-endian order. Helper for EndianSequence.unpack with preset Big Endian byte order (BE).
Params:
bytes = An array of unsigned bytes (big-endian-order).
Returns: The value retrieved from the array


Typical usage:
----
// value is 0xabcdef00 in hex or 2882400000 in dec
uint tmp = fromBEBytes!uint([0xab, 0xcd, 0xef, 0x00]);
----
*/
alias fromBEBytes = EndianSequence!(BYTE_ORDER.BIG_ENDIAN).unpack;
