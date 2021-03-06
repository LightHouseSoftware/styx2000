// Written in the D programming language.

/**
Constants for representing the base error messages in 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protoconst.errors;

/// Typical error messages in Styx
enum STYX_ERRORS
{
	/// Out of memory error
	ENOMEM    =  cast(ubyte[]) `Out of memory`,
	/// Permission error
	EPERM     =  cast(ubyte[]) `Permission denied`,
	/// No free devices error
	ENODEV    =  cast(ubyte[]) `No free devices`,
	/// I/O hangup
	EHUNGUP   =  cast(ubyte[]) `I/O on hungup channel`,
	/// File exists error
	EEXIST    =  cast(ubyte[]) `File exists`,
	/// File does not exist
	ENONEXIST =  cast(ubyte[]) `File does not exist`,
	/// Bad command error
	EBADCMD   =  cast(ubyte[]) `Bad command`,
	/// Bad arguments
	EBADARG   =  cast(ubyte[]) `Bad arguments`
}
