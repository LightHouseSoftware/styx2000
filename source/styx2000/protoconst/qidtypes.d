module styx2000.protoconst.qidtypes;

// qid field in 9P messages
enum STYX_QID_TYPE : ubyte
{
	// directory
	QTDIR 	 = 	 0x80,
	// append only
	QTAPPEND =   0x40,
	// exclusive use (file may be used only by one client)
	QTEXCL   =   0x20,
	// authentication file
	QTAUTH   =   0x08,
	// temporary file (not included in nigthly archive)
	QTTMP    =   0x04,
	// any other file
	QTFILE   =   0x00
}


