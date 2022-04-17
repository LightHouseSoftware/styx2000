// Written in the D programming language.

/**
This module contains a set of various useful helpers for miscellaneous stuff.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.extrautil.mischelpers;

private 
{
	import std.path : baseName;
	import std.file : DirEntry, SpanMode;
	import std.stdio : File;
	
	import styx2000.extrautil.siphash : hash8;
	import styx2000.protobj;
}

/// Create Qid object from DirEntry
auto createQid(DirEntry de)
{	
	return new Qid(
		(de.isDir) ? STYX_QID_TYPE.QTDIR : STYX_QID_TYPE.QTFILE,
		cast(uint) de.timeLastModified.toUnixTime,
		hash8(de.name)
	);
}

/// Convenient helper for creating Qid from path string
auto createQid(string path)
{
	return createQid(
		DirEntry(path)
	);
}

/// Create Stat object from DirEntry
auto createStat(DirEntry de, ushort type = 0, ushort dev = 0, string uid = "", string gid = "", string muid = "")
{
	auto qid = createQid(de);
	return new Stat(
		dev, 
		type, 
		qid,
		new Perm((qid.getType << 24) | (de.attributes & 0x1ff)),
		cast(uint) de.timeLastAccessed.toUnixTime,
		cast(uint) de.timeLastModified.toUnixTime, 
		(de.isDir) ? 0 : de.size, 
		baseName(de.name), 
		uid, 
		gid, 
		muid
	);
}


/// Convenient helper for creating Stat object from path string
auto createStat(string path, ushort type = 0, ushort dev = 0, string uid = "", string gid = "", string muid = "")
{
	return createStat(DirEntry(path), type, dev, uid, gid, muid);
}


/// Translate Qid to their string representation (string are the same as in Plan 90
auto toPlan9Qid(T : Qid)(T qid)
{
	string type;
	
	final switch (qid.getType) with (STYX_QID_TYPE)
	{
		case QTDIR:
			type = `d`;
			break;
		case QTAPPEND:
			type = `a`;
			break;
		case QTEXCL:
			type = `l`;
			break;
		case QTAUTH:
			type = `u`;
			break;
		case QTTMP:
			type = `t`; // ??? 
			break;
		case QTFILE:
			type = ` `;
			break;
	}
	
	return format(
		`(%0.16x %d %s)`,
		qid.getPath,
		qid.getVers,
		type,
	);
}
