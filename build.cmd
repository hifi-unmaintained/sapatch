copy client.dat client.exe
tools\linker.exe src\status_gump.asm src\status_gump.inc client.exe tools\nasm.exe
tools\linker.exe src\misc.asm src\misc.inc client.exe tools\nasm.exe
