module styx2000.lowlevel.endianness;

// endianess
enum BYTE_ORDER
{
	LITTLE_ENDIAN,
	BIG_ENDIAN
}

class EndianSequence
{	
	// unpack value from bytes
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

	// pack value to bytes
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


// to little endian bytes
auto toLEBytes(T)(T value)
{
	return EndianSequence.pack!T(BYTE_ORDER.LITTLE_ENDIAN, value);
}

// from little endian bytes
auto fromLEBytes(T)(ubyte[] bytes...)
{
	return EndianSequence.unpack!T(BYTE_ORDER.LITTLE_ENDIAN, bytes);
}
