// Written in the D programming language.

/**
Constants for representing the permissions for filesystem objects in 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protoconst.permissions;

/// File permissions for 9P / Styx messages
enum STYX_FILE_PERMISSION : uint
{
	/// Directory
	DMDIR 	 	= 0x80000000,
	/// Append only
	DMAPPEND 	= 0x40000000,
	/// Exclusive use
	DMEXCL   	= 0x20000000,
	/// Authentication file
	DMAUTH	 	= 0x08000000,
	/// Temporary file (directory?file is not included in nightly archive)
	DMTMP       = 0x04000000,
	
	/// Owner permission for reading
	OWNER_READ 	= 0x00000100,
	/// Owner permission for writing
	OWNER_WRITE = 0x00000080,
	/// Owner permission for executing
	OWNER_EXEC 	= 0x00000040,
	
	/// Owner group permission for reading
	GROUP_READ 	= 0x00000020,
	/// Owner group permission for writing
	GROUP_WRITE = 0x00000010,
	/// Owner group permission for executing
	GROUP_EXEC 	= 0x00000008,
	
	/// Others user/group permission for reading
	OTHER_READ 	= 0x00000004,
	/// Others user/group permission for writing
	OTHER_WRITE = 0x00000002,
	/// Others user/group permission for executing
	OTHER_EXEC 	= 0x00000001,
}
