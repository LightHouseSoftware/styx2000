// Written in the D programming language.

/**
This class provides an implementation of the SipHash cryptographic function.
Implementation is based on the following code (by Károly Lőrentey): https://github.com/attaswift/SipHash/blob/master/SipHash/SipHasher.swift

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev

See also: 
	https://131002.net/siphash, https://github.com/attaswift/SipHash/blob/master/SipHash/SipHasher.swift		   
*/
module styx2000.extrautil.siphash;

public import styx2000.lowlevel.endianness : BYTE_ORDER;

/**
	The class provides functionality to initialize the internal state of the SipHash hash function and generate a hash for byte arrays.
	Params:
	NUMBER_OF_COMPRESS_ROUNDS = Number of compression rounds (default: 2).
	NUMBER_OF_FINALIZATION_ROUNDS = Number of finalization rounds (default: 4).
*/
class SipHash(ubyte NUMBER_OF_COMPRESS_ROUNDS = 2, ubyte NUMBER_OF_FINALIZATION_ROUNDS = 4)
{
    private
    {
        /// Secret key: 0 - low part of key, 1 - high of key
        ulong key0, key1;
        
        /// Internal state
        ulong v0 = 0x736f6d6570736575;
        ulong v1 = 0x646f72616e646f6d;
        ulong v2 = 0x6c7967656e657261;
        ulong v3 = 0x7465646279746573;

        ulong pendingBytes = 0;
        ulong pendingByteCount = 0;
        long byteCount = 0;
    }

    private
    {
		/**
		Constructs (restores) a unsigned long value (little-endian order of bytes in value) from the passed pointer to ubyte array. 
		For internal use.
	    Params:
		ptr = Pointer to unsigned byte array.
	  
	    */
        ulong _toLEUlong(ubyte* ptr) @system @nogc
        {
            ulong h = 0x0000000000000000;
            
            for (int i = 0; i < 64; i += 8)
            {
				h |= (cast(ulong) ptr[i >> 3]) << i;
			}

            return h;
        }

		/**
		Rotated shift of unsigned long value. 
		For internal use.
	    Params:
		value = Unsigned long value.
		amount = Number of position to shift.
	  
	    */
        ulong _rotateLeft(ulong value, ulong amount) @nogc
        {
            return (value << amount) | (value >> (64 - amount));
        }

		/**
		One SipHash round. 
		For internal use.
	  
	    */
        void _round() @nogc
        {
            v0 += v1;
            v1 = _rotateLeft(v1, 13);
            v1 ^= v0;
            v0 = _rotateLeft(v0, 32);
            v2 += v3;
            v3 = _rotateLeft(v3, 16);
            v3 ^= v2;
            v0 += v3;
            v3 = _rotateLeft(v3, 21);
            v3 ^= v0;
            v2 += v1;
            v1 = _rotateLeft(v1, 17);
            v1 ^= v2;
            v2 = _rotateLeft(v2, 32);
        }


		/**
		Compress one word. 
		For internal use.
	    Params:
		m = Unsigned long value (word for compressing).
	  
	    */
        void _compress(ulong m) @nogc
        {
            v3 ^= m;
            
            for (ubyte i = 0; i < NUMBER_OF_COMPRESS_ROUNDS; i++)
            {
                _round;
            }
            
            v0 ^= m;
        }

		
		/**
		Finalization procedure.Needed for ending of hashing. 
		For internal use.

	    */
        ulong _finalize() @nogc
        {
            pendingBytes |= (cast(ulong) byteCount) << 56;
            byteCount = -1;

            _compress(pendingBytes);

            v2 ^= 0xff;

            for (ubyte i = 0; i < NUMBER_OF_FINALIZATION_ROUNDS; i++)
            {
                _round;
            }

            return v0 ^ v1 ^ v2 ^ v3;
        }
    }

	/**
	Default constructor. 
	Initializes the internal state of the function with a random 128-bit key (split into two 64-bit parts).

    */
    this()
    {
        import std.random : Random, uniform, unpredictableSeed;

        auto rng = Random(unpredictableSeed);

        this(uniform(0UL, ulong.max, rng), uniform(0UL, ulong.max, rng));
    }

