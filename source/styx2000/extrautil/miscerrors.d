// Written in the D programming language.

/**
This module contains additional errors constants that may be used in 9P / Styx message parsing.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.extrautil.miscerrors;

enum STYX_ERROR_MESSAGE : string
{
	ECONTAINSSLASH  = "slash in path element",
	EINVALIDMSGTYPE = "invalid message type",
	EINVALIDQIDTYPE = "invalid type field in qid",
	EINVALIDUTF8    = "string is not valid utf8",
	ELONGANAME      = "aname field too long",
	ELONGFILENAME   = "file name too long",
	ELONGSIZE       = "size field is longer than actual message size",
	ELONGLENGTH     = "long length field in stat structure",
	ELONGSTAT       = "stat structure too long",
	ELONGUSERNAME   = "uid or gid name is too long",
	ELONGVERSION    = "protocol version string too long",
	EMAXOFFSET      = "maximum offset exceeded",
	EMAXWELEM       = "maximum walk elements exceeded",
	ENULLSTRING     = "NUL in string field",
	EOVERSIZE       = "size of field exceeds size of message",
	ESHORTSTAT      = "stat structure too short",
	ETOOBIG         = "message is too long",
	ETOOSMALL       = "message is too small",
	EUNDERSIZE      = "empty space in message",
	EZEROLEN        = "zero-length message",
	EMAXSIZE 	   = "message exceeds msize",
	
	ENEEDNOTAG    = "STYX_NOTAG(0xffff) required for T_Version",
	E9P2000ONLY   = "only 9P2000 protocol version",
	ENOAUTH       = "no authentication required",
	ENEEDNOFID    = "no authentication fid required",
	ENOALTROOT    = "alternate root requested unavailable",
	EINVALIDFID   = "supplied fid invalid",
	EDUPLICATEFID = "supplied fid exists",
	ENOTDIR       = "not a directory",
	EALREADYOPEN  = "file already open",
	ENOTFOUND     = "not found",
	ENOTOPEN      = "file not opened",
}
