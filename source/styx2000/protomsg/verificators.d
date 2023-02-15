// Written in the D programming language.

/**
Module for various 9P / Styx objects checks. For internal use only. 

Copyright: LightHouse Software, 2021
License:   $(HTTP https://github.com/aquaratixc/ESL-License, Experimental Software License 1.0).
Authors:   Oleg Bakharev,
		   Ilya Pertsev
*/
module styx2000.protomsg.verificators;

private {
	 import styx2000.protobj.type;
	
	 import styx2000.protoconst.messages;
	 import styx2000.protoconst.sizes;
	
	 import styx2000.protobj.styxobject;
	 
	 import styx2000.protomsg.typeconv;
}

/// Message has right count of styx objects ?
auto hasValidFieldsCount(Type type, StyxObject[] msg...)
{
	ulong fieldsCount;
	ulong messageFieldsCount = msg.length;
			
	with (STYX_MESSAGE_TYPE)
	{
		switch(type.getType) {
			// version
			case R_VERSION:
				fieldsCount = STYX_MESSAGE_SIZE.R_VERSION;
				break;
			case T_VERSION:
				fieldsCount = STYX_MESSAGE_SIZE.T_VERSION;
				break;
			// auth
			case R_AUTH:
				fieldsCount = STYX_MESSAGE_SIZE.R_AUTH;
				break;
			case T_AUTH:
				fieldsCount = STYX_MESSAGE_SIZE.T_AUTH;
				break;
			// error
			case R_ERROR:
				fieldsCount = STYX_MESSAGE_SIZE.R_ERROR;
				break;
			// flush
			case R_FLUSH:
				fieldsCount = STYX_MESSAGE_SIZE.R_FLUSH;
				break;
			case T_FLUSH:
				fieldsCount = STYX_MESSAGE_SIZE.T_FLUSH;
				break;
			// attach
			case R_ATTACH:
				fieldsCount = STYX_MESSAGE_SIZE.R_ATTACH;
				break;
			case T_ATTACH:
				fieldsCount = STYX_MESSAGE_SIZE.T_ATTACH;
				break;
			// walk
			case R_WALK:
				fieldsCount = STYX_MESSAGE_SIZE.R_WALK;
				break;
			case T_WALK:
				fieldsCount = STYX_MESSAGE_SIZE.T_WALK;
				break;
			// open
			case R_OPEN:
				fieldsCount = STYX_MESSAGE_SIZE.R_OPEN;
				break;
			case T_OPEN:
				fieldsCount = STYX_MESSAGE_SIZE.T_OPEN;
				break;
			// create
			case R_CREATE:
				fieldsCount = STYX_MESSAGE_SIZE.R_CREATE;
				break;
			case T_CREATE:
				fieldsCount = STYX_MESSAGE_SIZE.T_CREATE;
				break;
			// read
			case R_READ:
				fieldsCount = STYX_MESSAGE_SIZE.R_READ;
				break;
			case T_READ:
				fieldsCount = STYX_MESSAGE_SIZE.T_READ;
				break;
			// write
			case R_WRITE:
				fieldsCount = STYX_MESSAGE_SIZE.R_WRITE;
				break;
			case T_WRITE:
				fieldsCount = STYX_MESSAGE_SIZE.T_WRITE;
				break;
			// clunk
			case R_CLUNK:
				fieldsCount = STYX_MESSAGE_SIZE.R_CLUNK;
				break;
			case T_CLUNK:
				fieldsCount = STYX_MESSAGE_SIZE.T_CLUNK;
				break;
			// remove
			case R_REMOVE:
				fieldsCount = STYX_MESSAGE_SIZE.R_REMOVE;
				break;
			case T_REMOVE:
				fieldsCount = STYX_MESSAGE_SIZE.T_REMOVE;
				break;
			// stat
			case R_STAT:
				fieldsCount = STYX_MESSAGE_SIZE.R_STAT;
				break;
			case T_STAT:
				fieldsCount = STYX_MESSAGE_SIZE.T_STAT;
				break;
			// wstat
			case R_WSTAT:
				fieldsCount = STYX_MESSAGE_SIZE.R_WSTAT;
				break;
			case T_WSTAT:
				fieldsCount = STYX_MESSAGE_SIZE.T_WSTAT;
				break;
			default:
				//throw new Exception("Bad message type");
				break;
		}
	}
	return (messageFieldsCount == fieldsCount);
}

