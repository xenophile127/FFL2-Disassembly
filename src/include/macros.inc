MACRO farcall
call executeFarcall
 dw \1
 db BANK(\1) + (BANK(\1) == 0)
ENDM
MACRO farcall2
call executeFarcall2
 dw \1
 db BANK(\1) + (BANK(\1) == 0)
ENDM
MACRO ld_long_load
db $FA
dw \2
ENDM
MACRO ld_long_store
db $EA
dw \1
ENDM
MACRO short_halt
db $76
ENDM
MACRO short_stop
db $10
ENDM