	/**
	Basic constructor. 
	Initializes the internal state with a 128-bit key, split into two 64-bit parts - the low-order and high-order parts of the key.
	Params:
	key0 = low part of key.
	key1 = high part of key.

    */	
    this(ulong key0, ulong key1)
    {
        key0 = key0;
        key1 = key1;

        v0 ^= key0;
        v1 ^= key1;
        v2 ^= key0;
        v3 ^= key1;
    }
    
    
    /**
	Basic constructor. 
	Initializes the internal state with a 128-bit key. If key length less than 16 bytes (i.e 128 bit), the key will padded with padding method 2.
	Params:
	key = key as array of unsigned bytes.

    */	
    this(ubyte[] key)
    {
		static join8to64(ubyte[] block)
		{
			ulong number = block[0];
	
			for (byte j = 1; j < 8; j++)
			{
				number <<= 8;
				number |= block[j];
			}
	
			return number;
		}
	
        if (key.length < 16)
        {
			key ~= 0x01;
			
			while (key.length != 16)
			{
				key ~= 0x00;
			}
		}
		
		key0 = join8to64(key[0..8]);
        key1 = join8to64(key[8..16]);

        v0 ^= key0;
        v1 ^= key1;
        v2 ^= key0;
        v3 ^= key1;
    }

	/**
	Append bytes to internal hash-function state.
    Params:
	buffer = Unsigned byte array.
  
    */
    void append(ubyte[] buffer...)
    {
        import std.algorithm : min;

        auto i = 0;
        
        if (pendingByteCount > 0)
        {
            ulong readCount = min(buffer.length, 8 - pendingByteCount);
            ulong m = 0;
            
            switch (readCount)
            {
	            case 7:
	                m |= cast(ulong)(buffer[6]) << 48;
	                goto case;
	            case 6:
	                m |= cast(ulong)(buffer[5]) << 40;
	                goto case;
	            case 5:
	                m |= cast(ulong)(buffer[4]) << 32;
	                goto case;
	            case 4:
	                m |= cast(ulong)(buffer[3]) << 24;
	                goto case;
	            case 3:
	                m |= cast(ulong)(buffer[2]) << 16;
	                goto case;
	            case 2:
	                m |= cast(ulong)(buffer[1]) << 8;
	                goto case;
	            case 1:
	                m |= cast(ulong)(buffer[0]);
	                break;
	            default:
	                break;
            }
            
            pendingBytes |= m << cast(ulong)(pendingByteCount << 3);
            pendingByteCount += readCount;
            i += readCount;

            if (pendingByteCount == 8)
            {
                _compress(pendingBytes);
                pendingBytes = 0;
                pendingByteCount = 0;
            }
        }

        ulong left = (buffer.length - i) & 7;
        ulong end = (buffer.length - i) - left;

        while (i < end)
        {
            ulong m = 0;
            auto ptr = buffer[i .. i + 8].ptr;
            _compress(_toLEUlong(ptr));
            i += 8;
        }

        switch (left)
        {
	        case 7:
	            pendingBytes |= cast(ulong)(buffer[i + 6]) << 48;
	            goto case;
	        case 6:
	            pendingBytes |= cast(ulong)(buffer[i + 5]) << 40;
	            goto case;
	        case 5:
	            pendingBytes |= cast(ulong)(buffer[i + 4]) << 32;
	            goto case;
	        case 4:
	            pendingBytes |= cast(ulong)(buffer[i + 3]) << 24;
	            goto case;
	        case 3:
	            pendingBytes |= cast(ulong)(buffer[i + 2]) << 16;
	            goto case;
	        case 2:
	            pendingBytes |= cast(ulong)(buffer[i + 1]) << 8;
	            goto case;
	        case 1:
	            pendingBytes |= cast(ulong)(buffer[i]);
	            break;
	        default:
	            break;
        }

        pendingByteCount = left;

        byteCount += buffer.length;
    }

	/**
	Perform finalization of hash-function and returns hash.
	Returns:
	64-bit hash of passed bytes.
  
    */
    ulong finalize()
    {
        return _finalize();
    }
}

