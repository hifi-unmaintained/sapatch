Ultima Online Second Age Client Patch
================================================================================
This project tries to bring back some of the original playing experiences of T2A
era to UO client **5.0.8** which is the client of choice for UOSA freeshard.

To build, copy `client.exe` from the UO directory as `client.dat` and run
`build.cmd` to compile a patched version.

Features currently implemented:

 * Status gump has original look (with stat buttons)
 * Elf race is not selectable when creating a character

Contributing
--------------------------------------------------------------------------------
All code is in x86 assembly with custom annotations that modify the binary in
other ways. For annotation reference, see the [nasm-patcher][1] README.

The ground work has been done in [OllyDbg][2] which is free and powerful little
debugger. Research notes are saved in [pyudd][3] CSV format for easy sharing and
merging. To import and export the notes in OllyDbg, use the [ollydbg-backup][4]
plugin.

The research notes are not necessarily accurate and most possibly even completely
wrong for some parts. Please update them with accurate information as you go.

[1]: https://github.com/cnc-patch/nasm-patcher
[2]: http://ollydbg.de/
[3]: http://code.google.com/p/pyudd/
[4]: https://github.com/hifi/ollydbg-backup

Included binaries
--------------------------------------------------------------------------------
Pre-built tools that are included in the **tools/** directory:

 * linker.exe - [https://github.com/cnc-patch/nasm-patcher](https://github.com/cnc-patch/nasm-patcher)
 * nasm.exe - [http://nasm.us/](http://nasm.us/)

Both are free software and can be compiled separately. They are pre-built for
convenience.
