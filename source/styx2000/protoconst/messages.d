module styx2000.protoconst.messages;

/// Possible Styx message types (R- and T-message types)
enum STYX_MESSAGE_TYPE : ubyte
{
	/// version
	T_VERSION  = 100,
    R_VERSION  = 101,
    /// auth
    T_AUTH	   = 102,
    R_AUTH	   = 103,
    /// attach
    T_ATTACH   = 104,
    R_ATTACH   = 105,
    /// error
    R_ERROR    = 107,
    /// flush
    T_FLUSH	   = 108,
    R_FLUSH    = 109,
    /// walk
    T_WALK     = 110,
    R_WALK     = 111,
    /// open
    T_OPEN     = 112,
    R_OPEN     = 113,
    /// create
    T_CREATE   = 114,
    R_CREATE   = 115,
    /// read
    T_READ     = 116,
    R_READ     = 117,
    /// write
    T_WRITE    = 118,
    R_WRITE    = 119,
    /// clunk
    T_CLUNK    = 120,
    R_CLUNK    = 121,
    /// remove
    T_REMOVE   = 122,
    R_REMOVE   = 123,
    /// stat
    T_STAT     = 124,
    R_STAT     = 125,
    /// wstat
    T_WSTAT    = 126,
    R_WSTAT    = 127,
}
