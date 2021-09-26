// Written in the D programming language.

/**
A type alias for representing the oldtag object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.oldtag;

private {	
	import styx2000.protoconst.base : STYX_NOTAG;
	
	import styx2000.protobj.tag : Tag;
	
	import styx2000.protobj.styxobject;
}

/// Aliased from Tag class. The methods are the same as for the Tag class.
alias OldTag = Tag;
