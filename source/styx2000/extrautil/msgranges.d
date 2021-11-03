// Written in the D programming language.

/**
This module contains a set of various functions for work with 9P / Styx messages as ranges.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.extrautil.msgranges;

private {
	import std.algorithm : map;
	import std.conv : to;
	import std.string : replace;
	
	import styx2000.lowlevel.endianness : fromLEBytes;
	import styx2000.protobj.styxobject : StyxObject;
	import styx2000.protomsg : decode;
}

private {
	/// Raw byte range
	struct ByteMessageRange
	{
		private {
			ubyte[] _bytes;
			ubyte[] _message;
			uint 	_size;
		}
		
		/// Load into range byte array for processing (assume that byte array contains messages as bytes)
		this(ubyte[] bytes...)
		{
			_bytes = bytes;
		}
		
		bool empty() @property {
			bool isEmpty;
			// if range contains valid message size marker
			if (_bytes.length > 4)
			{
				// message marker
				_size = fromLEBytes!uint(_bytes[0..4]);
				// if rest's length greather than real length
				if (_size > _bytes.length)
				{
					isEmpty = true;
				}
			}
			else
			{
				isEmpty = true;
			}
			return isEmpty;
		}
		
		/// Front of range
		ubyte[] front() {
			_message = _bytes[0.._size];
			return _message;
		}
		
		/// Proccess current message
		void popFront()
		{
			_bytes = _bytes[_size..$];
		}
	}
}

/// Create message range (in byte form) from bytes
auto byRawMessage(ubyte[] bytes...) 
{
	return ByteMessageRange(bytes);
}

/// Create StyxObject range from bytes
auto byStyxMessage(ubyte[] bytes...) 
{
	return bytes.byRawMessage.map!decode;
}

/// Create string representation for entire StyxObject array
auto toTextObject(StyxObject[] msg) 
{
	return msg
			.to!string
			.replace(`[`, `{`)
			.replace(`]`, `}`);
}

/// Create string representation range from bytes
auto byTextMessage(ubyte[] bytes...) 
{
	return bytes.byStyxMessage.map!toTextObject;
}
