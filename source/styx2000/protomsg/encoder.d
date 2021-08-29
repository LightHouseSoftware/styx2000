module styx2000.protomsg.encoder;

private {
	import styx2000.protomsg.typeconv;
	import styx2000.protomsg.verificators;
}

public {
	import styx2000.protoconst.messages;
	import styx2000.protoconst.sizes;
	
	import styx2000.protobj;
}


// encode styx objects to bytes
auto encode(StyxObject[] msg)
{
	ubyte[] _representation;
	
	if (msg.length == 0)
	{
		throw new Exception(`Bad Styx message length: empty message`);
	}
	else
	{
		if (msg.length < 3)
		{
			throw new Exception(`Bad Styx message length: message contains no Styx header`);
		}
		else
		{
			auto size = fromStyxObject!Size(msg[0]);
			if (size is null)
			{
				throw new Exception(`Bad message content: wrong Size object`);
			}
			
			auto type = fromStyxObject!Type(msg[1]);
			if (size is null)
			{
				throw new Exception(`Bad message content: wrong Type object`);
			}
			
			auto tag = fromStyxObject!Tag(msg[2]);
			if (size is null)
			{
				throw new Exception(`Bad message content: wrong Tag object`);
			}
			
			if (!hasValidFieldsCount(type, msg))
			{
				throw new Exception(`Bad message content: wrong fields count`);
			}
			
			if (!hasValidFieldsTypes(type, msg))
			{
				throw new Exception(`Bad message content: wrong Styx type in message`);
			}
			
			uint length = 0;
			
			foreach (f; msg[1..$])
			{
				if (f is null)
				{
					throw new Exception("Bad message content: null Styx object");
				}
				
				auto packed = f.pack;
				length += packed.length;
				_representation ~= packed;
			}
			
			size.setSize(length + 4);
			_representation = size ~ _representation;
		}
	}
	
	return _representation;
}
