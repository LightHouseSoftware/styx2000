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
	import std.range : chunks;
	import std.stdio : File;
	import std.string : format, strip;
	
	import styx2000.extrautil.casts;
	import styx2000.extrautil.siphash : hash8;
	import styx2000.extrautil.styxmessage : StyxMessage;
	
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


/// Translate Qid to his string representation (string are the same as in Plan 9)
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


/// Translate Nwname to his string representation (string are the same as in Plan 9)
auto toPlan9Nwname(Nwname nwname)
{
	string representation = `nwname `;
	
	auto numberOfNames = nwname.countOfNames ;
	
	if (numberOfNames == 0)
	{
		representation ~= `0 `;
	}
	else
	{
		representation ~= format(`%d `, numberOfNames);
		
		foreach (i, name; nwname.getNwname)
		{
			representation ~= format(`%d:%s `, i, name);
		}
	}
		
	return representation;
}


/// Translate Nwqid to his string representation (string are the same as in Plan 9)
auto toPlan9Nwqid(Nwqid nwqid)
{
	string representation = `nwqid `;
	
	auto numberOfQids = nwqid.countOfQids;
	
	if (numberOfQids == 0)
	{
		representation ~= `0 `;
	}
	else
	{
		representation ~= format(`%d `, numberOfQids);
		
		foreach (i, qid; nwqid.getNwqid)
		{
			representation ~= format(`%d:%s `, i, qid.toPlan9Qid);
		}
	}
		
	return representation;
}


/// Translate permission to his string representation (string are the same as in Plan 9)
auto toPlan9Permissions(Perm perm)
{
	return format(`%0.16o`, perm.getPerm);
}


/// Translate Stat to his string representation (string are the same as in Plan 9)
auto toPlan9Stat(Stat stat)
{
	return format(
		`'%s' '%s' '%s' '%s' q %s m %s at %d mt %d l %d t %d d %d`,
		stat.getName,
		stat.getUid,
		stat.getGid,
		stat.getMuid,
		stat.getQid.toPlan9Qid,
		stat.getMode.toPlan9Permissions,
		stat.getAtime,
		stat.getMtime,
		stat.getLength,
		stat.getType,
		stat.getDev
	);
}


