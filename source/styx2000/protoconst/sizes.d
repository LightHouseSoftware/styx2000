module styx2000.protoconst.sizes;

// size of messages in StyxObject's (in SOBJ's)
enum STYX_MESSAGE_SIZE
{
	// version
	T_VERSION  = 5,
    R_VERSION  = 5,
    // auth
    T_AUTH	   = 6,
    R_AUTH	   = 4,
    // attach
    T_ATTACH   = 4,
    R_ATTACH   = 4,
    // error
    R_ERROR    = 4,
    // flush
    T_FLUSH	   = 4,
    R_FLUSH    = 3,
    // walk
    T_WALK     = 6,
    R_WALK     = 4,
    // open
    T_OPEN     = 5,
    R_OPEN     = 5,
    // create
    T_CREATE   = 7,
    R_CREATE   = 5,
    // read
    T_READ     = 6,
    R_READ     = 5,
    // write
    T_WRITE    = 7,
    R_WRITE    = 4,
    // clunk
    T_CLUNK    = 4,
    R_CLUNK    = 3,
    // remove
    T_REMOVE   = 4,
    R_REMOVE   = 3,
    // stat
    T_STAT     = 4,
    R_STAT     = 4,
    // wstat
    T_WSTAT    = 5,
    R_WSTAT    = 3,
}
