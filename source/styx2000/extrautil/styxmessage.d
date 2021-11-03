// Written in the D programming language.

/**
This module contains a set of various useful functions for more convenient work with 9P /Styx messages.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.extrautil.styxmessage;

private {
	import styx2000.protoconst;
	
	import styx2000.protobj;
}

/// Convenient alias
alias StyxMessage = StyxObject[];

/// StyxMessage is client message ?
bool isTmessage(StyxMessage msg)
{
	bool isMessage = false;
	Type type = cast(Type) msg[1];
	
	if (type !is null)
	{
		with (STYX_MESSAGE_TYPE)
		{
			switch(type.getType) 
			{
				// version
				case T_VERSION:
					isMessage = true;
					break;
				// auth
				case T_AUTH:
					isMessage = true;
					break;
				// flush
				case T_FLUSH:
					isMessage = true;
					break;
				// attach
				case T_ATTACH:
					isMessage = true;
					break;
				// walk
				case T_WALK:
					isMessage = true;
					break;
				case T_OPEN:
					isMessage = true;
					break;
				// create
				case T_CREATE:
					isMessage = true;
					break;
				// read
				case T_READ:
					isMessage = true;
					break;
				// write
				case T_WRITE:
					isMessage = true;
					break;
				// clunk
				case T_CLUNK:
					isMessage = true;
					break;
				// remove
				case T_REMOVE:
					isMessage = true;
					break;
				// stat
				case T_STAT:
					isMessage = true;
					break;
				// wstat
				case T_WSTAT:
					isMessage = true;
					break;
				default:
					break;
			}
		}
	}
	
	return isMessage;
}

/// StyxMessage is server message ?
bool isRmessage(StyxMessage msg)
{
	bool isMessage = false;
	Type type = cast(Type) msg[1];
	
	if (type !is null)
	{
		with (STYX_MESSAGE_TYPE)
		{
			switch(type.getType) 
			{
				// version
				case R_VERSION:
					isMessage = true;
					break;
				// auth
				case R_AUTH:
					isMessage = true;
					break;
				// flush
				case R_FLUSH:
					isMessage = true;
					break;
				// attach
				case R_ATTACH:
					isMessage = true;
					break;
				// walk
				case R_WALK:
					isMessage = true;
					break;
				case R_OPEN:
					isMessage = true;
					break;
				// create
				case R_CREATE:
					isMessage = true;
					break;
				// read
				case R_READ:
					isMessage = true;
					break;
				// write
				case R_WRITE:
					isMessage = true;
					break;
				// clunk
				case R_CLUNK:
					isMessage = true;
					break;
				// remove
				case R_REMOVE:
					isMessage = true;
					break;
				// stat
				case R_STAT:
					isMessage = true;
					break;
				// wstat
				case R_WSTAT:
					isMessage = true;
					break;
				// error
				case R_ERROR:
					isMessage = true;
					break;
				default:
					break;
			}
		}
	}
	
	return isMessage;
}

/// StyxMessage is error message ?
bool isErrorMessage(StyxMessage msg)
{
	bool isMessage = false;
	Type type = cast(Type) msg[1];
	
	if (type !is null)
	{
		if (type.getType == STYX_MESSAGE_TYPE.R_ERROR)
		{
			isMessage = true;
		}
	}
	
	return isMessage;
}

/// Create base header for 9P / Styx messages
auto createHeader(uint size = 0, STYX_MESSAGE_TYPE type = STYX_MESSAGE_TYPE.R_ERROR, ushort tag = STYX_NOTAG)
{
	return cast(StyxMessage) [
		new Size(size),
		new Type(type),
		new Tag(tag)
	];
}

/// Create version message from client
auto createTmsgVersion(ushort tag = STYX_NOTAG, uint maximalSize = 8192, string vers = STYX_VERSION)
{
	return createHeader(0, STYX_MESSAGE_TYPE.T_VERSION, tag) ~ cast(StyxMessage) [
		new Msize(maximalSize),
		new Version(vers)
	];
}

/// Create version message from server
auto createRmsgVersion(ushort tag = STYX_NOTAG, uint maximalSize = 8192, string vers = STYX_VERSION)
{
	return createHeader(0, STYX_MESSAGE_TYPE.R_VERSION, tag) ~ cast(StyxMessage) [
		new Msize(maximalSize),
		new Version(vers)
	];
}

/// Create auth message from client
auto createTmsgAuth(ushort tag = STYX_NOTAG, uint afid = STYX_NOFID, string uname = "", string aname = "")
{
	return createHeader(0, STYX_MESSAGE_TYPE.T_AUTH, tag) ~ cast(StyxMessage) [
		new Afid(afid),
		new Uname(uname),
		new Aname(aname)
	];
}

/// Create auth message from server
auto createRmsgAuth(ushort tag = STYX_NOTAG, STYX_QID_TYPE type = STYX_QID_TYPE.QTFILE, uint vers = 0, ulong path = 0)
{
	return createHeader(0, STYX_MESSAGE_TYPE.R_AUTH, tag) ~ cast(StyxMessage) [
		new Aqid(type, vers, path)
	];
}

/// Create attach message from client
auto createTmsgAttach(ushort tag = STYX_NOTAG, uint fid = STYX_NOFID, uint afid = STYX_NOFID, string uname = "", string aname = "")
{
	return createHeader(0, STYX_MESSAGE_TYPE.T_ATTACH, tag) ~ cast(StyxMessage) [
		new Fid(fid),
		new Afid(afid),
		new Uname(uname),
		new Aname(aname)
	];
}

/// Create attach message from server
auto createRmsgAttach(ushort tag = STYX_NOTAG, STYX_QID_TYPE type = STYX_QID_TYPE.QTFILE, uint vers = 0, ulong path = 0)
{
	return createHeader(0, STYX_MESSAGE_TYPE.R_ATTACH, tag) ~ cast(StyxMessage) [
		new Qid(type, vers, path)
	];
}

/// Create error message from server (for client this type of message does not exists)
auto createRmsgError(ushort tag = STYX_NOTAG, string ename = "")
{
	return createHeader(0, STYX_MESSAGE_TYPE.R_ERROR, tag) ~ cast(StyxMessage) [
		new Ename(ename)
	];
}

/// Create clunk message from client
auto createTmsgClunk(ushort tag = STYX_NOTAG, uint fid = STYX_NOFID)
{
	return createHeader(0, STYX_MESSAGE_TYPE.T_CLUNK, tag) ~ cast(StyxMessage) [
		new Fid(fid)
	];
}

/// Create clunk message from server
auto createRmsgClunk(ushort tag = STYX_NOTAG)
{
	return createHeader(0, STYX_MESSAGE_TYPE.R_CLUNK, tag);
}

/// Create flush message from client
auto createTmsgFlush(ushort tag = STYX_NOTAG, ushort oldTag = STYX_NOTAG)
{
	return createHeader(0, STYX_MESSAGE_TYPE.T_FLUSH, tag) ~ cast(StyxMessage) [
		new OldTag(oldTag)
	];
}

/// Create flush message from server
auto createRmsgFlush(ushort tag = STYX_NOTAG)
{
	return createHeader(0, STYX_MESSAGE_TYPE.R_FLUSH, tag);
}

/// Create remove message from client
auto createTmsgRemove(ushort tag = STYX_NOTAG, uint fid = STYX_NOFID)
{
	return createHeader(0, STYX_MESSAGE_TYPE.T_REMOVE, tag) ~ cast(StyxMessage) [
		new Fid(fid)
	];
}

/// Create remove message from server
auto createRmsgRemove(ushort tag = STYX_NOTAG)
{
	return createHeader(0, STYX_MESSAGE_TYPE.R_REMOVE, tag);
}

/// Create open message from client
auto createTmsgOpen(ushort tag = STYX_NOTAG, uint fid = STYX_NOFID, uint afid = STYX_NOFID, STYX_FILE_MODE mode = STYX_FILE_MODE.OREAD)
{
	return createHeader(0, STYX_MESSAGE_TYPE.T_OPEN, tag) ~ cast(StyxMessage) [
		new Mode(mode)
	];
}

/// Create open message from server
auto createRmsgOpen(ushort tag = STYX_NOTAG, STYX_QID_TYPE type = STYX_QID_TYPE.QTFILE, uint vers = 0, ulong path = 0, uint iounit = 8164)
{
	return createHeader(0, STYX_MESSAGE_TYPE.R_OPEN, tag) ~ cast(StyxMessage) [
		new Qid(type, vers, path),
		new Iounit(iounit)
	];
}



