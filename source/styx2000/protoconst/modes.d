module styx2000.protoconst.modes;

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