/**
Hashes a byte stream with the specified cryptographic key.
Params:
bytes = Array of unsigned bytes.
key = Array of two ulong for low and high parts of 128-bit key (default: zero key).
Returns:
64-bit hash of passed bytes.

Typical usage:
----
auto hash = hash8([0x65, 0x67, 0x67, 0x00]);
----
*/
auto hash8(ubyte[] bytes, ulong[2] key = [0UL, 0UL])
{
    SipHash!(2, 4) sh = new SipHash!(2, 4)(key[0], key[1]);

    sh.append(bytes);

    return sh.finalize;
}

/**
Hashes a string with the specified cryptographic key.
Params:
string = String for hashing.
key = Array of two ulong for low and high parts of 128-bit key (default: zero key).
Returns:
64-bit hash of passed bytes.

Typical usage:
----
auto hash = hash8(`Sample`);
----
*/
auto hash8(string s, ulong[2] key = [0UL, 0UL])
{
    SipHash!(2, 4) sh = new SipHash!(2, 4)(key[0], key[1]);

    sh.append(cast(ubyte[]) s);

    return sh.finalize;
}

/**
Hashes a byte stream with the specified cryptographic key.
Params:
bytes = Array of unsigned bytes.
key = Array of unsigned bytes for 128-bit key (default: zero key).
Returns:
64-bit hash of passed bytes.

Typical usage:
----
auto hash = hash8([0x65, 0x67, 0x67, 0x00]);
----
*/
auto hash(ubyte[] bytes, ubyte[] key = [0x0])
{
    SipHash!(2, 4) sh = new SipHash!(2, 4)(key);

    sh.append(bytes);

    return sh.finalize;
}

/**
Create string representation of some value in hexadecimal view with specified byte order.
Params:
byteOrder = Order of bytes.
value = Some value of basic D's type.
Returns:
String representation (hexadecimal digits) of value.

Typical usage:
----
import std.stdio : writeln;

auto value = 0xabcdef01;
value.asHexWithOrder!(BYTE_ORDER.BIG_ENDIAN).writeln;    // prints "abcdef01"
value.asHexWithOrder!(BYTE_ORDER.LITTLE_ENDIAN).writeln; // prints "01efcdab"
----
*/
template asHexWithOrder(BYTE_ORDER byteOrder)
{
	private import std.traits : isBasicType;
	
	private auto asHexByte(ubyte value) {
		enum DIGIT   = `0123456789abcdef`;
		string hexs;
		
		hexs ~= DIGIT[value >> 4];
		hexs ~= DIGIT[value & 0x0f];
		
		return hexs;
	}
	
	auto asHexWithOrder(T)(T value) if (isBasicType!T)
	{
		string hexs;
		
		enum T mask = T(0xff);
		enum T size = T.sizeof;

        foreach (i; 0..size)
        {
            static if (byteOrder == BYTE_ORDER.LITTLE_ENDIAN)
	            T shift = i << 3;
	        else
	            T shift = (size - i - 1) << 3;
	            
            auto e = cast(ubyte) ((value & (mask << shift)) >> shift);
            
            hexs ~= asHexByte(e);
        }
		
		return hexs;
	}
}

/**
Create string representation of some value in hexadecimal view with big_endian order of digits.
Params:
value = Some value of basic D's type.
Returns:
String representation (hexadecimal digits) of value.

Typical usage:
----
import std.stdio : writeln;

auto value = 0xabcdef01;
asHexBE(value).writeln; // prints "abcdef01"
----
*/
alias asHexBE = asHexWithOrder!(BYTE_ORDER.BIG_ENDIAN);


/**
Create string representation of some value in hexadecimal view with little_endian order of digits.
Params:
value = Some value of basic D's type.
Returns:
String representation (hexadecimal digits) of value

Typical usage:
----
import std.stdio : writeln;

auto value = 0xabcdef01;
asHexBE(value).writeln; // prints "01efcdab"
----
*/
alias asHexLE = asHexWithOrder!(BYTE_ORDER.LITTLE_ENDIAN);
