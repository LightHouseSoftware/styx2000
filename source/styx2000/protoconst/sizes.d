// Written in the D programming language.

/**
Constants for representing sizes of all messages (measured in StyxObject's). 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protoconst.sizes;

/// size of messages in StyxObject's (in SOBJ's)
enum STYX_MESSAGE_SIZE
{
	/// Version message size (client)
	T_VERSION  = 5,
	/// Version message size(server)
    R_VERSION  = 5,
    /// Auth message size (client)
    T_AUTH	   = 6,
    /// Auth message size (server)
    R_AUTH	   = 4,
    /// Attach message size (client)
    T_ATTACH   = 4,
    /// Attach message size (server)
    R_ATTACH   = 4,
    /// Error message size (only server, for client analog isn't exists)
    R_ERROR    = 4,
    /// Flush message size (client)
    T_FLUSH	   = 4,
    /// Flush message size (server)
    R_FLUSH    = 3,
    /// Walk message size (client)
    T_WALK     = 6,
    /// Walk message size (server)
    R_WALK     = 4,
    /// Open message size (client)
    T_OPEN     = 5,
    /// Open message size (server)
    R_OPEN     = 5,
    /// Create message size (client)
    T_CREATE   = 7,
    /// Create message size (server)
    R_CREATE   = 5,
    /// Read message size (client)
    T_READ     = 6,
    /// Read message size (server)
    R_READ     = 5,
    /// Write message size (client)
    T_WRITE    = 7,
    /// Write message size (server)
    R_WRITE    = 4,
    /// Clunk message size (client)
    T_CLUNK    = 4,
    /// Clunk message size (server)
    R_CLUNK    = 3,
    /// Remove message size (client)
    T_REMOVE   = 4,
    /// Remove message size (server)
    R_REMOVE   = 3,
    /// Stat message size (client)
    T_STAT     = 4,
    /// Stat message size (server)
    R_STAT     = 4,
    /// Wstat message size (client)
    T_WSTAT    = 5,
    /// Wstat message size (server)
    R_WSTAT    = 3,
}
