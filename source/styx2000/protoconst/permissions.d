module styx2000.protoconst.permissions;

/// File permissions for 9P messages
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
	
	/// Owner permission
	
	OWNER_READ 	= 0x00000100,
	OWNER_WRITE = 0x00000080,
	OWNER_EXEC 	= 0x00000040,
	
	/// Owner group
	
	GROUP_READ 	= 0x00000020,
	GROUP_WRITE = 0x00000010,
	GROUP_EXEC 	= 0x00000008,
	
	/// Others
	
	OTHER_READ 	= 0x00000004,
	OTHER_WRITE = 0x00000002,
	OTHER_EXEC 	= 0x00000001,
}
