module styx2000.protoconst.fsmodes;

// file mode for open/create messages
enum STYX_FILE_MODE : ubyte
{
	// read only
	OREAD   = 0x00,
	// write only
	OWRITE  = 0x01,
	// read-write
	ORDWR   = 0x02,
	// execute
	OEXEC   = 0x03,
	// truncate file
	OTRUNC  = 0x10,
	// remove file after closing
	ORCLOSE = 0x40
}

// file permissions for 9P messages
enum STYX_FILE_PERMISSION : uint
{
	// directory
	DMDIR 	 	= 0x80000000,
	// append only
	DMAPPEND 	= 0x40000000,
	// exclusive use
	DMEXCL   	= 0x20000000,
	// authentication file
	DMAUTH	 	= 0x08000000,
	// temporary file
	DMTMP       = 0x04000000,
	
	// owner permission
	OWNER_READ 	= 0x00000100,
	OWNER_WRITE = 0x00000080,
	OWNER_EXEC 	= 0x00000040,
	// owner group
	GROUP_READ 	= 0x00000020,
	GROUP_WRITE = 0x00000010,
	GROUP_EXEC 	= 0x00000008,
	// others
	OTHER_READ 	= 0x00000004,
	OTHER_WRITE = 0x00000002,
	OTHER_EXEC 	= 0x00000001,
}
