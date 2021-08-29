module styx2000.protobj.styxobject;

// interface to all protocol object
interface StyxObject 
{
	// pack Styx object to byte array
	ubyte[] pack();
	// unpack Styx object from byte array
	void unpack(ubyte[] bytes...);
}
