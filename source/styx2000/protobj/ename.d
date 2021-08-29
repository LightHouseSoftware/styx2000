module styx2000.protobj.ename;

private {
	import std.string : format;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.name;
}

// error message
class Ename : Name
{
	this(string name = "")
	{
		super(name);
	}
	
	// string representation
	override string toString()
	{
		return format(
			`Ename(error="%s")`, 
			_name == "" ? `` : _name
		);
	}
	
	alias pack this;
}
