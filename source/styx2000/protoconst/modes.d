module styx2000.protoconst.modes;

/// File mode for open/create messages
enum STYX_FILE_MODE : ubyte
{
	/// Read only
	OREAD   = 0x00,
	/// write only
	OWRITE  = 0x01,
	/// Read-write
	ORDWR   = 0x02,
	/// Execute
	OEXEC   = 0x03,
	/// Truncate file
	OTRUNC  = 0x10,
	/// Remove file after closing
	ORCLOSE = 0x40
}