/// All fields in styx message has right (for concrete type of message) ?
auto hasValidFieldsTypes(E...)(StyxObject[] msg...)
{
	bool isAllTypesValid = true;
	foreach (indexOfField, fieldType; E)
	{
		auto castedField = cast(fieldType) msg[indexOfField];
		if (castedField is null) {
			isAllTypesValid = false;
			break;
		}
	}
	return isAllTypesValid;
}

/// Message has right count of styx objects (for some message type)?
auto hasValidFieldsTypes(Type type, StyxObject[] msg...)
{
	bool isAllTypesValid = false;		
	with (STYX_MESSAGE_TYPE)
	{
		switch(type.getType) {
			// version
			case R_VERSION:
				isAllTypesValid = hasValidFieldsTypes!Rversion(msg);
				break;
			case T_VERSION:
				isAllTypesValid = hasValidFieldsTypes!Tversion(msg);
				break;
			// auth
			case R_AUTH:
				isAllTypesValid = hasValidFieldsTypes!Rauth(msg);
				break;
			case T_AUTH:
				isAllTypesValid = hasValidFieldsTypes!Tauth(msg);
				break;
			// error
			case R_ERROR:
				isAllTypesValid = hasValidFieldsTypes!Rerror(msg);
				break;
			// flush
			case R_FLUSH:
				isAllTypesValid = hasValidFieldsTypes!Rflush(msg);
				break;
			case T_FLUSH:
				isAllTypesValid = hasValidFieldsTypes!Tflush(msg);
				break;
			// attach
			case R_ATTACH:
				isAllTypesValid = hasValidFieldsTypes!Rattach(msg);
				break;
			case T_ATTACH:
				isAllTypesValid = hasValidFieldsTypes!Tattach(msg);
				break;
			// walk
			case R_WALK:
				isAllTypesValid = hasValidFieldsTypes!Rwalk(msg);
				break;
			case T_WALK:
				isAllTypesValid = hasValidFieldsTypes!Twalk(msg);
				break;
			// open
			case R_OPEN:
				isAllTypesValid = hasValidFieldsTypes!Ropen(msg);
				break;
			case T_OPEN:
				isAllTypesValid = hasValidFieldsTypes!Topen(msg);
				break;
			// create
			case R_CREATE:
				isAllTypesValid = hasValidFieldsTypes!Rcreate(msg);
				break;
			case T_CREATE:
				isAllTypesValid = hasValidFieldsTypes!Tcreate(msg);
				break;
			// read
			case R_READ:
				isAllTypesValid = hasValidFieldsTypes!Rread(msg);
				break;
			case T_READ:
				isAllTypesValid = hasValidFieldsTypes!Tread(msg);
				break;
			// write
			case R_WRITE:
				isAllTypesValid = hasValidFieldsTypes!Rwrite(msg);
				break;
			case T_WRITE:
				isAllTypesValid = hasValidFieldsTypes!Twrite(msg);
				break;
			// clunk
			case R_CLUNK:
				isAllTypesValid = hasValidFieldsTypes!Rclunk(msg);
				break;
			case T_CLUNK:
				isAllTypesValid = hasValidFieldsTypes!Tclunk(msg);
				break;
			// remove
			case R_REMOVE:
				isAllTypesValid = hasValidFieldsTypes!Rremove(msg);
				break;
			case T_REMOVE:
				isAllTypesValid = hasValidFieldsTypes!Tremove(msg);
				break;
			// stat
			case R_STAT:
				isAllTypesValid = hasValidFieldsTypes!Rstat(msg);
				break;
			case T_STAT:
				isAllTypesValid = hasValidFieldsTypes!Tstat(msg);
				break;
			// wstat
			case R_WSTAT:
				isAllTypesValid = hasValidFieldsTypes!Rwstat(msg);
				break;
			case T_WSTAT:
				isAllTypesValid = hasValidFieldsTypes!Twstat(msg);
				break;
			default:
				//throw new Exception("Bad message type");
				break;
		}
	}
	return isAllTypesValid;
}
