;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank00", ROM0[$0000]

add_hl_a:
    push BC                                            ;; 00:0000 $c5
    ld   B, $00                                        ;; 00:0001 $06 $00
    ld   C, A                                          ;; 00:0003 $4f
    add  HL, BC                                        ;; 00:0004 $09
    pop  BC                                            ;; 00:0005 $c1
    ret                                                ;; 00:0006 $c9
    db   $00                                           ;; 00:0007 ?

rst_00_0008:
    jp   jp_00_0908                                    ;; 00:0008 $c3 $08 $09

pop_all:
    pop  HL                                            ;; 00:000b $e1
    pop  DE                                            ;; 00:000c $d1
    pop  BC                                            ;; 00:000d $c1
    pop  AF                                            ;; 00:000e $f1
    ret                                                ;; 00:000f $c9

; This waits for the VBlank period but also does some maintaince keeping on what
;   I think is shadow OAM. But, where it is called is usually interested in VBlank time
waitForVBlank:
    jp   waitForVBlankImpl                             ;; 00:0010 $c3 $d9 $00

data_00_0013:
    dw   LCDCInterruptHandler                          ;; 00:0013 pP
    db   $00, $00, $00                                 ;; 00:0015 ???

executeOAM_DMA:
    jp   hOAM_DMAHandler                               ;; 00:0018 $c3 $80 $ff
    db   $00, $00, $00, $00, $00                       ;; 00:001b ?????

rst_00_0020:
    jp   jp_00_0800                                    ;; 00:0020 $c3 $00 $08
    db   $00, $00, $00, $00, $00                       ;; 00:0023 ?????

;Switch bank to A, return old bank in A. Interrupt safe function
switchBankSafe:
    di                                                 ;; 00:0028 $f3
    call switchBankUnsafe                              ;; 00:0029 $cd $b1 $04
    reti                                               ;; 00:002c $d9
    db   $00, $00, $00                                 ;; 00:002d ???

rst_00_0030:
    jp   jp_00_0701                                    ;; 00:0030 $c3 $01 $07
    db   $00, $00, $00, $00, $00, $c3, $38             ;; 00:0033 ???????

SECTION "isrVBlank", ROM0[$0040]

isrVBlank:
    jp   wVBlankInterruptHandler                       ;; 00:0040 $c3 $03 $c7

SECTION "isrLCDC", ROM0[$0048]

isrLCDC:
    jp   wLCDCInterruptHandler                         ;; 00:0048 $c3 $06 $c7
    db   $87                                           ;; 00:004b ?

mul_a_32:
    add  A, A                                          ;; 00:004c $87

mul_a_16:
    add  A, A                                          ;; 00:004d $87
    add  A, A                                          ;; 00:004e $87
    add  A, A                                          ;; 00:004f $87
    add  A, A                                          ;; 00:0050 $87
    ret                                                ;; 00:0051 $c9
    db   $29, $29, $29, $29, $29, $29                  ;; 00:0052 ??????

SECTION "isrSerial", ROM0[$0058]

isrSerial:
    add  HL, HL                                        ;; 00:0058 $29
    ret                                                ;; 00:0059 $c9
    db   $29, $29                                      ;; 00:005a ??

mul_hl_32_add_bc:
    add  HL, HL                                        ;; 00:005c $29

mul_hl_16_add_bc:
    add  HL, HL                                        ;; 00:005d $29

mul_hl_8_add_bc:
    add  HL, HL                                        ;; 00:005e $29
    add  HL, HL                                        ;; 00:005f $29
    add  HL, HL                                        ;; 00:0060 $29
    add  HL, BC                                        ;; 00:0061 $09
    ret                                                ;; 00:0062 $c9

mul_hl_128_add_de:
    add  HL, HL                                        ;; 00:0063 $29
    add  HL, HL                                        ;; 00:0064 $29

mul_hl_32_add_de:
    add  HL, HL                                        ;; 00:0065 $29
    add  HL, HL                                        ;; 00:0066 $29

mul_hl_8_add_de:
    add  HL, HL                                        ;; 00:0067 $29
    add  HL, HL                                        ;; 00:0068 $29
    add  HL, HL                                        ;; 00:0069 $29
    add  HL, DE                                        ;; 00:006a $19
    ret                                                ;; 00:006b $c9

memclearSmall:
    xor  A, A                                          ;; 00:006c $af

memsetSmall:
    ld   [HL+], A                                      ;; 00:006d $22
    dec  B                                             ;; 00:006e $05
    jr   NZ, memsetSmall                               ;; 00:006f $20 $fc
    ret                                                ;; 00:0071 $c9

memclearBig:
    xor  A, A                                          ;; 00:0072 $af

memsetBig:
    push AF                                            ;; 00:0073 $f5
    push DE                                            ;; 00:0074 $d5
    ld   E, A                                          ;; 00:0075 $5f
.jr_00_0076:
    ld   [HL], E                                       ;; 00:0076 $73
    inc  HL                                            ;; 00:0077 $23
    dec  BC                                            ;; 00:0078 $0b
    ld   A, C                                          ;; 00:0079 $79
    or   A, B                                          ;; 00:007a $b0
    jr   NZ, .jr_00_0076                               ;; 00:007b $20 $f9
    pop  DE                                            ;; 00:007d $d1
    pop  AF                                            ;; 00:007e $f1
    ret                                                ;; 00:007f $c9

; Copy HL to DE, times B
memcopySmall:
    push AF                                            ;; 00:0080 $f5
.jr_00_0081:
    ld   A, [HL+]                                      ;; 00:0081 $2a
    ld   [DE], A                                       ;; 00:0082 $12
    inc  DE                                            ;; 00:0083 $13
    dec  B                                             ;; 00:0084 $05
    jr   NZ, .jr_00_0081                               ;; 00:0085 $20 $fa
    pop  AF                                            ;; 00:0087 $f1
    ret                                                ;; 00:0088 $c9

; Copy HL to DE, times BC
memcopyLarge:
    push AF                                            ;; 00:0089 $f5
.jr_00_008a:
    ld   A, [HL+]                                      ;; 00:008a $2a
    ld   [DE], A                                       ;; 00:008b $12
    inc  DE                                            ;; 00:008c $13
    dec  BC                                            ;; 00:008d $0b
    ld   A, C                                          ;; 00:008e $79
    or   A, B                                          ;; 00:008f $b0
    jr   NZ, .jr_00_008a                               ;; 00:0090 $20 $f8
    pop  AF                                            ;; 00:0092 $f1
    ret                                                ;; 00:0093 $c9

call_00_0094:
    call call_00_1674                                  ;; 00:0094 $cd $74 $16
    call memsetSmall                                   ;; 00:0097 $cd $6d $00
    jr   jr_00_00b2                                    ;; 00:009a $18 $16

call_00_009c:
    call call_00_1674                                  ;; 00:009c $cd $74 $16
    call memsetBig                                     ;; 00:009f $cd $73 $00
    jr   jr_00_00b2                                    ;; 00:00a2 $18 $0e

call_00_00a4:
    call call_00_1674                                  ;; 00:00a4 $cd $74 $16
    call memcopySmall                                  ;; 00:00a7 $cd $80 $00
    jr   jr_00_00b2                                    ;; 00:00aa $18 $06

call_00_00ac:
    call call_00_1674                                  ;; 00:00ac $cd $74 $16
    call memcopyLarge                                  ;; 00:00af $cd $89 $00

jr_00_00b2:
    jp   call_00_1691                                  ;; 00:00b2 $c3 $91 $16

memcopySmallFromBank:
    rst  switchBankSafe                                ;; 00:00b5 $ef
    push AF                                            ;; 00:00b6 $f5
    call memcopySmall                                  ;; 00:00b7 $cd $80 $00
    jr   jr_00_00cf                                    ;; 00:00ba $18 $13
    db   $ef, $f5, $cd, $89, $00, $18, $0c             ;; 00:00bc ???????

jp_00_00c3:
    rst  switchBankSafe                                ;; 00:00c3 $ef
    push AF                                            ;; 00:00c4 $f5
    call call_00_00a4                                  ;; 00:00c5 $cd $a4 $00
    jr   jr_00_00cf                                    ;; 00:00c8 $18 $05

call_00_00ca:
    rst  switchBankSafe                                ;; 00:00ca $ef
    push AF                                            ;; 00:00cb $f5
    call call_00_00ac                                  ;; 00:00cc $cd $ac $00

jr_00_00cf:
    pop  AF                                            ;; 00:00cf $f1
    rst  switchBankSafe                                ;; 00:00d0 $ef
    ret                                                ;; 00:00d1 $c9

; do: "ld a, [hl]" but with a different bank active.
readFromBank:
    push BC                                            ;; 00:00d2 $c5
    rst  switchBankSafe                                ;; 00:00d3 $ef
    ld   C, [HL]                                       ;; 00:00d4 $4e
    rst  switchBankSafe                                ;; 00:00d5 $ef
    ld   A, C                                          ;; 00:00d6 $79
    pop  BC                                            ;; 00:00d7 $c1
    ret                                                ;; 00:00d8 $c9

waitForVBlankImpl:
    push AF                                            ;; 00:00d9 $f5
    call call_00_06b0                                  ;; 00:00da $cd $b0 $06
.jr_00_00dd:
    short_halt                                         ;; 00:00dd $76
    ldh  A, [rLY]                                      ;; 00:00de $f0 $44
    cp   A, $90                                        ;; 00:00e0 $fe $90
    jr   C, .jr_00_00dd                                ;; 00:00e2 $38 $f9
    pop  AF                                            ;; 00:00e4 $f1
    ret                                                ;; 00:00e5 $c9
    db   $31, $00, $00, $c9, $3e, $00, $c3, $00        ;; 00:00e6 ........
    db   $00, $cb, $47, $c9                            ;; 00:00ee ....

;@code
oamDMAHandler:
    ldh  [rDMA], A                                     ;; 00:00f2 $e0 $46
    ld   A, $28                                        ;; 00:00f4 $3e $28
.delayloop:
    dec  A                                             ;; 00:00f6 $3d
    jr   NZ, .delayloop                                ;; 00:00f7 $20 $fd
    ret                                                ;; 00:00f9 $c9

SECTION "entry", ROM0[$0100]

entry:
    nop                                                ;; 00:0100 $00
    jp   init                                          ;; 00:0101 $c3 $00 $02
    ds   $30                                           ;; 00:0104
    db   "SAGA2", $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;; 00:0134
    db   CART_COMPATIBLE_DMG                           ;; 00:0143
    db   $00, $00                                      ;; 00:0144 ??
    db   CART_INDICATOR_GB                             ;; 00:0146
    db   CART_ROM_MBC1_RAM_BAT, CART_ROM_256KB, CART_SRAM_8KB ;; 00:0147
    db   CART_DEST_NON_JAPANESE, $c3, $00              ;; 00:014a $01 $c3 $00
    ds   3                                             ;; 00:014d

SECTION "bank00_0150", ROM0[$0150]

call_00_0150:
    jp   call_00_02f0                                  ;; 00:0150 $c3 $f0 $02
    db   $c3, $06, $03                                 ;; 00:0153 ???

call_00_0156:
    jp   call_00_0376                                  ;; 00:0156 $c3 $76 $03

call_00_0159:
    jp   call_00_038a                                  ;; 00:0159 $c3 $8a $03

call_00_015c:
    jp   jp_00_0321                                    ;; 00:015c $c3 $21 $03

call_00_015f:
    jp   jp_00_033f                                    ;; 00:015f $c3 $3f $03

call_00_0162:
    jp   call_00_0390                                  ;; 00:0162 $c3 $90 $03

call_00_0165:
    jp   call_00_03a6                                  ;; 00:0165 $c3 $a6 $03

call_00_0168:
    jp   call_00_03bc                                  ;; 00:0168 $c3 $bc $03

call_00_016b:
    jp   jp_00_043e                                    ;; 00:016b $c3 $3e $04

call_00_016e:
    jp   call_00_16f9                                  ;; 00:016e $c3 $f9 $16

call_00_0171:
    jp   call_00_0469                                  ;; 00:0171 $c3 $69 $04

call_00_0174:
    jp   jp_00_049d                                    ;; 00:0174 $c3 $9d $04

call_00_0177:
    jp   call_00_1674                                  ;; 00:0177 $c3 $74 $16

call_00_017a:
    jp   call_00_1691                                  ;; 00:017a $c3 $91 $16

;@FFLFarcall2
executeFarcall2:
    jp   executeFarcall                                ;; 00:017d $c3 $bf $04

call_00_0180:
    jp   jp_00_03dc                                    ;; 00:0180 $c3 $dc $03

call_00_0183:
    jp   jp_00_040b                                    ;; 00:0183 $c3 $0b $04

call_00_0186:
    jp   call_00_0af3                                  ;; 00:0186 $c3 $f3 $0a
    db   $c3, $6b, $16                                 ;; 00:0189 ???

call_00_018c:
    jp   jp_00_0615                                    ;; 00:018c $c3 $15 $06

call_00_018f:
    jp   jp_00_0621                                    ;; 00:018f $c3 $21 $06

call_00_0192:
    jp   call_00_063e                                  ;; 00:0192 $c3 $3e $06

call_00_0195:
    jp   jp_00_064a                                    ;; 00:0195 $c3 $4a $06

call_00_0198:
    jp   call_00_0608                                  ;; 00:0198 $c3 $08 $06

call_00_019b:
    jp   call_00_05d9                                  ;; 00:019b $c3 $d9 $05

call_00_019e:
    jp   call_00_055d                                  ;; 00:019e $c3 $5d $05

call_00_01a1:
    jp   jp_00_1884                                    ;; 00:01a1 $c3 $84 $18

call_00_01a4:
    jp   jp_00_188b                                    ;; 00:01a4 $c3 $8b $18

call_00_01a7:
    jp   jp_00_0494                                    ;; 00:01a7 $c3 $94 $04
    db   $c3, $b1, $04                                 ;; 00:01aa ???

call_00_01ad:
    jp   call_00_0a5c                                  ;; 00:01ad $c3 $5c $0a

call_00_01b0:
    jp   call_00_0546                                  ;; 00:01b0 $c3 $46 $05

call_00_01b3:
    jp   call_00_0533                                  ;; 00:01b3 $c3 $33 $05

call_00_01b6:
    jp   jp_00_0536                                    ;; 00:01b6 $c3 $36 $05

call_00_01b9:
    jp   call_00_18c3                                  ;; 00:01b9 $c3 $c3 $18

call_00_01bc:
    jp   call_00_05ef                                  ;; 00:01bc $c3 $ef $05

call_00_01bf:
    jp   call_00_14e3                                  ;; 00:01bf $c3 $e3 $14

jp_00_01c2:
    jp   call_00_151c                                  ;; 00:01c2 $c3 $1c $15

call_00_01c5:
    jp   jp_00_0901                                    ;; 00:01c5 $c3 $01 $09

call_00_01c8:
    jp   disableSRAM                                   ;; 00:01c8 $c3 $f4 $04

call_00_01cb:
    jp   enableSRAM                                    ;; 00:01cb $c3 $fb $04

call_00_01ce:
    jp   call_00_0a2b                                  ;; 00:01ce $c3 $2b $0a

jp_00_01d1:
    jp   jp_00_0ac2                                    ;; 00:01d1 $c3 $c2 $0a

call_00_01d4:
    jp   jp_00_18a7                                    ;; 00:01d4 $c3 $a7 $18

call_00_01d7:
    jp   jp_00_1892                                    ;; 00:01d7 $c3 $92 $18

call_00_01da:
    jp   jp_00_1899                                    ;; 00:01da $c3 $99 $18

call_00_01dd:
    jp   jp_00_18a0                                    ;; 00:01dd $c3 $a0 $18
    jp   jp_00_18ae                                    ;; 00:01e0 $c3 $ae $18

call_00_01e3:
    jp   jp_00_18b5                                    ;; 00:01e3 $c3 $b5 $18

call_00_01e6:
    jp   call_00_066e                                  ;; 00:01e6 $c3 $6e $06

call_00_01e9:
    jp   jp_00_14ac                                    ;; 00:01e9 $c3 $ac $14

call_00_01ec:
    jp   call_00_068a                                  ;; 00:01ec $c3 $8a $06

call_00_01ef:
    jp   call_00_0550                                  ;; 00:01ef $c3 $50 $05

call_00_01f2:
    jp   jp_00_06f4                                    ;; 00:01f2 $c3 $f4 $06
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:01f5 ????????
    db   $00, $00, $00                                 ;; 00:01fd ???

init:
    di                                                 ;; 00:0200 $f3
    ld   SP, wCF00                                     ;; 00:0201 $31 $00 $cf
    ld   A, $80                                        ;; 00:0204 $3e $80
    ldh  [rLCDC], A                                    ;; 00:0206 $e0 $40
    xor  A, A                                          ;; 00:0208 $af
    ldh  [rIF], A                                      ;; 00:0209 $e0 $0f
    ldh  [rIE], A                                      ;; 00:020b $e0 $ff
    ldh  [rSTAT], A                                    ;; 00:020d $e0 $41
    ldh  [rBGP], A                                     ;; 00:020f $e0 $47
    ldh  [rOBP0], A                                    ;; 00:0211 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:0213 $e0 $49
    ldh  [rSCX], A                                     ;; 00:0215 $e0 $43
    ldh  [rSCY], A                                     ;; 00:0217 $e0 $42
    ld   B, A                                          ;; 00:0219 $47
    ld   A, $1b                                        ;; 00:021a $3e $1b
    ld   HL, wC776                                     ;; 00:021c $21 $76 $c7
    push HL                                            ;; 00:021f $e5
    cp   A, [HL]                                       ;; 00:0220 $be
    inc  HL                                            ;; 00:0221 $23
    jr   NZ, .jr_00_0229                               ;; 00:0222 $20 $05
    cpl                                                ;; 00:0224 $2f
    cp   A, [HL]                                       ;; 00:0225 $be
    jr   NZ, .jr_00_0229                               ;; 00:0226 $20 $01
    inc  B                                             ;; 00:0228 $04
.jr_00_0229:
    push BC                                            ;; 00:0229 $c5
    ld   HL, wC000                                     ;; 00:022a $21 $00 $c0
    ld   B, $a0                                        ;; 00:022d $06 $a0
    call memclearSmall                                 ;; 00:022f $cd $6c $00
    ld   HL, wC100                                     ;; 00:0232 $21 $00 $c1
    ld   BC, $d00                                      ;; 00:0235 $01 $00 $0d
    call memclearBig                                   ;; 00:0238 $cd $72 $00
    ld   H, $cf                                        ;; 00:023b $26 $cf
    ld   B, $11                                        ;; 00:023d $06 $11
    call memclearBig                                   ;; 00:023f $cd $72 $00
    ld   HL, hOAM_DMAHandler                           ;; 00:0242 $21 $80 $ff
    ld   B, $7f                                        ;; 00:0245 $06 $7f
    call memclearSmall                                 ;; 00:0247 $cd $6c $00
    pop  BC                                            ;; 00:024a $c1
    pop  HL                                            ;; 00:024b $e1
    ld   A, $1b                                        ;; 00:024c $3e $1b
    ld   [HL+], A                                      ;; 00:024e $22
    cpl                                                ;; 00:024f $2f
    ld   [HL+], A                                      ;; 00:0250 $22
    ld   [HL], B                                       ;; 00:0251 $70
    inc  B                                             ;; 00:0252 $04
    dec  B                                             ;; 00:0253 $05
    jr   NZ, .jr_00_0262                               ;; 00:0254 $20 $0c
    ld   B, $40                                        ;; 00:0256 $06 $40
    ld   HL, wC0A0                                     ;; 00:0258 $21 $a0 $c0
    ldh  A, [rDIV]                                     ;; 00:025b $f0 $04
.jr_00_025d:
    ld   [HL+], A                                      ;; 00:025d $22
    inc  A                                             ;; 00:025e $3c
    dec  B                                             ;; 00:025f $05
    jr   NZ, .jr_00_025d                               ;; 00:0260 $20 $fb
.jr_00_0262:
    ld   HL, wC779                                     ;; 00:0262 $21 $79 $c7
    ld   [HL], $a0                                     ;; 00:0265 $36 $a0
    inc  HL                                            ;; 00:0267 $23
    ld   [HL], $cc                                     ;; 00:0268 $36 $cc
    ld   HL, oamDMAHandler ;@=ptr                      ;; 00:026a $21 $f2 $00
    ld   DE, hOAM_DMAHandler                           ;; 00:026d $11 $80 $ff
    ld   B, $08                                        ;; 00:0270 $06 $08
    call memcopySmall                                  ;; 00:0272 $cd $80 $00
    ld   HL, $e6                                       ;; 00:0275 $21 $e6 $00
    ld   DE, wC0E0                                     ;; 00:0278 $11 $e0 $c0
    ld   B, $0c                                        ;; 00:027b $06 $0c
    call memcopySmall                                  ;; 00:027d $cd $80 $00
    ld   A, $0e                                        ;; 00:0280 $3e $0e
    rst  switchBankSafe                                ;; 00:0282 $ef
    call initSoundEngine                               ;; 00:0283 $cd $03 $40
    di                                                 ;; 00:0286 $f3
    xor  A, A                                          ;; 00:0287 $af
    ldh  [rLYC], A                                     ;; 00:0288 $e0 $45
    ldh  [rIF], A                                      ;; 00:028a $e0 $0f
    ld   A, $03                                        ;; 00:028c $3e $03
    ldh  [rIE], A                                      ;; 00:028e $e0 $ff
    ld   A, $40                                        ;; 00:0290 $3e $40
    ldh  [rSTAT], A                                    ;; 00:0292 $e0 $41
    ld   HL, wVBlankInterruptHandler                   ;; 00:0294 $21 $03 $c7
    ld   A, $c3                                        ;; 00:0297 $3e $c3
    ld   [HL+], A                                      ;; 00:0299 $22
    ld   A, LOW(VBlankHandler) ;@=low VBlankHandler    ;; 00:029a $3e $df
    ld   [HL+], A                                      ;; 00:029c $22
    ld   A, HIGH(VBlankHandler) ;@=high VBlankHandler  ;; 00:029d $3e $16
    ld   [HL+], A                                      ;; 00:029f $22
    ld   HL, wLCDCInterruptHandler                     ;; 00:02a0 $21 $06 $c7
    ld   A, $c3                                        ;; 00:02a3 $3e $c3
    ld   [HL+], A                                      ;; 00:02a5 $22
    ld   A, LOW(LCDCInterruptHandler) ;@=low LCDCInterruptHandler ;; 00:02a6 $3e $d9
    ld   [HL+], A                                      ;; 00:02a8 $22
    ld   A, HIGH(LCDCInterruptHandler) ;@=high LCDCInterruptHandler ;; 00:02a9 $3e $16
    ld   [HL], A                                       ;; 00:02ab $77
    call call_00_0550                                  ;; 00:02ac $cd $50 $05
    ld   HL, $4800                                     ;; 00:02af $21 $00 $48
    ld   BC, $800                                      ;; 00:02b2 $01 $00 $08
    ld   A, $04                                        ;; 00:02b5 $3e $04
    call call_00_00ca                                  ;; 00:02b7 $cd $ca $00
    call enableSRAM                                    ;; 00:02ba $cd $fb $04
    ld   HL, sA781                                     ;; 00:02bd $21 $81 $a7
    ld   A, [HL+]                                      ;; 00:02c0 $2a
    cp   A, $1b                                        ;; 00:02c1 $fe $1b
    jr   NZ, .jr_00_02ca                               ;; 00:02c3 $20 $05
    ld   A, [HL]                                       ;; 00:02c5 $7e
    cp   A, $e4                                        ;; 00:02c6 $fe $e4
    jr   Z, .jr_00_02cf                                ;; 00:02c8 $28 $05
.jr_00_02ca:
    ld   A, $01                                        ;; 00:02ca $3e $01
    ld   [sA780], A                                    ;; 00:02cc $ea $80 $a7
.jr_00_02cf:
    call disableSRAM                                   ;; 00:02cf $cd $f4 $04
    ld   HL, wC200                                     ;; 00:02d2 $21 $00 $c2
    ld   C, $04                                        ;; 00:02d5 $0e $04
.jr_00_02d7:
    ld   B, $04                                        ;; 00:02d7 $06 $04
    ld   A, $ff                                        ;; 00:02d9 $3e $ff
    call memsetSmall                                   ;; 00:02db $cd $6d $00
    ld   A, $1c                                        ;; 00:02de $3e $1c
    rst  add_hl_a                                      ;; 00:02e0 $c7
    dec  C                                             ;; 00:02e1 $0d
    jr   NZ, .jr_00_02d7                               ;; 00:02e2 $20 $f3
    ld   A, $01                                        ;; 00:02e4 $3e $01
    rst  switchBankSafe                                ;; 00:02e6 $ef
    call call_01_500f                                  ;; 00:02e7 $cd $0f $50
    jp   NC, jp_00_1900                                ;; 00:02ea $d2 $00 $19
    jp   jp_00_1903                                    ;; 00:02ed $c3 $03 $19

call_00_02f0:
    push AF                                            ;; 00:02f0 $f5
    push BC                                            ;; 00:02f1 $c5
    ld   B, $08                                        ;; 00:02f2 $06 $08
    xor  A, A                                          ;; 00:02f4 $af
    ld   C, A                                          ;; 00:02f5 $4f
.jr_00_02f6:
    rr   H                                             ;; 00:02f6 $cb $1c
    jr   NC, .jr_00_02fb                               ;; 00:02f8 $30 $01
    add  A, L                                          ;; 00:02fa $85
.jr_00_02fb:
    rra                                                ;; 00:02fb $1f
    rr   C                                             ;; 00:02fc $cb $19
    dec  B                                             ;; 00:02fe $05
    jr   NZ, .jr_00_02f6                               ;; 00:02ff $20 $f5
    ld   H, A                                          ;; 00:0301 $67
    ld   L, C                                          ;; 00:0302 $69
    pop  BC                                            ;; 00:0303 $c1
    pop  AF                                            ;; 00:0304 $f1
    ret                                                ;; 00:0305 $c9

call_00_0306:
    push AF                                            ;; 00:0306 $f5
    push BC                                            ;; 00:0307 $c5
    ld   A, L                                          ;; 00:0308 $7d
    cpl                                                ;; 00:0309 $2f
    ld   C, A                                          ;; 00:030a $4f
    inc  C                                             ;; 00:030b $0c
    xor  A, A                                          ;; 00:030c $af
    ld   B, $08                                        ;; 00:030d $06 $08
.jr_00_030f:
    sla  H                                             ;; 00:030f $cb $24
    rla                                                ;; 00:0311 $17
    add  A, C                                          ;; 00:0312 $81
    jr   C, .jr_00_0317                                ;; 00:0313 $38 $02
    add  A, L                                          ;; 00:0315 $85
    inc  H                                             ;; 00:0316 $24
.jr_00_0317:
    dec  B                                             ;; 00:0317 $05
    jr   NZ, .jr_00_030f                               ;; 00:0318 $20 $f5
    ld   L, A                                          ;; 00:031a $6f
    ld   A, H                                          ;; 00:031b $7c
    cpl                                                ;; 00:031c $2f
    ld   H, A                                          ;; 00:031d $67
    pop  BC                                            ;; 00:031e $c1
    pop  AF                                            ;; 00:031f $f1
    ret                                                ;; 00:0320 $c9

jp_00_0321:
    push AF                                            ;; 00:0321 $f5
    push BC                                            ;; 00:0322 $c5
    ld   C, L                                          ;; 00:0323 $4d
    ld   B, H                                          ;; 00:0324 $44
    ld   HL, $00                                       ;; 00:0325 $21 $00 $00
    ld   A, $10                                        ;; 00:0328 $3e $10
.jr_00_032a:
    rr   D                                             ;; 00:032a $cb $1a
    rr   E                                             ;; 00:032c $cb $1b
    jr   NC, .jr_00_0331                               ;; 00:032e $30 $01
    add  HL, BC                                        ;; 00:0330 $09
.jr_00_0331:
    rr   H                                             ;; 00:0331 $cb $1c
    rr   L                                             ;; 00:0333 $cb $1d
    dec  A                                             ;; 00:0335 $3d
    jr   NZ, .jr_00_032a                               ;; 00:0336 $20 $f2
    rr   D                                             ;; 00:0338 $cb $1a
    rr   E                                             ;; 00:033a $cb $1b
    pop  BC                                            ;; 00:033c $c1
    pop  AF                                            ;; 00:033d $f1
    ret                                                ;; 00:033e $c9

jp_00_033f:
    di                                                 ;; 00:033f $f3
    push AF                                            ;; 00:0340 $f5
    push BC                                            ;; 00:0341 $c5
    ld   C, L                                          ;; 00:0342 $4d
    ld   B, H                                          ;; 00:0343 $44
    ld   HL, $36b                                      ;; 00:0344 $21 $6b $03
    push HL                                            ;; 00:0347 $e5
    ld   [wC0E1], SP                                   ;; 00:0348 $08 $e1 $c0
    ld   A, E                                          ;; 00:034b $7b
    cpl                                                ;; 00:034c $2f
    ld   L, A                                          ;; 00:034d $6f
    ld   A, D                                          ;; 00:034e $7a
    cpl                                                ;; 00:034f $2f
    ld   H, A                                          ;; 00:0350 $67
    inc  HL                                            ;; 00:0351 $23
    ld   SP, HL                                        ;; 00:0352 $f9
    ld   HL, $00                                       ;; 00:0353 $21 $00 $00
    ld   A, $10                                        ;; 00:0356 $3e $10
.jr_00_0358:
    sla  C                                             ;; 00:0358 $cb $21
    rl   B                                             ;; 00:035a $cb $10
    rl   L                                             ;; 00:035c $cb $15
    rl   H                                             ;; 00:035e $cb $14
    add  HL, SP                                        ;; 00:0360 $39
    jr   C, .jr_00_0365                                ;; 00:0361 $38 $02
    add  HL, DE                                        ;; 00:0363 $19
    inc  C                                             ;; 00:0364 $0c
.jr_00_0365:
    dec  A                                             ;; 00:0365 $3d
    jr   NZ, .jr_00_0358                               ;; 00:0366 $20 $f0
    jp   wC0E0                                         ;; 00:0368 $c3 $e0 $c0
    push HL                                            ;; 00:036b $e5
    ld   A, C                                          ;; 00:036c $79
    cpl                                                ;; 00:036d $2f
    ld   L, A                                          ;; 00:036e $6f
    ld   A, B                                          ;; 00:036f $78
    cpl                                                ;; 00:0370 $2f
    ld   H, A                                          ;; 00:0371 $67
    pop  DE                                            ;; 00:0372 $d1
    pop  BC                                            ;; 00:0373 $c1
    pop  AF                                            ;; 00:0374 $f1
    reti                                               ;; 00:0375 $d9

call_00_0376:
    ldh  [hFF90], A                                    ;; 00:0376 $e0 $90
    push DE                                            ;; 00:0378 $d5
    ld   A, L                                          ;; 00:0379 $7d
    sub  A, E                                          ;; 00:037a $93
    ld   L, A                                          ;; 00:037b $6f
    ld   A, H                                          ;; 00:037c $7c
    sbc  A, D                                          ;; 00:037d $9a
    ld   H, A                                          ;; 00:037e $67
    jr   C, .jr_00_0384                                ;; 00:037f $38 $03
    or   A, L                                          ;; 00:0381 $b5
    jr   .jr_00_0386                                   ;; 00:0382 $18 $02
.jr_00_0384:
    or   A, L                                          ;; 00:0384 $b5
    scf                                                ;; 00:0385 $37
.jr_00_0386:
    pop  DE                                            ;; 00:0386 $d1
    ldh  A, [hFF90]                                    ;; 00:0387 $f0 $90
    ret                                                ;; 00:0389 $c9

call_00_038a:
    push HL                                            ;; 00:038a $e5
    call call_00_0376                                  ;; 00:038b $cd $76 $03
    pop  HL                                            ;; 00:038e $e1
    ret                                                ;; 00:038f $c9

call_00_0390:
    ldh  [hFF90], A                                    ;; 00:0390 $e0 $90
    push DE                                            ;; 00:0392 $d5
    push HL                                            ;; 00:0393 $e5
    ld   A, [DE]                                       ;; 00:0394 $1a
    add  A, [HL]                                       ;; 00:0395 $86
    ld   [DE], A                                       ;; 00:0396 $12
    inc  DE                                            ;; 00:0397 $13
    inc  HL                                            ;; 00:0398 $23
    ld   A, [DE]                                       ;; 00:0399 $1a
    adc  A, [HL]                                       ;; 00:039a $8e
    ld   [DE], A                                       ;; 00:039b $12
    inc  DE                                            ;; 00:039c $13
    inc  HL                                            ;; 00:039d $23
    ld   A, [DE]                                       ;; 00:039e $1a
    adc  A, [HL]                                       ;; 00:039f $8e
    ld   [DE], A                                       ;; 00:03a0 $12
    pop  HL                                            ;; 00:03a1 $e1
    pop  DE                                            ;; 00:03a2 $d1
    ldh  A, [hFF90]                                    ;; 00:03a3 $f0 $90
    ret                                                ;; 00:03a5 $c9

call_00_03a6:
    ldh  [hFF90], A                                    ;; 00:03a6 $e0 $90
    push BC                                            ;; 00:03a8 $c5
    push DE                                            ;; 00:03a9 $d5
    push HL                                            ;; 00:03aa $e5
    ld   A, [DE]                                       ;; 00:03ab $1a
    sub  A, [HL]                                       ;; 00:03ac $96
    ld   [DE], A                                       ;; 00:03ad $12
    ld   C, A                                          ;; 00:03ae $4f
    inc  DE                                            ;; 00:03af $13
    inc  HL                                            ;; 00:03b0 $23
    ld   A, [DE]                                       ;; 00:03b1 $1a
    sbc  A, [HL]                                       ;; 00:03b2 $9e
    ld   [DE], A                                       ;; 00:03b3 $12
    ld   B, A                                          ;; 00:03b4 $47
    inc  DE                                            ;; 00:03b5 $13
    inc  HL                                            ;; 00:03b6 $23
    ld   A, [DE]                                       ;; 00:03b7 $1a
    sbc  A, [HL]                                       ;; 00:03b8 $9e
    ld   [DE], A                                       ;; 00:03b9 $12
    jr   jr_00_03cd                                    ;; 00:03ba $18 $11

call_00_03bc:
    ldh  [hFF90], A                                    ;; 00:03bc $e0 $90
    push BC                                            ;; 00:03be $c5
    push DE                                            ;; 00:03bf $d5
    push HL                                            ;; 00:03c0 $e5
    ld   A, [DE]                                       ;; 00:03c1 $1a
    sub  A, [HL]                                       ;; 00:03c2 $96
    ld   C, A                                          ;; 00:03c3 $4f
    inc  DE                                            ;; 00:03c4 $13
    inc  HL                                            ;; 00:03c5 $23
    ld   A, [DE]                                       ;; 00:03c6 $1a
    sbc  A, [HL]                                       ;; 00:03c7 $9e
    ld   B, A                                          ;; 00:03c8 $47
    inc  DE                                            ;; 00:03c9 $13
    inc  HL                                            ;; 00:03ca $23
    ld   A, [DE]                                       ;; 00:03cb $1a
    sbc  A, [HL]                                       ;; 00:03cc $9e

jr_00_03cd:
    jr   C, jr_00_03d3                                 ;; 00:03cd $38 $04
    or   A, C                                          ;; 00:03cf $b1
    or   A, B                                          ;; 00:03d0 $b0
    jr   jr_00_03d6                                    ;; 00:03d1 $18 $03

jr_00_03d3:
    or   A, C                                          ;; 00:03d3 $b1
    or   A, B                                          ;; 00:03d4 $b0
    scf                                                ;; 00:03d5 $37

jr_00_03d6:
    pop  HL                                            ;; 00:03d6 $e1
    pop  DE                                            ;; 00:03d7 $d1
    pop  BC                                            ;; 00:03d8 $c1
    ldh  A, [hFF90]                                    ;; 00:03d9 $f0 $90
    ret                                                ;; 00:03db $c9

jp_00_03dc:
    push AF                                            ;; 00:03dc $f5
    push BC                                            ;; 00:03dd $c5
    push DE                                            ;; 00:03de $d5
    push HL                                            ;; 00:03df $e5
    push DE                                            ;; 00:03e0 $d5
    ld   L, E                                          ;; 00:03e1 $6b
    ld   H, D                                          ;; 00:03e2 $62
    ld   E, [HL]                                       ;; 00:03e3 $5e
    inc  HL                                            ;; 00:03e4 $23
    ld   D, [HL]                                       ;; 00:03e5 $56
    inc  HL                                            ;; 00:03e6 $23
    ld   L, [HL]                                       ;; 00:03e7 $6e
    ld   H, A                                          ;; 00:03e8 $67
    ld   B, $18                                        ;; 00:03e9 $06 $18
    xor  A, A                                          ;; 00:03eb $af
.jr_00_03ec:
    rr   L                                             ;; 00:03ec $cb $1d
    rr   D                                             ;; 00:03ee $cb $1a
    rr   E                                             ;; 00:03f0 $cb $1b
    jr   NC, .jr_00_03f5                               ;; 00:03f2 $30 $01
    add  A, H                                          ;; 00:03f4 $84
.jr_00_03f5:
    rra                                                ;; 00:03f5 $1f
    dec  B                                             ;; 00:03f6 $05
    jr   NZ, .jr_00_03ec                               ;; 00:03f7 $20 $f3
    rr   L                                             ;; 00:03f9 $cb $1d
    rr   D                                             ;; 00:03fb $cb $1a
    rr   E                                             ;; 00:03fd $cb $1b
    ld   C, L                                          ;; 00:03ff $4d
    pop  HL                                            ;; 00:0400 $e1
    ld   [HL], E                                       ;; 00:0401 $73
    inc  HL                                            ;; 00:0402 $23
    ld   [HL], D                                       ;; 00:0403 $72
    inc  HL                                            ;; 00:0404 $23
    ld   [HL], C                                       ;; 00:0405 $71
    inc  HL                                            ;; 00:0406 $23
    ld   [HL], A                                       ;; 00:0407 $77
    jp   pop_all                                       ;; 00:0408 $c3 $0b $00

jp_00_040b:
    push BC                                            ;; 00:040b $c5
    push DE                                            ;; 00:040c $d5
    push HL                                            ;; 00:040d $e5
    ld   L, E                                          ;; 00:040e $6b
    ld   H, D                                          ;; 00:040f $62
    ld   C, A                                          ;; 00:0410 $4f
    cpl                                                ;; 00:0411 $2f
    ld   B, A                                          ;; 00:0412 $47
    inc  B                                             ;; 00:0413 $04
    push HL                                            ;; 00:0414 $e5
    ld   E, [HL]                                       ;; 00:0415 $5e
    inc  HL                                            ;; 00:0416 $23
    ld   D, [HL]                                       ;; 00:0417 $56
    inc  HL                                            ;; 00:0418 $23
    ld   A, [HL]                                       ;; 00:0419 $7e
    ld   H, C                                          ;; 00:041a $61
    ld   C, A                                          ;; 00:041b $4f
    xor  A, A                                          ;; 00:041c $af
    ld   L, $18                                        ;; 00:041d $2e $18

jr_00_041f:
    sla  E                                             ;; 00:041f $cb $23

call_00_0421:
    rl   D                                             ;; 00:0421 $cb $12
    rl   C                                             ;; 00:0423 $cb $11
    rla                                                ;; 00:0425 $17
    add  A, B                                          ;; 00:0426 $80
    jr   C, .jr_00_042b                                ;; 00:0427 $38 $02
    add  A, H                                          ;; 00:0429 $84
    inc  E                                             ;; 00:042a $1c
.jr_00_042b:
    dec  L                                             ;; 00:042b $2d
    jr   NZ, jr_00_041f                                ;; 00:042c $20 $f1
    pop  HL                                            ;; 00:042e $e1
    ld   B, A                                          ;; 00:042f $47
    ld   A, E                                          ;; 00:0430 $7b
    cpl                                                ;; 00:0431 $2f
    ld   [HL+], A                                      ;; 00:0432 $22
    ld   A, D                                          ;; 00:0433 $7a
    cpl                                                ;; 00:0434 $2f
    ld   [HL+], A                                      ;; 00:0435 $22
    ld   A, C                                          ;; 00:0436 $79
    cpl                                                ;; 00:0437 $2f
    ld   [HL], A                                       ;; 00:0438 $77
    ld   A, B                                          ;; 00:0439 $78
    pop  HL                                            ;; 00:043a $e1
    pop  DE                                            ;; 00:043b $d1
    pop  BC                                            ;; 00:043c $c1
    ret                                                ;; 00:043d $c9

jp_00_043e:
    push DE                                            ;; 00:043e $d5
    push HL                                            ;; 00:043f $e5
    ld   HL, wC0A0                                     ;; 00:0440 $21 $a0 $c0
    rst  add_hl_a                                      ;; 00:0443 $c7
    inc  [HL]                                          ;; 00:0444 $34
    ld   L, [HL]                                       ;; 00:0445 $6e
    ld   H, $40                                        ;; 00:0446 $26 $40
    ld   A, $0f                                        ;; 00:0448 $3e $0f
    rst  switchBankSafe                                ;; 00:044a $ef
    ld   H, [HL]                                       ;; 00:044b $66
    rst  switchBankSafe                                ;; 00:044c $ef
    ld   A, E                                          ;; 00:044d $7b
    cp   A, $ff                                        ;; 00:044e $fe $ff
    jr   Z, .jr_00_0466                                ;; 00:0450 $28 $14
    ld   A, D                                          ;; 00:0452 $7a
    and  A, A                                          ;; 00:0453 $a7
    jr   Z, .jr_00_0466                                ;; 00:0454 $28 $10
    cp   A, E                                          ;; 00:0456 $bb
    jr   Z, .jr_00_0466                                ;; 00:0457 $28 $0d
    sub  A, E                                          ;; 00:0459 $93
    ld   L, A                                          ;; 00:045a $6f
    cp   A, $ff                                        ;; 00:045b $fe $ff
    ld   A, H                                          ;; 00:045d $7c
    jr   Z, .jr_00_0465                                ;; 00:045e $28 $05
    inc  L                                             ;; 00:0460 $2c
    call call_00_0306                                  ;; 00:0461 $cd $06 $03
    ld   A, L                                          ;; 00:0464 $7d
.jr_00_0465:
    add  A, E                                          ;; 00:0465 $83
.jr_00_0466:
    pop  HL                                            ;; 00:0466 $e1
    pop  DE                                            ;; 00:0467 $d1
    ret                                                ;; 00:0468 $c9

call_00_0469:
    ldh  A, [hFF89]                                    ;; 00:0469 $f0 $89
    ld   C, A                                          ;; 00:046b $4f
    ld   A, [wC775]                                    ;; 00:046c $fa $75 $c7
    cp   A, C                                          ;; 00:046f $b9
    jr   NZ, .jr_00_0488                               ;; 00:0470 $20 $16
    ld   A, [wC774]                                    ;; 00:0472 $fa $74 $c7
    dec  A                                             ;; 00:0475 $3d
    jr   Z, .jr_00_047f                                ;; 00:0476 $28 $07
    ld   [wC774], A                                    ;; 00:0478 $ea $74 $c7
    xor  A, A                                          ;; 00:047b $af
    ldh  [hFF8A], A                                    ;; 00:047c $e0 $8a
    ret                                                ;; 00:047e $c9
.jr_00_047f:
    ld   A, $05                                        ;; 00:047f $3e $05
    ld   [wC774], A                                    ;; 00:0481 $ea $74 $c7
    ld   A, C                                          ;; 00:0484 $79
    ldh  [hFF8A], A                                    ;; 00:0485 $e0 $8a
    ret                                                ;; 00:0487 $c9
.jr_00_0488:
    ld   A, $1e                                        ;; 00:0488 $3e $1e
    ld   [wC774], A                                    ;; 00:048a $ea $74 $c7
    ld   A, C                                          ;; 00:048d $79
    ldh  [hFF8A], A                                    ;; 00:048e $e0 $8a
    ld   [wC775], A                                    ;; 00:0490 $ea $75 $c7
    ret                                                ;; 00:0493 $c9

jp_00_0494:
    call call_00_0469                                  ;; 00:0494 $cd $69 $04
    call call_00_068f                                  ;; 00:0497 $cd $8f $06
    ldh  A, [hFF8A]                                    ;; 00:049a $f0 $8a
    ret                                                ;; 00:049c $c9

jp_00_049d:
    push AF                                            ;; 00:049d $f5
.jr_00_049e:
    rst  waitForVBlank                                 ;; 00:049e $d7
    ldh  A, [hFF89]                                    ;; 00:049f $f0 $89
    and  A, A                                          ;; 00:04a1 $a7
    jr   NZ, .jr_00_049e                               ;; 00:04a2 $20 $fa
    pop  AF                                            ;; 00:04a4 $f1
    ret                                                ;; 00:04a5 $c9

call_00_04a6:
    push AF                                            ;; 00:04a6 $f5
.jr_00_04a7:
    call call_00_068f                                  ;; 00:04a7 $cd $8f $06
    ldh  A, [hFF89]                                    ;; 00:04aa $f0 $89
    and  A, A                                          ;; 00:04ac $a7
    jr   NZ, .jr_00_04a7                               ;; 00:04ad $20 $f8
    pop  AF                                            ;; 00:04af $f1
    ret                                                ;; 00:04b0 $c9

;Switch to bank A, return old bank in A, not interrupt safe
switchBankUnsafe:
    push BC                                            ;; 00:04b1 $c5
    ld   C, A                                          ;; 00:04b2 $4f
    ldh  A, [hCurrentBank]                             ;; 00:04b3 $f0 $88
    ld   B, A                                          ;; 00:04b5 $47
    ld   A, C                                          ;; 00:04b6 $79
    ldh  [hCurrentBank], A                             ;; 00:04b7 $e0 $88
    ld   [$2100], A                                    ;; 00:04b9 $ea $00 $21
    ld   A, B                                          ;; 00:04bc $78
    pop  BC                                            ;; 00:04bd $c1
    ret                                                ;; 00:04be $c9

; The 3 bytes after this instruction indicate which bank and address to call
;@FFLFarcall
executeFarcall:
    push AF                                            ;; 00:04bf $f5
    push HL                                            ;; 00:04c0 $e5
    push DE                                            ;; 00:04c1 $d5
    ld   HL, SP+6                                      ;; 00:04c2 $f8 $06
    ld   A, [HL]                                       ;; 00:04c4 $7e
    ld   E, A                                          ;; 00:04c5 $5f
    add  A, $03                                        ;; 00:04c6 $c6 $03
    ld   [HL+], A                                      ;; 00:04c8 $22
    ld   D, [HL]                                       ;; 00:04c9 $56
    jr   NC, .jr_00_04cd                               ;; 00:04ca $30 $01
    inc  [HL]                                          ;; 00:04cc $34
.jr_00_04cd:
    ld   L, E                                          ;; 00:04cd $6b
    ld   H, D                                          ;; 00:04ce $62
    ld   A, [HL+]                                      ;; 00:04cf $2a
    ld   [wC0E7], A                                    ;; 00:04d0 $ea $e7 $c0
    ld   A, [HL+]                                      ;; 00:04d3 $2a
    ld   [wC0E8], A                                    ;; 00:04d4 $ea $e8 $c0
    ld   A, [HL]                                       ;; 00:04d7 $7e
    rst  switchBankSafe                                ;; 00:04d8 $ef
    ld   E, A                                          ;; 00:04d9 $5f
    ld   HL, SP+5                                      ;; 00:04da $f8 $05
    ld   A, [HL]                                       ;; 00:04dc $7e
    di                                                 ;; 00:04dd $f3
    ld   [HL], E                                       ;; 00:04de $73
    ld   [wC0E5], A                                    ;; 00:04df $ea $e5 $c0
    pop  DE                                            ;; 00:04e2 $d1
    pop  HL                                            ;; 00:04e3 $e1
    pop  AF                                            ;; 00:04e4 $f1
    dec  SP                                            ;; 00:04e5 $3b
    ei                                                 ;; 00:04e6 $fb
    call $c0e4                                         ;; 00:04e7 $cd $e4 $c0
    push AF                                            ;; 00:04ea $f5
    push HL                                            ;; 00:04eb $e5
    ld   HL, SP+4                                      ;; 00:04ec $f8 $04
    ld   A, [HL]                                       ;; 00:04ee $7e
    rst  switchBankSafe                                ;; 00:04ef $ef
    pop  HL                                            ;; 00:04f0 $e1
    pop  AF                                            ;; 00:04f1 $f1
    inc  SP                                            ;; 00:04f2 $33
    ret                                                ;; 00:04f3 $c9

disableSRAM:
    push AF                                            ;; 00:04f4 $f5
    xor  A, A                                          ;; 00:04f5 $af
    ld   [$0000], A                                    ;; 00:04f6 $ea $00 $00
    pop  AF                                            ;; 00:04f9 $f1
    reti                                               ;; 00:04fa $d9

enableSRAM:
    di                                                 ;; 00:04fb $f3
    push AF                                            ;; 00:04fc $f5
    ld   A, $0a                                        ;; 00:04fd $3e $0a
    ld   [$0000], A                                    ;; 00:04ff $ea $00 $00
    pop  AF                                            ;; 00:0502 $f1
    ret                                                ;; 00:0503 $c9

call_00_0504:
    push BC                                            ;; 00:0504 $c5
    ld   B, A                                          ;; 00:0505 $47
    ld   A, C                                          ;; 00:0506 $79
    ld   C, $47                                        ;; 00:0507 $0e $47
    jr   jr_00_0517                                    ;; 00:0509 $18 $0c

call_00_050b:
    push BC                                            ;; 00:050b $c5
    ld   B, A                                          ;; 00:050c $47
    ld   A, C                                          ;; 00:050d $79
    ld   C, $c7                                        ;; 00:050e $0e $c7
    jr   jr_00_0517                                    ;; 00:0510 $18 $05
    db   $c5, $47, $79, $0e, $87                       ;; 00:0512 ?????

jr_00_0517:
    and  A, $07                                        ;; 00:0517 $e6 $07
    rlca                                               ;; 00:0519 $07
    rlca                                               ;; 00:051a $07
    rlca                                               ;; 00:051b $07
    or   A, C                                          ;; 00:051c $b1
    ld   [wC0EA], A                                    ;; 00:051d $ea $ea $c0
    ld   A, B                                          ;; 00:0520 $78
    call $c0e9                                         ;; 00:0521 $cd $e9 $c0
    pop  BC                                            ;; 00:0524 $c1
    ret                                                ;; 00:0525 $c9

call_00_0526:
    push AF                                            ;; 00:0526 $f5
    ld   A, D                                          ;; 00:0527 $7a
    add  A, A                                          ;; 00:0528 $87
    add  A, A                                          ;; 00:0529 $87
    add  A, A                                          ;; 00:052a $87
    ld   D, A                                          ;; 00:052b $57
    ld   A, E                                          ;; 00:052c $7b
    add  A, A                                          ;; 00:052d $87
    add  A, A                                          ;; 00:052e $87
    add  A, A                                          ;; 00:052f $87
    ld   E, A                                          ;; 00:0530 $5f
    pop  AF                                            ;; 00:0531 $f1
    ret                                                ;; 00:0532 $c9

call_00_0533:
    xor  A, A                                          ;; 00:0533 $af
    ldh  [hFF9B], A                                    ;; 00:0534 $e0 $9b

jp_00_0536:
    xor  A, A                                          ;; 00:0536 $af
    ld   [wC7CA], A                                    ;; 00:0537 $ea $ca $c7
    ld   [wC7CF], A                                    ;; 00:053a $ea $cf $c7
    dec  A                                             ;; 00:053d $3d
    ld   B, $80                                        ;; 00:053e $06 $80
    ld   HL, wC380                                     ;; 00:0540 $21 $80 $c3
    jp   memsetSmall                                   ;; 00:0543 $c3 $6d $00

call_00_0546:
    ld   HL, hFF97                                     ;; 00:0546 $21 $97 $ff
    ld   A, $ff                                        ;; 00:0549 $3e $ff
    ld   [HL+], A                                      ;; 00:054b $22
    ld   [HL+], A                                      ;; 00:054c $22
    ld   [HL+], A                                      ;; 00:054d $22
    ld   [HL], A                                       ;; 00:054e $77
    ret                                                ;; 00:054f $c9

call_00_0550:
    ld   HL, $7f00                                     ;; 00:0550 $21 $00 $7f
    ld   DE, $8700                                     ;; 00:0553 $11 $00 $87
    ld   B, $00                                        ;; 00:0556 $06 $00
    ld   A, $03                                        ;; 00:0558 $3e $03
    jp   jp_00_00c3                                    ;; 00:055a $c3 $c3 $00

call_00_055d:
    ldh  [hFF90], A                                    ;; 00:055d $e0 $90
    ld   A, $0d                                        ;; 00:055f $3e $0d
    rst  switchBankSafe                                ;; 00:0561 $ef
    push AF                                            ;; 00:0562 $f5
    ldh  A, [hFF90]                                    ;; 00:0563 $f0 $90
    ld   L, A                                          ;; 00:0565 $6f
    ld   H, $0a                                        ;; 00:0566 $26 $0a
    call call_00_02f0                                  ;; 00:0568 $cd $f0 $02
    ld   DE, data_0d_6f80                              ;; 00:056b $11 $80 $6f
    add  HL, DE                                        ;; 00:056e $19
    push HL                                            ;; 00:056f $e5
    ld   A, [wC709]                                    ;; 00:0570 $fa $09 $c7
    ld   HL, wC204                                     ;; 00:0573 $21 $04 $c2
    call call_00_05d9                                  ;; 00:0576 $cd $d9 $05
    ld   E, L                                          ;; 00:0579 $5d
    ld   D, H                                          ;; 00:057a $54
    ldh  A, [hFF90]                                    ;; 00:057b $f0 $90
    ld   [DE], A                                       ;; 00:057d $12
    inc  DE                                            ;; 00:057e $13
    pop  HL                                            ;; 00:057f $e1
    ld   A, [HL+]                                      ;; 00:0580 $2a
    inc  HL                                            ;; 00:0581 $23
    ldh  [hFF92], A                                    ;; 00:0582 $e0 $92
    swap A                                             ;; 00:0584 $cb $37
    and  A, $0f                                        ;; 00:0586 $e6 $0f
    ld   [DE], A                                       ;; 00:0588 $12
    ldh  [hFF91], A                                    ;; 00:0589 $e0 $91
    inc  DE                                            ;; 00:058b $13
    xor  A, A                                          ;; 00:058c $af
    ld   [DE], A                                       ;; 00:058d $12
    inc  DE                                            ;; 00:058e $13
    ld   C, [HL]                                       ;; 00:058f $4e
    inc  HL                                            ;; 00:0590 $23
    ld   B, [HL]                                       ;; 00:0591 $46
    inc  HL                                            ;; 00:0592 $23
    ld   A, C                                          ;; 00:0593 $79
    ld   [DE], A                                       ;; 00:0594 $12
    inc  DE                                            ;; 00:0595 $13
    ld   A, B                                          ;; 00:0596 $78
    ld   [DE], A                                       ;; 00:0597 $12
    inc  DE                                            ;; 00:0598 $13
    ld   A, C                                          ;; 00:0599 $79
    ld   [DE], A                                       ;; 00:059a $12
    inc  DE                                            ;; 00:059b $13
    ld   A, B                                          ;; 00:059c $78
    ld   [DE], A                                       ;; 00:059d $12
    inc  DE                                            ;; 00:059e $13
    ld   B, $04                                        ;; 00:059f $06 $04
    call memcopySmall                                  ;; 00:05a1 $cd $80 $00
    ldh  A, [hFF92]                                    ;; 00:05a4 $f0 $92
    and  A, $07                                        ;; 00:05a6 $e6 $07
    inc  A                                             ;; 00:05a8 $3c
    ld   B, A                                          ;; 00:05a9 $47
    ldh  [hFF90], A                                    ;; 00:05aa $e0 $90
    ld   A, [HL+]                                      ;; 00:05ac $2a
    ld   H, [HL]                                       ;; 00:05ad $66
    ld   L, A                                          ;; 00:05ae $6f
    push DE                                            ;; 00:05af $d5
.jr_00_05b0:
    ld   A, [HL+]                                      ;; 00:05b0 $2a
    ld   [DE], A                                       ;; 00:05b1 $12
    inc  DE                                            ;; 00:05b2 $13
    inc  DE                                            ;; 00:05b3 $13
    dec  B                                             ;; 00:05b4 $05
    jr   NZ, .jr_00_05b0                               ;; 00:05b5 $20 $f9
    pop  DE                                            ;; 00:05b7 $d1
    ld   A, $0c                                        ;; 00:05b8 $3e $0c
    rst  switchBankSafe                                ;; 00:05ba $ef
    ldh  A, [hFF90]                                    ;; 00:05bb $f0 $90
    ld   B, A                                          ;; 00:05bd $47
.jr_00_05be:
    ld   A, [DE]                                       ;; 00:05be $1a
    inc  DE                                            ;; 00:05bf $13
    ld   HL, data_0c_7e80                              ;; 00:05c0 $21 $80 $7e
    rst  add_hl_a                                      ;; 00:05c3 $c7
    ldh  A, [hFF91]                                    ;; 00:05c4 $f0 $91
    cp   A, $03                                        ;; 00:05c6 $fe $03
    ld   A, [HL]                                       ;; 00:05c8 $7e
    jr   NZ, .jr_00_05d1                               ;; 00:05c9 $20 $06
    cp   A, $fe                                        ;; 00:05cb $fe $fe
    jr   Z, .jr_00_05d1                                ;; 00:05cd $28 $02
    srl  A                                             ;; 00:05cf $cb $3f
.jr_00_05d1:
    ld   [DE], A                                       ;; 00:05d1 $12
    inc  DE                                            ;; 00:05d2 $13
    dec  B                                             ;; 00:05d3 $05
    jr   NZ, .jr_00_05be                               ;; 00:05d4 $20 $e8
    pop  AF                                            ;; 00:05d6 $f1
    rst  switchBankSafe                                ;; 00:05d7 $ef
    ret                                                ;; 00:05d8 $c9

call_00_05d9:
    push BC                                            ;; 00:05d9 $c5
    ld   B, A                                          ;; 00:05da $47
    ldh  A, [hFF8B]                                    ;; 00:05db $f0 $8b
    and  A, A                                          ;; 00:05dd $a7
    jr   Z, .jr_00_05e5                                ;; 00:05de $28 $05
    ld   A, B                                          ;; 00:05e0 $78
    add  A, H                                          ;; 00:05e1 $84
    ld   H, A                                          ;; 00:05e2 $67
    jr   .jr_00_05ed                                   ;; 00:05e3 $18 $08
.jr_00_05e5:
    ld   A, B                                          ;; 00:05e5 $78
    call call_00_05ef                                  ;; 00:05e6 $cd $ef $05
    call mul_a_32                                      ;; 00:05e9 $cd $4c $00
    rst  add_hl_a                                      ;; 00:05ec $c7
.jr_00_05ed:
    pop  BC                                            ;; 00:05ed $c1
    ret                                                ;; 00:05ee $c9

call_00_05ef:
    push BC                                            ;; 00:05ef $c5
    cp   A, $04                                        ;; 00:05f0 $fe $04
    jr   C, .jr_00_05f8                                ;; 00:05f2 $38 $04
    ld   A, $04                                        ;; 00:05f4 $3e $04
    jr   .jr_00_0606                                   ;; 00:05f6 $18 $0e
.jr_00_05f8:
    ld   B, A                                          ;; 00:05f8 $47
    inc  B                                             ;; 00:05f9 $04
    ld   A, [wC2A0]                                    ;; 00:05fa $fa $a0 $c2
    rlca                                               ;; 00:05fd $07
    rlca                                               ;; 00:05fe $07
.jr_00_05ff:
    rrca                                               ;; 00:05ff $0f
    rrca                                               ;; 00:0600 $0f
    dec  B                                             ;; 00:0601 $05
    jr   NZ, .jr_00_05ff                               ;; 00:0602 $20 $fb
    and  A, $03                                        ;; 00:0604 $e6 $03
.jr_00_0606:
    pop  BC                                            ;; 00:0606 $c1
    ret                                                ;; 00:0607 $c9

call_00_0608:
    ldh  [hFF90], A                                    ;; 00:0608 $e0 $90
    push DE                                            ;; 00:060a $d5
    ld   E, $00                                        ;; 00:060b $1e $00
    call call_00_063e                                  ;; 00:060d $cd $3e $06
    and  A, A                                          ;; 00:0610 $a7
    pop  DE                                            ;; 00:0611 $d1
    ldh  A, [hFF90]                                    ;; 00:0612 $f0 $90
    ret                                                ;; 00:0614 $c9

jp_00_0615:
    push BC                                            ;; 00:0615 $c5
    push HL                                            ;; 00:0616 $e5
    call call_00_062e                                  ;; 00:0617 $cd $2e $06
    ld   A, [HL]                                       ;; 00:061a $7e
    call call_00_0504                                  ;; 00:061b $cd $04 $05
    pop  HL                                            ;; 00:061e $e1
    pop  BC                                            ;; 00:061f $c1
    ret                                                ;; 00:0620 $c9

jp_00_0621:
    push BC                                            ;; 00:0621 $c5
    push HL                                            ;; 00:0622 $e5
    call call_00_062e                                  ;; 00:0623 $cd $2e $06
    ld   A, [HL]                                       ;; 00:0626 $7e
    call call_00_050b                                  ;; 00:0627 $cd $0b $05
    ld   [HL], A                                       ;; 00:062a $77
    pop  HL                                            ;; 00:062b $e1
    pop  BC                                            ;; 00:062c $c1
    ret                                                ;; 00:062d $c9

call_00_062e:
    ld   C, A                                          ;; 00:062e $4f
    srl  A                                             ;; 00:062f $cb $3f
    srl  A                                             ;; 00:0631 $cb $3f
    srl  A                                             ;; 00:0633 $cb $3f
    ld   HL, wC306                                     ;; 00:0635 $21 $06 $c3
    rst  add_hl_a                                      ;; 00:0638 $c7
    ld   A, C                                          ;; 00:0639 $79
    and  A, $07                                        ;; 00:063a $e6 $07
    ld   C, A                                          ;; 00:063c $4f
    ret                                                ;; 00:063d $c9

call_00_063e:
    push HL                                            ;; 00:063e $e5
    call call_00_0661                                  ;; 00:063f $cd $61 $06
    jr   C, .jr_00_0646                                ;; 00:0642 $38 $02
    swap A                                             ;; 00:0644 $cb $37
.jr_00_0646:
    and  A, $0f                                        ;; 00:0646 $e6 $0f
    pop  HL                                            ;; 00:0648 $e1
    ret                                                ;; 00:0649 $c9

jp_00_064a:
    push DE                                            ;; 00:064a $d5
    push HL                                            ;; 00:064b $e5
    and  A, $0f                                        ;; 00:064c $e6 $0f
    ld   D, A                                          ;; 00:064e $57
    call call_00_0661                                  ;; 00:064f $cd $61 $06
    jr   C, .jr_00_065a                                ;; 00:0652 $38 $06
    and  A, $0f                                        ;; 00:0654 $e6 $0f
    swap D                                             ;; 00:0656 $cb $32
    jr   .jr_00_065c                                   ;; 00:0658 $18 $02
.jr_00_065a:
    and  A, $f0                                        ;; 00:065a $e6 $f0
.jr_00_065c:
    or   A, D                                          ;; 00:065c $b2
    ld   [HL], A                                       ;; 00:065d $77
    pop  HL                                            ;; 00:065e $e1
    pop  DE                                            ;; 00:065f $d1
    ret                                                ;; 00:0660 $c9

call_00_0661:
    ld   A, E                                          ;; 00:0661 $7b
    and  A, $1f                                        ;; 00:0662 $e6 $1f
    srl  A                                             ;; 00:0664 $cb $3f
    push AF                                            ;; 00:0666 $f5
    ld   HL, wC2F6                                     ;; 00:0667 $21 $f6 $c2
    rst  add_hl_a                                      ;; 00:066a $c7
    pop  AF                                            ;; 00:066b $f1
    ld   A, [HL]                                       ;; 00:066c $7e
    ret                                                ;; 00:066d $c9

call_00_066e:
    push BC                                            ;; 00:066e $c5
    push HL                                            ;; 00:066f $e5
    call call_00_0679                                  ;; 00:0670 $cd $79 $06
    call call_00_0504                                  ;; 00:0673 $cd $04 $05
    pop  HL                                            ;; 00:0676 $e1
    pop  BC                                            ;; 00:0677 $c1
    ret                                                ;; 00:0678 $c9

call_00_0679:
    ld   A, D                                          ;; 00:0679 $7a
    add  A, A                                          ;; 00:067a $87
    ld   HL, wC31D                                     ;; 00:067b $21 $1d $c3
    rst  add_hl_a                                      ;; 00:067e $c7
    bit  3, E                                          ;; 00:067f $cb $5b
    jr   Z, .jr_00_0684                                ;; 00:0681 $28 $01
    inc  HL                                            ;; 00:0683 $23
.jr_00_0684:
    ld   A, E                                          ;; 00:0684 $7b
    and  A, $07                                        ;; 00:0685 $e6 $07
    ld   C, A                                          ;; 00:0687 $4f
    ld   A, [HL]                                       ;; 00:0688 $7e
    ret                                                ;; 00:0689 $c9

call_00_068a:
    ld   A, [wC7DF]                                    ;; 00:068a $fa $df $c7
    rst  executeOAM_DMA                                ;; 00:068d $df
    ret                                                ;; 00:068e $c9

call_00_068f:
    push AF                                            ;; 00:068f $f5
    push BC                                            ;; 00:0690 $c5
    rst  waitForVBlank                                 ;; 00:0691 $d7
    ld   C, $cc                                        ;; 00:0692 $0e $cc
    ldh  A, [hFF8B]                                    ;; 00:0694 $f0 $8b
    and  A, A                                          ;; 00:0696 $a7
    jr   NZ, .jr_00_06ab                               ;; 00:0697 $20 $12
    ld   A, [wC764]                                    ;; 00:0699 $fa $64 $c7
    and  A, A                                          ;; 00:069c $a7
    jr   NZ, .jr_00_06ab                               ;; 00:069d $20 $0c
    ldh  A, [hFF96]                                    ;; 00:069f $f0 $96
    rrca                                               ;; 00:06a1 $0f
    jr   C, .jr_00_06ab                                ;; 00:06a2 $38 $07
    rrca                                               ;; 00:06a4 $0f
    jr   C, .jr_00_06ab                                ;; 00:06a5 $38 $04
    ld   A, [wC7DF]                                    ;; 00:06a7 $fa $df $c7
    ld   C, A                                          ;; 00:06aa $4f
.jr_00_06ab:
    ld   A, C                                          ;; 00:06ab $79
    rst  executeOAM_DMA                                ;; 00:06ac $df
    pop  BC                                            ;; 00:06ad $c1
    pop  AF                                            ;; 00:06ae $f1
    ret                                                ;; 00:06af $c9

call_00_06b0:
    push BC                                            ;; 00:06b0 $c5
    push DE                                            ;; 00:06b1 $d5
    push HL                                            ;; 00:06b2 $e5
    ld   HL, wC4FF                                     ;; 00:06b3 $21 $ff $c4
    inc  [HL]                                          ;; 00:06b6 $34
    ld   A, [HL]                                       ;; 00:06b7 $7e
    ld   HL, wC000                                     ;; 00:06b8 $21 $00 $c0
    and  A, $10                                        ;; 00:06bb $e6 $10
    swap A                                             ;; 00:06bd $cb $37
    or   A, H                                          ;; 00:06bf $b4
    ld   H, A                                          ;; 00:06c0 $67
    ld   [wC7DF], A                                    ;; 00:06c1 $ea $df $c7
    ld   A, [wC7DE]                                    ;; 00:06c4 $fa $de $c7
    and  A, A                                          ;; 00:06c7 $a7
    jr   Z, .jr_00_06f0                                ;; 00:06c8 $28 $26
    ld   B, $28                                        ;; 00:06ca $06 $28
    ldh  A, [hFF96]                                    ;; 00:06cc $f0 $96
    and  A, A                                          ;; 00:06ce $a7
    jr   Z, .jr_00_06d3                                ;; 00:06cf $28 $02
    ld   B, $24                                        ;; 00:06d1 $06 $24
.jr_00_06d3:
    ld   C, $5a                                        ;; 00:06d3 $0e $5a
    ld   DE, wCC00                                     ;; 00:06d5 $11 $00 $cc
.jr_00_06d8:
    ld   A, [HL+]                                      ;; 00:06d8 $2a
    cp   A, C                                          ;; 00:06d9 $b9
    jr   C, .jr_00_06dd                                ;; 00:06da $38 $01
    xor  A, A                                          ;; 00:06dc $af
.jr_00_06dd:
    ld   [DE], A                                       ;; 00:06dd $12
    inc  E                                             ;; 00:06de $1c
    ld   A, [HL+]                                      ;; 00:06df $2a
    ld   [DE], A                                       ;; 00:06e0 $12
    inc  E                                             ;; 00:06e1 $1c
    ld   A, [HL+]                                      ;; 00:06e2 $2a
    ld   [DE], A                                       ;; 00:06e3 $12
    inc  E                                             ;; 00:06e4 $1c
    ld   A, [HL+]                                      ;; 00:06e5 $2a
    ld   [DE], A                                       ;; 00:06e6 $12
    inc  E                                             ;; 00:06e7 $1c
    dec  B                                             ;; 00:06e8 $05
    jr   NZ, .jr_00_06d8                               ;; 00:06e9 $20 $ed
    ld   A, $cc                                        ;; 00:06eb $3e $cc
    ld   [wC7DF], A                                    ;; 00:06ed $ea $df $c7
.jr_00_06f0:
    pop  HL                                            ;; 00:06f0 $e1
    pop  DE                                            ;; 00:06f1 $d1
    pop  BC                                            ;; 00:06f2 $c1
    ret                                                ;; 00:06f3 $c9

jp_00_06f4:
    xor  A, A                                          ;; 00:06f4 $af
    ldh  [hFF8B], A                                    ;; 00:06f5 $e0 $8b
    ld   [wC764], A                                    ;; 00:06f7 $ea $64 $c7
    ldh  [hFF96], A                                    ;; 00:06fa $e0 $96
    ldh  [hFFA5], A                                    ;; 00:06fc $e0 $a5
    jp   call_00_0550                                  ;; 00:06fe $c3 $50 $05

jp_00_0701:
    push DE                                            ;; 00:0701 $d5
    call call_00_07b5                                  ;; 00:0702 $cd $b5 $07
    ld   A, [DE]                                       ;; 00:0705 $1a
    inc  DE                                            ;; 00:0706 $13
    call call_00_07be                                  ;; 00:0707 $cd $be $07
    pop  DE                                            ;; 00:070a $d1
    ret                                                ;; 00:070b $c9

call_00_070c:
    xor  A, A                                          ;; 00:070c $af
    ld   [wC77B], A                                    ;; 00:070d $ea $7b $c7
    rst  rst_00_0030                                   ;; 00:0710 $f7

jp_00_0711:
    cp   A, $9e                                        ;; 00:0711 $fe $9e
    jr   NC, call_00_073b                              ;; 00:0713 $30 $26
    cp   A, $4e                                        ;; 00:0715 $fe $4e
    jr   NC, jr_00_0724                                ;; 00:0717 $30 $0b

jp_00_0719:
    ld   HL, $13be                                     ;; 00:0719 $21 $be $13
    add  A, A                                          ;; 00:071c $87
    rst  add_hl_a                                      ;; 00:071d $c7
    ld   E, [HL]                                       ;; 00:071e $5e
    inc  HL                                            ;; 00:071f $23
    ld   D, [HL]                                       ;; 00:0720 $56
    push DE                                            ;; 00:0721 $d5
    pop  HL                                            ;; 00:0722 $e1
    jp   HL                                            ;; 00:0723 $e9

jr_00_0724:
    ld   HL, data_0f_6560 ;@=ptr bank=0F               ;; 00:0724 $21 $60 $65
    sub  A, $4e                                        ;; 00:0727 $d6 $4e
    add  A, A                                          ;; 00:0729 $87
    rst  add_hl_a                                      ;; 00:072a $c7
    ld   A, $0f                                        ;; 00:072b $3e $0f
    call readFromBank                                  ;; 00:072d $cd $d2 $00
    inc  HL                                            ;; 00:0730 $23
    push HL                                            ;; 00:0731 $e5
    call call_00_073b                                  ;; 00:0732 $cd $3b $07
    pop  HL                                            ;; 00:0735 $e1
    ld   A, $0f                                        ;; 00:0736 $3e $0f
    call readFromBank                                  ;; 00:0738 $cd $d2 $00

call_00_073b:
    call call_00_075e                                  ;; 00:073b $cd $5e $07
    call call_00_0755                                  ;; 00:073e $cd $55 $07
    call call_00_07aa                                  ;; 00:0741 $cd $aa $07
    ldh  A, [hFFA0]                                    ;; 00:0744 $f0 $a0
    and  A, A                                          ;; 00:0746 $a7
    ret  Z                                             ;; 00:0747 $c8
    cp   A, $04                                        ;; 00:0748 $fe $04
    ret  Z                                             ;; 00:074a $c8
    ld   HL, wC77F                                     ;; 00:074b $21 $7f $c7
    dec  [HL]                                          ;; 00:074e $35
    cp   A, $05                                        ;; 00:074f $fe $05
    ret  Z                                             ;; 00:0751 $c8
    jp   jp_00_08d6                                    ;; 00:0752 $c3 $d6 $08

call_00_0755:
    ld   HL, wC7A1                                     ;; 00:0755 $21 $a1 $c7
    inc  [HL]                                          ;; 00:0758 $34
    call call_00_079f                                  ;; 00:0759 $cd $9f $07
    ld   [HL+], A                                      ;; 00:075c $22
    ret                                                ;; 00:075d $c9

call_00_075e:
    push AF                                            ;; 00:075e $f5
    ldh  A, [hFFA0]                                    ;; 00:075f $f0 $a0
    and  A, A                                          ;; 00:0761 $a7
    jr   Z, .jr_00_078b                                ;; 00:0762 $28 $27
    cp   A, $04                                        ;; 00:0764 $fe $04
    jr   Z, .jr_00_078b                                ;; 00:0766 $28 $23
    cp   A, $05                                        ;; 00:0768 $fe $05
    jr   Z, .jr_00_076f                                ;; 00:076a $28 $03
    call call_00_0e30                                  ;; 00:076c $cd $30 $0e
.jr_00_076f:
    push BC                                            ;; 00:076f $c5
    push DE                                            ;; 00:0770 $d5
    push HL                                            ;; 00:0771 $e5
    ld   HL, wC77F                                     ;; 00:0772 $21 $7f $c7
    ld   A, [HL]                                       ;; 00:0775 $7e
    and  A, A                                          ;; 00:0776 $a7
    jr   NZ, .jr_00_077f                               ;; 00:0777 $20 $06
    dec  HL                                            ;; 00:0779 $2b
    ld   A, [HL+]                                      ;; 00:077a $2a
    ld   [HL], A                                       ;; 00:077b $77
    call call_00_0ded                                  ;; 00:077c $cd $ed $0d
.jr_00_077f:
    pop  HL                                            ;; 00:077f $e1
    pop  DE                                            ;; 00:0780 $d1
    pop  BC                                            ;; 00:0781 $c1
    ldh  A, [hFFA0]                                    ;; 00:0782 $f0 $a0
    cp   A, $05                                        ;; 00:0784 $fe $05
    jr   Z, .jr_00_078b                                ;; 00:0786 $28 $03
    call call_00_068f                                  ;; 00:0788 $cd $8f $06
.jr_00_078b:
    pop  AF                                            ;; 00:078b $f1
    ret                                                ;; 00:078c $c9

call_00_078d:
    ld   A, [wC783]                                    ;; 00:078d $fa $83 $c7
    ld   L, A                                          ;; 00:0790 $6f
    ld   A, [wC784]                                    ;; 00:0791 $fa $84 $c7
    ld   H, A                                          ;; 00:0794 $67
    ret                                                ;; 00:0795 $c9

call_00_0796:
    ld   A, L                                          ;; 00:0796 $7d
    ld   [wC783], A                                    ;; 00:0797 $ea $83 $c7
    ld   A, H                                          ;; 00:079a $7c
    ld   [wC784], A                                    ;; 00:079b $ea $84 $c7
    ret                                                ;; 00:079e $c9

call_00_079f:
    push AF                                            ;; 00:079f $f5
    ld   A, [wC781]                                    ;; 00:07a0 $fa $81 $c7
    ld   L, A                                          ;; 00:07a3 $6f
    ld   A, [wC782]                                    ;; 00:07a4 $fa $82 $c7
    ld   H, A                                          ;; 00:07a7 $67
    pop  AF                                            ;; 00:07a8 $f1
    ret                                                ;; 00:07a9 $c9

call_00_07aa:
    push AF                                            ;; 00:07aa $f5
    ld   A, L                                          ;; 00:07ab $7d
    ld   [wC781], A                                    ;; 00:07ac $ea $81 $c7
    ld   A, H                                          ;; 00:07af $7c
    ld   [wC782], A                                    ;; 00:07b0 $ea $82 $c7
    pop  AF                                            ;; 00:07b3 $f1
    ret                                                ;; 00:07b4 $c9

call_00_07b5:
    push HL                                            ;; 00:07b5 $e5
    ld   HL, hFFA2                                     ;; 00:07b6 $21 $a2 $ff
    ld   E, [HL]                                       ;; 00:07b9 $5e
    inc  HL                                            ;; 00:07ba $23
    ld   D, [HL]                                       ;; 00:07bb $56
    pop  HL                                            ;; 00:07bc $e1
    ret                                                ;; 00:07bd $c9

call_00_07be:
    push HL                                            ;; 00:07be $e5
    ld   HL, hFFA2                                     ;; 00:07bf $21 $a2 $ff
    ld   [HL], E                                       ;; 00:07c2 $73
    inc  HL                                            ;; 00:07c3 $23
    ld   [HL], D                                       ;; 00:07c4 $72
    pop  HL                                            ;; 00:07c5 $e1
    ret                                                ;; 00:07c6 $c9

call_00_07c7:
    ld   L, E                                          ;; 00:07c7 $6b
    ldh  A, [hFFA0]                                    ;; 00:07c8 $f0 $a0
    and  A, A                                          ;; 00:07ca $a7
    jr   Z, .jr_00_07da                                ;; 00:07cb $28 $0d
    dec  A                                             ;; 00:07cd $3d
    jr   Z, .jr_00_07da                                ;; 00:07ce $28 $0a
    dec  A                                             ;; 00:07d0 $3d
    jr   Z, .jr_00_07de                                ;; 00:07d1 $28 $0b
    dec  A                                             ;; 00:07d3 $3d
    jr   NZ, .jr_00_07da                               ;; 00:07d4 $20 $04
    ld   A, [wD90C]                                    ;; 00:07d6 $fa $0c $d9
    ld   L, A                                          ;; 00:07d9 $6f
.jr_00_07da:
    ld   H, $00                                        ;; 00:07da $26 $00
    jr   .jr_00_07e0                                   ;; 00:07dc $18 $02
.jr_00_07de:
    ld   H, D                                          ;; 00:07de $62
    dec  H                                             ;; 00:07df $25
.jr_00_07e0:
    add  HL, HL                                        ;; 00:07e0 $29
    add  HL, BC                                        ;; 00:07e1 $09
    ld   A, [HL+]                                      ;; 00:07e2 $2a
    ldh  [hFFA2], A                                    ;; 00:07e3 $e0 $a2
    ld   A, [HL]                                       ;; 00:07e5 $7e
    ldh  [hFFA3], A                                    ;; 00:07e6 $e0 $a3
    ret                                                ;; 00:07e8 $c9

call_00_07e9:
    push AF                                            ;; 00:07e9 $f5
    ldh  A, [hFFA0]                                    ;; 00:07ea $f0 $a0
    and  A, A                                          ;; 00:07ec $a7
    jr   Z, .jr_00_07f5                                ;; 00:07ed $28 $06
    dec  A                                             ;; 00:07ef $3d
    jr   Z, .jr_00_07f5                                ;; 00:07f0 $28 $03
    dec  A                                             ;; 00:07f2 $3d
    jr   Z, .jr_00_07f9                                ;; 00:07f3 $28 $04
.jr_00_07f5:
    ld   A, $0b                                        ;; 00:07f5 $3e $0b
    jr   .jr_00_07fb                                   ;; 00:07f7 $18 $02
.jr_00_07f9:
    ld   A, $0a                                        ;; 00:07f9 $3e $0a
.jr_00_07fb:
    rst  switchBankSafe                                ;; 00:07fb $ef
    ldh  [hFFA1], A                                    ;; 00:07fc $e0 $a1
    pop  AF                                            ;; 00:07fe $f1
    ret                                                ;; 00:07ff $c9

jp_00_0800:
    push AF                                            ;; 00:0800 $f5
    push BC                                            ;; 00:0801 $c5
    push DE                                            ;; 00:0802 $d5
    push HL                                            ;; 00:0803 $e5
    ldh  A, [hFF8B]                                    ;; 00:0804 $f0 $8b
    and  A, A                                          ;; 00:0806 $a7
    ld   A, $03                                        ;; 00:0807 $3e $03
    ld   BC, $6b80                                     ;; 00:0809 $01 $80 $6b
    jr   NZ, .jr_00_084e                               ;; 00:080c $20 $40
    dec  A                                             ;; 00:080e $3d
    ld   BC, $4000                                     ;; 00:080f $01 $00 $40
    inc  D                                             ;; 00:0812 $14
    dec  D                                             ;; 00:0813 $15
    jr   NZ, .jr_00_084e                               ;; 00:0814 $20 $38
    ld   BC, $4000                                     ;; 00:0816 $01 $00 $40
    ld   A, E                                          ;; 00:0819 $7b
    cp   A, $70                                        ;; 00:081a $fe $70
    ld   A, $01                                        ;; 00:081c $3e $01
    jr   NZ, .jr_00_084e                               ;; 00:081e $20 $2e
    ld   A, $04                                        ;; 00:0820 $3e $04
    ldh  [hFFA0], A                                    ;; 00:0822 $e0 $a0
    ld   A, $14                                        ;; 00:0824 $3e $14
    ld   [wC77E], A                                    ;; 00:0826 $ea $7e $c7
    call call_00_07e9                                  ;; 00:0829 $cd $e9 $07
    call call_00_07c7                                  ;; 00:082c $cd $c7 $07
    ld   HL, wC800                                     ;; 00:082f $21 $00 $c8
    ld   BC, $300                                      ;; 00:0832 $01 $00 $03
    ld   A, $ff                                        ;; 00:0835 $3e $ff
    call memsetBig                                     ;; 00:0837 $cd $73 $00
    ld   HL, wC814                                     ;; 00:083a $21 $14 $c8
    call call_00_0796                                  ;; 00:083d $cd $96 $07
    call call_00_07aa                                  ;; 00:0840 $cd $aa $07
.jr_00_0843:
    call call_00_070c                                  ;; 00:0843 $cd $0c $07
    jr   .jr_00_0843                                   ;; 00:0846 $18 $fb
    ldh  A, [hFFA1]                                    ;; 00:0848 $f0 $a1
    rst  switchBankSafe                                ;; 00:084a $ef
    jp   pop_all                                       ;; 00:084b $c3 $0b $00
.jr_00_084e:
    push AF                                            ;; 00:084e $f5
    push BC                                            ;; 00:084f $c5
    push DE                                            ;; 00:0850 $d5
    ld   HL, wC779                                     ;; 00:0851 $21 $79 $c7
    ld   E, [HL]                                       ;; 00:0854 $5e
    inc  HL                                            ;; 00:0855 $23
    ld   D, [HL]                                       ;; 00:0856 $56
    push HL                                            ;; 00:0857 $e5
    ld   HL, hFFA0                                     ;; 00:0858 $21 $a0 $ff
    ld   B, $04                                        ;; 00:085b $06 $04
    call memcopySmall                                  ;; 00:085d $cd $80 $00
    pop  HL                                            ;; 00:0860 $e1
    ld   [HL], D                                       ;; 00:0861 $72
    dec  HL                                            ;; 00:0862 $2b
    ld   [HL], E                                       ;; 00:0863 $73
    ld   HL, wC77D                                     ;; 00:0864 $21 $7d $c7
    ld   A, [HL]                                       ;; 00:0867 $7e
    ld   [wC77C], A                                    ;; 00:0868 $ea $7c $c7
    inc  [HL]                                          ;; 00:086b $34
    pop  DE                                            ;; 00:086c $d1
    pop  BC                                            ;; 00:086d $c1
    pop  AF                                            ;; 00:086e $f1
    ldh  [hFFA0], A                                    ;; 00:086f $e0 $a0
    call call_00_07e9                                  ;; 00:0871 $cd $e9 $07
    call call_00_07c7                                  ;; 00:0874 $cd $c7 $07
    ld   A, $20                                        ;; 00:0877 $3e $20
    ld   [wC77E], A                                    ;; 00:0879 $ea $7e $c7
.jr_00_087c:
    call call_00_070c                                  ;; 00:087c $cd $0c $07
    jr   .jr_00_087c                                   ;; 00:087f $18 $fb
    ldh  A, [hFFA1]                                    ;; 00:0881 $f0 $a1
    rst  switchBankSafe                                ;; 00:0883 $ef
    ld   HL, wC779                                     ;; 00:0884 $21 $79 $c7
    ld   E, [HL]                                       ;; 00:0887 $5e
    inc  HL                                            ;; 00:0888 $23
    ld   D, [HL]                                       ;; 00:0889 $56
    push HL                                            ;; 00:088a $e5
    ld   HL, hFFA3                                     ;; 00:088b $21 $a3 $ff
    ld   B, $04                                        ;; 00:088e $06 $04
    call memcopySmallReverse                           ;; 00:0890 $cd $a3 $08
    pop  HL                                            ;; 00:0893 $e1
    ld   [HL], D                                       ;; 00:0894 $72
    dec  HL                                            ;; 00:0895 $2b
    ld   [HL], E                                       ;; 00:0896 $73
    ld   HL, wC77D                                     ;; 00:0897 $21 $7d $c7
    dec  [HL]                                          ;; 00:089a $35
    ld   A, [HL]                                       ;; 00:089b $7e
    dec  A                                             ;; 00:089c $3d
    ld   [wC77C], A                                    ;; 00:089d $ea $7c $c7
    jp   pop_all                                       ;; 00:08a0 $c3 $0b $00

; Copies data from DE-1 to HL B times, but in the reverse direction compared to normal copies,
; pointers start at the end of the data.
memcopySmallReverse:
    dec  DE                                            ;; 00:08a3 $1b
    ld   A, [DE]                                       ;; 00:08a4 $1a
    ld   [HL-], A                                      ;; 00:08a5 $32
    dec  B                                             ;; 00:08a6 $05
    jr   NZ, memcopySmallReverse                       ;; 00:08a7 $20 $fa
    ret                                                ;; 00:08a9 $c9

call_00_08aa:
    ld   HL, $9c40                                     ;; 00:08aa $21 $40 $9c
    ld   DE, $9c20                                     ;; 00:08ad $11 $20 $9c
    ld   B, $e0                                        ;; 00:08b0 $06 $e0
    ldh  A, [hFFA0]                                    ;; 00:08b2 $f0 $a0
    cp   A, $03                                        ;; 00:08b4 $fe $03
    jr   Z, .jr_00_08ba                                ;; 00:08b6 $28 $02
    ld   B, $a0                                        ;; 00:08b8 $06 $a0
.jr_00_08ba:
    call call_00_1674                                  ;; 00:08ba $cd $74 $16
    call memcopySmall                                  ;; 00:08bd $cd $80 $00
    ld   B, $12                                        ;; 00:08c0 $06 $12
    ld   HL, $9d01                                     ;; 00:08c2 $21 $01 $9d
    ldh  A, [hFFA0]                                    ;; 00:08c5 $f0 $a0
    cp   A, $03                                        ;; 00:08c7 $fe $03
    jr   Z, .jr_00_08ce                                ;; 00:08c9 $28 $03
    ld   HL, $9cc1                                     ;; 00:08cb $21 $c1 $9c
.jr_00_08ce:
    ld   A, $ff                                        ;; 00:08ce $3e $ff
    call memsetSmall                                   ;; 00:08d0 $cd $6d $00
    call call_00_1691                                  ;; 00:08d3 $cd $91 $16

jp_00_08d6:
    ld   C, $89                                        ;; 00:08d6 $0e $89
    ld   A, [wC765]                                    ;; 00:08d8 $fa $65 $c7
    ld   E, A                                          ;; 00:08db $5f
    rrca                                               ;; 00:08dc $0f
    jr   C, .jr_00_08e2                                ;; 00:08dd $38 $03
    ldh  A, [C]                                        ;; 00:08df $f2
    rrca                                               ;; 00:08e0 $0f
    ret  C                                             ;; 00:08e1 $d8
.jr_00_08e2:
    ld   A, [wC31B]                                    ;; 00:08e2 $fa $1b $c3
    add  A, A                                          ;; 00:08e5 $87
    and  A, A                                          ;; 00:08e6 $a7
    ret  Z                                             ;; 00:08e7 $c8
    ld   B, A                                          ;; 00:08e8 $47
.jr_00_08e9:
    ldh  A, [C]                                        ;; 00:08e9 $f2
    bit  0, E                                          ;; 00:08ea $cb $43
    jr   NZ, .jr_00_08f1                               ;; 00:08ec $20 $03
    bit  0, A                                          ;; 00:08ee $cb $47
    ret  NZ                                            ;; 00:08f0 $c0
.jr_00_08f1:
    bit  1, E                                          ;; 00:08f1 $cb $4b
    jr   NZ, .jr_00_08fa                               ;; 00:08f3 $20 $05
    bit  1, A                                          ;; 00:08f5 $cb $4f
    jr   Z, .jr_00_08fa                                ;; 00:08f7 $28 $01
    inc  B                                             ;; 00:08f9 $04
.jr_00_08fa:
    call call_00_068f                                  ;; 00:08fa $cd $8f $06
    dec  B                                             ;; 00:08fd $05
    jr   NZ, .jr_00_08e9                               ;; 00:08fe $20 $e9
    ret                                                ;; 00:0900 $c9

jp_00_0901:
    ld   [wC7D2], A                                    ;; 00:0901 $ea $d2 $c7
    call call_00_0916                                  ;; 00:0904 $cd $16 $09
    ret                                                ;; 00:0907 $c9

jp_00_0908:
    push AF                                            ;; 00:0908 $f5
    push BC                                            ;; 00:0909 $c5
    push DE                                            ;; 00:090a $d5
    push HL                                            ;; 00:090b $e5
    xor  A, A                                          ;; 00:090c $af
    ld   [wC7D2], A                                    ;; 00:090d $ea $d2 $c7
    call call_00_0916                                  ;; 00:0910 $cd $16 $09
    jp   pop_all                                       ;; 00:0913 $c3 $0b $00

call_00_0916:
    xor  A, A                                          ;; 00:0916 $af
    ldh  [hFFA0], A                                    ;; 00:0917 $e0 $a0
    ld   HL, wC799                                     ;; 00:0919 $21 $99 $c7
    ld   [HL+], A                                      ;; 00:091c $22
    ld   [HL], A                                       ;; 00:091d $77
    call call_00_07e9                                  ;; 00:091e $cd $e9 $07
    ld   BC, $7400                                     ;; 00:0921 $01 $00 $74
    call call_00_07c7                                  ;; 00:0924 $cd $c7 $07
    call call_00_07b5                                  ;; 00:0927 $cd $b5 $07
    ld   HL, wC799                                     ;; 00:092a $21 $99 $c7
    ld   BC, wC79B                                     ;; 00:092d $01 $9b $c7
    ld   A, $02                                        ;; 00:0930 $3e $02
.jr_00_0932:
    ldh  [hFF90], A                                    ;; 00:0932 $e0 $90
    ld   A, [DE]                                       ;; 00:0934 $1a
    rla                                                ;; 00:0935 $17
    rl   [HL]                                          ;; 00:0936 $cb $16
    inc  HL                                            ;; 00:0938 $23
    ld   A, [DE]                                       ;; 00:0939 $1a
    inc  DE                                            ;; 00:093a $13
    and  A, $1f                                        ;; 00:093b $e6 $1f
    ld   [BC], A                                       ;; 00:093d $02
    inc  BC                                            ;; 00:093e $03
    ldh  A, [hFF90]                                    ;; 00:093f $f0 $90
    dec  A                                             ;; 00:0941 $3d
    jr   NZ, .jr_00_0932                               ;; 00:0942 $20 $ee
    ld   L, $02                                        ;; 00:0944 $2e $02
.jr_00_0946:
    ld   A, [DE]                                       ;; 00:0946 $1a
    inc  DE                                            ;; 00:0947 $13
    ld   [BC], A                                       ;; 00:0948 $02
    inc  BC                                            ;; 00:0949 $03
    dec  L                                             ;; 00:094a $2d
    jr   NZ, .jr_00_0946                               ;; 00:094b $20 $f9
    call call_00_07be                                  ;; 00:094d $cd $be $07
    ld   HL, wC800                                     ;; 00:0950 $21 $00 $c8
    ld   BC, $300                                      ;; 00:0953 $01 $00 $03
    ld   A, [wC799]                                    ;; 00:0956 $fa $99 $c7
    and  A, A                                          ;; 00:0959 $a7
    jr   Z, .jr_00_0960                                ;; 00:095a $28 $04
    ld   H, $d0                                        ;; 00:095c $26 $d0
    ld   B, $04                                        ;; 00:095e $06 $04
.jr_00_0960:
    ld   A, $ff                                        ;; 00:0960 $3e $ff
    call memsetBig                                     ;; 00:0962 $cd $73 $00
    ld   HL, $b09                                      ;; 00:0965 $21 $09 $0b
    ldh  A, [hFF8B]                                    ;; 00:0968 $f0 $8b
    and  A, A                                          ;; 00:096a $a7
    jr   NZ, .jr_00_097b                               ;; 00:096b $20 $0e
    ld   A, [wC764]                                    ;; 00:096d $fa $64 $c7
    and  A, A                                          ;; 00:0970 $a7
    jr   Z, .jr_00_0978                                ;; 00:0971 $28 $05
    ld   HL, $b0b                                      ;; 00:0973 $21 $0b $0b
    jr   .jr_00_097b                                   ;; 00:0976 $18 $03
.jr_00_0978:
    ld   HL, $b0d                                      ;; 00:0978 $21 $0d $0b
.jr_00_097b:
    ld   DE, wC7A4                                     ;; 00:097b $11 $a4 $c7
    ld   B, $02                                        ;; 00:097e $06 $02
    call memcopySmall                                  ;; 00:0980 $cd $80 $00
    ld   HL, wC79B                                     ;; 00:0983 $21 $9b $c7
    ld   DE, wC7A1                                     ;; 00:0986 $11 $a1 $c7
    ld   A, [wC7D2]                                    ;; 00:0989 $fa $d2 $c7
    bit  1, A                                          ;; 00:098c $cb $4f
    jr   Z, .jr_00_0999                                ;; 00:098e $28 $09
    ld   A, [HL+]                                      ;; 00:0990 $2a
    ld   [DE], A                                       ;; 00:0991 $12
    inc  DE                                            ;; 00:0992 $13
    ld   [DE], A                                       ;; 00:0993 $12
    inc  DE                                            ;; 00:0994 $13
    ld   A, [HL+]                                      ;; 00:0995 $2a
    ld   [DE], A                                       ;; 00:0996 $12
    jr   .jr_00_09a2                                   ;; 00:0997 $18 $09
.jr_00_0999:
    ld   A, [HL+]                                      ;; 00:0999 $2a
    inc  A                                             ;; 00:099a $3c
    ld   [DE], A                                       ;; 00:099b $12
    inc  DE                                            ;; 00:099c $13
    ld   [DE], A                                       ;; 00:099d $12
    inc  DE                                            ;; 00:099e $13
    ld   A, [HL]                                       ;; 00:099f $7e
    inc  A                                             ;; 00:09a0 $3c
    ld   [DE], A                                       ;; 00:09a1 $12
.jr_00_09a2:
    ld   A, [wC7A4]                                    ;; 00:09a2 $fa $a4 $c7
    ld   C, A                                          ;; 00:09a5 $4f
    ld   A, [HL]                                       ;; 00:09a6 $7e
    sub  A, C                                          ;; 00:09a7 $91
    jr   NC, .jr_00_09ab                               ;; 00:09a8 $30 $01
    xor  A, A                                          ;; 00:09aa $af
.jr_00_09ab:
    ld   [HL], A                                       ;; 00:09ab $77
    ld   HL, wC79D                                     ;; 00:09ac $21 $9d $c7
    ld   B, [HL]                                       ;; 00:09af $46
    inc  HL                                            ;; 00:09b0 $23
    ld   C, [HL]                                       ;; 00:09b1 $4e
    ld   A, [wC7D2]                                    ;; 00:09b2 $fa $d2 $c7
    bit  1, A                                          ;; 00:09b5 $cb $4f
    jr   NZ, .jr_00_09bc                               ;; 00:09b7 $20 $03
    call call_00_0a2b                                  ;; 00:09b9 $cd $2b $0a
.jr_00_09bc:
    ld   A, [wC79D]                                    ;; 00:09bc $fa $9d $c7
    ld   B, A                                          ;; 00:09bf $47
    ld   A, [wC799]                                    ;; 00:09c0 $fa $99 $c7
    and  A, A                                          ;; 00:09c3 $a7
    jr   Z, .jr_00_09c8                                ;; 00:09c4 $28 $02
    ld   B, $22                                        ;; 00:09c6 $06 $22
.jr_00_09c8:
    ld   A, [wC79A]                                    ;; 00:09c8 $fa $9a $c7
    and  A, A                                          ;; 00:09cb $a7
    jr   Z, .jr_00_09dc                                ;; 00:09cc $28 $0e
    ld   A, L                                          ;; 00:09ce $7d
    ld   [wC7C8], A                                    ;; 00:09cf $ea $c8 $c7
    ld   A, H                                          ;; 00:09d2 $7c
    ld   [wC7C9], A                                    ;; 00:09d3 $ea $c9 $c7
    dec  B                                             ;; 00:09d6 $05
    dec  B                                             ;; 00:09d7 $05
    ld   A, B                                          ;; 00:09d8 $78
    rst  add_hl_a                                      ;; 00:09d9 $c7
    jr   .jr_00_09df                                   ;; 00:09da $18 $03
.jr_00_09dc:
    call call_00_0ae2                                  ;; 00:09dc $cd $e2 $0a
.jr_00_09df:
    ld   A, B                                          ;; 00:09df $78
    ld   [wC77E], A                                    ;; 00:09e0 $ea $7e $c7
    call call_00_0796                                  ;; 00:09e3 $cd $96 $07
    call call_00_07aa                                  ;; 00:09e6 $cd $aa $07
    ld   HL, wC79B                                     ;; 00:09e9 $21 $9b $c7
    ld   DE, wC79F                                     ;; 00:09ec $11 $9f $c7
    ld   C, [HL]                                       ;; 00:09ef $4e
    inc  HL                                            ;; 00:09f0 $23
    ld   B, [HL]                                       ;; 00:09f1 $46
    inc  HL                                            ;; 00:09f2 $23
    ld   A, [HL+]                                      ;; 00:09f3 $2a
    add  A, C                                          ;; 00:09f4 $81
    dec  A                                             ;; 00:09f5 $3d
    ld   [DE], A                                       ;; 00:09f6 $12
    inc  DE                                            ;; 00:09f7 $13
    ld   A, [HL]                                       ;; 00:09f8 $7e
    add  A, B                                          ;; 00:09f9 $80
    dec  A                                             ;; 00:09fa $3d
    ld   B, A                                          ;; 00:09fb $47
    ld   A, [wC7A4]                                    ;; 00:09fc $fa $a4 $c7
    ld   C, A                                          ;; 00:09ff $4f
    add  A, B                                          ;; 00:0a00 $80
    ld   [DE], A                                       ;; 00:0a01 $12
    ld   HL, wC79B                                     ;; 00:0a02 $21 $9b $c7
    ld   DE, wC7D0                                     ;; 00:0a05 $11 $d0 $c7
    ld   A, [HL+]                                      ;; 00:0a08 $2a
    ld   [DE], A                                       ;; 00:0a09 $12
    inc  DE                                            ;; 00:0a0a $13
    ld   A, [HL]                                       ;; 00:0a0b $7e
    add  A, C                                          ;; 00:0a0c $81
    ld   [DE], A                                       ;; 00:0a0d $12
    ld   A, [wC79A]                                    ;; 00:0a0e $fa $9a $c7
    and  A, A                                          ;; 00:0a11 $a7
    jr   Z, .jr_00_0a17                                ;; 00:0a12 $28 $03
    ld   A, [wC7CA]                                    ;; 00:0a14 $fa $ca $c7
.jr_00_0a17:
    ld   [wC7CF], A                                    ;; 00:0a17 $ea $cf $c7
.jr_00_0a1a:
    call call_00_070c                                  ;; 00:0a1a $cd $0c $07
    jr   .jr_00_0a1a                                   ;; 00:0a1d $18 $fb
    di                                                 ;; 00:0a1f $f3
    call call_00_176c                                  ;; 00:0a20 $cd $6c $17
    ei                                                 ;; 00:0a23 $fb
    call call_00_0a5c                                  ;; 00:0a24 $cd $5c $0a
    ldh  A, [hFFA1]                                    ;; 00:0a27 $f0 $a1
    rst  switchBankSafe                                ;; 00:0a29 $ef
    ret                                                ;; 00:0a2a $c9

call_00_0a2b:
    dec  B                                             ;; 00:0a2b $05
    dec  B                                             ;; 00:0a2c $05
    dec  C                                             ;; 00:0a2d $0d
    dec  C                                             ;; 00:0a2e $0d
    ld   E, B                                          ;; 00:0a2f $58
    ld   HL, wC800                                     ;; 00:0a30 $21 $00 $c8
    ld   A, [wC799]                                    ;; 00:0a33 $fa $99 $c7
    and  A, A                                          ;; 00:0a36 $a7
    jr   Z, .jr_00_0a3c                                ;; 00:0a37 $28 $03
    ld   HL, wD000                                     ;; 00:0a39 $21 $00 $d0
.jr_00_0a3c:
    ld   A, $f7                                        ;; 00:0a3c $3e $f7
    call call_00_0a52                                  ;; 00:0a3e $cd $52 $0a
.jr_00_0a41:
    ld   [HL+], A                                      ;; 00:0a41 $22
    push AF                                            ;; 00:0a42 $f5
    ld   A, $ff                                        ;; 00:0a43 $3e $ff
    ld   B, E                                          ;; 00:0a45 $43
    call memsetSmall                                   ;; 00:0a46 $cd $6d $00
    pop  AF                                            ;; 00:0a49 $f1
    inc  A                                             ;; 00:0a4a $3c
    ld   [HL+], A                                      ;; 00:0a4b $22
    dec  A                                             ;; 00:0a4c $3d
    dec  C                                             ;; 00:0a4d $0d
    jr   NZ, .jr_00_0a41                               ;; 00:0a4e $20 $f1
    inc  A                                             ;; 00:0a50 $3c
    inc  A                                             ;; 00:0a51 $3c

call_00_0a52:
    ld   [HL+], A                                      ;; 00:0a52 $22
    ld   B, E                                          ;; 00:0a53 $43
    inc  A                                             ;; 00:0a54 $3c
    call memsetSmall                                   ;; 00:0a55 $cd $6d $00
    inc  A                                             ;; 00:0a58 $3c
    ld   [HL+], A                                      ;; 00:0a59 $22
    inc  A                                             ;; 00:0a5a $3c
    ret                                                ;; 00:0a5b $c9

call_00_0a5c:
    ld   A, [wC7D2]                                    ;; 00:0a5c $fa $d2 $c7
    rrca                                               ;; 00:0a5f $0f
    ret  C                                             ;; 00:0a60 $d8
    ld   HL, wC79B                                     ;; 00:0a61 $21 $9b $c7
    ld   C, [HL]                                       ;; 00:0a64 $4e
    ld   B, $9c                                        ;; 00:0a65 $06 $9c
    inc  HL                                            ;; 00:0a67 $23
    ld   L, [HL]                                       ;; 00:0a68 $6e
    ld   H, $00                                        ;; 00:0a69 $26 $00
    call mul_hl_32_add_bc                              ;; 00:0a6b $cd $5c $00
    ld   E, L                                          ;; 00:0a6e $5d
    ld   D, H                                          ;; 00:0a6f $54
    ld   A, [wC79A]                                    ;; 00:0a70 $fa $9a $c7
    and  A, A                                          ;; 00:0a73 $a7
    jr   Z, .jr_00_0abc                                ;; 00:0a74 $28 $46
    push DE                                            ;; 00:0a76 $d5
    ld   A, [wC79D]                                    ;; 00:0a77 $fa $9d $c7
    inc  A                                             ;; 00:0a7a $3c
    ld   E, A                                          ;; 00:0a7b $5f
    ld   D, $c8                                        ;; 00:0a7c $16 $c8
    ld   HL, wC7C8                                     ;; 00:0a7e $21 $c8 $c7
    ld   C, [HL]                                       ;; 00:0a81 $4e
    inc  HL                                            ;; 00:0a82 $23
    ld   B, [HL]                                       ;; 00:0a83 $46
    ld   A, [wC77E]                                    ;; 00:0a84 $fa $7e $c7
    ld   L, A                                          ;; 00:0a87 $6f
    ld   A, [wC798]                                    ;; 00:0a88 $fa $98 $c7
    ld   H, A                                          ;; 00:0a8b $67
    call call_00_02f0                                  ;; 00:0a8c $cd $f0 $02
    add  HL, BC                                        ;; 00:0a8f $09
    ld   A, [wC799]                                    ;; 00:0a90 $fa $99 $c7
    and  A, A                                          ;; 00:0a93 $a7
    jr   Z, .jr_00_0a9c                                ;; 00:0a94 $28 $06
    ld   D, $d0                                        ;; 00:0a96 $16 $d0
    ld   A, [wC797]                                    ;; 00:0a98 $fa $97 $c7
    rst  add_hl_a                                      ;; 00:0a9b $c7
.jr_00_0a9c:
    ld   A, [wC79D]                                    ;; 00:0a9c $fa $9d $c7
    sub  A, $02                                        ;; 00:0a9f $d6 $02
    ld   B, A                                          ;; 00:0aa1 $47
    ld   A, [wC79E]                                    ;; 00:0aa2 $fa $9e $c7
    sub  A, $02                                        ;; 00:0aa5 $d6 $02
    ld   C, A                                          ;; 00:0aa7 $4f
.jr_00_0aa8:
    push BC                                            ;; 00:0aa8 $c5
    push HL                                            ;; 00:0aa9 $e5
.jr_00_0aaa:
    ld   A, [HL+]                                      ;; 00:0aaa $2a
    ld   [DE], A                                       ;; 00:0aab $12
    inc  DE                                            ;; 00:0aac $13
    dec  B                                             ;; 00:0aad $05
    jr   NZ, .jr_00_0aaa                               ;; 00:0aae $20 $fa
    inc  DE                                            ;; 00:0ab0 $13
    inc  DE                                            ;; 00:0ab1 $13
    pop  HL                                            ;; 00:0ab2 $e1
    pop  BC                                            ;; 00:0ab3 $c1
    ld   A, [wC77E]                                    ;; 00:0ab4 $fa $7e $c7
    rst  add_hl_a                                      ;; 00:0ab7 $c7
    dec  C                                             ;; 00:0ab8 $0d
    jr   NZ, .jr_00_0aa8                               ;; 00:0ab9 $20 $ed
    pop  DE                                            ;; 00:0abb $d1
.jr_00_0abc:
    ld   HL, wC79D                                     ;; 00:0abc $21 $9d $c7
    ld   B, [HL]                                       ;; 00:0abf $46
    inc  HL                                            ;; 00:0ac0 $23
    ld   C, [HL]                                       ;; 00:0ac1 $4e

jp_00_0ac2:
    ld   HL, wC800                                     ;; 00:0ac2 $21 $00 $c8
    ld   A, [wC799]                                    ;; 00:0ac5 $fa $99 $c7
    and  A, A                                          ;; 00:0ac8 $a7
    jr   Z, .jr_00_0ace                                ;; 00:0ac9 $28 $03
    ld   HL, wD000                                     ;; 00:0acb $21 $00 $d0
.jr_00_0ace:
    call call_00_0af3                                  ;; 00:0ace $cd $f3 $0a
    call call_00_068f                                  ;; 00:0ad1 $cd $8f $06
    ld   A, [wC7A5]                                    ;; 00:0ad4 $fa $a5 $c7
    ldh  [rWY], A                                      ;; 00:0ad7 $e0 $4a
    ld   A, $07                                        ;; 00:0ad9 $3e $07
    ldh  [rWX], A                                      ;; 00:0adb $e0 $4b
    ld   A, $e3                                        ;; 00:0add $3e $e3
    ldh  [rLCDC], A                                    ;; 00:0adf $e0 $40
    ret                                                ;; 00:0ae1 $c9

call_00_0ae2:
    ld   A, [wC7D2]                                    ;; 00:0ae2 $fa $d2 $c7
    bit  1, A                                          ;; 00:0ae5 $cb $4f
    ld   A, [wC79D]                                    ;; 00:0ae7 $fa $9d $c7
    jr   NZ, .jr_00_0aee                               ;; 00:0aea $20 $02
    add  A, A                                          ;; 00:0aec $87
    inc  A                                             ;; 00:0aed $3c
.jr_00_0aee:
    ld   HL, wC800                                     ;; 00:0aee $21 $00 $c8
    rst  add_hl_a                                      ;; 00:0af1 $c7
    ret                                                ;; 00:0af2 $c9

call_00_0af3:
    call call_00_1674                                  ;; 00:0af3 $cd $74 $16
.jr_00_0af6:
    push BC                                            ;; 00:0af6 $c5
    call memcopySmall                                  ;; 00:0af7 $cd $80 $00
    pop  BC                                            ;; 00:0afa $c1
    ld   A, $20                                        ;; 00:0afb $3e $20
    sub  A, B                                          ;; 00:0afd $90
    add  A, E                                          ;; 00:0afe $83
    ld   E, A                                          ;; 00:0aff $5f
    jr   NC, .jr_00_0b03                               ;; 00:0b00 $30 $01
    inc  D                                             ;; 00:0b02 $14
.jr_00_0b03:
    dec  C                                             ;; 00:0b03 $0d
    jr   NZ, .jr_00_0af6                               ;; 00:0b04 $20 $f0
    jp   call_00_1691                                  ;; 00:0b06 $c3 $91 $16
    db   $08, $40, $0a, $50, $00, $00                  ;; 00:0b09 ..??..

data_00_0b0f:
    ldh  A, [hFFA0]                                    ;; 00:0b0f $f0 $a0
    and  A, A                                          ;; 00:0b11 $a7
    jr   Z, .jr_00_0b2d                                ;; 00:0b12 $28 $19
    cp   A, $03                                        ;; 00:0b14 $fe $03
    jr   NC, .jr_00_0b2d                               ;; 00:0b16 $30 $15
    ld   A, [wC77C]                                    ;; 00:0b18 $fa $7c $c7
    and  A, A                                          ;; 00:0b1b $a7
    jr   NZ, .jr_00_0b2d                               ;; 00:0b1c $20 $0f
    ld   A, [wC764]                                    ;; 00:0b1e $fa $64 $c7
    and  A, A                                          ;; 00:0b21 $a7
    jr   Z, .jr_00_0b2d                                ;; 00:0b22 $28 $09
    call call_00_0ca9                                  ;; 00:0b24 $cd $a9 $0c
    call call_00_04a6                                  ;; 00:0b27 $cd $a6 $04
    call call_00_0e5c                                  ;; 00:0b2a $cd $5c $0e
.jr_00_0b2d:
    pop  HL                                            ;; 00:0b2d $e1
    inc  HL                                            ;; 00:0b2e $23
    inc  HL                                            ;; 00:0b2f $23
    jp   HL                                            ;; 00:0b30 $e9

data_00_0b31:
    ret                                                ;; 00:0b31 $c9

data_00_0b32:
    call call_00_0b46                                  ;; 00:0b32 $cd $46 $0b
    cp   A, $0f                                        ;; 00:0b35 $fe $0f
    jr   Z, jr_00_0b43                                 ;; 00:0b37 $28 $0a
    inc  A                                             ;; 00:0b39 $3c
    jr   jr_00_0b43                                    ;; 00:0b3a $18 $07

data_00_0b3c:
    call call_00_0b46                                  ;; 00:0b3c $cd $46 $0b
    and  A, A                                          ;; 00:0b3f $a7
    jr   Z, jr_00_0b43                                 ;; 00:0b40 $28 $01
    dec  A                                             ;; 00:0b42 $3d

jr_00_0b43:
    jp   jp_00_064a                                    ;; 00:0b43 $c3 $4a $06

call_00_0b46:
    rst  rst_00_0030                                   ;; 00:0b46 $f7
    ld   E, A                                          ;; 00:0b47 $5f
    jp   call_00_063e                                  ;; 00:0b48 $c3 $3e $06

data_00_0b4b:
    rst  rst_00_0030                                   ;; 00:0b4b $f7
    ld   E, A                                          ;; 00:0b4c $5f
    rst  rst_00_0030                                   ;; 00:0b4d $f7
    jr   jr_00_0b43                                    ;; 00:0b4e $18 $f3

call_00_0b50:
    call call_00_0b66                                  ;; 00:0b50 $cd $66 $0b
    call call_00_0679                                  ;; 00:0b53 $cd $79 $06
    call call_00_050b                                  ;; 00:0b56 $cd $0b $05
    jr   .jr_00_0b64                                   ;; 00:0b59 $18 $09
    db   $cd, $66, $0b, $cd, $79, $06, $cd, $12        ;; 00:0b5b ????????
    db   $05                                           ;; 00:0b63 ?
.jr_00_0b64:
    ld   [HL], A                                       ;; 00:0b64 $77
    ret                                                ;; 00:0b65 $c9

call_00_0b66:
    rst  rst_00_0030                                   ;; 00:0b66 $f7
    ld   E, A                                          ;; 00:0b67 $5f
    and  A, $f0                                        ;; 00:0b68 $e6 $f0
    swap A                                             ;; 00:0b6a $cb $37
    ld   D, A                                          ;; 00:0b6c $57
    ld   A, E                                          ;; 00:0b6d $7b
    and  A, $0f                                        ;; 00:0b6e $e6 $0f
    ld   E, A                                          ;; 00:0b70 $5f
    ret                                                ;; 00:0b71 $c9
    db   $f7, $06, $04, $21, $0f, $c2, $11, $10        ;; 00:0b72 ????????
    db   $00, $0e, $08, $cd, $03, $16, $d0, $19        ;; 00:0b7a ????????
    db   $05, $20, $f6, $cd, $08, $06, $28, $06        ;; 00:0b82 ????????
    db   $0e, $08, $cd, $03, $16, $d0, $21, $b9        ;; 00:0b8a ????????
    db   $c2, $0e, $10, $cd, $03, $16, $d0, $18        ;; 00:0b92 ????????
    db   $6a, $01, $00, $00, $79, $21, $06, $c2        ;; 00:0b9a ????????
    db   $cd, $d9, $05, $cb, $66, $28, $01, $04        ;; 00:0ba2 ????????
    db   $0c, $79, $fe, $04, $38, $ee, $78, $fe        ;; 00:0baa ????????
    db   $04, $c8, $18, $4f                            ;; 00:0bb2 ????

data_00_0bb6:
    rst  rst_00_0030                                   ;; 00:0bb6 $f7
    ld   E, A                                          ;; 00:0bb7 $5f
    rst  rst_00_0030                                   ;; 00:0bb8 $f7
    ld   C, A                                          ;; 00:0bb9 $4f
    and  A, $0f                                        ;; 00:0bba $e6 $0f
    ld   B, A                                          ;; 00:0bbc $47
    ld   A, C                                          ;; 00:0bbd $79
    and  A, $f0                                        ;; 00:0bbe $e6 $f0
    swap A                                             ;; 00:0bc0 $cb $37
    ld   C, A                                          ;; 00:0bc2 $4f
    call call_00_063e                                  ;; 00:0bc3 $cd $3e $06
    inc  B                                             ;; 00:0bc6 $04
    cp   A, C                                          ;; 00:0bc7 $b9
    jr   C, jr_00_0c05                                 ;; 00:0bc8 $38 $3b
    cp   A, B                                          ;; 00:0bca $b8
    jr   NC, jr_00_0c05                                ;; 00:0bcb $30 $38
    ret                                                ;; 00:0bcd $c9
    db   $f7, $47, $04, $fa, $d9, $c2, $b8, $d8        ;; 00:0bce ????????
    db   $18, $2d, $f7, $21, $da, $c2, $87, $c7        ;; 00:0bd6 ????????
    db   $7e, $e6, $0f, $c0, $18, $21                  ;; 00:0bde ??????

data_00_0be4:
    ld   DE, $03                                       ;; 00:0be4 $11 $03 $00
    ld   A, [wC763]                                    ;; 00:0be7 $fa $63 $c7
    and  A, A                                          ;; 00:0bea $a7
    ret  Z                                             ;; 00:0beb $c8
    jp   jp_00_0800                                    ;; 00:0bec $c3 $00 $08
    db   $f7, $4f, $f0, $b0, $b9, $c8, $18, $0e        ;; 00:0bef ????????
    db   $f7, $4f, $fa, $a1, $c2, $b9, $d0, $18        ;; 00:0bf7 ????????
    db   $05, $cd, $77, $14, $a7, $c8                  ;; 00:0bff ??????

jr_00_0c05:
    call call_00_07b5                                  ;; 00:0c05 $cd $b5 $07
    inc  DE                                            ;; 00:0c08 $13
    inc  DE                                            ;; 00:0c09 $13
    inc  DE                                            ;; 00:0c0a $13
    inc  DE                                            ;; 00:0c0b $13
    jp   call_00_07be                                  ;; 00:0c0c $c3 $be $07
    db   $cd, $bf, $04, $36, $50, $01, $cd, $a9        ;; 00:0c0f ????????
    db   $0c, $c3, $00, $02, $3e, $ff, $ea, $54        ;; 00:0c17 ????????
    db   $c3, $c9                                      ;; 00:0c1f ??

data_00_0c21:
    call call_00_0b50                                  ;; 00:0c21 $cd $50 $0b
    jp   call_00_11a1                                  ;; 00:0c24 $c3 $a1 $11
    db   $f7, $a7, $28, $2c, $cd, $fb, $04, $3d        ;; 00:0c27 ????????
    db   $28, $2d, $3d, $28, $2f, $3d, $28, $37        ;; 00:0c2f ????????
    db   $3d, $28, $40, $01, $06, $00, $cd, $8c        ;; 00:0c37 ????????
    db   $0c, $af, $cd, $d9, $05, $7e, $cd, $48        ;; 00:0c3f ????????
    db   $16, $a7, $20, $3b, $01, $09, $00, $cd        ;; 00:0c47 ????????
    db   $8c, $0c, $af, $cd, $04, $12, $18, $32        ;; 00:0c4f ????????
    db   $fa, $dd, $c7, $3c, $c3, $3f, $12, $01        ;; 00:0c57 ????????
    db   $1c, $01, $18, $03, $01, $d9, $00, $cd        ;; 00:0c5f ????????
    db   $8c, $0c, $cd, $e6, $12, $18, $1b, $01        ;; 00:0c67 ????????
    db   $00, $00, $cd, $8c, $0c, $af, $cd, $27        ;; 00:0c6f ????????
    db   $10, $18, $0f, $01, $07, $00, $cd, $8c        ;; 00:0c77 ????????
    db   $0c, $af, $cd, $04, $12, $18, $03, $cd        ;; 00:0c7f ????????
    db   $f2, $11, $c3, $f4, $04, $fa, $dd, $c7        ;; 00:0c87 ????????
    db   $cd, $4d, $00, $6f, $26, $15, $cd, $f0        ;; 00:0c8f ????????
    db   $02, $09, $01, $00, $a0, $09, $c9, $f7        ;; 00:0c97 ????????
    db   $4f, $f7, $47, $cd, $bf, $04, $2a, $50        ;; 00:0c9f ????????
    db   $01, $c9                                      ;; 00:0ca7 ??

call_00_0ca9:
    call call_00_04a6                                  ;; 00:0ca9 $cd $a6 $04
.jr_00_0cac:
    call call_00_068f                                  ;; 00:0cac $cd $8f $06
    call call_00_0469                                  ;; 00:0caf $cd $69 $04
    ldh  A, [hFF8A]                                    ;; 00:0cb2 $f0 $8a
    and  A, A                                          ;; 00:0cb4 $a7
    jr   Z, .jr_00_0cac                                ;; 00:0cb5 $28 $f5
    jp   call_00_04a6                                  ;; 00:0cb7 $c3 $a6 $04

data_00_0cba:
    call call_00_1909                                  ;; 00:0cba $cd $09 $19
    jp   call_00_068f                                  ;; 00:0cbd $c3 $8f $06

data_00_0cc0:
    rst  rst_00_0030                                   ;; 00:0cc0 $f7
    ld   B, A                                          ;; 00:0cc1 $47
.jr_00_0cc2:
    call call_00_068f                                  ;; 00:0cc2 $cd $8f $06
    call call_00_068f                                  ;; 00:0cc5 $cd $8f $06
    dec  B                                             ;; 00:0cc8 $05
    jr   NZ, .jr_00_0cc2                               ;; 00:0cc9 $20 $f7
    ret                                                ;; 00:0ccb $c9

data_00_0ccc:
    rst  rst_00_0030                                   ;; 00:0ccc $f7
    jp   call_00_073b                                  ;; 00:0ccd $c3 $3b $07

data_00_0cd0:
    ld   DE, wD500                                     ;; 00:0cd0 $11 $00 $d5
    call call_00_0cef                                  ;; 00:0cd3 $cd $ef $0c
    ld   B, $01                                        ;; 00:0cd6 $06 $01
    call call_00_1549                                  ;; 00:0cd8 $cd $49 $15
    rst  rst_00_0030                                   ;; 00:0cdb $f7
    push AF                                            ;; 00:0cdc $f5
    ld   DE, wC7D6                                     ;; 00:0cdd $11 $d6 $c7
    ld   A, [DE]                                       ;; 00:0ce0 $1a
    ld   HL, wD400                                     ;; 00:0ce1 $21 $00 $d4
    rst  add_hl_a                                      ;; 00:0ce4 $c7
    inc  A                                             ;; 00:0ce5 $3c
    ld   [DE], A                                       ;; 00:0ce6 $12
    pop  AF                                            ;; 00:0ce7 $f1
    ld   [HL], A                                       ;; 00:0ce8 $77
    jp   jp_00_0711                                    ;; 00:0ce9 $c3 $11 $07

data_00_0cec:
    ld   DE, wC380                                     ;; 00:0cec $11 $80 $c3

call_00_0cef:
    ld   HL, wC7CA                                     ;; 00:0cef $21 $ca $c7
    ld   A, [HL]                                       ;; 00:0cf2 $7e
    inc  [HL]                                          ;; 00:0cf3 $34
    ld   L, A                                          ;; 00:0cf4 $6f
    ld   H, $00                                        ;; 00:0cf5 $26 $00
    add  HL, HL                                        ;; 00:0cf7 $29
    add  HL, DE                                        ;; 00:0cf8 $19
    ld   DE, wC7A3                                     ;; 00:0cf9 $11 $a3 $c7
    ld   A, [DE]                                       ;; 00:0cfc $1a
    inc  A                                             ;; 00:0cfd $3c
    ld   [HL+], A                                      ;; 00:0cfe $22
    dec  DE                                            ;; 00:0cff $1b
    dec  DE                                            ;; 00:0d00 $1b
    ld   A, [DE]                                       ;; 00:0d01 $1a
    dec  A                                             ;; 00:0d02 $3d
    ld   [HL], A                                       ;; 00:0d03 $77
    ret                                                ;; 00:0d04 $c9

data_00_0d05:
    rst  rst_00_0030                                   ;; 00:0d05 $f7
    cp   A, $05                                        ;; 00:0d06 $fe $05
    jr   C, .jr_00_0d1b                                ;; 00:0d08 $38 $11
    cp   A, $ff                                        ;; 00:0d0a $fe $ff
    jr   Z, .jr_00_0d18                                ;; 00:0d0c $28 $0a
    sub  A, $05                                        ;; 00:0d0e $d6 $05
    ld   HL, wC73D                                     ;; 00:0d10 $21 $3d $c7
    rst  add_hl_a                                      ;; 00:0d13 $c7
    ld   E, $c0                                        ;; 00:0d14 $1e $c0
    jr   .jr_00_0d37                                   ;; 00:0d16 $18 $1f
.jr_00_0d18:
    ld   A, [wC709]                                    ;; 00:0d18 $fa $09 $c7
.jr_00_0d1b:
    cp   A, $04                                        ;; 00:0d1b $fe $04
    jr   NZ, .jr_00_0d24                               ;; 00:0d1d $20 $05
    call call_00_0608                                  ;; 00:0d1f $cd $08 $06
    jr   Z, .jr_00_0d8a                                ;; 00:0d22 $28 $66
.jr_00_0d24:
    push AF                                            ;; 00:0d24 $f5
    call call_00_0d91                                  ;; 00:0d25 $cd $91 $0d
    ld   HL, wC204                                     ;; 00:0d28 $21 $04 $c2
    ldh  A, [hFF8B]                                    ;; 00:0d2b $f0 $8b
    and  A, A                                          ;; 00:0d2d $a7
    jr   Z, .jr_00_0d33                                ;; 00:0d2e $28 $03
    ld   HL, wD00A                                     ;; 00:0d30 $21 $0a $d0
.jr_00_0d33:
    pop  AF                                            ;; 00:0d33 $f1
    call call_00_05d9                                  ;; 00:0d34 $cd $d9 $05
.jr_00_0d37:
    ld   C, [HL]                                       ;; 00:0d37 $4e
    ld   HL, wC796                                     ;; 00:0d38 $21 $96 $c7
    ld   A, [HL]                                       ;; 00:0d3b $7e
    ld   B, A                                          ;; 00:0d3c $47
    inc  A                                             ;; 00:0d3d $3c
    cp   A, $08                                        ;; 00:0d3e $fe $08
    jr   C, .jr_00_0d43                                ;; 00:0d40 $38 $01
    xor  A, A                                          ;; 00:0d42 $af
.jr_00_0d43:
    ld   [HL], A                                       ;; 00:0d43 $77
    ld   HL, wC7A6                                     ;; 00:0d44 $21 $a6 $c7
    ld   A, B                                          ;; 00:0d47 $78
    add  A, A                                          ;; 00:0d48 $87
    add  A, A                                          ;; 00:0d49 $87
    rst  add_hl_a                                      ;; 00:0d4a $c7
    ld   A, B                                          ;; 00:0d4b $78
    or   A, E                                          ;; 00:0d4c $b3
    ld   [HL+], A                                      ;; 00:0d4d $22
    push HL                                            ;; 00:0d4e $e5
    ld   A, C                                          ;; 00:0d4f $79
    ld   HL, data_0d_6b70 ;@=ptr bank=0D               ;; 00:0d50 $21 $70 $6b
    rst  add_hl_a                                      ;; 00:0d53 $c7
    ld   A, $0d                                        ;; 00:0d54 $3e $0d
    call readFromBank                                  ;; 00:0d56 $cd $d2 $00
    ld   HL, data_01_4300 ;@=ptr bank=01               ;; 00:0d59 $21 $00 $43
    rst  add_hl_a                                      ;; 00:0d5c $c7
    ld   A, $01                                        ;; 00:0d5d $3e $01
    call readFromBank                                  ;; 00:0d5f $cd $d2 $00
    pop  HL                                            ;; 00:0d62 $e1
    cp   A, $01                                        ;; 00:0d63 $fe $01
    jr   NZ, .jr_00_0d69                               ;; 00:0d65 $20 $02
    or   A, $04                                        ;; 00:0d67 $f6 $04
.jr_00_0d69:
    ld   [HL+], A                                      ;; 00:0d69 $22
    push HL                                            ;; 00:0d6a $e5
    ld   HL, wC7A3                                     ;; 00:0d6b $21 $a3 $c7
    ld   D, [HL]                                       ;; 00:0d6e $56
    dec  HL                                            ;; 00:0d6f $2b
    dec  HL                                            ;; 00:0d70 $2b
    ld   E, [HL]                                       ;; 00:0d71 $5e
    inc  [HL]                                          ;; 00:0d72 $34
    inc  [HL]                                          ;; 00:0d73 $34
    pop  HL                                            ;; 00:0d74 $e1
    call call_00_0526                                  ;; 00:0d75 $cd $26 $05
    ld   [HL], D                                       ;; 00:0d78 $72
    inc  HL                                            ;; 00:0d79 $23
    ld   [HL], E                                       ;; 00:0d7a $73
    ld   L, B                                          ;; 00:0d7b $68
    ld   H, $00                                        ;; 00:0d7c $26 $00
    ld   DE, $8000                                     ;; 00:0d7e $11 $00 $80
    call mul_hl_128_add_de                             ;; 00:0d81 $cd $63 $00
    ld   E, L                                          ;; 00:0d84 $5d
    ld   D, H                                          ;; 00:0d85 $54
    ld   A, C                                          ;; 00:0d86 $79
    call call_00_160c                                  ;; 00:0d87 $cd $0c $16
.jr_00_0d8a:
    call call_00_079f                                  ;; 00:0d8a $cd $9f $07
    inc  HL                                            ;; 00:0d8d $23
    inc  HL                                            ;; 00:0d8e $23
    jr   jr_00_0dea                                    ;; 00:0d8f $18 $59

call_00_0d91:
    call call_00_139a                                  ;; 00:0d91 $cd $9a $13
    call call_00_05d9                                  ;; 00:0d94 $cd $d9 $05
    ld   A, [HL]                                       ;; 00:0d97 $7e
    call call_00_1648                                  ;; 00:0d98 $cd $48 $16
    ld   HL, data_0f_4240 ;@=ptr bank=0F               ;; 00:0d9b $21 $40 $42
    rst  add_hl_a                                      ;; 00:0d9e $c7
    ld   A, $0f                                        ;; 00:0d9f $3e $0f
    call readFromBank                                  ;; 00:0da1 $cd $d2 $00
    ld   E, A                                          ;; 00:0da4 $5f
    ret                                                ;; 00:0da5 $c9

call_00_0da6:
    ld   HL, wC7A1                                     ;; 00:0da6 $21 $a1 $c7
    inc  [HL]                                          ;; 00:0da9 $34
    call call_00_079f                                  ;; 00:0daa $cd $9f $07
    inc  HL                                            ;; 00:0dad $23
    jr   jr_00_0dea                                    ;; 00:0dae $18 $3a

data_00_0db0:
    ld   HL, wC7A1                                     ;; 00:0db0 $21 $a1 $c7
    dec  [HL]                                          ;; 00:0db3 $35
    call call_00_079f                                  ;; 00:0db4 $cd $9f $07
    dec  HL                                            ;; 00:0db7 $2b
    jr   jr_00_0dea                                    ;; 00:0db8 $18 $30

data_00_0dba:
    ld   HL, wC7A3                                     ;; 00:0dba $21 $a3 $c7
    dec  [HL]                                          ;; 00:0dbd $35
    ld   A, [wC77E]                                    ;; 00:0dbe $fa $7e $c7
    cpl                                                ;; 00:0dc1 $2f
    inc  A                                             ;; 00:0dc2 $3c
    ld   B, $ff                                        ;; 00:0dc3 $06 $ff
    jr   jr_00_0dd0                                    ;; 00:0dc5 $18 $09

data_00_0dc7:
    ld   HL, wC7A3                                     ;; 00:0dc7 $21 $a3 $c7
    inc  [HL]                                          ;; 00:0dca $34
    ld   A, [wC77E]                                    ;; 00:0dcb $fa $7e $c7
    ld   B, $00                                        ;; 00:0dce $06 $00

jr_00_0dd0:
    ld   C, A                                          ;; 00:0dd0 $4f
    call call_00_078d                                  ;; 00:0dd1 $cd $8d $07
    add  HL, BC                                        ;; 00:0dd4 $09
    call call_00_0796                                  ;; 00:0dd5 $cd $96 $07
    call call_00_079f                                  ;; 00:0dd8 $cd $9f $07
    add  HL, BC                                        ;; 00:0ddb $09
    jr   jr_00_0dea                                    ;; 00:0ddc $18 $0c

data_00_0dde:
    rst  rst_00_0030                                   ;; 00:0dde $f7
    ld   C, A                                          ;; 00:0ddf $4f
    ld   HL, wC7A1                                     ;; 00:0de0 $21 $a1 $c7
    add  A, [HL]                                       ;; 00:0de3 $86
    ld   [HL], A                                       ;; 00:0de4 $77
    ld   A, C                                          ;; 00:0de5 $79
    call call_00_079f                                  ;; 00:0de6 $cd $9f $07
    rst  add_hl_a                                      ;; 00:0de9 $c7

jr_00_0dea:
    jp   call_00_07aa                                  ;; 00:0dea $c3 $aa $07

call_00_0ded:
    call call_00_0df0                                  ;; 00:0ded $cd $f0 $0d

call_00_0df0:
    ld   HL, wC780                                     ;; 00:0df0 $21 $80 $c7
    ld   A, [HL-]                                      ;; 00:0df3 $3a
    ld   [HL], A                                       ;; 00:0df4 $77
    ldh  A, [hFFA0]                                    ;; 00:0df5 $f0 $a0
    and  A, A                                          ;; 00:0df7 $a7
    jr   Z, .jr_00_0e1b                                ;; 00:0df8 $28 $21
    cp   A, $04                                        ;; 00:0dfa $fe $04
    jr   NC, .jr_00_0e1b                               ;; 00:0dfc $30 $1d
    call call_00_0e30                                  ;; 00:0dfe $cd $30 $0e
    ld   DE, $9d01                                     ;; 00:0e01 $11 $01 $9d
    cp   A, $03                                        ;; 00:0e04 $fe $03
    jr   Z, .jr_00_0e0b                                ;; 00:0e06 $28 $03
    ld   DE, $9cc1                                     ;; 00:0e08 $11 $c1 $9c
.jr_00_0e0b:
    call call_00_078d                                  ;; 00:0e0b $cd $8d $07
    call call_00_038a                                  ;; 00:0e0e $cd $8a $03
    jr   NZ, .jr_00_0e1b                               ;; 00:0e11 $20 $08
    call call_00_08aa                                  ;; 00:0e13 $cd $aa $08
    call call_00_078d                                  ;; 00:0e16 $cd $8d $07
    jr   jr_00_0dea                                    ;; 00:0e19 $18 $cf
.jr_00_0e1b:
    call call_00_078d                                  ;; 00:0e1b $cd $8d $07
    ld   A, [wC77E]                                    ;; 00:0e1e $fa $7e $c7
    rst  add_hl_a                                      ;; 00:0e21 $c7
    call call_00_07aa                                  ;; 00:0e22 $cd $aa $07
    call call_00_0796                                  ;; 00:0e25 $cd $96 $07
    ld   HL, wC7A3                                     ;; 00:0e28 $21 $a3 $c7
    inc  [HL]                                          ;; 00:0e2b $34
    dec  HL                                            ;; 00:0e2c $2b
    ld   A, [HL-]                                      ;; 00:0e2d $3a
    ld   [HL], A                                       ;; 00:0e2e $77
    ret                                                ;; 00:0e2f $c9

call_00_0e30:
    push AF                                            ;; 00:0e30 $f5
    push BC                                            ;; 00:0e31 $c5
    push DE                                            ;; 00:0e32 $d5
    push HL                                            ;; 00:0e33 $e5
    ld   HL, wC764                                     ;; 00:0e34 $21 $64 $c7
    ld   A, [HL]                                       ;; 00:0e37 $7e
    and  A, A                                          ;; 00:0e38 $a7
    jr   NZ, .jr_00_0e59                               ;; 00:0e39 $20 $1e
    inc  A                                             ;; 00:0e3b $3c
    ld   [HL], A                                       ;; 00:0e3c $77
    ld   HL, wC7DE                                     ;; 00:0e3d $21 $de $c7
    ld   [HL], A                                       ;; 00:0e40 $77
    ldh  A, [hFF8B]                                    ;; 00:0e41 $f0 $8b
    and  A, A                                          ;; 00:0e43 $a7
    jr   Z, .jr_00_0e53                                ;; 00:0e44 $28 $0d
    ld   [HL], $00                                     ;; 00:0e46 $36 $00
    ld   HL, wC7A6                                     ;; 00:0e48 $21 $a6 $c7
    ld   B, $20                                        ;; 00:0e4b $06 $20
    call memclearSmall                                 ;; 00:0e4d $cd $6c $00
    call call_00_0546                                  ;; 00:0e50 $cd $46 $05
.jr_00_0e53:
    call call_00_068f                                  ;; 00:0e53 $cd $8f $06
    call call_00_0e72                                  ;; 00:0e56 $cd $72 $0e
.jr_00_0e59:
    jp   pop_all                                       ;; 00:0e59 $c3 $0b $00

call_00_0e5c:
    ld   HL, wC764                                     ;; 00:0e5c $21 $64 $c7
    ld   A, [HL]                                       ;; 00:0e5f $7e
    and  A, A                                          ;; 00:0e60 $a7
    ret  Z                                             ;; 00:0e61 $c8
    xor  A, A                                          ;; 00:0e62 $af
    ld   [HL], A                                       ;; 00:0e63 $77
    ld   [wC7DE], A                                    ;; 00:0e64 $ea $de $c7
    rst  waitForVBlank                                 ;; 00:0e67 $d7
    call call_00_068a                                  ;; 00:0e68 $cd $8a $06
    ldh  A, [rLCDC]                                    ;; 00:0e6b $f0 $40
    and  A, $c3                                        ;; 00:0e6d $e6 $c3
    ldh  [rLCDC], A                                    ;; 00:0e6f $e0 $40
    ret                                                ;; 00:0e71 $c9

call_00_0e72:
    call call_00_0e9c                                  ;; 00:0e72 $cd $9c $0e
    ld   HL, $9c41                                     ;; 00:0e75 $21 $41 $9c
    call call_00_07aa                                  ;; 00:0e78 $cd $aa $07
    call call_00_0796                                  ;; 00:0e7b $cd $96 $07
    ld   E, $50                                        ;; 00:0e7e $1e $50
    ld   BC, $1408                                     ;; 00:0e80 $01 $08 $14
    ldh  A, [hFF8B]                                    ;; 00:0e83 $f0 $8b
    and  A, A                                          ;; 00:0e85 $a7
    jr   Z, .jr_00_0e8d                                ;; 00:0e86 $28 $05
    ld   E, $40                                        ;; 00:0e88 $1e $40
    ld   BC, $140a                                     ;; 00:0e8a $01 $0a $14
.jr_00_0e8d:
    ld   HL, wC7A5                                     ;; 00:0e8d $21 $a5 $c7
    ld   [HL], E                                       ;; 00:0e90 $73
    push BC                                            ;; 00:0e91 $c5
    call call_00_0a2b                                  ;; 00:0e92 $cd $2b $0a
    pop  BC                                            ;; 00:0e95 $c1
    ld   DE, $9c00                                     ;; 00:0e96 $11 $00 $9c
    jp   jp_00_0ac2                                    ;; 00:0e99 $c3 $c2 $0a

call_00_0e9c:
    ld   A, $12                                        ;; 00:0e9c $3e $12
    ld   HL, wC77F                                     ;; 00:0e9e $21 $7f $c7
    ld   [HL+], A                                      ;; 00:0ea1 $22
    ld   [HL], A                                       ;; 00:0ea2 $77
    ret                                                ;; 00:0ea3 $c9
    db   $11, $eb, $7a, $18, $12, $11, $e8, $7a        ;; 00:0ea4 ????????
    db   $18, $0d                                      ;; 00:0eac ??

data_00_0eae:
    ld   DE, $7ae5                                     ;; 00:0eae $11 $e5 $7a
    jr   jp_00_0ebb                                    ;; 00:0eb1 $18 $08
    db   $11, $e2, $7a, $18, $03                       ;; 00:0eb3 ?????

data_00_0eb8:
    ld   DE, $7ad5                                     ;; 00:0eb8 $11 $d5 $7a

jp_00_0ebb:
    ld   A, $0f                                        ;; 00:0ebb $3e $0f
    rst  switchBankSafe                                ;; 00:0ebd $ef
    push AF                                            ;; 00:0ebe $f5
    call call_00_155a                                  ;; 00:0ebf $cd $5a $15
    pop  AF                                            ;; 00:0ec2 $f1
    rst  switchBankSafe                                ;; 00:0ec3 $ef
    ret                                                ;; 00:0ec4 $c9

data_00_0ec5:
    call call_00_0e5c                                  ;; 00:0ec5 $cd $5c $0e
    ldh  A, [hCurrentBank]                             ;; 00:0ec8 $f0 $88
    push AF                                            ;; 00:0eca $f5
    rst  rst_00_0030                                   ;; 00:0ecb $f7
    ld   [wC7F3], A                                    ;; 00:0ecc $ea $f3 $c7
    cp   A, $ff                                        ;; 00:0ecf $fe $ff
    jr   NZ, .jr_00_0ed8                               ;; 00:0ed1 $20 $05
    call call_00_191e                                  ;; 00:0ed3 $cd $1e $19
    jr   .jr_00_0edc                                   ;; 00:0ed6 $18 $04
.jr_00_0ed8:
    ld   C, A                                          ;; 00:0ed8 $4f
    call call_00_190f                                  ;; 00:0ed9 $cd $0f $19
.jr_00_0edc:
    pop  AF                                            ;; 00:0edc $f1
    rst  switchBankSafe                                ;; 00:0edd $ef
.jr_00_0ede:
    xor  A, A                                          ;; 00:0ede $af
    ld   [wC764], A                                    ;; 00:0edf $ea $64 $c7
    ld   [wC763], A                                    ;; 00:0ee2 $ea $63 $c7
    ld   [wC7DE], A                                    ;; 00:0ee5 $ea $de $c7
    cpl                                                ;; 00:0ee8 $2f
    ldh  [hFF8B], A                                    ;; 00:0ee9 $e0 $8b
    call call_00_14e3                                  ;; 00:0eeb $cd $e3 $14
    farcall call_0d_4000                               ;; 00:0eee $cd $bf $04 $00 $40 $0d
    call call_00_151c                                  ;; 00:0ef4 $cd $1c $15
    ld   A, [wC763]                                    ;; 00:0ef7 $fa $63 $c7
    and  A, A                                          ;; 00:0efa $a7
    ret  Z                                             ;; 00:0efb $c8
    ld   E, $0b                                        ;; 00:0efc $1e $0b
    call call_00_063e                                  ;; 00:0efe $cd $3e $06
    and  A, A                                          ;; 00:0f01 $a7
    jp   NZ, init                                      ;; 00:0f02 $c2 $00 $02
    ld   DE, $03                                       ;; 00:0f05 $11 $03 $00
    rst  rst_00_0020                                   ;; 00:0f08 $e7
    call call_00_1477                                  ;; 00:0f09 $cd $77 $14
    and  A, A                                          ;; 00:0f0c $a7
    jp   NZ, init                                      ;; 00:0f0d $c2 $00 $02
    ld   HL, wC2A1                                     ;; 00:0f10 $21 $a1 $c2
    ld   A, [HL]                                       ;; 00:0f13 $7e
    inc  A                                             ;; 00:0f14 $3c
    jr   Z, .jr_00_0ede                                ;; 00:0f15 $28 $c7
    ld   [HL], A                                       ;; 00:0f17 $77
    jr   .jr_00_0ede                                   ;; 00:0f18 $18 $c4
    db   $3e, $01, $ef, $f5, $cd, $21, $50, $3e        ;; 00:0f1a ????????
    db   $e4, $ea, $a0, $c2, $cd, $24, $50, $cd        ;; 00:0f22 ????????
    db   $21, $19, $f1, $ef, $c9                       ;; 00:0f2a ?????

data_00_0f2f:
    ld   A, $04                                        ;; 00:0f2f $3e $04
    ld   [wC709], A                                    ;; 00:0f31 $ea $09 $c7
    ld   HL, wC340                                     ;; 00:0f34 $21 $40 $c3
    add  A, A                                          ;; 00:0f37 $87
    rst  add_hl_a                                      ;; 00:0f38 $c7
    xor  A, A                                          ;; 00:0f39 $af
    ld   [HL+], A                                      ;; 00:0f3a $22
    ld   [HL], A                                       ;; 00:0f3b $77
    ld   E, $00                                        ;; 00:0f3c $1e $00
    call call_00_063e                                  ;; 00:0f3e $cd $3e $06
    push AF                                            ;; 00:0f41 $f5
    add  A, $e0                                        ;; 00:0f42 $c6 $e0
    call call_00_055d                                  ;; 00:0f44 $cd $5d $05
    pop  AF                                            ;; 00:0f47 $f1
    add  A, A                                          ;; 00:0f48 $87
    add  A, A                                          ;; 00:0f49 $87
    ld   HL, data_0f_6610 ;@=ptr bank=0F               ;; 00:0f4a $21 $10 $66
    rst  add_hl_a                                      ;; 00:0f4d $c7
    ld   DE, wC280                                     ;; 00:0f4e $11 $80 $c2
    ld   A, $0f                                        ;; 00:0f51 $3e $0f
    ld   B, $04                                        ;; 00:0f53 $06 $04
    jp   memcopySmallFromBank                          ;; 00:0f55 $c3 $b5 $00
    db   $cd, $bf, $04, $1e, $50, $01, $c9, $f7        ;; 00:0f58 ????????
    db   $4f, $f7, $47, $cd, $bf, $04, $27, $50        ;; 00:0f60 ????????
    db   $01, $c9, $21, $0a, $c7, $f7, $22, $f7        ;; 00:0f68 ????????
    db   $22, $36, $00, $11, $a2, $c2, $21, $0a        ;; 00:0f70 ????????
    db   $c7, $cd, $bc, $03, $d2, $a6, $03, $6b        ;; 00:0f78 ????????
    db   $62, $af, $22, $22, $77, $c9                  ;; 00:0f80 ??????

data_00_0f86:
    call call_00_0e5c                                  ;; 00:0f86 $cd $5c $0e
    call call_00_14d5                                  ;; 00:0f89 $cd $d5 $14
    farcall call_01_5006                               ;; 00:0f8c $cd $bf $04 $06 $50 $01
    ldh  A, [hCurrentBank]                             ;; 00:0f92 $f0 $88
    push AF                                            ;; 00:0f94 $f5
    call call_00_1915                                  ;; 00:0f95 $cd $15 $19
    pop  AF                                            ;; 00:0f98 $f1
    rst  switchBankSafe                                ;; 00:0f99 $ef
    jp   call_00_150a                                  ;; 00:0f9a $c3 $0a $15
    db   $f7, $5f, $d5, $cd, $ca, $14, $d1, $cf        ;; 00:0f9d ????????
    db   $cd, $bc, $18, $fe, $ff, $28, $f9, $18        ;; 00:0fa5 ????????
    db   $1b, $cd, $ca, $14, $1e, $45, $cf, $cd        ;; 00:0fad ????????
    db   $bc, $18, $fe, $ff, $28, $0e, $21, $ee        ;; 00:0fb5 ????????
    db   $7a, $c7, $3e, $0f, $cd, $d2, $00, $e0        ;; 00:0fbd ????????
    db   $b0, $ea, $1a, $c3, $c3, $ff, $14             ;; 00:0fc5 ???????

data_00_0fcc:
    inc  A                                             ;; 00:0fcc $3c
    ld   [wC77B], A                                    ;; 00:0fcd $ea $7b $c7
    rst  rst_00_0030                                   ;; 00:0fd0 $f7
    jp   jp_00_0719                                    ;; 00:0fd1 $c3 $19 $07
    db   $1e, $18, $cd, $3e, $06, $4f, $f7, $b9        ;; 00:0fd4 ????????
    db   $28, $03, $d2, $ba, $11, $6f, $26, $00        ;; 00:0fdc ????????
    db   $11, $c0, $76, $cd, $66, $00, $06, $10        ;; 00:0fe4 ????????
    db   $cd, $3e, $15, $c3, $ed, $0d                  ;; 00:0fec ??????

data_00_0ff2:
    ld   HL, wC200                                     ;; 00:0ff2 $21 $00 $c2
    ldh  A, [hFF8B]                                    ;; 00:0ff5 $f0 $8b
    and  A, A                                          ;; 00:0ff7 $a7
    jr   Z, .jr_00_0ffd                                ;; 00:0ff8 $28 $03
    ld   HL, wD002                                     ;; 00:0ffa $21 $02 $d0
.jr_00_0ffd:
    rst  rst_00_0030                                   ;; 00:0ffd $f7
    cp   A, $05                                        ;; 00:0ffe $fe $05
    jr   C, .jr_00_1027                                ;; 00:1000 $38 $25
    cp   A, $0a                                        ;; 00:1002 $fe $0a
    jr   C, .jr_00_101c                                ;; 00:1004 $38 $16
    cp   A, $0d                                        ;; 00:1006 $fe $0d
    jr   NC, .jr_00_1024                               ;; 00:1008 $30 $1a
    sub  A, $0a                                        ;; 00:100a $d6 $0a
    add  A, A                                          ;; 00:100c $87
    ld   HL, wD906                                     ;; 00:100d $21 $06 $d9
    rst  add_hl_a                                      ;; 00:1010 $c7
    ld   A, [HL]                                       ;; 00:1011 $7e
    ld   HL, wD002                                     ;; 00:1012 $21 $02 $d0
    call call_00_05d9                                  ;; 00:1015 $cd $d9 $05
    ld   B, $08                                        ;; 00:1018 $06 $08
    jr   .jr_00_102c                                   ;; 00:101a $18 $10
.jr_00_101c:
    sub  A, $05                                        ;; 00:101c $d6 $05
    call mul_a_32                                      ;; 00:101e $cd $4c $00
    rst  add_hl_a                                      ;; 00:1021 $c7
    jr   .jr_00_102a                                   ;; 00:1022 $18 $06
.jr_00_1024:
    ld   A, [wC709]                                    ;; 00:1024 $fa $09 $c7
.jr_00_1027:
    call call_00_05d9                                  ;; 00:1027 $cd $d9 $05
.jr_00_102a:
    ld   B, $04                                        ;; 00:102a $06 $04
.jr_00_102c:
    call call_00_1598                                  ;; 00:102c $cd $98 $15
    jp   jp_00_1557                                    ;; 00:102f $c3 $57 $15

data_00_1032:
    rst  rst_00_0030                                   ;; 00:1032 $f7
    cp   A, $05                                        ;; 00:1033 $fe $05
    jr   C, .jr_00_105c                                ;; 00:1035 $38 $25
    cp   A, $0d                                        ;; 00:1037 $fe $0d
    jr   C, .jr_00_1051                                ;; 00:1039 $38 $16
    cp   A, $10                                        ;; 00:103b $fe $10
    jr   C, .jr_00_106a                                ;; 00:103d $38 $2b
    cp   A, $10                                        ;; 00:103f $fe $10
    jr   Z, .jr_00_1059                                ;; 00:1041 $28 $16
    cp   A, $14                                        ;; 00:1043 $fe $14
    jr   C, .jr_00_1073                                ;; 00:1045 $38 $2c
    rst  rst_00_0030                                   ;; 00:1047 $f7
    ld   L, A                                          ;; 00:1048 $6f
    ld   B, $08                                        ;; 00:1049 $06 $08
    ld   DE, $6ec0                                     ;; 00:104b $11 $c0 $6e
    jp   jp_00_1539                                    ;; 00:104e $c3 $39 $15
.jr_00_1051:
    sub  A, $05                                        ;; 00:1051 $d6 $05
    ld   HL, wC73D                                     ;; 00:1053 $21 $3d $c7
    rst  add_hl_a                                      ;; 00:1056 $c7
    jr   .jr_00_1062                                   ;; 00:1057 $18 $09
.jr_00_1059:
    ld   A, [wC709]                                    ;; 00:1059 $fa $09 $c7
.jr_00_105c:
    ld   HL, wC204                                     ;; 00:105c $21 $04 $c2
    call call_00_05d9                                  ;; 00:105f $cd $d9 $05
.jr_00_1062:
    ld   B, $08                                        ;; 00:1062 $06 $08
    ld   DE, $6ec0                                     ;; 00:1064 $11 $c0 $6e
    jp   jp_00_1538                                    ;; 00:1067 $c3 $38 $15
.jr_00_106a:
    sub  A, $0d                                        ;; 00:106a $d6 $0d
    add  A, A                                          ;; 00:106c $87
    ld   HL, wD906                                     ;; 00:106d $21 $06 $d9
    rst  add_hl_a                                      ;; 00:1070 $c7
    jr   .jr_00_1062                                   ;; 00:1071 $18 $ef
.jr_00_1073:
    sub  A, $11                                        ;; 00:1073 $d6 $11
    ld   HL, wD500                                     ;; 00:1075 $21 $00 $d5
    add  A, H                                          ;; 00:1078 $84
    ld   H, A                                          ;; 00:1079 $67
    ld   B, $08                                        ;; 00:107a $06 $08
    ld   A, [HL]                                       ;; 00:107c $7e
    and  A, A                                          ;; 00:107d $a7
    jp   Z, call_00_1549                               ;; 00:107e $ca $49 $15
    ld   A, $0a                                        ;; 00:1081 $3e $0a
    rst  add_hl_a                                      ;; 00:1083 $c7
    jr   .jr_00_1062                                   ;; 00:1084 $18 $dc

data_00_1086:
    rst  rst_00_0030                                   ;; 00:1086 $f7
    cp   A, $10                                        ;; 00:1087 $fe $10
    jr   C, .jr_00_1098                                ;; 00:1089 $38 $0d
    cp   A, $30                                        ;; 00:108b $fe $30
    jr   NC, .jr_00_109e                               ;; 00:108d $30 $0f
    sub  A, $20                                        ;; 00:108f $d6 $20
    ld   HL, wC71D                                     ;; 00:1091 $21 $1d $c7
    add  A, A                                          ;; 00:1094 $87
    rst  add_hl_a                                      ;; 00:1095 $c7
    jr   .jr_00_10a4                                   ;; 00:1096 $18 $0c
.jr_00_1098:
    ld   HL, wC7E0                                     ;; 00:1098 $21 $e0 $c7
    rst  add_hl_a                                      ;; 00:109b $c7
    jr   .jr_00_10a4                                   ;; 00:109c $18 $06
.jr_00_109e:
    ld   A, [wC709]                                    ;; 00:109e $fa $09 $c7
    call call_00_10b3                                  ;; 00:10a1 $cd $b3 $10
.jr_00_10a4:
    ld   B, $08                                        ;; 00:10a4 $06 $08
    ld   A, [HL]                                       ;; 00:10a6 $7e
    cp   A, $ff                                        ;; 00:10a7 $fe $ff
    jp   Z, call_00_1549                               ;; 00:10a9 $ca $49 $15
    ld   L, A                                          ;; 00:10ac $6f
    ld   DE, $6e40                                     ;; 00:10ad $11 $40 $6e
    jp   jp_00_1539                                    ;; 00:10b0 $c3 $39 $15

call_00_10b3:
    call mul_a_32                                      ;; 00:10b3 $cd $4c $00
    ld   HL, wC21F                                     ;; 00:10b6 $21 $1f $c2
    rst  add_hl_a                                      ;; 00:10b9 $c7
    ret                                                ;; 00:10ba $c9

data_00_10bb:
    ld   HL, wC20F                                     ;; 00:10bb $21 $0f $c2
    ld   DE, $20                                       ;; 00:10be $11 $20 $00
    rst  rst_00_0030                                   ;; 00:10c1 $f7
    cp   A, $10                                        ;; 00:10c2 $fe $10
    jp   C, .jp_00_1141                                ;; 00:10c4 $da $41 $11
    cp   A, $20                                        ;; 00:10c7 $fe $20
    jp   C, .jp_00_113a                                ;; 00:10c9 $da $3a $11
    cp   A, $28                                        ;; 00:10cc $fe $28
    jr   C, .jr_00_1110                                ;; 00:10ce $38 $40
    cp   A, $30                                        ;; 00:10d0 $fe $30
    jr   C, .jr_00_110d                                ;; 00:10d2 $38 $39
    cp   A, $38                                        ;; 00:10d4 $fe $38
    jr   C, .jr_00_110a                                ;; 00:10d6 $38 $32
    cp   A, $40                                        ;; 00:10d8 $fe $40
    jr   C, .jr_00_1107                                ;; 00:10da $38 $2b
    cp   A, $48                                        ;; 00:10dc $fe $48
    jr   C, .jr_00_1104                                ;; 00:10de $38 $24
    cp   A, $51                                        ;; 00:10e0 $fe $51
    jr   C, .jr_00_1115                                ;; 00:10e2 $38 $31
    cp   A, $63                                        ;; 00:10e4 $fe $63
    jr   NC, .jr_00_10fa                               ;; 00:10e6 $30 $12
    sub  A, $60                                        ;; 00:10e8 $d6 $60
    ld   HL, wD906                                     ;; 00:10ea $21 $06 $d9
    add  A, A                                          ;; 00:10ed $87
    rst  add_hl_a                                      ;; 00:10ee $c7
    ld   A, [HL+]                                      ;; 00:10ef $2a
    ld   H, [HL]                                       ;; 00:10f0 $66
    ld   L, A                                          ;; 00:10f1 $6f
    ld   B, $08                                        ;; 00:10f2 $06 $08
    ld   DE, $6640                                     ;; 00:10f4 $11 $40 $66
    jp   jp_00_153b                                    ;; 00:10f7 $c3 $3b $15
.jr_00_10fa:
    rst  rst_00_0030                                   ;; 00:10fa $f7
    ld   B, $08                                        ;; 00:10fb $06 $08
    ld   L, A                                          ;; 00:10fd $6f
    ld   DE, $6640                                     ;; 00:10fe $11 $40 $66
    jp   jp_00_1539                                    ;; 00:1101 $c3 $39 $15
.jr_00_1104:
    sub  A, $08                                        ;; 00:1104 $d6 $08
    add  HL, DE                                        ;; 00:1106 $19
.jr_00_1107:
    sub  A, $08                                        ;; 00:1107 $d6 $08
    add  HL, DE                                        ;; 00:1109 $19
.jr_00_110a:
    sub  A, $08                                        ;; 00:110a $d6 $08
    add  HL, DE                                        ;; 00:110c $19
.jr_00_110d:
    sub  A, $08                                        ;; 00:110d $d6 $08
    add  HL, DE                                        ;; 00:110f $19
.jr_00_1110:
    sub  A, $20                                        ;; 00:1110 $d6 $20
    add  HL, DE                                        ;; 00:1112 $19
    jr   .jr_00_1144                                   ;; 00:1113 $18 $2f
.jr_00_1115:
    sub  A, $48                                        ;; 00:1115 $d6 $48
    ld   B, A                                          ;; 00:1117 $47
    ldh  A, [hFF8B]                                    ;; 00:1118 $f0 $8b
    and  A, A                                          ;; 00:111a $a7
    jr   Z, .jr_00_112e                                ;; 00:111b $28 $11
    call call_00_1622                                  ;; 00:111d $cd $22 $16
    ld   B, $08                                        ;; 00:1120 $06 $08
    jp   NC, call_00_1549                              ;; 00:1122 $d2 $49 $15
    ld   A, [HL+]                                      ;; 00:1125 $2a
    ld   H, [HL]                                       ;; 00:1126 $66
    ld   L, A                                          ;; 00:1127 $6f
    ld   DE, $6640                                     ;; 00:1128 $11 $40 $66
    jp   jp_00_153b                                    ;; 00:112b $c3 $3b $15
.jr_00_112e:
    ld   A, [wC709]                                    ;; 00:112e $fa $09 $c7
    ld   HL, wC20F                                     ;; 00:1131 $21 $0f $c2
    call call_00_05d9                                  ;; 00:1134 $cd $d9 $05
    ld   A, B                                          ;; 00:1137 $78
    jr   .jr_00_1144                                   ;; 00:1138 $18 $0a
.jp_00_113a:
    sub  A, $10                                        ;; 00:113a $d6 $10
    ld   HL, wC2B9                                     ;; 00:113c $21 $b9 $c2
    jr   .jr_00_1144                                   ;; 00:113f $18 $03
.jp_00_1141:
    ld   HL, wC71D                                     ;; 00:1141 $21 $1d $c7
.jr_00_1144:
    add  A, A                                          ;; 00:1144 $87
    ld   DE, $6640                                     ;; 00:1145 $11 $40 $66
    rst  add_hl_a                                      ;; 00:1148 $c7
    ld   B, $08                                        ;; 00:1149 $06 $08
    ld   A, [HL]                                       ;; 00:114b $7e
    inc  A                                             ;; 00:114c $3c
    jp   Z, call_00_1549                               ;; 00:114d $ca $49 $15
    jp   jp_00_1538                                    ;; 00:1150 $c3 $38 $15

data_00_1153:
    rst  rst_00_0030                                   ;; 00:1153 $f7
    cp   A, $10                                        ;; 00:1154 $fe $10
    jr   C, .jr_00_115b                                ;; 00:1156 $38 $03
    ld   A, [wC7D9]                                    ;; 00:1158 $fa $d9 $c7
.jr_00_115b:
    ld   D, A                                          ;; 00:115b $57
    ld   E, $ff                                        ;; 00:115c $1e $ff
.jr_00_115e:
    inc  E                                             ;; 00:115e $1c
    ld   A, E                                          ;; 00:115f $7b
    cp   A, $10                                        ;; 00:1160 $fe $10
    jr   NC, jr_00_11ba                                ;; 00:1162 $30 $56
    call call_00_066e                                  ;; 00:1164 $cd $6e $06
    jr   Z, .jr_00_115e                                ;; 00:1167 $28 $f5
    ld   HL, wC7DA                                     ;; 00:1169 $21 $da $c7
    ld   A, [HL]                                       ;; 00:116c $7e
    inc  [HL]                                          ;; 00:116d $34
    ld   HL, wC71D                                     ;; 00:116e $21 $1d $c7
    rst  add_hl_a                                      ;; 00:1171 $c7
    ld   [HL], D                                       ;; 00:1172 $72
    push DE                                            ;; 00:1173 $d5
    ld   B, $01                                        ;; 00:1174 $06 $01
    call call_00_1549                                  ;; 00:1176 $cd $49 $15
    pop  DE                                            ;; 00:1179 $d1
    ld   HL, $4250                                     ;; 00:117a $21 $50 $42
    ld   A, D                                          ;; 00:117d $7a
    call call_00_11ab                                  ;; 00:117e $cd $ab $11
    jp   call_00_0ded                                  ;; 00:1181 $c3 $ed $0d

data_00_1184:
    ld   A, [wC7D9]                                    ;; 00:1184 $fa $d9 $c7
    ld   D, A                                          ;; 00:1187 $57
    ld   A, [wC7F2]                                    ;; 00:1188 $fa $f2 $c7
    ld   E, A                                          ;; 00:118b $5f
    call call_00_066e                                  ;; 00:118c $cd $6e $06
    ret  Z                                             ;; 00:118f $c8
    call call_00_0e9c                                  ;; 00:1190 $cd $9c $0e
    ld   HL, hFFA0                                     ;; 00:1193 $21 $a0 $ff
    ld   A, [HL]                                       ;; 00:1196 $7e
    push AF                                            ;; 00:1197 $f5
    ld   [HL], $05                                     ;; 00:1198 $36 $05
    call call_00_11a1                                  ;; 00:119a $cd $a1 $11
    pop  AF                                            ;; 00:119d $f1
    ldh  [hFFA0], A                                    ;; 00:119e $e0 $a0
    ret                                                ;; 00:11a0 $c9

call_00_11a1:
    ld   L, D                                          ;; 00:11a1 $6a
    ld   H, $00                                        ;; 00:11a2 $26 $00
    ld   BC, $4270                                     ;; 00:11a4 $01 $70 $42
    call mul_hl_32_add_bc                              ;; 00:11a7 $cd $5c $00
    ld   A, E                                          ;; 00:11aa $7b

call_00_11ab:
    add  A, A                                          ;; 00:11ab $87
    rst  add_hl_a                                      ;; 00:11ac $c7
    ld   A, $0f                                        ;; 00:11ad $3e $0f
    rst  switchBankSafe                                ;; 00:11af $ef
    push AF                                            ;; 00:11b0 $f5
    ld   E, [HL]                                       ;; 00:11b1 $5e
    inc  HL                                            ;; 00:11b2 $23
    ld   D, [HL]                                       ;; 00:11b3 $56
    call call_00_155a                                  ;; 00:11b4 $cd $5a $15
    pop  AF                                            ;; 00:11b7 $f1
    rst  switchBankSafe                                ;; 00:11b8 $ef
    ret                                                ;; 00:11b9 $c9

jr_00_11ba:
    ld   DE, wC380                                     ;; 00:11ba $11 $80 $c3
    ld   HL, wC7CA                                     ;; 00:11bd $21 $ca $c7
    dec  [HL]                                          ;; 00:11c0 $35
    ld   L, [HL]                                       ;; 00:11c1 $6e
    ld   H, $00                                        ;; 00:11c2 $26 $00
    add  HL, HL                                        ;; 00:11c4 $29
    add  HL, DE                                        ;; 00:11c5 $19
    ld   A, $ff                                        ;; 00:11c6 $3e $ff
    ld   [HL+], A                                      ;; 00:11c8 $22
    ld   [HL], A                                       ;; 00:11c9 $77
    ret                                                ;; 00:11ca $c9

data_00_11cb:
    ld   HL, wC207                                     ;; 00:11cb $21 $07 $c2
    ldh  A, [hFF8B]                                    ;; 00:11ce $f0 $8b
    and  A, A                                          ;; 00:11d0 $a7
    jr   Z, .jr_00_11d6                                ;; 00:11d1 $28 $03
    ld   HL, wD041                                     ;; 00:11d3 $21 $41 $d0
.jr_00_11d6:
    jr   jr_00_1201                                    ;; 00:11d6 $18 $29

data_00_11d8:
    call call_00_139a                                  ;; 00:11d8 $cd $9a $13
    call call_00_13b6                                  ;; 00:11db $cd $b6 $13
    ld   C, A                                          ;; 00:11de $4f
    call call_00_05d9                                  ;; 00:11df $cd $d9 $05
    ld   A, [HL]                                       ;; 00:11e2 $7e
    call call_00_1648                                  ;; 00:11e3 $cd $48 $16
    and  A, A                                          ;; 00:11e6 $a7
    jr   NZ, .jr_00_11f2                               ;; 00:11e7 $20 $09
    call call_00_0da6                                  ;; 00:11e9 $cd $a6 $0d
    call call_00_13a8                                  ;; 00:11ec $cd $a8 $13
    ld   A, C                                          ;; 00:11ef $79
    jr   jr_00_1204                                    ;; 00:11f0 $18 $12
.jr_00_11f2:
    dec  A                                             ;; 00:11f2 $3d
    add  A, A                                          ;; 00:11f3 $87
    add  A, A                                          ;; 00:11f4 $87
    ld   HL, $7840                                     ;; 00:11f5 $21 $40 $78
    rst  add_hl_a                                      ;; 00:11f8 $c7
    ld   B, $04                                        ;; 00:11f9 $06 $04
    jp   jp_00_153e                                    ;; 00:11fb $c3 $3e $15

data_00_11fe:
    call call_00_13a8                                  ;; 00:11fe $cd $a8 $13

jr_00_1201:
    call call_00_13b6                                  ;; 00:1201 $cd $b6 $13

jr_00_1204:
    call call_00_05d9                                  ;; 00:1204 $cd $d9 $05
    ld   A, [HL+]                                      ;; 00:1207 $2a
    ld   H, [HL]                                       ;; 00:1208 $66
    ld   L, A                                          ;; 00:1209 $6f
    ld   DE, $3e8                                      ;; 00:120a $11 $e8 $03
    call call_00_038a                                  ;; 00:120d $cd $8a $03
    jr   C, .jr_00_1215                                ;; 00:1210 $38 $03
    ld   HL, $3e7                                      ;; 00:1212 $21 $e7 $03
.jr_00_1215:
    call call_00_15b5                                  ;; 00:1215 $cd $b5 $15
    ld   HL, wC787                                     ;; 00:1218 $21 $87 $c7
    jp   jp_00_157a                                    ;; 00:121b $c3 $7a $15

data_00_121e:
    rst  rst_00_0030                                   ;; 00:121e $f7
    cp   A, $10                                        ;; 00:121f $fe $10
    jr   C, .jr_00_122b                                ;; 00:1221 $38 $08
    ld   A, [wC709]                                    ;; 00:1223 $fa $09 $c7
    call call_00_10b3                                  ;; 00:1226 $cd $b3 $10
    jr   .jr_00_122f                                   ;; 00:1229 $18 $04
.jr_00_122b:
    ld   HL, wC7E0                                     ;; 00:122b $21 $e0 $c7
    rst  add_hl_a                                      ;; 00:122e $c7
.jr_00_122f:
    ld   B, $01                                        ;; 00:122f $06 $01
    ld   A, [HL]                                       ;; 00:1231 $7e
    cp   A, $ff                                        ;; 00:1232 $fe $ff
    jp   Z, call_00_1549                               ;; 00:1234 $ca $49 $15
    add  A, A                                          ;; 00:1237 $87
    ld   HL, wC2DA                                     ;; 00:1238 $21 $da $c2
    rst  add_hl_a                                      ;; 00:123b $c7
    ld   A, [HL]                                       ;; 00:123c $7e
    and  A, $0f                                        ;; 00:123d $e6 $0f
    ld   L, A                                          ;; 00:123f $6f
    ld   H, $00                                        ;; 00:1240 $26 $00
    call call_00_15b5                                  ;; 00:1242 $cd $b5 $15
    ld   HL, wC789                                     ;; 00:1245 $21 $89 $c7
    jp   jp_00_157a                                    ;; 00:1248 $c3 $7a $15

data_00_124b:
    ld   HL, $00                                       ;; 00:124b $21 $00 $00
    ld   DE, $20                                       ;; 00:124e $11 $20 $00
    rst  rst_00_0030                                   ;; 00:1251 $f7
    cp   A, $10                                        ;; 00:1252 $fe $10
    jr   C, .jr_00_12ab                                ;; 00:1254 $38 $55
    cp   A, $20                                        ;; 00:1256 $fe $20
    jr   C, .jr_00_12a4                                ;; 00:1258 $38 $4a
    cp   A, $28                                        ;; 00:125a $fe $28
    jr   C, .jr_00_129c                                ;; 00:125c $38 $3e
    cp   A, $30                                        ;; 00:125e $fe $30
    jr   C, .jr_00_1299                                ;; 00:1260 $38 $37
    cp   A, $38                                        ;; 00:1262 $fe $38
    jr   C, .jr_00_1296                                ;; 00:1264 $38 $30
    cp   A, $40                                        ;; 00:1266 $fe $40
    jr   C, .jr_00_1293                                ;; 00:1268 $38 $29
    cp   A, $48                                        ;; 00:126a $fe $48
    jr   C, .jr_00_1290                                ;; 00:126c $38 $22
    sub  A, $48                                        ;; 00:126e $d6 $48
    ld   B, A                                          ;; 00:1270 $47
    ldh  A, [hFF8B]                                    ;; 00:1271 $f0 $8b
    and  A, A                                          ;; 00:1273 $a7
    ld   A, B                                          ;; 00:1274 $78
    jr   Z, .jr_00_1283                                ;; 00:1275 $28 $0c
    call call_00_1622                                  ;; 00:1277 $cd $22 $16
    ld   B, $02                                        ;; 00:127a $06 $02
    jp   NC, call_00_1549                              ;; 00:127c $d2 $49 $15
    inc  HL                                            ;; 00:127f $23
    inc  HL                                            ;; 00:1280 $23
    jr   .jr_00_12b7                                   ;; 00:1281 $18 $34
.jr_00_1283:
    ld   HL, wC20F                                     ;; 00:1283 $21 $0f $c2
    add  A, A                                          ;; 00:1286 $87
    rst  add_hl_a                                      ;; 00:1287 $c7
    ld   A, [wC709]                                    ;; 00:1288 $fa $09 $c7
    call call_00_05d9                                  ;; 00:128b $cd $d9 $05
    jr   .jr_00_12b0                                   ;; 00:128e $18 $20
.jr_00_1290:
    sub  A, $08                                        ;; 00:1290 $d6 $08
    add  HL, DE                                        ;; 00:1292 $19
.jr_00_1293:
    sub  A, $08                                        ;; 00:1293 $d6 $08
    add  HL, DE                                        ;; 00:1295 $19
.jr_00_1296:
    sub  A, $08                                        ;; 00:1296 $d6 $08
    add  HL, DE                                        ;; 00:1298 $19
.jr_00_1299:
    sub  A, $08                                        ;; 00:1299 $d6 $08
    add  HL, DE                                        ;; 00:129b $19
.jr_00_129c:
    ld   DE, wC20F                                     ;; 00:129c $11 $0f $c2
    sub  A, $20                                        ;; 00:129f $d6 $20
    add  HL, DE                                        ;; 00:12a1 $19
    jr   .jr_00_12ae                                   ;; 00:12a2 $18 $0a
.jr_00_12a4:
    sub  A, $10                                        ;; 00:12a4 $d6 $10
    ld   HL, wC2B9                                     ;; 00:12a6 $21 $b9 $c2
    jr   .jr_00_12ae                                   ;; 00:12a9 $18 $03
.jr_00_12ab:
    ld   HL, wC71D                                     ;; 00:12ab $21 $1d $c7
.jr_00_12ae:
    add  A, A                                          ;; 00:12ae $87
    rst  add_hl_a                                      ;; 00:12af $c7
.jr_00_12b0:
    ld   B, $02                                        ;; 00:12b0 $06 $02
    ld   A, [HL+]                                      ;; 00:12b2 $2a
    inc  A                                             ;; 00:12b3 $3c
    jp   Z, call_00_1549                               ;; 00:12b4 $ca $49 $15
.jr_00_12b7:
    ld   A, [HL]                                       ;; 00:12b7 $7e
    cp   A, $fe                                        ;; 00:12b8 $fe $fe
    jr   NZ, jp_00_12e6                                ;; 00:12ba $20 $2a
    ld   DE, $7ad2                                     ;; 00:12bc $11 $d2 $7a
    jp   jp_00_0ebb                                    ;; 00:12bf $c3 $bb $0e

data_00_12c2:
    ld   HL, wC20B                                     ;; 00:12c2 $21 $0b $c2
    jr   jr_00_12d4                                    ;; 00:12c5 $18 $0d

data_00_12c7:
    ld   HL, wC20E                                     ;; 00:12c7 $21 $0e $c2
    jr   jr_00_12d4                                    ;; 00:12ca $18 $08

data_00_12cc:
    ld   HL, wC20C                                     ;; 00:12cc $21 $0c $c2
    jr   jr_00_12d4                                    ;; 00:12cf $18 $03

data_00_12d1:
    ld   HL, wC20D                                     ;; 00:12d1 $21 $0d $c2

jr_00_12d4:
    call call_00_13b6                                  ;; 00:12d4 $cd $b6 $13
    call call_00_05d9                                  ;; 00:12d7 $cd $d9 $05
    jr   jp_00_12e6                                    ;; 00:12da $18 $0a

data_00_12dc:
    ld   HL, wC2D9                                     ;; 00:12dc $21 $d9 $c2
    jr   jp_00_12e6                                    ;; 00:12df $18 $05

data_00_12e1:
    rst  rst_00_0030                                   ;; 00:12e1 $f7
    ld   HL, wC70D                                     ;; 00:12e2 $21 $0d $c7
    rst  add_hl_a                                      ;; 00:12e5 $c7

jp_00_12e6:
    ld   A, [HL]                                       ;; 00:12e6 $7e
    cp   A, $64                                        ;; 00:12e7 $fe $64
    jr   C, .jr_00_12ed                                ;; 00:12e9 $38 $02
    ld   A, $63                                        ;; 00:12eb $3e $63
.jr_00_12ed:
    ld   L, A                                          ;; 00:12ed $6f
    ld   H, $00                                        ;; 00:12ee $26 $00
    call call_00_15b5                                  ;; 00:12f0 $cd $b5 $15
    ld   HL, wC788                                     ;; 00:12f3 $21 $88 $c7
    jp   jp_00_157a                                    ;; 00:12f6 $c3 $7a $15
    db   $cd, $13, $13, $21, $85, $c7, $f7, $c6        ;; 00:12f9 ????????
    db   $02, $47, $3e, $08, $90, $c7, $c3, $7a        ;; 00:1301 ????????
    db   $15                                           ;; 00:1309 ?

data_00_130a:
    call call_00_1313                                  ;; 00:130a $cd $13 $13
    ld   HL, wC785                                     ;; 00:130d $21 $85 $c7
    jp   jp_00_157a                                    ;; 00:1310 $c3 $7a $15

call_00_1313:
    ld   HL, wC2A2                                     ;; 00:1313 $21 $a2 $c2
    rst  rst_00_0030                                   ;; 00:1316 $f7
    and  A, A                                          ;; 00:1317 $a7
    jr   Z, .jr_00_1322                                ;; 00:1318 $28 $08
    dec  A                                             ;; 00:131a $3d
    ld   C, A                                          ;; 00:131b $4f
    add  A, A                                          ;; 00:131c $87
    add  A, C                                          ;; 00:131d $81
    ld   HL, wC745                                     ;; 00:131e $21 $45 $c7
    rst  add_hl_a                                      ;; 00:1321 $c7
.jr_00_1322:
    ld   A, [HL+]                                      ;; 00:1322 $2a
    and  A, [HL]                                       ;; 00:1323 $a6
    inc  HL                                            ;; 00:1324 $23
    and  A, [HL]                                       ;; 00:1325 $a6
    dec  HL                                            ;; 00:1326 $2b
    dec  HL                                            ;; 00:1327 $2b
    inc  A                                             ;; 00:1328 $3c
    jr   NZ, .jr_00_1334                               ;; 00:1329 $20 $09
    dec  A                                             ;; 00:132b $3d
    ld   B, $08                                        ;; 00:132c $06 $08
    call memsetSmall                                   ;; 00:132e $cd $6d $00
    xor  A, A                                          ;; 00:1331 $af
    ld   [HL], A                                       ;; 00:1332 $77
    ret                                                ;; 00:1333 $c9
.jr_00_1334:
    ld   DE, $1469                                     ;; 00:1334 $11 $69 $14
    call call_00_03bc                                  ;; 00:1337 $cd $bc $03
    jr   NC, .jr_00_133f                               ;; 00:133a $30 $03
    ld   HL, $1469                                     ;; 00:133c $21 $69 $14
.jr_00_133f:
    ld   DE, wC70A                                     ;; 00:133f $11 $0a $c7
    ld   B, $03                                        ;; 00:1342 $06 $03
    push DE                                            ;; 00:1344 $d5
    call memcopySmall                                  ;; 00:1345 $cd $80 $00
    pop  DE                                            ;; 00:1348 $d1
    ld   BC, wC785                                     ;; 00:1349 $01 $85 $c7
    ld   HL, $145a                                     ;; 00:134c $21 $5a $14
    ld   A, $05                                        ;; 00:134f $3e $05
.jr_00_1351:
    ldh  [hFF92], A                                    ;; 00:1351 $e0 $92
    xor  A, A                                          ;; 00:1353 $af
.jr_00_1354:
    call call_00_03a6                                  ;; 00:1354 $cd $a6 $03
    inc  A                                             ;; 00:1357 $3c
    jr   NC, .jr_00_1354                               ;; 00:1358 $30 $fa
    dec  A                                             ;; 00:135a $3d
    call call_00_0390                                  ;; 00:135b $cd $90 $03
    ld   [BC], A                                       ;; 00:135e $02
    inc  BC                                            ;; 00:135f $03
    inc  HL                                            ;; 00:1360 $23
    inc  HL                                            ;; 00:1361 $23
    inc  HL                                            ;; 00:1362 $23
    ldh  A, [hFF92]                                    ;; 00:1363 $f0 $92
    dec  A                                             ;; 00:1365 $3d
    jr   NZ, .jr_00_1351                               ;; 00:1366 $20 $e9
    ld   A, [DE]                                       ;; 00:1368 $1a
    ld   [BC], A                                       ;; 00:1369 $02
    ld   B, $06                                        ;; 00:136a $06 $06
    call call_00_15ba                                  ;; 00:136c $cd $ba $15
    ld   [HL], $c0                                     ;; 00:136f $36 $c0
    inc  HL                                            ;; 00:1371 $23
    ld   [HL], $c9                                     ;; 00:1372 $36 $c9
    inc  HL                                            ;; 00:1374 $23
    ld   [HL], $00                                     ;; 00:1375 $36 $00
    ret                                                ;; 00:1377 $c9

data_00_1378:
    ld   HL, wD900                                     ;; 00:1378 $21 $00 $d9
    rst  rst_00_0030                                   ;; 00:137b $f7
    add  A, A                                          ;; 00:137c $87
    rst  add_hl_a                                      ;; 00:137d $c7
    ld   A, [HL+]                                      ;; 00:137e $2a
    ld   H, [HL]                                       ;; 00:137f $66
    ld   L, A                                          ;; 00:1380 $6f
    call call_00_15b5                                  ;; 00:1381 $cd $b5 $15
    ld   HL, wC785                                     ;; 00:1384 $21 $85 $c7
    jp   jp_00_157a                                    ;; 00:1387 $c3 $7a $15

data_00_138a:
    rst  rst_00_0030                                   ;; 00:138a $f7
    ld   B, $02                                        ;; 00:138b $06 $02
    ld   HL, wD500                                     ;; 00:138d $21 $00 $d5
    add  A, H                                          ;; 00:1390 $84
    ld   H, A                                          ;; 00:1391 $67
    ld   A, [HL+]                                      ;; 00:1392 $2a
    and  A, A                                          ;; 00:1393 $a7
    jp   Z, call_00_1549                               ;; 00:1394 $ca $49 $15
    jp   jp_00_12e6                                    ;; 00:1397 $c3 $e6 $12

call_00_139a:
    push AF                                            ;; 00:139a $f5
    ld   HL, wC206                                     ;; 00:139b $21 $06 $c2
    ldh  A, [hFF8B]                                    ;; 00:139e $f0 $8b
    and  A, A                                          ;; 00:13a0 $a7
    jr   Z, .jr_00_13a6                                ;; 00:13a1 $28 $03
    ld   HL, wD040                                     ;; 00:13a3 $21 $40 $d0
.jr_00_13a6:
    pop  AF                                            ;; 00:13a6 $f1
    ret                                                ;; 00:13a7 $c9

call_00_13a8:
    push AF                                            ;; 00:13a8 $f5
    ld   HL, wC209                                     ;; 00:13a9 $21 $09 $c2
    ldh  A, [hFF8B]                                    ;; 00:13ac $f0 $8b
    and  A, A                                          ;; 00:13ae $a7
    jr   Z, .jr_00_13b4                                ;; 00:13af $28 $03
    ld   HL, wD00C                                     ;; 00:13b1 $21 $0c $d0
.jr_00_13b4:
    pop  AF                                            ;; 00:13b4 $f1
    ret                                                ;; 00:13b5 $c9

call_00_13b6:
    rst  rst_00_0030                                   ;; 00:13b6 $f7
    cp   A, $05                                        ;; 00:13b7 $fe $05
    ret  C                                             ;; 00:13b9 $d8
    ld   A, [wC709]                                    ;; 00:13ba $fa $09 $c7
    ret                                                ;; 00:13bd $c9
    dw   data_00_0b0f                                  ;; 00:13be pP
    dw   call_00_0da6                                  ;; 00:13c0 pP
    dw   data_00_0db0                                  ;; 00:13c2 pP
    dw   data_00_0dba                                  ;; 00:13c4 pP
    dw   data_00_0dc7                                  ;; 00:13c6 pP
    dw   call_00_0df0                                  ;; 00:13c8 pP
    dw   call_00_0ded                                  ;; 00:13ca pP
    dw   data_00_0ccc                                  ;; 00:13cc pP
    dw   data_00_0d05                                  ;; 00:13ce pP
    dw   data_00_0ec5                                  ;; 00:13d0 pP
    dw   data_00_0eb8                                  ;; 00:13d2 pP
    dw   call_00_0ca9                                  ;; 00:13d4 pP
    db   $30, $0e                                      ;; 00:13d6 ??
    dw   call_00_0e5c                                  ;; 00:13d8 pP
    dw   data_00_0b0f                                  ;; 00:13da pP
    db   $72, $0e                                      ;; 00:13dc ??
    dw   data_00_0cba                                  ;; 00:13de pP
    dw   data_00_0cc0                                  ;; 00:13e0 pP
    dw   data_00_0b32                                  ;; 00:13e2 pP
    dw   data_00_0b3c                                  ;; 00:13e4 pP
    dw   data_00_0b4b                                  ;; 00:13e6 pP
    dw   data_00_0bb6                                  ;; 00:13e8 pP
    db   $00, $0c, $72, $0b                            ;; 00:13ea ????
    dw   call_00_0b50                                  ;; 00:13ee pP
    dw   data_00_1490                                  ;; 00:13f0 pP
    db   $ce, $0b, $d8, $0b                            ;; 00:13f2 ????
    dw   data_00_1086                                  ;; 00:13f6 pP
    dw   data_00_121e                                  ;; 00:13f8 pP
    dw   data_00_130a                                  ;; 00:13fa pP
    dw   data_00_0ff2                                  ;; 00:13fc pP
    dw   data_00_0fcc                                  ;; 00:13fe pP
    dw   data_00_1032                                  ;; 00:1400 pP
    dw   data_00_10bb                                  ;; 00:1402 pP
    dw   data_00_124b                                  ;; 00:1404 pP
    dw   data_00_11cb                                  ;; 00:1406 pP
    dw   data_00_11fe                                  ;; 00:1408 pP
    dw   data_00_12e1                                  ;; 00:140a pP
    dw   data_00_12c2                                  ;; 00:140c pP
    dw   data_00_12c7                                  ;; 00:140e pP
    dw   data_00_12cc                                  ;; 00:1410 pP
    dw   data_00_12d1                                  ;; 00:1412 pP
    db   $4b, $12                                      ;; 00:1414 ??
    dw   data_00_12dc                                  ;; 00:1416 pP
    db   $d4, $0f                                      ;; 00:1418 ??
    dw   data_00_0cec                                  ;; 00:141a pP
    db   $b3, $0e                                      ;; 00:141c ??
    dw   data_00_1378                                  ;; 00:141e pP
    dw   data_00_0b31                                  ;; 00:1420 pP
    db   $9d, $0f, $6a, $0f                            ;; 00:1422 ????
    dw   data_00_0f86                                  ;; 00:1426 pP
    db   $f9, $12                                      ;; 00:1428 ??
    dw   data_00_0dde                                  ;; 00:142a pP
    dw   data_00_0be4                                  ;; 00:142c pP
    dw   data_00_0f2f                                  ;; 00:142e pP
    dw   data_00_0cd0                                  ;; 00:1430 pP
    dw   data_00_138a                                  ;; 00:1432 pP
    dw   data_00_11d8                                  ;; 00:1434 pP
    dw   data_00_0eae                                  ;; 00:1436 pP
    db   $a9, $0e, $58, $0f, $5f, $0f, $5b, $0b        ;; 00:1438 ????????
    dw   data_00_1153                                  ;; 00:1440 pP
    dw   data_00_1184                                  ;; 00:1442 pP
    db   $9b, $0b, $ef, $0b, $f7, $0b, $1a, $0f        ;; 00:1444 ????????
    db   $ae, $0f, $9e, $0c, $27, $0c, $6c, $14        ;; 00:144c ????????
    dw   data_00_0c21                                  ;; 00:1454 pP
    db   $1b, $0c, $0f, $0c, $a0, $86, $01, $10        ;; 00:1456 ????????
    db   $27, $00, $e8, $03, $00, $64, $00, $00        ;; 00:145e ????????
    db   $0a, $00, $00, $3f, $42, $0f, $3e, $03        ;; 00:1466 ???...??
    db   $ea, $65, $c7, $3e, $04, $ea, $1b, $c3        ;; 00:146e ????????
    db   $c9                                           ;; 00:1476 ?

call_00_1477:
    call call_00_14ca                                  ;; 00:1477 $cd $ca $14
    call call_00_04a6                                  ;; 00:147a $cd $a6 $04
    ld   E, $12                                        ;; 00:147d $1e $12
    rst  rst_00_0008                                   ;; 00:147f $cf
.jr_00_1480:
    call call_00_18bc                                  ;; 00:1480 $cd $bc $18
    cp   A, $ff                                        ;; 00:1483 $fe $ff
    jr   Z, .jr_00_1480                                ;; 00:1485 $28 $f9
    call call_00_04a6                                  ;; 00:1487 $cd $a6 $04
    push AF                                            ;; 00:148a $f5
    call call_00_14ff                                  ;; 00:148b $cd $ff $14
    pop  AF                                            ;; 00:148e $f1
    ret                                                ;; 00:148f $c9

data_00_1490:
    ld   HL, hFFA2                                     ;; 00:1490 $21 $a2 $ff
    ld   A, [HL+]                                      ;; 00:1493 $2a
    ld   H, [HL]                                       ;; 00:1494 $66
    ld   L, A                                          ;; 00:1495 $6f
    rst  rst_00_0030                                   ;; 00:1496 $f7
    ld   D, A                                          ;; 00:1497 $57
    rst  rst_00_0030                                   ;; 00:1498 $f7
    ld   E, A                                          ;; 00:1499 $5f
    ld   A, D                                          ;; 00:149a $7a
    cp   A, $04                                        ;; 00:149b $fe $04
    jp   C, jp_00_0800                                 ;; 00:149d $da $00 $08
    cp   A, $04                                        ;; 00:14a0 $fe $04
    jr   Z, jp_00_14ac                                 ;; 00:14a2 $28 $08
    call call_00_1906                                  ;; 00:14a4 $cd $06 $19
    ld   E, L                                          ;; 00:14a7 $5d
    ld   D, H                                          ;; 00:14a8 $54
    jp   call_00_07be                                  ;; 00:14a9 $c3 $be $07

jp_00_14ac:
    push AF                                            ;; 00:14ac $f5
    push BC                                            ;; 00:14ad $c5
    push DE                                            ;; 00:14ae $d5
    push HL                                            ;; 00:14af $e5
    push DE                                            ;; 00:14b0 $d5
    call call_00_0e5c                                  ;; 00:14b1 $cd $5c $0e
    call call_00_14d5                                  ;; 00:14b4 $cd $d5 $14
    pop  DE                                            ;; 00:14b7 $d1
    ld   A, $01                                        ;; 00:14b8 $3e $01
    rst  switchBankSafe                                ;; 00:14ba $ef
    push AF                                            ;; 00:14bb $f5
    call call_01_5009 ;@bank 1                         ;; 00:14bc $cd $09 $50
    call call_00_191b                                  ;; 00:14bf $cd $1b $19
    pop  AF                                            ;; 00:14c2 $f1
    rst  switchBankSafe                                ;; 00:14c3 $ef
    call call_00_150a                                  ;; 00:14c4 $cd $0a $15
    jp   pop_all                                       ;; 00:14c7 $c3 $0b $00

call_00_14ca:
    ld   B, $00                                        ;; 00:14ca $06 $00
    ld   HL, $9c00                                     ;; 00:14cc $21 $00 $9c
    ld   DE, $9d00                                     ;; 00:14cf $11 $00 $9d
    call call_00_00a4                                  ;; 00:14d2 $cd $a4 $00

call_00_14d5:
    xor  A, A                                          ;; 00:14d5 $af
    ld   [wC798], A                                    ;; 00:14d6 $ea $98 $c7
    call call_00_0546                                  ;; 00:14d9 $cd $46 $05
    call call_00_0533                                  ;; 00:14dc $cd $33 $05
    ld   A, $02                                        ;; 00:14df $3e $02
    ldh  [hFF96], A                                    ;; 00:14e1 $e0 $96

call_00_14e3:
    ld   HL, wC779                                     ;; 00:14e3 $21 $79 $c7
    ld   E, [HL]                                       ;; 00:14e6 $5e
    inc  HL                                            ;; 00:14e7 $23
    ld   D, [HL]                                       ;; 00:14e8 $56
    push HL                                            ;; 00:14e9 $e5
    ld   HL, hFFA0                                     ;; 00:14ea $21 $a0 $ff
    ld   B, $04                                        ;; 00:14ed $06 $04
    call memcopySmall                                  ;; 00:14ef $cd $80 $00
    ld   HL, wC77E                                     ;; 00:14f2 $21 $7e $c7
    ld   B, $07                                        ;; 00:14f5 $06 $07
    call memcopySmall                                  ;; 00:14f7 $cd $80 $00
    pop  HL                                            ;; 00:14fa $e1
    ld   [HL], D                                       ;; 00:14fb $72
    dec  HL                                            ;; 00:14fc $2b
    ld   [HL], E                                       ;; 00:14fd $73
    ret                                                ;; 00:14fe $c9

call_00_14ff:
    ld   B, $00                                        ;; 00:14ff $06 $00
    ld   HL, $9d00                                     ;; 00:1501 $21 $00 $9d
    ld   DE, $9c00                                     ;; 00:1504 $11 $00 $9c
    call call_00_00a4                                  ;; 00:1507 $cd $a4 $00

call_00_150a:
    xor  A, A                                          ;; 00:150a $af
    ldh  [hFF96], A                                    ;; 00:150b $e0 $96
    call call_00_0546                                  ;; 00:150d $cd $46 $05
    ld   HL, wCC80                                     ;; 00:1510 $21 $80 $cc
    ld   B, $20                                        ;; 00:1513 $06 $20
    call memclearSmall                                 ;; 00:1515 $cd $6c $00
    rst  waitForVBlank                                 ;; 00:1518 $d7
    ld   A, $cc                                        ;; 00:1519 $3e $cc
    rst  executeOAM_DMA                                ;; 00:151b $df

call_00_151c:
    ld   HL, wC779                                     ;; 00:151c $21 $79 $c7
    ld   E, [HL]                                       ;; 00:151f $5e
    inc  HL                                            ;; 00:1520 $23
    ld   D, [HL]                                       ;; 00:1521 $56
    push HL                                            ;; 00:1522 $e5
    ld   HL, wC784                                     ;; 00:1523 $21 $84 $c7
    ld   B, $07                                        ;; 00:1526 $06 $07
    call memcopySmallReverse                           ;; 00:1528 $cd $a3 $08
    ld   HL, hFFA3                                     ;; 00:152b $21 $a3 $ff
    ld   B, $04                                        ;; 00:152e $06 $04
    call memcopySmallReverse                           ;; 00:1530 $cd $a3 $08
    pop  HL                                            ;; 00:1533 $e1
    ld   [HL], D                                       ;; 00:1534 $72
    dec  HL                                            ;; 00:1535 $2b
    ld   [HL], E                                       ;; 00:1536 $73
    ret                                                ;; 00:1537 $c9

jp_00_1538:
    ld   L, [HL]                                       ;; 00:1538 $6e

jp_00_1539:
    ld   H, $00                                        ;; 00:1539 $26 $00

jp_00_153b:
    call mul_hl_8_add_de                               ;; 00:153b $cd $67 $00

jp_00_153e:
    ld   A, $0f                                        ;; 00:153e $3e $0f
    rst  switchBankSafe                                ;; 00:1540 $ef
    push AF                                            ;; 00:1541 $f5
    call call_00_1598                                  ;; 00:1542 $cd $98 $15
    pop  AF                                            ;; 00:1545 $f1
    rst  switchBankSafe                                ;; 00:1546 $ef
    jr   jp_00_1557                                    ;; 00:1547 $18 $0e

call_00_1549:
    ld   A, [wC77B]                                    ;; 00:1549 $fa $7b $c7
    and  A, A                                          ;; 00:154c $a7
    ret  NZ                                            ;; 00:154d $c0
    dec  A                                             ;; 00:154e $3d
    ld   HL, wC785                                     ;; 00:154f $21 $85 $c7
    call memsetSmall                                   ;; 00:1552 $cd $6d $00
    xor  A, A                                          ;; 00:1555 $af
    ld   [HL], A                                       ;; 00:1556 $77

jp_00_1557:
    ld   DE, wC785                                     ;; 00:1557 $11 $85 $c7

call_00_155a:
    ld   HL, hFFA2                                     ;; 00:155a $21 $a2 $ff
    ld   C, [HL]                                       ;; 00:155d $4e
    inc  HL                                            ;; 00:155e $23
    ld   B, [HL]                                       ;; 00:155f $46
    ld   [HL], D                                       ;; 00:1560 $72
    dec  HL                                            ;; 00:1561 $2b
    ld   [HL], E                                       ;; 00:1562 $73
    push BC                                            ;; 00:1563 $c5
    push HL                                            ;; 00:1564 $e5
    ld   HL, wC77C                                     ;; 00:1565 $21 $7c $c7
    ld   A, [HL]                                       ;; 00:1568 $7e
    ld   [HL], $01                                     ;; 00:1569 $36 $01
    push AF                                            ;; 00:156b $f5
.jr_00_156c:
    call call_00_070c                                  ;; 00:156c $cd $0c $07
    jr   .jr_00_156c                                   ;; 00:156f $18 $fb
    pop  AF                                            ;; 00:1571 $f1
    ld   [wC77C], A                                    ;; 00:1572 $ea $7c $c7
    pop  HL                                            ;; 00:1575 $e1
    pop  DE                                            ;; 00:1576 $d1
    jp   call_00_07be                                  ;; 00:1577 $c3 $be $07

jp_00_157a:
    ld   DE, wC785                                     ;; 00:157a $11 $85 $c7
    ld   A, [wC77B]                                    ;; 00:157d $fa $7b $c7
    and  A, A                                          ;; 00:1580 $a7
    jr   NZ, .jr_00_158b                               ;; 00:1581 $20 $08
.jr_00_1583:
    ld   A, [HL+]                                      ;; 00:1583 $2a
    ld   [DE], A                                       ;; 00:1584 $12
    inc  DE                                            ;; 00:1585 $13
    and  A, A                                          ;; 00:1586 $a7
    jr   NZ, .jr_00_1583                               ;; 00:1587 $20 $fa
    jr   .jr_00_1595                                   ;; 00:1589 $18 $0a
.jr_00_158b:
    ld   A, [HL+]                                      ;; 00:158b $2a
    cp   A, $ff                                        ;; 00:158c $fe $ff
    jr   Z, .jr_00_158b                                ;; 00:158e $28 $fb
    ld   [DE], A                                       ;; 00:1590 $12
    inc  DE                                            ;; 00:1591 $13
    and  A, A                                          ;; 00:1592 $a7
    jr   NZ, .jr_00_158b                               ;; 00:1593 $20 $f6
.jr_00_1595:
    jp   jp_00_1557                                    ;; 00:1595 $c3 $57 $15

call_00_1598:
    ld   DE, wC785                                     ;; 00:1598 $11 $85 $c7
    ld   A, [wC77B]                                    ;; 00:159b $fa $7b $c7
    and  A, A                                          ;; 00:159e $a7
    jr   NZ, .jr_00_15a6                               ;; 00:159f $20 $05
    call memcopySmall                                  ;; 00:15a1 $cd $80 $00
    jr   .jr_00_15b2                                   ;; 00:15a4 $18 $0c
.jr_00_15a6:
    ld   C, E                                          ;; 00:15a6 $4b
.jr_00_15a7:
    ld   A, [HL+]                                      ;; 00:15a7 $2a
    ld   [DE], A                                       ;; 00:15a8 $12
    inc  DE                                            ;; 00:15a9 $13
    inc  A                                             ;; 00:15aa $3c
    jr   Z, .jr_00_15ae                                ;; 00:15ab $28 $01
    ld   C, E                                          ;; 00:15ad $4b
.jr_00_15ae:
    dec  B                                             ;; 00:15ae $05
    jr   NZ, .jr_00_15a7                               ;; 00:15af $20 $f6
    ld   E, C                                          ;; 00:15b1 $59
.jr_00_15b2:
    xor  A, A                                          ;; 00:15b2 $af
    ld   [DE], A                                       ;; 00:15b3 $12
    ret                                                ;; 00:15b4 $c9

call_00_15b5:
    call call_00_15d9                                  ;; 00:15b5 $cd $d9 $15
    ld   B, $05                                        ;; 00:15b8 $06 $05

call_00_15ba:
    ld   HL, wC785                                     ;; 00:15ba $21 $85 $c7
    ld   C, $00                                        ;; 00:15bd $0e $00
.jr_00_15bf:
    ld   A, [HL]                                       ;; 00:15bf $7e
    and  A, A                                          ;; 00:15c0 $a7
    jr   NZ, .jr_00_15d0                               ;; 00:15c1 $20 $0d
    inc  C                                             ;; 00:15c3 $0c
    dec  C                                             ;; 00:15c4 $0d
    jr   NZ, .jr_00_15d0                               ;; 00:15c5 $20 $09
    dec  B                                             ;; 00:15c7 $05
    jr   NZ, .jr_00_15cc                               ;; 00:15c8 $20 $02
    ld   A, $b1                                        ;; 00:15ca $3e $b1
.jr_00_15cc:
    inc  B                                             ;; 00:15cc $04
    dec  A                                             ;; 00:15cd $3d
    jr   .jr_00_15d3                                   ;; 00:15ce $18 $03
.jr_00_15d0:
    inc  C                                             ;; 00:15d0 $0c
    add  A, $b0                                        ;; 00:15d1 $c6 $b0
.jr_00_15d3:
    ld   [HL+], A                                      ;; 00:15d3 $22
    dec  B                                             ;; 00:15d4 $05
    jr   NZ, .jr_00_15bf                               ;; 00:15d5 $20 $e8
    ld   [HL], B                                       ;; 00:15d7 $70
    ret                                                ;; 00:15d8 $c9

call_00_15d9:
    ld   BC, wC785                                     ;; 00:15d9 $01 $85 $c7
    ld   DE, $2710                                     ;; 00:15dc $11 $10 $27
    call call_00_15f7                                  ;; 00:15df $cd $f7 $15
    ld   DE, $3e8                                      ;; 00:15e2 $11 $e8 $03
    call call_00_15f7                                  ;; 00:15e5 $cd $f7 $15
    ld   DE, $64                                       ;; 00:15e8 $11 $64 $00
    call call_00_15f7                                  ;; 00:15eb $cd $f7 $15
    ld   DE, $0a                                       ;; 00:15ee $11 $0a $00
    call call_00_15f7                                  ;; 00:15f1 $cd $f7 $15
    ld   A, L                                          ;; 00:15f4 $7d
    ld   [BC], A                                       ;; 00:15f5 $02
    ret                                                ;; 00:15f6 $c9

call_00_15f7:
    xor  A, A                                          ;; 00:15f7 $af
.jr_00_15f8:
    call call_00_0376                                  ;; 00:15f8 $cd $76 $03
    inc  A                                             ;; 00:15fb $3c
    jr   NC, .jr_00_15f8                               ;; 00:15fc $30 $fa
    dec  A                                             ;; 00:15fe $3d
    add  HL, DE                                        ;; 00:15ff $19
    ld   [BC], A                                       ;; 00:1600 $02
    inc  BC                                            ;; 00:1601 $03
    ret                                                ;; 00:1602 $c9
    db   $be, $c8, $23, $23, $0d, $20, $f9, $37        ;; 00:1603 ????????
    db   $c9                                           ;; 00:160b ?

call_00_160c:
    ld   HL, data_0d_6b70 ;@=ptr bank=0D               ;; 00:160c $21 $70 $6b
    rst  add_hl_a                                      ;; 00:160f $c7
    ld   A, $0d                                        ;; 00:1610 $3e $0d
    call readFromBank                                  ;; 00:1612 $cd $d2 $00
    ld   H, $40                                        ;; 00:1615 $26 $40
    add  A, H                                          ;; 00:1617 $84
    ld   H, A                                          ;; 00:1618 $67
    ld   L, $00                                        ;; 00:1619 $2e $00
    ld   A, $03                                        ;; 00:161b $3e $03
    ld   B, $80                                        ;; 00:161d $06 $80
    jp   jp_00_00c3                                    ;; 00:161f $c3 $c3 $00

call_00_1622:
    ld   HL, wD012                                     ;; 00:1622 $21 $12 $d0
    ld   A, [wC709]                                    ;; 00:1625 $fa $09 $c7
    call call_00_05d9                                  ;; 00:1628 $cd $d9 $05
    ld   A, B                                          ;; 00:162b $78
    add  A, A                                          ;; 00:162c $87
    add  A, B                                          ;; 00:162d $80
    rst  add_hl_a                                      ;; 00:162e $c7
    ld   A, [HL]                                       ;; 00:162f $7e
    cp   A, $ff                                        ;; 00:1630 $fe $ff
    ret  Z                                             ;; 00:1632 $c8
    push HL                                            ;; 00:1633 $e5
    inc  HL                                            ;; 00:1634 $23
    ld   H, [HL]                                       ;; 00:1635 $66
    ld   L, A                                          ;; 00:1636 $6f
    ld   DE, data_0c_6f80 ;@=ptr bank=0C               ;; 00:1637 $11 $80 $6f
    call mul_hl_8_add_de                               ;; 00:163a $cd $67 $00
    ld   A, $0c                                        ;; 00:163d $3e $0c
    call readFromBank                                  ;; 00:163f $cd $d2 $00
    pop  HL                                            ;; 00:1642 $e1
    and  A, $01                                        ;; 00:1643 $e6 $01
    ret  Z                                             ;; 00:1645 $c8
    scf                                                ;; 00:1646 $37
    ret                                                ;; 00:1647 $c9

call_00_1648:
    push BC                                            ;; 00:1648 $c5
    push DE                                            ;; 00:1649 $d5
    push HL                                            ;; 00:164a $e5
    ld   B, A                                          ;; 00:164b $47
    ld   A, $0f                                        ;; 00:164c $3e $0f
    rst  switchBankSafe                                ;; 00:164e $ef
    push AF                                            ;; 00:164f $f5
    ld   HL, $4238                                     ;; 00:1650 $21 $38 $42
    ld   D, $08                                        ;; 00:1653 $16 $08
.jr_00_1655:
    ld   C, [HL]                                       ;; 00:1655 $4e
    inc  HL                                            ;; 00:1656 $23
    ld   E, C                                          ;; 00:1657 $59
    inc  E                                             ;; 00:1658 $1c
    ld   A, B                                          ;; 00:1659 $78
    call call_00_0504                                  ;; 00:165a $cd $04 $05
    jr   NZ, .jr_00_1664                               ;; 00:165d $20 $05
    dec  D                                             ;; 00:165f $15
    jr   NZ, .jr_00_1655                               ;; 00:1660 $20 $f3
    ld   E, $00                                        ;; 00:1662 $1e $00
.jr_00_1664:
    pop  AF                                            ;; 00:1664 $f1
    rst  switchBankSafe                                ;; 00:1665 $ef
    ld   A, E                                          ;; 00:1666 $7b
    pop  HL                                            ;; 00:1667 $e1
    pop  DE                                            ;; 00:1668 $d1
    pop  BC                                            ;; 00:1669 $c1
    ret                                                ;; 00:166a $c9
    db   $f5, $f0, $44, $fe, $90, $20, $fa, $f1        ;; 00:166b ????????
    db   $c9                                           ;; 00:1673 ?

call_00_1674:
    rst  waitForVBlank                                 ;; 00:1674 $d7
    di                                                 ;; 00:1675 $f3
    push AF                                            ;; 00:1676 $f5
    push DE                                            ;; 00:1677 $d5
    push HL                                            ;; 00:1678 $e5
    ld   HL, wLCDCInterruptHandler                     ;; 00:1679 $21 $06 $c7
    ld   DE, wC7D3                                     ;; 00:167c $11 $d3 $c7
    ld   A, [HL]                                       ;; 00:167f $7e
    ld   [DE], A                                       ;; 00:1680 $12
    inc  DE                                            ;; 00:1681 $13
    ld   A, $c3                                        ;; 00:1682 $3e $c3
    ld   [HL+], A                                      ;; 00:1684 $22
    ld   A, [HL]                                       ;; 00:1685 $7e
    ld   [DE], A                                       ;; 00:1686 $12
    inc  DE                                            ;; 00:1687 $13
    ld   A, $a8                                        ;; 00:1688 $3e $a8
    ld   [HL+], A                                      ;; 00:168a $22
    ld   A, [HL]                                       ;; 00:168b $7e
    ld   [DE], A                                       ;; 00:168c $12
    ld   A, $16                                        ;; 00:168d $3e $16
    jr   jr_00_16a3                                    ;; 00:168f $18 $12

call_00_1691:
    rst  waitForVBlank                                 ;; 00:1691 $d7
    di                                                 ;; 00:1692 $f3
    push AF                                            ;; 00:1693 $f5
    push DE                                            ;; 00:1694 $d5
    push HL                                            ;; 00:1695 $e5
    ld   HL, wLCDCInterruptHandler                     ;; 00:1696 $21 $06 $c7
    ld   DE, wC7D3                                     ;; 00:1699 $11 $d3 $c7
    ld   A, [DE]                                       ;; 00:169c $1a
    inc  DE                                            ;; 00:169d $13
    ld   [HL+], A                                      ;; 00:169e $22
    ld   A, [DE]                                       ;; 00:169f $1a
    inc  DE                                            ;; 00:16a0 $13
    ld   [HL+], A                                      ;; 00:16a1 $22
    ld   A, [DE]                                       ;; 00:16a2 $1a

jr_00_16a3:
    ld   [HL], A                                       ;; 00:16a3 $77
    pop  HL                                            ;; 00:16a4 $e1
    pop  DE                                            ;; 00:16a5 $d1
    pop  AF                                            ;; 00:16a6 $f1
    reti                                               ;; 00:16a7 $d9
    push AF                                            ;; 00:16a8 $f5
    ldh  A, [rLY]                                      ;; 00:16a9 $f0 $44
    and  A, A                                          ;; 00:16ab $a7
    call Z, call_00_16be                               ;; 00:16ac $cc $be $16
    inc  A                                             ;; 00:16af $3c
    ldh  [rLYC], A                                     ;; 00:16b0 $e0 $45
    ldh  A, [rSTAT]                                    ;; 00:16b2 $f0 $41
    ldh  [rSTAT], A                                    ;; 00:16b4 $e0 $41
.jr_00_16b6:
    ldh  A, [rSTAT]                                    ;; 00:16b6 $f0 $41
    and  A, $03                                        ;; 00:16b8 $e6 $03
    jr   NZ, .jr_00_16b6                               ;; 00:16ba $20 $fa
    pop  AF                                            ;; 00:16bc $f1
    reti                                               ;; 00:16bd $d9

call_00_16be:
    call call_00_16f9                                  ;; 00:16be $cd $f9 $16
    call call_00_16d0                                  ;; 00:16c1 $cd $d0 $16
.jr_00_16c4:
    ldh  A, [rSTAT]                                    ;; 00:16c4 $f0 $41
    and  A, $03                                        ;; 00:16c6 $e6 $03
    jr   NZ, .jr_00_16c4                               ;; 00:16c8 $20 $fa
    call call_00_16d0                                  ;; 00:16ca $cd $d0 $16
    ldh  A, [rLY]                                      ;; 00:16cd $f0 $44
    ret                                                ;; 00:16cf $c9

call_00_16d0:
    ldh  A, [rSTAT]                                    ;; 00:16d0 $f0 $41
    and  A, $03                                        ;; 00:16d2 $e6 $03
    cp   A, $03                                        ;; 00:16d4 $fe $03
    jr   NZ, call_00_16d0                              ;; 00:16d6 $20 $f8
    ret                                                ;; 00:16d8 $c9

LCDCInterruptHandler:
    call call_00_16f9                                  ;; 00:16d9 $cd $f9 $16
    push AF                                            ;; 00:16dc $f5
    jr   jr_00_16f2                                    ;; 00:16dd $18 $13

VBlankHandler:
    push AF                                            ;; 00:16df $f5
    ldh  A, [hFFA5]                                    ;; 00:16e0 $f0 $a5
    and  A, A                                          ;; 00:16e2 $a7
    jr   Z, jr_00_16f2                                 ;; 00:16e3 $28 $0d
    ld   A, $01                                        ;; 00:16e5 $3e $01
    ld   [$2100], A                                    ;; 00:16e7 $ea $00 $21
    call call_01_502d ;@bank 1                         ;; 00:16ea $cd $2d $50
    ldh  A, [hCurrentBank]                             ;; 00:16ed $f0 $88
    ld   [$2100], A                                    ;; 00:16ef $ea $00 $21

jr_00_16f2:
    xor  A, A                                          ;; 00:16f2 $af
    ldh  [rLYC], A                                     ;; 00:16f3 $e0 $45
    ldh  [rIF], A                                      ;; 00:16f5 $e0 $0f
    pop  AF                                            ;; 00:16f7 $f1
    reti                                               ;; 00:16f8 $d9

call_00_16f9:
    push AF                                            ;; 00:16f9 $f5
    push BC                                            ;; 00:16fa $c5
    push DE                                            ;; 00:16fb $d5
    push HL                                            ;; 00:16fc $e5
    ld   HL, hFF9C                                     ;; 00:16fd $21 $9c $ff
    ld   A, [HL]                                       ;; 00:1700 $7e
    and  A, A                                          ;; 00:1701 $a7
    jr   NZ, .jr_00_1760                               ;; 00:1702 $20 $5c
    inc  [HL]                                          ;; 00:1704 $34
    ld   A, $0e                                        ;; 00:1705 $3e $0e
    call switchBankUnsafe                              ;; 00:1707 $cd $b1 $04
    push AF                                            ;; 00:170a $f5
    call updateSoundEngine                             ;; 00:170b $cd $00 $40
    ldh  A, [hFFA5]                                    ;; 00:170e $f0 $a5
    and  A, A                                          ;; 00:1710 $a7
    jr   Z, .jr_00_171b                                ;; 00:1711 $28 $08
    ld   A, $01                                        ;; 00:1713 $3e $01
    call switchBankUnsafe                              ;; 00:1715 $cd $b1 $04
    call call_01_5033 ;@bank 1                         ;; 00:1718 $cd $33 $50
.jr_00_171b:
    pop  AF                                            ;; 00:171b $f1
    call switchBankUnsafe                              ;; 00:171c $cd $b1 $04
    ld   HL, wC770                                     ;; 00:171f $21 $70 $c7
    ld   DE, wC771                                     ;; 00:1722 $11 $71 $c7
    ld   B, $03                                        ;; 00:1725 $06 $03
    push HL                                            ;; 00:1727 $e5
    call memcopySmall                                  ;; 00:1728 $cd $80 $00
    pop  HL                                            ;; 00:172b $e1
    ld   C, $00                                        ;; 00:172c $0e $00
    ld   A, $20                                        ;; 00:172e $3e $20
    ldh  [C], A                                        ;; 00:1730 $e2
    call call_00_1767                                  ;; 00:1731 $cd $67 $17
    swap A                                             ;; 00:1734 $cb $37
    ld   B, A                                          ;; 00:1736 $47
    ld   A, $10                                        ;; 00:1737 $3e $10
    ldh  [C], A                                        ;; 00:1739 $e2
    call call_00_1763                                  ;; 00:173a $cd $63 $17
    and  A, B                                          ;; 00:173d $a0
    cpl                                                ;; 00:173e $2f
    ld   [HL+], A                                      ;; 00:173f $22
    inc  HL                                            ;; 00:1740 $23
    inc  HL                                            ;; 00:1741 $23
    ld   A, [HL-]                                      ;; 00:1742 $3a
    or   A, [HL]                                       ;; 00:1743 $b6
    dec  HL                                            ;; 00:1744 $2b
    and  A, [HL]                                       ;; 00:1745 $a6
    dec  HL                                            ;; 00:1746 $2b
    and  A, [HL]                                       ;; 00:1747 $a6
    ldh  [hFF89], A                                    ;; 00:1748 $e0 $89
    ld   A, $30                                        ;; 00:174a $3e $30
    ldh  [C], A                                        ;; 00:174c $e2
    ldh  A, [hFF89]                                    ;; 00:174d $f0 $89
    and  A, $0f                                        ;; 00:174f $e6 $0f
    cp   A, $0f                                        ;; 00:1751 $fe $0f
    jp   Z, init                                       ;; 00:1753 $ca $00 $02
    ldh  A, [hFF96]                                    ;; 00:1756 $f0 $96
    and  A, A                                          ;; 00:1758 $a7
    call NZ, call_00_176c                              ;; 00:1759 $c4 $6c $17
    ld   HL, hFF9C                                     ;; 00:175c $21 $9c $ff
    dec  [HL]                                          ;; 00:175f $35
.jr_00_1760:
    jp   pop_all                                       ;; 00:1760 $c3 $0b $00

call_00_1763:
    ldh  A, [C]                                        ;; 00:1763 $f2
    ldh  A, [C]                                        ;; 00:1764 $f2
    ldh  A, [C]                                        ;; 00:1765 $f2
    ldh  A, [C]                                        ;; 00:1766 $f2

call_00_1767:
    ldh  A, [C]                                        ;; 00:1767 $f2
    ldh  A, [C]                                        ;; 00:1768 $f2
    or   A, $f0                                        ;; 00:1769 $f6 $f0
    ret                                                ;; 00:176b $c9

call_00_176c:
    ld   A, $0f                                        ;; 00:176c $3e $0f
    call switchBankUnsafe                              ;; 00:176e $cd $b1 $04
    push AF                                            ;; 00:1771 $f5
    ld   HL, wC7C6                                     ;; 00:1772 $21 $c6 $c7
    inc  [HL]                                          ;; 00:1775 $34
    ld   A, [HL]                                       ;; 00:1776 $7e
    and  A, $10                                        ;; 00:1777 $e6 $10
    jr   Z, .jr_00_1783                                ;; 00:1779 $28 $08
    xor  A, A                                          ;; 00:177b $af
    ld   [HL+], A                                      ;; 00:177c $22
    ld   A, [HL]                                       ;; 00:177d $7e
    and  A, $01                                        ;; 00:177e $e6 $01
    xor  A, $01                                        ;; 00:1780 $ee $01
    ld   [HL], A                                       ;; 00:1782 $77
.jr_00_1783:
    ldh  A, [hFF96]                                    ;; 00:1783 $f0 $96
    bit  0, A                                          ;; 00:1785 $cb $47
    jp   Z, .jp_00_182a                                ;; 00:1787 $ca $2a $18
    ld   HL, wCC00                                     ;; 00:178a $21 $00 $cc
    ld   B, $80                                        ;; 00:178d $06 $80
    call memclearSmall                                 ;; 00:178f $cd $6c $00
    ld   HL, wC7A6                                     ;; 00:1792 $21 $a6 $c7
    ld   B, $08                                        ;; 00:1795 $06 $08
.jp_00_1797:
    push BC                                            ;; 00:1797 $c5
    ld   A, [HL]                                       ;; 00:1798 $7e
    rla                                                ;; 00:1799 $17
    jp   NC, .jp_00_1821                               ;; 00:179a $d2 $21 $18
    push HL                                            ;; 00:179d $e5
    ld   A, [HL+]                                      ;; 00:179e $2a
    ldh  [hFF95], A                                    ;; 00:179f $e0 $95
    ld   A, [HL+]                                      ;; 00:17a1 $2a
    ldh  [hFF94], A                                    ;; 00:17a2 $e0 $94
    ldh  A, [hFF95]                                    ;; 00:17a4 $f0 $95
    and  A, $07                                        ;; 00:17a6 $e6 $07
    add  A, A                                          ;; 00:17a8 $87
    add  A, A                                          ;; 00:17a9 $87
    add  A, A                                          ;; 00:17aa $87
    add  A, A                                          ;; 00:17ab $87
    ld   D, [HL]                                       ;; 00:17ac $56
    inc  HL                                            ;; 00:17ad $23
    ld   E, [HL]                                       ;; 00:17ae $5e
    ld   L, A                                          ;; 00:17af $6f
    ld   H, $cc                                        ;; 00:17b0 $26 $cc
    ldh  A, [hFF95]                                    ;; 00:17b2 $f0 $95
    bit  5, A                                          ;; 00:17b4 $cb $6f
    jr   Z, .jr_00_17be                                ;; 00:17b6 $28 $06
    ld   A, [wC7C7]                                    ;; 00:17b8 $fa $c7 $c7
    and  A, A                                          ;; 00:17bb $a7
    jr   Z, .jr_00_1820                                ;; 00:17bc $28 $62
.jr_00_17be:
    ldh  A, [hFF95]                                    ;; 00:17be $f0 $95
    bit  6, A                                          ;; 00:17c0 $cb $77
    jr   Z, .jr_00_17cf                                ;; 00:17c2 $28 $0b
    ldh  A, [hFF94]                                    ;; 00:17c4 $f0 $94
    bit  2, A                                          ;; 00:17c6 $cb $57
    jr   NZ, .jr_00_17cf                               ;; 00:17c8 $20 $05
    ld   A, [wC7C7]                                    ;; 00:17ca $fa $c7 $c7
    add  A, E                                          ;; 00:17cd $83
    ld   E, A                                          ;; 00:17ce $5f
.jr_00_17cf:
    push HL                                            ;; 00:17cf $e5
    call call_00_1869                                  ;; 00:17d0 $cd $69 $18
    ld   HL, $4200                                     ;; 00:17d3 $21 $00 $42
    ldh  A, [hFF95]                                    ;; 00:17d6 $f0 $95
    bit  6, A                                          ;; 00:17d8 $cb $77
    jr   Z, .jr_00_17e5                                ;; 00:17da $28 $09
    ld   A, [wC7C7]                                    ;; 00:17dc $fa $c7 $c7
    and  A, A                                          ;; 00:17df $a7
    jr   Z, .jr_00_17e5                                ;; 00:17e0 $28 $03
    ld   HL, $4218                                     ;; 00:17e2 $21 $18 $42
.jr_00_17e5:
    ldh  A, [hFF95]                                    ;; 00:17e5 $f0 $95
    bit  4, A                                          ;; 00:17e7 $cb $67
    jr   Z, .jr_00_17ee                                ;; 00:17e9 $28 $03
    ld   A, $0c                                        ;; 00:17eb $3e $0c
    rst  add_hl_a                                      ;; 00:17ed $c7
.jr_00_17ee:
    ldh  A, [hFF94]                                    ;; 00:17ee $f0 $94
    and  A, $03                                        ;; 00:17f0 $e6 $03
    add  A, A                                          ;; 00:17f2 $87
    add  A, A                                          ;; 00:17f3 $87
    rst  add_hl_a                                      ;; 00:17f4 $c7
    ld   E, L                                          ;; 00:17f5 $5d
    ld   D, H                                          ;; 00:17f6 $54
    pop  HL                                            ;; 00:17f7 $e1
    ldh  A, [hFF95]                                    ;; 00:17f8 $f0 $95
    and  A, $07                                        ;; 00:17fa $e6 $07
    add  A, A                                          ;; 00:17fc $87
    add  A, A                                          ;; 00:17fd $87
    add  A, A                                          ;; 00:17fe $87
    ldh  [hFF94], A                                    ;; 00:17ff $e0 $94
    ldh  A, [hFF95]                                    ;; 00:1801 $f0 $95
    and  A, $08                                        ;; 00:1803 $e6 $08
    rlca                                               ;; 00:1805 $07
    ldh  [hFF93], A                                    ;; 00:1806 $e0 $93
    ld   B, $04                                        ;; 00:1808 $06 $04
.jr_00_180a:
    inc  HL                                            ;; 00:180a $23
    inc  HL                                            ;; 00:180b $23
    ldh  A, [hFF94]                                    ;; 00:180c $f0 $94
    ld   C, A                                          ;; 00:180e $4f
    ld   A, [DE]                                       ;; 00:180f $1a
    and  A, $0f                                        ;; 00:1810 $e6 $0f
    add  A, C                                          ;; 00:1812 $81
    ld   [HL+], A                                      ;; 00:1813 $22
    ldh  A, [hFF93]                                    ;; 00:1814 $f0 $93
    ld   C, A                                          ;; 00:1816 $4f
    ld   A, [DE]                                       ;; 00:1817 $1a
    inc  DE                                            ;; 00:1818 $13
    and  A, $f0                                        ;; 00:1819 $e6 $f0
    or   A, C                                          ;; 00:181b $b1
    ld   [HL+], A                                      ;; 00:181c $22
    dec  B                                             ;; 00:181d $05
    jr   NZ, .jr_00_180a                               ;; 00:181e $20 $ea
.jr_00_1820:
    pop  HL                                            ;; 00:1820 $e1
.jp_00_1821:
    inc  HL                                            ;; 00:1821 $23
    inc  HL                                            ;; 00:1822 $23
    inc  HL                                            ;; 00:1823 $23
    inc  HL                                            ;; 00:1824 $23
    pop  BC                                            ;; 00:1825 $c1
    dec  B                                             ;; 00:1826 $05
    jp   NZ, .jp_00_1797                               ;; 00:1827 $c2 $97 $17
.jp_00_182a:
    ld   HL, wCC90                                     ;; 00:182a $21 $90 $cc
    xor  A, A                                          ;; 00:182d $af
.jr_00_182e:
    ldh  [hFF95], A                                    ;; 00:182e $e0 $95
    ld   C, $97                                        ;; 00:1830 $0e $97
    add  A, A                                          ;; 00:1832 $87
    add  A, C                                          ;; 00:1833 $81
    ld   C, A                                          ;; 00:1834 $4f
    ldh  A, [C]                                        ;; 00:1835 $f2
    ld   D, A                                          ;; 00:1836 $57
    inc  C                                             ;; 00:1837 $0c
    ldh  A, [C]                                        ;; 00:1838 $f2
    ld   E, A                                          ;; 00:1839 $5f
    inc  A                                             ;; 00:183a $3c
    jr   NZ, .jr_00_1844                               ;; 00:183b $20 $07
    ld   B, $10                                        ;; 00:183d $06 $10
    call memclearSmall                                 ;; 00:183f $cd $6c $00
    jr   .jr_00_185a                                   ;; 00:1842 $18 $16
.jr_00_1844:
    call call_00_0526                                  ;; 00:1844 $cd $26 $05
    push HL                                            ;; 00:1847 $e5
    call call_00_1869                                  ;; 00:1848 $cd $69 $18
    pop  HL                                            ;; 00:184b $e1
    ld   B, $04                                        ;; 00:184c $06 $04
    ld   A, $78                                        ;; 00:184e $3e $78
.jr_00_1850:
    inc  HL                                            ;; 00:1850 $23
    inc  HL                                            ;; 00:1851 $23
    ld   [HL+], A                                      ;; 00:1852 $22
    inc  A                                             ;; 00:1853 $3c
    ld   [HL], $00                                     ;; 00:1854 $36 $00
    inc  HL                                            ;; 00:1856 $23
    dec  B                                             ;; 00:1857 $05
    jr   NZ, .jr_00_1850                               ;; 00:1858 $20 $f6
.jr_00_185a:
    ld   HL, wCC80                                     ;; 00:185a $21 $80 $cc
    ldh  A, [hFF95]                                    ;; 00:185d $f0 $95
    inc  A                                             ;; 00:185f $3c
    cp   A, $02                                        ;; 00:1860 $fe $02
    jr   C, .jr_00_182e                                ;; 00:1862 $38 $ca
    pop  AF                                            ;; 00:1864 $f1
    call switchBankUnsafe                              ;; 00:1865 $cd $b1 $04
    ret                                                ;; 00:1868 $c9

call_00_1869:
    push AF                                            ;; 00:1869 $f5
    push BC                                            ;; 00:186a $c5
    ld   A, $04                                        ;; 00:186b $3e $04
    ld   BC, $4230                                     ;; 00:186d $01 $30 $42
.jr_00_1870:
    ldh  [hFF93], A                                    ;; 00:1870 $e0 $93
    ld   A, [BC]                                       ;; 00:1872 $0a
    inc  BC                                            ;; 00:1873 $03
    add  A, D                                          ;; 00:1874 $82
    ld   [HL+], A                                      ;; 00:1875 $22
    ld   A, [BC]                                       ;; 00:1876 $0a
    inc  BC                                            ;; 00:1877 $03
    add  A, E                                          ;; 00:1878 $83
    ld   [HL+], A                                      ;; 00:1879 $22
    inc  HL                                            ;; 00:187a $23
    inc  HL                                            ;; 00:187b $23
    ldh  A, [hFF93]                                    ;; 00:187c $f0 $93
    dec  A                                             ;; 00:187e $3d
    jr   NZ, .jr_00_1870                               ;; 00:187f $20 $ef
    pop  BC                                            ;; 00:1881 $c1
    pop  AF                                            ;; 00:1882 $f1
    ret                                                ;; 00:1883 $c9

jp_00_1884:
    farcall call_01_5000                               ;; 00:1884 $cd $bf $04 $00 $50 $01
    ret                                                ;; 00:188a $c9

jp_00_188b:
    farcall call_01_5003                               ;; 00:188b $cd $bf $04 $03 $50 $01
    ret                                                ;; 00:1891 $c9

jp_00_1892:
    farcall call_01_5015                               ;; 00:1892 $cd $bf $04 $15 $50 $01
    ret                                                ;; 00:1898 $c9

jp_00_1899:
    farcall call_01_5018                               ;; 00:1899 $cd $bf $04 $18 $50 $01
    ret                                                ;; 00:189f $c9

jp_00_18a0:
    farcall call_01_501b                               ;; 00:18a0 $cd $bf $04 $1b $50 $01
    ret                                                ;; 00:18a6 $c9

jp_00_18a7:
    farcall call_0f_6080                               ;; 00:18a7 $cd $bf $04 $80 $60 $0f
    ret                                                ;; 00:18ad $c9

jp_00_18ae:
    farcall call_0d_5000                               ;; 00:18ae $cd $bf $04 $00 $50 $0d
    ret                                                ;; 00:18b4 $c9

jp_00_18b5:
    farcall call_0f_6083                               ;; 00:18b5 $cd $bf $04 $83 $60 $0f
    ret                                                ;; 00:18bb $c9

call_00_18bc:
    xor  A, A                                          ;; 00:18bc $af
    call call_00_18c3                                  ;; 00:18bd $cd $c3 $18
    ldh  A, [hFF8C]                                    ;; 00:18c0 $f0 $8c
    ret                                                ;; 00:18c2 $c9

call_00_18c3:
    push AF                                            ;; 00:18c3 $f5
    push BC                                            ;; 00:18c4 $c5
    push DE                                            ;; 00:18c5 $d5
    push HL                                            ;; 00:18c6 $e5
    ld   B, A                                          ;; 00:18c7 $47
    ld   A, [wC79A]                                    ;; 00:18c8 $fa $9a $c7
    add  A, A                                          ;; 00:18cb $87
    or   A, B                                          ;; 00:18cc $b0
    ld   [wC7CD], A                                    ;; 00:18cd $ea $cd $c7
    ld   A, $01                                        ;; 00:18d0 $3e $01
    rst  switchBankSafe                                ;; 00:18d2 $ef
    push AF                                            ;; 00:18d3 $f5
    call call_01_500c                                  ;; 00:18d4 $cd $0c $50
    pop  AF                                            ;; 00:18d7 $f1
    rst  switchBankSafe                                ;; 00:18d8 $ef
    jp   pop_all                                       ;; 00:18d9 $c3 $0b $00
    db   $f5, $c5, $d5, $e5, $47, $fa, $9a, $c7        ;; 00:18dc ????????
    db   $87, $b0, $ea, $cd, $c7, $3e, $01, $ef        ;; 00:18e4 ????????
    db   $f5, $cd, $0c, $50, $f1, $ef, $c3, $0b        ;; 00:18ec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 00:18f4 ????????
    db   $00, $00, $00, $00                            ;; 00:18fc ????

jp_00_1900:
    jp   jp_00_19d6                                    ;; 00:1900 $c3 $d6 $19

jp_00_1903:
    jp   jp_00_1997                                    ;; 00:1903 $c3 $97 $19

call_00_1906:
    jp   jp_00_388c                                    ;; 00:1906 $c3 $8c $38

call_00_1909:
    jp   jp_00_333c                                    ;; 00:1909 $c3 $3c $33

call_00_190c:
    jp   jp_00_3232                                    ;; 00:190c $c3 $32 $32

call_00_190f:
    jp   call_00_2b14                                  ;; 00:190f $c3 $14 $2b

call_00_1912:
    jp   jp_00_194b                                    ;; 00:1912 $c3 $4b $19

call_00_1915:
    jp   jp_00_1b5f                                    ;; 00:1915 $c3 $5f $1b

call_00_1918:
    jp   call_00_1b99                                  ;; 00:1918 $c3 $99 $1b

call_00_191b:
    jp   call_00_2fb1                                  ;; 00:191b $c3 $b1 $2f

call_00_191e:
    jp   jp_00_2adf                                    ;; 00:191e $c3 $df $2a
    db   $c3, $1a, $1f, $00, $00, $00, $00, $00        ;; 00:1921 ????????
    db   $fc, $00, $02, $01, $00, $ff, $00, $02        ;; 00:1929 ????????
    db   $ff, $ff, $01, $01, $00, $ff, $04, $08        ;; 00:1931 ????????
    db   $0a, $0c, $0c, $0e, $0c, $0a, $08, $04        ;; 00:1939 ????????
    db   $fc, $f8, $f4, $f2, $f0, $f2, $f4, $f6        ;; 00:1941 ????????
    db   $fa, $80                                      ;; 00:1949 ??

jp_00_194b:
    ld   A, [wC44B]                                    ;; 00:194b $fa $4b $c4
    ld   [wC2A5], A                                    ;; 00:194e $ea $a5 $c2
    ld   A, [wC44C]                                    ;; 00:1951 $fa $4c $c4
    ld   [wC2A6], A                                    ;; 00:1954 $ea $a6 $c2
    ld   A, [wC42E]                                    ;; 00:1957 $fa $2e $c4
    swap A                                             ;; 00:195a $cb $37
    and  A, $0f                                        ;; 00:195c $e6 $0f
    ld   C, A                                          ;; 00:195e $4f
    ld   A, [wC42C]                                    ;; 00:195f $fa $2c $c4
    add  A, C                                          ;; 00:1962 $81
    ld   C, A                                          ;; 00:1963 $4f
    ld   A, [wC436]                                    ;; 00:1964 $fa $36 $c4
    rrca                                               ;; 00:1967 $0f
    rrca                                               ;; 00:1968 $0f
    and  A, $c0                                        ;; 00:1969 $e6 $c0
    or   A, C                                          ;; 00:196b $b1
    ld   [wC2A7], A                                    ;; 00:196c $ea $a7 $c2
    ld   A, [wC42F]                                    ;; 00:196f $fa $2f $c4
    swap A                                             ;; 00:1972 $cb $37
    and  A, $0f                                        ;; 00:1974 $e6 $0f
    ld   C, A                                          ;; 00:1976 $4f
    ld   A, [wC42D]                                    ;; 00:1977 $fa $2d $c4
    add  A, C                                          ;; 00:197a $81
    ld   [wC2A8], A                                    ;; 00:197b $ea $a8 $c2
    ld   A, [wC434]                                    ;; 00:197e $fa $34 $c4
    ld   [wC33D], A                                    ;; 00:1981 $ea $3d $c3
    ld   A, [wC43A]                                    ;; 00:1984 $fa $3a $c4
    ld   [wC33E], A                                    ;; 00:1987 $ea $3e $c3
    ld   A, [wC43B]                                    ;; 00:198a $fa $3b $c4
    ld   [wC33F], A                                    ;; 00:198d $ea $3f $c3
    ld   A, [wC460]                                    ;; 00:1990 $fa $60 $c4
    ld   [wC305], A                                    ;; 00:1993 $ea $05 $c3
    ret                                                ;; 00:1996 $c9

jp_00_1997:
    ld   A, $69                                        ;; 00:1997 $3e $69
    ld   [wC468], A                                    ;; 00:1999 $ea $68 $c4
    ld   A, [wC2A5]                                    ;; 00:199c $fa $a5 $c2
    ld   [wC44B], A                                    ;; 00:199f $ea $4b $c4
    ld   A, [wC2A6]                                    ;; 00:19a2 $fa $a6 $c2
    ld   [wC44C], A                                    ;; 00:19a5 $ea $4c $c4
    ld   A, [wC2A7]                                    ;; 00:19a8 $fa $a7 $c2
    ld   B, A                                          ;; 00:19ab $47
    and  A, $3f                                        ;; 00:19ac $e6 $3f
    sub  A, $05                                        ;; 00:19ae $d6 $05
    ld   [wC42C], A                                    ;; 00:19b0 $ea $2c $c4
    ld   A, B                                          ;; 00:19b3 $78
    rlca                                               ;; 00:19b4 $07
    rlca                                               ;; 00:19b5 $07
    and  A, $03                                        ;; 00:19b6 $e6 $03
    ld   [wC436], A                                    ;; 00:19b8 $ea $36 $c4
    ld   A, [wC2A8]                                    ;; 00:19bb $fa $a8 $c2
    and  A, $3f                                        ;; 00:19be $e6 $3f
    sub  A, $04                                        ;; 00:19c0 $d6 $04
    ld   [wC42D], A                                    ;; 00:19c2 $ea $2d $c4
    ld   A, $40                                        ;; 00:19c5 $3e $40
    ld   [wC42F], A                                    ;; 00:19c7 $ea $2f $c4
    ld   A, $50                                        ;; 00:19ca $3e $50
    ld   [wC42E], A                                    ;; 00:19cc $ea $2e $c4
    ld   A, $01                                        ;; 00:19cf $3e $01
    ld   [wC466], A                                    ;; 00:19d1 $ea $66 $c4
    jr   jr_00_19f0                                    ;; 00:19d4 $18 $1a

jp_00_19d6:
    ld   A, $69                                        ;; 00:19d6 $3e $69
    ld   [wC468], A                                    ;; 00:19d8 $ea $68 $c4
    xor  A, A                                          ;; 00:19db $af
    ld   [wC466], A                                    ;; 00:19dc $ea $66 $c4
    ld   A, $fe                                        ;; 00:19df $3e $fe
    ld   [wC442], A                                    ;; 00:19e1 $ea $42 $c4
    ld   A, $06                                        ;; 00:19e4 $3e $06
    ld   [wC443], A                                    ;; 00:19e6 $ea $43 $c4
    call call_00_1bf0                                  ;; 00:19e9 $cd $f0 $1b
    ld   A, $01                                        ;; 00:19ec $3e $01
    jr   jr_00_19f1                                    ;; 00:19ee $18 $01

jr_00_19f0:
    xor  A, A                                          ;; 00:19f0 $af

jr_00_19f1:
    ld   [wC45B], A                                    ;; 00:19f1 $ea $5b $c4
    ldh  [rBGP], A                                     ;; 00:19f4 $e0 $47
    ldh  [rOBP0], A                                    ;; 00:19f6 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:19f8 $e0 $49
    ld   A, $90                                        ;; 00:19fa $3e $90
    ldh  [rWY], A                                      ;; 00:19fc $e0 $4a
    call call_00_1b37                                  ;; 00:19fe $cd $37 $1b
    call call_00_1caf                                  ;; 00:1a01 $cd $af $1c
    ld   A, [wC450]                                    ;; 00:1a04 $fa $50 $c4
    call call_00_1f55                                  ;; 00:1a07 $cd $55 $1f
    call call_00_2232                                  ;; 00:1a0a $cd $32 $22
    ld   A, [wC450]                                    ;; 00:1a0d $fa $50 $c4
    call call_00_1bb9                                  ;; 00:1a10 $cd $b9 $1b
    call call_00_1a7b                                  ;; 00:1a13 $cd $7b $1a
    call call_00_1f23                                  ;; 00:1a16 $cd $23 $1f
    call call_00_1e21                                  ;; 00:1a19 $cd $21 $1e
    call call_00_338a                                  ;; 00:1a1c $cd $8a $33
    call call_00_1d5c                                  ;; 00:1a1f $cd $5c $1d
    call call_00_32d8                                  ;; 00:1a22 $cd $d8 $32
    ld   A, [wC466]                                    ;; 00:1a25 $fa $66 $c4
    or   A, A                                          ;; 00:1a28 $b7
    jr   Z, .jr_00_1a3d                                ;; 00:1a29 $28 $12
    ld   A, [wC33D]                                    ;; 00:1a2b $fa $3d $c3
    ld   [wC434], A                                    ;; 00:1a2e $ea $34 $c4
    ld   A, [wC33E]                                    ;; 00:1a31 $fa $3e $c3
    ld   [wC43A], A                                    ;; 00:1a34 $ea $3a $c4
    ld   A, [wC33F]                                    ;; 00:1a37 $fa $3f $c3
    ld   [wC43B], A                                    ;; 00:1a3a $ea $3b $c4
.jr_00_1a3d:
    call call_00_20c8                                  ;; 00:1a3d $cd $c8 $20
    call call_00_3ea2                                  ;; 00:1a40 $cd $a2 $3e

jp_00_1a43:
    ld   A, [wC43D]                                    ;; 00:1a43 $fa $3d $c4
    or   A, A                                          ;; 00:1a46 $b7
    jr   NZ, .jr_00_1a66                               ;; 00:1a47 $20 $1d
    call call_00_27c9                                  ;; 00:1a49 $cd $c9 $27
    ld   A, [wC443]                                    ;; 00:1a4c $fa $43 $c4
    cp   A, $0e                                        ;; 00:1a4f $fe $0e
    jp   Z, jp_00_1ad9                                 ;; 00:1a51 $ca $d9 $1a
    cp   A, $05                                        ;; 00:1a54 $fe $05
    jr   C, .jr_00_1a5d                                ;; 00:1a56 $38 $05
    cp   A, $07                                        ;; 00:1a58 $fe $07
    jp   C, jp_00_1ad9                                 ;; 00:1a5a $da $d9 $1a
.jr_00_1a5d:
    call call_00_3039                                  ;; 00:1a5d $cd $39 $30
    call call_00_26d5                                  ;; 00:1a60 $cd $d5 $26
    call call_00_2fbf                                  ;; 00:1a63 $cd $bf $2f
.jr_00_1a66:
    call call_00_3249                                  ;; 00:1a66 $cd $49 $32
    call call_00_344b                                  ;; 00:1a69 $cd $4b $34
    call call_00_391d                                  ;; 00:1a6c $cd $1d $39
    jr   jp_00_1a43                                    ;; 00:1a6f $18 $d2
    db   $00, $00, $00, $01, $00, $ff, $ff, $00        ;; 00:1a71 ??......
    db   $01, $00                                      ;; 00:1a79 ..

call_00_1a7b:
    ld   A, $00                                        ;; 00:1a7b $3e $00
    ld   [wC435], A                                    ;; 00:1a7d $ea $35 $c4
    xor  A, A                                          ;; 00:1a80 $af
    ld_long_store hFFC0, A                             ;; 00:1a81 $ea $c0 $ff
    ld   [wC45C], A                                    ;; 00:1a84 $ea $5c $c4
    ld   [wC45D], A                                    ;; 00:1a87 $ea $5d $c4
    ld   A, $ff                                        ;; 00:1a8a $3e $ff
    ld   [wC442], A                                    ;; 00:1a8c $ea $42 $c4
    ld   [wC443], A                                    ;; 00:1a8f $ea $43 $c4
    ld   A, $c3                                        ;; 00:1a92 $3e $c3
    ldh  [rLCDC], A                                    ;; 00:1a94 $e0 $40
    ret                                                ;; 00:1a96 $c9

call_00_1a97:
    push HL                                            ;; 00:1a97 $e5
    push AF                                            ;; 00:1a98 $f5
    call call_00_01ec                                  ;; 00:1a99 $cd $ec $01
    ld   A, [wC305]                                    ;; 00:1a9c $fa $05 $c3
    and  A, $f0                                        ;; 00:1a9f $e6 $f0
    cp   A, $10                                        ;; 00:1aa1 $fe $10
    jr   NZ, .jr_00_1aba                               ;; 00:1aa3 $20 $15
    ld   HL, wC441                                     ;; 00:1aa5 $21 $41 $c4
    inc  [HL]                                          ;; 00:1aa8 $34
    ld   A, [HL]                                       ;; 00:1aa9 $7e
    and  A, $07                                        ;; 00:1aaa $e6 $07
    add  A, A                                          ;; 00:1aac $87
    add  A, $27                                        ;; 00:1aad $c6 $27
    ld   L, A                                          ;; 00:1aaf $6f
    ld   H, $19                                        ;; 00:1ab0 $26 $19
    ld   A, [HL+]                                      ;; 00:1ab2 $2a
    ldh  [hFFC3], A                                    ;; 00:1ab3 $e0 $c3
    ld   A, [HL]                                       ;; 00:1ab5 $7e
    ldh  [hFFC4], A                                    ;; 00:1ab6 $e0 $c4
    jr   .jr_00_1ac2                                   ;; 00:1ab8 $18 $08
.jr_00_1aba:
    xor  A, A                                          ;; 00:1aba $af
    ldh  [hFFC3], A                                    ;; 00:1abb $e0 $c3
    ldh  [hFFC4], A                                    ;; 00:1abd $e0 $c4
    ld   HL, $1928                                     ;; 00:1abf $21 $28 $19
.jr_00_1ac2:
    ldh  A, [hFFC2]                                    ;; 00:1ac2 $f0 $c2
    add  A, [HL]                                       ;; 00:1ac4 $86
    ldh  [rSCX], A                                     ;; 00:1ac5 $e0 $43
    dec  L                                             ;; 00:1ac7 $2d
    ldh  A, [hFFC1]                                    ;; 00:1ac8 $f0 $c1
    add  A, [HL]                                       ;; 00:1aca $86
    ldh  [rSCY], A                                     ;; 00:1acb $e0 $42
    ld   A, [wC464]                                    ;; 00:1acd $fa $64 $c4
    inc  A                                             ;; 00:1ad0 $3c
    and  A, $1f                                        ;; 00:1ad1 $e6 $1f
    ld   [wC464], A                                    ;; 00:1ad3 $ea $64 $c4
    pop  AF                                            ;; 00:1ad6 $f1
    pop  HL                                            ;; 00:1ad7 $e1
    ret                                                ;; 00:1ad8 $c9

jp_00_1ad9:
    call call_00_1aec                                  ;; 00:1ad9 $cd $ec $1a
    ld   A, $ff                                        ;; 00:1adc $3e $ff
    ld   [wC442], A                                    ;; 00:1ade $ea $42 $c4
    ld   [wC443], A                                    ;; 00:1ae1 $ea $43 $c4
    jp   jp_00_1a43                                    ;; 00:1ae4 $c3 $43 $1a

call_00_1ae7:
    call call_00_1bdb                                  ;; 00:1ae7 $cd $db $1b
    jr   jr_00_1aef                                    ;; 00:1aea $18 $03

call_00_1aec:
    call call_00_1bf0                                  ;; 00:1aec $cd $f0 $1b

jr_00_1aef:
    call call_00_3e5b                                  ;; 00:1aef $cd $5b $3e
    ld   A, [wC305]                                    ;; 00:1af2 $fa $05 $c3
    ld   [wC463], A                                    ;; 00:1af5 $ea $63 $c4
    and  A, $0f                                        ;; 00:1af8 $e6 $0f
    ld   [wC305], A                                    ;; 00:1afa $ea $05 $c3
    call call_00_2ece                                  ;; 00:1afd $cd $ce $2e
    call call_00_1caf                                  ;; 00:1b00 $cd $af $1c
    call call_00_1b37                                  ;; 00:1b03 $cd $37 $1b
    ld   A, [wC44D]                                    ;; 00:1b06 $fa $4d $c4
    or   A, A                                          ;; 00:1b09 $b7
    jr   NZ, .jr_00_1b24                               ;; 00:1b0a $20 $18
    ld   A, [wC450]                                    ;; 00:1b0c $fa $50 $c4
    call call_00_1f55                                  ;; 00:1b0f $cd $55 $1f
    call call_00_2232                                  ;; 00:1b12 $cd $32 $22
    ld   A, [wC450]                                    ;; 00:1b15 $fa $50 $c4
    call call_00_1bb9                                  ;; 00:1b18 $cd $b9 $1b
    call call_00_1f23                                  ;; 00:1b1b $cd $23 $1f
    call call_00_338a                                  ;; 00:1b1e $cd $8a $33
    call call_00_1d5c                                  ;; 00:1b21 $cd $5c $1d
.jr_00_1b24:
    call call_00_1e21                                  ;; 00:1b24 $cd $21 $1e
    call call_00_32d8                                  ;; 00:1b27 $cd $d8 $32
    call call_00_20c8                                  ;; 00:1b2a $cd $c8 $20
    call call_00_3e4c                                  ;; 00:1b2d $cd $4c $3e
    ld   A, [wC463]                                    ;; 00:1b30 $fa $63 $c4
    ld   [wC305], A                                    ;; 00:1b33 $ea $05 $c3
    ret                                                ;; 00:1b36 $c9

call_00_1b37:
    ld   HL, wC010                                     ;; 00:1b37 $21 $10 $c0
    xor  A, A                                          ;; 00:1b3a $af
    ld   B, $90                                        ;; 00:1b3b $06 $90
.jr_00_1b3d:
    ld   [HL+], A                                      ;; 00:1b3d $22
    dec  B                                             ;; 00:1b3e $05
    jr   NZ, .jr_00_1b3d                               ;; 00:1b3f $20 $fc
    ld   HL, wC110                                     ;; 00:1b41 $21 $10 $c1
    ld   B, $90                                        ;; 00:1b44 $06 $90
.jr_00_1b46:
    ld   [HL+], A                                      ;; 00:1b46 $22
    dec  B                                             ;; 00:1b47 $05
    jr   NZ, .jr_00_1b46                               ;; 00:1b48 $20 $fc
    ret                                                ;; 00:1b4a $c9

call_00_1b4b:
    ld   HL, wC000                                     ;; 00:1b4b $21 $00 $c0
    xor  A, A                                          ;; 00:1b4e $af
    ld   B, $a0                                        ;; 00:1b4f $06 $a0
.jr_00_1b51:
    ld   [HL+], A                                      ;; 00:1b51 $22
    dec  B                                             ;; 00:1b52 $05
    jr   NZ, .jr_00_1b51                               ;; 00:1b53 $20 $fc
    ld   HL, wC100                                     ;; 00:1b55 $21 $00 $c1
    ld   B, $a0                                        ;; 00:1b58 $06 $a0
.jr_00_1b5a:
    ld   [HL+], A                                      ;; 00:1b5a $22
    dec  B                                             ;; 00:1b5b $05
    jr   NZ, .jr_00_1b5a                               ;; 00:1b5c $20 $fc
    ret                                                ;; 00:1b5e $c9

jp_00_1b5f:
    call call_00_28a8                                  ;; 00:1b5f $cd $a8 $28
    ld   A, $0d                                        ;; 00:1b62 $3e $0d
    rst  switchBankSafe                                ;; 00:1b64 $ef
    ret                                                ;; 00:1b65 $c9

call_00_1b66:
    ld   A, [wC305]                                    ;; 00:1b66 $fa $05 $c3
    ld   [wC461], A                                    ;; 00:1b69 $ea $61 $c4
    and  A, $0f                                        ;; 00:1b6c $e6 $0f
    ld   [wC305], A                                    ;; 00:1b6e $ea $05 $c3
    call call_00_2ece                                  ;; 00:1b71 $cd $ce $2e
    rst  rst_00_0020                                   ;; 00:1b74 $e7
    ld   A, [wC305]                                    ;; 00:1b75 $fa $05 $c3
    and  A, $f0                                        ;; 00:1b78 $e6 $f0
    cp   A, $30                                        ;; 00:1b7a $fe $30
    jr   Z, .jr_00_1b90                                ;; 00:1b7c $28 $12
    or   A, A                                          ;; 00:1b7e $b7
    ret  NZ                                            ;; 00:1b7f $c0
    ld   A, [wC305]                                    ;; 00:1b80 $fa $05 $c3
    and  A, $0f                                        ;; 00:1b83 $e6 $0f
    ld   B, A                                          ;; 00:1b85 $47
    ld   A, [wC461]                                    ;; 00:1b86 $fa $61 $c4
    and  A, $f0                                        ;; 00:1b89 $e6 $f0
    or   A, B                                          ;; 00:1b8b $b0
    ld   [wC305], A                                    ;; 00:1b8c $ea $05 $c3
    ret                                                ;; 00:1b8f $c9
.jr_00_1b90:
    ld   A, [wC305]                                    ;; 00:1b90 $fa $05 $c3
    and  A, $0f                                        ;; 00:1b93 $e6 $0f
    ld   [wC305], A                                    ;; 00:1b95 $ea $05 $c3
    ret                                                ;; 00:1b98 $c9

call_00_1b99:
    cp   A, $04                                        ;; 00:1b99 $fe $04
    jr   Z, .jr_00_1bb4                                ;; 00:1b9b $28 $17
    inc  A                                             ;; 00:1b9d $3c
    push BC                                            ;; 00:1b9e $c5
    ld   B, A                                          ;; 00:1b9f $47
    ld   A, [wC2A0]                                    ;; 00:1ba0 $fa $a0 $c2
    rlca                                               ;; 00:1ba3 $07
    rlca                                               ;; 00:1ba4 $07
.jr_00_1ba5:
    rrca                                               ;; 00:1ba5 $0f
    rrca                                               ;; 00:1ba6 $0f
    dec  B                                             ;; 00:1ba7 $05
    jr   NZ, .jr_00_1ba5                               ;; 00:1ba8 $20 $fb
    pop  BC                                            ;; 00:1baa $c1
    and  A, $03                                        ;; 00:1bab $e6 $03
    swap A                                             ;; 00:1bad $cb $37
    sla  A                                             ;; 00:1baf $cb $27
    add  A, L                                          ;; 00:1bb1 $85
    ld   L, A                                          ;; 00:1bb2 $6f
    ret                                                ;; 00:1bb3 $c9
.jr_00_1bb4:
    ld   A, L                                          ;; 00:1bb4 $7d
    add  A, $80                                        ;; 00:1bb5 $c6 $80
    ld   L, A                                          ;; 00:1bb7 $6f
    ret                                                ;; 00:1bb8 $c9

call_00_1bb9:
    ld   C, $00                                        ;; 00:1bb9 $0e $00
    srl  A                                             ;; 00:1bbb $cb $3f
    rr   C                                             ;; 00:1bbd $cb $19
    srl  A                                             ;; 00:1bbf $cb $3f
    rr   C                                             ;; 00:1bc1 $cb $19
    srl  A                                             ;; 00:1bc3 $cb $3f
    rr   C                                             ;; 00:1bc5 $cb $19
    ld   B, A                                          ;; 00:1bc7 $47
    ld   HL, $7000                                     ;; 00:1bc8 $21 $00 $70
    add  HL, BC                                        ;; 00:1bcb $09
    ld   A, $07                                        ;; 00:1bcc $3e $07
    rst  switchBankSafe                                ;; 00:1bce $ef
    ld   DE, wC520                                     ;; 00:1bcf $11 $20 $c5
    ld   B, $20                                        ;; 00:1bd2 $06 $20
.jr_00_1bd4:
    ld   A, [HL+]                                      ;; 00:1bd4 $2a
    ld   [DE], A                                       ;; 00:1bd5 $12
    inc  E                                             ;; 00:1bd6 $1c
    dec  B                                             ;; 00:1bd7 $05
    jr   NZ, .jr_00_1bd4                               ;; 00:1bd8 $20 $fa
    ret                                                ;; 00:1bda $c9

call_00_1bdb:
    ld   A, [wC442]                                    ;; 00:1bdb $fa $42 $c4
    ld   L, A                                          ;; 00:1bde $6f
    ld   A, [wC443]                                    ;; 00:1bdf $fa $43 $c4
    and  A, $01                                        ;; 00:1be2 $e6 $01
    ld   H, A                                          ;; 00:1be4 $67
    add  HL, HL                                        ;; 00:1be5 $29
    add  HL, HL                                        ;; 00:1be6 $29
    ld   DE, $4000                                     ;; 00:1be7 $11 $00 $40
    ld   A, $07                                        ;; 00:1bea $3e $07
    rst  switchBankSafe                                ;; 00:1bec $ef
    add  HL, DE                                        ;; 00:1bed $19
    jr   call_00_1c61                                  ;; 00:1bee $18 $71

call_00_1bf0:
    ld   HL, $1a71                                     ;; 00:1bf0 $21 $71 $1a
    call call_00_29b3                                  ;; 00:1bf3 $cd $b3 $29
    call call_00_2636                                  ;; 00:1bf6 $cd $36 $26
    ld   A, [BC]                                       ;; 00:1bf9 $0a
    res  7, A                                          ;; 00:1bfa $cb $bf
    ld   [BC], A                                       ;; 00:1bfc $02
    ld   A, [wC442]                                    ;; 00:1bfd $fa $42 $c4
    ld   L, A                                          ;; 00:1c00 $6f
    ld   A, [wC443]                                    ;; 00:1c01 $fa $43 $c4
    cp   A, $0e                                        ;; 00:1c04 $fe $0e
    jr   NZ, .jr_00_1c12                               ;; 00:1c06 $20 $0a
    and  A, $01                                        ;; 00:1c08 $e6 $01
    ld   H, A                                          ;; 00:1c0a $67
    add  HL, HL                                        ;; 00:1c0b $29
    add  HL, HL                                        ;; 00:1c0c $29
    ld   DE, $6f80                                     ;; 00:1c0d $11 $80 $6f
    jr   .jr_00_1c27                                   ;; 00:1c10 $18 $15
.jr_00_1c12:
    and  A, $01                                        ;; 00:1c12 $e6 $01
    xor  A, $01                                        ;; 00:1c14 $ee $01
    ld   H, A                                          ;; 00:1c16 $67
    jr   Z, .jr_00_1c22                                ;; 00:1c17 $28 $09
    ld   A, L                                          ;; 00:1c19 $7d
    inc  A                                             ;; 00:1c1a $3c
    jr   NZ, .jr_00_1c22                               ;; 00:1c1b $20 $05
    ld   HL, wC316                                     ;; 00:1c1d $21 $16 $c3
    jr   call_00_1c61                                  ;; 00:1c20 $18 $3f
.jr_00_1c22:
    add  HL, HL                                        ;; 00:1c22 $29
    add  HL, HL                                        ;; 00:1c23 $29
    ld   DE, $4000                                     ;; 00:1c24 $11 $00 $40
.jr_00_1c27:
    ld   A, $07                                        ;; 00:1c27 $3e $07
    rst  switchBankSafe                                ;; 00:1c29 $ef
    add  HL, DE                                        ;; 00:1c2a $19
    ld   A, [wC2A5]                                    ;; 00:1c2b $fa $a5 $c2
    ld   [wC316], A                                    ;; 00:1c2e $ea $16 $c3
    ld   A, [wC2A6]                                    ;; 00:1c31 $fa $a6 $c2
    ld   [wC317], A                                    ;; 00:1c34 $ea $17 $c3
    ld   A, [wC42C]                                    ;; 00:1c37 $fa $2c $c4
    ld   E, A                                          ;; 00:1c3a $5f
    ld   A, [wC42E]                                    ;; 00:1c3b $fa $2e $c4
    swap A                                             ;; 00:1c3e $cb $37
    and  A, $0f                                        ;; 00:1c40 $e6 $0f
    add  A, E                                          ;; 00:1c42 $83
    ld   E, A                                          ;; 00:1c43 $5f
    ld   A, [wC436]                                    ;; 00:1c44 $fa $36 $c4
    xor  A, $01                                        ;; 00:1c47 $ee $01
    rrca                                               ;; 00:1c49 $0f
    rrca                                               ;; 00:1c4a $0f
    and  A, $c0                                        ;; 00:1c4b $e6 $c0
    or   A, E                                          ;; 00:1c4d $b3
    ld   [wC318], A                                    ;; 00:1c4e $ea $18 $c3
    ld   A, [wC42D]                                    ;; 00:1c51 $fa $2d $c4
    ld   E, A                                          ;; 00:1c54 $5f
    ld   A, [wC42F]                                    ;; 00:1c55 $fa $2f $c4
    swap A                                             ;; 00:1c58 $cb $37
    and  A, $0f                                        ;; 00:1c5a $e6 $0f
    add  A, E                                          ;; 00:1c5c $83
    inc  A                                             ;; 00:1c5d $3c
    ld   [wC319], A                                    ;; 00:1c5e $ea $19 $c3

call_00_1c61:
    ld   E, [HL]                                       ;; 00:1c61 $5e
    inc  HL                                            ;; 00:1c62 $23
    ld   D, [HL]                                       ;; 00:1c63 $56
    inc  HL                                            ;; 00:1c64 $23
    ld   A, E                                          ;; 00:1c65 $7b
    ld   [wC2A5], A                                    ;; 00:1c66 $ea $a5 $c2
    ld   [wC44B], A                                    ;; 00:1c69 $ea $4b $c4
    ld   A, D                                          ;; 00:1c6c $7a
    ld   [wC2A6], A                                    ;; 00:1c6d $ea $a6 $c2
    ld   [wC44C], A                                    ;; 00:1c70 $ea $4c $c4
    ld   A, [HL+]                                      ;; 00:1c73 $2a
    ld   B, A                                          ;; 00:1c74 $47
    and  A, $3f                                        ;; 00:1c75 $e6 $3f
    sub  A, $05                                        ;; 00:1c77 $d6 $05
    ld   [wC42C], A                                    ;; 00:1c79 $ea $2c $c4
    ld   A, B                                          ;; 00:1c7c $78
    rlca                                               ;; 00:1c7d $07
    rlca                                               ;; 00:1c7e $07
    and  A, $03                                        ;; 00:1c7f $e6 $03
    ld   [wC436], A                                    ;; 00:1c81 $ea $36 $c4
    ld   A, [HL+]                                      ;; 00:1c84 $2a
    ld   B, A                                          ;; 00:1c85 $47
    and  A, $3f                                        ;; 00:1c86 $e6 $3f
    sub  A, $04                                        ;; 00:1c88 $d6 $04
    ld   [wC42D], A                                    ;; 00:1c8a $ea $2d $c4
    ld   A, B                                          ;; 00:1c8d $78
    and  A, $40                                        ;; 00:1c8e $e6 $40
    ld   [wC44D], A                                    ;; 00:1c90 $ea $4d $c4
    ld   A, B                                          ;; 00:1c93 $78
    and  A, $80                                        ;; 00:1c94 $e6 $80
    ld   B, A                                          ;; 00:1c96 $47
    jr   Z, .jr_00_1c9d                                ;; 00:1c97 $28 $04
    ld   A, $16                                        ;; 00:1c99 $3e $16
    ldh  [hFFB2], A                                    ;; 00:1c9b $e0 $b2
.jr_00_1c9d:
    ld   A, [wC319]                                    ;; 00:1c9d $fa $19 $c3
    or   A, B                                          ;; 00:1ca0 $b0
    ld   [wC319], A                                    ;; 00:1ca1 $ea $19 $c3
    ld   A, $40                                        ;; 00:1ca4 $3e $40
    ld   [wC42F], A                                    ;; 00:1ca6 $ea $2f $c4
    ld   A, $50                                        ;; 00:1ca9 $3e $50
    ld   [wC42E], A                                    ;; 00:1cab $ea $2e $c4
    ret                                                ;; 00:1cae $c9

call_00_1caf:
    ld   A, $07                                        ;; 00:1caf $3e $07
    rst  switchBankSafe                                ;; 00:1cb1 $ef
    ld   A, [wC44B]                                    ;; 00:1cb2 $fa $4b $c4
    ld   E, A                                          ;; 00:1cb5 $5f
    ld   A, [wC44C]                                    ;; 00:1cb6 $fa $4c $c4
    ld   D, A                                          ;; 00:1cb9 $57
    ld   A, [DE]                                       ;; 00:1cba $1a
    inc  DE                                            ;; 00:1cbb $13
    ld   [wC44E], A                                    ;; 00:1cbc $ea $4e $c4
    ld   A, [DE]                                       ;; 00:1cbf $1a
    inc  DE                                            ;; 00:1cc0 $13
    ld   [wC44F], A                                    ;; 00:1cc1 $ea $4f $c4
    ld   A, [DE]                                       ;; 00:1cc4 $1a
    inc  DE                                            ;; 00:1cc5 $13
    ld   [wC450], A                                    ;; 00:1cc6 $ea $50 $c4
    ld   A, [DE]                                       ;; 00:1cc9 $1a
    inc  DE                                            ;; 00:1cca $13
    ld   C, A                                          ;; 00:1ccb $4f
    and  A, $0f                                        ;; 00:1ccc $e6 $0f
    ld   [wC451], A                                    ;; 00:1cce $ea $51 $c4
    ld   A, $80                                        ;; 00:1cd1 $3e $80
    and  A, C                                          ;; 00:1cd3 $a1
    ld   [wC452], A                                    ;; 00:1cd4 $ea $52 $c4
    ld   A, $40                                        ;; 00:1cd7 $3e $40
    and  A, C                                          ;; 00:1cd9 $a1
    ld   [wC453], A                                    ;; 00:1cda $ea $53 $c4
    swap C                                             ;; 00:1cdd $cb $31
    ld   A, C                                          ;; 00:1cdf $79
    and  A, $03                                        ;; 00:1ce0 $e6 $03
    ld   [wC456], A                                    ;; 00:1ce2 $ea $56 $c4
    ld   A, [wC453]                                    ;; 00:1ce5 $fa $53 $c4
    or   A, A                                          ;; 00:1ce8 $b7
    jr   Z, .jr_00_1cf5                                ;; 00:1ce9 $28 $0a
    ld   A, [DE]                                       ;; 00:1ceb $1a
    ld   [wC454], A                                    ;; 00:1cec $ea $54 $c4
    inc  DE                                            ;; 00:1cef $13
    ld   A, [DE]                                       ;; 00:1cf0 $1a
    ld   [wC455], A                                    ;; 00:1cf1 $ea $55 $c4
    inc  DE                                            ;; 00:1cf4 $13
.jr_00_1cf5:
    ld   A, [DE]                                       ;; 00:1cf5 $1a
    ld   L, A                                          ;; 00:1cf6 $6f
    inc  DE                                            ;; 00:1cf7 $13
    ld   A, E                                          ;; 00:1cf8 $7b
    ld   [wC457], A                                    ;; 00:1cf9 $ea $57 $c4
    ld   A, D                                          ;; 00:1cfc $7a
    ld   [wC458], A                                    ;; 00:1cfd $ea $58 $c4
    ld   H, $00                                        ;; 00:1d00 $26 $00
    add  HL, HL                                        ;; 00:1d02 $29
    add  HL, DE                                        ;; 00:1d03 $19
    ld   A, L                                          ;; 00:1d04 $7d
    ld   [wC459], A                                    ;; 00:1d05 $ea $59 $c4
    ld   A, H                                          ;; 00:1d08 $7c
    ld   [wC45A], A                                    ;; 00:1d09 $ea $5a $c4
    ret                                                ;; 00:1d0c $c9

call_00_1d0d:
    ld   A, [wC45C]                                    ;; 00:1d0d $fa $5c $c4
    ld   C, A                                          ;; 00:1d10 $4f
    ld   A, [wC45D]                                    ;; 00:1d11 $fa $5d $c4
    or   A, C                                          ;; 00:1d14 $b1
    ret  NZ                                            ;; 00:1d15 $c0
    ld   A, [wC434]                                    ;; 00:1d16 $fa $34 $c4
    ld   [wCFE6], A                                    ;; 00:1d19 $ea $e6 $cf
    ld   A, [wC43A]                                    ;; 00:1d1c $fa $3a $c4
    ld   [wCFE7], A                                    ;; 00:1d1f $ea $e7 $cf
    ld   A, [wC43B]                                    ;; 00:1d22 $fa $3b $c4
    ld   [wCFE8], A                                    ;; 00:1d25 $ea $e8 $cf
    ld   A, [wC2A5]                                    ;; 00:1d28 $fa $a5 $c2
    ld   [wC45C], A                                    ;; 00:1d2b $ea $5c $c4
    ld   A, [wC2A6]                                    ;; 00:1d2e $fa $a6 $c2
    ld   [wC45D], A                                    ;; 00:1d31 $ea $5d $c4
    ld   A, [wC42C]                                    ;; 00:1d34 $fa $2c $c4
    ld   E, A                                          ;; 00:1d37 $5f
    ld   A, [wC42E]                                    ;; 00:1d38 $fa $2e $c4
    swap A                                             ;; 00:1d3b $cb $37
    and  A, $0f                                        ;; 00:1d3d $e6 $0f
    add  A, E                                          ;; 00:1d3f $83
    ld   E, A                                          ;; 00:1d40 $5f
    ld   A, [wC436]                                    ;; 00:1d41 $fa $36 $c4
    rrca                                               ;; 00:1d44 $0f
    rrca                                               ;; 00:1d45 $0f
    and  A, $c0                                        ;; 00:1d46 $e6 $c0
    or   A, E                                          ;; 00:1d48 $b3
    ld   [wC45E], A                                    ;; 00:1d49 $ea $5e $c4
    ld   A, [wC42D]                                    ;; 00:1d4c $fa $2d $c4
    ld   E, A                                          ;; 00:1d4f $5f
    ld   A, [wC42F]                                    ;; 00:1d50 $fa $2f $c4
    swap A                                             ;; 00:1d53 $cb $37
    and  A, $0f                                        ;; 00:1d55 $e6 $0f
    add  A, E                                          ;; 00:1d57 $83
    ld   [wC45F], A                                    ;; 00:1d58 $ea $5f $c4
    ret                                                ;; 00:1d5b $c9

call_00_1d5c:
    xor  A, A                                          ;; 00:1d5c $af
    ld   [wC446], A                                    ;; 00:1d5d $ea $46 $c4
    ld   DE, wC6F0                                     ;; 00:1d60 $11 $f0 $c6
    ld   HL, wC2A9                                     ;; 00:1d63 $21 $a9 $c2
    ld   C, $04                                        ;; 00:1d66 $0e $04
.jp_00_1d68:
    push HL                                            ;; 00:1d68 $e5
    push BC                                            ;; 00:1d69 $c5
    ld   A, [wC44B]                                    ;; 00:1d6a $fa $4b $c4
    cp   A, [HL]                                       ;; 00:1d6d $be
    jp   NZ, .jp_00_1e10                               ;; 00:1d6e $c2 $10 $1e
    inc  HL                                            ;; 00:1d71 $23
    ld   A, [wC44C]                                    ;; 00:1d72 $fa $4c $c4
    xor  A, [HL]                                       ;; 00:1d75 $ae
    and  A, $3f                                        ;; 00:1d76 $e6 $3f
    jp   NZ, .jp_00_1e10                               ;; 00:1d78 $c2 $10 $1e
    ld   A, [HL+]                                      ;; 00:1d7b $2a
    and  A, $c0                                        ;; 00:1d7c $e6 $c0
    rlca                                               ;; 00:1d7e $07
    rlca                                               ;; 00:1d7f $07
    inc  A                                             ;; 00:1d80 $3c
    ld   C, $80                                        ;; 00:1d81 $0e $80
.jr_00_1d83:
    rlc  C                                             ;; 00:1d83 $cb $01
    dec  A                                             ;; 00:1d85 $3d
    jr   NZ, .jr_00_1d83                               ;; 00:1d86 $20 $fb
    ld   A, E                                          ;; 00:1d88 $7b
    or   A, $0c                                        ;; 00:1d89 $f6 $0c
    ld   E, A                                          ;; 00:1d8b $5f
    ld   A, C                                          ;; 00:1d8c $79
    ld   [DE], A                                       ;; 00:1d8d $12
    ld   A, E                                          ;; 00:1d8e $7b
    and  A, $f0                                        ;; 00:1d8f $e6 $f0
    ld   E, A                                          ;; 00:1d91 $5f
    pop  BC                                            ;; 00:1d92 $c1
    push BC                                            ;; 00:1d93 $c5
    ld   A, $05                                        ;; 00:1d94 $3e $05
    sub  A, C                                          ;; 00:1d96 $91
    ld   C, A                                          ;; 00:1d97 $4f
    push DE                                            ;; 00:1d98 $d5
    ld   E, $1f                                        ;; 00:1d99 $1e $1f
    call call_00_0192                                  ;; 00:1d9b $cd $92 $01
    pop  DE                                            ;; 00:1d9e $d1
    cp   A, C                                          ;; 00:1d9f $b9
    ld   B, $80                                        ;; 00:1da0 $06 $80
    jr   Z, .jr_00_1da6                                ;; 00:1da2 $28 $02
    ld   B, $00                                        ;; 00:1da4 $06 $00
.jr_00_1da6:
    ld   A, [HL+]                                      ;; 00:1da6 $2a
    ld   C, A                                          ;; 00:1da7 $4f
    and  A, $3f                                        ;; 00:1da8 $e6 $3f
    or   A, $40                                        ;; 00:1daa $f6 $40
    or   A, B                                          ;; 00:1dac $b0
    ld   [DE], A                                       ;; 00:1dad $12
    inc  E                                             ;; 00:1dae $1c
    xor  A, A                                          ;; 00:1daf $af
    ld   [DE], A                                       ;; 00:1db0 $12
    inc  E                                             ;; 00:1db1 $1c
    ld   A, B                                          ;; 00:1db2 $78
    or   A, A                                          ;; 00:1db3 $b7
    ld   A, [HL+]                                      ;; 00:1db4 $2a
    ld   B, A                                          ;; 00:1db5 $47
    jr   NZ, .jr_00_1dc8                               ;; 00:1db6 $20 $10
    push BC                                            ;; 00:1db8 $c5
    ld   A, C                                          ;; 00:1db9 $79
    and  A, $3f                                        ;; 00:1dba $e6 $3f
    ld   C, A                                          ;; 00:1dbc $4f
    ld   A, B                                          ;; 00:1dbd $78
    and  A, $3f                                        ;; 00:1dbe $e6 $3f
    ld   B, A                                          ;; 00:1dc0 $47
    call call_00_2636                                  ;; 00:1dc1 $cd $36 $26
    set  7, A                                          ;; 00:1dc4 $cb $ff
    ld   [BC], A                                       ;; 00:1dc6 $02
    pop  BC                                            ;; 00:1dc7 $c1
.jr_00_1dc8:
    ld   A, B                                          ;; 00:1dc8 $78
    and  A, $3f                                        ;; 00:1dc9 $e6 $3f
    ld   [DE], A                                       ;; 00:1dcb $12
    inc  E                                             ;; 00:1dcc $1c
    xor  A, A                                          ;; 00:1dcd $af
    ld   [DE], A                                       ;; 00:1dce $12
    inc  E                                             ;; 00:1dcf $1c
    ld   [DE], A                                       ;; 00:1dd0 $12
    ld   A, B                                          ;; 00:1dd1 $78
    and  A, $c0                                        ;; 00:1dd2 $e6 $c0
    rrca                                               ;; 00:1dd4 $0f
    rrca                                               ;; 00:1dd5 $0f
    ld   B, A                                          ;; 00:1dd6 $47
    ld   A, E                                          ;; 00:1dd7 $7b
    and  A, $f0                                        ;; 00:1dd8 $e6 $f0
    or   A, $0c                                        ;; 00:1dda $f6 $0c
    ld   E, A                                          ;; 00:1ddc $5f
    ld   A, [DE]                                       ;; 00:1ddd $1a
    or   A, B                                          ;; 00:1dde $b0
    ld   [DE], A                                       ;; 00:1ddf $12
    ld   A, E                                          ;; 00:1de0 $7b
    and  A, $f0                                        ;; 00:1de1 $e6 $f0
    or   A, $05                                        ;; 00:1de3 $f6 $05
    ld   E, A                                          ;; 00:1de5 $5f
    ld   A, B                                          ;; 00:1de6 $78
    or   A, A                                          ;; 00:1de7 $b7
    jr   Z, .jr_00_1dec                                ;; 00:1de8 $28 $02
    ld   B, $01                                        ;; 00:1dea $06 $01
.jr_00_1dec:
    ld   A, C                                          ;; 00:1dec $79
    and  A, $c0                                        ;; 00:1ded $e6 $c0
    ld   C, A                                          ;; 00:1def $4f
    rrca                                               ;; 00:1df0 $0f
    rrca                                               ;; 00:1df1 $0f
    or   A, C                                          ;; 00:1df2 $b1
    or   A, B                                          ;; 00:1df3 $b0
    ld   [DE], A                                       ;; 00:1df4 $12
    inc  E                                             ;; 00:1df5 $1c
    xor  A, A                                          ;; 00:1df6 $af
    ld   [DE], A                                       ;; 00:1df7 $12
    inc  E                                             ;; 00:1df8 $1c
    inc  E                                             ;; 00:1df9 $1c
    pop  BC                                            ;; 00:1dfa $c1
    push BC                                            ;; 00:1dfb $c5
    ld   A, $10                                        ;; 00:1dfc $3e $10
    ld   [DE], A                                       ;; 00:1dfe $12
    inc  E                                             ;; 00:1dff $1c
    ld   A, $04                                        ;; 00:1e00 $3e $04
    sub  A, C                                          ;; 00:1e02 $91
    or   A, $08                                        ;; 00:1e03 $f6 $08
    ld   [DE], A                                       ;; 00:1e05 $12
    inc  E                                             ;; 00:1e06 $1c
    ld   A, $f0                                        ;; 00:1e07 $3e $f0
    ld   [DE], A                                       ;; 00:1e09 $12
    inc  E                                             ;; 00:1e0a $1c
    xor  A, A                                          ;; 00:1e0b $af
    ld   [DE], A                                       ;; 00:1e0c $12
    inc  E                                             ;; 00:1e0d $1c
    inc  E                                             ;; 00:1e0e $1c
    ld   [DE], A                                       ;; 00:1e0f $12
.jp_00_1e10:
    pop  BC                                            ;; 00:1e10 $c1
    pop  HL                                            ;; 00:1e11 $e1
    inc  L                                             ;; 00:1e12 $2c
    inc  L                                             ;; 00:1e13 $2c
    inc  L                                             ;; 00:1e14 $2c
    inc  L                                             ;; 00:1e15 $2c
    ld   A, E                                          ;; 00:1e16 $7b
    and  A, $f0                                        ;; 00:1e17 $e6 $f0
    sub  A, $10                                        ;; 00:1e19 $d6 $10
    ld   E, A                                          ;; 00:1e1b $5f
    dec  C                                             ;; 00:1e1c $0d
    jp   NZ, .jp_00_1d68                               ;; 00:1e1d $c2 $68 $1d
    ret                                                ;; 00:1e20 $c9

call_00_1e21:
    push DE                                            ;; 00:1e21 $d5
    ld   E, $1f                                        ;; 00:1e22 $1e $1f
    call call_00_0192                                  ;; 00:1e24 $cd $92 $01
    pop  DE                                            ;; 00:1e27 $d1
    or   A, A                                          ;; 00:1e28 $b7
    jr   Z, .jr_00_1e53                                ;; 00:1e29 $28 $28
    ld   B, A                                          ;; 00:1e2b $47
    ld   A, $05                                        ;; 00:1e2c $3e $05
    sub  A, B                                          ;; 00:1e2e $90
    ld   B, $80                                        ;; 00:1e2f $06 $80
.jr_00_1e31:
    rlc  B                                             ;; 00:1e31 $cb $00
    dec  A                                             ;; 00:1e33 $3d
    jr   NZ, .jr_00_1e31                               ;; 00:1e34 $20 $fb
    ld   A, B                                          ;; 00:1e36 $78
    ld   [wC43E], A                                    ;; 00:1e37 $ea $3e $c4
    ld   [wC43F], A                                    ;; 00:1e3a $ea $3f $c4
    ld   A, $01                                        ;; 00:1e3d $3e $01
    ld   [wC430], A                                    ;; 00:1e3f $ea $30 $c4
    ld   A, $01                                        ;; 00:1e42 $3e $01
    ld   [wC431], A                                    ;; 00:1e44 $ea $31 $c4
    ld   A, $80                                        ;; 00:1e47 $3e $80
    ld   [wC432], A                                    ;; 00:1e49 $ea $32 $c4
    ld   A, $40                                        ;; 00:1e4c $3e $40
    ld   [wC433], A                                    ;; 00:1e4e $ea $33 $c4
    jr   .jr_00_1e62                                   ;; 00:1e51 $18 $0f
.jr_00_1e53:
    ld   A, $01                                        ;; 00:1e53 $3e $01
    ld   [wC43E], A                                    ;; 00:1e55 $ea $3e $c4
    ld   [wC43F], A                                    ;; 00:1e58 $ea $3f $c4
    xor  A, A                                          ;; 00:1e5b $af
    ld   [wC430], A                                    ;; 00:1e5c $ea $30 $c4
    call call_00_1ec2                                  ;; 00:1e5f $cd $c2 $1e
.jr_00_1e62:
    xor  A, A                                          ;; 00:1e62 $af
    ld   [wC437], A                                    ;; 00:1e63 $ea $37 $c4
    ld   [wC43D], A                                    ;; 00:1e66 $ea $3d $c4
    ld   [wC438], A                                    ;; 00:1e69 $ea $38 $c4

call_00_1e6c:
    ld   HL, $1a71                                     ;; 00:1e6c $21 $71 $1a
    call call_00_29b3                                  ;; 00:1e6f $cd $b3 $29
    call call_00_2636                                  ;; 00:1e72 $cd $36 $26
    ld   A, [BC]                                       ;; 00:1e75 $0a
    set  7, A                                          ;; 00:1e76 $cb $ff
    ld   [BC], A                                       ;; 00:1e78 $02
    call call_00_2946                                  ;; 00:1e79 $cd $46 $29
    ld   C, A                                          ;; 00:1e7c $4f
    and  A, $20                                        ;; 00:1e7d $e6 $20
    ld   [wC43C], A                                    ;; 00:1e7f $ea $3c $c4
    ld   A, C                                          ;; 00:1e82 $79
    and  A, $1f                                        ;; 00:1e83 $e6 $1f
    add  A, $20                                        ;; 00:1e85 $c6 $20
    ld   C, A                                          ;; 00:1e87 $4f
    ld   B, $c5                                        ;; 00:1e88 $06 $c5
    ld   A, [BC]                                       ;; 00:1e8a $0a
    ld   E, A                                          ;; 00:1e8b $5f
    cp   A, $c0                                        ;; 00:1e8c $fe $c0
    jr   NC, .jr_00_1eb4                               ;; 00:1e8e $30 $24
    bit  7, A                                          ;; 00:1e90 $cb $7f
    jr   NZ, .jr_00_1ea1                               ;; 00:1e92 $20 $0d
    bit  2, A                                          ;; 00:1e94 $cb $57
    jr   NZ, .jr_00_1ea9                               ;; 00:1e96 $20 $11
    and  A, $03                                        ;; 00:1e98 $e6 $03
    jr   Z, .jr_00_1e9e                                ;; 00:1e9a $28 $02
    xor  A, $03                                        ;; 00:1e9c $ee $03
.jr_00_1e9e:
    ld   [wC434], A                                    ;; 00:1e9e $ea $34 $c4
.jr_00_1ea1:
    ld   A, E                                          ;; 00:1ea1 $7b
    and  A, $30                                        ;; 00:1ea2 $e6 $30
    ld   [wC43B], A                                    ;; 00:1ea4 $ea $3b $c4
    jr   .jr_00_1ebb                                   ;; 00:1ea7 $18 $12
.jr_00_1ea9:
    ld   A, [wC434]                                    ;; 00:1ea9 $fa $34 $c4
    and  A, $01                                        ;; 00:1eac $e6 $01
    jr   Z, .jr_00_1ea1                                ;; 00:1eae $28 $f1
    ld   E, $30                                        ;; 00:1eb0 $1e $30
    jr   .jr_00_1ea1                                   ;; 00:1eb2 $18 $ed
.jr_00_1eb4:
    xor  A, A                                          ;; 00:1eb4 $af
    ld   [wC43B], A                                    ;; 00:1eb5 $ea $3b $c4
    ld   [wC434], A                                    ;; 00:1eb8 $ea $34 $c4
.jr_00_1ebb:
    ld   A, [wC436]                                    ;; 00:1ebb $fa $36 $c4
    call call_00_29e2                                  ;; 00:1ebe $cd $e2 $29
    ret                                                ;; 00:1ec1 $c9

call_00_1ec2:
    ld   E, $1f                                        ;; 00:1ec2 $1e $1f
    call call_00_0192                                  ;; 00:1ec4 $cd $92 $01
    or   A, A                                          ;; 00:1ec7 $b7
    jr   NZ, .jr_00_1f0a                               ;; 00:1ec8 $20 $40
    xor  A, A                                          ;; 00:1eca $af
.jr_00_1ecb:
    push AF                                            ;; 00:1ecb $f5
    ld   HL, wC206                                     ;; 00:1ecc $21 $06 $c2
    call call_00_1b99                                  ;; 00:1ecf $cd $99 $1b
    pop  AF                                            ;; 00:1ed2 $f1
    bit  4, [HL]                                       ;; 00:1ed3 $cb $66
    jr   Z, .jr_00_1eda                                ;; 00:1ed5 $28 $03
    inc  A                                             ;; 00:1ed7 $3c
    jr   .jr_00_1ecb                                   ;; 00:1ed8 $18 $f1
.jr_00_1eda:
    ld   A, L                                          ;; 00:1eda $7d
    sub  A, $02                                        ;; 00:1edb $d6 $02
    ld   L, A                                          ;; 00:1edd $6f
    ld   A, [HL]                                       ;; 00:1ede $7e
    ld   B, $00                                        ;; 00:1edf $06 $00
    ld   C, A                                          ;; 00:1ee1 $4f
    ld   HL, $6b70                                     ;; 00:1ee2 $21 $70 $6b
    add  HL, BC                                        ;; 00:1ee5 $09
    ld   A, $0d                                        ;; 00:1ee6 $3e $0d
    rst  switchBankSafe                                ;; 00:1ee8 $ef
    ld   A, [HL]                                       ;; 00:1ee9 $7e
    add  A, $00                                        ;; 00:1eea $c6 $00
    ld   L, A                                          ;; 00:1eec $6f
    ld   H, $43                                        ;; 00:1eed $26 $43
    ld   A, $01                                        ;; 00:1eef $3e $01
    rst  switchBankSafe                                ;; 00:1ef1 $ef
    ld   C, $00                                        ;; 00:1ef2 $0e $00
    ld   A, [HL]                                       ;; 00:1ef4 $7e
    ld   [wC431], A                                    ;; 00:1ef5 $ea $31 $c4
    srl  A                                             ;; 00:1ef8 $cb $3f
    rr   C                                             ;; 00:1efa $cb $19
    ld   B, A                                          ;; 00:1efc $47
    ld   HL, $4000                                     ;; 00:1efd $21 $00 $40
    add  HL, BC                                        ;; 00:1f00 $09
    ld   A, L                                          ;; 00:1f01 $7d
    ld   [wC432], A                                    ;; 00:1f02 $ea $32 $c4
    ld   A, H                                          ;; 00:1f05 $7c
    ld   [wC433], A                                    ;; 00:1f06 $ea $33 $c4
    ret                                                ;; 00:1f09 $c9
.jr_00_1f0a:
    ld   A, $01                                        ;; 00:1f0a $3e $01
    ld   [wC431], A                                    ;; 00:1f0c $ea $31 $c4
    ld   A, $80                                        ;; 00:1f0f $3e $80
    ld   [wC432], A                                    ;; 00:1f11 $ea $32 $c4
    ld   A, $40                                        ;; 00:1f14 $3e $40
    ld   [wC433], A                                    ;; 00:1f16 $ea $33 $c4
    ret                                                ;; 00:1f19 $c9
    db   $cd, $23, $1f, $cd, $c2, $1e, $c3, $bb        ;; 00:1f1a ????????
    db   $1e                                           ;; 00:1f22 ?

call_00_1f23:
    xor  A, A                                          ;; 00:1f23 $af
.jr_00_1f24:
    push AF                                            ;; 00:1f24 $f5
    ld   HL, wC206                                     ;; 00:1f25 $21 $06 $c2
    call call_00_1b99                                  ;; 00:1f28 $cd $99 $1b
    pop  AF                                            ;; 00:1f2b $f1
    bit  4, [HL]                                       ;; 00:1f2c $cb $66
    jr   Z, .jr_00_1f33                                ;; 00:1f2e $28 $03
    inc  A                                             ;; 00:1f30 $3c
    jr   .jr_00_1f24                                   ;; 00:1f31 $18 $f1
.jr_00_1f33:
    ld   A, L                                          ;; 00:1f33 $7d
    sub  A, $02                                        ;; 00:1f34 $d6 $02
    ld   L, A                                          ;; 00:1f36 $6f
    ld   A, [HL]                                       ;; 00:1f37 $7e
    ld   B, $00                                        ;; 00:1f38 $06 $00
    ld   C, A                                          ;; 00:1f3a $4f
    ld   HL, data_0d_6b70 ;@=ptr bank=0D               ;; 00:1f3b $21 $70 $6b
    add  HL, BC                                        ;; 00:1f3e $09
    ld   A, $0d                                        ;; 00:1f3f $3e $0d
    rst  switchBankSafe                                ;; 00:1f41 $ef
    ld   A, [HL]                                       ;; 00:1f42 $7e
    add  A, $40                                        ;; 00:1f43 $c6 $40
    ld   H, A                                          ;; 00:1f45 $67
    ld   L, $00                                        ;; 00:1f46 $2e $00
    ld   A, $03                                        ;; 00:1f48 $3e $03
    rst  switchBankSafe                                ;; 00:1f4a $ef
    ld   DE, $8000                                     ;; 00:1f4b $11 $00 $80
    ld   BC, $100                                      ;; 00:1f4e $01 $00 $01
    call call_00_00ac                                  ;; 00:1f51 $cd $ac $00
    ret                                                ;; 00:1f54 $c9

call_00_1f55:
    ld   C, $00                                        ;; 00:1f55 $0e $00
    srl  A                                             ;; 00:1f57 $cb $3f
    rr   C                                             ;; 00:1f59 $cb $19
    srl  A                                             ;; 00:1f5b $cb $3f
    rr   C                                             ;; 00:1f5d $cb $19
    srl  A                                             ;; 00:1f5f $cb $3f
    rr   C                                             ;; 00:1f61 $cb $19
    ld   B, A                                          ;; 00:1f63 $47
    ld   HL, data_07_7800 ;@=ptr bank=07               ;; 00:1f64 $21 $00 $78
    add  HL, BC                                        ;; 00:1f67 $09
    ld   A, $02                                        ;; 00:1f68 $3e $02
    rst  switchBankSafe                                ;; 00:1f6a $ef
.jr_00_1f6b:
    ldh  A, [rLY]                                      ;; 00:1f6b $f0 $44
    cp   A, $96                                        ;; 00:1f6d $fe $96
    jr   NZ, .jr_00_1f6b                               ;; 00:1f6f $20 $fa
    ld   A, $43                                        ;; 00:1f71 $3e $43
    ldh  [rLCDC], A                                    ;; 00:1f73 $e0 $40
    ld   DE, $9000                                     ;; 00:1f75 $11 $00 $90
    ld   B, $20                                        ;; 00:1f78 $06 $20
.jr_00_1f7a:
    push BC                                            ;; 00:1f7a $c5
    ld   A, $07                                        ;; 00:1f7b $3e $07
    call readFromBank                                  ;; 00:1f7d $cd $d2 $00
    inc  HL                                            ;; 00:1f80 $23
    ld   B, A                                          ;; 00:1f81 $47
    ld   C, $00                                        ;; 00:1f82 $0e $00
    srl  B                                             ;; 00:1f84 $cb $38
    rr   C                                             ;; 00:1f86 $cb $19
    srl  B                                             ;; 00:1f88 $cb $38
    rr   C                                             ;; 00:1f8a $cb $19
    push HL                                            ;; 00:1f8c $e5
    ld   HL, data_02_4000 ;@=ptr bank=2                ;; 00:1f8d $21 $00 $40
    add  HL, BC                                        ;; 00:1f90 $09
    ld   B, $40                                        ;; 00:1f91 $06 $40
    call memcopySmall                                  ;; 00:1f93 $cd $80 $00
    pop  HL                                            ;; 00:1f96 $e1
    pop  BC                                            ;; 00:1f97 $c1
    dec  B                                             ;; 00:1f98 $05
    jr   NZ, .jr_00_1f7a                               ;; 00:1f99 $20 $df
    ld   A, $c3                                        ;; 00:1f9b $3e $c3
    ldh  [rLCDC], A                                    ;; 00:1f9d $e0 $40
    xor  A, A                                          ;; 00:1f9f $af
    ld   [wC439], A                                    ;; 00:1fa0 $ea $39 $c4
    ret                                                ;; 00:1fa3 $c9

call_00_1fa4:
    call call_00_2f7f                                  ;; 00:1fa4 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:1fa7 $d7
    call call_00_1a97                                  ;; 00:1fa8 $cd $97 $1a

call_00_1fab:
    call call_00_21ea                                  ;; 00:1fab $cd $ea $21
    ld   C, $c1                                        ;; 00:1fae $0e $c1
    ld   A, [wC43E]                                    ;; 00:1fb0 $fa $3e $c4
    ld   B, A                                          ;; 00:1fb3 $47
    ld   A, [wC43D]                                    ;; 00:1fb4 $fa $3d $c4
    dec  A                                             ;; 00:1fb7 $3d
    jr   Z, .jr_00_1fd4                                ;; 00:1fb8 $28 $1a
    dec  A                                             ;; 00:1fba $3d
    jr   Z, .jr_00_1fd0                                ;; 00:1fbb $28 $13
    dec  A                                             ;; 00:1fbd $3d
    jr   Z, .jr_00_1fc8                                ;; 00:1fbe $28 $08
    inc  C                                             ;; 00:1fc0 $0c
    ldh  A, [C]                                        ;; 00:1fc1 $f2
    add  A, B                                          ;; 00:1fc2 $80
    ldh  [C], A                                        ;; 00:1fc3 $e2
    add  A, $08                                        ;; 00:1fc4 $c6 $08
    jr   .jr_00_1fd9                                   ;; 00:1fc6 $18 $11
.jr_00_1fc8:
    inc  C                                             ;; 00:1fc8 $0c
    ldh  A, [C]                                        ;; 00:1fc9 $f2
    sub  A, B                                          ;; 00:1fca $90
    ldh  [C], A                                        ;; 00:1fcb $e2
    add  A, $08                                        ;; 00:1fcc $c6 $08
    jr   .jr_00_1fd9                                   ;; 00:1fce $18 $09
.jr_00_1fd0:
    ldh  A, [C]                                        ;; 00:1fd0 $f2
    sub  A, B                                          ;; 00:1fd1 $90
    jr   .jr_00_1fd8                                   ;; 00:1fd2 $18 $04
.jr_00_1fd4:
    ldh  A, [C]                                        ;; 00:1fd4 $f2
    add  A, B                                          ;; 00:1fd5 $80
    jr   .jr_00_1fd8                                   ;; 00:1fd6 $18 $00
.jr_00_1fd8:
    ldh  [C], A                                        ;; 00:1fd8 $e2
.jr_00_1fd9:
    and  A, $0f                                        ;; 00:1fd9 $e6 $0f
    ret  NZ                                            ;; 00:1fdb $c0
    ld   [wC43D], A                                    ;; 00:1fdc $ea $3d $c4
    ld   A, [wC43F]                                    ;; 00:1fdf $fa $3f $c4
    ld   [wC43E], A                                    ;; 00:1fe2 $ea $3e $c4
    xor  A, A                                          ;; 00:1fe5 $af
    ld   [wC437], A                                    ;; 00:1fe6 $ea $37 $c4
    ret                                                ;; 00:1fe9 $c9

call_00_1fea:
    add  A, A                                          ;; 00:1fea $87
    ld   E, A                                          ;; 00:1feb $5f
    ld   D, $00                                        ;; 00:1fec $16 $00
    ld   HL, $2007                                     ;; 00:1fee $21 $07 $20
    add  HL, DE                                        ;; 00:1ff1 $19
    ld   E, [HL]                                       ;; 00:1ff2 $5e
    inc  HL                                            ;; 00:1ff3 $23
    ld   D, [HL]                                       ;; 00:1ff4 $56
    ld   A, [wC449]                                    ;; 00:1ff5 $fa $49 $c4
    ld   L, A                                          ;; 00:1ff8 $6f
    ld   A, [wC44A]                                    ;; 00:1ff9 $fa $4a $c4
    ld   H, A                                          ;; 00:1ffc $67
    ld   A, [wC42D]                                    ;; 00:1ffd $fa $2d $c4
    ld   B, A                                          ;; 00:2000 $47
    ld   A, [wC42C]                                    ;; 00:2001 $fa $2c $c4
    ld   C, A                                          ;; 00:2004 $4f
    push DE                                            ;; 00:2005 $d5
    ret                                                ;; 00:2006 $c9
    dw   .data_00_2033                                 ;; 00:2007 pP
    dw   .data_00_200f                                 ;; 00:2009 pP
    dw   .data_00_2062                                 ;; 00:200b pP
    dw   .data_00_2089                                 ;; 00:200d pP
.data_00_200f:
    ld   A, [wC42D]                                    ;; 00:200f $fa $2d $c4
    dec  A                                             ;; 00:2012 $3d
    ld   [wC42D], A                                    ;; 00:2013 $ea $2d $c4
    dec  B                                             ;; 00:2016 $05
    ld   DE, hFFC0                                     ;; 00:2017 $11 $c0 $ff
    add  HL, DE                                        ;; 00:201a $19
    ld   A, H                                          ;; 00:201b $7c
    and  A, $fb                                        ;; 00:201c $e6 $fb
    or   A, $08                                        ;; 00:201e $f6 $08
    ld   H, A                                          ;; 00:2020 $67
    ld   A, L                                          ;; 00:2021 $7d
    ld   [wC449], A                                    ;; 00:2022 $ea $49 $c4
    ld   A, H                                          ;; 00:2025 $7c
    ld   [wC44A], A                                    ;; 00:2026 $ea $4a $c4
    call call_00_2104                                  ;; 00:2029 $cd $04 $21
    call call_00_2155                                  ;; 00:202c $cd $55 $21
    call call_00_1fab                                  ;; 00:202f $cd $ab $1f
    ret                                                ;; 00:2032 $c9
.data_00_2033:
    ld   A, [wC42D]                                    ;; 00:2033 $fa $2d $c4
    inc  A                                             ;; 00:2036 $3c
    ld   [wC42D], A                                    ;; 00:2037 $ea $2d $c4
    ld   A, B                                          ;; 00:203a $78
    add  A, $09                                        ;; 00:203b $c6 $09
    ld   B, A                                          ;; 00:203d $47
    ld   DE, $240                                      ;; 00:203e $11 $40 $02
    add  HL, DE                                        ;; 00:2041 $19
    ld   A, H                                          ;; 00:2042 $7c
    and  A, $fb                                        ;; 00:2043 $e6 $fb
    ld   H, A                                          ;; 00:2045 $67
    call call_00_2104                                  ;; 00:2046 $cd $04 $21
    call call_00_2155                                  ;; 00:2049 $cd $55 $21
    ld   A, [wC449]                                    ;; 00:204c $fa $49 $c4
    add  A, $40                                        ;; 00:204f $c6 $40
    ld   [wC449], A                                    ;; 00:2051 $ea $49 $c4
    ld   A, [wC44A]                                    ;; 00:2054 $fa $4a $c4
    adc  A, $00                                        ;; 00:2057 $ce $00
    and  A, $fb                                        ;; 00:2059 $e6 $fb
    ld   [wC44A], A                                    ;; 00:205b $ea $4a $c4
    call call_00_1fab                                  ;; 00:205e $cd $ab $1f
    ret                                                ;; 00:2061 $c9
.data_00_2062:
    ld   A, [wC42C]                                    ;; 00:2062 $fa $2c $c4
    dec  A                                             ;; 00:2065 $3d
    ld   [wC42C], A                                    ;; 00:2066 $ea $2c $c4
    dec  C                                             ;; 00:2069 $0d
    ld   A, L                                          ;; 00:206a $7d
    dec  A                                             ;; 00:206b $3d
    dec  A                                             ;; 00:206c $3d
    and  A, $1f                                        ;; 00:206d $e6 $1f
    push AF                                            ;; 00:206f $f5
    ld   A, L                                          ;; 00:2070 $7d
    and  A, $e0                                        ;; 00:2071 $e6 $e0
    ld   L, A                                          ;; 00:2073 $6f
    pop  AF                                            ;; 00:2074 $f1
    or   A, L                                          ;; 00:2075 $b5
    ld   L, A                                          ;; 00:2076 $6f
    ld   A, L                                          ;; 00:2077 $7d
    ld   [wC449], A                                    ;; 00:2078 $ea $49 $c4
    ld   A, H                                          ;; 00:207b $7c
    ld   [wC44A], A                                    ;; 00:207c $ea $4a $c4
    call call_00_212c                                  ;; 00:207f $cd $2c $21
    call call_00_2178                                  ;; 00:2082 $cd $78 $21
    call call_00_1fab                                  ;; 00:2085 $cd $ab $1f
    ret                                                ;; 00:2088 $c9
.data_00_2089:
    ld   A, [wC42C]                                    ;; 00:2089 $fa $2c $c4
    inc  A                                             ;; 00:208c $3c
    ld   [wC42C], A                                    ;; 00:208d $ea $2c $c4
    ld   A, C                                          ;; 00:2090 $79
    add  A, $0b                                        ;; 00:2091 $c6 $0b
    ld   C, A                                          ;; 00:2093 $4f
    ld   A, L                                          ;; 00:2094 $7d
    add  A, $16                                        ;; 00:2095 $c6 $16
    and  A, $1f                                        ;; 00:2097 $e6 $1f
    push AF                                            ;; 00:2099 $f5
    ld   A, L                                          ;; 00:209a $7d
    and  A, $e0                                        ;; 00:209b $e6 $e0
    ld   L, A                                          ;; 00:209d $6f
    pop  AF                                            ;; 00:209e $f1
    or   A, L                                          ;; 00:209f $b5
    ld   L, A                                          ;; 00:20a0 $6f
    call call_00_212c                                  ;; 00:20a1 $cd $2c $21
    call call_00_2178                                  ;; 00:20a4 $cd $78 $21
    ld   A, [wC449]                                    ;; 00:20a7 $fa $49 $c4
    ld   L, A                                          ;; 00:20aa $6f
    ld   A, [wC44A]                                    ;; 00:20ab $fa $4a $c4
    ld   H, A                                          ;; 00:20ae $67
    ld   A, L                                          ;; 00:20af $7d
    inc  A                                             ;; 00:20b0 $3c
    inc  A                                             ;; 00:20b1 $3c
    and  A, $1f                                        ;; 00:20b2 $e6 $1f
    push AF                                            ;; 00:20b4 $f5
    ld   A, L                                          ;; 00:20b5 $7d
    and  A, $e0                                        ;; 00:20b6 $e6 $e0
    ld   L, A                                          ;; 00:20b8 $6f
    pop  AF                                            ;; 00:20b9 $f1
    or   A, L                                          ;; 00:20ba $b5
    ld   L, A                                          ;; 00:20bb $6f
    ld   A, L                                          ;; 00:20bc $7d
    ld   [wC449], A                                    ;; 00:20bd $ea $49 $c4
    ld   A, H                                          ;; 00:20c0 $7c
    ld   [wC44A], A                                    ;; 00:20c1 $ea $4a $c4
    call call_00_1fab                                  ;; 00:20c4 $cd $ab $1f
    ret                                                ;; 00:20c7 $c9

call_00_20c8:
    ld   HL, wC449                                     ;; 00:20c8 $21 $49 $c4
    ld   [HL], $00                                     ;; 00:20cb $36 $00
    inc  HL                                            ;; 00:20cd $23
    ld   [HL], $98                                     ;; 00:20ce $36 $98
    xor  A, A                                          ;; 00:20d0 $af
    ldh  [hFFC1], A                                    ;; 00:20d1 $e0 $c1
    ld   A, $08                                        ;; 00:20d3 $3e $08
    ldh  [hFFC2], A                                    ;; 00:20d5 $e0 $c2
    call call_00_20db                                  ;; 00:20d7 $cd $db $20
    ret                                                ;; 00:20da $c9

call_00_20db:
    ld   A, [wC449]                                    ;; 00:20db $fa $49 $c4
    ld   L, A                                          ;; 00:20de $6f
    ld   A, [wC44A]                                    ;; 00:20df $fa $4a $c4
    ld   H, A                                          ;; 00:20e2 $67
    ld   A, [wC42D]                                    ;; 00:20e3 $fa $2d $c4
    ld   B, A                                          ;; 00:20e6 $47
    ld   A, $09                                        ;; 00:20e7 $3e $09
.jr_00_20e9:
    push AF                                            ;; 00:20e9 $f5
    push HL                                            ;; 00:20ea $e5
    ld   A, [wC42C]                                    ;; 00:20eb $fa $2c $c4
    ld   C, A                                          ;; 00:20ee $4f
    call call_00_2104                                  ;; 00:20ef $cd $04 $21
    call call_00_2155                                  ;; 00:20f2 $cd $55 $21
    pop  HL                                            ;; 00:20f5 $e1
    ld   DE, $40                                       ;; 00:20f6 $11 $40 $00
    add  HL, DE                                        ;; 00:20f9 $19
    ld   A, H                                          ;; 00:20fa $7c
    and  A, $fb                                        ;; 00:20fb $e6 $fb
    ld   H, A                                          ;; 00:20fd $67
    pop  AF                                            ;; 00:20fe $f1
    inc  B                                             ;; 00:20ff $04
    dec  A                                             ;; 00:2100 $3d
    jr   NZ, .jr_00_20e9                               ;; 00:2101 $20 $e6
    ret                                                ;; 00:2103 $c9

call_00_2104:
    push HL                                            ;; 00:2104 $e5
    ld   HL, wC400                                     ;; 00:2105 $21 $00 $c4
    ld   A, $0b                                        ;; 00:2108 $3e $0b
.jr_00_210a:
    push AF                                            ;; 00:210a $f5
    ld   A, B                                          ;; 00:210b $78
    or   A, C                                          ;; 00:210c $b1
    and  A, $c0                                        ;; 00:210d $e6 $c0
    jr   NZ, .jr_00_2118                               ;; 00:210f $20 $07
    push BC                                            ;; 00:2111 $c5
    call call_00_2636                                  ;; 00:2112 $cd $36 $26
    pop  BC                                            ;; 00:2115 $c1
    jr   .jr_00_2119                                   ;; 00:2116 $18 $01
.jr_00_2118:
    xor  A, A                                          ;; 00:2118 $af
.jr_00_2119:
    call call_00_21a0                                  ;; 00:2119 $cd $a0 $21
    add  A, A                                          ;; 00:211c $87
    add  A, A                                          ;; 00:211d $87
    ld   [HL+], A                                      ;; 00:211e $22
    inc  A                                             ;; 00:211f $3c
    ld   [HL+], A                                      ;; 00:2120 $22
    inc  A                                             ;; 00:2121 $3c
    ld   [HL+], A                                      ;; 00:2122 $22
    inc  A                                             ;; 00:2123 $3c
    ld   [HL+], A                                      ;; 00:2124 $22
    pop  AF                                            ;; 00:2125 $f1
    inc  C                                             ;; 00:2126 $0c
    dec  A                                             ;; 00:2127 $3d
    jr   NZ, .jr_00_210a                               ;; 00:2128 $20 $e0
    pop  HL                                            ;; 00:212a $e1
    ret                                                ;; 00:212b $c9

call_00_212c:
    push HL                                            ;; 00:212c $e5
    ld   HL, wC400                                     ;; 00:212d $21 $00 $c4
    ld   A, $09                                        ;; 00:2130 $3e $09
.jr_00_2132:
    push AF                                            ;; 00:2132 $f5
    ld   A, C                                          ;; 00:2133 $79
    or   A, B                                          ;; 00:2134 $b0
    and  A, $c0                                        ;; 00:2135 $e6 $c0
    jr   NZ, .jr_00_2140                               ;; 00:2137 $20 $07
    push BC                                            ;; 00:2139 $c5
    call call_00_2636                                  ;; 00:213a $cd $36 $26
    pop  BC                                            ;; 00:213d $c1
    jr   .jr_00_2141                                   ;; 00:213e $18 $01
.jr_00_2140:
    xor  A, A                                          ;; 00:2140 $af
.jr_00_2141:
    call call_00_21a0                                  ;; 00:2141 $cd $a0 $21
    add  A, A                                          ;; 00:2144 $87
    add  A, A                                          ;; 00:2145 $87
    ld   [HL+], A                                      ;; 00:2146 $22
    inc  A                                             ;; 00:2147 $3c
    ld   [HL+], A                                      ;; 00:2148 $22
    inc  A                                             ;; 00:2149 $3c
    ld   [HL+], A                                      ;; 00:214a $22
    inc  A                                             ;; 00:214b $3c
    ld   [HL+], A                                      ;; 00:214c $22
    inc  A                                             ;; 00:214d $3c
    pop  AF                                            ;; 00:214e $f1
    inc  B                                             ;; 00:214f $04
    dec  A                                             ;; 00:2150 $3d
    jr   NZ, .jr_00_2132                               ;; 00:2151 $20 $df
    pop  HL                                            ;; 00:2153 $e1
    ret                                                ;; 00:2154 $c9

call_00_2155:
    call call_00_2f7f                                  ;; 00:2155 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:2158 $d7
    call call_00_1a97                                  ;; 00:2159 $cd $97 $1a
    ld   DE, wC400                                     ;; 00:215c $11 $00 $c4
.jr_00_215f:
    ld   A, [DE]                                       ;; 00:215f $1a
    ld   [HL+], A                                      ;; 00:2160 $22
    inc  E                                             ;; 00:2161 $1c
    ld   A, [DE]                                       ;; 00:2162 $1a
    ld   [HL-], A                                      ;; 00:2163 $32
    inc  E                                             ;; 00:2164 $1c
    set  5, L                                          ;; 00:2165 $cb $ed
    ld   A, [DE]                                       ;; 00:2167 $1a
    ld   [HL+], A                                      ;; 00:2168 $22
    inc  E                                             ;; 00:2169 $1c
    ld   A, [DE]                                       ;; 00:216a $1a
    ld   [HL], A                                       ;; 00:216b $77
    inc  E                                             ;; 00:216c $1c
    res  5, L                                          ;; 00:216d $cb $ad
    inc  L                                             ;; 00:216f $2c
    res  5, L                                          ;; 00:2170 $cb $ad
    ld   A, E                                          ;; 00:2172 $7b
    cp   A, $2c                                        ;; 00:2173 $fe $2c
    jr   C, .jr_00_215f                                ;; 00:2175 $38 $e8
    ret                                                ;; 00:2177 $c9

call_00_2178:
    push BC                                            ;; 00:2178 $c5
    call call_00_2f7f                                  ;; 00:2179 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:217c $d7
    call call_00_1a97                                  ;; 00:217d $cd $97 $1a
    ld   BC, wC400                                     ;; 00:2180 $01 $00 $c4
.jr_00_2183:
    ld   A, [BC]                                       ;; 00:2183 $0a
    ld   [HL+], A                                      ;; 00:2184 $22
    inc  C                                             ;; 00:2185 $0c
    ld   A, [BC]                                       ;; 00:2186 $0a
    ld   [HL-], A                                      ;; 00:2187 $32
    inc  C                                             ;; 00:2188 $0c
    set  5, L                                          ;; 00:2189 $cb $ed
    ld   A, [BC]                                       ;; 00:218b $0a
    ld   [HL+], A                                      ;; 00:218c $22
    inc  C                                             ;; 00:218d $0c
    ld   A, [BC]                                       ;; 00:218e $0a
    ld   [HL-], A                                      ;; 00:218f $32
    inc  C                                             ;; 00:2190 $0c
    ld   DE, $20                                       ;; 00:2191 $11 $20 $00
    add  HL, DE                                        ;; 00:2194 $19
    ld   A, H                                          ;; 00:2195 $7c
    and  A, $fb                                        ;; 00:2196 $e6 $fb
    ld   H, A                                          ;; 00:2198 $67
    ld   A, C                                          ;; 00:2199 $79
    cp   A, $24                                        ;; 00:219a $fe $24
    jr   C, .jr_00_2183                                ;; 00:219c $38 $e5
    pop  BC                                            ;; 00:219e $c1
    ret                                                ;; 00:219f $c9

call_00_21a0:
    and  A, $7f                                        ;; 00:21a0 $e6 $7f
    cp   A, $40                                        ;; 00:21a2 $fe $40
    jr   NC, .jr_00_21ba                               ;; 00:21a4 $30 $14
    ld   E, A                                          ;; 00:21a6 $5f
    ld   A, [wC43C]                                    ;; 00:21a7 $fa $3c $c4
    xor  A, E                                          ;; 00:21aa $ab
    cp   A, $20                                        ;; 00:21ab $fe $20
    ret  C                                             ;; 00:21ad $d8
    ld   A, [wC43C]                                    ;; 00:21ae $fa $3c $c4
    swap A                                             ;; 00:21b1 $cb $37
    dec  A                                             ;; 00:21b3 $3d
    cp   A, $01                                        ;; 00:21b4 $fe $01
    ret  Z                                             ;; 00:21b6 $c8
    ld   A, $02                                        ;; 00:21b7 $3e $02
    ret                                                ;; 00:21b9 $c9
.jr_00_21ba:
    and  A, $1f                                        ;; 00:21ba $e6 $1f
    ld   E, A                                          ;; 00:21bc $5f
    ld   D, $c5                                        ;; 00:21bd $16 $c5
    ld   A, [DE]                                       ;; 00:21bf $1a
    jr   call_00_21a0                                  ;; 00:21c0 $18 $de

jr_00_21c2:
    ld   A, [wC439]                                    ;; 00:21c2 $fa $39 $c4
    add  A, $80                                        ;; 00:21c5 $c6 $80
    ld   L, A                                          ;; 00:21c7 $6f
    xor  A, $40                                        ;; 00:21c8 $ee $40
    ld   E, A                                          ;; 00:21ca $5f
    ld   H, $97                                        ;; 00:21cb $26 $97
    ld   D, H                                          ;; 00:21cd $54
    ld   A, [DE]                                       ;; 00:21ce $1a
    ld   C, [HL]                                       ;; 00:21cf $4e
    ld   [HL+], A                                      ;; 00:21d0 $22
    ld   A, C                                          ;; 00:21d1 $79
    ld   [DE], A                                       ;; 00:21d2 $12
    inc  E                                             ;; 00:21d3 $1c
    ld   A, [DE]                                       ;; 00:21d4 $1a
    ld   C, [HL]                                       ;; 00:21d5 $4e
    ld   [HL], A                                       ;; 00:21d6 $77
    ld   A, C                                          ;; 00:21d7 $79
    ld   [DE], A                                       ;; 00:21d8 $12
    set  4, L                                          ;; 00:21d9 $cb $e5
    set  4, E                                          ;; 00:21db $cb $e3
    ld   A, [DE]                                       ;; 00:21dd $1a
    ld   C, [HL]                                       ;; 00:21de $4e
    ld   [HL-], A                                      ;; 00:21df $32
    ld   A, C                                          ;; 00:21e0 $79
    ld   [DE], A                                       ;; 00:21e1 $12
    dec  E                                             ;; 00:21e2 $1d
    ld   A, [DE]                                       ;; 00:21e3 $1a
    ld   C, [HL]                                       ;; 00:21e4 $4e
    ld   [HL], A                                       ;; 00:21e5 $77
    ld   A, C                                          ;; 00:21e6 $79
    ld   [DE], A                                       ;; 00:21e7 $12
    jr   jr_00_221d                                    ;; 00:21e8 $18 $33

call_00_21ea:
    ld   A, [wC456]                                    ;; 00:21ea $fa $56 $c4
    or   A, A                                          ;; 00:21ed $b7
    jr   Z, jr_00_21c2                                 ;; 00:21ee $28 $d2
    ld   E, A                                          ;; 00:21f0 $5f
    ld   D, A                                          ;; 00:21f1 $57
    ld   A, [wC439]                                    ;; 00:21f2 $fa $39 $c4
    add  A, $c0                                        ;; 00:21f5 $c6 $c0
    ld   L, A                                          ;; 00:21f7 $6f
    ld   H, $97                                        ;; 00:21f8 $26 $97
    ld   C, [HL]                                       ;; 00:21fa $4e
    set  4, L                                          ;; 00:21fb $cb $e5
    ld   B, [HL]                                       ;; 00:21fd $46
    ld   A, B                                          ;; 00:21fe $78
.jr_00_21ff:
    rra                                                ;; 00:21ff $1f
    rr   C                                             ;; 00:2200 $cb $19
    rr   B                                             ;; 00:2202 $cb $18
    dec  D                                             ;; 00:2204 $15
    jr   NZ, .jr_00_21ff                               ;; 00:2205 $20 $f8
    ld   [HL], B                                       ;; 00:2207 $70
    res  4, L                                          ;; 00:2208 $cb $a5
    ld   [HL], C                                       ;; 00:220a $71
    inc  L                                             ;; 00:220b $2c
    ld   C, [HL]                                       ;; 00:220c $4e
    set  4, L                                          ;; 00:220d $cb $e5
    ld   B, [HL]                                       ;; 00:220f $46
    ld   A, B                                          ;; 00:2210 $78
.jr_00_2211:
    rra                                                ;; 00:2211 $1f
    rr   C                                             ;; 00:2212 $cb $19
    rr   B                                             ;; 00:2214 $cb $18
    dec  E                                             ;; 00:2216 $1d
    jr   NZ, .jr_00_2211                               ;; 00:2217 $20 $f8
    ld   [HL], B                                       ;; 00:2219 $70
    res  4, L                                          ;; 00:221a $cb $a5
    ld   [HL], C                                       ;; 00:221c $71

jr_00_221d:
    ld   A, [wC439]                                    ;; 00:221d $fa $39 $c4
    inc  A                                             ;; 00:2220 $3c
    inc  A                                             ;; 00:2221 $3c
    ld   [wC439], A                                    ;; 00:2222 $ea $39 $c4
    ld   C, A                                          ;; 00:2225 $4f
    and  A, $0f                                        ;; 00:2226 $e6 $0f
    ret  NZ                                            ;; 00:2228 $c0
    ld   A, C                                          ;; 00:2229 $79
    add  A, $10                                        ;; 00:222a $c6 $10
    and  A, $20                                        ;; 00:222c $e6 $20
    ld   [wC439], A                                    ;; 00:222e $ea $39 $c4
    ret                                                ;; 00:2231 $c9

call_00_2232:
    ld   A, [wC44E]                                    ;; 00:2232 $fa $4e $c4
    ld   L, A                                          ;; 00:2235 $6f
    ld   A, [wC44F]                                    ;; 00:2236 $fa $4f $c4
    ld   H, A                                          ;; 00:2239 $67
    call call_00_223e                                  ;; 00:223a $cd $3e $22
    ret                                                ;; 00:223d $c9

call_00_223e:
    ld   A, $09                                        ;; 00:223e $3e $09
    rst  switchBankSafe                                ;; 00:2240 $ef
    bit  6, H                                          ;; 00:2241 $cb $74
    jr   NZ, .jr_00_224c                               ;; 00:2243 $20 $07
    ld   A, $40                                        ;; 00:2245 $3e $40
    add  A, H                                          ;; 00:2247 $84
    ld   H, A                                          ;; 00:2248 $67
    ld   A, $08                                        ;; 00:2249 $3e $08
    rst  switchBankSafe                                ;; 00:224b $ef
.jr_00_224c:
    call call_00_2253                                  ;; 00:224c $cd $53 $22
    call call_00_2647                                  ;; 00:224f $cd $47 $26
    ret                                                ;; 00:2252 $c9

call_00_2253:
    call call_00_2613                                  ;; 00:2253 $cd $13 $26
    push HL                                            ;; 00:2256 $e5
    ld   D, $00                                        ;; 00:2257 $16 $00
    ld   HL, $2263                                     ;; 00:2259 $21 $63 $22
    add  HL, DE                                        ;; 00:225c $19
    ld   E, [HL]                                       ;; 00:225d $5e
    inc  HL                                            ;; 00:225e $23
    ld   D, [HL]                                       ;; 00:225f $56
    pop  HL                                            ;; 00:2260 $e1
    push DE                                            ;; 00:2261 $d5
    ret                                                ;; 00:2262 $c9
    dw   .data_00_2279                                 ;; 00:2263 pP
    dw   data_00_231b                                  ;; 00:2265 pP
    dw   data_00_2328                                  ;; 00:2267 pP
    dw   data_00_2336                                  ;; 00:2269 pP
    dw   data_00_2382                                  ;; 00:226b pP
    dw   data_00_240a                                  ;; 00:226d pP
    dw   data_00_24fc                                  ;; 00:226f pP
    dw   data_00_22ff                                  ;; 00:2271 pP
    dw   .data_00_2293                                 ;; 00:2273 pP
    dw   data_00_24eb                                  ;; 00:2275 pP
    dw   .data_00_227a                                 ;; 00:2277 pP
.data_00_2279:
    ret                                                ;; 00:2279 $c9
.data_00_227a:
    push DE                                            ;; 00:227a $d5
    ld   E, B                                          ;; 00:227b $58
    and  A, $0f                                        ;; 00:227c $e6 $0f
    call call_00_0192                                  ;; 00:227e $cd $92 $01
    pop  DE                                            ;; 00:2281 $d1
    ld   B, A                                          ;; 00:2282 $47
    ld   A, C                                          ;; 00:2283 $79
    and  A, $0f                                        ;; 00:2284 $e6 $0f
    cp   A, B                                          ;; 00:2286 $b8
    ret  C                                             ;; 00:2287 $d8
    ld   A, C                                          ;; 00:2288 $79
    swap A                                             ;; 00:2289 $cb $37
    and  A, $0f                                        ;; 00:228b $e6 $0f
    cp   A, B                                          ;; 00:228d $b8
    jr   Z, call_00_2253                               ;; 00:228e $28 $c3
    ret  NC                                            ;; 00:2290 $d0
    jr   call_00_2253                                  ;; 00:2291 $18 $c0
.data_00_2293:
    call call_00_2625                                  ;; 00:2293 $cd $25 $26
    ld   E, C                                          ;; 00:2296 $59
    ld   A, [wC473]                                    ;; 00:2297 $fa $73 $c4
    ld   C, A                                          ;; 00:229a $4f
    ld   A, [wC474]                                    ;; 00:229b $fa $74 $c4
    ld   B, A                                          ;; 00:229e $47
    push BC                                            ;; 00:229f $c5
    call call_00_2636                                  ;; 00:22a0 $cd $36 $26
    pop  BC                                            ;; 00:22a3 $c1
    ld   D, A                                          ;; 00:22a4 $57
    push BC                                            ;; 00:22a5 $c5
.jr_00_22a6:
    push BC                                            ;; 00:22a6 $c5
    call call_00_2636                                  ;; 00:22a7 $cd $36 $26
    pop  BC                                            ;; 00:22aa $c1
    cp   A, D                                          ;; 00:22ab $ba
    jr   NZ, .jr_00_22b9                               ;; 00:22ac $20 $0b
    call call_00_22d1                                  ;; 00:22ae $cd $d1 $22
    inc  B                                             ;; 00:22b1 $04
    ld   A, B                                          ;; 00:22b2 $78
    cp   A, $40                                        ;; 00:22b3 $fe $40
    jr   NC, .jr_00_22b9                               ;; 00:22b5 $30 $02
    jr   .jr_00_22a6                                   ;; 00:22b7 $18 $ed
.jr_00_22b9:
    pop  BC                                            ;; 00:22b9 $c1
    dec  B                                             ;; 00:22ba $05
.jr_00_22bb:
    push BC                                            ;; 00:22bb $c5
    call call_00_2636                                  ;; 00:22bc $cd $36 $26
    pop  BC                                            ;; 00:22bf $c1
    cp   A, D                                          ;; 00:22c0 $ba
    jr   NZ, .jr_00_22ce                               ;; 00:22c1 $20 $0b
    call call_00_22d1                                  ;; 00:22c3 $cd $d1 $22
    dec  B                                             ;; 00:22c6 $05
    ld   A, B                                          ;; 00:22c7 $78
    cp   A, $40                                        ;; 00:22c8 $fe $40
    jr   NC, .jr_00_22ce                               ;; 00:22ca $30 $02
    jr   .jr_00_22bb                                   ;; 00:22cc $18 $ed
.jr_00_22ce:
    jp   call_00_2253                                  ;; 00:22ce $c3 $53 $22

call_00_22d1:
    push BC                                            ;; 00:22d1 $c5
.jp_00_22d2:
    push BC                                            ;; 00:22d2 $c5
    call call_00_2636                                  ;; 00:22d3 $cd $36 $26
    cp   A, D                                          ;; 00:22d6 $ba
    jr   NZ, .jr_00_22e5                               ;; 00:22d7 $20 $0c
    ld   A, E                                          ;; 00:22d9 $7b
    ld   [BC], A                                       ;; 00:22da $02
    pop  BC                                            ;; 00:22db $c1
    inc  C                                             ;; 00:22dc $0c
    ld   A, C                                          ;; 00:22dd $79
    cp   A, $40                                        ;; 00:22de $fe $40
    jr   NC, .jr_00_22e6                               ;; 00:22e0 $30 $04
    jp   .jp_00_22d2                                   ;; 00:22e2 $c3 $d2 $22
.jr_00_22e5:
    pop  BC                                            ;; 00:22e5 $c1
.jr_00_22e6:
    pop  BC                                            ;; 00:22e6 $c1
    push BC                                            ;; 00:22e7 $c5
    dec  C                                             ;; 00:22e8 $0d
.jp_00_22e9:
    push BC                                            ;; 00:22e9 $c5
    call call_00_2636                                  ;; 00:22ea $cd $36 $26
    cp   A, D                                          ;; 00:22ed $ba
    jr   NZ, .jr_00_22fc                               ;; 00:22ee $20 $0c
    ld   A, E                                          ;; 00:22f0 $7b
    ld   [BC], A                                       ;; 00:22f1 $02
    pop  BC                                            ;; 00:22f2 $c1
    dec  C                                             ;; 00:22f3 $0d
    ld   A, C                                          ;; 00:22f4 $79
    cp   A, $40                                        ;; 00:22f5 $fe $40
    jr   NC, .jr_00_22fd                               ;; 00:22f7 $30 $04
    jp   .jp_00_22e9                                   ;; 00:22f9 $c3 $e9 $22
.jr_00_22fc:
    pop  BC                                            ;; 00:22fc $c1
.jr_00_22fd:
    pop  BC                                            ;; 00:22fd $c1
    ret                                                ;; 00:22fe $c9

data_00_22ff:
    call call_00_2625                                  ;; 00:22ff $cd $25 $26
    push HL                                            ;; 00:2302 $e5
    ld   HL, wD000                                     ;; 00:2303 $21 $00 $d0
    ld   E, $40                                        ;; 00:2306 $1e $40
.jr_00_2308:
    ld   A, $20                                        ;; 00:2308 $3e $20
.jr_00_230a:
    ld   [HL], C                                       ;; 00:230a $71
    inc  HL                                            ;; 00:230b $23
    ld   [HL], B                                       ;; 00:230c $70
    inc  HL                                            ;; 00:230d $23
    dec  A                                             ;; 00:230e $3d
    jr   NZ, .jr_00_230a                               ;; 00:230f $20 $f9
    ld   A, B                                          ;; 00:2311 $78
    ld   B, C                                          ;; 00:2312 $41
    ld   C, A                                          ;; 00:2313 $4f
    dec  E                                             ;; 00:2314 $1d
    jr   NZ, .jr_00_2308                               ;; 00:2315 $20 $f1
    pop  HL                                            ;; 00:2317 $e1
    jp   call_00_2253                                  ;; 00:2318 $c3 $53 $22

data_00_231b:
    ld   A, [HL+]                                      ;; 00:231b $2a
    push HL                                            ;; 00:231c $e5
    and  A, $3f                                        ;; 00:231d $e6 $3f
    ld   HL, wD000                                     ;; 00:231f $21 $00 $d0
    add  HL, BC                                        ;; 00:2322 $09
    ld   [HL], A                                       ;; 00:2323 $77
    pop  HL                                            ;; 00:2324 $e1
    jp   call_00_2253                                  ;; 00:2325 $c3 $53 $22

data_00_2328:
    call call_00_2625                                  ;; 00:2328 $cd $25 $26
    ld   A, C                                          ;; 00:232b $79
    ld   [wC473], A                                    ;; 00:232c $ea $73 $c4
    ld   A, B                                          ;; 00:232f $78
    ld   [wC474], A                                    ;; 00:2330 $ea $74 $c4
    jp   call_00_2253                                  ;; 00:2333 $c3 $53 $22

data_00_2336:
    call call_00_2625                                  ;; 00:2336 $cd $25 $26
    call call_00_2606                                  ;; 00:2339 $cd $06 $26
    push HL                                            ;; 00:233c $e5
    call call_00_25f0                                  ;; 00:233d $cd $f0 $25
    push HL                                            ;; 00:2340 $e5
.jp_00_2341:
    ld   A, E                                          ;; 00:2341 $7b
    call call_00_25da                                  ;; 00:2342 $cd $da $25
    ld   A, L                                          ;; 00:2345 $7d
    cp   A, C                                          ;; 00:2346 $b9
    jr   Z, .jp_00_2350                                ;; 00:2347 $28 $07
    ld   A, E                                          ;; 00:2349 $7b
    ld   E, D                                          ;; 00:234a $5a
    ld   D, A                                          ;; 00:234b $57
    inc  L                                             ;; 00:234c $2c
    jp   .jp_00_2341                                   ;; 00:234d $c3 $41 $23
.jp_00_2350:
    ld   A, E                                          ;; 00:2350 $7b
    call call_00_25da                                  ;; 00:2351 $cd $da $25
    ld   A, H                                          ;; 00:2354 $7c
    cp   A, B                                          ;; 00:2355 $b8
    jr   Z, .jr_00_235f                                ;; 00:2356 $28 $07
    ld   A, E                                          ;; 00:2358 $7b
    ld   E, D                                          ;; 00:2359 $5a
    ld   D, A                                          ;; 00:235a $57
    inc  H                                             ;; 00:235b $24
    jp   .jp_00_2350                                   ;; 00:235c $c3 $50 $23
.jr_00_235f:
    pop  BC                                            ;; 00:235f $c1
.jp_00_2360:
    ld   A, E                                          ;; 00:2360 $7b
    call call_00_25da                                  ;; 00:2361 $cd $da $25
    ld   A, L                                          ;; 00:2364 $7d
    cp   A, C                                          ;; 00:2365 $b9
    jr   Z, .jp_00_236f                                ;; 00:2366 $28 $07
    ld   A, E                                          ;; 00:2368 $7b
    ld   E, D                                          ;; 00:2369 $5a
    ld   D, A                                          ;; 00:236a $57
    dec  L                                             ;; 00:236b $2d
    jp   .jp_00_2360                                   ;; 00:236c $c3 $60 $23
.jp_00_236f:
    ld   A, E                                          ;; 00:236f $7b
    call call_00_25da                                  ;; 00:2370 $cd $da $25
    ld   A, H                                          ;; 00:2373 $7c
    cp   A, B                                          ;; 00:2374 $b8
    jr   Z, .jr_00_237e                                ;; 00:2375 $28 $07
    ld   A, E                                          ;; 00:2377 $7b
    ld   E, D                                          ;; 00:2378 $5a
    ld   D, A                                          ;; 00:2379 $57
    dec  H                                             ;; 00:237a $25
    jp   .jp_00_236f                                   ;; 00:237b $c3 $6f $23
.jr_00_237e:
    pop  HL                                            ;; 00:237e $e1
    jp   call_00_2253                                  ;; 00:237f $c3 $53 $22

data_00_2382:
    call call_00_2625                                  ;; 00:2382 $cd $25 $26
    call call_00_2606                                  ;; 00:2385 $cd $06 $26
    push HL                                            ;; 00:2388 $e5
    call call_00_25f0                                  ;; 00:2389 $cd $f0 $25
.jp_00_238c:
    push DE                                            ;; 00:238c $d5
    push HL                                            ;; 00:238d $e5
.jp_00_238e:
    ld   A, E                                          ;; 00:238e $7b
    call call_00_25da                                  ;; 00:238f $cd $da $25
    ld   A, L                                          ;; 00:2392 $7d
    cp   A, C                                          ;; 00:2393 $b9
    jr   Z, .jr_00_239d                                ;; 00:2394 $28 $07
    ld   A, E                                          ;; 00:2396 $7b
    ld   E, D                                          ;; 00:2397 $5a
    ld   D, A                                          ;; 00:2398 $57
    inc  L                                             ;; 00:2399 $2c
    jp   .jp_00_238e                                   ;; 00:239a $c3 $8e $23
.jr_00_239d:
    pop  HL                                            ;; 00:239d $e1
    pop  DE                                            ;; 00:239e $d1
    ld   A, H                                          ;; 00:239f $7c
    cp   A, B                                          ;; 00:23a0 $b8
    jr   Z, .jr_00_23aa                                ;; 00:23a1 $28 $07
    ld   A, D                                          ;; 00:23a3 $7a
    ld   D, E                                          ;; 00:23a4 $53
    ld   E, A                                          ;; 00:23a5 $5f
    inc  H                                             ;; 00:23a6 $24
    jp   .jp_00_238c                                   ;; 00:23a7 $c3 $8c $23
.jr_00_23aa:
    pop  HL                                            ;; 00:23aa $e1
    jp   call_00_2253                                  ;; 00:23ab $c3 $53 $22

jp_00_23ae:
    dec  A                                             ;; 00:23ae $3d
    add  A, A                                          ;; 00:23af $87
    ld   E, A                                          ;; 00:23b0 $5f
    ld   D, $00                                        ;; 00:23b1 $16 $00
    push HL                                            ;; 00:23b3 $e5
    ld   HL, $2670                                     ;; 00:23b4 $21 $70 $26
    add  HL, DE                                        ;; 00:23b7 $19
    ld   E, [HL]                                       ;; 00:23b8 $5e
    inc  HL                                            ;; 00:23b9 $23
    ld   D, [HL]                                       ;; 00:23ba $56
    pop  HL                                            ;; 00:23bb $e1
.jp_00_23bc:
    ld   A, [DE]                                       ;; 00:23bc $1a
    cp   A, $ff                                        ;; 00:23bd $fe $ff
    jr   Z, .jr_00_23f5                                ;; 00:23bf $28 $34
    inc  DE                                            ;; 00:23c1 $13
    ld   C, A                                          ;; 00:23c2 $4f
    ld   A, [DE]                                       ;; 00:23c3 $1a
    inc  DE                                            ;; 00:23c4 $13
    ld   B, A                                          ;; 00:23c5 $47
    push HL                                            ;; 00:23c6 $e5
    ld   A, L                                          ;; 00:23c7 $7d
    add  A, C                                          ;; 00:23c8 $81
    ld   L, A                                          ;; 00:23c9 $6f
    ld   A, H                                          ;; 00:23ca $7c
    add  A, B                                          ;; 00:23cb $80
    ld   H, A                                          ;; 00:23cc $67
    call call_00_23f9                                  ;; 00:23cd $cd $f9 $23
    pop  HL                                            ;; 00:23d0 $e1
    push HL                                            ;; 00:23d1 $e5
    ld   A, L                                          ;; 00:23d2 $7d
    add  A, B                                          ;; 00:23d3 $80
    ld   L, A                                          ;; 00:23d4 $6f
    ld   A, H                                          ;; 00:23d5 $7c
    sub  A, C                                          ;; 00:23d6 $91
    ld   H, A                                          ;; 00:23d7 $67
    call call_00_23f9                                  ;; 00:23d8 $cd $f9 $23
    pop  HL                                            ;; 00:23db $e1
    push HL                                            ;; 00:23dc $e5
    ld   A, L                                          ;; 00:23dd $7d
    sub  A, C                                          ;; 00:23de $91
    ld   L, A                                          ;; 00:23df $6f
    ld   A, H                                          ;; 00:23e0 $7c
    sub  A, B                                          ;; 00:23e1 $90
    ld   H, A                                          ;; 00:23e2 $67
    call call_00_23f9                                  ;; 00:23e3 $cd $f9 $23
    pop  HL                                            ;; 00:23e6 $e1
    push HL                                            ;; 00:23e7 $e5
    ld   A, L                                          ;; 00:23e8 $7d
    sub  A, B                                          ;; 00:23e9 $90
    ld   L, A                                          ;; 00:23ea $6f
    ld   A, H                                          ;; 00:23eb $7c
    add  A, C                                          ;; 00:23ec $81
    ld   H, A                                          ;; 00:23ed $67
    call call_00_23f9                                  ;; 00:23ee $cd $f9 $23
    pop  HL                                            ;; 00:23f1 $e1
    jp   .jp_00_23bc                                   ;; 00:23f2 $c3 $bc $23
.jr_00_23f5:
    pop  HL                                            ;; 00:23f5 $e1
    jp   call_00_2253                                  ;; 00:23f6 $c3 $53 $22

call_00_23f9:
    ld   A, L                                          ;; 00:23f9 $7d
    cp   A, $40                                        ;; 00:23fa $fe $40
    jr   NC, .jr_00_2409                               ;; 00:23fc $30 $0b
    ld   A, H                                          ;; 00:23fe $7c
    cp   A, $40                                        ;; 00:23ff $fe $40
    jr   NC, .jr_00_2409                               ;; 00:2401 $30 $06
    ld   A, [wC478]                                    ;; 00:2403 $fa $78 $c4
    call call_00_25da                                  ;; 00:2406 $cd $da $25
.jr_00_2409:
    ret                                                ;; 00:2409 $c9

data_00_240a:
    call call_00_2625                                  ;; 00:240a $cd $25 $26
    call call_00_2606                                  ;; 00:240d $cd $06 $26
    ld   A, E                                          ;; 00:2410 $7b
    ld   [wC478], A                                    ;; 00:2411 $ea $78 $c4
    push HL                                            ;; 00:2414 $e5
    ld   A, [wC473]                                    ;; 00:2415 $fa $73 $c4
    ld   L, A                                          ;; 00:2418 $6f
    ld   A, [wC474]                                    ;; 00:2419 $fa $74 $c4
    ld   H, A                                          ;; 00:241c $67
    ld   A, C                                          ;; 00:241d $79
    sub  A, L                                          ;; 00:241e $95
    ld   C, A                                          ;; 00:241f $4f
    cp   A, $80                                        ;; 00:2420 $fe $80
    jr   C, .jr_00_2427                                ;; 00:2422 $38 $03
    xor  A, $ff                                        ;; 00:2424 $ee $ff
    inc  A                                             ;; 00:2426 $3c
.jr_00_2427:
    ld   E, A                                          ;; 00:2427 $5f
    ld   A, B                                          ;; 00:2428 $78
    sub  A, H                                          ;; 00:2429 $94
    ld   B, A                                          ;; 00:242a $47
    cp   A, $80                                        ;; 00:242b $fe $80
    jr   C, .jr_00_2432                                ;; 00:242d $38 $03
    xor  A, $ff                                        ;; 00:242f $ee $ff
    inc  A                                             ;; 00:2431 $3c
.jr_00_2432:
    ld   D, A                                          ;; 00:2432 $57
    ld   A, E                                          ;; 00:2433 $7b
    add  A, D                                          ;; 00:2434 $82
    jr   Z, .jr_00_243e                                ;; 00:2435 $28 $07
    cp   A, $08                                        ;; 00:2437 $fe $08
    jr   NC, .jr_00_243e                               ;; 00:2439 $30 $03
    jp   jp_00_23ae                                    ;; 00:243b $c3 $ae $23
.jr_00_243e:
    ld   [wC477], A                                    ;; 00:243e $ea $77 $c4
    push HL                                            ;; 00:2441 $e5
    ld   H, $00                                        ;; 00:2442 $26 $00
    ld   L, A                                          ;; 00:2444 $6f
    add  HL, HL                                        ;; 00:2445 $29
    add  HL, HL                                        ;; 00:2446 $29
    add  HL, HL                                        ;; 00:2447 $29
    inc  HL                                            ;; 00:2448 $23
    ld   A, L                                          ;; 00:2449 $7d
    ld   [wC47A], A                                    ;; 00:244a $ea $7a $c4
    ld   A, H                                          ;; 00:244d $7c
    ld   [wC47B], A                                    ;; 00:244e $ea $7b $c4
    pop  HL                                            ;; 00:2451 $e1
    ld   D, B                                          ;; 00:2452 $50
    ld   B, C                                          ;; 00:2453 $41
    ld   C, $00                                        ;; 00:2454 $0e $00
    ld   E, C                                          ;; 00:2456 $59
.jr_00_2457:
    push HL                                            ;; 00:2457 $e5
    ld   H, D                                          ;; 00:2458 $62
    ld   L, E                                          ;; 00:2459 $6b
    call call_00_24a4                                  ;; 00:245a $cd $a4 $24
    add  HL, BC                                        ;; 00:245d $09
    ld   C, L                                          ;; 00:245e $4d
    ld   B, H                                          ;; 00:245f $44
    call call_00_24a4                                  ;; 00:2460 $cd $a4 $24
    ld   A, L                                          ;; 00:2463 $7d
    ld   L, E                                          ;; 00:2464 $6b
    ld   E, A                                          ;; 00:2465 $5f
    ld   A, H                                          ;; 00:2466 $7c
    ld   H, D                                          ;; 00:2467 $62
    ld   D, A                                          ;; 00:2468 $57
    ld   A, E                                          ;; 00:2469 $7b
    xor  A, $ff                                        ;; 00:246a $ee $ff
    ld   E, A                                          ;; 00:246c $5f
    ld   A, D                                          ;; 00:246d $7a
    xor  A, $ff                                        ;; 00:246e $ee $ff
    ld   D, A                                          ;; 00:2470 $57
    inc  DE                                            ;; 00:2471 $13
    add  HL, DE                                        ;; 00:2472 $19
    ld   E, L                                          ;; 00:2473 $5d
    ld   D, H                                          ;; 00:2474 $54
    pop  HL                                            ;; 00:2475 $e1
    push HL                                            ;; 00:2476 $e5
    ld   A, L                                          ;; 00:2477 $7d
    add  A, B                                          ;; 00:2478 $80
    cp   A, $40                                        ;; 00:2479 $fe $40
    jr   NC, .jr_00_248b                               ;; 00:247b $30 $0e
    ld   L, A                                          ;; 00:247d $6f
    ld   A, H                                          ;; 00:247e $7c
    add  A, D                                          ;; 00:247f $82
    cp   A, $40                                        ;; 00:2480 $fe $40
    jr   NC, .jr_00_248b                               ;; 00:2482 $30 $07
    ld   H, A                                          ;; 00:2484 $67
    ld   A, [wC478]                                    ;; 00:2485 $fa $78 $c4
    call call_00_25da                                  ;; 00:2488 $cd $da $25
.jr_00_248b:
    ld   A, [wC47A]                                    ;; 00:248b $fa $7a $c4
    ld   L, A                                          ;; 00:248e $6f
    ld   A, [wC47B]                                    ;; 00:248f $fa $7b $c4
    ld   H, A                                          ;; 00:2492 $67
    dec  HL                                            ;; 00:2493 $2b
    ld   A, L                                          ;; 00:2494 $7d
    ld   [wC47A], A                                    ;; 00:2495 $ea $7a $c4
    ld   A, H                                          ;; 00:2498 $7c
    ld   [wC47B], A                                    ;; 00:2499 $ea $7b $c4
    or   A, L                                          ;; 00:249c $b5
    pop  HL                                            ;; 00:249d $e1
    jr   NZ, .jr_00_2457                               ;; 00:249e $20 $b7
    pop  HL                                            ;; 00:24a0 $e1
    jp   call_00_2253                                  ;; 00:24a1 $c3 $53 $22

call_00_24a4:
    push DE                                            ;; 00:24a4 $d5
    push BC                                            ;; 00:24a5 $c5
    push AF                                            ;; 00:24a6 $f5
    ld   A, H                                          ;; 00:24a7 $7c
    cp   A, $80                                        ;; 00:24a8 $fe $80
    jr   C, .jr_00_24c5                                ;; 00:24aa $38 $19
    ld   A, H                                          ;; 00:24ac $7c
    xor  A, $ff                                        ;; 00:24ad $ee $ff
    ld   H, A                                          ;; 00:24af $67
    ld   A, L                                          ;; 00:24b0 $7d
    xor  A, $ff                                        ;; 00:24b1 $ee $ff
    ld   L, A                                          ;; 00:24b3 $6f
    inc  HL                                            ;; 00:24b4 $23
    call call_00_24cc                                  ;; 00:24b5 $cd $cc $24
    ld   A, H                                          ;; 00:24b8 $7c
    xor  A, $ff                                        ;; 00:24b9 $ee $ff
    ld   H, A                                          ;; 00:24bb $67
    ld   A, L                                          ;; 00:24bc $7d
    xor  A, $ff                                        ;; 00:24bd $ee $ff
    ld   L, A                                          ;; 00:24bf $6f
    inc  HL                                            ;; 00:24c0 $23
    pop  AF                                            ;; 00:24c1 $f1
    pop  BC                                            ;; 00:24c2 $c1
    pop  DE                                            ;; 00:24c3 $d1
    ret                                                ;; 00:24c4 $c9
.jr_00_24c5:
    call call_00_24cc                                  ;; 00:24c5 $cd $cc $24
    pop  AF                                            ;; 00:24c8 $f1
    pop  BC                                            ;; 00:24c9 $c1
    pop  DE                                            ;; 00:24ca $d1
    ret                                                ;; 00:24cb $c9

call_00_24cc:
    ld   DE, $00                                       ;; 00:24cc $11 $00 $00
    ld   A, [wC477]                                    ;; 00:24cf $fa $77 $c4
    ld   C, A                                          ;; 00:24d2 $4f
    xor  A, A                                          ;; 00:24d3 $af
    ld   B, $10                                        ;; 00:24d4 $06 $10
.jr_00_24d6:
    sla  L                                             ;; 00:24d6 $cb $25
    rl   H                                             ;; 00:24d8 $cb $14
    rla                                                ;; 00:24da $17
    cp   A, C                                          ;; 00:24db $b9
    ccf                                                ;; 00:24dc $3f
    rl   E                                             ;; 00:24dd $cb $13
    rl   D                                             ;; 00:24df $cb $12
    cp   A, C                                          ;; 00:24e1 $b9
    jr   C, .jr_00_24e5                                ;; 00:24e2 $38 $01
    sub  A, C                                          ;; 00:24e4 $91
.jr_00_24e5:
    dec  B                                             ;; 00:24e5 $05
    jr   NZ, .jr_00_24d6                               ;; 00:24e6 $20 $ee
    ld   L, E                                          ;; 00:24e8 $6b
    ld   H, D                                          ;; 00:24e9 $62
    ret                                                ;; 00:24ea $c9

data_00_24eb:
    call call_00_2625                                  ;; 00:24eb $cd $25 $26
    call call_00_2606                                  ;; 00:24ee $cd $06 $26
    push HL                                            ;; 00:24f1 $e5
    ld   A, [wC475]                                    ;; 00:24f2 $fa $75 $c4
    ld   L, A                                          ;; 00:24f5 $6f
    ld   A, [wC476]                                    ;; 00:24f6 $fa $76 $c4
    ld   H, A                                          ;; 00:24f9 $67
    jr   jr_00_250b                                    ;; 00:24fa $18 $0f

data_00_24fc:
    call call_00_2625                                  ;; 00:24fc $cd $25 $26
    call call_00_2606                                  ;; 00:24ff $cd $06 $26
    push HL                                            ;; 00:2502 $e5
    ld   A, [wC473]                                    ;; 00:2503 $fa $73 $c4
    ld   L, A                                          ;; 00:2506 $6f
    ld   A, [wC474]                                    ;; 00:2507 $fa $74 $c4
    ld   H, A                                          ;; 00:250a $67

jr_00_250b:
    ld   A, C                                          ;; 00:250b $79
    ld   [wC475], A                                    ;; 00:250c $ea $75 $c4
    ld   A, B                                          ;; 00:250f $78
    ld   [wC476], A                                    ;; 00:2510 $ea $76 $c4
    ld   A, C                                          ;; 00:2513 $79
    sub  A, L                                          ;; 00:2514 $95
    ld   [wC477], A                                    ;; 00:2515 $ea $77 $c4
    ld   A, B                                          ;; 00:2518 $78
    sub  A, H                                          ;; 00:2519 $94
    ld   [wC478], A                                    ;; 00:251a $ea $78 $c4
    ld   A, $01                                        ;; 00:251d $3e $01
    ld   [wC47A], A                                    ;; 00:251f $ea $7a $c4
    ld   [wC47B], A                                    ;; 00:2522 $ea $7b $c4
    ld   [wC47C], A                                    ;; 00:2525 $ea $7c $c4
    ld   [wC47D], A                                    ;; 00:2528 $ea $7d $c4
    ld   A, [wC477]                                    ;; 00:252b $fa $77 $c4
    cp   A, $80                                        ;; 00:252e $fe $80
    jr   C, .jr_00_2540                                ;; 00:2530 $38 $0e
    xor  A, $ff                                        ;; 00:2532 $ee $ff
    inc  A                                             ;; 00:2534 $3c
    ld   [wC477], A                                    ;; 00:2535 $ea $77 $c4
    ld   A, $ff                                        ;; 00:2538 $3e $ff
    ld   [wC47A], A                                    ;; 00:253a $ea $7a $c4
    ld   [wC47C], A                                    ;; 00:253d $ea $7c $c4
.jr_00_2540:
    ld   A, [wC478]                                    ;; 00:2540 $fa $78 $c4
    cp   A, $80                                        ;; 00:2543 $fe $80
    jr   C, .jr_00_2555                                ;; 00:2545 $38 $0e
    xor  A, $ff                                        ;; 00:2547 $ee $ff
    inc  A                                             ;; 00:2549 $3c
    ld   [wC478], A                                    ;; 00:254a $ea $78 $c4
    ld   A, $ff                                        ;; 00:254d $3e $ff
    ld   [wC47B], A                                    ;; 00:254f $ea $7b $c4
    ld   [wC47D], A                                    ;; 00:2552 $ea $7d $c4
.jr_00_2555:
    push HL                                            ;; 00:2555 $e5
    ld   A, [wC478]                                    ;; 00:2556 $fa $78 $c4
    ld   L, A                                          ;; 00:2559 $6f
    ld   A, [wC477]                                    ;; 00:255a $fa $77 $c4
    cp   A, L                                          ;; 00:255d $bd
    jr   NC, .jr_00_2575                               ;; 00:255e $30 $15
    ld   A, [wC477]                                    ;; 00:2560 $fa $77 $c4
    ld   L, A                                          ;; 00:2563 $6f
    ld   A, [wC478]                                    ;; 00:2564 $fa $78 $c4
    ld   [wC477], A                                    ;; 00:2567 $ea $77 $c4
    ld   A, L                                          ;; 00:256a $7d
    ld   [wC478], A                                    ;; 00:256b $ea $78 $c4
    xor  A, A                                          ;; 00:256e $af
    ld   [wC47C], A                                    ;; 00:256f $ea $7c $c4
    jp   .jp_00_2579                                   ;; 00:2572 $c3 $79 $25
.jr_00_2575:
    xor  A, A                                          ;; 00:2575 $af
    ld   [wC47D], A                                    ;; 00:2576 $ea $7d $c4
.jp_00_2579:
    pop  HL                                            ;; 00:2579 $e1
    ld   A, [wC478]                                    ;; 00:257a $fa $78 $c4
    ld   [wC479], A                                    ;; 00:257d $ea $79 $c4
    ld   A, [wC477]                                    ;; 00:2580 $fa $77 $c4
    srl  A                                             ;; 00:2583 $cb $3f
    or   A, A                                          ;; 00:2585 $b7
    jr   NZ, .jr_00_2589                               ;; 00:2586 $20 $01
    inc  A                                             ;; 00:2588 $3c
.jr_00_2589:
    ld   [wC478], A                                    ;; 00:2589 $ea $78 $c4
.jp_00_258c:
    ld   A, E                                          ;; 00:258c $7b
    call call_00_25da                                  ;; 00:258d $cd $da $25
    ld   A, E                                          ;; 00:2590 $7b
    ld   E, D                                          ;; 00:2591 $5a
    ld   D, A                                          ;; 00:2592 $57
    ld   A, C                                          ;; 00:2593 $79
    cp   A, L                                          ;; 00:2594 $bd
    jr   NZ, .jr_00_259b                               ;; 00:2595 $20 $04
    ld   A, B                                          ;; 00:2597 $78
    cp   A, H                                          ;; 00:2598 $bc
    jr   Z, .jr_00_25d6                                ;; 00:2599 $28 $3b
.jr_00_259b:
    push HL                                            ;; 00:259b $e5
    ld   A, [wC479]                                    ;; 00:259c $fa $79 $c4
    ld   L, A                                          ;; 00:259f $6f
    ld   A, [wC478]                                    ;; 00:25a0 $fa $78 $c4
    add  A, L                                          ;; 00:25a3 $85
    ld   [wC478], A                                    ;; 00:25a4 $ea $78 $c4
    ld   L, A                                          ;; 00:25a7 $6f
    ld   A, [wC477]                                    ;; 00:25a8 $fa $77 $c4
    cp   A, L                                          ;; 00:25ab $bd
    pop  HL                                            ;; 00:25ac $e1
    jr   NC, .jr_00_25c9                               ;; 00:25ad $30 $1a
    ld   A, [wC47A]                                    ;; 00:25af $fa $7a $c4
    add  A, L                                          ;; 00:25b2 $85
    ld   L, A                                          ;; 00:25b3 $6f
    ld   A, [wC47B]                                    ;; 00:25b4 $fa $7b $c4
    add  A, H                                          ;; 00:25b7 $84
    ld   H, A                                          ;; 00:25b8 $67
    push HL                                            ;; 00:25b9 $e5
    ld   A, [wC477]                                    ;; 00:25ba $fa $77 $c4
    ld   L, A                                          ;; 00:25bd $6f
    ld   A, [wC478]                                    ;; 00:25be $fa $78 $c4
    sub  A, L                                          ;; 00:25c1 $95
    ld   [wC478], A                                    ;; 00:25c2 $ea $78 $c4
    pop  HL                                            ;; 00:25c5 $e1
    jp   .jp_00_258c                                   ;; 00:25c6 $c3 $8c $25
.jr_00_25c9:
    ld   A, [wC47C]                                    ;; 00:25c9 $fa $7c $c4
    add  A, L                                          ;; 00:25cc $85
    ld   L, A                                          ;; 00:25cd $6f
    ld   A, [wC47D]                                    ;; 00:25ce $fa $7d $c4
    add  A, H                                          ;; 00:25d1 $84
    ld   H, A                                          ;; 00:25d2 $67
    jp   .jp_00_258c                                   ;; 00:25d3 $c3 $8c $25
.jr_00_25d6:
    pop  HL                                            ;; 00:25d6 $e1
    jp   call_00_2253                                  ;; 00:25d7 $c3 $53 $22

call_00_25da:
    push HL                                            ;; 00:25da $e5
    push AF                                            ;; 00:25db $f5
    xor  A, A                                          ;; 00:25dc $af
    srl  H                                             ;; 00:25dd $cb $3c
    rr   A                                             ;; 00:25df $cb $1f
    and  A, A                                          ;; 00:25e1 $a7
    srl  H                                             ;; 00:25e2 $cb $3c
    rr   A                                             ;; 00:25e4 $cb $1f
    or   A, L                                          ;; 00:25e6 $b5
    ld   L, A                                          ;; 00:25e7 $6f
    ld   A, $d0                                        ;; 00:25e8 $3e $d0
    or   A, H                                          ;; 00:25ea $b4
    ld   H, A                                          ;; 00:25eb $67
    pop  AF                                            ;; 00:25ec $f1
    ld   [HL], A                                       ;; 00:25ed $77
    pop  HL                                            ;; 00:25ee $e1
    ret                                                ;; 00:25ef $c9

call_00_25f0:
    ld   A, [wC473]                                    ;; 00:25f0 $fa $73 $c4
    ld   L, A                                          ;; 00:25f3 $6f
    ld   A, [wC474]                                    ;; 00:25f4 $fa $74 $c4
    ld   H, A                                          ;; 00:25f7 $67
    ld   A, L                                          ;; 00:25f8 $7d
    cp   A, C                                          ;; 00:25f9 $b9
    jr   C, .jr_00_25ff                                ;; 00:25fa $38 $03
    ld   A, L                                          ;; 00:25fc $7d
    ld   L, C                                          ;; 00:25fd $69
    ld   C, A                                          ;; 00:25fe $4f
.jr_00_25ff:
    ld   A, H                                          ;; 00:25ff $7c
    cp   A, B                                          ;; 00:2600 $b8
    ret  C                                             ;; 00:2601 $d8
    ld   A, H                                          ;; 00:2602 $7c
    ld   H, B                                          ;; 00:2603 $60
    ld   B, A                                          ;; 00:2604 $47
    ret                                                ;; 00:2605 $c9

call_00_2606:
    ld   A, [HL+]                                      ;; 00:2606 $2a
    ld   D, A                                          ;; 00:2607 $57
    ld   E, A                                          ;; 00:2608 $5f
    and  A, $c0                                        ;; 00:2609 $e6 $c0
    ret  Z                                             ;; 00:260b $c8
    ld   A, E                                          ;; 00:260c $7b
    and  A, $3f                                        ;; 00:260d $e6 $3f
    ld   E, A                                          ;; 00:260f $5f
    ld   D, [HL]                                       ;; 00:2610 $56
    inc  HL                                            ;; 00:2611 $23
    ret                                                ;; 00:2612 $c9

call_00_2613:
    ld   A, [HL+]                                      ;; 00:2613 $2a
    ld   C, [HL]                                       ;; 00:2614 $4e
    inc  HL                                            ;; 00:2615 $23
    ld   B, A                                          ;; 00:2616 $47
    and  A, $f0                                        ;; 00:2617 $e6 $f0
    srl  A                                             ;; 00:2619 $cb $3f
    srl  A                                             ;; 00:261b $cb $3f
    srl  A                                             ;; 00:261d $cb $3f
    ld   E, A                                          ;; 00:261f $5f
    ld   A, B                                          ;; 00:2620 $78
    and  A, $0f                                        ;; 00:2621 $e6 $0f
    ld   B, A                                          ;; 00:2623 $47
    ret                                                ;; 00:2624 $c9

call_00_2625:
    ld   A, C                                          ;; 00:2625 $79
    rl   C                                             ;; 00:2626 $cb $11
    rl   B                                             ;; 00:2628 $cb $10
    rl   C                                             ;; 00:262a $cb $11
    rl   B                                             ;; 00:262c $cb $10
    and  A, $3f                                        ;; 00:262e $e6 $3f
    ld   C, A                                          ;; 00:2630 $4f
    ld   A, B                                          ;; 00:2631 $78
    and  A, $3f                                        ;; 00:2632 $e6 $3f
    ld   B, A                                          ;; 00:2634 $47
    ret                                                ;; 00:2635 $c9

call_00_2636:
    xor  A, A                                          ;; 00:2636 $af
    srl  B                                             ;; 00:2637 $cb $38
    rr   A                                             ;; 00:2639 $cb $1f
    srl  B                                             ;; 00:263b $cb $38
    rr   A                                             ;; 00:263d $cb $1f
    or   A, C                                          ;; 00:263f $b1
    ld   C, A                                          ;; 00:2640 $4f
    ld   A, B                                          ;; 00:2641 $78
    add  A, $d0                                        ;; 00:2642 $c6 $d0
    ld   B, A                                          ;; 00:2644 $47
    ld   A, [BC]                                       ;; 00:2645 $0a
    ret                                                ;; 00:2646 $c9

call_00_2647:
    ld   A, [wC451]                                    ;; 00:2647 $fa $51 $c4
    or   A, A                                          ;; 00:264a $b7
    ret  Z                                             ;; 00:264b $c8
    add  A, $03                                        ;; 00:264c $c6 $03
    ld   B, A                                          ;; 00:264e $47
    ld   HL, wD000                                     ;; 00:264f $21 $00 $d0
    ld   DE, wC500                                     ;; 00:2652 $11 $00 $c5
.jr_00_2655:
    ld   A, [HL]                                       ;; 00:2655 $7e
    ld   C, A                                          ;; 00:2656 $4f
    and  A, $1f                                        ;; 00:2657 $e6 $1f
    cp   A, $03                                        ;; 00:2659 $fe $03
    jr   C, .jr_00_2669                                ;; 00:265b $38 $0c
    cp   A, B                                          ;; 00:265d $b8
    jr   NC, .jr_00_2669                               ;; 00:265e $30 $09
    ld   A, C                                          ;; 00:2660 $79
    ld   [DE], A                                       ;; 00:2661 $12
    and  A, $20                                        ;; 00:2662 $e6 $20
    or   A, $40                                        ;; 00:2664 $f6 $40
    or   A, E                                          ;; 00:2666 $b3
    ld   [HL], A                                       ;; 00:2667 $77
    inc  E                                             ;; 00:2668 $1c
.jr_00_2669:
    inc  HL                                            ;; 00:2669 $23
    ld   A, H                                          ;; 00:266a $7c
    cp   A, $e0                                        ;; 00:266b $fe $e0
    jr   NZ, .jr_00_2655                               ;; 00:266d $20 $e6
    ret                                                ;; 00:266f $c9
    dw   .data_00_267e                                 ;; 00:2670 pP
    db   $81, $26                                      ;; 00:2672 ??
    dw   .data_00_2688                                 ;; 00:2674 pP
    db   $91, $26                                      ;; 00:2676 ??
    dw   .data_00_269e                                 ;; 00:2678 pP
    db   $ad, $26                                      ;; 00:267a ??
    dw   .data_00_26c0                                 ;; 00:267c pP
.data_00_267e:
    db   $01, $00, $ff, $02, $00, $02, $01, $01        ;; 00:267e ...?????
    db   $02, $ff                                      ;; 00:2686 ??
.data_00_2688:
    db   $03, $00, $03, $01, $02, $02, $01, $03        ;; 00:2688 ........
    db   $ff, $04, $00, $04, $01, $04, $02, $03        ;; 00:2690 .???????
    db   $03, $02, $04, $01, $04, $ff                  ;; 00:2698 ??????
.data_00_269e:
    db   $05, $00, $05, $01, $05, $02, $04, $03        ;; 00:269e ........
    db   $03, $04, $02, $05, $01, $05, $ff, $06        ;; 00:26a6 .......?
    db   $00, $06, $01, $06, $02, $05, $03, $05        ;; 00:26ae ????????
    db   $04, $04, $05, $03, $05, $02, $06, $01        ;; 00:26b6 ????????
    db   $06, $ff                                      ;; 00:26be ??
.data_00_26c0:
    db   $07, $00, $07, $01, $07, $02, $06, $03        ;; 00:26c0 ........
    db   $06, $04, $05, $05, $04, $06, $03, $06        ;; 00:26c8 ........
    db   $02, $07, $01, $07, $ff                       ;; 00:26d0 .....

call_00_26d5:
    ld   A, [wC435]                                    ;; 00:26d5 $fa $35 $c4
    or   A, A                                          ;; 00:26d8 $b7
    jr   Z, .jr_00_26e1                                ;; 00:26d9 $28 $06
    ld   A, [wC436]                                    ;; 00:26db $fa $36 $c4
    jp   call_00_29e2                                  ;; 00:26de $c3 $e2 $29
.jr_00_26e1:
    call call_00_29a3                                  ;; 00:26e1 $cd $a3 $29
    or   A, A                                          ;; 00:26e4 $b7
    jr   NZ, .jr_00_26ed                               ;; 00:26e5 $20 $06
    ld   A, [wC436]                                    ;; 00:26e7 $fa $36 $c4
    jp   call_00_29e2                                  ;; 00:26ea $c3 $e2 $29
.jr_00_26ed:
    dec  A                                             ;; 00:26ed $3d
    push AF                                            ;; 00:26ee $f5
    ld   C, A                                          ;; 00:26ef $4f
    ld   A, [wC436]                                    ;; 00:26f0 $fa $36 $c4
    cp   A, C                                          ;; 00:26f3 $b9
    jr   Z, .jr_00_26fa                                ;; 00:26f4 $28 $04
    ld   A, C                                          ;; 00:26f6 $79
    ld   [wC436], A                                    ;; 00:26f7 $ea $36 $c4
.jr_00_26fa:
    xor  A, A                                          ;; 00:26fa $af
    ld   [wC437], A                                    ;; 00:26fb $ea $37 $c4
    ld   A, C                                          ;; 00:26fe $79
    call call_00_29e2                                  ;; 00:26ff $cd $e2 $29
    pop  AF                                            ;; 00:2702 $f1
    push AF                                            ;; 00:2703 $f5
    add  A, A                                          ;; 00:2704 $87
    ld   E, A                                          ;; 00:2705 $5f
    ld   D, $00                                        ;; 00:2706 $16 $00
    ld   HL, $1a73                                     ;; 00:2708 $21 $73 $1a
    add  HL, DE                                        ;; 00:270b $19
    call call_00_29b3                                  ;; 00:270c $cd $b3 $29
    ld   A, C                                          ;; 00:270f $79
    or   A, B                                          ;; 00:2710 $b0
    and  A, $c0                                        ;; 00:2711 $e6 $c0
    jr   Z, .jr_00_2717                                ;; 00:2713 $28 $02
    pop  AF                                            ;; 00:2715 $f1
    ret                                                ;; 00:2716 $c9
.jr_00_2717:
    push BC                                            ;; 00:2717 $c5
    call call_00_2636                                  ;; 00:2718 $cd $36 $26
    pop  DE                                            ;; 00:271b $d1
    bit  7, A                                          ;; 00:271c $cb $7f
    jr   Z, .jr_00_2739                                ;; 00:271e $28 $19
    pop  AF                                            ;; 00:2720 $f1
    call call_00_3183                                  ;; 00:2721 $cd $83 $31
    ret  C                                             ;; 00:2724 $d8
    ld   A, L                                          ;; 00:2725 $7d
    and  A, $f0                                        ;; 00:2726 $e6 $f0
    or   A, $0d                                        ;; 00:2728 $f6 $0d
    ld   L, A                                          ;; 00:272a $6f
    ld   A, [HL]                                       ;; 00:272b $7e
    or   A, A                                          ;; 00:272c $b7
    ret  Z                                             ;; 00:272d $c8
    ld   A, L                                          ;; 00:272e $7d
    sub  A, $04                                        ;; 00:272f $d6 $04
    ld   L, A                                          ;; 00:2731 $6f
    ld   A, [HL+]                                      ;; 00:2732 $2a
    ld   H, [HL]                                       ;; 00:2733 $66
    ld   L, A                                          ;; 00:2734 $6f
    call call_00_29cf                                  ;; 00:2735 $cd $cf $29
    ret                                                ;; 00:2738 $c9
.jr_00_2739:
    call call_00_2946                                  ;; 00:2739 $cd $46 $29
    and  A, $1f                                        ;; 00:273c $e6 $1f
    add  A, $20                                        ;; 00:273e $c6 $20
    ld   C, A                                          ;; 00:2740 $4f
    ld   B, $c5                                        ;; 00:2741 $06 $c5
    ld   A, [BC]                                       ;; 00:2743 $0a
    pop  DE                                            ;; 00:2744 $d1
    bit  7, A                                          ;; 00:2745 $cb $7f
    jr   Z, .jr_00_274b                                ;; 00:2747 $28 $02
    jr   .jr_00_2763                                   ;; 00:2749 $18 $18
.jr_00_274b:
    ld   C, A                                          ;; 00:274b $4f
    ld   A, [wC305]                                    ;; 00:274c $fa $05 $c3
    and  A, $0f                                        ;; 00:274f $e6 $0f
    jr   NZ, .jr_00_2760                               ;; 00:2751 $20 $0d
    ld   A, C                                          ;; 00:2753 $79
    and  A, $03                                        ;; 00:2754 $e6 $03
    cp   A, $03                                        ;; 00:2756 $fe $03
    ret  Z                                             ;; 00:2758 $c8
    ld   A, [wC434]                                    ;; 00:2759 $fa $34 $c4
    and  A, C                                          ;; 00:275c $a1
    jr   Z, .jr_00_2763                                ;; 00:275d $28 $04
    ret                                                ;; 00:275f $c9
.jr_00_2760:
    bit  3, C                                          ;; 00:2760 $cb $59
    ret  NZ                                            ;; 00:2762 $c0
.jr_00_2763:
    ld   A, [wC442]                                    ;; 00:2763 $fa $42 $c4
    inc  A                                             ;; 00:2766 $3c
    ld   C, A                                          ;; 00:2767 $4f
    ld   A, [wC443]                                    ;; 00:2768 $fa $43 $c4
    inc  A                                             ;; 00:276b $3c
    or   A, C                                          ;; 00:276c $b1
    jr   Z, .jr_00_27c1                                ;; 00:276d $28 $52
    ld   A, [wC443]                                    ;; 00:276f $fa $43 $c4
    cp   A, $f0                                        ;; 00:2772 $fe $f0
    ret  NZ                                            ;; 00:2774 $c0
    ld   A, [wC442]                                    ;; 00:2775 $fa $42 $c4
    cp   A, $04                                        ;; 00:2778 $fe $04
    ret  NC                                            ;; 00:277a $d0
    xor  A, D                                          ;; 00:277b $aa
    and  A, $03                                        ;; 00:277c $e6 $03
    jr   NZ, .jr_00_2789                               ;; 00:277e $20 $09
    ld   A, [wC43E]                                    ;; 00:2780 $fa $3e $c4
    sla  A                                             ;; 00:2783 $cb $27
    ld   [wC43E], A                                    ;; 00:2785 $ea $3e $c4
    ret                                                ;; 00:2788 $c9
.jr_00_2789:
    dec  A                                             ;; 00:2789 $3d
    jr   NZ, .jr_00_27c1                               ;; 00:278a $20 $35
    ld   A, [wC43F]                                    ;; 00:278c $fa $3f $c4
    ld   E, A                                          ;; 00:278f $5f
    ld   A, [wC43E]                                    ;; 00:2790 $fa $3e $c4
    sub  A, E                                          ;; 00:2793 $93
    jr   C, .jr_00_27b0                                ;; 00:2794 $38 $1a
    jr   NZ, .jr_00_27a5                               ;; 00:2796 $20 $0d
    ld   HL, rIE                                       ;; 00:2798 $21 $ff $ff
    call call_00_29d9                                  ;; 00:279b $cd $d9 $29
    ld   A, [wC43F]                                    ;; 00:279e $fa $3f $c4
    ld   [wC43E], A                                    ;; 00:27a1 $ea $3e $c4
    ret                                                ;; 00:27a4 $c9
.jr_00_27a5:
    ld   A, [wC43E]                                    ;; 00:27a5 $fa $3e $c4
    srl  A                                             ;; 00:27a8 $cb $3f
    or   A, A                                          ;; 00:27aa $b7
    ret  Z                                             ;; 00:27ab $c8
    ld   [wC43E], A                                    ;; 00:27ac $ea $3e $c4
    ret                                                ;; 00:27af $c9
.jr_00_27b0:
    ld   A, E                                          ;; 00:27b0 $7b
    srl  A                                             ;; 00:27b1 $cb $3f
    or   A, A                                          ;; 00:27b3 $b7
    jr   NZ, .jr_00_27b7                               ;; 00:27b4 $20 $01
    inc  A                                             ;; 00:27b6 $3c
.jr_00_27b7:
    ld   [wC43E], A                                    ;; 00:27b7 $ea $3e $c4
.jr_00_27ba:
    ld   L, D                                          ;; 00:27ba $6a
    ld   H, $f0                                        ;; 00:27bb $26 $f0
    call call_00_29d9                                  ;; 00:27bd $cd $d9 $29
    ret                                                ;; 00:27c0 $c9
.jr_00_27c1:
    ld   A, [wC43F]                                    ;; 00:27c1 $fa $3f $c4
    ld   [wC43E], A                                    ;; 00:27c4 $ea $3e $c4
    jr   .jr_00_27ba                                   ;; 00:27c7 $18 $f1

call_00_27c9:
    ld   A, [wC438]                                    ;; 00:27c9 $fa $38 $c4
    or   A, A                                          ;; 00:27cc $b7
    ret  NZ                                            ;; 00:27cd $c0
    inc  A                                             ;; 00:27ce $3c
    ld   [wC438], A                                    ;; 00:27cf $ea $38 $c4
    ld   HL, $1a71                                     ;; 00:27d2 $21 $71 $1a
    call call_00_29b3                                  ;; 00:27d5 $cd $b3 $29
    call call_00_2636                                  ;; 00:27d8 $cd $36 $26
    bit  6, A                                          ;; 00:27db $cb $77
    jp   NZ, call_00_298a                              ;; 00:27dd $c2 $8a $29
    call call_00_2946                                  ;; 00:27e0 $cd $46 $29
    ld   E, A                                          ;; 00:27e3 $5f
    push DE                                            ;; 00:27e4 $d5
    and  A, $20                                        ;; 00:27e5 $e6 $20
    ld   E, A                                          ;; 00:27e7 $5f
    ld   A, [wC43C]                                    ;; 00:27e8 $fa $3c $c4
    cp   A, E                                          ;; 00:27eb $bb
    jr   Z, .jr_00_283b                                ;; 00:27ec $28 $4d
    ld   A, E                                          ;; 00:27ee $7b
    ld   [wC43C], A                                    ;; 00:27ef $ea $3c $c4
    call call_00_362a                                  ;; 00:27f2 $cd $2a $36
    pop  DE                                            ;; 00:27f5 $d1
    push DE                                            ;; 00:27f6 $d5
    ld   A, E                                          ;; 00:27f7 $7b
    and  A, $1f                                        ;; 00:27f8 $e6 $1f
    add  A, $20                                        ;; 00:27fa $c6 $20
    ld   C, A                                          ;; 00:27fc $4f
    ld   B, $c5                                        ;; 00:27fd $06 $c5
    ld   A, [BC]                                       ;; 00:27ff $0a
    ld   D, A                                          ;; 00:2800 $57
    and  A, $c0                                        ;; 00:2801 $e6 $c0
    cp   A, $c0                                        ;; 00:2803 $fe $c0
    jr   Z, .jr_00_2813                                ;; 00:2805 $28 $0c
    ld   A, D                                          ;; 00:2807 $7a
    and  A, $30                                        ;; 00:2808 $e6 $30
    ld   [wC43B], A                                    ;; 00:280a $ea $3b $c4
    ld   A, [wC436]                                    ;; 00:280d $fa $36 $c4
    call call_00_29e2                                  ;; 00:2810 $cd $e2 $29
.jr_00_2813:
    call call_00_2f7f                                  ;; 00:2813 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:2816 $d7
    call call_00_1a97                                  ;; 00:2817 $cd $97 $1a
    ld   A, [wC305]                                    ;; 00:281a $fa $05 $c3
    ld   [wC462], A                                    ;; 00:281d $ea $62 $c4
    and  A, $0f                                        ;; 00:2820 $e6 $0f
    ld   [wC305], A                                    ;; 00:2822 $ea $05 $c3
    call call_00_2ece                                  ;; 00:2825 $cd $ce $2e
    call call_00_36d6                                  ;; 00:2828 $cd $d6 $36
    call call_00_32d8                                  ;; 00:282b $cd $d8 $32
    ld   A, [wC462]                                    ;; 00:282e $fa $62 $c4
    ld   [wC305], A                                    ;; 00:2831 $ea $05 $c3
    call call_00_2f7f                                  ;; 00:2834 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:2837 $d7
    call call_00_1a97                                  ;; 00:2838 $cd $97 $1a
.jr_00_283b:
    pop  DE                                            ;; 00:283b $d1
    ld   A, E                                          ;; 00:283c $7b
    and  A, $1f                                        ;; 00:283d $e6 $1f
    add  A, $20                                        ;; 00:283f $c6 $20
    ld   C, A                                          ;; 00:2841 $4f
    ld   B, $c5                                        ;; 00:2842 $06 $c5
    ld   A, [BC]                                       ;; 00:2844 $0a
    bit  7, A                                          ;; 00:2845 $cb $7f
    jr   Z, .jr_00_286f                                ;; 00:2847 $28 $26
    bit  6, A                                          ;; 00:2849 $cb $77
    jp   NZ, jp_00_2987                                ;; 00:284b $c2 $87 $29
    ld   E, A                                          ;; 00:284e $5f
    srl  A                                             ;; 00:284f $cb $3f
    srl  A                                             ;; 00:2851 $cb $3f
    and  A, $03                                        ;; 00:2853 $e6 $03
    inc  A                                             ;; 00:2855 $3c
    ld   D, A                                          ;; 00:2856 $57
    ld   A, $80                                        ;; 00:2857 $3e $80
.jr_00_2859:
    rlc  A                                             ;; 00:2859 $cb $07
    dec  D                                             ;; 00:285b $15
    jr   NZ, .jr_00_2859                               ;; 00:285c $20 $fb
    ld   [wC43E], A                                    ;; 00:285e $ea $3e $c4
    ld   [wC437], A                                    ;; 00:2861 $ea $37 $c4
    ld   A, E                                          ;; 00:2864 $7b
    and  A, $03                                        ;; 00:2865 $e6 $03
    ld   L, A                                          ;; 00:2867 $6f
    ld   H, $f0                                        ;; 00:2868 $26 $f0
    call call_00_29cf                                  ;; 00:286a $cd $cf $29
    jr   jp_00_2884                                    ;; 00:286d $18 $15
.jr_00_286f:
    bit  6, A                                          ;; 00:286f $cb $77
    call NZ, call_00_2952                              ;; 00:2871 $c4 $52 $29
    ld   E, A                                          ;; 00:2874 $5f
    bit  2, A                                          ;; 00:2875 $cb $57
    jp   NZ, jp_00_2939                                ;; 00:2877 $c2 $39 $29
    ld   A, E                                          ;; 00:287a $7b
    and  A, $03                                        ;; 00:287b $e6 $03
    jr   Z, .jr_00_2881                                ;; 00:287d $28 $02
    xor  A, $03                                        ;; 00:287f $ee $03
.jr_00_2881:
    ld   [wC434], A                                    ;; 00:2881 $ea $34 $c4

jp_00_2884:
    ld   A, [wC43B]                                    ;; 00:2884 $fa $3b $c4
    ld   D, A                                          ;; 00:2887 $57
    ld   A, E                                          ;; 00:2888 $7b
    and  A, $30                                        ;; 00:2889 $e6 $30
    ld   [wC43B], A                                    ;; 00:288b $ea $3b $c4
    ld   A, [wC453]                                    ;; 00:288e $fa $53 $c4
    or   A, A                                          ;; 00:2891 $b7
    ret  Z                                             ;; 00:2892 $c8
    ld   A, [wC455]                                    ;; 00:2893 $fa $55 $c4
    ld   C, A                                          ;; 00:2896 $4f
    ld   DE, $ff00                                     ;; 00:2897 $11 $00 $ff
    ld   A, $09                                        ;; 00:289a $3e $09
    call call_00_016b                                  ;; 00:289c $cd $6b $01
    cp   A, C                                          ;; 00:289f $b9
    ret  NC                                            ;; 00:28a0 $d0
    ld   DE, $02                                       ;; 00:28a1 $11 $02 $00
    call call_00_1b66                                  ;; 00:28a4 $cd $66 $1b
    ret                                                ;; 00:28a7 $c9

call_00_28a8:
    ld   A, [wC45C]                                    ;; 00:28a8 $fa $5c $c4
    ld   C, A                                          ;; 00:28ab $4f
    ld   A, [wC45D]                                    ;; 00:28ac $fa $5d $c4
    or   A, C                                          ;; 00:28af $b1
    jr   Z, .jr_00_28f4                                ;; 00:28b0 $28 $42
    ld   HL, wC45C                                     ;; 00:28b2 $21 $5c $c4
    call call_00_1c61                                  ;; 00:28b5 $cd $61 $1c
    call call_00_1caf                                  ;; 00:28b8 $cd $af $1c
    xor  A, A                                          ;; 00:28bb $af
    ld   [wC45C], A                                    ;; 00:28bc $ea $5c $c4
    ld   [wC45D], A                                    ;; 00:28bf $ea $5d $c4
    call call_00_1b37                                  ;; 00:28c2 $cd $37 $1b
    ld   A, [wC450]                                    ;; 00:28c5 $fa $50 $c4
    call call_00_1bb9                                  ;; 00:28c8 $cd $b9 $1b
    call call_00_2232                                  ;; 00:28cb $cd $32 $22
    call call_00_1f23                                  ;; 00:28ce $cd $23 $1f
    call call_00_338a                                  ;; 00:28d1 $cd $8a $33
    call call_00_1d5c                                  ;; 00:28d4 $cd $5c $1d
    call call_00_1e21                                  ;; 00:28d7 $cd $21 $1e
    ld   A, [wCFE6]                                    ;; 00:28da $fa $e6 $cf
    ld   [wC434], A                                    ;; 00:28dd $ea $34 $c4
    ld   A, [wCFE7]                                    ;; 00:28e0 $fa $e7 $cf
    ld   [wC43A], A                                    ;; 00:28e3 $ea $3a $c4
    ld   A, [wCFE8]                                    ;; 00:28e6 $fa $e8 $cf
    ld   [wC43B], A                                    ;; 00:28e9 $ea $3b $c4
    call call_00_1ec2                                  ;; 00:28ec $cd $c2 $1e
    call call_00_2fb1                                  ;; 00:28ef $cd $b1 $2f
    jr   .jr_00_28fd                                   ;; 00:28f2 $18 $09
.jr_00_28f4:
    call call_00_1ec2                                  ;; 00:28f4 $cd $c2 $1e
    call call_00_2fb1                                  ;; 00:28f7 $cd $b1 $2f
    call call_00_2232                                  ;; 00:28fa $cd $32 $22
.jr_00_28fd:
    xor  A, A                                          ;; 00:28fd $af
    ldh  [rBGP], A                                     ;; 00:28fe $e0 $47
    ldh  [rOBP0], A                                    ;; 00:2900 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:2902 $e0 $49
    ld   A, [wC450]                                    ;; 00:2904 $fa $50 $c4
    call call_00_1f55                                  ;; 00:2907 $cd $55 $1f
    call call_00_20db                                  ;; 00:290a $cd $db $20
    call call_00_32d8                                  ;; 00:290d $cd $d8 $32
    call call_00_344b                                  ;; 00:2910 $cd $4b $34
    ld   A, [wC436]                                    ;; 00:2913 $fa $36 $c4
    call call_00_29e2                                  ;; 00:2916 $cd $e2 $29
    ld   HL, $1a71                                     ;; 00:2919 $21 $71 $1a
    call call_00_29b3                                  ;; 00:291c $cd $b3 $29
    call call_00_2636                                  ;; 00:291f $cd $36 $26
    ld   A, [BC]                                       ;; 00:2922 $0a
    set  7, A                                          ;; 00:2923 $cb $ff
    ld   [BC], A                                       ;; 00:2925 $02
    ld   A, $03                                        ;; 00:2926 $3e $03
    rst  switchBankSafe                                ;; 00:2928 $ef
    ld   HL, $7f00                                     ;; 00:2929 $21 $00 $7f
    ld   DE, $8700                                     ;; 00:292c $11 $00 $87
    ld   BC, $100                                      ;; 00:292f $01 $00 $01
    call call_00_00ac                                  ;; 00:2932 $cd $ac $00
    call call_00_3ea2                                  ;; 00:2935 $cd $a2 $3e
    ret                                                ;; 00:2938 $c9

jp_00_2939:
    ld   A, [wC434]                                    ;; 00:2939 $fa $34 $c4
    and  A, $01                                        ;; 00:293c $e6 $01
    jp   Z, jp_00_2884                                 ;; 00:293e $ca $84 $28
    ld   E, $30                                        ;; 00:2941 $1e $30
    jp   jp_00_2884                                    ;; 00:2943 $c3 $84 $28

call_00_2946:
    and  A, $7f                                        ;; 00:2946 $e6 $7f
    cp   A, $40                                        ;; 00:2948 $fe $40
    ret  C                                             ;; 00:294a $d8
    and  A, $1f                                        ;; 00:294b $e6 $1f
    ld   C, A                                          ;; 00:294d $4f
    ld   B, $c5                                        ;; 00:294e $06 $c5
    ld   A, [BC]                                       ;; 00:2950 $0a
    ret                                                ;; 00:2951 $c9

call_00_2952:
    push AF                                            ;; 00:2952 $f5
    ld   HL, wC207                                     ;; 00:2953 $21 $07 $c2
    ld   B, $05                                        ;; 00:2956 $06 $05
.jr_00_2958:
    ld   E, [HL]                                       ;; 00:2958 $5e
    inc  L                                             ;; 00:2959 $2c
    ld   D, [HL]                                       ;; 00:295a $56
    dec  DE                                            ;; 00:295b $1b
    ld   A, E                                          ;; 00:295c $7b
    or   A, D                                          ;; 00:295d $b2
    jr   NZ, .jr_00_2963                               ;; 00:295e $20 $03
    ld   DE, $01                                       ;; 00:2960 $11 $01 $00
.jr_00_2963:
    ld   [HL], D                                       ;; 00:2963 $72
    dec  L                                             ;; 00:2964 $2d
    ld   [HL], E                                       ;; 00:2965 $73
    ld   A, L                                          ;; 00:2966 $7d
    add  A, $20                                        ;; 00:2967 $c6 $20
    ld   L, A                                          ;; 00:2969 $6f
    dec  B                                             ;; 00:296a $05
    jr   NZ, .jr_00_2958                               ;; 00:296b $20 $eb
    ld   A, $2d                                        ;; 00:296d $3e $2d
    ldh  [rOBP0], A                                    ;; 00:296f $e0 $48
    ld   A, $36                                        ;; 00:2971 $3e $36
    ldh  [hFFB2], A                                    ;; 00:2973 $e0 $b2
    ld   C, $03                                        ;; 00:2975 $0e $03
.jr_00_2977:
    call call_00_2f7f                                  ;; 00:2977 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:297a $d7
    call call_00_1a97                                  ;; 00:297b $cd $97 $1a
    dec  C                                             ;; 00:297e $0d
    jr   NZ, .jr_00_2977                               ;; 00:297f $20 $f6
    ld   A, $d2                                        ;; 00:2981 $3e $d2
    ldh  [rOBP0], A                                    ;; 00:2983 $e0 $48
    pop  AF                                            ;; 00:2985 $f1
    ret                                                ;; 00:2986 $c9

jp_00_2987:
    bit  5, A                                          ;; 00:2987 $cb $6f
    ret  NZ                                            ;; 00:2989 $c0

call_00_298a:
    and  A, $1f                                        ;; 00:298a $e6 $1f
    add  A, A                                          ;; 00:298c $87
    ld   L, A                                          ;; 00:298d $6f
    ld   H, $00                                        ;; 00:298e $26 $00
    ld   A, $07                                        ;; 00:2990 $3e $07
    rst  switchBankSafe                                ;; 00:2992 $ef
    ld   A, [wC457]                                    ;; 00:2993 $fa $57 $c4
    ld   E, A                                          ;; 00:2996 $5f
    ld   A, [wC458]                                    ;; 00:2997 $fa $58 $c4
    ld   D, A                                          ;; 00:299a $57
    add  HL, DE                                        ;; 00:299b $19
    ld   A, [HL+]                                      ;; 00:299c $2a
    ld   H, [HL]                                       ;; 00:299d $66
    ld   L, A                                          ;; 00:299e $6f
    call call_00_29cf                                  ;; 00:299f $cd $cf $29
    ret                                                ;; 00:29a2 $c9

call_00_29a3:
    ldh  A, [hFF89]                                    ;; 00:29a3 $f0 $89
    ld   B, $04                                        ;; 00:29a5 $06 $04
.jr_00_29a7:
    rlca                                               ;; 00:29a7 $07
    jr   C, .jr_00_29af                                ;; 00:29a8 $38 $05
    dec  B                                             ;; 00:29aa $05
    jr   NZ, .jr_00_29a7                               ;; 00:29ab $20 $fa
    ld   B, $05                                        ;; 00:29ad $06 $05
.jr_00_29af:
    ld   A, $05                                        ;; 00:29af $3e $05
    sub  A, B                                          ;; 00:29b1 $90
    ret                                                ;; 00:29b2 $c9

call_00_29b3:
    ld   A, [wC42E]                                    ;; 00:29b3 $fa $2e $c4
    swap A                                             ;; 00:29b6 $cb $37
    and  A, $0f                                        ;; 00:29b8 $e6 $0f
    add  A, [HL]                                       ;; 00:29ba $86
    ld   C, A                                          ;; 00:29bb $4f
    inc  HL                                            ;; 00:29bc $23
    ld   A, [wC42F]                                    ;; 00:29bd $fa $2f $c4
    swap A                                             ;; 00:29c0 $cb $37
    and  A, $0f                                        ;; 00:29c2 $e6 $0f
    add  A, [HL]                                       ;; 00:29c4 $86
    ld   HL, wC42D                                     ;; 00:29c5 $21 $2d $c4
    add  A, [HL]                                       ;; 00:29c8 $86
    ld   B, A                                          ;; 00:29c9 $47
    dec  HL                                            ;; 00:29ca $2b
    ld   A, C                                          ;; 00:29cb $79
    add  A, [HL]                                       ;; 00:29cc $86
    ld   C, A                                          ;; 00:29cd $4f
    ret                                                ;; 00:29ce $c9

call_00_29cf:
    ld   A, [wC443]                                    ;; 00:29cf $fa $43 $c4
    inc  A                                             ;; 00:29d2 $3c
    ret  NZ                                            ;; 00:29d3 $c0
    ld   A, [wC442]                                    ;; 00:29d4 $fa $42 $c4
    inc  A                                             ;; 00:29d7 $3c
    ret  NZ                                            ;; 00:29d8 $c0

call_00_29d9:
    ld   A, L                                          ;; 00:29d9 $7d
    ld   [wC442], A                                    ;; 00:29da $ea $42 $c4
    ld   A, H                                          ;; 00:29dd $7c
    ld   [wC443], A                                    ;; 00:29de $ea $43 $c4
    ret                                                ;; 00:29e1 $c9

call_00_29e2:
    and  A, $03                                        ;; 00:29e2 $e6 $03
    swap A                                             ;; 00:29e4 $cb $37
    add  A, A                                          ;; 00:29e6 $87
    ld   E, A                                          ;; 00:29e7 $5f
    ld   C, A                                          ;; 00:29e8 $4f
    ld   A, [wC432]                                    ;; 00:29e9 $fa $32 $c4
    add  A, E                                          ;; 00:29ec $83
    ld   E, A                                          ;; 00:29ed $5f
    ld   A, [wC433]                                    ;; 00:29ee $fa $33 $c4
    ld   D, A                                          ;; 00:29f1 $57
    ld   A, [wC437]                                    ;; 00:29f2 $fa $37 $c4
    or   A, A                                          ;; 00:29f5 $b7
    jr   Z, .jr_00_2a14                                ;; 00:29f6 $28 $1c
    ld   A, [wC431]                                    ;; 00:29f8 $fa $31 $c4
    cp   A, $01                                        ;; 00:29fb $fe $01
    jr   Z, .jr_00_2a14                                ;; 00:29fd $28 $15
    cp   A, $03                                        ;; 00:29ff $fe $03
    jr   NC, .jr_00_2a14                               ;; 00:2a01 $30 $11
    ld   E, $00                                        ;; 00:2a03 $1e $00
    srl  A                                             ;; 00:2a05 $cb $3f
    rr   E                                             ;; 00:2a07 $cb $1b
    ld   D, A                                          ;; 00:2a09 $57
    push HL                                            ;; 00:2a0a $e5
    ld   HL, $4180                                     ;; 00:2a0b $21 $80 $41
    add  HL, DE                                        ;; 00:2a0e $19
    ld   A, L                                          ;; 00:2a0f $7d
    add  A, C                                          ;; 00:2a10 $81
    ld   E, A                                          ;; 00:2a11 $5f
    ld   D, H                                          ;; 00:2a12 $54
    pop  HL                                            ;; 00:2a13 $e1
.jr_00_2a14:
    ld   A, [wC42F]                                    ;; 00:2a14 $fa $2f $c4
    add  A, $10                                        ;; 00:2a17 $c6 $10
    ld   B, A                                          ;; 00:2a19 $47
    ld   A, [wC42E]                                    ;; 00:2a1a $fa $2e $c4
    ld   C, A                                          ;; 00:2a1d $4f
    ld   HL, wC000                                     ;; 00:2a1e $21 $00 $c0
    ld   A, [wC43B]                                    ;; 00:2a21 $fa $3b $c4
    ld   [wC43A], A                                    ;; 00:2a24 $ea $3a $c4
    ld   A, [wC45B]                                    ;; 00:2a27 $fa $5b $c4
    or   A, A                                          ;; 00:2a2a $b7
    jr   NZ, .jr_00_2a4d                               ;; 00:2a2b $20 $20
    call call_00_2a5d                                  ;; 00:2a2d $cd $5d $2a
    ld   A, [wC430]                                    ;; 00:2a30 $fa $30 $c4
    swap A                                             ;; 00:2a33 $cb $37
    ld   C, A                                          ;; 00:2a35 $4f
    ld   HL, wC002                                     ;; 00:2a36 $21 $02 $c0
    ld   B, $04                                        ;; 00:2a39 $06 $04
.jr_00_2a3b:
    ld   A, [HL]                                       ;; 00:2a3b $7e
    add  A, C                                          ;; 00:2a3c $81
    ld   [HL], A                                       ;; 00:2a3d $77
    set  0, H                                          ;; 00:2a3e $cb $c4
    ld   A, [HL]                                       ;; 00:2a40 $7e
    add  A, C                                          ;; 00:2a41 $81
    ld   [HL], A                                       ;; 00:2a42 $77
    res  0, H                                          ;; 00:2a43 $cb $84
    ld   A, L                                          ;; 00:2a45 $7d
    add  A, $04                                        ;; 00:2a46 $c6 $04
    ld   L, A                                          ;; 00:2a48 $6f
    dec  B                                             ;; 00:2a49 $05
    jr   NZ, .jr_00_2a3b                               ;; 00:2a4a $20 $ef
    ret                                                ;; 00:2a4c $c9
.jr_00_2a4d:
    ld   HL, wC000                                     ;; 00:2a4d $21 $00 $c0
    ld   B, $10                                        ;; 00:2a50 $06 $10
    xor  A, A                                          ;; 00:2a52 $af
.jr_00_2a53:
    ld   [HL], A                                       ;; 00:2a53 $77
    set  0, H                                          ;; 00:2a54 $cb $c4
    ld   [HL+], A                                      ;; 00:2a56 $22
    res  0, H                                          ;; 00:2a57 $cb $84
    dec  B                                             ;; 00:2a59 $05
    jr   NZ, .jr_00_2a53                               ;; 00:2a5a $20 $f7
    ret                                                ;; 00:2a5c $c9

call_00_2a5d:
    push HL                                            ;; 00:2a5d $e5
.jr_00_2a5e:
    xor  A, A                                          ;; 00:2a5e $af
    ld   [HL], A                                       ;; 00:2a5f $77
    set  0, H                                          ;; 00:2a60 $cb $c4
    ld   [HL+], A                                      ;; 00:2a62 $22
    res  0, H                                          ;; 00:2a63 $cb $84
    ld   A, L                                          ;; 00:2a65 $7d
    and  A, $0f                                        ;; 00:2a66 $e6 $0f
    jr   NZ, .jr_00_2a5e                               ;; 00:2a68 $20 $f4
    pop  HL                                            ;; 00:2a6a $e1
    ld   A, $01                                        ;; 00:2a6b $3e $01
    rst  switchBankSafe                                ;; 00:2a6d $ef
    push HL                                            ;; 00:2a6e $e5
.jr_00_2a6f:
    ld   A, [DE]                                       ;; 00:2a6f $1a
    inc  E                                             ;; 00:2a70 $1c
    add  A, B                                          ;; 00:2a71 $80
    ld   [HL], A                                       ;; 00:2a72 $77
    set  0, H                                          ;; 00:2a73 $cb $c4
    ld   A, [DE]                                       ;; 00:2a75 $1a
    inc  E                                             ;; 00:2a76 $1c
    add  A, B                                          ;; 00:2a77 $80
    ld   [HL+], A                                      ;; 00:2a78 $22
    ld   A, [DE]                                       ;; 00:2a79 $1a
    inc  E                                             ;; 00:2a7a $1c
    add  A, C                                          ;; 00:2a7b $81
    ld   [HL], A                                       ;; 00:2a7c $77
    res  0, H                                          ;; 00:2a7d $cb $84
    ld   A, [DE]                                       ;; 00:2a7f $1a
    inc  E                                             ;; 00:2a80 $1c
    add  A, C                                          ;; 00:2a81 $81
    ld   [HL+], A                                      ;; 00:2a82 $22
    ld   A, [DE]                                       ;; 00:2a83 $1a
    inc  E                                             ;; 00:2a84 $1c
    ld   [HL], A                                       ;; 00:2a85 $77
    set  0, H                                          ;; 00:2a86 $cb $c4
    ld   A, [DE]                                       ;; 00:2a88 $1a
    inc  E                                             ;; 00:2a89 $1c
    ld   [HL+], A                                      ;; 00:2a8a $22
    ld   A, [DE]                                       ;; 00:2a8b $1a
    inc  E                                             ;; 00:2a8c $1c
    ld   [HL], A                                       ;; 00:2a8d $77
    res  0, H                                          ;; 00:2a8e $cb $84
    ld   A, [DE]                                       ;; 00:2a90 $1a
    inc  E                                             ;; 00:2a91 $1c
    ld   [HL+], A                                      ;; 00:2a92 $22
    ld   A, C                                          ;; 00:2a93 $79
    add  A, $08                                        ;; 00:2a94 $c6 $08
    ld   C, A                                          ;; 00:2a96 $4f
    bit  2, L                                          ;; 00:2a97 $cb $55
    jr   NZ, .jr_00_2a6f                               ;; 00:2a99 $20 $d4
    ld   A, C                                          ;; 00:2a9b $79
    sub  A, $10                                        ;; 00:2a9c $d6 $10
    ld   C, A                                          ;; 00:2a9e $4f
    ld   A, B                                          ;; 00:2a9f $78
    add  A, $08                                        ;; 00:2aa0 $c6 $08
    ld   B, A                                          ;; 00:2aa2 $47
    bit  3, L                                          ;; 00:2aa3 $cb $5d
    jr   NZ, .jr_00_2a6f                               ;; 00:2aa5 $20 $c8
    pop  HL                                            ;; 00:2aa7 $e1
    ld   A, [wC43A]                                    ;; 00:2aa8 $fa $3a $c4
    and  A, $20                                        ;; 00:2aab $e6 $20
    jr   Z, .jr_00_2ac4                                ;; 00:2aad $28 $15
    push HL                                            ;; 00:2aaf $e5
    inc  L                                             ;; 00:2ab0 $2c
    inc  L                                             ;; 00:2ab1 $2c
    inc  L                                             ;; 00:2ab2 $2c
    set  7, [HL]                                       ;; 00:2ab3 $cb $fe
    set  0, H                                          ;; 00:2ab5 $cb $c4
    set  7, [HL]                                       ;; 00:2ab7 $cb $fe
    inc  L                                             ;; 00:2ab9 $2c
    inc  L                                             ;; 00:2aba $2c
    inc  L                                             ;; 00:2abb $2c
    inc  L                                             ;; 00:2abc $2c
    set  7, [HL]                                       ;; 00:2abd $cb $fe
    res  0, H                                          ;; 00:2abf $cb $84
    set  7, [HL]                                       ;; 00:2ac1 $cb $fe
    pop  HL                                            ;; 00:2ac3 $e1
.jr_00_2ac4:
    ld   A, [wC43A]                                    ;; 00:2ac4 $fa $3a $c4
    and  A, $10                                        ;; 00:2ac7 $e6 $10
    ret  Z                                             ;; 00:2ac9 $c8
    ld   A, L                                          ;; 00:2aca $7d
    add  A, $0b                                        ;; 00:2acb $c6 $0b
    ld   L, A                                          ;; 00:2acd $6f
    set  7, [HL]                                       ;; 00:2ace $cb $fe
    set  0, H                                          ;; 00:2ad0 $cb $c4
    set  7, [HL]                                       ;; 00:2ad2 $cb $fe
    inc  L                                             ;; 00:2ad4 $2c
    inc  L                                             ;; 00:2ad5 $2c
    inc  L                                             ;; 00:2ad6 $2c
    inc  L                                             ;; 00:2ad7 $2c
    set  7, [HL]                                       ;; 00:2ad8 $cb $fe
    res  0, H                                          ;; 00:2ada $cb $84
    set  7, [HL]                                       ;; 00:2adc $cb $fe
    ret                                                ;; 00:2ade $c9

jp_00_2adf:
    call call_00_2ae6                                  ;; 00:2adf $cd $e6 $2a
    call call_00_2b14                                  ;; 00:2ae2 $cd $14 $2b
    ret                                                ;; 00:2ae5 $c9

call_00_2ae6:
    ld   A, [wC454]                                    ;; 00:2ae6 $fa $54 $c4
    ld   L, A                                          ;; 00:2ae9 $6f
    ld   H, $00                                        ;; 00:2aea $26 $00
    add  HL, HL                                        ;; 00:2aec $29
    add  HL, HL                                        ;; 00:2aed $29
    add  HL, HL                                        ;; 00:2aee $29
    ld   DE, data_0b_6570                              ;; 00:2aef $11 $70 $65
    add  HL, DE                                        ;; 00:2af2 $19
    push HL                                            ;; 00:2af3 $e5
    ld   A, $0d                                        ;; 00:2af4 $3e $0d
    rst  switchBankSafe                                ;; 00:2af6 $ef
    ld   HL, $6560                                     ;; 00:2af7 $21 $60 $65
    ld   A, $0a                                        ;; 00:2afa $3e $0a
    ld   DE, $ff00                                     ;; 00:2afc $11 $00 $ff
    call call_00_016b                                  ;; 00:2aff $cd $6b $01
    ld   B, $07                                        ;; 00:2b02 $06 $07
    ld   C, $00                                        ;; 00:2b04 $0e $00
.jr_00_2b06:
    cp   A, [HL]                                       ;; 00:2b06 $be
    jr   NC, .jr_00_2b0e                               ;; 00:2b07 $30 $05
    inc  HL                                            ;; 00:2b09 $23
    inc  C                                             ;; 00:2b0a $0c
    dec  B                                             ;; 00:2b0b $05
    jr   NZ, .jr_00_2b06                               ;; 00:2b0c $20 $f8
.jr_00_2b0e:
    ld   B, $00                                        ;; 00:2b0e $06 $00
    pop  HL                                            ;; 00:2b10 $e1
    add  HL, BC                                        ;; 00:2b11 $09
    ld   C, [HL]                                       ;; 00:2b12 $4e
    ret                                                ;; 00:2b13 $c9

call_00_2b14:
    ld   A, C                                          ;; 00:2b14 $79
    push BC                                            ;; 00:2b15 $c5
    and  A, $7f                                        ;; 00:2b16 $e6 $7f
    ld   L, A                                          ;; 00:2b18 $6f
    ld   H, $00                                        ;; 00:2b19 $26 $00
    add  A, $70                                        ;; 00:2b1b $c6 $70
    ld   C, A                                          ;; 00:2b1d $4f
    ld   A, $6c                                        ;; 00:2b1e $3e $6c
    adc  A, $00                                        ;; 00:2b20 $ce $00
    ld   B, A                                          ;; 00:2b22 $47
    add  HL, HL                                        ;; 00:2b23 $29
    add  HL, HL                                        ;; 00:2b24 $29
    add  HL, BC                                        ;; 00:2b25 $09
    ld   DE, wCFE1                                     ;; 00:2b26 $11 $e1 $cf
    ld   B, $03                                        ;; 00:2b29 $06 $03
.jr_00_2b2b:
    ld   A, $0d                                        ;; 00:2b2b $3e $0d
    call readFromBank                                  ;; 00:2b2d $cd $d2 $00
    ld   [DE], A                                       ;; 00:2b30 $12
    inc  DE                                            ;; 00:2b31 $13
    inc  DE                                            ;; 00:2b32 $13
    inc  HL                                            ;; 00:2b33 $23
    dec  B                                             ;; 00:2b34 $05
    jr   NZ, .jr_00_2b2b                               ;; 00:2b35 $20 $f4
    pop  BC                                            ;; 00:2b37 $c1
    bit  7, C                                          ;; 00:2b38 $cb $79
    jr   Z, .jr_00_2b3d                                ;; 00:2b3a $28 $01
    inc  HL                                            ;; 00:2b3c $23
.jr_00_2b3d:
    ld   A, $0d                                        ;; 00:2b3d $3e $0d
    call readFromBank                                  ;; 00:2b3f $cd $d2 $00
    push AF                                            ;; 00:2b42 $f5
    and  A, $c0                                        ;; 00:2b43 $e6 $c0
    rlca                                               ;; 00:2b45 $07
    rlca                                               ;; 00:2b46 $07
    add  A, $00                                        ;; 00:2b47 $c6 $00
    ld   [wCFE9], A                                    ;; 00:2b49 $ea $e9 $cf
    pop  AF                                            ;; 00:2b4c $f1
    ld   [wD844], A                                    ;; 00:2b4d $ea $44 $d8
    ld   [wCFEA], A                                    ;; 00:2b50 $ea $ea $cf
    and  A, $1f                                        ;; 00:2b53 $e6 $1f
    ld   C, A                                          ;; 00:2b55 $4f
    add  A, A                                          ;; 00:2b56 $87
    add  A, C                                          ;; 00:2b57 $81
    add  A, $f0                                        ;; 00:2b58 $c6 $f0
    ld   L, A                                          ;; 00:2b5a $6f
    ld   A, $6e                                        ;; 00:2b5b $3e $6e
    adc  A, $00                                        ;; 00:2b5d $ce $00
    ld   H, A                                          ;; 00:2b5f $67
    ld   DE, wCFE0                                     ;; 00:2b60 $11 $e0 $cf
    ld   B, $03                                        ;; 00:2b63 $06 $03
.jr_00_2b65:
    ld   A, $0d                                        ;; 00:2b65 $3e $0d
    call readFromBank                                  ;; 00:2b67 $cd $d2 $00
    push DE                                            ;; 00:2b6a $d5
    ld   E, A                                          ;; 00:2b6b $5f
    and  A, $0f                                        ;; 00:2b6c $e6 $0f
    ld   D, A                                          ;; 00:2b6e $57
    ld   A, E                                          ;; 00:2b6f $7b
    swap A                                             ;; 00:2b70 $cb $37
    and  A, $0f                                        ;; 00:2b72 $e6 $0f
    ld   E, A                                          ;; 00:2b74 $5f
    ld   A, $0b                                        ;; 00:2b75 $3e $0b
    call call_00_016b                                  ;; 00:2b77 $cd $6b $01
    pop  DE                                            ;; 00:2b7a $d1
    inc  HL                                            ;; 00:2b7b $23
    ld   [DE], A                                       ;; 00:2b7c $12
    inc  DE                                            ;; 00:2b7d $13
    inc  DE                                            ;; 00:2b7e $13
    dec  B                                             ;; 00:2b7f $05
    jr   NZ, .jr_00_2b65                               ;; 00:2b80 $20 $e3
    ld   A, $28                                        ;; 00:2b82 $3e $28
    ldh  [hFFB2], A                                    ;; 00:2b84 $e0 $b2
    call call_00_2cbe                                  ;; 00:2b86 $cd $be $2c
    ret                                                ;; 00:2b89 $c9

call_00_2b8a:
    call call_00_1b4b                                  ;; 00:2b8a $cd $4b $1b
    call call_00_2bee                                  ;; 00:2b8d $cd $ee $2b
    ld   A, $00                                        ;; 00:2b90 $3e $00
    ld   [wC479], A                                    ;; 00:2b92 $ea $79 $c4
    ld   A, $00                                        ;; 00:2b95 $3e $00
    ld   [wC47C], A                                    ;; 00:2b97 $ea $7c $c4
    ld   A, $02                                        ;; 00:2b9a $3e $02
    ld   [wC47B], A                                    ;; 00:2b9c $ea $7b $c4
    rst  waitForVBlank                                 ;; 00:2b9f $d7
    call call_00_1a97                                  ;; 00:2ba0 $cd $97 $1a
    ld   BC, $2c27                                     ;; 00:2ba3 $01 $27 $2c
    call call_00_2e9c                                  ;; 00:2ba6 $cd $9c $2e
    ld   D, $24                                        ;; 00:2ba9 $16 $24
.jr_00_2bab:
    ldh  A, [rLY]                                      ;; 00:2bab $f0 $44
    cp   A, $90                                        ;; 00:2bad $fe $90
    jr   NC, .jr_00_2bab                               ;; 00:2baf $30 $fa
.jr_00_2bb1:
    ldh  A, [rLY]                                      ;; 00:2bb1 $f0 $44
    cp   A, $90                                        ;; 00:2bb3 $fe $90
    jr   C, .jr_00_2bb1                                ;; 00:2bb5 $38 $fa
    push DE                                            ;; 00:2bb7 $d5
    call call_00_016e                                  ;; 00:2bb8 $cd $6e $01
    pop  DE                                            ;; 00:2bbb $d1
    xor  A, A                                          ;; 00:2bbc $af
    ld   [wC47C], A                                    ;; 00:2bbd $ea $7c $c4
    ei                                                 ;; 00:2bc0 $fb
    ld   A, [wC479]                                    ;; 00:2bc1 $fa $79 $c4
    add  A, $01                                        ;; 00:2bc4 $c6 $01
    ld   [wC479], A                                    ;; 00:2bc6 $ea $79 $c4
    cp   A, D                                          ;; 00:2bc9 $ba
    jr   NZ, .jr_00_2bab                               ;; 00:2bca $20 $df
    ld   A, D                                          ;; 00:2bcc $7a
    srl  A                                             ;; 00:2bcd $cb $3f
    add  A, D                                          ;; 00:2bcf $82
    ld   D, A                                          ;; 00:2bd0 $57
    ld   A, [wC47B]                                    ;; 00:2bd1 $fa $7b $c4
    sla  A                                             ;; 00:2bd4 $cb $27
    ld   [wC47B], A                                    ;; 00:2bd6 $ea $7b $c4
    cp   A, $10                                        ;; 00:2bd9 $fe $10
    jr   NZ, .jr_00_2bab                               ;; 00:2bdb $20 $ce
    xor  A, A                                          ;; 00:2bdd $af
    ldh  [rBGP], A                                     ;; 00:2bde $e0 $47
    ldh  [rOBP0], A                                    ;; 00:2be0 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:2be2 $e0 $49
    call call_00_2ee5                                  ;; 00:2be4 $cd $e5 $2e
    ld   A, [wC462]                                    ;; 00:2be7 $fa $62 $c4
    ld   [wC305], A                                    ;; 00:2bea $ea $05 $c3
    ret                                                ;; 00:2bed $c9

call_00_2bee:
    ld   A, [wC305]                                    ;; 00:2bee $fa $05 $c3
    ld   [wC462], A                                    ;; 00:2bf1 $ea $62 $c4
    and  A, $0f                                        ;; 00:2bf4 $e6 $0f
    ld   [wC305], A                                    ;; 00:2bf6 $ea $05 $c3
    call call_00_2ece                                  ;; 00:2bf9 $cd $ce $2e
    call call_00_0177                                  ;; 00:2bfc $cd $77 $01
    ld   HL, $9c00                                     ;; 00:2bff $21 $00 $9c
.jr_00_2c02:
    ld   [HL], $ff                                     ;; 00:2c02 $36 $ff
    inc  HL                                            ;; 00:2c04 $23
    ld   A, H                                          ;; 00:2c05 $7c
    cp   A, $a0                                        ;; 00:2c06 $fe $a0
    jr   NZ, .jr_00_2c02                               ;; 00:2c08 $20 $f8
    call call_00_017a                                  ;; 00:2c0a $cd $7a $01
    ld   A, $e3                                        ;; 00:2c0d $3e $e3
    ldh  [rLCDC], A                                    ;; 00:2c0f $e0 $40
    xor  A, A                                          ;; 00:2c11 $af
    ldh  [rWY], A                                      ;; 00:2c12 $e0 $4a
    ld   A, $a7                                        ;; 00:2c14 $3e $a7
    ldh  [rWX], A                                      ;; 00:2c16 $e0 $4b
    ldh  A, [hFFC1]                                    ;; 00:2c18 $f0 $c1
    ldh  [rSCY], A                                     ;; 00:2c1a $e0 $42
    ld   [wC47D], A                                    ;; 00:2c1c $ea $7d $c4
    ldh  A, [hFFC2]                                    ;; 00:2c1f $f0 $c2
    ldh  [rSCX], A                                     ;; 00:2c21 $e0 $43
    ld   [wC47A], A                                    ;; 00:2c23 $ea $7a $c4
    ret                                                ;; 00:2c26 $c9
    push AF                                            ;; 00:2c27 $f5
    push HL                                            ;; 00:2c28 $e5
    ldh  A, [rLY]                                      ;; 00:2c29 $f0 $44
    cp   A, $48                                        ;; 00:2c2b $fe $48
    jr   NC, .jr_00_2c63                               ;; 00:2c2d $30 $34
    ld   L, A                                          ;; 00:2c2f $6f
    ld   A, [wC479]                                    ;; 00:2c30 $fa $79 $c4
    cp   A, L                                          ;; 00:2c33 $bd
    jr   NC, .jr_00_2c58                               ;; 00:2c34 $30 $22
    ld   HL, wC47C                                     ;; 00:2c36 $21 $7c $c4
    ldh  A, [rLY]                                      ;; 00:2c39 $f0 $44
    cp   A, [HL]                                       ;; 00:2c3b $be
    ld   A, [wC47D]                                    ;; 00:2c3c $fa $7d $c4
    jr   C, .jr_00_2c48                                ;; 00:2c3f $38 $07
    add  A, [HL]                                       ;; 00:2c41 $86
    ld   L, A                                          ;; 00:2c42 $6f
    ldh  A, [rLY]                                      ;; 00:2c43 $f0 $44
    sub  A, L                                          ;; 00:2c45 $95
    cpl                                                ;; 00:2c46 $2f
    inc  A                                             ;; 00:2c47 $3c
.jr_00_2c48:
    ldh  [rSCY], A                                     ;; 00:2c48 $e0 $42
    ld   A, [wC47B]                                    ;; 00:2c4a $fa $7b $c4
    ld   HL, wC47C                                     ;; 00:2c4d $21 $7c $c4
    add  A, [HL]                                       ;; 00:2c50 $86
    ld   [HL], A                                       ;; 00:2c51 $77
    ld   A, $a7                                        ;; 00:2c52 $3e $a7
    ldh  [rWX], A                                      ;; 00:2c54 $e0 $4b
    jr   .jr_00_2c5c                                   ;; 00:2c56 $18 $04
.jr_00_2c58:
    ld   A, $07                                        ;; 00:2c58 $3e $07
    ldh  [rWX], A                                      ;; 00:2c5a $e0 $4b
.jr_00_2c5c:
    ld   HL, rLYC                                      ;; 00:2c5c $21 $45 $ff
    inc  [HL]                                          ;; 00:2c5f $34
    pop  HL                                            ;; 00:2c60 $e1
    pop  AF                                            ;; 00:2c61 $f1
    reti                                               ;; 00:2c62 $d9
.jr_00_2c63:
    ld   L, A                                          ;; 00:2c63 $6f
    ld   A, $90                                        ;; 00:2c64 $3e $90
    sub  A, L                                          ;; 00:2c66 $95
    ld   L, A                                          ;; 00:2c67 $6f
    ld   A, [wC479]                                    ;; 00:2c68 $fa $79 $c4
    cp   A, L                                          ;; 00:2c6b $bd
    jr   NC, .jr_00_2c58                               ;; 00:2c6c $30 $ea
    ld   A, [wC47C]                                    ;; 00:2c6e $fa $7c $c4
    cp   A, L                                          ;; 00:2c71 $bd
    ld   A, [wC47D]                                    ;; 00:2c72 $fa $7d $c4
    jr   NC, .jr_00_2c81                               ;; 00:2c75 $30 $0a
    add  A, $90                                        ;; 00:2c77 $c6 $90
    ld   HL, wC47C                                     ;; 00:2c79 $21 $7c $c4
    sub  A, [HL]                                       ;; 00:2c7c $96
    ld   HL, rLY                                       ;; 00:2c7d $21 $44 $ff
    sub  A, [HL]                                       ;; 00:2c80 $96
.jr_00_2c81:
    ldh  [rSCY], A                                     ;; 00:2c81 $e0 $42
    ld   A, [wC47C]                                    ;; 00:2c83 $fa $7c $c4
    ld   HL, wC47B                                     ;; 00:2c86 $21 $7b $c4
    sub  A, [HL]                                       ;; 00:2c89 $96
    jr   C, .jr_00_2c8f                                ;; 00:2c8a $38 $03
    ld   [wC47C], A                                    ;; 00:2c8c $ea $7c $c4
.jr_00_2c8f:
    ld   A, $a7                                        ;; 00:2c8f $3e $a7
    ldh  [rWX], A                                      ;; 00:2c91 $e0 $4b
    jr   .jr_00_2c5c                                   ;; 00:2c93 $18 $c7
    db   $f5, $e5, $f0, $44, $fe, $90, $30, $1a        ;; 00:2c95 ????????
    db   $e6, $1f, $6f, $fa, $64, $c4, $bd, $28        ;; 00:2c9d ????????
    db   $0d, $c6, $0a, $e6, $1f, $bd, $20, $0a        ;; 00:2ca5 ????????
    db   $21, $42, $ff, $34, $18, $04, $21, $42        ;; 00:2cad ????????
    db   $ff, $35, $21, $45, $ff, $34, $e1, $f1        ;; 00:2cb5 ????????
    db   $d9                                           ;; 00:2cbd ?

call_00_2cbe:
    call call_00_1b4b                                  ;; 00:2cbe $cd $4b $1b
    call call_00_2ddc                                  ;; 00:2cc1 $cd $dc $2d
    ld   A, $b0                                        ;; 00:2cc4 $3e $b0
    ld   [wC479], A                                    ;; 00:2cc6 $ea $79 $c4
    rst  waitForVBlank                                 ;; 00:2cc9 $d7
    call call_00_1a97                                  ;; 00:2cca $cd $97 $1a
    ld   BC, $2f16                                     ;; 00:2ccd $01 $16 $2f
    call call_00_2e9c                                  ;; 00:2cd0 $cd $9c $2e
.jr_00_2cd3:
    ldh  A, [rLY]                                      ;; 00:2cd3 $f0 $44
    cp   A, $90                                        ;; 00:2cd5 $fe $90
    jr   NC, .jr_00_2cd3                               ;; 00:2cd7 $30 $fa
.jr_00_2cd9:
    ldh  A, [rLY]                                      ;; 00:2cd9 $f0 $44
    cp   A, $90                                        ;; 00:2cdb $fe $90
    jr   C, .jr_00_2cd9                                ;; 00:2cdd $38 $fa
    call call_00_016e                                  ;; 00:2cdf $cd $6e $01
    ei                                                 ;; 00:2ce2 $fb
    ld   A, [wC479]                                    ;; 00:2ce3 $fa $79 $c4
    add  A, $08                                        ;; 00:2ce6 $c6 $08
    ld   [wC479], A                                    ;; 00:2ce8 $ea $79 $c4
    cp   A, $50                                        ;; 00:2ceb $fe $50
    jr   NZ, .jr_00_2cd3                               ;; 00:2ced $20 $e4
    xor  A, A                                          ;; 00:2cef $af
    ldh  [rBGP], A                                     ;; 00:2cf0 $e0 $47
    ldh  [rOBP0], A                                    ;; 00:2cf2 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:2cf4 $e0 $49
    call call_00_2ee5                                  ;; 00:2cf6 $cd $e5 $2e
    ld   A, [wC462]                                    ;; 00:2cf9 $fa $62 $c4
    ld   [wC305], A                                    ;; 00:2cfc $ea $05 $c3
    ret                                                ;; 00:2cff $c9

call_00_2d00:
    call call_00_1b4b                                  ;; 00:2d00 $cd $4b $1b
    call call_00_2ddc                                  ;; 00:2d03 $cd $dc $2d
    ld   A, $48                                        ;; 00:2d06 $3e $48
    ld   [wC479], A                                    ;; 00:2d08 $ea $79 $c4
    rst  waitForVBlank                                 ;; 00:2d0b $d7
    call call_00_1a97                                  ;; 00:2d0c $cd $97 $1a
    ld   BC, $2f43                                     ;; 00:2d0f $01 $43 $2f
    call call_00_2e9c                                  ;; 00:2d12 $cd $9c $2e
.jr_00_2d15:
    ldh  A, [rLY]                                      ;; 00:2d15 $f0 $44
    cp   A, $90                                        ;; 00:2d17 $fe $90
    jr   NC, .jr_00_2d15                               ;; 00:2d19 $30 $fa
.jr_00_2d1b:
    ldh  A, [rLY]                                      ;; 00:2d1b $f0 $44
    cp   A, $90                                        ;; 00:2d1d $fe $90
    jr   C, .jr_00_2d1b                                ;; 00:2d1f $38 $fa
    call call_00_016e                                  ;; 00:2d21 $cd $6e $01
    ei                                                 ;; 00:2d24 $fb
    ld   A, [wC479]                                    ;; 00:2d25 $fa $79 $c4
    dec  A                                             ;; 00:2d28 $3d
    ld   [wC479], A                                    ;; 00:2d29 $ea $79 $c4
    cp   A, $ff                                        ;; 00:2d2c $fe $ff
    jr   NZ, .jr_00_2d15                               ;; 00:2d2e $20 $e5
    xor  A, A                                          ;; 00:2d30 $af
    ldh  [rOBP0], A                                    ;; 00:2d31 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:2d33 $e0 $49
    ldh  [rBGP], A                                     ;; 00:2d35 $e0 $47
    call call_00_2ee5                                  ;; 00:2d37 $cd $e5 $2e
    ld   A, [wC462]                                    ;; 00:2d3a $fa $62 $c4
    ld   [wC305], A                                    ;; 00:2d3d $ea $05 $c3
    ret                                                ;; 00:2d40 $c9

call_00_2d41:
    xor  A, A                                          ;; 00:2d41 $af
    ld_long_store hFFC0, A                             ;; 00:2d42 $ea $c0 $ff
    call call_00_2ddc                                  ;; 00:2d45 $cd $dc $2d
    xor  A, A                                          ;; 00:2d48 $af
    ld   [wC479], A                                    ;; 00:2d49 $ea $79 $c4
    rst  waitForVBlank                                 ;; 00:2d4c $d7
    call call_00_1a97                                  ;; 00:2d4d $cd $97 $1a
    ld   BC, $2f43                                     ;; 00:2d50 $01 $43 $2f
    call call_00_2e9c                                  ;; 00:2d53 $cd $9c $2e
.jr_00_2d56:
    ldh  A, [rLY]                                      ;; 00:2d56 $f0 $44
    cp   A, $90                                        ;; 00:2d58 $fe $90
    jr   NC, .jr_00_2d56                               ;; 00:2d5a $30 $fa
.jr_00_2d5c:
    ldh  A, [rLY]                                      ;; 00:2d5c $f0 $44
    cp   A, $90                                        ;; 00:2d5e $fe $90
    jr   C, .jr_00_2d5c                                ;; 00:2d60 $38 $fa
    ld   A, $d2                                        ;; 00:2d62 $3e $d2
    ldh  [rBGP], A                                     ;; 00:2d64 $e0 $47
    call call_00_016e                                  ;; 00:2d66 $cd $6e $01
    ei                                                 ;; 00:2d69 $fb
    ld   A, [wC479]                                    ;; 00:2d6a $fa $79 $c4
    inc  A                                             ;; 00:2d6d $3c
    ld   [wC479], A                                    ;; 00:2d6e $ea $79 $c4
    cp   A, $48                                        ;; 00:2d71 $fe $48
    jr   NZ, .jr_00_2d56                               ;; 00:2d73 $20 $e1
    di                                                 ;; 00:2d75 $f3
    xor  A, A                                          ;; 00:2d76 $af
    ldh  [rLYC], A                                     ;; 00:2d77 $e0 $45
    call call_00_2eec                                  ;; 00:2d79 $cd $ec $2e
    call call_00_2d8f                                  ;; 00:2d7c $cd $8f $2d
    call call_00_2f03                                  ;; 00:2d7f $cd $03 $2f
    ld   A, [wC462]                                    ;; 00:2d82 $fa $62 $c4
    ld   [wC305], A                                    ;; 00:2d85 $ea $05 $c3
    ld   A, $d2                                        ;; 00:2d88 $3e $d2
    ldh  [rOBP0], A                                    ;; 00:2d8a $e0 $48
    ldh  [rOBP1], A                                    ;; 00:2d8c $e0 $49
    ret                                                ;; 00:2d8e $c9

call_00_2d8f:
    ld   A, [wC44A]                                    ;; 00:2d8f $fa $4a $c4
    ld   H, A                                          ;; 00:2d92 $67
    ld   D, $9c                                        ;; 00:2d93 $16 $9c
    ld   A, [wC449]                                    ;; 00:2d95 $fa $49 $c4
    push AF                                            ;; 00:2d98 $f5
    add  A, $0b                                        ;; 00:2d99 $c6 $0b
    and  A, $1f                                        ;; 00:2d9b $e6 $1f
    ld   L, A                                          ;; 00:2d9d $6f
    pop  AF                                            ;; 00:2d9e $f1
    and  A, $e0                                        ;; 00:2d9f $e6 $e0
    or   A, L                                          ;; 00:2da1 $b5
    ld   L, A                                          ;; 00:2da2 $6f
    ld   E, $00                                        ;; 00:2da3 $1e $00
    ld   C, $12                                        ;; 00:2da5 $0e $12
.jr_00_2da7:
    ld   B, $0b                                        ;; 00:2da7 $06 $0b
    push HL                                            ;; 00:2da9 $e5
.jr_00_2daa:
    ldh  A, [rLY]                                      ;; 00:2daa $f0 $44
    cp   A, $90                                        ;; 00:2dac $fe $90
    jr   C, .jr_00_2daa                                ;; 00:2dae $38 $fa
    cp   A, $97                                        ;; 00:2db0 $fe $97
    jr   NC, .jr_00_2daa                               ;; 00:2db2 $30 $f6
    ld   A, [DE]                                       ;; 00:2db4 $1a
    ld   [HL], A                                       ;; 00:2db5 $77
    ld   A, L                                          ;; 00:2db6 $7d
    push AF                                            ;; 00:2db7 $f5
    inc  A                                             ;; 00:2db8 $3c
    and  A, $1f                                        ;; 00:2db9 $e6 $1f
    ld   L, A                                          ;; 00:2dbb $6f
    pop  AF                                            ;; 00:2dbc $f1
    and  A, $e0                                        ;; 00:2dbd $e6 $e0
    or   A, L                                          ;; 00:2dbf $b5
    ld   L, A                                          ;; 00:2dc0 $6f
    inc  E                                             ;; 00:2dc1 $1c
    dec  B                                             ;; 00:2dc2 $05
    jr   NZ, .jr_00_2daa                               ;; 00:2dc3 $20 $e5
    pop  HL                                            ;; 00:2dc5 $e1
    ld   A, L                                          ;; 00:2dc6 $7d
    add  A, $20                                        ;; 00:2dc7 $c6 $20
    ld   L, A                                          ;; 00:2dc9 $6f
    ld   A, H                                          ;; 00:2dca $7c
    adc  A, $00                                        ;; 00:2dcb $ce $00
    and  A, $9b                                        ;; 00:2dcd $e6 $9b
    ld   H, A                                          ;; 00:2dcf $67
    ld   A, E                                          ;; 00:2dd0 $7b
    add  A, $15                                        ;; 00:2dd1 $c6 $15
    ld   E, A                                          ;; 00:2dd3 $5f
    ld   A, D                                          ;; 00:2dd4 $7a
    adc  A, $00                                        ;; 00:2dd5 $ce $00
    ld   D, A                                          ;; 00:2dd7 $57
    dec  C                                             ;; 00:2dd8 $0d
    jr   NZ, .jr_00_2da7                               ;; 00:2dd9 $20 $cc
    ret                                                ;; 00:2ddb $c9

call_00_2ddc:
    ldh  A, [hFFC1]                                    ;; 00:2ddc $f0 $c1
    ldh  [rSCY], A                                     ;; 00:2dde $e0 $42
    ldh  A, [hFFC2]                                    ;; 00:2de0 $f0 $c2
    ldh  [rSCX], A                                     ;; 00:2de2 $e0 $43
    ld   A, [wC305]                                    ;; 00:2de4 $fa $05 $c3
    ld   [wC462], A                                    ;; 00:2de7 $ea $62 $c4
    and  A, $0f                                        ;; 00:2dea $e6 $0f
    ld   [wC305], A                                    ;; 00:2dec $ea $05 $c3
    call call_00_2ece                                  ;; 00:2def $cd $ce $2e
    call call_00_0177                                  ;; 00:2df2 $cd $77 $01
    ld   HL, $9c00                                     ;; 00:2df5 $21 $00 $9c
.jr_00_2df8:
    ld   [HL], $ff                                     ;; 00:2df8 $36 $ff
    inc  HL                                            ;; 00:2dfa $23
    ld   A, H                                          ;; 00:2dfb $7c
    cp   A, $a0                                        ;; 00:2dfc $fe $a0
    jr   NZ, .jr_00_2df8                               ;; 00:2dfe $20 $f8
    call call_00_017a                                  ;; 00:2e00 $cd $7a $01
    ld   A, [wC44A]                                    ;; 00:2e03 $fa $4a $c4
    ld   H, A                                          ;; 00:2e06 $67
    ld   D, $9c                                        ;; 00:2e07 $16 $9c
    ld   A, [wC449]                                    ;; 00:2e09 $fa $49 $c4
    push AF                                            ;; 00:2e0c $f5
    add  A, $0b                                        ;; 00:2e0d $c6 $0b
    and  A, $1f                                        ;; 00:2e0f $e6 $1f
    ld   L, A                                          ;; 00:2e11 $6f
    pop  AF                                            ;; 00:2e12 $f1
    and  A, $e0                                        ;; 00:2e13 $e6 $e0
    or   A, L                                          ;; 00:2e15 $b5
    ld   L, A                                          ;; 00:2e16 $6f
    ld   E, $00                                        ;; 00:2e17 $1e $00
    ld   C, $12                                        ;; 00:2e19 $0e $12
.jr_00_2e1b:
    ld   B, $0b                                        ;; 00:2e1b $06 $0b
    push HL                                            ;; 00:2e1d $e5
.jr_00_2e1e:
    ldh  A, [rLY]                                      ;; 00:2e1e $f0 $44
    cp   A, $90                                        ;; 00:2e20 $fe $90
    jr   C, .jr_00_2e1e                                ;; 00:2e22 $38 $fa
    cp   A, $97                                        ;; 00:2e24 $fe $97
    jr   NC, .jr_00_2e1e                               ;; 00:2e26 $30 $f6
    ld   A, [HL]                                       ;; 00:2e28 $7e
    ld   [DE], A                                       ;; 00:2e29 $12
    ld   A, L                                          ;; 00:2e2a $7d
    push AF                                            ;; 00:2e2b $f5
    inc  A                                             ;; 00:2e2c $3c
    and  A, $1f                                        ;; 00:2e2d $e6 $1f
    ld   L, A                                          ;; 00:2e2f $6f
    pop  AF                                            ;; 00:2e30 $f1
    and  A, $e0                                        ;; 00:2e31 $e6 $e0
    or   A, L                                          ;; 00:2e33 $b5
    ld   L, A                                          ;; 00:2e34 $6f
    inc  E                                             ;; 00:2e35 $1c
    dec  B                                             ;; 00:2e36 $05
    jr   NZ, .jr_00_2e1e                               ;; 00:2e37 $20 $e5
    ld   HL, $15                                       ;; 00:2e39 $21 $15 $00
    add  HL, DE                                        ;; 00:2e3c $19
    ld   E, L                                          ;; 00:2e3d $5d
    ld   D, H                                          ;; 00:2e3e $54
    pop  HL                                            ;; 00:2e3f $e1
    ld   A, L                                          ;; 00:2e40 $7d
    add  A, $20                                        ;; 00:2e41 $c6 $20
    ld   L, A                                          ;; 00:2e43 $6f
    ld   A, H                                          ;; 00:2e44 $7c
    adc  A, $00                                        ;; 00:2e45 $ce $00
    and  A, $9b                                        ;; 00:2e47 $e6 $9b
    ld   H, A                                          ;; 00:2e49 $67
    dec  C                                             ;; 00:2e4a $0d
    jr   NZ, .jr_00_2e1b                               ;; 00:2e4b $20 $ce
    ld   A, $e3                                        ;; 00:2e4d $3e $e3
    ldh  [rLCDC], A                                    ;; 00:2e4f $e0 $40
    xor  A, A                                          ;; 00:2e51 $af
    ldh  [rWY], A                                      ;; 00:2e52 $e0 $4a
    ld   A, $57                                        ;; 00:2e54 $3e $57
    ldh  [rWX], A                                      ;; 00:2e56 $e0 $4b
    ld   H, $98                                        ;; 00:2e58 $26 $98
    ld   A, [wC449]                                    ;; 00:2e5a $fa $49 $c4
    add  A, $0b                                        ;; 00:2e5d $c6 $0b
    and  A, $1f                                        ;; 00:2e5f $e6 $1f
    ld   L, A                                          ;; 00:2e61 $6f
    ld   C, $20                                        ;; 00:2e62 $0e $20
.jr_00_2e64:
    ld   B, $15                                        ;; 00:2e64 $06 $15
    push HL                                            ;; 00:2e66 $e5
.jr_00_2e67:
    ldh  A, [rLY]                                      ;; 00:2e67 $f0 $44
    cp   A, $90                                        ;; 00:2e69 $fe $90
    jr   C, .jr_00_2e67                                ;; 00:2e6b $38 $fa
    cp   A, $97                                        ;; 00:2e6d $fe $97
    jr   NC, .jr_00_2e67                               ;; 00:2e6f $30 $f6
    ld   [HL], $ff                                     ;; 00:2e71 $36 $ff
    ld   A, L                                          ;; 00:2e73 $7d
    push AF                                            ;; 00:2e74 $f5
    inc  A                                             ;; 00:2e75 $3c
    and  A, $1f                                        ;; 00:2e76 $e6 $1f
    ld   L, A                                          ;; 00:2e78 $6f
    pop  AF                                            ;; 00:2e79 $f1
    and  A, $e0                                        ;; 00:2e7a $e6 $e0
    or   A, L                                          ;; 00:2e7c $b5
    ld   L, A                                          ;; 00:2e7d $6f
    dec  B                                             ;; 00:2e7e $05
    jr   NZ, .jr_00_2e67                               ;; 00:2e7f $20 $e6
    pop  HL                                            ;; 00:2e81 $e1
    ld   A, L                                          ;; 00:2e82 $7d
    add  A, $20                                        ;; 00:2e83 $c6 $20
    ld   L, A                                          ;; 00:2e85 $6f
    ld   A, H                                          ;; 00:2e86 $7c
    adc  A, $00                                        ;; 00:2e87 $ce $00
    ld   H, A                                          ;; 00:2e89 $67
    dec  C                                             ;; 00:2e8a $0d
    jr   NZ, .jr_00_2e64                               ;; 00:2e8b $20 $d7
    ldh  A, [hFFC2]                                    ;; 00:2e8d $f0 $c2
    ldh  [rSCX], A                                     ;; 00:2e8f $e0 $43
    ld   [wC47A], A                                    ;; 00:2e91 $ea $7a $c4
    ldh  A, [hFFC1]                                    ;; 00:2e94 $f0 $c1
    ldh  [rSCY], A                                     ;; 00:2e96 $e0 $42
    ld   [wC47D], A                                    ;; 00:2e98 $ea $7d $c4
    ret                                                ;; 00:2e9b $c9

call_00_2e9c:
    di                                                 ;; 00:2e9c $f3
    ld   HL, wLCDCInterruptHandler                     ;; 00:2e9d $21 $06 $c7
    ld   DE, wC473                                     ;; 00:2ea0 $11 $73 $c4
    ld   A, [HL]                                       ;; 00:2ea3 $7e
    ld   [DE], A                                       ;; 00:2ea4 $12
    ld   A, $c3                                        ;; 00:2ea5 $3e $c3
    ld   [HL], A                                       ;; 00:2ea7 $77
    inc  L                                             ;; 00:2ea8 $2c
    inc  E                                             ;; 00:2ea9 $1c
    ld   A, [HL]                                       ;; 00:2eaa $7e
    ld   [DE], A                                       ;; 00:2eab $12
    ld   [HL], C                                       ;; 00:2eac $71
    inc  L                                             ;; 00:2ead $2c
    inc  E                                             ;; 00:2eae $1c
    ld   A, [HL]                                       ;; 00:2eaf $7e
    ld   [DE], A                                       ;; 00:2eb0 $12
    ld   [HL], B                                       ;; 00:2eb1 $70
    inc  E                                             ;; 00:2eb2 $1c
    ldh  A, [rSTAT]                                    ;; 00:2eb3 $f0 $41
    ld   [DE], A                                       ;; 00:2eb5 $12
    ld   A, $c0                                        ;; 00:2eb6 $3e $c0
    ldh  [rSTAT], A                                    ;; 00:2eb8 $e0 $41
    ei                                                 ;; 00:2eba $fb
    ret                                                ;; 00:2ebb $c9

call_00_2ebc:
    di                                                 ;; 00:2ebc $f3
    ld   A, $c3                                        ;; 00:2ebd $3e $c3
    ld   [wLCDCInterruptHandler], A                    ;; 00:2ebf $ea $06 $c7
    ld   A, $95                                        ;; 00:2ec2 $3e $95
    ld   [wC707], A                                    ;; 00:2ec4 $ea $07 $c7
    ld   A, $2c                                        ;; 00:2ec7 $3e $2c
    ld   [wC708], A                                    ;; 00:2ec9 $ea $08 $c7
    ei                                                 ;; 00:2ecc $fb
    ret                                                ;; 00:2ecd $c9

call_00_2ece:
    di                                                 ;; 00:2ece $f3
    ld   A, $c3                                        ;; 00:2ecf $3e $c3
    ld   [wLCDCInterruptHandler], A                    ;; 00:2ed1 $ea $06 $c7
    ld   A, [data_00_0013]                             ;; 00:2ed4 $fa $13 $00
    ld   [wC707], A                                    ;; 00:2ed7 $ea $07 $c7
    ld   A, [data_00_0013 + $01]                       ;; 00:2eda $fa $14 $00
    ld   [wC708], A                                    ;; 00:2edd $ea $08 $c7
    xor  A, A                                          ;; 00:2ee0 $af
    ldh  [rLYC], A                                     ;; 00:2ee1 $e0 $45
    ei                                                 ;; 00:2ee3 $fb
    ret                                                ;; 00:2ee4 $c9

call_00_2ee5:
    call call_00_2eec                                  ;; 00:2ee5 $cd $ec $2e
    call call_00_2f03                                  ;; 00:2ee8 $cd $03 $2f
    ret                                                ;; 00:2eeb $c9

call_00_2eec:
    di                                                 ;; 00:2eec $f3
    xor  A, A                                          ;; 00:2eed $af
    ldh  [rLYC], A                                     ;; 00:2eee $e0 $45
    ld   HL, wC473                                     ;; 00:2ef0 $21 $73 $c4
    ld   DE, wLCDCInterruptHandler                     ;; 00:2ef3 $11 $06 $c7
    ld   A, [HL+]                                      ;; 00:2ef6 $2a
    ld   [DE], A                                       ;; 00:2ef7 $12
    inc  E                                             ;; 00:2ef8 $1c
    ld   A, [HL+]                                      ;; 00:2ef9 $2a
    ld   [DE], A                                       ;; 00:2efa $12
    inc  E                                             ;; 00:2efb $1c
    ld   A, [HL+]                                      ;; 00:2efc $2a
    ld   [DE], A                                       ;; 00:2efd $12
    ld   A, [HL]                                       ;; 00:2efe $7e
    ldh  [rSTAT], A                                    ;; 00:2eff $e0 $41
    ei                                                 ;; 00:2f01 $fb
    ret                                                ;; 00:2f02 $c9

call_00_2f03:
    ld   A, [wC47A]                                    ;; 00:2f03 $fa $7a $c4
    ldh  [rSCX], A                                     ;; 00:2f06 $e0 $43
    ld   A, [wC47D]                                    ;; 00:2f08 $fa $7d $c4
    ldh  [rSCY], A                                     ;; 00:2f0b $e0 $42
    ld   A, $c3                                        ;; 00:2f0d $3e $c3
    ldh  [rLCDC], A                                    ;; 00:2f0f $e0 $40
    ld   A, $91                                        ;; 00:2f11 $3e $91
    ldh  [rWY], A                                      ;; 00:2f13 $e0 $4a
    ret                                                ;; 00:2f15 $c9
    push AF                                            ;; 00:2f16 $f5
    push HL                                            ;; 00:2f17 $e5
    ldh  A, [rLY]                                      ;; 00:2f18 $f0 $44
    cp   A, $48                                        ;; 00:2f1a $fe $48
    jr   C, .jr_00_2f22                                ;; 00:2f1c $38 $04
    ld   L, A                                          ;; 00:2f1e $6f
    ld   A, $90                                        ;; 00:2f1f $3e $90
    sub  A, L                                          ;; 00:2f21 $95
.jr_00_2f22:
    ld   L, A                                          ;; 00:2f22 $6f
    ld   A, [wC479]                                    ;; 00:2f23 $fa $79 $c4
    add  A, L                                          ;; 00:2f26 $85
    cp   A, $51                                        ;; 00:2f27 $fe $51
    jr   NC, .jr_00_2f3c                               ;; 00:2f29 $30 $11
    ld   L, A                                          ;; 00:2f2b $6f
    ld   A, [wC47A]                                    ;; 00:2f2c $fa $7a $c4
    add  A, L                                          ;; 00:2f2f $85
    ldh  [rSCX], A                                     ;; 00:2f30 $e0 $43
    ld   A, $57                                        ;; 00:2f32 $3e $57
    add  A, L                                          ;; 00:2f34 $85
    cp   A, $a6                                        ;; 00:2f35 $fe $a6
    jr   NZ, .jr_00_2f3a                               ;; 00:2f37 $20 $01
    inc  A                                             ;; 00:2f39 $3c
.jr_00_2f3a:
    ldh  [rWX], A                                      ;; 00:2f3a $e0 $4b
.jr_00_2f3c:
    ld   HL, rLYC                                      ;; 00:2f3c $21 $45 $ff
    inc  [HL]                                          ;; 00:2f3f $34
    pop  HL                                            ;; 00:2f40 $e1
    pop  AF                                            ;; 00:2f41 $f1
    reti                                               ;; 00:2f42 $d9
    push AF                                            ;; 00:2f43 $f5
    push HL                                            ;; 00:2f44 $e5
    ldh  A, [rLY]                                      ;; 00:2f45 $f0 $44
    cp   A, $48                                        ;; 00:2f47 $fe $48
    jr   C, .jr_00_2f4f                                ;; 00:2f49 $38 $04
    ld   L, A                                          ;; 00:2f4b $6f
    ld   A, $90                                        ;; 00:2f4c $3e $90
    sub  A, L                                          ;; 00:2f4e $95
.jr_00_2f4f:
    ld   L, A                                          ;; 00:2f4f $6f
    ld   A, [wC479]                                    ;; 00:2f50 $fa $79 $c4
    cp   A, L                                          ;; 00:2f53 $bd
    jr   C, .jr_00_2f6d                                ;; 00:2f54 $38 $17
    ld   L, A                                          ;; 00:2f56 $6f
    ld   A, $48                                        ;; 00:2f57 $3e $48
    sub  A, L                                          ;; 00:2f59 $95
    ld   L, A                                          ;; 00:2f5a $6f
    ld   A, [wC47A]                                    ;; 00:2f5b $fa $7a $c4
    add  A, L                                          ;; 00:2f5e $85
    ldh  [rSCX], A                                     ;; 00:2f5f $e0 $43
    ld   A, $57                                        ;; 00:2f61 $3e $57
    add  A, L                                          ;; 00:2f63 $85
    cp   A, $a6                                        ;; 00:2f64 $fe $a6
    jr   NZ, .jr_00_2f69                               ;; 00:2f66 $20 $01
    inc  A                                             ;; 00:2f68 $3c
.jr_00_2f69:
    ldh  [rWX], A                                      ;; 00:2f69 $e0 $4b
    jr   .jr_00_2f78                                   ;; 00:2f6b $18 $0b
.jr_00_2f6d:
    ld   A, [wC47A]                                    ;; 00:2f6d $fa $7a $c4
    add  A, $50                                        ;; 00:2f70 $c6 $50
    ldh  [rSCX], A                                     ;; 00:2f72 $e0 $43
    ld   A, $a7                                        ;; 00:2f74 $3e $a7
    ldh  [rWX], A                                      ;; 00:2f76 $e0 $4b
.jr_00_2f78:
    ld   HL, rLYC                                      ;; 00:2f78 $21 $45 $ff
    inc  [HL]                                          ;; 00:2f7b $34
    pop  HL                                            ;; 00:2f7c $e1
    pop  AF                                            ;; 00:2f7d $f1
    reti                                               ;; 00:2f7e $d9

call_00_2f7f:
    push AF                                            ;; 00:2f7f $f5
    push HL                                            ;; 00:2f80 $e5
    ld   A, [wC305]                                    ;; 00:2f81 $fa $05 $c3
    and  A, $f0                                        ;; 00:2f84 $e6 $f0
    cp   A, $20                                        ;; 00:2f86 $fe $20
    jr   NZ, .jr_00_2f9e                               ;; 00:2f88 $20 $14
    ld   A, [wC707]                                    ;; 00:2f8a $fa $07 $c7
    cp   A, $95                                        ;; 00:2f8d $fe $95
    jr   Z, .jr_00_2f98                                ;; 00:2f8f $28 $07
    xor  A, A                                          ;; 00:2f91 $af
    ld   [wC464], A                                    ;; 00:2f92 $ea $64 $c4
    call call_00_2ebc                                  ;; 00:2f95 $cd $bc $2e
.jr_00_2f98:
    call call_00_016e                                  ;; 00:2f98 $cd $6e $01
.jr_00_2f9b:
    pop  HL                                            ;; 00:2f9b $e1
    pop  AF                                            ;; 00:2f9c $f1
    ret                                                ;; 00:2f9d $c9
.jr_00_2f9e:
    ld   A, [wC707]                                    ;; 00:2f9e $fa $07 $c7
    ld   L, A                                          ;; 00:2fa1 $6f
    ld   A, [data_00_0013]                             ;; 00:2fa2 $fa $13 $00
    cp   A, L                                          ;; 00:2fa5 $bd
    jr   Z, .jr_00_2f9b                                ;; 00:2fa6 $28 $f3
    xor  A, A                                          ;; 00:2fa8 $af
    ld   [wC464], A                                    ;; 00:2fa9 $ea $64 $c4
    call call_00_2ece                                  ;; 00:2fac $cd $ce $2e
    jr   .jr_00_2f9b                                   ;; 00:2faf $18 $ea

call_00_2fb1:
    ld   A, [wC452]                                    ;; 00:2fb1 $fa $52 $c4
    or   A, A                                          ;; 00:2fb4 $b7
    jp   Z, .jp_00_2fbb                                ;; 00:2fb5 $ca $bb $2f
    call call_00_363f                                  ;; 00:2fb8 $cd $3f $36
.jp_00_2fbb:
    call call_00_1f23                                  ;; 00:2fbb $cd $23 $1f
    ret                                                ;; 00:2fbe $c9

call_00_2fbf:
    ld   A, [wC435]                                    ;; 00:2fbf $fa $35 $c4
    ld   C, A                                          ;; 00:2fc2 $4f
    and  A, $07                                        ;; 00:2fc3 $e6 $07
    ret  Z                                             ;; 00:2fc5 $c8
    bit  3, C                                          ;; 00:2fc6 $cb $59
    jr   NZ, .jr_00_302b                               ;; 00:2fc8 $20 $61
    add  A, A                                          ;; 00:2fca $87
    add  A, $71                                        ;; 00:2fcb $c6 $71
    ld   L, A                                          ;; 00:2fcd $6f
    ld   H, $1a                                        ;; 00:2fce $26 $1a
    ld   C, [HL]                                       ;; 00:2fd0 $4e
    inc  L                                             ;; 00:2fd1 $2c
    ld   B, [HL]                                       ;; 00:2fd2 $46
    ld   A, [wC43E]                                    ;; 00:2fd3 $fa $3e $c4
.jr_00_2fd6:
    rra                                                ;; 00:2fd6 $1f
    jr   C, .jr_00_2fdf                                ;; 00:2fd7 $38 $06
    sla  B                                             ;; 00:2fd9 $cb $20
    sla  C                                             ;; 00:2fdb $cb $21
    jr   .jr_00_2fd6                                   ;; 00:2fdd $18 $f7
.jr_00_2fdf:
    ld   A, [wC42E]                                    ;; 00:2fdf $fa $2e $c4
    add  A, C                                          ;; 00:2fe2 $81
    ld   [wC42E], A                                    ;; 00:2fe3 $ea $2e $c4
    ld   C, A                                          ;; 00:2fe6 $4f
    inc  L                                             ;; 00:2fe7 $2c
    ld   A, [wC42F]                                    ;; 00:2fe8 $fa $2f $c4
    add  A, B                                          ;; 00:2feb $80
    ld   [wC42F], A                                    ;; 00:2fec $ea $2f $c4
    or   A, C                                          ;; 00:2fef $b1
    and  A, $0f                                        ;; 00:2ff0 $e6 $0f
    ret  NZ                                            ;; 00:2ff2 $c0
    ld   A, [wC435]                                    ;; 00:2ff3 $fa $35 $c4
    and  A, $07                                        ;; 00:2ff6 $e6 $07
    dec  A                                             ;; 00:2ff8 $3d
    xor  A, $01                                        ;; 00:2ff9 $ee $01
    add  A, A                                          ;; 00:2ffb $87
    add  A, $73                                        ;; 00:2ffc $c6 $73
    ld   L, A                                          ;; 00:2ffe $6f
    ld   H, $1a                                        ;; 00:2fff $26 $1a
    call call_00_29b3                                  ;; 00:3001 $cd $b3 $29
    call call_00_2636                                  ;; 00:3004 $cd $36 $26
    res  7, A                                          ;; 00:3007 $cb $bf
    ld   [BC], A                                       ;; 00:3009 $02
    ld   HL, $1a71                                     ;; 00:300a $21 $71 $1a
    call call_00_29b3                                  ;; 00:300d $cd $b3 $29
    call call_00_2636                                  ;; 00:3010 $cd $36 $26
    set  7, A                                          ;; 00:3013 $cb $ff
    ld   [BC], A                                       ;; 00:3015 $02
.jr_00_3016:
    xor  A, A                                          ;; 00:3016 $af
    ld   [wC438], A                                    ;; 00:3017 $ea $38 $c4
    ld   A, [wC435]                                    ;; 00:301a $fa $35 $c4
    sub  A, $10                                        ;; 00:301d $d6 $10
    ld   [wC435], A                                    ;; 00:301f $ea $35 $c4
    swap A                                             ;; 00:3022 $cb $37
    and  A, $0f                                        ;; 00:3024 $e6 $0f
    ret  NZ                                            ;; 00:3026 $c0
    ld   [wC435], A                                    ;; 00:3027 $ea $35 $c4
    ret                                                ;; 00:302a $c9
.jr_00_302b:
    ld   A, C                                          ;; 00:302b $79
    and  A, $07                                        ;; 00:302c $e6 $07
    dec  A                                             ;; 00:302e $3d
    ld   [wC442], A                                    ;; 00:302f $ea $42 $c4
    ld   A, $f0                                        ;; 00:3032 $3e $f0
    ld   [wC443], A                                    ;; 00:3034 $ea $43 $c4
    jr   .jr_00_3016                                   ;; 00:3037 $18 $dd

call_00_3039:
    call call_00_0171                                  ;; 00:3039 $cd $71 $01
    bit  2, A                                          ;; 00:303c $cb $57
    jp   NZ, jp_00_31c5                                ;; 00:303e $c2 $c5 $31
    bit  3, A                                          ;; 00:3041 $cb $5f
    jp   NZ, jp_00_31e1                                ;; 00:3043 $c2 $e1 $31
    bit  1, A                                          ;; 00:3046 $cb $4f
    jp   NZ, jp_00_322b                                ;; 00:3048 $c2 $2b $32
    and  A, $01                                        ;; 00:304b $e6 $01
    ret  Z                                             ;; 00:304d $c8
    ld   E, $1f                                        ;; 00:304e $1e $1f
    call call_00_0192                                  ;; 00:3050 $cd $92 $01
    or   A, A                                          ;; 00:3053 $b7
    jp   NZ, jp_00_3162                                ;; 00:3054 $c2 $62 $31
    ld   A, [wC436]                                    ;; 00:3057 $fa $36 $c4
    add  A, A                                          ;; 00:305a $87
    ld   E, A                                          ;; 00:305b $5f
    ld   D, $00                                        ;; 00:305c $16 $00
    ld   HL, $1a73                                     ;; 00:305e $21 $73 $1a
    add  HL, DE                                        ;; 00:3061 $19
    call call_00_29b3                                  ;; 00:3062 $cd $b3 $29
    ld   A, C                                          ;; 00:3065 $79
    or   A, B                                          ;; 00:3066 $b0
    and  A, $c0                                        ;; 00:3067 $e6 $c0
    ret  NZ                                            ;; 00:3069 $c0
    push BC                                            ;; 00:306a $c5
    call call_00_2636                                  ;; 00:306b $cd $36 $26
    pop  DE                                            ;; 00:306e $d1
    bit  7, A                                          ;; 00:306f $cb $7f
    jp   Z, jp_00_314d                                 ;; 00:3071 $ca $4d $31
    call call_00_3183                                  ;; 00:3074 $cd $83 $31
    ret  C                                             ;; 00:3077 $d8
    ld   A, L                                          ;; 00:3078 $7d
    and  A, $f0                                        ;; 00:3079 $e6 $f0
    add  A, $0b                                        ;; 00:307b $c6 $0b
    ld   L, A                                          ;; 00:307d $6f
    ld   A, [HL]                                       ;; 00:307e $7e
    and  A, $03                                        ;; 00:307f $e6 $03
    jr   Z, .jr_00_308c                                ;; 00:3081 $28 $09
    ld   A, [wC434]                                    ;; 00:3083 $fa $34 $c4
    and  A, $03                                        ;; 00:3086 $e6 $03
    jr   Z, .jr_00_308c                                ;; 00:3088 $28 $02
    and  A, [HL]                                       ;; 00:308a $a6
    ret  Z                                             ;; 00:308b $c8
.jr_00_308c:
    ld   A, L                                          ;; 00:308c $7d
    and  A, $f0                                        ;; 00:308d $e6 $f0
    add  A, $09                                        ;; 00:308f $c6 $09
    ld   L, A                                          ;; 00:3091 $6f
    ld   C, [HL]                                       ;; 00:3092 $4e
    inc  L                                             ;; 00:3093 $2c
    ld   A, [HL]                                       ;; 00:3094 $7e
    ld   B, A                                          ;; 00:3095 $47
    cp   A, $09                                        ;; 00:3096 $fe $09
    jr   Z, .jr_00_3104                                ;; 00:3098 $28 $6a
    cp   A, $0a                                        ;; 00:309a $fe $0a
    jr   Z, .jr_00_3104                                ;; 00:309c $28 $66
    cp   A, $0a                                        ;; 00:309e $fe $0a
    jr   Z, .jr_00_3104                                ;; 00:30a0 $28 $62
    cp   A, $04                                        ;; 00:30a2 $fe $04
    jr   Z, .jr_00_30fb                                ;; 00:30a4 $28 $55
    cp   A, $f0                                        ;; 00:30a6 $fe $f0
    jr   NZ, .jr_00_30d1                               ;; 00:30a8 $20 $27
    ld   A, C                                          ;; 00:30aa $79
    and  A, $f8                                        ;; 00:30ab $e6 $f8
    cp   A, $08                                        ;; 00:30ad $fe $08
    jr   NZ, .jr_00_30d1                               ;; 00:30af $20 $20
    ld   A, [wC436]                                    ;; 00:30b1 $fa $36 $c4
    ld   [wC442], A                                    ;; 00:30b4 $ea $42 $c4
    ld   A, $f8                                        ;; 00:30b7 $3e $f8
    ld   [wC443], A                                    ;; 00:30b9 $ea $43 $c4
    ld   A, L                                          ;; 00:30bc $7d
    and  A, $f0                                        ;; 00:30bd $e6 $f0
    add  A, $09                                        ;; 00:30bf $c6 $09
    ld   L, A                                          ;; 00:30c1 $6f
    ld   A, [HL+]                                      ;; 00:30c2 $2a
    ld   [wC444], A                                    ;; 00:30c3 $ea $44 $c4
    ld   A, [HL]                                       ;; 00:30c6 $7e
    ld   [wC445], A                                    ;; 00:30c7 $ea $45 $c4
    ld   A, L                                          ;; 00:30ca $7d
    and  A, $f0                                        ;; 00:30cb $e6 $f0
    ld   [wC446], A                                    ;; 00:30cd $ea $46 $c4
    ret                                                ;; 00:30d0 $c9
.jr_00_30d1:
    ld   A, C                                          ;; 00:30d1 $79
    ld   [wC442], A                                    ;; 00:30d2 $ea $42 $c4
    ld   A, B                                          ;; 00:30d5 $78
    ld   [wC443], A                                    ;; 00:30d6 $ea $43 $c4
    ld   A, L                                          ;; 00:30d9 $7d
    and  A, $f0                                        ;; 00:30da $e6 $f0
    ld   L, A                                          ;; 00:30dc $6f
    ld   A, L                                          ;; 00:30dd $7d
    and  A, $f0                                        ;; 00:30de $e6 $f0
    add  A, $05                                        ;; 00:30e0 $c6 $05
    ld   L, A                                          ;; 00:30e2 $6f
    ld   A, [HL]                                       ;; 00:30e3 $7e
    and  A, $0f                                        ;; 00:30e4 $e6 $0f
    cp   A, $03                                        ;; 00:30e6 $fe $03
    ret  Z                                             ;; 00:30e8 $c8
    ld   A, [wC436]                                    ;; 00:30e9 $fa $36 $c4
    xor  A, $01                                        ;; 00:30ec $ee $01
    swap A                                             ;; 00:30ee $cb $37
    ld   C, A                                          ;; 00:30f0 $4f
    rlca                                               ;; 00:30f1 $07
    rlca                                               ;; 00:30f2 $07
    or   A, C                                          ;; 00:30f3 $b1
    ld   C, A                                          ;; 00:30f4 $4f
    ld   A, [HL]                                       ;; 00:30f5 $7e
    and  A, $0f                                        ;; 00:30f6 $e6 $0f
    or   A, C                                          ;; 00:30f8 $b1
    ld   [HL], A                                       ;; 00:30f9 $77
    ret                                                ;; 00:30fa $c9
.jr_00_30fb:
    ld   A, C                                          ;; 00:30fb $79
    ld   [wC442], A                                    ;; 00:30fc $ea $42 $c4
    ld   A, B                                          ;; 00:30ff $78
    ld   [wC443], A                                    ;; 00:3100 $ea $43 $c4
    ret                                                ;; 00:3103 $c9
.jr_00_3104:
    ld   A, L                                          ;; 00:3104 $7d
    and  A, $f0                                        ;; 00:3105 $e6 $f0
    or   A, $05                                        ;; 00:3107 $f6 $05
    ld   L, A                                          ;; 00:3109 $6f
    ld   A, [HL]                                       ;; 00:310a $7e
    and  A, $0f                                        ;; 00:310b $e6 $0f
    or   A, $10                                        ;; 00:310d $f6 $10
    ld   [HL], A                                       ;; 00:310f $77
    ld   A, L                                          ;; 00:3110 $7d
    and  A, $f0                                        ;; 00:3111 $e6 $f0
    ld   L, A                                          ;; 00:3113 $6f
    push BC                                            ;; 00:3114 $c5
    push HL                                            ;; 00:3115 $e5
    call call_00_367b                                  ;; 00:3116 $cd $7b $36
    pop  HL                                            ;; 00:3119 $e1
    pop  BC                                            ;; 00:311a $c1
    ld   A, L                                          ;; 00:311b $7d
    and  A, $f0                                        ;; 00:311c $e6 $f0
    or   A, $0c                                        ;; 00:311e $f6 $0c
    ld   L, A                                          ;; 00:3120 $6f
    ld   A, [HL]                                       ;; 00:3121 $7e
    call call_00_018c                                  ;; 00:3122 $cd $8c $01
    jr   NZ, jr_00_3146                                ;; 00:3125 $20 $1f
    ld   A, B                                          ;; 00:3127 $78
    cp   A, $0a                                        ;; 00:3128 $fe $0a
    jr   Z, jr_00_313c                                 ;; 00:312a $28 $10
    ld   A, C                                          ;; 00:312c $79
    inc  A                                             ;; 00:312d $3c
    jr   Z, jr_00_3143                                 ;; 00:312e $28 $13
    push HL                                            ;; 00:3130 $e5
    call call_00_3edf                                  ;; 00:3131 $cd $df $3e
    pop  HL                                            ;; 00:3134 $e1
    or   A, A                                          ;; 00:3135 $b7
    ret  NZ                                            ;; 00:3136 $c0

call_00_3137:
    ld   A, [HL]                                       ;; 00:3137 $7e
    call call_00_018f                                  ;; 00:3138 $cd $8f $01
    ret                                                ;; 00:313b $c9

jr_00_313c:
    push HL                                            ;; 00:313c $e5
    call call_00_3f4e                                  ;; 00:313d $cd $4e $3f
    pop  HL                                            ;; 00:3140 $e1
    jr   call_00_3137                                  ;; 00:3141 $18 $f4

jr_00_3143:
    call call_00_3137                                  ;; 00:3143 $cd $37 $31

jr_00_3146:
    ld   DE, $103                                      ;; 00:3146 $11 $03 $01
    call call_00_1b66                                  ;; 00:3149 $cd $66 $1b
    ret                                                ;; 00:314c $c9

jp_00_314d:
    bit  6, A                                          ;; 00:314d $cb $77
    ret  NZ                                            ;; 00:314f $c0
    call call_00_2946                                  ;; 00:3150 $cd $46 $29
    and  A, $1f                                        ;; 00:3153 $e6 $1f
    add  A, $20                                        ;; 00:3155 $c6 $20
    ld   C, A                                          ;; 00:3157 $4f
    ld   B, $c5                                        ;; 00:3158 $06 $c5
    ld   A, [BC]                                       ;; 00:315a $0a
    cp   A, $e0                                        ;; 00:315b $fe $e0
    ret  C                                             ;; 00:315d $d8
    call call_00_298a                                  ;; 00:315e $cd $8a $29
    ret                                                ;; 00:3161 $c9

jp_00_3162:
    ld   HL, $1a71                                     ;; 00:3162 $21 $71 $1a
    call call_00_29b3                                  ;; 00:3165 $cd $b3 $29
    call call_00_2636                                  ;; 00:3168 $cd $36 $26
    bit  6, A                                          ;; 00:316b $cb $77
    ret  NZ                                            ;; 00:316d $c0
    call call_00_2946                                  ;; 00:316e $cd $46 $29
    and  A, $1f                                        ;; 00:3171 $e6 $1f
    add  A, $20                                        ;; 00:3173 $c6 $20
    ld   C, A                                          ;; 00:3175 $4f
    ld   B, $c5                                        ;; 00:3176 $06 $c5
    ld   A, [BC]                                       ;; 00:3178 $0a
    cp   A, $c0                                        ;; 00:3179 $fe $c0
    ret  NC                                            ;; 00:317b $d0
    ld   HL, $f005                                     ;; 00:317c $21 $05 $f0
    call call_00_29cf                                  ;; 00:317f $cd $cf $29
    ret                                                ;; 00:3182 $c9

call_00_3183:
    ld   HL, wC600                                     ;; 00:3183 $21 $00 $c6
.jr_00_3186:
    ld   C, [HL]                                       ;; 00:3186 $4e
    bit  7, C                                          ;; 00:3187 $cb $79
    jr   NZ, .jr_00_31b2                               ;; 00:3189 $20 $27
    ld   A, C                                          ;; 00:318b $79
    and  A, $3f                                        ;; 00:318c $e6 $3f
    ld   C, A                                          ;; 00:318e $4f
    inc  L                                             ;; 00:318f $2c
    ld   A, [HL+]                                      ;; 00:3190 $2a
    or   A, A                                          ;; 00:3191 $b7
    jr   Z, .jr_00_319b                                ;; 00:3192 $28 $07
    dec  C                                             ;; 00:3194 $0d
    cp   A, $80                                        ;; 00:3195 $fe $80
    jr   NC, .jr_00_319b                               ;; 00:3197 $30 $02
    inc  C                                             ;; 00:3199 $0c
    inc  C                                             ;; 00:319a $0c
.jr_00_319b:
    ld   A, C                                          ;; 00:319b $79
    and  A, $3f                                        ;; 00:319c $e6 $3f
    cp   A, E                                          ;; 00:319e $bb
    jr   NZ, .jr_00_31b2                               ;; 00:319f $20 $11
    ld   B, [HL]                                       ;; 00:31a1 $46
    inc  L                                             ;; 00:31a2 $2c
    ld   A, [HL+]                                      ;; 00:31a3 $2a
    or   A, A                                          ;; 00:31a4 $b7
    jr   Z, .jr_00_31ae                                ;; 00:31a5 $28 $07
    dec  B                                             ;; 00:31a7 $05
    cp   A, $80                                        ;; 00:31a8 $fe $80
    jr   NC, .jr_00_31ae                               ;; 00:31aa $30 $02
    inc  B                                             ;; 00:31ac $04
    inc  B                                             ;; 00:31ad $04
.jr_00_31ae:
    ld   A, B                                          ;; 00:31ae $78
    cp   A, D                                          ;; 00:31af $ba
    jr   Z, .jr_00_31be                                ;; 00:31b0 $28 $0c
.jr_00_31b2:
    ld   A, L                                          ;; 00:31b2 $7d
    and  A, $f0                                        ;; 00:31b3 $e6 $f0
    add  A, $10                                        ;; 00:31b5 $c6 $10
    ld   L, A                                          ;; 00:31b7 $6f
    or   A, A                                          ;; 00:31b8 $b7
    jr   NZ, .jr_00_3186                               ;; 00:31b9 $20 $cb
    ld   A, L                                          ;; 00:31bb $7d
    scf                                                ;; 00:31bc $37
    ret                                                ;; 00:31bd $c9
.jr_00_31be:
    ld   A, L                                          ;; 00:31be $7d
    and  A, $f0                                        ;; 00:31bf $e6 $f0
    ld   L, A                                          ;; 00:31c1 $6f
    scf                                                ;; 00:31c2 $37
    ccf                                                ;; 00:31c3 $3f
    ret                                                ;; 00:31c4 $c9

jp_00_31c5:
    ld   A, [wC305]                                    ;; 00:31c5 $fa $05 $c3
    ld   [wC460], A                                    ;; 00:31c8 $ea $60 $c4
    and  A, $0f                                        ;; 00:31cb $e6 $0f
    ld   [wC305], A                                    ;; 00:31cd $ea $05 $c3
    call call_00_2ece                                  ;; 00:31d0 $cd $ce $2e
    call call_00_01a4                                  ;; 00:31d3 $cd $a4 $01
    call call_00_1ec2                                  ;; 00:31d6 $cd $c2 $1e
    ld   A, [wC452]                                    ;; 00:31d9 $fa $52 $c4
    or   A, A                                          ;; 00:31dc $b7
    jr   Z, jp_00_31fc                                 ;; 00:31dd $28 $1d
    jr   jr_00_31f9                                    ;; 00:31df $18 $18

jp_00_31e1:
    call call_00_2ece                                  ;; 00:31e1 $cd $ce $2e
    ld   A, [wC305]                                    ;; 00:31e4 $fa $05 $c3
    ld   [wC460], A                                    ;; 00:31e7 $ea $60 $c4
    and  A, $0f                                        ;; 00:31ea $e6 $0f
    ld   [wC305], A                                    ;; 00:31ec $ea $05 $c3
    call call_00_01a1                                  ;; 00:31ef $cd $a1 $01
    ld   A, [wC452]                                    ;; 00:31f2 $fa $52 $c4
    or   A, A                                          ;; 00:31f5 $b7
    jp   Z, jp_00_31fc                                 ;; 00:31f6 $ca $fc $31

jr_00_31f9:
    call call_00_363f                                  ;; 00:31f9 $cd $3f $36

jp_00_31fc:
    call call_00_1f23                                  ;; 00:31fc $cd $23 $1f
    ld   A, $d2                                        ;; 00:31ff $3e $d2
    ldh  [rBGP], A                                     ;; 00:3201 $e0 $47
    ldh  [rOBP0], A                                    ;; 00:3203 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:3205 $e0 $49
    ld   A, [wC305]                                    ;; 00:3207 $fa $05 $c3
    and  A, $f0                                        ;; 00:320a $e6 $f0
    cp   A, $30                                        ;; 00:320c $fe $30
    jr   Z, .jr_00_3222                                ;; 00:320e $28 $12
    or   A, A                                          ;; 00:3210 $b7
    ret  NZ                                            ;; 00:3211 $c0
    ld   A, [wC305]                                    ;; 00:3212 $fa $05 $c3
    and  A, $0f                                        ;; 00:3215 $e6 $0f
    ld   B, A                                          ;; 00:3217 $47
    ld   A, [wC460]                                    ;; 00:3218 $fa $60 $c4
    and  A, $f0                                        ;; 00:321b $e6 $f0
    or   A, B                                          ;; 00:321d $b0
    ld   [wC305], A                                    ;; 00:321e $ea $05 $c3
    ret                                                ;; 00:3221 $c9
.jr_00_3222:
    ld   A, [wC305]                                    ;; 00:3222 $fa $05 $c3
    and  A, $0f                                        ;; 00:3225 $e6 $0f
    ld   [wC305], A                                    ;; 00:3227 $ea $05 $c3
    ret                                                ;; 00:322a $c9

jp_00_322b:
    ld   DE, $58                                       ;; 00:322b $11 $58 $00
    call call_00_1b66                                  ;; 00:322e $cd $66 $1b
    ret                                                ;; 00:3231 $c9

jp_00_3232:
    ld   HL, data_0c_468a ;@=ptr bank=0C               ;; 00:3232 $21 $8a $46
    ld   A, $0c                                        ;; 00:3235 $3e $0c
    call readFromBank                                  ;; 00:3237 $cd $d2 $00
    ld   E, A                                          ;; 00:323a $5f
    inc  HL                                            ;; 00:323b $23
    ld   A, $0c                                        ;; 00:323c $3e $0c
    call readFromBank                                  ;; 00:323e $cd $d2 $00
    ld   D, A                                          ;; 00:3241 $57
    farcall2 call_0c_4000                              ;; 00:3242 $cd $7d $01 $00 $40 $0c
    ret                                                ;; 00:3248 $c9

call_00_3249:
    ld   A, $01                                        ;; 00:3249 $3e $01
    ld   DE, $300                                      ;; 00:324b $11 $00 $03
    call call_00_016b                                  ;; 00:324e $cd $6b $01
    or   A, A                                          ;; 00:3251 $b7
    ret  NZ                                            ;; 00:3252 $c0
    xor  A, A                                          ;; 00:3253 $af
    ld   DE, $f00                                      ;; 00:3254 $11 $00 $0f
    call call_00_016b                                  ;; 00:3257 $cd $6b $01
    ld   B, A                                          ;; 00:325a $47
    swap A                                             ;; 00:325b $cb $37
    ld   L, A                                          ;; 00:325d $6f
    ld   H, $c6                                        ;; 00:325e $26 $c6
    ld   A, [HL+]                                      ;; 00:3260 $2a
    bit  7, A                                          ;; 00:3261 $cb $7f
    ret  NZ                                            ;; 00:3263 $c0
    bit  6, A                                          ;; 00:3264 $cb $77
    ret  NZ                                            ;; 00:3266 $c0
    ld   C, A                                          ;; 00:3267 $4f
    ld   A, B                                          ;; 00:3268 $78
    add  A, $20                                        ;; 00:3269 $c6 $20
    ld   DE, $300                                      ;; 00:326b $11 $00 $03
    call call_00_016b                                  ;; 00:326e $cd $6b $01
    and  A, $03                                        ;; 00:3271 $e6 $03
    ld   [wC47E], A                                    ;; 00:3273 $ea $7e $c4
    add  A, A                                          ;; 00:3276 $87
    add  A, $73                                        ;; 00:3277 $c6 $73
    ld   E, A                                          ;; 00:3279 $5f
    ld   D, $1a                                        ;; 00:327a $16 $1a
    ld   A, [DE]                                       ;; 00:327c $1a
    inc  E                                             ;; 00:327d $1c
    add  A, C                                          ;; 00:327e $81
    ld   C, A                                          ;; 00:327f $4f
    ld   A, [HL+]                                      ;; 00:3280 $2a
    or   A, A                                          ;; 00:3281 $b7
    ret  NZ                                            ;; 00:3282 $c0
    ld   A, [DE]                                       ;; 00:3283 $1a
    add  A, [HL]                                       ;; 00:3284 $86
    ld   B, A                                          ;; 00:3285 $47
    or   A, C                                          ;; 00:3286 $b1
    and  A, $c0                                        ;; 00:3287 $e6 $c0
    ret  NZ                                            ;; 00:3289 $c0
    inc  L                                             ;; 00:328a $2c
    ld   A, [HL+]                                      ;; 00:328b $2a
    or   A, A                                          ;; 00:328c $b7
    ret  NZ                                            ;; 00:328d $c0
    ld   A, [HL]                                       ;; 00:328e $7e
    or   A, A                                          ;; 00:328f $b7
    ret  NZ                                            ;; 00:3290 $c0
    call call_00_2636                                  ;; 00:3291 $cd $36 $26
    bit  7, A                                          ;; 00:3294 $cb $7f
    ret  NZ                                            ;; 00:3296 $c0
    call call_00_2946                                  ;; 00:3297 $cd $46 $29
    ld   C, A                                          ;; 00:329a $4f
    and  A, $1f                                        ;; 00:329b $e6 $1f
    add  A, $20                                        ;; 00:329d $c6 $20
    ld   E, A                                          ;; 00:329f $5f
    ld   D, $c5                                        ;; 00:32a0 $16 $c5
    ld   A, [DE]                                       ;; 00:32a2 $1a
    bit  7, A                                          ;; 00:32a3 $cb $7f
    ret  NZ                                            ;; 00:32a5 $c0
    ld   C, A                                          ;; 00:32a6 $4f
    ld   A, L                                          ;; 00:32a7 $7d
    and  A, $f0                                        ;; 00:32a8 $e6 $f0
    add  A, $0b                                        ;; 00:32aa $c6 $0b
    ld   L, A                                          ;; 00:32ac $6f
    ld   A, [HL]                                       ;; 00:32ad $7e
    and  A, C                                          ;; 00:32ae $a1
    ret  NZ                                            ;; 00:32af $c0
    bit  2, C                                          ;; 00:32b0 $cb $51
    jr   NZ, .jr_00_32bf                               ;; 00:32b2 $20 $0b
    ld   A, C                                          ;; 00:32b4 $79
    and  A, $03                                        ;; 00:32b5 $e6 $03
    jr   Z, .jr_00_32be                                ;; 00:32b7 $28 $05
    cp   A, $03                                        ;; 00:32b9 $fe $03
    ret  Z                                             ;; 00:32bb $c8
    xor  A, $03                                        ;; 00:32bc $ee $03
.jr_00_32be:
    ld   [HL], A                                       ;; 00:32be $77
.jr_00_32bf:
    ld   A, L                                          ;; 00:32bf $7d
    and  A, $f0                                        ;; 00:32c0 $e6 $f0
    add  A, $04                                        ;; 00:32c2 $c6 $04
    ld   L, A                                          ;; 00:32c4 $6f
    ld   [HL], $01                                     ;; 00:32c5 $36 $01
    inc  L                                             ;; 00:32c7 $2c
    ld   A, [HL]                                       ;; 00:32c8 $7e
    and  A, $0f                                        ;; 00:32c9 $e6 $0f
    ld   C, A                                          ;; 00:32cb $4f
    ld   A, [wC47E]                                    ;; 00:32cc $fa $7e $c4
    ld   B, A                                          ;; 00:32cf $47
    rlca                                               ;; 00:32d0 $07
    rlca                                               ;; 00:32d1 $07
    or   A, B                                          ;; 00:32d2 $b0
    swap A                                             ;; 00:32d3 $cb $37
    or   A, C                                          ;; 00:32d5 $b1
    ld   [HL], A                                       ;; 00:32d6 $77
    ret                                                ;; 00:32d7 $c9

call_00_32d8:
    ld   HL, wC600                                     ;; 00:32d8 $21 $00 $c6
.jr_00_32db:
    ld   A, [HL+]                                      ;; 00:32db $2a
    bit  7, A                                          ;; 00:32dc $cb $7f
    jr   NZ, .jr_00_3332                               ;; 00:32de $20 $52
    and  A, $3f                                        ;; 00:32e0 $e6 $3f
    ld   C, A                                          ;; 00:32e2 $4f
    ld   D, [HL]                                       ;; 00:32e3 $56
    inc  L                                             ;; 00:32e4 $2c
    ld   B, [HL]                                       ;; 00:32e5 $46
    inc  L                                             ;; 00:32e6 $2c
    ld   A, [HL+]                                      ;; 00:32e7 $2a
    or   A, D                                          ;; 00:32e8 $b2
    ld   D, A                                          ;; 00:32e9 $57
    inc  L                                             ;; 00:32ea $2c
    inc  L                                             ;; 00:32eb $2c
    call call_00_2636                                  ;; 00:32ec $cd $36 $26
    ld   E, A                                          ;; 00:32ef $5f
    ld   A, D                                          ;; 00:32f0 $7a
    or   A, A                                          ;; 00:32f1 $b7
    jr   NZ, .jr_00_32f8                               ;; 00:32f2 $20 $04
    set  7, E                                          ;; 00:32f4 $cb $fb
    ld   A, E                                          ;; 00:32f6 $7b
    ld   [BC], A                                       ;; 00:32f7 $02
.jr_00_32f8:
    ld   A, E                                          ;; 00:32f8 $7b
    call call_00_2946                                  ;; 00:32f9 $cd $46 $29
    ld   C, A                                          ;; 00:32fc $4f
    and  A, $1f                                        ;; 00:32fd $e6 $1f
    add  A, $20                                        ;; 00:32ff $c6 $20
    ld   E, A                                          ;; 00:3301 $5f
    ld   D, $c5                                        ;; 00:3302 $16 $c5
    ld   A, [DE]                                       ;; 00:3304 $1a
    ld   B, A                                          ;; 00:3305 $47
    ld   A, C                                          ;; 00:3306 $79
    and  A, $20                                        ;; 00:3307 $e6 $20
    ld   C, A                                          ;; 00:3309 $4f
    ld   A, [wC43C]                                    ;; 00:330a $fa $3c $c4
    xor  A, C                                          ;; 00:330d $a9
    jr   NZ, .jr_00_331a                               ;; 00:330e $20 $0a
    ld   A, B                                          ;; 00:3310 $78
    cp   A, $c0                                        ;; 00:3311 $fe $c0
    jr   NC, .jr_00_3332                               ;; 00:3313 $30 $1d
    and  A, $30                                        ;; 00:3315 $e6 $30
    ld   [HL], A                                       ;; 00:3317 $77
    jr   .jr_00_331c                                   ;; 00:3318 $18 $02
.jr_00_331a:
    ld   [HL], $30                                     ;; 00:331a $36 $30
.jr_00_331c:
    ld   A, L                                          ;; 00:331c $7d
    and  A, $f0                                        ;; 00:331d $e6 $f0
    add  A, $0b                                        ;; 00:331f $c6 $0b
    ld   L, A                                          ;; 00:3321 $6f
    ld   A, B                                          ;; 00:3322 $78
    cp   A, $80                                        ;; 00:3323 $fe $80
    jr   NC, .jr_00_3332                               ;; 00:3325 $30 $0b
    bit  2, B                                          ;; 00:3327 $cb $50
    jr   NZ, .jr_00_3332                               ;; 00:3329 $20 $07
    and  A, $03                                        ;; 00:332b $e6 $03
    jr   Z, .jr_00_3331                                ;; 00:332d $28 $02
    xor  A, $03                                        ;; 00:332f $ee $03
.jr_00_3331:
    ld   [HL], A                                       ;; 00:3331 $77
.jr_00_3332:
    ld   A, L                                          ;; 00:3332 $7d
    and  A, $f0                                        ;; 00:3333 $e6 $f0
    add  A, $10                                        ;; 00:3335 $c6 $10
    ld   L, A                                          ;; 00:3337 $6f
    or   A, A                                          ;; 00:3338 $b7
    jr   NZ, .jr_00_32db                               ;; 00:3339 $20 $a0
    ret                                                ;; 00:333b $c9

jp_00_333c:
    ld_long_load A, hCurrentBank                       ;; 00:333c $fa $88 $ff
    ld   [wC467], A                                    ;; 00:333f $ea $67 $c4
    ld   HL, wD000                                     ;; 00:3342 $21 $00 $d0
.jr_00_3345:
    ld   A, [HL]                                       ;; 00:3345 $7e
    and  A, $7f                                        ;; 00:3346 $e6 $7f
    ld   [HL+], A                                      ;; 00:3348 $22
    ld   A, H                                          ;; 00:3349 $7c
    cp   A, $e0                                        ;; 00:334a $fe $e0
    jr   NZ, .jr_00_3345                               ;; 00:334c $20 $f7
    ld   A, [wC459]                                    ;; 00:334e $fa $59 $c4
    ld   L, A                                          ;; 00:3351 $6f
    ld   A, [wC45A]                                    ;; 00:3352 $fa $5a $c4
    ld   H, A                                          ;; 00:3355 $67
    ld   D, $81                                        ;; 00:3356 $16 $81
.jr_00_3358:
    ld   A, $07                                        ;; 00:3358 $3e $07
    rst  switchBankSafe                                ;; 00:335a $ef
    ld   A, D                                          ;; 00:335b $7a
    cp   A, $87                                        ;; 00:335c $fe $87
    jr   Z, .jr_00_3368                                ;; 00:335e $28 $08
    ld   A, [HL+]                                      ;; 00:3360 $2a
    cp   A, $ff                                        ;; 00:3361 $fe $ff
    jr   Z, .jr_00_3368                                ;; 00:3363 $28 $03
    inc  D                                             ;; 00:3365 $14
    jr   .jr_00_3358                                   ;; 00:3366 $18 $f0
.jr_00_3368:
    call call_00_3397                                  ;; 00:3368 $cd $97 $33
    call call_00_32d8                                  ;; 00:336b $cd $d8 $32
    call call_00_344b                                  ;; 00:336e $cd $4b $34
    call call_00_2f7f                                  ;; 00:3371 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3374 $d7
    call call_00_1a97                                  ;; 00:3375 $cd $97 $1a
    ld   HL, $1a71                                     ;; 00:3378 $21 $71 $1a
    call call_00_29b3                                  ;; 00:337b $cd $b3 $29
    call call_00_2636                                  ;; 00:337e $cd $36 $26
    ld   A, [BC]                                       ;; 00:3381 $0a
    set  7, A                                          ;; 00:3382 $cb $ff
    ld   [BC], A                                       ;; 00:3384 $02
    ld   A, [wC467]                                    ;; 00:3385 $fa $67 $c4
    rst  switchBankSafe                                ;; 00:3388 $ef
    ret                                                ;; 00:3389 $c9

call_00_338a:
    ld   DE, wC600                                     ;; 00:338a $11 $00 $c6
    ld   A, [wC452]                                    ;; 00:338d $fa $52 $c4
    or   A, A                                          ;; 00:3390 $b7
    jp   Z, jp_00_343d                                 ;; 00:3391 $ca $3d $34
    call call_00_363f                                  ;; 00:3394 $cd $3f $36

call_00_3397:
    ld   DE, wC600                                     ;; 00:3397 $11 $00 $c6
.jp_00_339a:
    ld   A, [HL+]                                      ;; 00:339a $2a
    cp   A, $ff                                        ;; 00:339b $fe $ff
    jp   Z, jp_00_343d                                 ;; 00:339d $ca $3d $34
    cp   A, $80                                        ;; 00:33a0 $fe $80
    jr   NZ, .jr_00_33b6                               ;; 00:33a2 $20 $12
    ld   A, [HL+]                                      ;; 00:33a4 $2a
    ld   C, A                                          ;; 00:33a5 $4f
    call call_00_018c                                  ;; 00:33a6 $cd $8c $01
    jp   NZ, .jp_00_3436                               ;; 00:33a9 $c2 $36 $34
    ld   A, E                                          ;; 00:33ac $7b
    and  A, $f0                                        ;; 00:33ad $e6 $f0
    or   A, $0c                                        ;; 00:33af $f6 $0c
    ld   E, A                                          ;; 00:33b1 $5f
    ld   A, C                                          ;; 00:33b2 $79
    ld   [DE], A                                       ;; 00:33b3 $12
    jr   .jr_00_33d0                                   ;; 00:33b4 $18 $1a
.jr_00_33b6:
    push DE                                            ;; 00:33b6 $d5
    and  A, $1f                                        ;; 00:33b7 $e6 $1f
    ld   E, A                                          ;; 00:33b9 $5f
    call call_00_0192                                  ;; 00:33ba $cd $92 $01
    pop  DE                                            ;; 00:33bd $d1
    inc  A                                             ;; 00:33be $3c
    ld   C, A                                          ;; 00:33bf $4f
    ld   A, [HL+]                                      ;; 00:33c0 $2a
    ld   B, A                                          ;; 00:33c1 $47
    swap A                                             ;; 00:33c2 $cb $37
    and  A, $0f                                        ;; 00:33c4 $e6 $0f
    cp   A, C                                          ;; 00:33c6 $b9
    jr   NC, .jp_00_3436                               ;; 00:33c7 $30 $6d
    ld   A, B                                          ;; 00:33c9 $78
    and  A, $0f                                        ;; 00:33ca $e6 $0f
    dec  C                                             ;; 00:33cc $0d
    cp   A, C                                          ;; 00:33cd $b9
    jr   C, .jp_00_3436                                ;; 00:33ce $38 $66
.jr_00_33d0:
    push HL                                            ;; 00:33d0 $e5
    push HL                                            ;; 00:33d1 $e5
    dec  HL                                            ;; 00:33d2 $2b
    dec  HL                                            ;; 00:33d3 $2b
    ld   A, [HL]                                       ;; 00:33d4 $7e
    and  A, $40                                        ;; 00:33d5 $e6 $40
    ld   C, A                                          ;; 00:33d7 $4f
    ld   A, E                                          ;; 00:33d8 $7b
    and  A, $f0                                        ;; 00:33d9 $e6 $f0
    or   A, $0d                                        ;; 00:33db $f6 $0d
    ld   E, A                                          ;; 00:33dd $5f
    ld   A, C                                          ;; 00:33de $79
    ld   [DE], A                                       ;; 00:33df $12
    pop  HL                                            ;; 00:33e0 $e1
    ld   A, [HL+]                                      ;; 00:33e1 $2a
    ld   C, A                                          ;; 00:33e2 $4f
    ld   A, [HL+]                                      ;; 00:33e3 $2a
    ld   B, A                                          ;; 00:33e4 $47
    ld   A, [HL+]                                      ;; 00:33e5 $2a
    ld   H, [HL]                                       ;; 00:33e6 $66
    ld   L, A                                          ;; 00:33e7 $6f
    ld   A, E                                          ;; 00:33e8 $7b
    and  A, $f0                                        ;; 00:33e9 $e6 $f0
    or   A, $09                                        ;; 00:33eb $f6 $09
    ld   E, A                                          ;; 00:33ed $5f
    ld   A, L                                          ;; 00:33ee $7d
    ld   [DE], A                                       ;; 00:33ef $12
    inc  E                                             ;; 00:33f0 $1c
    ld   A, H                                          ;; 00:33f1 $7c
    and  A, $0f                                        ;; 00:33f2 $e6 $0f
    ld   [DE], A                                       ;; 00:33f4 $12
    inc  E                                             ;; 00:33f5 $1c
    xor  A, A                                          ;; 00:33f6 $af
    ld   [DE], A                                       ;; 00:33f7 $12
    ld   A, E                                          ;; 00:33f8 $7b
    and  A, $f0                                        ;; 00:33f9 $e6 $f0
    ld   E, A                                          ;; 00:33fb $5f
    ld   A, C                                          ;; 00:33fc $79
    and  A, $3f                                        ;; 00:33fd $e6 $3f
    ld   L, A                                          ;; 00:33ff $6f
    ld   A, H                                          ;; 00:3400 $7c
    and  A, $80                                        ;; 00:3401 $e6 $80
    rrca                                               ;; 00:3403 $0f
    or   A, L                                          ;; 00:3404 $b5
    ld   [DE], A                                       ;; 00:3405 $12
    inc  E                                             ;; 00:3406 $1c
    xor  A, A                                          ;; 00:3407 $af
    ld   [DE], A                                       ;; 00:3408 $12
    inc  E                                             ;; 00:3409 $1c
    ld   A, B                                          ;; 00:340a $78
    and  A, $3f                                        ;; 00:340b $e6 $3f
    ld   [DE], A                                       ;; 00:340d $12
    inc  E                                             ;; 00:340e $1c
    xor  A, A                                          ;; 00:340f $af
    ld   [DE], A                                       ;; 00:3410 $12
    inc  E                                             ;; 00:3411 $1c
    ld   [DE], A                                       ;; 00:3412 $12
    inc  E                                             ;; 00:3413 $1c
    ld   A, B                                          ;; 00:3414 $78
    and  A, $c0                                        ;; 00:3415 $e6 $c0
    rlca                                               ;; 00:3417 $07
    rlca                                               ;; 00:3418 $07
    ld   L, A                                          ;; 00:3419 $6f
    ld   A, C                                          ;; 00:341a $79
    and  A, $c0                                        ;; 00:341b $e6 $c0
    ld   C, A                                          ;; 00:341d $4f
    rrca                                               ;; 00:341e $0f
    rrca                                               ;; 00:341f $0f
    or   A, C                                          ;; 00:3420 $b1
    or   A, L                                          ;; 00:3421 $b5
    ld   [DE], A                                       ;; 00:3422 $12
    inc  E                                             ;; 00:3423 $1c
    xor  A, A                                          ;; 00:3424 $af
    ld   [DE], A                                       ;; 00:3425 $12
    inc  E                                             ;; 00:3426 $1c
    ld   [DE], A                                       ;; 00:3427 $12
    inc  E                                             ;; 00:3428 $1c
    ld   A, H                                          ;; 00:3429 $7c
    and  A, $70                                        ;; 00:342a $e6 $70
    ld   [DE], A                                       ;; 00:342c $12
    ld   A, E                                          ;; 00:342d $7b
    and  A, $f0                                        ;; 00:342e $e6 $f0
    add  A, $10                                        ;; 00:3430 $c6 $10
    ld   E, A                                          ;; 00:3432 $5f
    pop  HL                                            ;; 00:3433 $e1
    or   A, A                                          ;; 00:3434 $b7
    ret  Z                                             ;; 00:3435 $c8
.jp_00_3436:
    inc  HL                                            ;; 00:3436 $23
    inc  HL                                            ;; 00:3437 $23
    inc  HL                                            ;; 00:3438 $23
    inc  HL                                            ;; 00:3439 $23
    jp   .jp_00_339a                                   ;; 00:343a $c3 $9a $33

jp_00_343d:
    ld   L, E                                          ;; 00:343d $6b
    ld   H, D                                          ;; 00:343e $62
.jr_00_343f:
    ld   A, H                                          ;; 00:343f $7c
    cp   A, $c7                                        ;; 00:3440 $fe $c7
    ret  Z                                             ;; 00:3442 $c8
    ld   [HL], $80                                     ;; 00:3443 $36 $80
    ld   DE, $10                                       ;; 00:3445 $11 $10 $00
    add  HL, DE                                        ;; 00:3448 $19
    jr   .jr_00_343f                                   ;; 00:3449 $18 $f4

call_00_344b:
    ld   A, $f0                                        ;; 00:344b $3e $f0
    ld   [wC440], A                                    ;; 00:344d $ea $40 $c4
    ld   A, $10                                        ;; 00:3450 $3e $10
    ld   [wC47F], A                                    ;; 00:3452 $ea $7f $c4
    ld   A, [wC42D]                                    ;; 00:3455 $fa $2d $c4
    ld   D, A                                          ;; 00:3458 $57
    ld   A, [wC42C]                                    ;; 00:3459 $fa $2c $c4
    ld   E, A                                          ;; 00:345c $5f
    ld   HL, wC600                                     ;; 00:345d $21 $00 $c6
.jp_00_3460:
    push DE                                            ;; 00:3460 $d5
    ld   A, [HL+]                                      ;; 00:3461 $2a
    bit  7, A                                          ;; 00:3462 $cb $7f
    jp   NZ, .jp_00_35ac                               ;; 00:3464 $c2 $ac $35
    and  A, $3f                                        ;; 00:3467 $e6 $3f
    sub  A, E                                          ;; 00:3469 $93
    cp   A, $0b                                        ;; 00:346a $fe $0b
    jr   NC, .jr_00_34c7                               ;; 00:346c $30 $59
    swap A                                             ;; 00:346e $cb $37
    add  A, [HL]                                       ;; 00:3470 $86
    ld   C, A                                          ;; 00:3471 $4f
    inc  L                                             ;; 00:3472 $2c
    ld   A, [HL+]                                      ;; 00:3473 $2a
    sub  A, D                                          ;; 00:3474 $92
    cp   A, $09                                        ;; 00:3475 $fe $09
    jr   NC, .jr_00_34c7                               ;; 00:3477 $30 $4e
    swap A                                             ;; 00:3479 $cb $37
    add  A, $10                                        ;; 00:347b $c6 $10
    add  A, [HL]                                       ;; 00:347d $86
    ld   B, A                                          ;; 00:347e $47
    inc  L                                             ;; 00:347f $2c
    inc  L                                             ;; 00:3480 $2c
    ld   A, [HL]                                       ;; 00:3481 $7e
    and  A, $07                                        ;; 00:3482 $e6 $07
    ld   E, $00                                        ;; 00:3484 $1e $00
    srl  A                                             ;; 00:3486 $cb $3f
    rr   E                                             ;; 00:3488 $cb $1b
    add  A, $40                                        ;; 00:348a $c6 $40
    ld   D, A                                          ;; 00:348c $57
    ld   A, [HL+]                                      ;; 00:348d $2a
    and  A, $30                                        ;; 00:348e $e6 $30
    add  A, A                                          ;; 00:3490 $87
    add  A, E                                          ;; 00:3491 $83
    ld   E, A                                          ;; 00:3492 $5f
    ld   A, [HL+]                                      ;; 00:3493 $2a
    ld   [wC43A], A                                    ;; 00:3494 $ea $3a $c4
    ld   A, [wC47F]                                    ;; 00:3497 $fa $7f $c4
    ld   [HL+], A                                      ;; 00:349a $22
    cp   A, $a0                                        ;; 00:349b $fe $a0
    jr   Z, .jr_00_34c7                                ;; 00:349d $28 $28
    push HL                                            ;; 00:349f $e5
    ld   L, A                                          ;; 00:34a0 $6f
    ld   H, $c0                                        ;; 00:34a1 $26 $c0
    push HL                                            ;; 00:34a3 $e5
    call call_00_2a5d                                  ;; 00:34a4 $cd $5d $2a
    ld   A, [wC47F]                                    ;; 00:34a7 $fa $7f $c4
    add  A, $10                                        ;; 00:34aa $c6 $10
    ld   [wC47F], A                                    ;; 00:34ac $ea $7f $c4
    pop  DE                                            ;; 00:34af $d1
    pop  HL                                            ;; 00:34b0 $e1
    ld   C, [HL]                                       ;; 00:34b1 $4e
    inc  E                                             ;; 00:34b2 $1c
    inc  E                                             ;; 00:34b3 $1c
    ld   B, $04                                        ;; 00:34b4 $06 $04
.jr_00_34b6:
    ld   A, [DE]                                       ;; 00:34b6 $1a
    add  A, C                                          ;; 00:34b7 $81
    ld   [DE], A                                       ;; 00:34b8 $12
    set  0, D                                          ;; 00:34b9 $cb $c2
    ld   A, [DE]                                       ;; 00:34bb $1a
    add  A, C                                          ;; 00:34bc $81
    ld   [DE], A                                       ;; 00:34bd $12
    res  0, D                                          ;; 00:34be $cb $82
    ld   A, E                                          ;; 00:34c0 $7b
    add  A, $04                                        ;; 00:34c1 $c6 $04
    ld   E, A                                          ;; 00:34c3 $5f
    dec  B                                             ;; 00:34c4 $05
    jr   NZ, .jr_00_34b6                               ;; 00:34c5 $20 $ef
.jr_00_34c7:
    ld   A, L                                          ;; 00:34c7 $7d
    and  A, $f0                                        ;; 00:34c8 $e6 $f0
    inc  A                                             ;; 00:34ca $3c
    ld   L, A                                          ;; 00:34cb $6f
    ld   A, [HL]                                       ;; 00:34cc $7e
    or   A, A                                          ;; 00:34cd $b7
    jr   Z, .jr_00_34fc                                ;; 00:34ce $28 $2c
    and  A, $0f                                        ;; 00:34d0 $e6 $0f
    jr   Z, .jr_00_3506                                ;; 00:34d2 $28 $32
.jr_00_34d4:
    bit  7, [HL]                                       ;; 00:34d4 $cb $7e
    jr   NZ, .jr_00_34dc                               ;; 00:34d6 $20 $04
    inc  [HL]                                          ;; 00:34d8 $34
    jp   .jp_00_35b7                                   ;; 00:34d9 $c3 $b7 $35
.jr_00_34dc:
    dec  [HL]                                          ;; 00:34dc $35
    jp   .jp_00_35b7                                   ;; 00:34dd $c3 $b7 $35
.jr_00_34e0:
    inc  L                                             ;; 00:34e0 $2c
    ld   A, [HL+]                                      ;; 00:34e1 $2a
    or   A, A                                          ;; 00:34e2 $b7
    jp   Z, .jp_00_3527                                ;; 00:34e3 $ca $27 $35
    ld   A, [HL-]                                      ;; 00:34e6 $3a
    rlca                                               ;; 00:34e7 $07
    rlca                                               ;; 00:34e8 $07
    and  A, $03                                        ;; 00:34e9 $e6 $03
    add  A, A                                          ;; 00:34eb $87
    add  A, $73                                        ;; 00:34ec $c6 $73
    ld   E, A                                          ;; 00:34ee $5f
    ld   D, $1a                                        ;; 00:34ef $16 $1a
    dec  L                                             ;; 00:34f1 $2d
    dec  L                                             ;; 00:34f2 $2d
    dec  L                                             ;; 00:34f3 $2d
    ld   A, [DE]                                       ;; 00:34f4 $1a
    ld   [HL+], A                                      ;; 00:34f5 $22
    inc  E                                             ;; 00:34f6 $1c
    inc  L                                             ;; 00:34f7 $2c
    ld   A, [DE]                                       ;; 00:34f8 $1a
    ld   [HL+], A                                      ;; 00:34f9 $22
    jr   .jr_00_353a                                   ;; 00:34fa $18 $3e
.jr_00_34fc:
    inc  L                                             ;; 00:34fc $2c
    inc  L                                             ;; 00:34fd $2c
    ld   A, [HL]                                       ;; 00:34fe $7e
    or   A, A                                          ;; 00:34ff $b7
    jr   Z, .jr_00_34e0                                ;; 00:3500 $28 $de
    and  A, $0f                                        ;; 00:3502 $e6 $0f
    jr   NZ, .jr_00_34d4                               ;; 00:3504 $20 $ce
.jr_00_3506:
    ld   A, [HL]                                       ;; 00:3506 $7e
    ld   E, L                                          ;; 00:3507 $5d
    ld   D, H                                          ;; 00:3508 $54
    sra  A                                             ;; 00:3509 $cb $2f
    sra  A                                             ;; 00:350b $cb $2f
    sra  A                                             ;; 00:350d $cb $2f
    sra  A                                             ;; 00:350f $cb $2f
    ld   [HL-], A                                      ;; 00:3511 $32
    add  A, [HL]                                       ;; 00:3512 $86
    and  A, $3f                                        ;; 00:3513 $e6 $3f
    ld   C, A                                          ;; 00:3515 $4f
    ld   A, [HL]                                       ;; 00:3516 $7e
    and  A, $c0                                        ;; 00:3517 $e6 $c0
    or   A, C                                          ;; 00:3519 $b1
    ld   [HL], A                                       ;; 00:351a $77
    ld   A, L                                          ;; 00:351b $7d
    and  A, $f0                                        ;; 00:351c $e6 $f0
    or   A, $04                                        ;; 00:351e $f6 $04
    ld   L, A                                          ;; 00:3520 $6f
    ld   A, [HL]                                       ;; 00:3521 $7e
    or   A, A                                          ;; 00:3522 $b7
    jr   NZ, .jr_00_353a                               ;; 00:3523 $20 $15
    xor  A, A                                          ;; 00:3525 $af
    ld   [DE], A                                       ;; 00:3526 $12
.jp_00_3527:
    ld   A, L                                          ;; 00:3527 $7d
    and  A, $f0                                        ;; 00:3528 $e6 $f0
    ld   L, A                                          ;; 00:352a $6f
    ld   A, [HL]                                       ;; 00:352b $7e
    and  A, $3f                                        ;; 00:352c $e6 $3f
    ld   C, A                                          ;; 00:352e $4f
    inc  L                                             ;; 00:352f $2c
    inc  L                                             ;; 00:3530 $2c
    ld   B, [HL]                                       ;; 00:3531 $46
    call call_00_2636                                  ;; 00:3532 $cd $36 $26
    set  7, A                                          ;; 00:3535 $cb $ff
    ld   [BC], A                                       ;; 00:3537 $02
    jr   .jp_00_35ac                                   ;; 00:3538 $18 $72
.jr_00_353a:
    dec  [HL]                                          ;; 00:353a $35
    ld   A, L                                          ;; 00:353b $7d
    and  A, $f0                                        ;; 00:353c $e6 $f0
    ld   L, A                                          ;; 00:353e $6f
    ld   A, [HL]                                       ;; 00:353f $7e
    and  A, $3f                                        ;; 00:3540 $e6 $3f
    ld   C, A                                          ;; 00:3542 $4f
    inc  L                                             ;; 00:3543 $2c
    inc  L                                             ;; 00:3544 $2c
    ld   B, [HL]                                       ;; 00:3545 $46
    call call_00_2636                                  ;; 00:3546 $cd $36 $26
    res  7, A                                          ;; 00:3549 $cb $bf
    ld   [BC], A                                       ;; 00:354b $02
    inc  L                                             ;; 00:354c $2c
    ld   A, [HL-]                                      ;; 00:354d $3a
    add  A, [HL]                                       ;; 00:354e $86
    and  A, $3f                                        ;; 00:354f $e6 $3f
    ld   B, A                                          ;; 00:3551 $47
    dec  L                                             ;; 00:3552 $2d
    ld   A, [HL-]                                      ;; 00:3553 $3a
    add  A, [HL]                                       ;; 00:3554 $86
    and  A, $3f                                        ;; 00:3555 $e6 $3f
    ld   C, A                                          ;; 00:3557 $4f
    call call_00_2636                                  ;; 00:3558 $cd $36 $26
    set  7, A                                          ;; 00:355b $cb $ff
    ld   [BC], A                                       ;; 00:355d $02
    call call_00_2946                                  ;; 00:355e $cd $46 $29
    ld   E, A                                          ;; 00:3561 $5f
    and  A, $1f                                        ;; 00:3562 $e6 $1f
    add  A, $20                                        ;; 00:3564 $c6 $20
    ld   C, A                                          ;; 00:3566 $4f
    ld   B, $c5                                        ;; 00:3567 $06 $c5
    ld   A, L                                          ;; 00:3569 $7d
    and  A, $f0                                        ;; 00:356a $e6 $f0
    add  A, $0b                                        ;; 00:356c $c6 $0b
    ld   L, A                                          ;; 00:356e $6f
    ld   A, [BC]                                       ;; 00:356f $0a
    ld   B, A                                          ;; 00:3570 $47
    bit  7, A                                          ;; 00:3571 $cb $7f
    jr   NZ, .jr_00_3581                               ;; 00:3573 $20 $0c
    bit  2, B                                          ;; 00:3575 $cb $50
    jr   NZ, .jr_00_3581                               ;; 00:3577 $20 $08
    ld   A, B                                          ;; 00:3579 $78
    and  A, $03                                        ;; 00:357a $e6 $03
    jr   Z, .jr_00_3580                                ;; 00:357c $28 $02
    xor  A, $03                                        ;; 00:357e $ee $03
.jr_00_3580:
    ld   [HL], A                                       ;; 00:3580 $77
.jr_00_3581:
    ld   C, [HL]                                       ;; 00:3581 $4e
    ld   A, L                                          ;; 00:3582 $7d
    and  A, $f0                                        ;; 00:3583 $e6 $f0
    add  A, $06                                        ;; 00:3585 $c6 $06
    ld   L, A                                          ;; 00:3587 $6f
    ld   A, E                                          ;; 00:3588 $7b
    and  A, $20                                        ;; 00:3589 $e6 $20
    ld   E, A                                          ;; 00:358b $5f
    ld   A, [wC43C]                                    ;; 00:358c $fa $3c $c4
    xor  A, E                                          ;; 00:358f $ab
    jr   NZ, .jr_00_35b5                               ;; 00:3590 $20 $23
    ld   A, B                                          ;; 00:3592 $78
    cp   A, $c0                                        ;; 00:3593 $fe $c0
    jr   NC, .jr_00_35a8                               ;; 00:3595 $30 $11
    bit  2, B                                          ;; 00:3597 $cb $50
    jr   Z, .jr_00_35a2                                ;; 00:3599 $28 $07
    ld   A, C                                          ;; 00:359b $79
    and  A, $01                                        ;; 00:359c $e6 $01
    jr   Z, .jr_00_35a2                                ;; 00:359e $28 $02
    ld   B, $30                                        ;; 00:35a0 $06 $30
.jr_00_35a2:
    ld   A, B                                          ;; 00:35a2 $78
    and  A, $30                                        ;; 00:35a3 $e6 $30
    ld   [HL], A                                       ;; 00:35a5 $77
    jr   .jp_00_35b7                                   ;; 00:35a6 $18 $0f
.jr_00_35a8:
    ld   [HL], $00                                     ;; 00:35a8 $36 $00
    jr   .jp_00_35b7                                   ;; 00:35aa $18 $0b
.jp_00_35ac:
    ld   A, [wC440]                                    ;; 00:35ac $fa $40 $c4
    inc  A                                             ;; 00:35af $3c
    ld   [wC440], A                                    ;; 00:35b0 $ea $40 $c4
    jr   .jp_00_35b7                                   ;; 00:35b3 $18 $02
.jr_00_35b5:
    ld   [HL], $30                                     ;; 00:35b5 $36 $30
.jp_00_35b7:
    pop  DE                                            ;; 00:35b7 $d1
    ld   A, L                                          ;; 00:35b8 $7d
    and  A, $f0                                        ;; 00:35b9 $e6 $f0
    add  A, $10                                        ;; 00:35bb $c6 $10
    ld   L, A                                          ;; 00:35bd $6f
    or   A, A                                          ;; 00:35be $b7
    jp   NZ, .jp_00_3460                               ;; 00:35bf $c2 $60 $34
    ld   A, [wC47F]                                    ;; 00:35c2 $fa $7f $c4
    ld   L, A                                          ;; 00:35c5 $6f
    ld   E, A                                          ;; 00:35c6 $5f
    ld   H, $c0                                        ;; 00:35c7 $26 $c0
.jr_00_35c9:
    ld   A, L                                          ;; 00:35c9 $7d
    cp   A, $a0                                        ;; 00:35ca $fe $a0
    jr   NC, .jr_00_35dc                               ;; 00:35cc $30 $0e
    ld   [HL], $00                                     ;; 00:35ce $36 $00
    set  0, H                                          ;; 00:35d0 $cb $c4
    ld   [HL], $00                                     ;; 00:35d2 $36 $00
    res  0, H                                          ;; 00:35d4 $cb $84
    ld   A, L                                          ;; 00:35d6 $7d
    add  A, $04                                        ;; 00:35d7 $c6 $04
    ld   L, A                                          ;; 00:35d9 $6f
    jr   .jr_00_35c9                                   ;; 00:35da $18 $ed
.jr_00_35dc:
    ld   A, [wC43D]                                    ;; 00:35dc $fa $3d $c4
    or   A, A                                          ;; 00:35df $b7
    ret  Z                                             ;; 00:35e0 $c8
    ld   HL, wC010                                     ;; 00:35e1 $21 $10 $c0
    dec  A                                             ;; 00:35e4 $3d
    jr   Z, .jr_00_360d                                ;; 00:35e5 $28 $26
    dec  A                                             ;; 00:35e7 $3d
    jr   Z, .jr_00_3603                                ;; 00:35e8 $28 $19
    dec  A                                             ;; 00:35ea $3d
    jr   Z, .jr_00_35f7                                ;; 00:35eb $28 $0a
    ldh  A, [hFFC2]                                    ;; 00:35ed $f0 $c2
    add  A, $08                                        ;; 00:35ef $c6 $08
    cpl                                                ;; 00:35f1 $2f
    inc  A                                             ;; 00:35f2 $3c
    and  A, $0f                                        ;; 00:35f3 $e6 $0f
    jr   .jr_00_3615                                   ;; 00:35f5 $18 $1e
.jr_00_35f7:
    ldh  A, [hFFC2]                                    ;; 00:35f7 $f0 $c2
    add  A, $08                                        ;; 00:35f9 $c6 $08
    cpl                                                ;; 00:35fb $2f
    inc  A                                             ;; 00:35fc $3c
    and  A, $0f                                        ;; 00:35fd $e6 $0f
    or   A, $f0                                        ;; 00:35ff $f6 $f0
    jr   .jr_00_3615                                   ;; 00:3601 $18 $12
.jr_00_3603:
    ldh  A, [hFFC1]                                    ;; 00:3603 $f0 $c1
    cpl                                                ;; 00:3605 $2f
    inc  A                                             ;; 00:3606 $3c
    and  A, $0f                                        ;; 00:3607 $e6 $0f
    or   A, $f0                                        ;; 00:3609 $f6 $f0
    jr   .jr_00_3616                                   ;; 00:360b $18 $09
.jr_00_360d:
    ldh  A, [hFFC1]                                    ;; 00:360d $f0 $c1
    cpl                                                ;; 00:360f $2f
    inc  A                                             ;; 00:3610 $3c
    and  A, $0f                                        ;; 00:3611 $e6 $0f
    jr   .jr_00_3616                                   ;; 00:3613 $18 $01
.jr_00_3615:
    inc  L                                             ;; 00:3615 $2c
.jr_00_3616:
    ld   C, A                                          ;; 00:3616 $4f
.jr_00_3617:
    ld   A, L                                          ;; 00:3617 $7d
    cp   A, E                                          ;; 00:3618 $bb
    ret  NC                                            ;; 00:3619 $d0
    ld   A, [HL]                                       ;; 00:361a $7e
    add  A, C                                          ;; 00:361b $81
    ld   [HL], A                                       ;; 00:361c $77
    set  0, H                                          ;; 00:361d $cb $c4
    ld   A, [HL]                                       ;; 00:361f $7e
    add  A, C                                          ;; 00:3620 $81
    ld   [HL], A                                       ;; 00:3621 $77
    res  0, H                                          ;; 00:3622 $cb $84
    ld   A, L                                          ;; 00:3624 $7d
    add  A, $04                                        ;; 00:3625 $c6 $04
    ld   L, A                                          ;; 00:3627 $6f
    jr   .jr_00_3617                                   ;; 00:3628 $18 $ed

call_00_362a:
    ld   HL, wC010                                     ;; 00:362a $21 $10 $c0
.jr_00_362d:
    ld   A, L                                          ;; 00:362d $7d
    cp   A, $a0                                        ;; 00:362e $fe $a0
    ret  NC                                            ;; 00:3630 $d0
    ld   [HL], $00                                     ;; 00:3631 $36 $00
    set  0, H                                          ;; 00:3633 $cb $c4
    ld   [HL], $00                                     ;; 00:3635 $36 $00
    res  0, H                                          ;; 00:3637 $cb $84
    ld   A, L                                          ;; 00:3639 $7d
    add  A, $04                                        ;; 00:363a $c6 $04
    ld   L, A                                          ;; 00:363c $6f
    jr   .jr_00_362d                                   ;; 00:363d $18 $ee

call_00_363f:
    ld   A, [wC459]                                    ;; 00:363f $fa $59 $c4
    ld   L, A                                          ;; 00:3642 $6f
    ld   A, [wC45A]                                    ;; 00:3643 $fa $5a $c4
    ld   H, A                                          ;; 00:3646 $67
    ld   DE, $8100                                     ;; 00:3647 $11 $00 $81
.jr_00_364a:
    ld   A, $07                                        ;; 00:364a $3e $07
    rst  switchBankSafe                                ;; 00:364c $ef
    ld   A, D                                          ;; 00:364d $7a
    cp   A, $87                                        ;; 00:364e $fe $87
    jr   Z, .jr_00_367a                                ;; 00:3650 $28 $28
    ld   A, [HL+]                                      ;; 00:3652 $2a
    cp   A, $ff                                        ;; 00:3653 $fe $ff
    jr   Z, .jr_00_367a                                ;; 00:3655 $28 $23
    push HL                                            ;; 00:3657 $e5
    push DE                                            ;; 00:3658 $d5
    ld   L, $00                                        ;; 00:3659 $2e $00
    add  A, $40                                        ;; 00:365b $c6 $40
    bit  7, A                                          ;; 00:365d $cb $7f
    jr   Z, .jr_00_366b                                ;; 00:365f $28 $0a
    and  A, $7f                                        ;; 00:3661 $e6 $7f
    or   A, $40                                        ;; 00:3663 $f6 $40
    ld   H, A                                          ;; 00:3665 $67
    ld   A, $04                                        ;; 00:3666 $3e $04
    rst  switchBankSafe                                ;; 00:3668 $ef
    jr   .jr_00_366f                                   ;; 00:3669 $18 $04
.jr_00_366b:
    ld   H, A                                          ;; 00:366b $67
    ld   A, $03                                        ;; 00:366c $3e $03
    rst  switchBankSafe                                ;; 00:366e $ef
.jr_00_366f:
    ld   BC, $100                                      ;; 00:366f $01 $00 $01
    call call_00_00ac                                  ;; 00:3672 $cd $ac $00
    pop  DE                                            ;; 00:3675 $d1
    pop  HL                                            ;; 00:3676 $e1
    inc  D                                             ;; 00:3677 $14
    jr   .jr_00_364a                                   ;; 00:3678 $18 $d0
.jr_00_367a:
    ret                                                ;; 00:367a $c9

call_00_367b:
    ld   A, [wC42D]                                    ;; 00:367b $fa $2d $c4
    ld   D, A                                          ;; 00:367e $57
    ld   A, [wC42C]                                    ;; 00:367f $fa $2c $c4
    ld   E, A                                          ;; 00:3682 $5f
    ld   A, [HL+]                                      ;; 00:3683 $2a
    and  A, $3f                                        ;; 00:3684 $e6 $3f
    sub  A, E                                          ;; 00:3686 $93
    swap A                                             ;; 00:3687 $cb $37
    ld   C, A                                          ;; 00:3689 $4f
    inc  L                                             ;; 00:368a $2c
    ld   A, [HL+]                                      ;; 00:368b $2a
    sub  A, D                                          ;; 00:368c $92
    swap A                                             ;; 00:368d $cb $37
    add  A, $10                                        ;; 00:368f $c6 $10
    ld   B, A                                          ;; 00:3691 $47
    inc  L                                             ;; 00:3692 $2c
    inc  L                                             ;; 00:3693 $2c
    ld   A, [HL]                                       ;; 00:3694 $7e
    and  A, $07                                        ;; 00:3695 $e6 $07
    ld   E, $00                                        ;; 00:3697 $1e $00
    srl  A                                             ;; 00:3699 $cb $3f
    rr   E                                             ;; 00:369b $cb $1b
    add  A, $40                                        ;; 00:369d $c6 $40
    ld   D, A                                          ;; 00:369f $57
    ld   A, [HL+]                                      ;; 00:36a0 $2a
    and  A, $30                                        ;; 00:36a1 $e6 $30
    add  A, A                                          ;; 00:36a3 $87
    add  A, E                                          ;; 00:36a4 $83
    ld   E, A                                          ;; 00:36a5 $5f
    ld   A, [HL+]                                      ;; 00:36a6 $2a
    ld   [wC43A], A                                    ;; 00:36a7 $ea $3a $c4
    ld   A, [HL+]                                      ;; 00:36aa $2a
    cp   A, $a0                                        ;; 00:36ab $fe $a0
    ret  Z                                             ;; 00:36ad $c8
    push HL                                            ;; 00:36ae $e5
    ld   L, A                                          ;; 00:36af $6f
    ld   H, $c0                                        ;; 00:36b0 $26 $c0
    push HL                                            ;; 00:36b2 $e5
    call call_00_2a5d                                  ;; 00:36b3 $cd $5d $2a
    pop  DE                                            ;; 00:36b6 $d1
    pop  HL                                            ;; 00:36b7 $e1
    ld   C, [HL]                                       ;; 00:36b8 $4e
    inc  E                                             ;; 00:36b9 $1c
    inc  E                                             ;; 00:36ba $1c
    ld   B, $04                                        ;; 00:36bb $06 $04
.jr_00_36bd:
    ld   A, [DE]                                       ;; 00:36bd $1a
    add  A, C                                          ;; 00:36be $81
    ld   [DE], A                                       ;; 00:36bf $12
    set  0, D                                          ;; 00:36c0 $cb $c2
    ld   A, [DE]                                       ;; 00:36c2 $1a
    add  A, C                                          ;; 00:36c3 $81
    ld   [DE], A                                       ;; 00:36c4 $12
    res  0, D                                          ;; 00:36c5 $cb $82
    ld   A, E                                          ;; 00:36c7 $7b
    add  A, $04                                        ;; 00:36c8 $c6 $04
    ld   E, A                                          ;; 00:36ca $5f
    dec  B                                             ;; 00:36cb $05
    jr   NZ, .jr_00_36bd                               ;; 00:36cc $20 $ef
    call call_00_2f7f                                  ;; 00:36ce $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:36d1 $d7
    call call_00_1a97                                  ;; 00:36d2 $cd $97 $1a
    ret                                                ;; 00:36d5 $c9

call_00_36d6:
    ld   A, [wC449]                                    ;; 00:36d6 $fa $49 $c4
    ld   L, A                                          ;; 00:36d9 $6f
    ld   A, [wC44A]                                    ;; 00:36da $fa $4a $c4
    inc  A                                             ;; 00:36dd $3c
    and  A, $fb                                        ;; 00:36de $e6 $fb
    ld   H, A                                          ;; 00:36e0 $67
    ld   A, L                                          ;; 00:36e1 $7d
    push AF                                            ;; 00:36e2 $f5
    add  A, $0a                                        ;; 00:36e3 $c6 $0a
    and  A, $1f                                        ;; 00:36e5 $e6 $1f
    ld   L, A                                          ;; 00:36e7 $6f
    pop  AF                                            ;; 00:36e8 $f1
    and  A, $e0                                        ;; 00:36e9 $e6 $e0
    or   A, L                                          ;; 00:36eb $b5
    ld   L, A                                          ;; 00:36ec $6f
    ld   D, $00                                        ;; 00:36ed $16 $00
    ld   B, $08                                        ;; 00:36ef $06 $08
    ld   C, $0a                                        ;; 00:36f1 $0e $0a
    call call_00_3846                                  ;; 00:36f3 $cd $46 $38
    ld   A, $01                                        ;; 00:36f6 $3e $01
.jp_00_36f8:
    push AF                                            ;; 00:36f8 $f5
    ld   E, A                                          ;; 00:36f9 $5f
.jr_00_36fa:
    ld   A, D                                          ;; 00:36fa $7a
    xor  A, $01                                        ;; 00:36fb $ee $01
    ld   D, A                                          ;; 00:36fd $57
    ld   A, L                                          ;; 00:36fe $7d
    push AF                                            ;; 00:36ff $f5
    inc  A                                             ;; 00:3700 $3c
    and  A, $1f                                        ;; 00:3701 $e6 $1f
    ld   L, A                                          ;; 00:3703 $6f
    pop  AF                                            ;; 00:3704 $f1
    and  A, $e0                                        ;; 00:3705 $e6 $e0
    or   A, L                                          ;; 00:3707 $b5
    ld   L, A                                          ;; 00:3708 $6f
    inc  C                                             ;; 00:3709 $0c
    call call_00_3846                                  ;; 00:370a $cd $46 $38
    dec  E                                             ;; 00:370d $1d
    jr   NZ, .jr_00_36fa                               ;; 00:370e $20 $ea
    pop  AF                                            ;; 00:3710 $f1
    push AF                                            ;; 00:3711 $f5
    ld   E, A                                          ;; 00:3712 $5f
.jr_00_3713:
    ld   A, D                                          ;; 00:3713 $7a
    xor  A, $02                                        ;; 00:3714 $ee $02
    ld   D, A                                          ;; 00:3716 $57
    ld   A, L                                          ;; 00:3717 $7d
    add  A, $20                                        ;; 00:3718 $c6 $20
    ld   L, A                                          ;; 00:371a $6f
    ld   A, H                                          ;; 00:371b $7c
    adc  A, $00                                        ;; 00:371c $ce $00
    and  A, $fb                                        ;; 00:371e $e6 $fb
    ld   H, A                                          ;; 00:3720 $67
    inc  B                                             ;; 00:3721 $04
    call call_00_3846                                  ;; 00:3722 $cd $46 $38
    dec  E                                             ;; 00:3725 $1d
    jr   NZ, .jr_00_3713                               ;; 00:3726 $20 $eb
    pop  AF                                            ;; 00:3728 $f1
    inc  A                                             ;; 00:3729 $3c
    cp   A, $17                                        ;; 00:372a $fe $17
    jp   Z, .jp_00_376a                                ;; 00:372c $ca $6a $37
    push AF                                            ;; 00:372f $f5
    ld   E, A                                          ;; 00:3730 $5f
.jr_00_3731:
    ld   A, D                                          ;; 00:3731 $7a
    xor  A, $01                                        ;; 00:3732 $ee $01
    ld   D, A                                          ;; 00:3734 $57
    ld   A, L                                          ;; 00:3735 $7d
    push AF                                            ;; 00:3736 $f5
    dec  A                                             ;; 00:3737 $3d
    and  A, $1f                                        ;; 00:3738 $e6 $1f
    ld   L, A                                          ;; 00:373a $6f
    pop  AF                                            ;; 00:373b $f1
    and  A, $e0                                        ;; 00:373c $e6 $e0
    or   A, L                                          ;; 00:373e $b5
    ld   L, A                                          ;; 00:373f $6f
    dec  C                                             ;; 00:3740 $0d
    call call_00_3846                                  ;; 00:3741 $cd $46 $38
    dec  E                                             ;; 00:3744 $1d
    jr   NZ, .jr_00_3731                               ;; 00:3745 $20 $ea
    pop  AF                                            ;; 00:3747 $f1
    push AF                                            ;; 00:3748 $f5
    ld   E, A                                          ;; 00:3749 $5f
.jr_00_374a:
    ld   A, D                                          ;; 00:374a $7a
    xor  A, $02                                        ;; 00:374b $ee $02
    ld   D, A                                          ;; 00:374d $57
    ld   A, L                                          ;; 00:374e $7d
    sub  A, $20                                        ;; 00:374f $d6 $20
    ld   L, A                                          ;; 00:3751 $6f
    ld   A, H                                          ;; 00:3752 $7c
    sbc  A, $00                                        ;; 00:3753 $de $00
    and  A, $fb                                        ;; 00:3755 $e6 $fb
    or   A, $08                                        ;; 00:3757 $f6 $08
    ld   H, A                                          ;; 00:3759 $67
    dec  B                                             ;; 00:375a $05
    call call_00_3846                                  ;; 00:375b $cd $46 $38
    dec  E                                             ;; 00:375e $1d
    jr   NZ, .jr_00_374a                               ;; 00:375f $20 $e9
    pop  AF                                            ;; 00:3761 $f1
    inc  A                                             ;; 00:3762 $3c
    cp   A, $17                                        ;; 00:3763 $fe $17
    jr   Z, .jp_00_376a                                ;; 00:3765 $28 $03
    jp   .jp_00_36f8                                   ;; 00:3767 $c3 $f8 $36
.jp_00_376a:
    ld   A, [wC449]                                    ;; 00:376a $fa $49 $c4
    push AF                                            ;; 00:376d $f5
    dec  A                                             ;; 00:376e $3d
    and  A, $1f                                        ;; 00:376f $e6 $1f
    ld   L, A                                          ;; 00:3771 $6f
    pop  AF                                            ;; 00:3772 $f1
    and  A, $e0                                        ;; 00:3773 $e6 $e0
    or   A, L                                          ;; 00:3775 $b5
    sub  A, $40                                        ;; 00:3776 $d6 $40
    ld   L, A                                          ;; 00:3778 $6f
    ld   A, [wC44A]                                    ;; 00:3779 $fa $4a $c4
    sbc  A, $00                                        ;; 00:377c $de $00
    and  A, $fb                                        ;; 00:377e $e6 $fb
    or   A, $08                                        ;; 00:3780 $f6 $08
    ld   H, A                                          ;; 00:3782 $67
    ld   D, $01                                        ;; 00:3783 $16 $01
    ld   B, $fe                                        ;; 00:3785 $06 $fe
    ld   C, $ff                                        ;; 00:3787 $0e $ff
    ld   A, $16                                        ;; 00:3789 $3e $16
.jp_00_378b:
    push AF                                            ;; 00:378b $f5
    ld   E, A                                          ;; 00:378c $5f
.jr_00_378d:
    ld   A, D                                          ;; 00:378d $7a
    xor  A, $01                                        ;; 00:378e $ee $01
    ld   D, A                                          ;; 00:3790 $57
    ld   A, L                                          ;; 00:3791 $7d
    push AF                                            ;; 00:3792 $f5
    inc  A                                             ;; 00:3793 $3c
    and  A, $1f                                        ;; 00:3794 $e6 $1f
    ld   L, A                                          ;; 00:3796 $6f
    pop  AF                                            ;; 00:3797 $f1
    and  A, $e0                                        ;; 00:3798 $e6 $e0
    or   A, L                                          ;; 00:379a $b5
    ld   L, A                                          ;; 00:379b $6f
    inc  C                                             ;; 00:379c $0c
    call call_00_37f6                                  ;; 00:379d $cd $f6 $37
    dec  E                                             ;; 00:37a0 $1d
    jr   NZ, .jr_00_378d                               ;; 00:37a1 $20 $ea
    pop  AF                                            ;; 00:37a3 $f1
    dec  A                                             ;; 00:37a4 $3d
    ret  Z                                             ;; 00:37a5 $c8
    push AF                                            ;; 00:37a6 $f5
    ld   E, A                                          ;; 00:37a7 $5f
.jr_00_37a8:
    ld   A, D                                          ;; 00:37a8 $7a
    xor  A, $02                                        ;; 00:37a9 $ee $02
    ld   D, A                                          ;; 00:37ab $57
    ld   A, L                                          ;; 00:37ac $7d
    add  A, $20                                        ;; 00:37ad $c6 $20
    ld   L, A                                          ;; 00:37af $6f
    ld   A, H                                          ;; 00:37b0 $7c
    adc  A, $00                                        ;; 00:37b1 $ce $00
    and  A, $fb                                        ;; 00:37b3 $e6 $fb
    ld   H, A                                          ;; 00:37b5 $67
    inc  B                                             ;; 00:37b6 $04
    call call_00_37f6                                  ;; 00:37b7 $cd $f6 $37
    dec  E                                             ;; 00:37ba $1d
    jr   NZ, .jr_00_37a8                               ;; 00:37bb $20 $eb
    pop  AF                                            ;; 00:37bd $f1
    push AF                                            ;; 00:37be $f5
    ld   E, A                                          ;; 00:37bf $5f
.jr_00_37c0:
    ld   A, D                                          ;; 00:37c0 $7a
    xor  A, $01                                        ;; 00:37c1 $ee $01
    ld   D, A                                          ;; 00:37c3 $57
    ld   A, L                                          ;; 00:37c4 $7d
    push AF                                            ;; 00:37c5 $f5
    dec  A                                             ;; 00:37c6 $3d
    and  A, $1f                                        ;; 00:37c7 $e6 $1f
    ld   L, A                                          ;; 00:37c9 $6f
    pop  AF                                            ;; 00:37ca $f1
    and  A, $e0                                        ;; 00:37cb $e6 $e0
    or   A, L                                          ;; 00:37cd $b5
    ld   L, A                                          ;; 00:37ce $6f
    dec  C                                             ;; 00:37cf $0d
    call call_00_37f6                                  ;; 00:37d0 $cd $f6 $37
    dec  E                                             ;; 00:37d3 $1d
    jr   NZ, .jr_00_37c0                               ;; 00:37d4 $20 $ea
    pop  AF                                            ;; 00:37d6 $f1
    dec  A                                             ;; 00:37d7 $3d
    ret  Z                                             ;; 00:37d8 $c8
    push AF                                            ;; 00:37d9 $f5
    ld   E, A                                          ;; 00:37da $5f
.jr_00_37db:
    ld   A, D                                          ;; 00:37db $7a
    xor  A, $02                                        ;; 00:37dc $ee $02
    ld   D, A                                          ;; 00:37de $57
    ld   A, L                                          ;; 00:37df $7d
    sub  A, $20                                        ;; 00:37e0 $d6 $20
    ld   L, A                                          ;; 00:37e2 $6f
    ld   A, H                                          ;; 00:37e3 $7c
    sbc  A, $00                                        ;; 00:37e4 $de $00
    and  A, $fb                                        ;; 00:37e6 $e6 $fb
    or   A, $08                                        ;; 00:37e8 $f6 $08
    ld   H, A                                          ;; 00:37ea $67
    dec  B                                             ;; 00:37eb $05
    call call_00_37f6                                  ;; 00:37ec $cd $f6 $37
    dec  E                                             ;; 00:37ef $1d
    jr   NZ, .jr_00_37db                               ;; 00:37f0 $20 $e9
    pop  AF                                            ;; 00:37f2 $f1
    jp   .jp_00_378b                                   ;; 00:37f3 $c3 $8b $37

call_00_37f6:
    push BC                                            ;; 00:37f6 $c5
    push DE                                            ;; 00:37f7 $d5
    ld   A, [wC42C]                                    ;; 00:37f8 $fa $2c $c4
    sra  C                                             ;; 00:37fb $cb $29
    add  A, C                                          ;; 00:37fd $81
    ld   C, A                                          ;; 00:37fe $4f
    ld   A, [wC42D]                                    ;; 00:37ff $fa $2d $c4
    sra  B                                             ;; 00:3802 $cb $28
    add  A, B                                          ;; 00:3804 $80
    ld   B, A                                          ;; 00:3805 $47
    or   A, C                                          ;; 00:3806 $b1
    and  A, $c0                                        ;; 00:3807 $e6 $c0
    jr   Z, .jr_00_380e                                ;; 00:3809 $28 $03
    xor  A, A                                          ;; 00:380b $af
    jr   .jr_00_3811                                   ;; 00:380c $18 $03
.jr_00_380e:
    call call_00_2636                                  ;; 00:380e $cd $36 $26
.jr_00_3811:
    and  A, $7f                                        ;; 00:3811 $e6 $7f
    cp   A, $40                                        ;; 00:3813 $fe $40
    jr   C, .jr_00_381d                                ;; 00:3815 $38 $06
    and  A, $1f                                        ;; 00:3817 $e6 $1f
    ld   E, A                                          ;; 00:3819 $5f
    ld   D, $c5                                        ;; 00:381a $16 $c5
    ld   A, [DE]                                       ;; 00:381c $1a
.jr_00_381d:
    ld   E, A                                          ;; 00:381d $5f
    ld   A, [wC43C]                                    ;; 00:381e $fa $3c $c4
    xor  A, E                                          ;; 00:3821 $ab
    cp   A, $20                                        ;; 00:3822 $fe $20
    jp   C, jp_00_3889                                 ;; 00:3824 $da $89 $38
    ld   A, [wC43C]                                    ;; 00:3827 $fa $3c $c4
    swap A                                             ;; 00:382a $cb $37
    dec  A                                             ;; 00:382c $3d
    cp   A, $01                                        ;; 00:382d $fe $01
    jr   Z, .jr_00_3833                                ;; 00:382f $28 $02
    ld   A, $02                                        ;; 00:3831 $3e $02
.jr_00_3833:
    add  A, A                                          ;; 00:3833 $87
    add  A, A                                          ;; 00:3834 $87
    pop  DE                                            ;; 00:3835 $d1
    pop  BC                                            ;; 00:3836 $c1
    add  A, D                                          ;; 00:3837 $82
    push AF                                            ;; 00:3838 $f5
.jr_00_3839:
    ldh  A, [rLY]                                      ;; 00:3839 $f0 $44
    cp   A, $90                                        ;; 00:383b $fe $90
    jr   C, .jr_00_3839                                ;; 00:383d $38 $fa
    cp   A, $98                                        ;; 00:383f $fe $98
    jr   NC, .jr_00_3839                               ;; 00:3841 $30 $f6
    pop  AF                                            ;; 00:3843 $f1
    ld   [HL], A                                       ;; 00:3844 $77
    ret                                                ;; 00:3845 $c9

call_00_3846:
    push BC                                            ;; 00:3846 $c5
    push DE                                            ;; 00:3847 $d5
    ld   A, [wC42C]                                    ;; 00:3848 $fa $2c $c4
    sra  C                                             ;; 00:384b $cb $29
    add  A, C                                          ;; 00:384d $81
    ld   C, A                                          ;; 00:384e $4f
    ld   A, [wC42D]                                    ;; 00:384f $fa $2d $c4
    sra  B                                             ;; 00:3852 $cb $28
    add  A, B                                          ;; 00:3854 $80
    ld   B, A                                          ;; 00:3855 $47
    or   A, C                                          ;; 00:3856 $b1
    and  A, $c0                                        ;; 00:3857 $e6 $c0
    jr   Z, .jr_00_385e                                ;; 00:3859 $28 $03
    xor  A, A                                          ;; 00:385b $af
    jr   .jr_00_3861                                   ;; 00:385c $18 $03
.jr_00_385e:
    call call_00_2636                                  ;; 00:385e $cd $36 $26
.jr_00_3861:
    and  A, $7f                                        ;; 00:3861 $e6 $7f
    cp   A, $40                                        ;; 00:3863 $fe $40
    jr   C, .jr_00_386d                                ;; 00:3865 $38 $06
    and  A, $1f                                        ;; 00:3867 $e6 $1f
    ld   E, A                                          ;; 00:3869 $5f
    ld   D, $c5                                        ;; 00:386a $16 $c5
    ld   A, [DE]                                       ;; 00:386c $1a
.jr_00_386d:
    ld   E, A                                          ;; 00:386d $5f
    ld   A, [wC43C]                                    ;; 00:386e $fa $3c $c4
    xor  A, E                                          ;; 00:3871 $ab
    cp   A, $20                                        ;; 00:3872 $fe $20
    jr   NC, jp_00_3889                                ;; 00:3874 $30 $13
    add  A, A                                          ;; 00:3876 $87
    add  A, A                                          ;; 00:3877 $87
    pop  DE                                            ;; 00:3878 $d1
    pop  BC                                            ;; 00:3879 $c1
    add  A, D                                          ;; 00:387a $82
    push AF                                            ;; 00:387b $f5
.jr_00_387c:
    ldh  A, [rLY]                                      ;; 00:387c $f0 $44
    cp   A, $90                                        ;; 00:387e $fe $90
    jr   C, .jr_00_387c                                ;; 00:3880 $38 $fa
    cp   A, $98                                        ;; 00:3882 $fe $98
    jr   NC, .jr_00_387c                               ;; 00:3884 $30 $f6
    pop  AF                                            ;; 00:3886 $f1
    ld   [HL], A                                       ;; 00:3887 $77
    ret                                                ;; 00:3888 $c9

jp_00_3889:
    pop  DE                                            ;; 00:3889 $d1
    pop  BC                                            ;; 00:388a $c1
    ret                                                ;; 00:388b $c9

jp_00_388c:
    ld   A, [wC468]                                    ;; 00:388c $fa $68 $c4
    ld   E, A                                          ;; 00:388f $5f
    ld   D, $c4                                        ;; 00:3890 $16 $c4
    ld_long_load A, hCurrentBank                       ;; 00:3892 $fa $88 $ff
    ld   [DE], A                                       ;; 00:3895 $12
    inc  E                                             ;; 00:3896 $1c
    ld   A, E                                          ;; 00:3897 $7b
    ld   [wC468], A                                    ;; 00:3898 $ea $68 $c4
.jr_00_389b:
    ld   A, [wC468]                                    ;; 00:389b $fa $68 $c4
    ld   E, A                                          ;; 00:389e $5f
    ld   D, $c4                                        ;; 00:389f $16 $c4
    dec  E                                             ;; 00:38a1 $1d
    ld   A, [DE]                                       ;; 00:38a2 $1a
    rst  switchBankSafe                                ;; 00:38a3 $ef
    ld   A, [HL+]                                      ;; 00:38a4 $2a
    ld   [wC443], A                                    ;; 00:38a5 $ea $43 $c4
    ld   B, A                                          ;; 00:38a8 $47
    cp   A, $ff                                        ;; 00:38a9 $fe $ff
    jr   Z, .jr_00_38da                                ;; 00:38ab $28 $2d
    ld   A, [HL+]                                      ;; 00:38ad $2a
    ld   [wC442], A                                    ;; 00:38ae $ea $42 $c4
    ld   C, A                                          ;; 00:38b1 $4f
    ld   A, B                                          ;; 00:38b2 $78
    cp   A, $f5                                        ;; 00:38b3 $fe $f5
    jr   Z, .jr_00_38bb                                ;; 00:38b5 $28 $04
    cp   A, $f6                                        ;; 00:38b7 $fe $f6
    jr   NZ, .jr_00_38bf                               ;; 00:38b9 $20 $04
.jr_00_38bb:
    ld   A, [HL+]                                      ;; 00:38bb $2a
    ld   [wC444], A                                    ;; 00:38bc $ea $44 $c4
.jr_00_38bf:
    push BC                                            ;; 00:38bf $c5
    push HL                                            ;; 00:38c0 $e5
    call call_00_3934                                  ;; 00:38c1 $cd $34 $39
    pop  HL                                            ;; 00:38c4 $e1
    pop  BC                                            ;; 00:38c5 $c1
    ld   A, B                                          ;; 00:38c6 $78
    cp   A, $f0                                        ;; 00:38c7 $fe $f0
    jr   C, .jr_00_3910                                ;; 00:38c9 $38 $45
    cp   A, $f7                                        ;; 00:38cb $fe $f7
    jr   NC, .jr_00_3910                               ;; 00:38cd $30 $41
    cp   A, $f0                                        ;; 00:38cf $fe $f0
    jr   NZ, .jr_00_389b                               ;; 00:38d1 $20 $c8
    ld   A, C                                          ;; 00:38d3 $79
    cp   A, $04                                        ;; 00:38d4 $fe $04
    jr   NC, .jr_00_3910                               ;; 00:38d6 $30 $38
    jr   .jr_00_389b                                   ;; 00:38d8 $18 $c1
.jr_00_38da:
    push HL                                            ;; 00:38da $e5
.jr_00_38db:
    ld   A, [wC43D]                                    ;; 00:38db $fa $3d $c4
    or   A, A                                          ;; 00:38de $b7
    jr   NZ, .jr_00_38ea                               ;; 00:38df $20 $09
    call call_00_2fbf                                  ;; 00:38e1 $cd $bf $2f
    ld   A, [wC436]                                    ;; 00:38e4 $fa $36 $c4
    call call_00_29e2                                  ;; 00:38e7 $cd $e2 $29
.jr_00_38ea:
    call call_00_344b                                  ;; 00:38ea $cd $4b $34
    call call_00_391d                                  ;; 00:38ed $cd $1d $39
    ld   A, [wC435]                                    ;; 00:38f0 $fa $35 $c4
    ld   C, A                                          ;; 00:38f3 $4f
    and  A, $07                                        ;; 00:38f4 $e6 $07
    jr   NZ, .jr_00_38db                               ;; 00:38f6 $20 $e3
    ld   A, [wC43D]                                    ;; 00:38f8 $fa $3d $c4
    or   A, A                                          ;; 00:38fb $b7
    jr   NZ, .jr_00_38db                               ;; 00:38fc $20 $dd
    ldh  A, [hFFC1]                                    ;; 00:38fe $f0 $c1
    ldh  [rSCY], A                                     ;; 00:3900 $e0 $42
    ldh  A, [hFFC2]                                    ;; 00:3902 $f0 $c2
    ldh  [rSCX], A                                     ;; 00:3904 $e0 $43
    ld   A, [wC440]                                    ;; 00:3906 $fa $40 $c4
    or   A, A                                          ;; 00:3909 $b7
    jr   NZ, .jr_00_38db                               ;; 00:390a $20 $cf
    call call_00_344b                                  ;; 00:390c $cd $4b $34
    pop  HL                                            ;; 00:390f $e1
.jr_00_3910:
    ld   A, [wC468]                                    ;; 00:3910 $fa $68 $c4
    dec  A                                             ;; 00:3913 $3d
    ld   [wC468], A                                    ;; 00:3914 $ea $68 $c4
    ld   E, A                                          ;; 00:3917 $5f
    ld   D, $c4                                        ;; 00:3918 $16 $c4
    ld   A, [DE]                                       ;; 00:391a $1a
    rst  switchBankSafe                                ;; 00:391b $ef
    ret                                                ;; 00:391c $c9

call_00_391d:
    ld   A, [wC43D]                                    ;; 00:391d $fa $3d $c4
    or   A, A                                          ;; 00:3920 $b7
    jp   NZ, jp_00_3c81                                ;; 00:3921 $c2 $81 $3c
    ld   A, [wC443]                                    ;; 00:3924 $fa $43 $c4
    ld   B, A                                          ;; 00:3927 $47
    ld   A, [wC442]                                    ;; 00:3928 $fa $42 $c4
    ld   C, A                                          ;; 00:392b $4f
    inc  A                                             ;; 00:392c $3c
    jr   NZ, call_00_3934                              ;; 00:392d $20 $05
    ld   A, B                                          ;; 00:392f $78
    inc  A                                             ;; 00:3930 $3c
    jp   Z, jp_00_3c93                                 ;; 00:3931 $ca $93 $3c

call_00_3934:
    ld   A, B                                          ;; 00:3934 $78
    cp   A, $04                                        ;; 00:3935 $fe $04
    jr   Z, .jr_00_39b4                                ;; 00:3937 $28 $7b
    cp   A, $05                                        ;; 00:3939 $fe $05
    jp   Z, .jp_00_39ae                                ;; 00:393b $ca $ae $39
    cp   A, $06                                        ;; 00:393e $fe $06
    jp   Z, .jp_00_39ae                                ;; 00:3940 $ca $ae $39
    cp   A, $07                                        ;; 00:3943 $fe $07
    jp   Z, jp_00_3e10                                 ;; 00:3945 $ca $10 $3e
    cp   A, $08                                        ;; 00:3948 $fe $08
    jp   Z, jp_00_3c93                                 ;; 00:394a $ca $93 $3c
    cp   A, $09                                        ;; 00:394d $fe $09
    jp   Z, call_00_3edf                               ;; 00:394f $ca $df $3e
    cp   A, $0a                                        ;; 00:3952 $fe $0a
    jp   Z, call_00_3f4e                               ;; 00:3954 $ca $4e $3f
    cp   A, $0b                                        ;; 00:3957 $fe $0b
    jp   Z, jp_00_3f28                                 ;; 00:3959 $ca $28 $3f
    cp   A, $0c                                        ;; 00:395c $fe $0c
    jr   Z, .jr_00_39bc                                ;; 00:395e $28 $5c
    cp   A, $0d                                        ;; 00:3960 $fe $0d
    jr   Z, .jr_00_39bc                                ;; 00:3962 $28 $58
    cp   A, $0e                                        ;; 00:3964 $fe $0e
    jp   Z, .jp_00_39ae                                ;; 00:3966 $ca $ae $39
    ld   A, B                                          ;; 00:3969 $78
    and  A, $f0                                        ;; 00:396a $e6 $f0
    cp   A, $f0                                        ;; 00:396c $fe $f0
    jp   NZ, .jp_00_3a60                               ;; 00:396e $c2 $60 $3a
    bit  3, B                                          ;; 00:3971 $cb $58
    jp   NZ, .jp_00_3b5b                               ;; 00:3973 $c2 $5b $3b
    ld   A, B                                          ;; 00:3976 $78
    and  A, $0f                                        ;; 00:3977 $e6 $0f
    jp   Z, .jp_00_3aa1                                ;; 00:3979 $ca $a1 $3a
    dec  A                                             ;; 00:397c $3d
    jp   Z, .jp_00_3a06                                ;; 00:397d $ca $06 $3a
    dec  A                                             ;; 00:3980 $3d
    jp   Z, .jp_00_3a18                                ;; 00:3981 $ca $18 $3a
    dec  A                                             ;; 00:3984 $3d
    jp   Z, .jp_00_3a24                                ;; 00:3985 $ca $24 $3a
    dec  A                                             ;; 00:3988 $3d
    jp   Z, .jp_00_3a33                                ;; 00:3989 $ca $33 $3a
    dec  A                                             ;; 00:398c $3d
    jr   Z, .jr_00_39e4                                ;; 00:398d $28 $55
    dec  A                                             ;; 00:398f $3d
    jr   Z, .jr_00_39c5                                ;; 00:3990 $28 $33
    dec  A                                             ;; 00:3992 $3d
    jr   Z, .jr_00_3998                                ;; 00:3993 $28 $03
    jp   jp_00_3c93                                    ;; 00:3995 $c3 $93 $3c
.jr_00_3998:
    ld   A, C                                          ;; 00:3998 $79
    and  A, $30                                        ;; 00:3999 $e6 $30
    ld   [wC43B], A                                    ;; 00:399b $ea $3b $c4
    ld   A, [wC436]                                    ;; 00:399e $fa $36 $c4
    call call_00_29e2                                  ;; 00:39a1 $cd $e2 $29
    call call_00_2f7f                                  ;; 00:39a4 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:39a7 $d7
    call call_00_1a97                                  ;; 00:39a8 $cd $97 $1a
    jp   jp_00_3c93                                    ;; 00:39ab $c3 $93 $3c
.jp_00_39ae:
    call call_00_1aec                                  ;; 00:39ae $cd $ec $1a
    jp   jp_00_3c93                                    ;; 00:39b1 $c3 $93 $3c
.jr_00_39b4:
    ld   E, C                                          ;; 00:39b4 $59
    ld   D, B                                          ;; 00:39b5 $50
    call call_00_01e9                                  ;; 00:39b6 $cd $e9 $01
    jp   jp_00_3c93                                    ;; 00:39b9 $c3 $93 $3c
.jr_00_39bc:
    call call_00_1d0d                                  ;; 00:39bc $cd $0d $1d
    call call_00_1ae7                                  ;; 00:39bf $cd $e7 $1a
    jp   jp_00_3c93                                    ;; 00:39c2 $c3 $93 $3c
.jr_00_39c5:
    ld   A, [wC444]                                    ;; 00:39c5 $fa $44 $c4
    swap A                                             ;; 00:39c8 $cb $37
    and  A, $f0                                        ;; 00:39ca $e6 $f0
    add  A, $05                                        ;; 00:39cc $c6 $05
    ld   L, A                                          ;; 00:39ce $6f
    ld   H, $c6                                        ;; 00:39cf $26 $c6
    ld   A, [HL]                                       ;; 00:39d1 $7e
    ld   B, A                                          ;; 00:39d2 $47
    and  A, $0f                                        ;; 00:39d3 $e6 $0f
    cp   A, $03                                        ;; 00:39d5 $fe $03
    jr   Z, .jr_00_39e4                                ;; 00:39d7 $28 $0b
    ld   A, B                                          ;; 00:39d9 $78
    and  A, $cf                                        ;; 00:39da $e6 $cf
    ld   B, A                                          ;; 00:39dc $47
    ld   A, C                                          ;; 00:39dd $79
    and  A, $03                                        ;; 00:39de $e6 $03
    swap A                                             ;; 00:39e0 $cb $37
    or   A, B                                          ;; 00:39e2 $b0
    ld   [HL], A                                       ;; 00:39e3 $77
.jr_00_39e4:
    ld   A, C                                          ;; 00:39e4 $79
    and  A, $f0                                        ;; 00:39e5 $e6 $f0
    swap A                                             ;; 00:39e7 $cb $37
    ld   B, A                                          ;; 00:39e9 $47
    ld   A, [wC444]                                    ;; 00:39ea $fa $44 $c4
    swap A                                             ;; 00:39ed $cb $37
    and  A, $f0                                        ;; 00:39ef $e6 $f0
    add  A, $04                                        ;; 00:39f1 $c6 $04
    ld   L, A                                          ;; 00:39f3 $6f
    ld   H, $c6                                        ;; 00:39f4 $26 $c6
    ld   [HL], B                                       ;; 00:39f6 $70
    inc  L                                             ;; 00:39f7 $2c
    ld   A, [HL]                                       ;; 00:39f8 $7e
    and  A, $3f                                        ;; 00:39f9 $e6 $3f
    ld   B, A                                          ;; 00:39fb $47
    ld   A, C                                          ;; 00:39fc $79
    and  A, $03                                        ;; 00:39fd $e6 $03
    rrca                                               ;; 00:39ff $0f
    rrca                                               ;; 00:3a00 $0f
    or   A, B                                          ;; 00:3a01 $b0
    ld   [HL], A                                       ;; 00:3a02 $77
    jp   jp_00_3c93                                    ;; 00:3a03 $c3 $93 $3c
.jp_00_3a06:
    ld   A, [wC435]                                    ;; 00:3a06 $fa $35 $c4
    or   A, A                                          ;; 00:3a09 $b7
    jp   NZ, jp_00_3ca0                                ;; 00:3a0a $c2 $a0 $3c
    ld   E, $08                                        ;; 00:3a0d $1e $08
    ld   A, C                                          ;; 00:3a0f $79
    and  A, $03                                        ;; 00:3a10 $e6 $03
    ld   [wC436], A                                    ;; 00:3a12 $ea $36 $c4
    jp   .jp_00_3a3c                                   ;; 00:3a15 $c3 $3c $3a
.jp_00_3a18:
    ld   A, [wC435]                                    ;; 00:3a18 $fa $35 $c4
    or   A, A                                          ;; 00:3a1b $b7
    jp   NZ, jp_00_3ca0                                ;; 00:3a1c $c2 $a0 $3c
    ld   E, $08                                        ;; 00:3a1f $1e $08
    jp   .jp_00_3a3c                                   ;; 00:3a21 $c3 $3c $3a
.jp_00_3a24:
    ld   A, [wC435]                                    ;; 00:3a24 $fa $35 $c4
    or   A, A                                          ;; 00:3a27 $b7
    jp   NZ, jp_00_3ca0                                ;; 00:3a28 $c2 $a0 $3c
    ld   A, C                                          ;; 00:3a2b $79
    and  A, $03                                        ;; 00:3a2c $e6 $03
    ld   [wC436], A                                    ;; 00:3a2e $ea $36 $c4
    jr   .jr_00_3a3a                                   ;; 00:3a31 $18 $07
.jp_00_3a33:
    ld   A, [wC435]                                    ;; 00:3a33 $fa $35 $c4
    or   A, A                                          ;; 00:3a36 $b7
    jp   NZ, jp_00_3ca0                                ;; 00:3a37 $c2 $a0 $3c
.jr_00_3a3a:
    ld   E, $00                                        ;; 00:3a3a $1e $00
.jp_00_3a3c:
    ld   A, [wC436]                                    ;; 00:3a3c $fa $36 $c4
    push DE                                            ;; 00:3a3f $d5
    push BC                                            ;; 00:3a40 $c5
    call call_00_29e2                                  ;; 00:3a41 $cd $e2 $29
    call call_00_2f7f                                  ;; 00:3a44 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3a47 $d7
    call call_00_1a97                                  ;; 00:3a48 $cd $97 $1a
    pop  BC                                            ;; 00:3a4b $c1
    pop  DE                                            ;; 00:3a4c $d1
    ld   A, C                                          ;; 00:3a4d $79
    and  A, $03                                        ;; 00:3a4e $e6 $03
    inc  A                                             ;; 00:3a50 $3c
    ld   B, A                                          ;; 00:3a51 $47
    ld   A, C                                          ;; 00:3a52 $79
    and  A, $f0                                        ;; 00:3a53 $e6 $f0
    jp   Z, jp_00_3c93                                 ;; 00:3a55 $ca $93 $3c
    or   A, B                                          ;; 00:3a58 $b0
    or   A, E                                          ;; 00:3a59 $b3
    ld   [wC435], A                                    ;; 00:3a5a $ea $35 $c4
    jp   call_00_3cab                                  ;; 00:3a5d $c3 $ab $3c
.jp_00_3a60:
    ld   A, B                                          ;; 00:3a60 $78
    cp   A, $04                                        ;; 00:3a61 $fe $04
    jp   NC, jp_00_3c93                                ;; 00:3a63 $d2 $93 $3c
    ld   D, B                                          ;; 00:3a66 $50
    ld   E, C                                          ;; 00:3a67 $59
    ld   A, [wC305]                                    ;; 00:3a68 $fa $05 $c3
    ld   [wC465], A                                    ;; 00:3a6b $ea $65 $c4
    and  A, $0f                                        ;; 00:3a6e $e6 $0f
    ld   [wC305], A                                    ;; 00:3a70 $ea $05 $c3
    call call_00_2ece                                  ;; 00:3a73 $cd $ce $2e
    rst  rst_00_0020                                   ;; 00:3a76 $e7
    ld   A, [wC305]                                    ;; 00:3a77 $fa $05 $c3
    and  A, $f0                                        ;; 00:3a7a $e6 $f0
    cp   A, $30                                        ;; 00:3a7c $fe $30
    jr   Z, .jr_00_3a96                                ;; 00:3a7e $28 $16
    or   A, A                                          ;; 00:3a80 $b7
    jp   NZ, jp_00_3c93                                ;; 00:3a81 $c2 $93 $3c
    ld   A, [wC305]                                    ;; 00:3a84 $fa $05 $c3
    and  A, $0f                                        ;; 00:3a87 $e6 $0f
    ld   B, A                                          ;; 00:3a89 $47
    ld   A, [wC465]                                    ;; 00:3a8a $fa $65 $c4
    and  A, $f0                                        ;; 00:3a8d $e6 $f0
    or   A, B                                          ;; 00:3a8f $b0
    ld   [wC305], A                                    ;; 00:3a90 $ea $05 $c3
    jp   jp_00_3c93                                    ;; 00:3a93 $c3 $93 $3c
.jr_00_3a96:
    ld   A, [wC305]                                    ;; 00:3a96 $fa $05 $c3
    and  A, $0f                                        ;; 00:3a99 $e6 $0f
    ld   [wC305], A                                    ;; 00:3a9b $ea $05 $c3
    jp   jp_00_3c93                                    ;; 00:3a9e $c3 $93 $3c
.jp_00_3aa1:
    ld   A, C                                          ;; 00:3aa1 $79
    cp   A, $04                                        ;; 00:3aa2 $fe $04
    jp   C, .jp_00_3b2e                                ;; 00:3aa4 $da $2e $3b
    cp   A, $04                                        ;; 00:3aa7 $fe $04
    jp   Z, jp_00_3ca8                                 ;; 00:3aa9 $ca $a8 $3c
    cp   A, $05                                        ;; 00:3aac $fe $05
    jp   Z, .jp_00_3b6f                                ;; 00:3aae $ca $6f $3b
    cp   A, $06                                        ;; 00:3ab1 $fe $06
    jp   Z, jp_00_3c93                                 ;; 00:3ab3 $ca $93 $3c
    cp   A, $07                                        ;; 00:3ab6 $fe $07
    jp   Z, jp_00_3c93                                 ;; 00:3ab8 $ca $93 $3c
    cp   A, $0c                                        ;; 00:3abb $fe $0c
    jp   Z, jp_00_3d98                                 ;; 00:3abd $ca $98 $3d
    cp   A, $0d                                        ;; 00:3ac0 $fe $0d
    jp   Z, .jp_00_3b1f                                ;; 00:3ac2 $ca $1f $3b
    cp   A, $0e                                        ;; 00:3ac5 $fe $0e
    jp   Z, jp_00_3e46                                 ;; 00:3ac7 $ca $46 $3e
    cp   A, $0f                                        ;; 00:3aca $fe $0f
    jp   Z, jp_00_3e9c                                 ;; 00:3acc $ca $9c $3e
    cp   A, $10                                        ;; 00:3acf $fe $10
    jp   Z, jp_00_3e3b                                 ;; 00:3ad1 $ca $3b $3e
    cp   A, $11                                        ;; 00:3ad4 $fe $11
    jp   Z, jp_00_3e96                                 ;; 00:3ad6 $ca $96 $3e
    cp   A, $12                                        ;; 00:3ad9 $fe $12
    jp   Z, jp_00_3f87                                 ;; 00:3adb $ca $87 $3f
    cp   A, $13                                        ;; 00:3ade $fe $13
    jp   Z, jp_00_3e2f                                 ;; 00:3ae0 $ca $2f $3e
    cp   A, $14                                        ;; 00:3ae3 $fe $14
    jp   Z, jp_00_3e35                                 ;; 00:3ae5 $ca $35 $3e
    cp   A, $15                                        ;; 00:3ae8 $fe $15
    jp   Z, .jp_00_3b04                                ;; 00:3aea $ca $04 $3b
    cp   A, $16                                        ;; 00:3aed $fe $16
    jp   Z, .jp_00_3b12                                ;; 00:3aef $ca $12 $3b
    cp   A, $17                                        ;; 00:3af2 $fe $17
    jp   Z, jp_00_3fbf                                 ;; 00:3af4 $ca $bf $3f
    cp   A, $18                                        ;; 00:3af7 $fe $18
    jp   Z, jp_00_3fd0                                 ;; 00:3af9 $ca $d0 $3f
    cp   A, $0c                                        ;; 00:3afc $fe $0c
    jp   C, .jp_00_3c3f                                ;; 00:3afe $da $3f $3c
    jp   jp_00_3c93                                    ;; 00:3b01 $c3 $93 $3c
.jp_00_3b04:
    ld   A, $01                                        ;; 00:3b04 $3e $01
    ld   [wC45B], A                                    ;; 00:3b06 $ea $5b $c4
    ld   A, [wC436]                                    ;; 00:3b09 $fa $36 $c4
    call call_00_29e2                                  ;; 00:3b0c $cd $e2 $29
    jp   jp_00_3c93                                    ;; 00:3b0f $c3 $93 $3c
.jp_00_3b12:
    xor  A, A                                          ;; 00:3b12 $af
    ld   [wC45B], A                                    ;; 00:3b13 $ea $5b $c4
    ld   A, [wC436]                                    ;; 00:3b16 $fa $36 $c4
    call call_00_29e2                                  ;; 00:3b19 $cd $e2 $29
    jp   jp_00_3c93                                    ;; 00:3b1c $c3 $93 $3c
.jp_00_3b1f:
    call call_00_2232                                  ;; 00:3b1f $cd $32 $22
    call call_00_1e6c                                  ;; 00:3b22 $cd $6c $1e
    call call_00_20db                                  ;; 00:3b25 $cd $db $20
    call call_00_32d8                                  ;; 00:3b28 $cd $d8 $32
    jp   jp_00_3c93                                    ;; 00:3b2b $c3 $93 $3c
.jp_00_3b2e:
    push AF                                            ;; 00:3b2e $f5
    xor  A, A                                          ;; 00:3b2f $af
    ld   [wC438], A                                    ;; 00:3b30 $ea $38 $c4
    ld   HL, $1a71                                     ;; 00:3b33 $21 $71 $1a
    call call_00_29b3                                  ;; 00:3b36 $cd $b3 $29
    call call_00_2636                                  ;; 00:3b39 $cd $36 $26
    ld   A, [BC]                                       ;; 00:3b3c $0a
    res  7, A                                          ;; 00:3b3d $cb $bf
    ld   [BC], A                                       ;; 00:3b3f $02
    pop  AF                                            ;; 00:3b40 $f1
    and  A, $03                                        ;; 00:3b41 $e6 $03
    inc  A                                             ;; 00:3b43 $3c
    ld   [wC43D], A                                    ;; 00:3b44 $ea $3d $c4
    dec  A                                             ;; 00:3b47 $3d
    call call_00_1fea                                  ;; 00:3b48 $cd $ea $1f
    ld   HL, $1a71                                     ;; 00:3b4b $21 $71 $1a
    call call_00_29b3                                  ;; 00:3b4e $cd $b3 $29
    call call_00_2636                                  ;; 00:3b51 $cd $36 $26
    ld   A, [BC]                                       ;; 00:3b54 $0a
    set  7, A                                          ;; 00:3b55 $cb $ff
    ld   [BC], A                                       ;; 00:3b57 $02
    jp   call_00_3cab                                  ;; 00:3b58 $c3 $ab $3c
.jp_00_3b5b:
    ld   A, B                                          ;; 00:3b5b $78
    and  A, $f7                                        ;; 00:3b5c $e6 $f7
    ld   B, A                                          ;; 00:3b5e $47
    call call_00_3934                                  ;; 00:3b5f $cd $34 $39
    ld   A, [wC444]                                    ;; 00:3b62 $fa $44 $c4
    ld   [wC442], A                                    ;; 00:3b65 $ea $42 $c4
    ld   A, [wC445]                                    ;; 00:3b68 $fa $45 $c4
    ld   [wC443], A                                    ;; 00:3b6b $ea $43 $c4
    ret                                                ;; 00:3b6e $c9
.jp_00_3b6f:
    ld   E, $1f                                        ;; 00:3b6f $1e $1f
    call call_00_0192                                  ;; 00:3b71 $cd $92 $01
    or   A, A                                          ;; 00:3b74 $b7
    jp   Z, jp_00_3c93                                 ;; 00:3b75 $ca $93 $3c
    ld   A, [wC436]                                    ;; 00:3b78 $fa $36 $c4
    add  A, A                                          ;; 00:3b7b $87
    add  A, $73                                        ;; 00:3b7c $c6 $73
    ld   L, A                                          ;; 00:3b7e $6f
    ld   H, $1a                                        ;; 00:3b7f $26 $1a
    call call_00_29b3                                  ;; 00:3b81 $cd $b3 $29
    ld   A, C                                          ;; 00:3b84 $79
    or   A, B                                          ;; 00:3b85 $b0
    and  A, $c0                                        ;; 00:3b86 $e6 $c0
    jp   NZ, jp_00_3c93                                ;; 00:3b88 $c2 $93 $3c
    call call_00_2636                                  ;; 00:3b8b $cd $36 $26
    bit  7, A                                          ;; 00:3b8e $cb $7f
    jp   NZ, jp_00_3c93                                ;; 00:3b90 $c2 $93 $3c
    call call_00_2946                                  ;; 00:3b93 $cd $46 $29
    and  A, $1f                                        ;; 00:3b96 $e6 $1f
    add  A, $20                                        ;; 00:3b98 $c6 $20
    ld   C, A                                          ;; 00:3b9a $4f
    ld   B, $c5                                        ;; 00:3b9b $06 $c5
    ld   A, [BC]                                       ;; 00:3b9d $0a
    bit  7, A                                          ;; 00:3b9e $cb $7f
    jr   Z, .jr_00_3bad                                ;; 00:3ba0 $28 $0b
    bit  6, A                                          ;; 00:3ba2 $cb $77
    jr   Z, .jr_00_3bbd                                ;; 00:3ba4 $28 $17
    bit  5, A                                          ;; 00:3ba6 $cb $6f
    jp   NZ, jp_00_3c93                                ;; 00:3ba8 $c2 $93 $3c
    jr   .jr_00_3bbd                                   ;; 00:3bab $18 $10
.jr_00_3bad:
    ld   C, A                                          ;; 00:3bad $4f
    ld   A, [wC434]                                    ;; 00:3bae $fa $34 $c4
    and  A, C                                          ;; 00:3bb1 $a1
    jp   NZ, jp_00_3c93                                ;; 00:3bb2 $c2 $93 $3c
    ld   A, C                                          ;; 00:3bb5 $79
    and  A, $03                                        ;; 00:3bb6 $e6 $03
    cp   A, $03                                        ;; 00:3bb8 $fe $03
    jp   Z, jp_00_3c93                                 ;; 00:3bba $ca $93 $3c
.jr_00_3bbd:
    ld   E, $1f                                        ;; 00:3bbd $1e $1f
    call call_00_0192                                  ;; 00:3bbf $cd $92 $01
    dec  A                                             ;; 00:3bc2 $3d
    and  A, $0f                                        ;; 00:3bc3 $e6 $0f
    add  A, A                                          ;; 00:3bc5 $87
    add  A, A                                          ;; 00:3bc6 $87
    add  A, $a9                                        ;; 00:3bc7 $c6 $a9
    ld   L, A                                          ;; 00:3bc9 $6f
    ld   H, $c2                                        ;; 00:3bca $26 $c2
    ld   A, [wC44B]                                    ;; 00:3bcc $fa $4b $c4
    ld   [HL+], A                                      ;; 00:3bcf $22
    ld   A, [wC43F]                                    ;; 00:3bd0 $fa $3f $c4
    ld   C, $00                                        ;; 00:3bd3 $0e $00
.jr_00_3bd5:
    rrca                                               ;; 00:3bd5 $0f
    jr   C, .jr_00_3bdb                                ;; 00:3bd6 $38 $03
    inc  C                                             ;; 00:3bd8 $0c
    jr   .jr_00_3bd5                                   ;; 00:3bd9 $18 $fa
.jr_00_3bdb:
    rrc  C                                             ;; 00:3bdb $cb $09
    rrc  C                                             ;; 00:3bdd $cb $09
    ld   A, [wC44C]                                    ;; 00:3bdf $fa $4c $c4
    or   A, C                                          ;; 00:3be2 $b1
    ld   [HL+], A                                      ;; 00:3be3 $22
    ld   A, [wC436]                                    ;; 00:3be4 $fa $36 $c4
    rrca                                               ;; 00:3be7 $0f
    rrca                                               ;; 00:3be8 $0f
    ld   B, A                                          ;; 00:3be9 $47
    ld   A, [wC42E]                                    ;; 00:3bea $fa $2e $c4
    swap A                                             ;; 00:3bed $cb $37
    and  A, $0f                                        ;; 00:3bef $e6 $0f
    ld   C, A                                          ;; 00:3bf1 $4f
    ld   A, [wC42C]                                    ;; 00:3bf2 $fa $2c $c4
    add  A, C                                          ;; 00:3bf5 $81
    or   A, B                                          ;; 00:3bf6 $b0
    ld   [HL+], A                                      ;; 00:3bf7 $22
    ld   A, [wC431]                                    ;; 00:3bf8 $fa $31 $c4
    rrca                                               ;; 00:3bfb $0f
    rrca                                               ;; 00:3bfc $0f
    ld   B, A                                          ;; 00:3bfd $47
    ld   A, [wC42F]                                    ;; 00:3bfe $fa $2f $c4
    swap A                                             ;; 00:3c01 $cb $37
    and  A, $0f                                        ;; 00:3c03 $e6 $0f
    ld   C, A                                          ;; 00:3c05 $4f
    ld   A, [wC42D]                                    ;; 00:3c06 $fa $2d $c4
    add  A, C                                          ;; 00:3c09 $81
    or   A, B                                          ;; 00:3c0a $b0
    ld   [HL], A                                       ;; 00:3c0b $77
    ld   A, $01                                        ;; 00:3c0c $3e $01
    ld   [wC43E], A                                    ;; 00:3c0e $ea $3e $c4
    ld   [wC43F], A                                    ;; 00:3c11 $ea $3f $c4
    xor  A, A                                          ;; 00:3c14 $af
    ld   [wC430], A                                    ;; 00:3c15 $ea $30 $c4
    ld   E, $1f                                        ;; 00:3c18 $1e $1f
    ld   A, $00                                        ;; 00:3c1a $3e $00
    call call_00_0195                                  ;; 00:3c1c $cd $95 $01
    call call_00_1ec2                                  ;; 00:3c1f $cd $c2 $1e
    ld   A, [wC436]                                    ;; 00:3c22 $fa $36 $c4
    call call_00_29e2                                  ;; 00:3c25 $cd $e2 $29
    ld   A, [wC436]                                    ;; 00:3c28 $fa $36 $c4
    ld   C, A                                          ;; 00:3c2b $4f
    ld   [wC442], A                                    ;; 00:3c2c $ea $42 $c4
    ld   A, $f0                                        ;; 00:3c2f $3e $f0
    ld   B, A                                          ;; 00:3c31 $47
    ld   [wC443], A                                    ;; 00:3c32 $ea $43 $c4
    call call_00_3934                                  ;; 00:3c35 $cd $34 $39
    call call_00_1d5c                                  ;; 00:3c38 $cd $5c $1d
    call call_00_32d8                                  ;; 00:3c3b $cd $d8 $32
    ret                                                ;; 00:3c3e $c9
.jp_00_3c3f:
    ld   A, [wC446]                                    ;; 00:3c3f $fa $46 $c4
    or   A, A                                          ;; 00:3c42 $b7
    jr   Z, .jr_00_3c4a                                ;; 00:3c43 $28 $05
    ld   L, A                                          ;; 00:3c45 $6f
    ld   H, $c6                                        ;; 00:3c46 $26 $c6
    set  7, [HL]                                       ;; 00:3c48 $cb $fe
.jr_00_3c4a:
    xor  A, A                                          ;; 00:3c4a $af
    ld   [wC446], A                                    ;; 00:3c4b $ea $46 $c4
    ld   A, $01                                        ;; 00:3c4e $3e $01
    ld   [wC430], A                                    ;; 00:3c50 $ea $30 $c4
    ld   A, C                                          ;; 00:3c53 $79
    and  A, $03                                        ;; 00:3c54 $e6 $03
    push AF                                            ;; 00:3c56 $f5
    inc  A                                             ;; 00:3c57 $3c
    ld   E, $1f                                        ;; 00:3c58 $1e $1f
    call call_00_0195                                  ;; 00:3c5a $cd $95 $01
    pop  BC                                            ;; 00:3c5d $c1
    ld   A, $04                                        ;; 00:3c5e $3e $04
    sub  A, B                                          ;; 00:3c60 $90
    ld   B, $80                                        ;; 00:3c61 $06 $80
.jr_00_3c63:
    rlc  B                                             ;; 00:3c63 $cb $00
    dec  A                                             ;; 00:3c65 $3d
    jr   NZ, .jr_00_3c63                               ;; 00:3c66 $20 $fb
    ld   A, B                                          ;; 00:3c68 $78
    ld   [wC43E], A                                    ;; 00:3c69 $ea $3e $c4
    ld   [wC43F], A                                    ;; 00:3c6c $ea $3f $c4
    ld   A, $01                                        ;; 00:3c6f $3e $01
    ld   [wC431], A                                    ;; 00:3c71 $ea $31 $c4
    ld   A, $80                                        ;; 00:3c74 $3e $80
    ld   [wC432], A                                    ;; 00:3c76 $ea $32 $c4
    ld   A, $40                                        ;; 00:3c79 $3e $40
    ld   [wC433], A                                    ;; 00:3c7b $ea $33 $c4
    jp   jp_00_3c93                                    ;; 00:3c7e $c3 $93 $3c

jp_00_3c81:
    call call_00_1fa4                                  ;; 00:3c81 $cd $a4 $1f
    ld   A, [wC443]                                    ;; 00:3c84 $fa $43 $c4
    cp   A, $f0                                        ;; 00:3c87 $fe $f0
    ret  NZ                                            ;; 00:3c89 $c0
    ld   A, [wC442]                                    ;; 00:3c8a $fa $42 $c4
    cp   A, $04                                        ;; 00:3c8d $fe $04
    ret  NC                                            ;; 00:3c8f $d0
    jp   call_00_3cab                                  ;; 00:3c90 $c3 $ab $3c

jp_00_3c93:
    call call_00_2f7f                                  ;; 00:3c93 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3c96 $d7
    call call_00_1a97                                  ;; 00:3c97 $cd $97 $1a
    call call_00_21ea                                  ;; 00:3c9a $cd $ea $21
    jp   call_00_3cab                                  ;; 00:3c9d $c3 $ab $3c

jp_00_3ca0:
    call call_00_2f7f                                  ;; 00:3ca0 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3ca3 $d7
    call call_00_1a97                                  ;; 00:3ca4 $cd $97 $1a
    ret                                                ;; 00:3ca7 $c9

jp_00_3ca8:
    jp   call_00_3cab                                  ;; 00:3ca8 $c3 $ab $3c

call_00_3cab:
    ld   A, $ff                                        ;; 00:3cab $3e $ff
    ld   [wC442], A                                    ;; 00:3cad $ea $42 $c4
    ld   [wC443], A                                    ;; 00:3cb0 $ea $43 $c4
    ret                                                ;; 00:3cb3 $c9

jp_00_3cb4:
    xor  A, A                                          ;; 00:3cb4 $af
    ld_long_store hFFC0, A                             ;; 00:3cb5 $ea $c0 $ff
    ld   A, $37                                        ;; 00:3cb8 $3e $37
    ld   [wC479], A                                    ;; 00:3cba $ea $79 $c4
    ldh  A, [hFFC2]                                    ;; 00:3cbd $f0 $c2
    ldh  [rSCX], A                                     ;; 00:3cbf $e0 $43
    ld   [wC47A], A                                    ;; 00:3cc1 $ea $7a $c4
    rst  waitForVBlank                                 ;; 00:3cc4 $d7
    call call_00_1a97                                  ;; 00:3cc5 $cd $97 $1a
    di                                                 ;; 00:3cc8 $f3
    ld   HL, wLCDCInterruptHandler                     ;; 00:3cc9 $21 $06 $c7
    ld   DE, wC473                                     ;; 00:3ccc $11 $73 $c4
    ld   BC, $3d7b                                     ;; 00:3ccf $01 $7b $3d
    ld   A, [HL]                                       ;; 00:3cd2 $7e
    ld   [DE], A                                       ;; 00:3cd3 $12
    ld   A, $c3                                        ;; 00:3cd4 $3e $c3
    ld   [HL], A                                       ;; 00:3cd6 $77
    inc  L                                             ;; 00:3cd7 $2c
    inc  E                                             ;; 00:3cd8 $1c
    ld   A, [HL]                                       ;; 00:3cd9 $7e
    ld   [DE], A                                       ;; 00:3cda $12
    ld   [HL], C                                       ;; 00:3cdb $71
    inc  L                                             ;; 00:3cdc $2c
    inc  E                                             ;; 00:3cdd $1c
    ld   A, [HL]                                       ;; 00:3cde $7e
    ld   [DE], A                                       ;; 00:3cdf $12
    ld   [HL], B                                       ;; 00:3ce0 $70
    inc  E                                             ;; 00:3ce1 $1c
    ldh  A, [rSTAT]                                    ;; 00:3ce2 $f0 $41
    ld   [DE], A                                       ;; 00:3ce4 $12
    ld   A, $c0                                        ;; 00:3ce5 $3e $c0
    ldh  [rSTAT], A                                    ;; 00:3ce7 $e0 $41
    ei                                                 ;; 00:3ce9 $fb
    ld   A, $3c                                        ;; 00:3cea $3e $3c
.jr_00_3cec:
    push AF                                            ;; 00:3cec $f5
    swap A                                             ;; 00:3ced $cb $37
    and  A, $0f                                        ;; 00:3cef $e6 $0f
    ld   L, A                                          ;; 00:3cf1 $6f
    ld   A, $03                                        ;; 00:3cf2 $3e $03
    sub  A, L                                          ;; 00:3cf4 $95
    ld   [wC478], A                                    ;; 00:3cf5 $ea $78 $c4
    ld   L, $40                                        ;; 00:3cf8 $2e $40
    dec  A                                             ;; 00:3cfa $3d
    jr   NZ, .jr_00_3d01                               ;; 00:3cfb $20 $04
    ld   L, $81                                        ;; 00:3cfd $2e $81
    jr   .jr_00_3d0d                                   ;; 00:3cff $18 $0c
.jr_00_3d01:
    dec  A                                             ;; 00:3d01 $3d
    jr   NZ, .jr_00_3d08                               ;; 00:3d02 $20 $04
    ld   L, $81                                        ;; 00:3d04 $2e $81
    jr   .jr_00_3d0d                                   ;; 00:3d06 $18 $05
.jr_00_3d08:
    dec  A                                             ;; 00:3d08 $3d
    jr   NZ, .jr_00_3d0d                               ;; 00:3d09 $20 $02
    ld   L, $d2                                        ;; 00:3d0b $2e $d2
.jr_00_3d0d:
    ld   A, L                                          ;; 00:3d0d $7d
    ldh  [rBGP], A                                     ;; 00:3d0e $e0 $47
    ldh  [rOBP0], A                                    ;; 00:3d10 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:3d12 $e0 $49
    ld   A, $40                                        ;; 00:3d14 $3e $40
    ld   [wC477], A                                    ;; 00:3d16 $ea $77 $c4
    ld   H, $19                                        ;; 00:3d19 $26 $19
    ld   A, [wC479]                                    ;; 00:3d1b $fa $79 $c4
    ld   L, A                                          ;; 00:3d1e $6f
    ld   DE, wC540                                     ;; 00:3d1f $11 $40 $c5
    ld   B, $90                                        ;; 00:3d22 $06 $90
.jr_00_3d24:
    ld   C, [HL]                                       ;; 00:3d24 $4e
    ld   A, [wC478]                                    ;; 00:3d25 $fa $78 $c4
    or   A, A                                          ;; 00:3d28 $b7
    jr   Z, .jr_00_3d30                                ;; 00:3d29 $28 $05
.jr_00_3d2b:
    sra  C                                             ;; 00:3d2b $cb $29
    dec  A                                             ;; 00:3d2d $3d
    jr   NZ, .jr_00_3d2b                               ;; 00:3d2e $20 $fb
.jr_00_3d30:
    ld   A, [wC47A]                                    ;; 00:3d30 $fa $7a $c4
    add  A, C                                          ;; 00:3d33 $81
    ld   [DE], A                                       ;; 00:3d34 $12
    inc  L                                             ;; 00:3d35 $2c
    ld   A, [HL]                                       ;; 00:3d36 $7e
    cp   A, $80                                        ;; 00:3d37 $fe $80
    jr   NZ, .jr_00_3d3d                               ;; 00:3d39 $20 $02
    ld   L, $37                                        ;; 00:3d3b $2e $37
.jr_00_3d3d:
    inc  E                                             ;; 00:3d3d $1c
    dec  B                                             ;; 00:3d3e $05
    jr   NZ, .jr_00_3d24                               ;; 00:3d3f $20 $e3
    call call_00_016e                                  ;; 00:3d41 $cd $6e $01
    ei                                                 ;; 00:3d44 $fb
.jr_00_3d45:
    ldh  A, [rLY]                                      ;; 00:3d45 $f0 $44
    cp   A, $90                                        ;; 00:3d47 $fe $90
    jr   NC, .jr_00_3d45                               ;; 00:3d49 $30 $fa
.jr_00_3d4b:
    ldh  A, [rLY]                                      ;; 00:3d4b $f0 $44
    cp   A, $90                                        ;; 00:3d4d $fe $90
    jr   C, .jr_00_3d4b                                ;; 00:3d4f $38 $fa
    ld   A, [wC479]                                    ;; 00:3d51 $fa $79 $c4
    ld   L, A                                          ;; 00:3d54 $6f
    ld   H, $19                                        ;; 00:3d55 $26 $19
    inc  L                                             ;; 00:3d57 $2c
    ld   A, [HL]                                       ;; 00:3d58 $7e
    cp   A, $80                                        ;; 00:3d59 $fe $80
    jr   NZ, .jr_00_3d5f                               ;; 00:3d5b $20 $02
    ld   L, $37                                        ;; 00:3d5d $2e $37
.jr_00_3d5f:
    ld   A, L                                          ;; 00:3d5f $7d
    ld   [wC479], A                                    ;; 00:3d60 $ea $79 $c4
    pop  AF                                            ;; 00:3d63 $f1
    dec  A                                             ;; 00:3d64 $3d
    jr   NZ, .jr_00_3cec                               ;; 00:3d65 $20 $85
    di                                                 ;; 00:3d67 $f3
    ld   HL, wC473                                     ;; 00:3d68 $21 $73 $c4
    ld   DE, wLCDCInterruptHandler                     ;; 00:3d6b $11 $06 $c7
    ld   A, [HL+]                                      ;; 00:3d6e $2a
    ld   [DE], A                                       ;; 00:3d6f $12
    inc  E                                             ;; 00:3d70 $1c
    ld   A, [HL+]                                      ;; 00:3d71 $2a
    ld   [DE], A                                       ;; 00:3d72 $12
    inc  E                                             ;; 00:3d73 $1c
    ld   A, [HL+]                                      ;; 00:3d74 $2a
    ld   [DE], A                                       ;; 00:3d75 $12
    ld   A, [HL]                                       ;; 00:3d76 $7e
    ldh  [rSTAT], A                                    ;; 00:3d77 $e0 $41
    ei                                                 ;; 00:3d79 $fb
    ret                                                ;; 00:3d7a $c9
    db   $f5, $e5, $f0, $44, $fe, $90, $30, $0e        ;; 00:3d7b ????????
    db   $fa, $77, $c4, $6f, $26, $c5, $7e, $e0        ;; 00:3d83 ????????
    db   $43, $2c, $7d, $ea, $77, $c4, $21, $45        ;; 00:3d8b ????????
    db   $ff, $34, $e1, $f1, $d9                       ;; 00:3d93 ?????

jp_00_3d98:
    ld   A, $27                                        ;; 00:3d98 $3e $27
    ldh  [hFFB2], A                                    ;; 00:3d9a $e0 $b2
    ldh  A, [hFFC2]                                    ;; 00:3d9c $f0 $c2
    ldh  [rSCX], A                                     ;; 00:3d9e $e0 $43
    ld   [wC473], A                                    ;; 00:3da0 $ea $73 $c4
    ldh  A, [hFFC1]                                    ;; 00:3da3 $f0 $c1
    ldh  [rSCY], A                                     ;; 00:3da5 $e0 $42
    ld   [wC474], A                                    ;; 00:3da7 $ea $74 $c4
    ld   HL, $3e07                                     ;; 00:3daa $21 $07 $3e
.jr_00_3dad:
    ld   A, [HL]                                       ;; 00:3dad $7e
    or   A, A                                          ;; 00:3dae $b7
    jp   Z, .jp_00_3dec                                ;; 00:3daf $ca $ec $3d
    push HL                                            ;; 00:3db2 $e5
    push AF                                            ;; 00:3db3 $f5
    ld   A, $0c                                        ;; 00:3db4 $3e $0c
    ld   DE, $100                                      ;; 00:3db6 $11 $00 $01
    call call_00_016b                                  ;; 00:3db9 $cd $6b $01
    ld   E, A                                          ;; 00:3dbc $5f
    pop  AF                                            ;; 00:3dbd $f1
    dec  E                                             ;; 00:3dbe $1d
    jr   Z, .jr_00_3dc3                                ;; 00:3dbf $28 $02
    cpl                                                ;; 00:3dc1 $2f
    inc  A                                             ;; 00:3dc2 $3c
.jr_00_3dc3:
    ld   C, A                                          ;; 00:3dc3 $4f
    ld   A, [HL]                                       ;; 00:3dc4 $7e
    push AF                                            ;; 00:3dc5 $f5
    ld   A, $0d                                        ;; 00:3dc6 $3e $0d
    ld   DE, $100                                      ;; 00:3dc8 $11 $00 $01
    call call_00_016b                                  ;; 00:3dcb $cd $6b $01
    ld   E, A                                          ;; 00:3dce $5f
    pop  AF                                            ;; 00:3dcf $f1
    dec  E                                             ;; 00:3dd0 $1d
    jr   Z, .jr_00_3dd5                                ;; 00:3dd1 $28 $02
    cpl                                                ;; 00:3dd3 $2f
    inc  A                                             ;; 00:3dd4 $3c
.jr_00_3dd5:
    ld   B, A                                          ;; 00:3dd5 $47
    call call_00_3df9                                  ;; 00:3dd6 $cd $f9 $3d
    call call_00_3e00                                  ;; 00:3dd9 $cd $00 $3e
    ld   B, $03                                        ;; 00:3ddc $06 $03
.jr_00_3dde:
    call call_00_2f7f                                  ;; 00:3dde $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3de1 $d7
    call call_00_1a97                                  ;; 00:3de2 $cd $97 $1a
    dec  B                                             ;; 00:3de5 $05
    jr   NZ, .jr_00_3dde                               ;; 00:3de6 $20 $f6
    pop  HL                                            ;; 00:3de8 $e1
    inc  HL                                            ;; 00:3de9 $23
    jr   .jr_00_3dad                                   ;; 00:3dea $18 $c1
.jp_00_3dec:
    ld   A, [wC473]                                    ;; 00:3dec $fa $73 $c4
    ldh  [rSCX], A                                     ;; 00:3def $e0 $43
    ld   A, [wC474]                                    ;; 00:3df1 $fa $74 $c4
    ldh  [rSCY], A                                     ;; 00:3df4 $e0 $42
    jp   call_00_3cab                                  ;; 00:3df6 $c3 $ab $3c

call_00_3df9:
    ld   A, [wC474]                                    ;; 00:3df9 $fa $74 $c4
    add  A, C                                          ;; 00:3dfc $81
    ldh  [rSCY], A                                     ;; 00:3dfd $e0 $42
    ret                                                ;; 00:3dff $c9

call_00_3e00:
    ld   A, [wC473]                                    ;; 00:3e00 $fa $73 $c4
    add  A, B                                          ;; 00:3e03 $80
    ldh  [rSCX], A                                     ;; 00:3e04 $e0 $43
    ret                                                ;; 00:3e06 $c9
    db   $02, $04, $08, $0c, $04, $0c, $06, $04        ;; 00:3e07 ????????
    db   $00                                           ;; 00:3e0f ?

jp_00_3e10:
    ld   A, C                                          ;; 00:3e10 $79
    bit  7, A                                          ;; 00:3e11 $cb $7f
    jr   NZ, .jr_00_3e28                               ;; 00:3e13 $20 $13
    bit  6, A                                          ;; 00:3e15 $cb $77
    jr   NZ, .jr_00_3e21                               ;; 00:3e17 $20 $08
    ldh  [hFFB0], A                                    ;; 00:3e19 $e0 $b0
    ld   [wC31A], A                                    ;; 00:3e1b $ea $1a $c3
    jp   jp_00_3c93                                    ;; 00:3e1e $c3 $93 $3c
.jr_00_3e21:
    sub  A, $40                                        ;; 00:3e21 $d6 $40
    ldh  [hFFB1], A                                    ;; 00:3e23 $e0 $b1
    jp   jp_00_3c93                                    ;; 00:3e25 $c3 $93 $3c
.jr_00_3e28:
    sub  A, $80                                        ;; 00:3e28 $d6 $80
    ldh  [hFFB2], A                                    ;; 00:3e2a $e0 $b2
    jp   jp_00_3c93                                    ;; 00:3e2c $c3 $93 $3c

jp_00_3e2f:
    call call_00_2cbe                                  ;; 00:3e2f $cd $be $2c
    jp   jp_00_3c93                                    ;; 00:3e32 $c3 $93 $3c

jp_00_3e35:
    call call_00_2b8a                                  ;; 00:3e35 $cd $8a $2b
    jp   jp_00_3c93                                    ;; 00:3e38 $c3 $93 $3c

jp_00_3e3b:
    ld   A, $01                                        ;; 00:3e3b $3e $01
    ld_long_store hFFC0, A                             ;; 00:3e3d $ea $c0 $ff
    call call_00_2d00                                  ;; 00:3e40 $cd $00 $2d
    jp   jp_00_3c93                                    ;; 00:3e43 $c3 $93 $3c

jp_00_3e46:
    call call_00_3e5b                                  ;; 00:3e46 $cd $5b $3e
    jp   jp_00_3c93                                    ;; 00:3e49 $c3 $93 $3c

call_00_3e4c:
    ld_long_load A, hFFC0                              ;; 00:3e4c $fa $c0 $ff
    cp   A, $01                                        ;; 00:3e4f $fe $01
    jp   Z, call_00_2d41                               ;; 00:3e51 $ca $41 $2d
    or   A, A                                          ;; 00:3e54 $b7
    jp   NZ, jp_00_3cb4                                ;; 00:3e55 $c2 $b4 $3c
    jp   call_00_3ea2                                  ;; 00:3e58 $c3 $a2 $3e

call_00_3e5b:
    ld   D, $03                                        ;; 00:3e5b $16 $03
.jr_00_3e5d:
    ldh  A, [rBGP]                                     ;; 00:3e5d $f0 $47
    ld   C, A                                          ;; 00:3e5f $4f
    ld   B, $00                                        ;; 00:3e60 $06 $00
    ld   E, $04                                        ;; 00:3e62 $1e $04
.jr_00_3e64:
    ld   A, C                                          ;; 00:3e64 $79
    and  A, $03                                        ;; 00:3e65 $e6 $03
    cp   A, D                                          ;; 00:3e67 $ba
    jr   NZ, .jr_00_3e6b                               ;; 00:3e68 $20 $01
    dec  A                                             ;; 00:3e6a $3d
.jr_00_3e6b:
    rra                                                ;; 00:3e6b $1f
    rr   B                                             ;; 00:3e6c $cb $18
    rra                                                ;; 00:3e6e $1f
    rr   B                                             ;; 00:3e6f $cb $18
    rrc  C                                             ;; 00:3e71 $cb $09
    rrc  C                                             ;; 00:3e73 $cb $09
    dec  E                                             ;; 00:3e75 $1d
    jr   NZ, .jr_00_3e64                               ;; 00:3e76 $20 $ec
    call call_00_2f7f                                  ;; 00:3e78 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3e7b $d7
    call call_00_1a97                                  ;; 00:3e7c $cd $97 $1a
    ld   A, B                                          ;; 00:3e7f $78
    ldh  [rBGP], A                                     ;; 00:3e80 $e0 $47
    ldh  [rOBP0], A                                    ;; 00:3e82 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:3e84 $e0 $49
    ld   E, $06                                        ;; 00:3e86 $1e $06
.jr_00_3e88:
    call call_00_2f7f                                  ;; 00:3e88 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3e8b $d7
    call call_00_1a97                                  ;; 00:3e8c $cd $97 $1a
    dec  E                                             ;; 00:3e8f $1d
    jr   NZ, .jr_00_3e88                               ;; 00:3e90 $20 $f6
    dec  D                                             ;; 00:3e92 $15
    jr   NZ, .jr_00_3e5d                               ;; 00:3e93 $20 $c8
    ret                                                ;; 00:3e95 $c9

jp_00_3e96:
    call call_00_2d41                                  ;; 00:3e96 $cd $41 $2d
    jp   jp_00_3c93                                    ;; 00:3e99 $c3 $93 $3c

jp_00_3e9c:
    call call_00_3ea2                                  ;; 00:3e9c $cd $a2 $3e
    jp   jp_00_3c93                                    ;; 00:3e9f $c3 $93 $3c

call_00_3ea2:
    ld   D, $01                                        ;; 00:3ea2 $16 $01
.jr_00_3ea4:
    ld   C, $d2                                        ;; 00:3ea4 $0e $d2
    ld   B, $00                                        ;; 00:3ea6 $06 $00
    ld   E, $04                                        ;; 00:3ea8 $1e $04
.jr_00_3eaa:
    ld   A, C                                          ;; 00:3eaa $79
    and  A, $03                                        ;; 00:3eab $e6 $03
    cp   A, D                                          ;; 00:3ead $ba
    jr   C, .jr_00_3eb1                                ;; 00:3eae $38 $01
    ld   A, D                                          ;; 00:3eb0 $7a
.jr_00_3eb1:
    rra                                                ;; 00:3eb1 $1f
    rr   B                                             ;; 00:3eb2 $cb $18
    rra                                                ;; 00:3eb4 $1f
    rr   B                                             ;; 00:3eb5 $cb $18
    rrc  C                                             ;; 00:3eb7 $cb $09
    rrc  C                                             ;; 00:3eb9 $cb $09
    dec  E                                             ;; 00:3ebb $1d
    jr   NZ, .jr_00_3eaa                               ;; 00:3ebc $20 $ec
    call call_00_2f7f                                  ;; 00:3ebe $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3ec1 $d7
    call call_00_1a97                                  ;; 00:3ec2 $cd $97 $1a
    ld   A, B                                          ;; 00:3ec5 $78
    ldh  [rBGP], A                                     ;; 00:3ec6 $e0 $47
    ldh  [rOBP0], A                                    ;; 00:3ec8 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:3eca $e0 $49
    ld   E, $06                                        ;; 00:3ecc $1e $06
.jr_00_3ece:
    call call_00_2f7f                                  ;; 00:3ece $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3ed1 $d7
    call call_00_1a97                                  ;; 00:3ed2 $cd $97 $1a
    dec  E                                             ;; 00:3ed5 $1d
    jr   NZ, .jr_00_3ece                               ;; 00:3ed6 $20 $f6
    inc  D                                             ;; 00:3ed8 $14
    ld   A, D                                          ;; 00:3ed9 $7a
    cp   A, $04                                        ;; 00:3eda $fe $04
    jr   NZ, .jr_00_3ea4                               ;; 00:3edc $20 $c6
    ret                                                ;; 00:3ede $c9

call_00_3edf:
    call call_00_3f78                                  ;; 00:3edf $cd $78 $3f
    jr   Z, jr_00_3ef6                                 ;; 00:3ee2 $28 $12
    ld   DE, $104                                      ;; 00:3ee4 $11 $04 $01
    call call_00_1b66                                  ;; 00:3ee7 $cd $66 $1b
    ld   DE, $105                                      ;; 00:3eea $11 $05 $01
    call call_00_1b66                                  ;; 00:3eed $cd $66 $1b
    call call_00_3cab                                  ;; 00:3ef0 $cd $ab $3c
    ld   A, $01                                        ;; 00:3ef3 $3e $01
    ret                                                ;; 00:3ef5 $c9

jr_00_3ef6:
    ld   A, C                                          ;; 00:3ef6 $79
    inc  A                                             ;; 00:3ef7 $3c
    jr   NZ, .jr_00_3f06                               ;; 00:3ef8 $20 $0c
    ld   DE, $103                                      ;; 00:3efa $11 $03 $01
    call call_00_1b66                                  ;; 00:3efd $cd $66 $1b
    call call_00_3cab                                  ;; 00:3f00 $cd $ab $3c
    ld   A, $01                                        ;; 00:3f03 $3e $01
    ret                                                ;; 00:3f05 $c9
.jr_00_3f06:
    ld   [HL], C                                       ;; 00:3f06 $71
    ld   A, C                                          ;; 00:3f07 $79
    ld   [wC71D], A                                    ;; 00:3f08 $ea $1d $c7
    inc  HL                                            ;; 00:3f0b $23
    push HL                                            ;; 00:3f0c $e5
    ld   A, $80                                        ;; 00:3f0d $3e $80
    add  A, C                                          ;; 00:3f0f $81
    ld   L, A                                          ;; 00:3f10 $6f
    ld   A, $7e                                        ;; 00:3f11 $3e $7e
    adc  A, $00                                        ;; 00:3f13 $ce $00
    ld   H, A                                          ;; 00:3f15 $67
    ld   A, $0c                                        ;; 00:3f16 $3e $0c
    call readFromBank                                  ;; 00:3f18 $cd $d2 $00
    pop  HL                                            ;; 00:3f1b $e1
    ld   [HL], A                                       ;; 00:3f1c $77
    ld   DE, $107                                      ;; 00:3f1d $11 $07 $01
    call call_00_1b66                                  ;; 00:3f20 $cd $66 $1b
    call call_00_3cab                                  ;; 00:3f23 $cd $ab $3c
    xor  A, A                                          ;; 00:3f26 $af
    ret                                                ;; 00:3f27 $c9

jp_00_3f28:
    call call_00_3f78                                  ;; 00:3f28 $cd $78 $3f
    jr   Z, jr_00_3ef6                                 ;; 00:3f2b $28 $c9
    ld   DE, $104                                      ;; 00:3f2d $11 $04 $01
    call call_00_1b66                                  ;; 00:3f30 $cd $66 $1b
.jr_00_3f33:
    ld   DE, $106                                      ;; 00:3f33 $11 $06 $01
    call call_00_1b66                                  ;; 00:3f36 $cd $66 $1b
    ld_long_load A, hFF8C                              ;; 00:3f39 $fa $8c $ff
    inc  A                                             ;; 00:3f3c $3c
    jr   Z, .jr_00_3f33                                ;; 00:3f3d $28 $f4
    add  A, A                                          ;; 00:3f3f $87
    add  A, $b7                                        ;; 00:3f40 $c6 $b7
    ld   L, A                                          ;; 00:3f42 $6f
    ld   A, $c2                                        ;; 00:3f43 $3e $c2
    adc  A, $00                                        ;; 00:3f45 $ce $00
    ld   H, A                                          ;; 00:3f47 $67
    ld   A, $ff                                        ;; 00:3f48 $3e $ff
    ld   [HL+], A                                      ;; 00:3f4a $22
    ld   [HL-], A                                      ;; 00:3f4b $32
    jr   jr_00_3ef6                                    ;; 00:3f4c $18 $a8

call_00_3f4e:
    ld   A, $80                                        ;; 00:3f4e $3e $80
    add  A, C                                          ;; 00:3f50 $81
    ld   L, A                                          ;; 00:3f51 $6f
    ld   H, $7f                                        ;; 00:3f52 $26 $7f
    ld   A, $0c                                        ;; 00:3f54 $3e $0c
    call readFromBank                                  ;; 00:3f56 $cd $d2 $00
    ld   B, A                                          ;; 00:3f59 $47
    ld   A, C                                          ;; 00:3f5a $79
    add  A, A                                          ;; 00:3f5b $87
    add  A, $da                                        ;; 00:3f5c $c6 $da
    ld   L, A                                          ;; 00:3f5e $6f
    ld   A, $c2                                        ;; 00:3f5f $3e $c2
    adc  A, $00                                        ;; 00:3f61 $ce $00
    ld   H, A                                          ;; 00:3f63 $67
    inc  [HL]                                          ;; 00:3f64 $34
    inc  HL                                            ;; 00:3f65 $23
    ld   [HL], B                                       ;; 00:3f66 $70
    ld   HL, wC2D9                                     ;; 00:3f67 $21 $d9 $c2
    inc  [HL]                                          ;; 00:3f6a $34
    ld   A, C                                          ;; 00:3f6b $79
    ld   [wC71D], A                                    ;; 00:3f6c $ea $1d $c7
    ld   DE, $102                                      ;; 00:3f6f $11 $02 $01
    call call_00_1b66                                  ;; 00:3f72 $cd $66 $1b
    jp   call_00_3cab                                  ;; 00:3f75 $c3 $ab $3c

call_00_3f78:
    ld   HL, wC2B9                                     ;; 00:3f78 $21 $b9 $c2
    ld   B, $10                                        ;; 00:3f7b $06 $10
.jr_00_3f7d:
    ld   A, [HL]                                       ;; 00:3f7d $7e
    inc  A                                             ;; 00:3f7e $3c
    ret  Z                                             ;; 00:3f7f $c8
    inc  HL                                            ;; 00:3f80 $23
    inc  HL                                            ;; 00:3f81 $23
    dec  B                                             ;; 00:3f82 $05
    jr   NZ, .jr_00_3f7d                               ;; 00:3f83 $20 $f8
    or   A, A                                          ;; 00:3f85 $b7
    ret                                                ;; 00:3f86 $c9

jp_00_3f87:
    ld   A, $18                                        ;; 00:3f87 $3e $18
    ldh  [hFFB2], A                                    ;; 00:3f89 $e0 $b2
    ld   B, $03                                        ;; 00:3f8b $06 $03
.jr_00_3f8d:
    ldh  A, [rBGP]                                     ;; 00:3f8d $f0 $47
    xor  A, $ff                                        ;; 00:3f8f $ee $ff
    ldh  [rBGP], A                                     ;; 00:3f91 $e0 $47
    ldh  [rOBP0], A                                    ;; 00:3f93 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:3f95 $e0 $49
    ld   C, $04                                        ;; 00:3f97 $0e $04
.jr_00_3f99:
    call call_00_2f7f                                  ;; 00:3f99 $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3f9c $d7
    call call_00_1a97                                  ;; 00:3f9d $cd $97 $1a
    dec  C                                             ;; 00:3fa0 $0d
    jr   NZ, .jr_00_3f99                               ;; 00:3fa1 $20 $f6
    ldh  A, [rBGP]                                     ;; 00:3fa3 $f0 $47
    xor  A, $ff                                        ;; 00:3fa5 $ee $ff
    ldh  [rBGP], A                                     ;; 00:3fa7 $e0 $47
    ldh  [rOBP0], A                                    ;; 00:3fa9 $e0 $48
    ldh  [rOBP1], A                                    ;; 00:3fab $e0 $49
    ld   C, $06                                        ;; 00:3fad $0e $06
.jr_00_3faf:
    call call_00_2f7f                                  ;; 00:3faf $cd $7f $2f
    rst  waitForVBlank                                 ;; 00:3fb2 $d7
    call call_00_1a97                                  ;; 00:3fb3 $cd $97 $1a
    dec  C                                             ;; 00:3fb6 $0d
    jr   NZ, .jr_00_3faf                               ;; 00:3fb7 $20 $f6
    dec  B                                             ;; 00:3fb9 $05
    jr   NZ, .jr_00_3f8d                               ;; 00:3fba $20 $d1
    jp   jp_00_3c93                                    ;; 00:3fbc $c3 $93 $3c

jp_00_3fbf:
    ld   HL, wC2DA                                     ;; 00:3fbf $21 $da $c2
    ld   B, $1c                                        ;; 00:3fc2 $06 $1c
    xor  A, A                                          ;; 00:3fc4 $af
.jr_00_3fc5:
    ld   [HL+], A                                      ;; 00:3fc5 $22
    dec  B                                             ;; 00:3fc6 $05
    jr   NZ, .jr_00_3fc5                               ;; 00:3fc7 $20 $fc
    xor  A, A                                          ;; 00:3fc9 $af
    ld   [wC2D9], A                                    ;; 00:3fca $ea $d9 $c2
    jp   jp_00_3c93                                    ;; 00:3fcd $c3 $93 $3c

jp_00_3fd0:
    ld   A, $0c                                        ;; 00:3fd0 $3e $0c
    rst  switchBankSafe                                ;; 00:3fd2 $ef
    ld   DE, $7f80                                     ;; 00:3fd3 $11 $80 $7f
    ld   HL, wC2DA                                     ;; 00:3fd6 $21 $da $c2
    ld   B, $08                                        ;; 00:3fd9 $06 $08
.jr_00_3fdb:
    ld   A, [HL]                                       ;; 00:3fdb $7e
    or   A, $09                                        ;; 00:3fdc $f6 $09
    ld   [HL+], A                                      ;; 00:3fde $22
    ld   A, [DE]                                       ;; 00:3fdf $1a
    inc  DE                                            ;; 00:3fe0 $13
    ld   [HL+], A                                      ;; 00:3fe1 $22
    dec  B                                             ;; 00:3fe2 $05
    jr   NZ, .jr_00_3fdb                               ;; 00:3fe3 $20 $f6
    ld   B, $06                                        ;; 00:3fe5 $06 $06
.jr_00_3fe7:
    ld   A, [HL]                                       ;; 00:3fe7 $7e
    or   A, $01                                        ;; 00:3fe8 $f6 $01
    ld   [HL+], A                                      ;; 00:3fea $22
    ld   A, [DE]                                       ;; 00:3feb $1a
    inc  DE                                            ;; 00:3fec $13
    ld   [HL+], A                                      ;; 00:3fed $22
    dec  B                                             ;; 00:3fee $05
    jr   NZ, .jr_00_3fe7                               ;; 00:3fef $20 $f6
    ld   A, $4e                                        ;; 00:3ff1 $3e $4e
    ld   [wC2D9], A                                    ;; 00:3ff3 $ea $d9 $c2
    jp   jp_00_3c93                                    ;; 00:3ff6 $c3 $93 $3c
