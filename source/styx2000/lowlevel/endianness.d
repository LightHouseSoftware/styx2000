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
class EndianSequence
{	
	/**
	Constructs (restores) a value from the passed in byte array.
    Params:
	byteOrder = Byte order for value (little or big endian).
    bytes = Array of unsigned bytes for reconstructing value.
    
    Typical usage:
    ----
    uint tmp = EndianSequence.unpack!uint([0xab, 0xcd, 0xef, 0x00]);
    ----
    */
	static T unpack(T)(BYTE_ORDER byteOrder, ubyte[] bytes...)
    {
        T mask;
        size_t shift;

        foreach (i, e; bytes)
        {
            final switch (byteOrder) with (BYTE_ORDER)
            {
	            case LITTLE_ENDIAN:
	                shift = (i << 3);
	                break;
	            case BIG_ENDIAN:
	                shift = ((bytes.length - i - 1) << 3);
	                break;
            }
            mask |= (e << shift);
        }

        return mask;
    }

	/**
	Deconstructs (saves) a passed value to unsigned byte array.
    Params:
	byteOrder = Byte order for value (little or big endian).
    value = Value for deconstructing.
    
    Typical usage:
    ----
    ubyte[] tmp = EndianSequence.pack!uint(150_000);
    ----
    */
    static ubyte[] pack(T)(BYTE_ORDER byteOrder, T value)
    {
        ubyte[] data;
        T mask = cast(T) 0xff;
        size_t shift;

        foreach (i; 0 .. T.sizeof)
        {
            final switch (byteOrder) with (BYTE_ORDER)
            {
	            case LITTLE_ENDIAN:
	                shift = (i << 3);
	                break;
	            case BIG_ENDIAN:
	                shift = ((T.sizeof - i - 1) << 3);
	                break;
            }

            data ~= cast(ubyte)((value & (mask << shift)) >> shift);
        }

        return data;
    }
}


/// To little endian bytes
auto toLEBytes(T)(T value)
{
	return EndianSequence.pack!T(BYTE_ORDER.LITTLE_ENDIAN, value);
}

/// From little endian bytes
auto fromLEBytes(T)(ubyte[] bytes...)
{
	return EndianSequence.unpack!T(BYTE_ORDER.LITTLE_ENDIAN, bytes);
}

/// To big endian bytes
auto toBEBytes(T)(T value)
{
	return EndianSequence.pack!T(BYTE_ORDER.BIG_ENDIAN, value);
}

/// From big endian bytes
auto fromBEBytes(T)(ubyte[] bytes...)
{
	return EndianSequence.unpack!T(BYTE_ORDER.BIG_ENDIAN, bytes);
}
