module styx2000.protobj.nwname;

private {
	import std.conv : to;
	import std.path : buildPath;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	import styx2000.lowlevel.vls;
	
	import styx2000.protobj.styxobject;
}

// name for walking
class Nwname : StyxObject
{
	protected {
		string[] _nwname;
		
		ubyte[] _representation;
	}
	
	private {
		// update names list
		void updateNames()
		{
			if (_nwname.length == 0)
			{
				// ????
				// if empty walk then nwname = 1, wname = [0, 0] (in inferno)
				// in plan9 is [0, 0]
				_representation = [0, 0];
			}
			else
			{
				_representation = toLEBytes!ushort(
					cast(ushort) _nwname.length
				);
				foreach (e; _nwname)
				{
					_representation ~= VariableLengthSequence.pack(cast(ubyte[]) e);
				}
			}
		}
	}
	
	// create from value
	this(string[] nwname = [])
	{
		_nwname = nwname;
		_representation = [];
		updateNames;
	}
	
	void setName(string[] nwname...)
	{
		_nwname = nwname;
		_representation = [];
		updateNames;
	}
	
	// number of names in path
	ushort countOfNames()
	{
		return fromLEBytes!ushort(_representation[0..2]);
	}

	// all names in path
	string[] getName()
	{
		return _nwname;
	}
	
	alias getNwname = getName;	
	alias setNwname = setName;	
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes;
		_nwname = [];
		ushort length = fromLEBytes!ushort(bytes[0..2]);
		auto vlsPosition = 2;
		
		foreach (_; 0..length)
		{
			string n = cast(string) VariableLengthSequence.unpack(
				bytes[vlsPosition..$]
			);
			_nwname ~= n;
			vlsPosition += n.length + 2;
		}
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Nwname(nwname=%d, wmname="%s")`,
			fromLEBytes!ushort(_representation[0..2]),
			buildPath(_nwname)
		);
	}
	
	alias pack this;
}
