module styx2000.protobj.styxversion;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.name;
	
	import styx2000.protoconst.protocol;
}

// error message
class Version : Name
{
	this(string name = "")
	{
		if (name == "")
		{
			_name = "9P2000";
			_representation = cast(ubyte[]) [6, 0] ~ STYX_VERSION;
		}
		else
		{
			_name = name;
			_representation = VariableLengthSequence.pack(cast(ubyte[]) name);
		}
	}
	
	alias setVersion = setName;
	alias getVersion = getName;
		
	override string toString()
	{
		return format(
			`Version(version="%s")`, 
			_name == "" ? `""` : _name
		);
	}
	
	alias pack this;
}
