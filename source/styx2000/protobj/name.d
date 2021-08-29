module styx2000.protobj.name;

private {
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	
	import styx2000.protobj.styxobject;
}

// user name
class Name : StyxObject
{
	protected {
		string _name;
		
		ubyte[] _representation;
	}
	
	// create from value
	this(string name = "")
	{
		_name = name;
		_representation = VariableLengthSequence.pack(cast(ubyte[]) name);
	}
	
	// getter
	string getName()
	{
		return _name;
	}
	
	// setter
	void setName(string name)
	{
		_name = name;
		_representation = VariableLengthSequence.pack(cast(ubyte[]) name);
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_name = cast(string) (VariableLengthSequence.unpack(bytes));
		_representation = VariableLengthSequence.pack(cast(ubyte[]) _name);
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Name(name="%s")`, 
			_name == "" ? `` : _name
		);
	}
	
	alias pack this;
}
