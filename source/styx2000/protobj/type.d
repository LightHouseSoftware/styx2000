module styx2000.protobj.type;

private {
	import std.conv : to;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protoconst.messages;
}

// message type
class Type : StyxObject
{
	protected {
		STYX_MESSAGE_TYPE _type;
		ubyte[] _representation;
	}
	
	// create from value
	this(STYX_MESSAGE_TYPE type = STYX_MESSAGE_TYPE.R_ERROR)
	{
		_type = type;
		_representation = [cast(ubyte) type];
	}
	
	// getter
	STYX_MESSAGE_TYPE getType()
	{
		return _type;
	}
	
	// setter
	void setType(STYX_MESSAGE_TYPE type)
	{
		_type = type;
		_representation = [cast(ubyte) type];
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = [bytes[0]];
		_type = cast(STYX_MESSAGE_TYPE) bytes[0];
	}
	
	// string representation
	override string toString()
	{
		return _type.to!string;
	}
	
	alias pack this;
}
