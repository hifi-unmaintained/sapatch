; remove elf/human selection from character creation gump
@CLEAR 0x0044CBE7 0x00 0x0044CEE9
@JMP 0x0044CBE7 0x0044CEE9

; change GUILD button to CHAT in paperdoll 
@SETD 0x004A45CC 0x7E3
@SETD 0x004A45D1 0x7E2
@SETD 0x004A4600 0x7E4
@CLEAR 0x004CC4D0 0x90 0x004CC4D5 ; just to be more neat, latter converts to short jump
@JMP 0x004CC4D0 0x004CC480

; change QUESTS button to JOURNAL in paperdoll
@SETD 0x004A451D 0x7DD
@SETD 0x004A4522 0x7DC
@SETD 0x004A454E 0x7DE
@CLEAR 0x004CC4E0 0x90 0x004CC4E5
@JMP 0x004CC4E0 0x004CC3A0

; hide party manifest scroll
@JMP 0x004A5099 0x004A50CB
@JMP 0x004A64D4 0x004A64F9 ; hides one click tooltip

; hide headgear boxes from paperdoll
@JMP 0x004A51A7 0x004A521D
@CLEAR 0x004A63AE 0x90 0x004A63B3 ; disable tooltip on click
@CLEAR 0x004A5F6B 0x90 0x004A6128 ; clear dragging code away
@JMP 0x004A5F6B 0x004A6128 ; disable dragging of items (ok above already does this but this optimizes it by jumping)
