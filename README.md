# styx2000
Low-level, minimal implementation of Styx protocol (9P protocol from Plan 9/Inferno).

# Examples
## Parsing the file with the captured stream from the client to the server
The source file for the example is compiled with the command:
```
dub build --single styxdecoder.d
```
Content of styxdecoder.d file:
```d
#!/usr/bin/env dub
/+ dub.sdl:
	dependency "styx2000" version="~main"
+/

private {
	import std.file : exists;
	import std.stdio;

	import styx2000.extrautil.msgranges : byTextMessage;
}

alias readBinaryFile = function(string filename) {
	static import std.file;
	return cast(ubyte[]) std.file.read(filename);
};

void main(string[] args)
{
	if (args.length < 2)
	 {
		 writeln(`Usage: styxdecoder <file1> [<file2> ... <fileN>]`);
	 }
	 else
	 {
		 foreach (f; args[1..$])
		 {
			 if (f.exists)
			 {
				 foreach (msg; f.readBinaryFile.byTextMessage)
				 {
					msg.writeln;
				 }
			 }
		 }
	 }
}
```
The working data for this script can be obtained by capturing traffic from the client to the server (or vice versa), for example, using the [tcpflow](https://github.com/simsong/tcpflow) utility.
