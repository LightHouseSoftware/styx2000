module styx2000.protobj.nwqid;

private {
	import std.conv : to;
	import std.string : format;
	
	import styx2000.lowlevel.endianness;
	
	import styx2000.protobj.styxobject;
}

public {
	import styx2000.protobj.qid;
}

// new qid 
class Nwqid : StyxObject
{
	protected {
		Qid[] _nwqid;
		
		ubyte[] _representation;
	}
	
	private {
		// update qids list
		void updateQids()
		{
			if (_nwqid.length == 0)
			{
				_representation = [0, 0];
			}
			else
			{
				_representation = toLEBytes!ushort(
					cast(ushort) _nwqid.length
				);
				foreach (e; _nwqid)
				{
					_representation ~= e.pack;
				}
			}
		}
	}
	
	// create from value
	this(Qid[] nwqid = [])
	{
		_nwqid = nwqid;
		_representation = [];
		updateQids;
	}
	
	// getter
	Qid[] getQid()
	{
		return _nwqid;
	}
	
	// number of qids
	ushort countOfQids()
	{
		return fromLEBytes!ushort(_representation[0..2]);
	}
	
	// setter
	void setQid(Qid[] nwqid...)
	{
		_nwqid = nwqid;
		_representation = [];
		updateQids;
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes...)
	{
		_representation = bytes;
		_nwqid = [];
		ushort length = fromLEBytes!ushort(bytes[0..2]);
		auto vlsPosition = 2;
		
		foreach (_; 0..length)
		{
			Qid qid = new Qid;
			qid.unpack(bytes[vlsPosition..$]);
			_nwqid ~= qid;
			vlsPosition += 13;
		}
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Nwqid(nwqid=%d, wqid=%s)`,
			fromLEBytes!ushort(_representation[0..2]),
			_nwqid.to!string
		);
	}
	
	alias pack this;
}
