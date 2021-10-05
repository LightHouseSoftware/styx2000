// Written in the D programming language.

/**
This module contains a set of various useful functions that are not part of the 9P / Styx protocol, but can help in developing applications using the protocol in their work. 
Also, the functionality of this module can be used outside the context of the 9P / Styx protocol.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.extrautil;

public {
	/// Some helpers for casting StyxObject to various objects
	import styx2000.extrautil.casts;
	/// Data structure for representing Stat information from directory entry
	import styx2000.extrautil.dir;
	/// Data structure for representing Stat for directories content
	import styx2000.extrautil.dirstat;
	/// Ranges for working with 9P / Styx messages
	import styx2000.extrautil.msgranges;
	/// Implementation of fast 64-bit hash function named SipHash
	import styx2000.extrautil.siphash;
}
