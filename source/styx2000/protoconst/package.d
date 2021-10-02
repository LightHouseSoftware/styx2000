module styx2000.protoconst;

public {
	/// Base constants for protocol: version, nofid and noqid
	import styx2000.protoconst.base;
	/// Typical errors in client-server interaction
	import styx2000.protoconst.errors;
	/// Constants for message types: R- and T-messages
	import styx2000.protoconst.messages;
	/// File operating modes
	import styx2000.protoconst.modes;
	/// File/directory permissions
	import styx2000.protoconst.permissions;
	/// Constants for qid types
	import styx2000.protoconst.qids;
	/// Sizes for all 9P / Styx messages
	import styx2000.protoconst.sizes;
}
