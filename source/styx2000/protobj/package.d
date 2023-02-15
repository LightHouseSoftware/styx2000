// Written in the D programming language.

/**
This module provides wrapper class implementations for the basic kinds of objects found in 9P / Styx messages. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protobj;

public {
	
	/**
		The class required to represent the `afid` object of the Styx protocol. 
	*/
	import styx2000.protobj.afid;
	
	/**
		The class required to represent the `aqid` object of the Styx protocol. 
	*/
	import styx2000.protobj.aqid;
	
	/**
		The class required to represent the `aname` object of the Styx protocol. 
	*/
	import styx2000.protobj.aname;
	
	/**
		The class required to represent the `count` object of the Styx protocol. 
	*/
	import styx2000.protobj.count;
	
	/**
		The class required to represent the `data` object of the Styx protocol. 
	*/
	import styx2000.protobj.data;
	
	/**
		The class required to represent the `ename` object of the Styx protocol. 
	*/
	import styx2000.protobj.ename;
	
	/**
		The class required to represent the `fid` object of the Styx protocol. 
	*/
	import styx2000.protobj.fid;
	
	/**
		The class required to represent the `iounit` object of the Styx protocol. 
	*/
	import styx2000.protobj.iounit;
	
	/**
		The class required to represent the `mode` object of the Styx protocol. 
	*/
	import styx2000.protobj.mode;
	
	/**
		The class required to represent the `msize` object of the Styx protocol. 
	*/
	import styx2000.protobj.msize;
	
	/**
		The class required to represent the `name` object of the Styx protocol. 
	*/
	import styx2000.protobj.name;
	
	/**
		The class required to represent the `newfid` object of the Styx protocol. 
	*/
	import styx2000.protobj.newfid;
	
	/**
		The class required to represent the `nwname` object of the Styx protocol. 
	*/
	import styx2000.protobj.nwname;
	
	/**
		The class required to represent the `nwqid` object of the Styx protocol. 
	*/
	import styx2000.protobj.nwqid;
	
	/**
		The class required to represent the `qid` object of the Styx protocol. 
	*/
	import styx2000.protobj.qid;
	
	/**
		The class required to represent the `oldtag` object of the Styx protocol. 
	*/
	import styx2000.protobj.oldtag;
	
	/**
		The class required to represent the `offset` object of the Styx protocol. 
	*/
	import styx2000.protobj.offset;
	
	/**
		The class required to represent the `perm` object of the Styx protocol. 
	*/
	import styx2000.protobj.perm;
	
	/**
		The class required to represent the `size` object of the Styx protocol. 
	*/
	import styx2000.protobj.size;
	
	/**
		The class required to represent the `stat` object of the Styx protocol. 
	*/
	import styx2000.protobj.stat;
	
	/**
		The class required to represent the `version` object of the Styx protocol. 
	*/
	import styx2000.protobj.styxversion;
	
	/**
		The class required to represent the `tag` object of the Styx protocol. 
	*/
	import styx2000.protobj.tag;
	
	/**
		The class required to represent the `type` object of the Styx protocol. 
	*/
	import styx2000.protobj.type;
	
	/**
		The class required to represent the `uname` object of the Styx protocol. 
	*/
	import styx2000.protobj.uname;
	
	/**
		Common type for all classes representing Styx protocol objects.
	*/
	import styx2000.protobj.styxobject;
}
