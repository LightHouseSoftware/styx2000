module styx2000.protobj.uname;

private {
	import std.string : format;
	
	import styx2000.protobj.styxobject;
	
	import styx2000.protobj.name;
}

// user name
class Uname : Name
{
	this(string name = "")
	{
		super(name);
	}
	
	alias getUname = getName;	
	alias setUname = setName;	
	
	override string toString()
	{
		return format(
			`Uname(uname=%s)`, 
			_name == "" ? `""` : _name
		);
	}
	
	alias pack this;
}
