;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank02", ROMX[$4000], BANK[$02]

;@gfximg name=tiles1 width=2 height=64
data_02_4000:
    INCBIN "tiles1.bin"                                ;; 02:4000
;@gfximg name=tiles2 width=2 height=64
    INCBIN "tiles2.bin"                                ;; 02:4800
;@gfximg name=tiles3 width=2 height=64
    INCBIN "tiles3.bin"                                ;; 02:5000
;@gfximg name=tiles4 width=2 height=64
    INCBIN "tiles4.bin"                                ;; 02:5800
;@gfximg name=tiles5 width=2 height=64
    INCBIN "tiles5.bin"                                ;; 02:6000
;@gfximg name=tiles6 width=2 height=64
    INCBIN "tiles6.bin"                                ;; 02:6800
;@gfximg name=tiles7 width=2 height=64
    INCBIN "tiles7.bin"                                ;; 02:7000
;@gfximg name=tiles8 width=2 height=64
    INCBIN "tiles8.bin"                                ;; 02:7800
