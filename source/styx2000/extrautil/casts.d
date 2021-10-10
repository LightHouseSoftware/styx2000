// Written in the D programming language.

/**
The module provides tools for convenient cast to some objects of 9P / Styx protocol.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.extrautil.casts;

private {
	import styx2000.protoconst.messages;
	
	import styx2000.protomsg.typeconv;
	
	import styx2000.protobj;
}

/// Transform to R-message type
/// Throws: Exception if passed type is not T-type or type is R-error
auto toRtype(Type type)
{		
	auto rtype = new Type;	
	with (STYX_MESSAGE_TYPE)
	{
		switch(type.getType) {
			// version
			case T_VERSION:
				rtype.setType(R_VERSION);
				break;
			// auth
			case T_AUTH:
				rtype.setType(R_AUTH);
				break;
			// flush
			case T_FLUSH:
				rtype.setType(R_FLUSH);
				break;
			// attach
			case T_ATTACH:
				rtype.setType(R_ATTACH);
				break;
			// walk
			case T_WALK:
				rtype.setType(R_WALK);
				break;
			case T_OPEN:
				rtype.setType(R_OPEN);
				break;
			// create
			case T_CREATE:
				rtype.setType(R_CREATE);
				break;
			// read
			case T_READ:
				rtype.setType(R_READ);
				break;
			// write
			case T_WRITE:
				rtype.setType(R_WRITE);
				break;
			// clunk
			case T_CLUNK:
				rtype.setType(R_CLUNK);
				break;
			// remove
			case T_REMOVE:
				rtype.setType(R_REMOVE);
				break;
			// stat
			case T_STAT:
				rtype.setType(R_STAT);
				break;
			// wstat
			case T_WSTAT:
				rtype.setType(R_WSTAT);
				break;
			default:
				throw new Exception("Wrong message type used to get R-message type");
		}
	}
	return rtype;
}

/// Transform to T-message type
/// Throws: Exception if passed type is not R-type or type is R-error
auto toTtype(Type type)
{		
	auto ttype = new Type;	
	with (STYX_MESSAGE_TYPE)
	{
		switch(type.getType) {
			// version
			case R_VERSION:
				ttype.setType(T_VERSION);
				break;
			// auth
			case R_AUTH:
				ttype.setType(T_AUTH);
				break;
			// flush
			case R_FLUSH:
				ttype.setType(T_FLUSH);
				break;
			// attach
			case R_ATTACH:
				ttype.setType(T_ATTACH);
				break;
			// walk
			case R_WALK:
				ttype.setType(T_WALK);
				break;
			case R_OPEN:
				ttype.setType(T_OPEN);
				break;
			// create
			case R_CREATE:
				ttype.setType(T_CREATE);
				break;
			// read
			case R_READ:
				ttype.setType(T_READ);
				break;
			// write
			case R_WRITE:
				ttype.setType(T_WRITE);
				break;
			// clunk
			case R_CLUNK:
				ttype.setType(T_CLUNK);
				break;
			// remove
			case R_REMOVE:
				ttype.setType(T_REMOVE);
				break;
			// stat
			case R_STAT:
				ttype.setType(T_STAT);
				break;
			// wstat
			case R_WSTAT:
				ttype.setType(T_WSTAT);
				break;
			default:
				throw new Exception("Wrong message type used to get T-message type");
		}
	}
	return ttype;
}

/// Conversion from StyxObject to Afid type
alias toAfid = fromStyxObject!Afid;

/// Conversion from StyxObject to Aname type
alias toAname = fromStyxObject!Aname;

/// Conversion from StyxObject to Aqid type
alias toAqid = fromStyxObject!Aqid;

/// Conversion from StyxObject to Count type
alias toCount = fromStyxObject!Count;

/// Conversion from StyxObject to Data type
alias toData = fromStyxObject!Data;

/// Conversion from StyxObject to Ename type
alias toEname = fromStyxObject!Ename;

/// Conversion from StyxObject to Fid type
alias toFid = fromStyxObject!Fid;

/// Conversion from StyxObject to Iounit type
alias toIounit = fromStyxObject!Iounit;

/// Conversion from StyxObject to Mode type
alias toMode = fromStyxObject!Mode;

/// Conversion from StyxObject to Msize type
alias toMsize = fromStyxObject!Msize;

/// Conversion from StyxObject to Name type
alias toName = fromStyxObject!Name;

/// Conversion from StyxObject to NewFid type
alias toNewFid = fromStyxObject!NewFid;

/// Conversion from StyxObject to Nwname type
alias toNwname = fromStyxObject!Nwname;

/// Conversion from StyxObject to Nwqid type
alias toNwqid = fromStyxObject!Nwqid;

/// Conversion from StyxObject to Offset type
alias toOffset = fromStyxObject!Offset;

/// Conversion from StyxObject to OldTag type
alias toOldTag = fromStyxObject!OldTag;

/// Conversion from StyxObject to Perm type
alias toPerm = fromStyxObject!Perm;

/// Conversion from StyxObject to Qid type
alias toQid = fromStyxObject!Qid;

/// Conversion from StyxObject to Size type
alias toSize = fromStyxObject!Size;

/// Conversion from StyxObject to Stat type
alias toStat = fromStyxObject!Stat;

/// Conversion from StyxObject to Version type
alias toVersion = fromStyxObject!Version;

/// Conversion from StyxObject to Tag type
alias toTag = fromStyxObject!Tag;

/// Conversion from StyxObject to Type type
alias toType = fromStyxObject!Type;

/// Conversion from StyxObject to Uname type
alias toUname = fromStyxObject!Uname;

