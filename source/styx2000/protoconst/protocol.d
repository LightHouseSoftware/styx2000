module styx2000.protoconst.protocol;

private {
	import styx2000.lowlevel.endianness;
}

// protocol version
enum STYX_VERSION = cast(ubyte[]) "9P2000";
// no tag value
enum STYX_NOTAG = toLEBytes!ushort(0xFFFF);
// no fid value
enum STYX_NOFID = toLEBytes!uint(0xFFFFFFFF);
