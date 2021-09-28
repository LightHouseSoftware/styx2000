module styx2000.extrautil.casts;

private {
	import styx2000.protoconst.messages;
	
	import styx2000.protomsg.typeconv;
	
	import styx2000.protobj;
}

// transform to R-message type
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

// transform to T-message type
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

// conversion from StyxObject to various protocol objects
alias toAfid = fromStyxObject!Afid;

alias toAname = fromStyxObject!Aname;

alias toAqid = fromStyxObject!Aqid;

alias toCount = fromStyxObject!Count;

alias toData = fromStyxObject!Data;

alias toEname = fromStyxObject!Ename;

alias toFid = fromStyxObject!Fid;

alias toIounit = fromStyxObject!Iounit;

alias toMode = fromStyxObject!Mode;

alias toMsize = fromStyxObject!Msize;

alias toName = fromStyxObject!Name;

alias toNewFid = fromStyxObject!NewFid;

alias toNwname = fromStyxObject!Nwname;

alias toNwqid = fromStyxObject!Nwqid;

alias toOffset = fromStyxObject!Offset;

alias toOldTag = fromStyxObject!OldTag;

alias toPerm = fromStyxObject!Perm;

alias toQid = fromStyxObject!Qid;

alias toSize = fromStyxObject!Size;

alias toStat = fromStyxObject!Stat;

alias toVersion = fromStyxObject!Version;

alias toTag = fromStyxObject!Tag;

alias toType = fromStyxObject!Type;

alias toUname = fromStyxObject!Uname;

