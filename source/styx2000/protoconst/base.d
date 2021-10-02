// Written in the D programming language.

/**
Constants for representing base details in 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protoconst.base;

/// Protocol version (base version, without Linux and any another extension)
enum string STYX_VERSION = "9P2000";
/// No tag value
enum ushort STYX_NOTAG = 0xFFFF;
/// No fid value
enum uint STYX_NOFID = 0xFFFFFFFF;
