// Written in the D programming language.

/**
Low-level operation with various objects. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.lowlevel;

public {
	/// Manipulating with bytes in different endianness
	import styx2000.lowlevel.endianness;
	/// Working with variable-length fields in 9P / Styx
	import styx2000.lowlevel.vls;
}
