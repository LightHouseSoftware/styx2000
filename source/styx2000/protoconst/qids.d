// Written in the D programming language.

/**
Constants for representing Qid type in 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protoconst.qids;

/// Qid types in 9P / Styx messages
enum STYX_QID_TYPE : ubyte
{
	/// Directory
	QTDIR 	 = 	 0x80,
	/// Append only
	QTAPPEND =   0x40,
	/// Exclusive use (file may be used only by one client)
	QTEXCL   =   0x20,
	/// Authentication file
	QTAUTH   =   0x08,
	/// Temporary file (not included in nigthly archive)
	QTTMP    =   0x04,
	/// Any other file (commonly used)
	QTFILE   =   0x00
}


