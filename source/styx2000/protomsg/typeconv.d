// Written in the D programming language.

/**
Module for various type representation and conversions between types.
Mainly for service use, however, the module contains two useful helpers for working with messages and their objects: fromStyxObject and toStyxObject. 
The module is not automatically connected with the import of the protoconst package, so manual connection is required to use it. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protomsg.typeconv;

private {
	import styx2000.protobj;
}

/// Alias for type tuple
template Tuple(E...)
{
	alias E Tuple;
}

/// `size[4] Tversion tag[2] msize[4] version[s]`
alias Tversion = Tuple!(Size, Type, Tag, Msize, Version);

/// `size[4] Rversion tag[2] msize[4] version[s]`
alias Rversion = Tuple!(Size, Type, Tag, Msize, Version);

/// `size[4] Tauth tag[2] afid[4] uname[s] aname[s]`
alias Tauth = Tuple!(Size, Type, Tag, Afid, Uname, Aname);

/// `size[4] Rauth tag[2] aqid[13]`
alias Rauth = Tuple!(Size, Type, Tag, Aqid);

/// `size[4] Rerror tag[2] ename[s]`
alias Rerror = Tuple!(Size, Type, Tag, Ename);

/// `size[4] Tflush tag[2] oldtag[2]`
alias Tflush = Tuple!(Size, Type, Tag, Tag);

/// `size[4] Rflush tag[2]`
alias Rflush = Tuple!(Size, Type, Tag);

/// `size[4] Tattach tag[2] fid[4] afid[4] uname[s] aname[s]`
alias Tattach = Tuple!(Size, Type, Tag, Fid, Afid, Uname, Aname);

/// size[4] Rattach tag[2] qid[13]
alias Rattach = Tuple!(Size, Type, Tag, Qid);

/// `size[4] Twalk tag[2] fid[4] newfid[4] nwname[2] nwname*(wname[s])`
alias Twalk = Tuple!(Size, Type, Tag, Fid, Fid, Nwname);

/// `size[4] Rwalk tag[2] nwqid[2] nwqid*(wqid[13])`
alias Rwalk = Tuple!(Size, Type, Tag, Nwqid);

/// `size[4] Topen tag[2] fid[4] mode[1]`
alias Topen = Tuple!(Size, Type, Tag, Fid, Mode);

/// `size[4] Ropen tag[2] qid[13] iounit[4]`
alias Ropen = Tuple!(Size, Type, Tag, Qid, Iounit);

/// `size[4] Tcreate tag[2] fid[4] name[s] perm[4] mode[1]`
alias Tcreate = Tuple!(Size, Type, Tag, Fid, Name, Perm, Mode);

/// `size[4] Rcreate tag[2] qid[13] iounit[4]`
alias Rcreate = Tuple!(Size, Type, Tag, Qid, Iounit);

/// `size[4] Tread tag[2] fid[4] offset[8] count[4]`
alias Tread = Tuple!(Size, Type, Tag, Fid, Offset, Count);

/// `size[4] Rread tag[2] count[4] data[count]`
alias Rread = Tuple!(Size, Type, Tag, Count, Data);

/// `size[4] Twrite tag[2] fid[4] offset[8] count[4] data[count]`
alias Twrite = Tuple!(Size, Type, Tag, Fid, Offset, Count, Data);

/// `size[4] Rwrite tag[2] count[4]`
alias Rwrite = Tuple!(Size, Type, Tag, Count);

/// `size[4] Tclunk tag[2] fid[4]`
alias Tclunk = Tuple!(Size, Type, Tag, Fid);

/// `size[4] Rclunk tag[2]`
alias Rclunk = Tuple!(Size, Type, Tag);

/// `size[4] Tremove tag[2] fid[4]`
alias Tremove = Tuple!(Size, Type, Tag, Fid);

/// `size[4] Rremove tag[2]`
alias Rremove = Tuple!(Size, Type, Tag);

/// `size[4] Tstat tag[2] fid[4]`
alias Tstat = Tuple!(Size, Type, Tag, Fid);

/// `size[4] Rstat tag[2] stat[n]`
alias Rstat = Tuple!(Size, Type, Tag, Stat);

/// `size[4] Twstat tag[2] fid[4] stat[n]`
alias Twstat = Tuple!(Size, Type, Tag, Fid, Stat);

/// `size[4] Rwstat tag[2]`
alias Rwstat = Tuple!(Size, Type, Tag);

/// Is one of StyxObject class ?
template isStyxObject(T)
{
	enum bool isStyxObject = is(T == Afid) || is(T : Qid) || is(T == Count)|| is(T == Data) || is(T : Name) || is(T : Fid) || is(T == Iounit) || 
							 is(T == Mode) || is(T == Msize) || is(T == Nwname) || is(T == Nwqid) || is(T == Offset) || is(T == Perm) || 
							 is(T == Size) || is(T == Stat) || is(T == Tag) || is(T == Type) || is(T == Version); 
}

/// Casts from StyxObject class
auto fromStyxObject(T)(StyxObject obj) if (isStyxObject!T)
{
	return cast(T) obj;
}

/// Casts to StyxObject class
auto toStyxObject(T)(T obj) if (isStyxObject!T)
{
	return cast(StyxObject) obj;
}