/// Translate Plan 9 Message to standard output form in Plan 9
auto toPlan9Message(StyxMessage msg)
{
	string representation;
	
	auto tag = msg[2].toTag.getTag;
	
	final switch (msg[1].toType.getType) with (STYX_MESSAGE_TYPE) 
	{
		/// T-Messages
		
		case T_VERSION:
			representation = format(
				`Tversion tag %d msize %d version '%s'`,
				tag,
				msg[3].toMsize.getMsize,
				msg[4].toVersion.getVersion
			);
			break;
		case T_AUTH:
			uint afid = msg[3].toAfid.getAfid;
			representation = format(
				`Tauth tag %d afid uname '%s' aname '%s'`,
				tag,
				cast(int) ((afid == uint.max) ? -1 : afid),
				msg[4].toUname.getUname,
				msg[5].toAname.getAname
			);
			break;
		case T_FLUSH:
			representation = format(
				`Tflush oldtag %d`,
				msg[3].toOldTag.getTag
			);
			break;
		case T_ATTACH:
			uint afid = msg[4].toAfid.getAfid;
			representation = format(
				`Tattach tag %d fid %d afid %d uname '%s' aname '%s'`,
				tag,
				msg[3].toFid.getFid,
				cast(int) ((afid == uint.max) ? -1 : afid),
				msg[5].toUname.getUname,
				msg[6].toAname.getAname
			);
			break;
		case T_WALK:
			representation = format(
				`Twalk tag %d fid %d newfid %d %s`,
				tag,
				msg[3].toFid.getFid,
				msg[4].toNewFid.getFid,
				msg[5].toNwname.toPlan9Nwname,
			);
			break;
		case T_OPEN:
			representation = format(
				`Topen tag %d fid %d mode %d`,
				tag,
				msg[3].toFid.getFid,
				cast(uint) msg[4].toMode.getMode
			);
			break;
		case T_CREATE:
			representation = format(
				`Tcreate tag %d fid %d '%s' m %s mode %d`,
				tag,
				msg[3].toFid.getFid,
				msg[4].toName.getName,
				msg[5].toPerm.toPlan9Permissions,
				cast(uint) msg[6].toMode.getMode
			);
			break;
		case T_READ:
			representation = format(
				`Tread tag %d fid %d offset %d count %d`,
				tag,
				msg[3].toFid.getFid,
				msg[4].toOffset.getOffset,
				msg[5].toCount.getCount,
			);
			break;
		case T_WRITE:
			uint count = msg[5].toCount.getCount;
			representation = format(
				`Twrite tag %d fid %d offset %d count %d '%s'`,
				tag,
				msg[3].toFid.getFid,
				msg[4].toOffset.getOffset,
				count,
				msg[6].toData.toPlan9Chunk(count)
			);
			break;
		case T_CLUNK:
			representation = format(
				`Tstat tag %d fid %d`,
				tag,
				msg[3].toFid.getFid,
			);
			break;
		case T_REMOVE:
			representation = format(
				`Tremove tag %d fid %d`,
				tag,
				msg[3].toFid.getFid,
			);
			break;
		case T_STAT:
			representation = format(
				`Tclunk tag %d fid %d`,
				tag,
				msg[3].toFid.getFid,
			);
			break;
		case T_WSTAT:
			representation = format(
				`Twstat tag %d fid %d stat %s`,
				tag,
				msg[3].toFid.getFid,
				msg[4].toStat.toPlan9Stat
			);
			break;
			
		/// R-Messages	
		
		case R_VERSION:
			representation = format(
					`Rversion tag %d msize %d version '%s'`,
					tag,
					msg[3].toMsize.getMsize,
					msg[4].toVersion.getVersion
				);
			break;
		case R_AUTH:
			representation = format(
				`Rauth tag %d aqid %s`,
				tag,
				msg[3].toAqid.toPlan9Qid
			);
			break;
		case R_FLUSH:
			representation = format(
				`Rflush tag %d`,
				tag,
			);
			break;
		case R_ERROR:
			representation = format(
				`Rerror tag %d ename %s`,
				tag,
				msg[3].toEname.getName
			);
			break;
		case R_ATTACH:
			representation = format(
				`Rattach tag %d qid %s`,
				tag,
				msg[3].toQid.toPlan9Qid
			);
			break;
		case R_WALK:
			representation = format(
				`Rwalk tag %d %s`,
				tag,
				msg[3].toNwqid.toPlan9Nwqid
			);
			break;
		case R_OPEN:
			representation = format(
				`Ropen tag %d qid %s iounit %d`,
				tag,
				msg[3].toQid.toPlan9Qid,
				msg[4].toIounit.getUnit,
			);
			break;
		case R_CREATE:
			representation = format(
				`Rcreate tag %d qid %s iounit %d`,
				tag,
				msg[3].toQid.toPlan9Qid,
				msg[4].toIounit.getUnit,
			);
			break;
		case R_READ:
			uint count = msg[3].toCount.getCount;
			representation = format(
				`Rread tag %d count %d '%s'`,
				tag,
				count,
				msg[4].toData.toPlan9Chunk(count)
			);
			break;
		case R_WRITE:
			representation = format(
				`Rwrite tag %d count %d`,
				tag,
				msg[3].toCount.getCount,
			);
			break;
		case R_CLUNK:
			representation = format(
				`Rclunk tag %d`,
				tag,
			);
			break;
		case R_REMOVE:
			representation = format(
				`Rremove tag %d`,
				tag			
			);
			break;
		case R_STAT:
			representation = format(
				`Rstat tag %d stat %s`,
				tag,
				msg[3].toStat.toPlan9Stat,
			);
			break;
		case R_WSTAT:
			representation = format(
				`Rwstat tag %d`,
				tag			
			);
			break;
	}    
	return  representation;
}


/// Translate data chunks to their string representation (string are the same as in Plan 9)
auto toPlan9Chunk(Data data, uint count)
{
	// raw chunk for pretty printing
	enum RAW_CHUNK_SIZE = 16 * 4;
	ubyte[] bytes;
	
	string representation;
	if (count != 0)
	{
		bytes = data.getData[0..count];
	}
	
	if (bytes.length > RAW_CHUNK_SIZE)
	{
		bytes = bytes[0..RAW_CHUNK_SIZE];
	}
	
	foreach (e; bytes.chunks(4))
	{
		foreach (b; e)
		{
			representation ~= format(`%0.2x`, b);
		}
		representation ~= " ";
	}
	
	return representation.strip;
}
