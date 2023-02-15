// Written in the D programming language.

/**
Module for working with messages of the 9P / Styx protocol and various objects in them.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protomsg;

public {
	/// Decode 9P / Styx message from raw bytes
	import styx2000.protomsg.decoder;
	
	/// Encode 9P / Styx message to raw bytes
	import styx2000.protomsg.encoder;
}
