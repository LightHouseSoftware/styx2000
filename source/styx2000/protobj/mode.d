module styx2000.protobj.mode;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protoconst.modes;
}

// message type
class Mode : StyxObject
{
	protected {
		STYX_FILE_MODE _mode;
		ubyte[] _representation;
	}
	
	// create from value
	this(STYX_FILE_MODE mode = STYX_FILE_MODE.OREAD)
	{
		_mode = mode;
		_representation = [cast(ubyte) mode];
	}
	
	// getter
	STYX_FILE_MODE getMode()
	{
		return _mode;
	}
	
	// setter
	void setMode(STYX_FILE_MODE mode)
	{
		_mode = mode;
		_representation = [cast(ubyte) mode];
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
		_mode = cast(STYX_FILE_MODE) bytes[0];
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Mode(mode=%s)`,
			_mode.to!string
		);
	}
	
	alias pack this;
}
