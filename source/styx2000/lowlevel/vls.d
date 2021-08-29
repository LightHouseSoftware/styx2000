module styx2000.lowlevel.vls;

private {
	import styx2000.lowlevel.endianness;
}

// variable-length sequence (VLS) in 9P format
class VariableLengthSequence
{
	// pack bytes to VLS
	static ubyte[] pack(ubyte[] bytes)
	{
		ubyte[] rawBytes;
		
		auto fieldSize = cast(ushort) bytes.length;
		rawBytes ~= toLEBytes!ushort(fieldSize);
		rawBytes ~= bytes;
		
		return rawBytes;
	}
	
	// unpack bytes from VLS
	static ubyte[] unpack(ubyte[] bytes)
	{
		ubyte[] rawBytes;
		
		if (bytes.length == 0)
		{
			throw new Exception(`Wrong Variable Length Field (VLS) size`);
		}
		else
		{
			auto fieldSize = fromLEBytes!ushort(bytes[0..2]);
			rawBytes = bytes[2..2+fieldSize];
		}
		
		return rawBytes;
	}
}
