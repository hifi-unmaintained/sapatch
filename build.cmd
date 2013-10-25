copy client_noenc.dat client_noenc.exe
tools\linker.exe src\status_gump.asm src\status_gump.inc client_noenc.exe tools\nasm.exe
tools\linker.exe src\no_elf.asm src\no_elf.inc client_noenc.exe tools\nasm.exe
