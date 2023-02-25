// Written in the D programming language.

/**
A type alias for representing the newfid object of the 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj.newfid;

private {
	
	import styx2000.protoconst.base : STYX_NOFID;
	
	import styx2000.protobj.fid : Fid;
	
	import styx2000.protobj.styxobject;
}

/// Aliased from Fid class. The methods are the same as for the Fid class.
alias NewFid = Fid;

/// Convenient alias for getting NewTag
alias getNewFid = Fid.getFid;
