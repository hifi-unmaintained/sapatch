;
; Copyright (c) 2013 Toni Spets <toni.spets@iki.fi>
;
; Permission to use, copy, modify, and distribute this software for any
; purpose with or without fee is hereby granted, provided that the above
; copyright notice and this permission notice appear in all copies.
;
; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
;

@SETD 0x004A6BA4 0x802  ; classic gump id
@SETD 0x004A6E60 0x00   ; set lock gump id to zero to hide it
@SETB 0x004A6E8B 0x3D   ; str arrow Y
@SETB 0x004A6E8D 0x27   ; str arrow X
@SETB 0x004A6EE3 0x49   ; dex arrow Y
@SETB 0x004A6EE5 0x27   ; dex arrow X
@SETD 0x004A6F3B 0x55   ; int arrow Y
@SETB 0x004A6F40 0x27   ; int arrow X
@SETD 0x004A6F9D 0x89   ; minimize bottom
@SETD 0x004A6FA2 0x108  ; minimize right
@SETD 0x004A6FA7 0x70   ; minimize top
@SETD 0x004A6FAC 0xF0   ; minimize left

@JMP 0x004A6FE1 0x004A7013 ; skip blue dot button

@CLEAR 0x00480234 0x90 0x00480239 ; disable tooltips on gump

%define sprintf 0x00550FCF
%define fmt_uint 0x005BA548
%define fmt_uint_s_uint 0x005BA52C

%define DrawTextOnGump 0x004DFFD0

%define lineHeight 12
%define line 0

; change character name drawing not to be centered and place it properly
@CLEAR 0x004A89F7 0x90 0x004A89FC
@SETB 0x004A8A05 0x35
@SETB 0x004A8A07 0x56
@CALL 0x004A8A08 DrawTextOnGump
@SETB 0x004A8A0F 0x2C

%macro DrawWordStat 3
    XOR ECX,ECX
    LEA EDX,[ESP+0x48]
    MOV CX,WORD [EBP+%1]
    PUSH ECX
    PUSH fmt_uint
    PUSH EDX
    CALL sprintf

    MOV EDX,[EBP+0x54]
    MOV ECX,[EBP+0x24]
    LEA EAX,[ESP+0x2C]
    PUSH EAX
    MOV EAX,[EDX+0x14]
    PUSH ECX
    ADD EAX,4
    LEA ECX,[ESP+0x5C]
    PUSH EAX
    PUSH ECX
    PUSH 0x386
    PUSH 0x1
    PUSH %3
    PUSH %2
    CALL DrawTextOnGump
    XOR EDX,EDX
    ADD ESP,0x2C
%endmacro

%macro DrawWordWordStat 4
    XOR ECX,ECX
    MOV CX,WORD [EBP+%2]
    PUSH ECX
    XOR ECX,ECX
    MOV CX,WORD [EBP+%1]
    PUSH ECX
    PUSH fmt_uint_s_uint
    LEA EDX,[ESP+0x50]
    PUSH EDX
    CALL sprintf

    MOV EDX,[EBP+0x54]
    MOV ECX,[EBP+0x24]
    LEA EAX,[ESP+0x30]
    PUSH EAX
    MOV EAX,[EDX+0x14]
    PUSH ECX
    ADD EAX,4
    LEA ECX,[ESP+0x5C]
    PUSH EAX
    PUSH ECX
    PUSH 0x386
    PUSH 0x1
    PUSH %4
    PUSH %3
    CALL DrawTextOnGump
    XOR EDX,EDX
    ADD ESP,0x30
%endmacro

[org 0x4A8A22]

; clean up the old gump text drawing code
@CLEAR 0x004A8A22 0x00 0x004A9200

; str
DrawWordStat 0xE4, 86, 72 + (line * lineHeight)
%assign line line+1

; dex
DrawWordStat 0xE6, 86, 72 + (line * lineHeight)
%assign line line+1

; int
DrawWordStat 0xE8, 86, 72 + (line * lineHeight)
%assign line line+1

; sex 0xE2
SexProc:

    MOV EDX,[EBP+0x54]
    MOV ECX,[EBP+0x24]
    LEA EAX,[ESP+0x20]
    PUSH EAX
    MOV EAX,[EDX+0x14]
    PUSH ECX
    ADD EAX,4
    PUSH EAX

    LEA EAX,[ESP+0x54]
    XOR ECX,ECX
    MOV CX,WORD [EBP+0xE2]
    TEST CX,CX
    JE .male
    MOV [EAX], BYTE 'F'
    JMP .cont
.male:
    MOV [EAX], BYTE 'M'
.cont:
    MOV [EAX+1], BYTE 0
    PUSH EAX
    PUSH 0x386
    PUSH 0x1
    PUSH 72 + (line * lineHeight)
    PUSH 86
    CALL DrawTextOnGump
    ADD ESP,0x20
    XOR EDX,EDX
%assign line line+1

; ar
DrawWordStat 0x100, 86, 72 + (line * lineHeight)

%assign line 0

; hits = 0xEA
; hitsMax = 0xEC
DrawWordWordStat 0xEA, 0xEC, 174, 72 + (line * lineHeight)
%assign line line+1

; mana = 0xF2
; manaMax = 0xF4
DrawWordWordStat 0xF2, 0xF4, 174, 72 + (line * lineHeight)
%assign line line+1

; stamina = 0xEE
; staminaMax = 0xF0
DrawWordWordStat 0xEE, 0xF0, 174, 72 + (line * lineHeight)
%assign line line+1

; gold = 0xF8
DrawWordStat 0xF8, 174, 72 + (line * lineHeight)
%assign line line+1

; weight = 0xFC
; weightMax = 0xFE
DrawWordStat 0xFC, 174, 72 + (line * lineHeight)

JMP 0x004A9200
