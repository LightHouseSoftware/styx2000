// Written in the D programming language.

/**
This module contains additional errors constants that may be used in 9P / Styx message parsing.

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev   
*/
module styx2000.extrautil.miscerrors;

/// Some kinds of error that are not included in protoconst/errors module
enum STYX_ERROR_MESSAGE : string
{
	/// Slash in path element
	ECONTAINSSLASH  = "slash in path element",
	
	/// Invalid message type
	EINVALIDMSGTYPE = "invalid message type",
	
	/// Invalid message type
	EINVALIDQIDTYPE = "invalid type field in qid",
	
	/// String is not valid utf8
	EINVALIDUTF8    = "string is not valid utf8",
	
	/// Field aname is too long
	ELONGANAME      = "aname field too long",
	
	/// File name too long
	ELONGFILENAME   = "file name too long",
	
	/// Size field is longer than actual message size
	ELONGSIZE       = "size field is longer than actual message size",
	
	/// Long length field in stat structure
	ELONGLENGTH     = "long length field in stat structure",
	
	/// Structure for stat is too long
	ELONGSTAT       = "stat structure too long",
	
	/// Name for uid or gid is too long
	ELONGUSERNAME   = "uid or gid name is too long",
	
	/// Protocol version string too long
	ELONGVERSION    = "protocol version string too long",
	
	/// Maximum offset exceeded
	EMAXOFFSET      = "maximum offset exceeded",
	
	/// Maximum walk elements exceeded
	EMAXWELEM       = "maximum walk elements exceeded",
	
	/// NUL in string field
	ENULLSTRING     = "NUL in string field",
	
	/// Size of field exceeds size of message
	EOVERSIZE       = "size of field exceeds size of message",
	
	/// Structure for stat is too short
	ESHORTSTAT      = "stat structure too short",
	
	/// Message is too long
	ETOOBIG         = "message is too long",
	
	/// Message is too small
	ETOOSMALL       = "message is too small",
	
	/// Empty space in message
	EUNDERSIZE      = "empty space in message",
	
	/// Zero length message
	EZEROLEN        = "zero-length message",
	
	/// Message size exceeds msize
	EMAXSIZE 	    = "message exceeds msize",
	
	/// Needed STYX_NOTAG
	ENEEDNOTAG    = "STYX_NOTAG(0xffff) required for T_Version",
	
	/// Only 9P2000 allowed
	E9P2000ONLY   = "only 9P2000 protocol version",
	
	/// No authentication required
	ENOAUTH       = "no authentication required",
	
	/// No authentication fid required
	ENEEDNOFID    = "no authentication fid required",
	
	/// Alternate root requested unavailable
	ENOALTROOT    = "alternate root requested unavailable",
	
	/// Supplied fid invalid
	EINVALIDFID   = "supplied fid invalid",
	
	/// Supplied fid exists
	EDUPLICATEFID = "supplied fid exists",
	
	/// Not a directory
	ENOTDIR       = "not a directory",
	
	/// File already opened
	EALREADYOPEN  = "file already open",
	
	/// Not found
	ENOTFOUND     = "not found",
	
	/// Not opened
	ENOTOPEN      = "file not opened",
}
