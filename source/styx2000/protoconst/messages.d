// Written in the D programming language.

/**
Constants for representing the message types in 9P / Styx protocol. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protoconst.messages;

/// Possible Styx message types (R- and T-message types)
enum STYX_MESSAGE_TYPE : ubyte
{
	/// Version message (client)
	T_VERSION  = 100,
	/// Version message (server)
    R_VERSION  = 101,
    /// Auth message (client)
    T_AUTH	   = 102,
    /// Auth message (server)
    R_AUTH	   = 103,
    /// Attach message (client)
    T_ATTACH   = 104,
    /// Attach message (server)
    R_ATTACH   = 105,
    /// Error message ()
    R_ERROR    = 107,
    /// Flush message (client)
    T_FLUSH	   = 108,
    /// Flush message (server)
    R_FLUSH    = 109,
    /// Walk message (client)
    T_WALK     = 110,
    /// Walk message (server)
    R_WALK     = 111,
    /// Open message (client)
    T_OPEN     = 112,
    /// Open message (server)
    R_OPEN     = 113,
    /// Create message (client)
    T_CREATE   = 114,
    /// Create message (server)
    R_CREATE   = 115,
    /// Read message (client)
    T_READ     = 116,
    /// Read message (server)
    R_READ     = 117,
    /// Write message (client)
    T_WRITE    = 118,
    /// Write message (server)
    R_WRITE    = 119,
    /// Clunk message (client)
    T_CLUNK    = 120,
    /// Clunk message (server)
    R_CLUNK    = 121,
    /// Remove message (client)
    T_REMOVE   = 122,
    /// Remove message (server)
    R_REMOVE   = 123,
    /// Stat message (client)
    T_STAT     = 124,
    /// Stat message (server)
    R_STAT     = 125,
    /// Wtat message (client)
    T_WSTAT    = 126,
    /// Wstat message (server)
    R_WSTAT    = 127,
}
