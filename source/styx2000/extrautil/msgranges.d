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
	// raw byte range
	struct ByteMessageRange
	{
		private {
			ubyte[] _bytes;
			ubyte[] _message;
			uint 	_size;
		}
		
		this(ubyte[] bytes...)
		{
			_bytes = bytes;
		}
		
		bool empty() @property const {
			return (_bytes.length == 0);
		}
		
		ubyte[] front() {

			_size = fromLEBytes!uint(_bytes[0..4]);
			_message = _bytes[0.._size];
			return _message;
		}
		
		void popFront()
		{
			_bytes = _bytes[_size..$];
		}
	}
}

// create message range (in byte form) from bytes
auto byRawMessage(ubyte[] bytes...) 
{
	return ByteMessageRange(bytes);
}

// create StyxObject range from bytes
auto byStyxMessage(ubyte[] bytes...) 
{
	return bytes.byRawMessage.map!decode;
}

// create string representation for entire StyxObject array
auto toTextObject(StyxObject[] msg) 
{
	return msg
			.to!string
			.replace(`[`, `{`)
			.replace(`]`, `}`);
}

// create string representation range from bytes
auto byTextMessage(ubyte[] bytes...) 
{
	return bytes.byStyxMessage.map!toTextObject;
}
