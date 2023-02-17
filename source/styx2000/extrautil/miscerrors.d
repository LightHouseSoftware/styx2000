// Written in the D programming language.

/**
This module contains additional errors constants that may be used in 9P / Styx message parsing.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.extrautil.miscerrors;

enum STYX_MESSAGE_ERROR : string
{
	CONTAINSSLASH  = "slash in path element",
	INVALIDMSGTYPE = "invalid message type",
	INVALIDQIDTYPE = "invalid type field in qid",
	INVALIDUTF8    = "string is not valid utf8",
	LONGANAME      = "aname field too long",
	LONGMESSAGE    = "or message too long",
	LONGFILENAME   = "file name too long",
	LONGSIZE       = "size field is longer than actual message size",
	LONGLENGTH     = "long length field in stat structure",
	LONGSTAT       = "stat structure too long",
	LONGUSERNAME   = "uid or gid name is too long",
	LONGVERSION    = "protocol version string too long",
	MAXOFFSET      = "Maximum offset exceeded",
	MAXWELEM       = "maximum walk elements exceeded",
	NULLSTRING     = "NUL in string field",
	OVERSIZE       = "size of field exceeds size of message",
	SHORTSTAT      = "stat structure too short",
	TOOBIG         = "message is too long",
	TOOSMALL       = "message is too small",
	UNDERSIZE      = "empty space in message",
	ZEROLEN        = "zero-length message",
	MAXSIZE 	   = "message exceeds msize"
	
	ENEEDNOTAG  = "NOTAG(0xFFFF) Required for Tversion."
	E9P2000ONLY   = "We only talk 9P2000 Here."
	ENOAUTH       = "No authentication required."
	ENEEDNOFID = "No Authentication FID required."
	ENOALTROOT = "Alternate root requested unavailable."
	EINVALIDFID = "Supplied FID invalid."
	EDUPLICATEFID = "Supplied FID exists."
	ENOTDIR = "Not a directory."
	EALREADYOPEN = "File already open."
	ENOTFOUND = "Not found."
	ENOTOPEN = "File not opened."
}
