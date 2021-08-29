module styx2000.protobj.aname;

private {
	import std.string : format;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.name;
}

// username for access
class Aname : Name
{
	this(string name = "")
	{
		super(name);
	}	
	
	// string representation
	override string toString()
	{
		return format(
			`Aname(aname=%s)`, 
			_name == "" ? `""` : _name
		);
	}
	
	alias pack this;
}
