;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank0e", ROMX[$4000], BANK[$0e]

call_0e_4000:
    jr   jr_0e_4006                                    ;; 0e:4000 $18 $04
    db   $00                                           ;; 0e:4002 ?

call_0e_4003:
    jr   call_0e_4048                                  ;; 0e:4003 $18 $43
    db   $00                                           ;; 0e:4005 ?

jr_0e_4006:
    push AF                                            ;; 0e:4006 $f5
    push BC                                            ;; 0e:4007 $c5
    push DE                                            ;; 0e:4008 $d5
    push HL                                            ;; 0e:4009 $e5
    ldh  A, [hFFB1]                                    ;; 0e:400a $f0 $b1
    or   A, A                                          ;; 0e:400c $b7
    jr   Z, .jr_0e_401e                                ;; 0e:400d $28 $0f
    ldh  A, [hFFB9]                                    ;; 0e:400f $f0 $b9
    or   A, A                                          ;; 0e:4011 $b7
    jr   Z, .jr_0e_4019                                ;; 0e:4012 $28 $05
    call call_0e_410d                                  ;; 0e:4014 $cd $0d $41
    jr   .jr_0e_403d                                   ;; 0e:4017 $18 $24
.jr_0e_4019:
    call call_0e_40eb                                  ;; 0e:4019 $cd $eb $40
    jr   .jr_0e_403d                                   ;; 0e:401c $18 $1f
.jr_0e_401e:
    ldh  A, [hFFB9]                                    ;; 0e:401e $f0 $b9
    or   A, A                                          ;; 0e:4020 $b7
    jr   Z, .jr_0e_4028                                ;; 0e:4021 $28 $05
    call call_0e_411d                                  ;; 0e:4023 $cd $1d $41
    jr   .jr_0e_403d                                   ;; 0e:4026 $18 $15
.jr_0e_4028:
    ld   A, [wCB1A]                                    ;; 0e:4028 $fa $1a $cb
    or   A, A                                          ;; 0e:402b $b7
    jr   NZ, .jr_0e_4037                               ;; 0e:402c $20 $09
    ldh  A, [hFFB3]                                    ;; 0e:402e $f0 $b3
    ld   B, A                                          ;; 0e:4030 $47
    ldh  A, [hFFB0]                                    ;; 0e:4031 $f0 $b0
    cp   A, B                                          ;; 0e:4033 $b8
    call NZ, call_0e_409b                              ;; 0e:4034 $c4 $9b $40
.jr_0e_4037:
    ldh  A, [hFFB2]                                    ;; 0e:4037 $f0 $b2
    or   A, A                                          ;; 0e:4039 $b7
    call NZ, call_0e_4920                              ;; 0e:403a $c4 $20 $49
.jr_0e_403d:
    call call_0e_4251                                  ;; 0e:403d $cd $51 $42
    call call_0e_4949                                  ;; 0e:4040 $cd $49 $49
    pop  HL                                            ;; 0e:4043 $e1
    pop  DE                                            ;; 0e:4044 $d1
    pop  BC                                            ;; 0e:4045 $c1
    pop  AF                                            ;; 0e:4046 $f1
    ret                                                ;; 0e:4047 $c9

call_0e_4048:
    ld   A, $ff                                        ;; 0e:4048 $3e $ff
    ldh  [rNR52], A                                    ;; 0e:404a $e0 $26
    call call_0e_4081                                  ;; 0e:404c $cd $81 $40
    ld   A, $ff                                        ;; 0e:404f $3e $ff
    ld   [wCB13], A                                    ;; 0e:4051 $ea $13 $cb
    ld   [wCB2B], A                                    ;; 0e:4054 $ea $2b $cb
    ld   [wCB43], A                                    ;; 0e:4057 $ea $43 $cb
    ld   [wCB5B], A                                    ;; 0e:405a $ea $5b $cb
    ld   A, $10                                        ;; 0e:405d $3e $10
    ldh  [rNR12], A                                    ;; 0e:405f $e0 $12
    ldh  [rNR22], A                                    ;; 0e:4061 $e0 $17
    ldh  [rNR32], A                                    ;; 0e:4063 $e0 $1c
    ldh  [rNR42], A                                    ;; 0e:4065 $e0 $21
    call call_0e_40ce                                  ;; 0e:4067 $cd $ce $40
    xor  A, A                                          ;; 0e:406a $af
    ld   [wCB1A], A                                    ;; 0e:406b $ea $1a $cb
    ld   A, $77                                        ;; 0e:406e $3e $77
    ldh  [rNR50], A                                    ;; 0e:4070 $e0 $24
    ld   A, $ff                                        ;; 0e:4072 $3e $ff
    ldh  [rNR51], A                                    ;; 0e:4074 $e0 $25
    ld   HL, hFFB0                                     ;; 0e:4076 $21 $b0 $ff
    ld   C, $10                                        ;; 0e:4079 $0e $10
    xor  A, A                                          ;; 0e:407b $af
.jr_0e_407c:
    ld   [HL+], A                                      ;; 0e:407c $22
    dec  C                                             ;; 0e:407d $0d
    jr   NZ, .jr_0e_407c                               ;; 0e:407e $20 $fc
    ret                                                ;; 0e:4080 $c9

call_0e_4081:
    ld   HL, wCB00                                     ;; 0e:4081 $21 $00 $cb
    ld   A, $ff                                        ;; 0e:4084 $3e $ff
    ld   [HL+], A                                      ;; 0e:4086 $22
    ld   A, $3c                                        ;; 0e:4087 $3e $3c
    ld   [HL+], A                                      ;; 0e:4089 $22
    ld   B, $03                                        ;; 0e:408a $06 $03
.jr_0e_408c:
    ld   DE, data_0e_4175                              ;; 0e:408c $11 $75 $41
    ld   C, $18                                        ;; 0e:408f $0e $18
.jr_0e_4091:
    ld   A, [DE]                                       ;; 0e:4091 $1a
    ld   [HL+], A                                      ;; 0e:4092 $22
    inc  E                                             ;; 0e:4093 $1c
    dec  C                                             ;; 0e:4094 $0d
    jr   NZ, .jr_0e_4091                               ;; 0e:4095 $20 $fa
    dec  B                                             ;; 0e:4097 $05
    jr   NZ, .jr_0e_408c                               ;; 0e:4098 $20 $f2
    ret                                                ;; 0e:409a $c9

call_0e_409b:
    ldh  [hFFB3], A                                    ;; 0e:409b $e0 $b3
    or   A, A                                          ;; 0e:409d $b7
    jr   NZ, call_0e_40a4                              ;; 0e:409e $20 $04
    call call_0e_4048                                  ;; 0e:40a0 $cd $48 $40
    ret                                                ;; 0e:40a3 $c9

call_0e_40a4:
    push AF                                            ;; 0e:40a4 $f5
    call call_0e_4081                                  ;; 0e:40a5 $cd $81 $40
    pop  AF                                            ;; 0e:40a8 $f1
    dec  A                                             ;; 0e:40a9 $3d
    ld   E, A                                          ;; 0e:40aa $5f
    add  A, A                                          ;; 0e:40ab $87
    add  A, E                                          ;; 0e:40ac $83
    add  A, A                                          ;; 0e:40ad $87
    ld   HL, data_0e_49f5                              ;; 0e:40ae $21 $f5 $49
    ld   E, A                                          ;; 0e:40b1 $5f
    ld   D, $00                                        ;; 0e:40b2 $16 $00
    add  HL, DE                                        ;; 0e:40b4 $19
    ld   A, [HL+]                                      ;; 0e:40b5 $2a
    ld   [wCB04], A                                    ;; 0e:40b6 $ea $04 $cb
    ld   A, [HL+]                                      ;; 0e:40b9 $2a
    ld   [wCB05], A                                    ;; 0e:40ba $ea $05 $cb
    ld   A, [HL+]                                      ;; 0e:40bd $2a
    ld   [wCB1C], A                                    ;; 0e:40be $ea $1c $cb
    ld   A, [HL+]                                      ;; 0e:40c1 $2a
    ld   [wCB1D], A                                    ;; 0e:40c2 $ea $1d $cb
    ld   A, [HL+]                                      ;; 0e:40c5 $2a
    ld   [wCB34], A                                    ;; 0e:40c6 $ea $34 $cb
    ld   A, [HL+]                                      ;; 0e:40c9 $2a
    ld   [wCB35], A                                    ;; 0e:40ca $ea $35 $cb
    ret                                                ;; 0e:40cd $c9

call_0e_40ce:
    xor  A, A                                          ;; 0e:40ce $af
    ldh  [rNR10], A                                    ;; 0e:40cf $e0 $10
    ld   A, $ff                                        ;; 0e:40d1 $3e $ff
    ldh  [rNR13], A                                    ;; 0e:40d3 $e0 $13
    ldh  [rNR23], A                                    ;; 0e:40d5 $e0 $18
    ldh  [rNR31], A                                    ;; 0e:40d7 $e0 $1b
    ldh  [rNR33], A                                    ;; 0e:40d9 $e0 $1d
    ld   A, $07                                        ;; 0e:40db $3e $07
    ldh  [rNR14], A                                    ;; 0e:40dd $e0 $14
    ldh  [rNR24], A                                    ;; 0e:40df $e0 $19
    ldh  [rNR34], A                                    ;; 0e:40e1 $e0 $1e
    xor  A, A                                          ;; 0e:40e3 $af
    ldh  [rNR42], A                                    ;; 0e:40e4 $e0 $21
    ld   A, $80                                        ;; 0e:40e6 $3e $80
    ldh  [rNR44], A                                    ;; 0e:40e8 $e0 $23
    ret                                                ;; 0e:40ea $c9

call_0e_40eb:
    call call_0e_40ce                                  ;; 0e:40eb $cd $ce $40
    xor  A, A                                          ;; 0e:40ee $af
    ld   [wCB1A], A                                    ;; 0e:40ef $ea $1a $cb
    ld   [wCB4A], A                                    ;; 0e:40f2 $ea $4a $cb
    ld   C, $62                                        ;; 0e:40f5 $0e $62
    ld   HL, wCB00                                     ;; 0e:40f7 $21 $00 $cb
    ld   DE, wCB62                                     ;; 0e:40fa $11 $62 $cb
.jr_0e_40fd:
    ld   A, [HL+]                                      ;; 0e:40fd $2a
    ld   [DE], A                                       ;; 0e:40fe $12
    inc  E                                             ;; 0e:40ff $1c
    dec  C                                             ;; 0e:4100 $0d
    jr   NZ, .jr_0e_40fd                               ;; 0e:4101 $20 $fa
    ldh  A, [hFFB1]                                    ;; 0e:4103 $f0 $b1
    call call_0e_40a4                                  ;; 0e:4105 $cd $a4 $40
    ld   A, $01                                        ;; 0e:4108 $3e $01
    ldh  [hFFB9], A                                    ;; 0e:410a $e0 $b9
    ret                                                ;; 0e:410c $c9

call_0e_410d:
    ld   A, [wCB13]                                    ;; 0e:410d $fa $13 $cb
    ld   E, A                                          ;; 0e:4110 $5f
    ld   A, [wCB2B]                                    ;; 0e:4111 $fa $2b $cb
    ld   D, A                                          ;; 0e:4114 $57
    ld   A, [wCB43]                                    ;; 0e:4115 $fa $43 $cb
    and  A, D                                          ;; 0e:4118 $a2
    and  A, E                                          ;; 0e:4119 $a3
    cp   A, $ff                                        ;; 0e:411a $fe $ff
    ret  NZ                                            ;; 0e:411c $c0

call_0e_411d:
    call call_0e_40ce                                  ;; 0e:411d $cd $ce $40
    ld   C, $62                                        ;; 0e:4120 $0e $62
    ld   HL, wCB00                                     ;; 0e:4122 $21 $00 $cb
    ld   DE, wCB62                                     ;; 0e:4125 $11 $62 $cb
.jr_0e_4128:
    ld   A, [DE]                                       ;; 0e:4128 $1a
    ld   [HL+], A                                      ;; 0e:4129 $22
    inc  E                                             ;; 0e:412a $1c
    dec  C                                             ;; 0e:412b $0d
    jr   NZ, .jr_0e_4128                               ;; 0e:412c $20 $fa
    xor  A, A                                          ;; 0e:412e $af
    ldh  [hFFB1], A                                    ;; 0e:412f $e0 $b1
    ldh  [hFFB9], A                                    ;; 0e:4131 $e0 $b9
    ld   A, [wCB0C]                                    ;; 0e:4133 $fa $0c $cb
    ldh  [rNR21], A                                    ;; 0e:4136 $e0 $16
    ld   A, [wCB10]                                    ;; 0e:4138 $fa $10 $cb
    ldh  [rNR22], A                                    ;; 0e:413b $e0 $17
    ld   A, $87                                        ;; 0e:413d $3e $87
    ldh  [rNR24], A                                    ;; 0e:413f $e0 $19
    ldh  A, [hFFBA]                                    ;; 0e:4141 $f0 $ba
    ld   L, A                                          ;; 0e:4143 $6f
    ldh  A, [hFFBB]                                    ;; 0e:4144 $f0 $bb
    ld   H, A                                          ;; 0e:4146 $67
    call call_0e_4791                                  ;; 0e:4147 $cd $91 $47

call_0e_414a:
    xor  A, A                                          ;; 0e:414a $af
    ldh  [rNR10], A                                    ;; 0e:414b $e0 $10
    ld   A, [wCB24]                                    ;; 0e:414d $fa $24 $cb
    ldh  [rNR11], A                                    ;; 0e:4150 $e0 $11
    ld   A, [wCB28]                                    ;; 0e:4152 $fa $28 $cb
    ldh  [rNR12], A                                    ;; 0e:4155 $e0 $12
    ld   A, $ff                                        ;; 0e:4157 $3e $ff
    ldh  [rNR13], A                                    ;; 0e:4159 $e0 $13
    ld   A, $87                                        ;; 0e:415b $3e $87
    ldh  [rNR14], A                                    ;; 0e:415d $e0 $14
    ld   A, [wCB2A]                                    ;; 0e:415f $fa $2a $cb
    ld   E, A                                          ;; 0e:4162 $5f
    ldh  A, [rNR51]                                    ;; 0e:4163 $f0 $25
    and  A, $ee                                        ;; 0e:4165 $e6 $ee
    or   A, E                                          ;; 0e:4167 $b3
    ldh  [rNR51], A                                    ;; 0e:4168 $e0 $25
    ret                                                ;; 0e:416a $c9

call_0e_416b:
    xor  A, A                                          ;; 0e:416b $af
    ldh  [rNR42], A                                    ;; 0e:416c $e0 $21
    ldh  [rNR43], A                                    ;; 0e:416e $e0 $22
    ld   A, $80                                        ;; 0e:4170 $3e $80
    ldh  [rNR44], A                                    ;; 0e:4172 $e0 $23
    ret                                                ;; 0e:4174 $c9

data_0e_4175:
    db   $00, $01, $00, $00, $14, $8c, $41, $8c        ;; 0e:4175 ........
    db   $41, $60, $00, $00, $00, $00, $10, $0f        ;; 0e:417d ........
    db   $00, $00, $01, $95, $41, $95, $41, $0a        ;; 0e:4185 ........
    db   $00, $02, $01, $02, $00, $00, $8e, $41        ;; 0e:418d w.w.w...
    db   $ff, $f0, $00, $95, $41                       ;; 0e:4195 ?????

data_0e_419a:
    db   $2c, $80, $9d, $80, $07, $81, $6b, $81        ;; 0e:419a ????????
    db   $c9, $81, $23, $82, $77, $82, $c7, $82        ;; 0e:41a2 ????????
    db   $12, $83, $58, $83, $9b, $83, $da, $83        ;; 0e:41aa ????????
    db   $16, $84                                      ;; 0e:41b2 w.
    dw   $844e                                         ;; 0e:41b4 wW
    dw   $8483                                         ;; 0e:41b6 wW
    db   $b5, $84                                      ;; 0e:41b8 ??
    dw   $84e5                                         ;; 0e:41ba wW
    db   $11, $85                                      ;; 0e:41bc w.
    dw   $853b                                         ;; 0e:41be wW
    dw   $8563                                         ;; 0e:41c0 wW
    dw   $8589                                         ;; 0e:41c2 wW
    dw   $85ac                                         ;; 0e:41c4 wW
    dw   $85ce                                         ;; 0e:41c6 wW
    dw   $85ed                                         ;; 0e:41c8 wW
    dw   $860b                                         ;; 0e:41ca wW
    dw   $8627                                         ;; 0e:41cc wW
    dw   $8642                                         ;; 0e:41ce wW
    dw   $865b                                         ;; 0e:41d0 wW
    dw   $8672                                         ;; 0e:41d2 wW
    dw   $8689                                         ;; 0e:41d4 wW
    dw   $869e                                         ;; 0e:41d6 wW
    dw   $86b2                                         ;; 0e:41d8 wW
    dw   $86c4                                         ;; 0e:41da wW
    dw   $86d6                                         ;; 0e:41dc wW
    dw   $86e7                                         ;; 0e:41de wW
    dw   $86f7                                         ;; 0e:41e0 wW
    dw   $8706                                         ;; 0e:41e2 wW
    dw   $8714                                         ;; 0e:41e4 wW
    dw   $8721                                         ;; 0e:41e6 wW
    dw   $872d                                         ;; 0e:41e8 wW
    dw   $8739                                         ;; 0e:41ea wW
    dw   $8744                                         ;; 0e:41ec wW
    dw   $874f                                         ;; 0e:41ee wW
    dw   $8759                                         ;; 0e:41f0 wW
    dw   $8762                                         ;; 0e:41f2 wW
    dw   $876b                                         ;; 0e:41f4 wW
    dw   $8773                                         ;; 0e:41f6 wW
    dw   $877b                                         ;; 0e:41f8 wW
    dw   $8783                                         ;; 0e:41fa wW
    db   $8a, $87                                      ;; 0e:41fc ??
    dw   $8790                                         ;; 0e:41fe wW
    db   $97, $87, $9d, $87, $a2, $87, $a7, $87        ;; 0e:4200 ????????
    db   $ac, $87, $b1, $87, $b6, $87, $ba, $87        ;; 0e:4208 ????????
    db   $be, $87, $c1, $87, $c5, $87, $c8, $87        ;; 0e:4210 ????????
    db   $cb, $87, $ce, $87, $d1, $87, $d4, $87        ;; 0e:4218 ????????
    db   $d6, $87, $d9, $87, $db, $87, $dd, $87        ;; 0e:4220 ????????
    db   $df, $87, $e1, $87, $e2, $87, $e4, $87        ;; 0e:4228 ????????
    db   $e6, $87, $e7, $87, $e9, $87, $ea, $87        ;; 0e:4230 ????????
    db   $eb, $87, $ec, $87, $ed, $87, $ee, $87        ;; 0e:4238 ????????
    db   $ef, $87, $f0, $87                            ;; 0e:4240 ????

data_0e_4244:
    db   $60, $48, $30, $20, $24, $18, $10, $12        ;; 0e:4244 ...?....
    db   $0c, $08, $06, $04, $03                       ;; 0e:424c .....

call_0e_4251:
    ld   A, [wCB00]                                    ;; 0e:4251 $fa $00 $cb
    ld   B, A                                          ;; 0e:4254 $47
    ld   A, [wCB01]                                    ;; 0e:4255 $fa $01 $cb
    add  A, B                                          ;; 0e:4258 $80
    ld   [wCB00], A                                    ;; 0e:4259 $ea $00 $cb
    jr   NC, .jr_0e_4264                               ;; 0e:425c $30 $06
    call call_0e_4281                                  ;; 0e:425e $cd $81 $42
    call call_0e_4281                                  ;; 0e:4261 $cd $81 $42
.jr_0e_4264:
    ldh  A, [hFFB4]                                    ;; 0e:4264 $f0 $b4
    inc  A                                             ;; 0e:4266 $3c
    cp   A, $03                                        ;; 0e:4267 $fe $03
    jr   NZ, .jr_0e_426c                               ;; 0e:4269 $20 $01
    xor  A, A                                          ;; 0e:426b $af
.jr_0e_426c:
    ldh  [hFFB4], A                                    ;; 0e:426c $e0 $b4
    or   A, A                                          ;; 0e:426e $b7
    call Z, call_0e_47d3                               ;; 0e:426f $cc $d3 $47
    ldh  A, [hFFB4]                                    ;; 0e:4272 $f0 $b4
    cp   A, $01                                        ;; 0e:4274 $fe $01
    call Z, call_0e_484d                               ;; 0e:4276 $cc $4d $48
    ldh  A, [hFFB4]                                    ;; 0e:4279 $f0 $b4
    cp   A, $02                                        ;; 0e:427b $fe $02
    call Z, call_0e_48c7                               ;; 0e:427d $cc $c7 $48
    ret                                                ;; 0e:4280 $c9

call_0e_4281:
    ld   A, [wCB13]                                    ;; 0e:4281 $fa $13 $cb
    cp   A, $ff                                        ;; 0e:4284 $fe $ff
    jp   Z, jp_0e_44cc                                 ;; 0e:4286 $ca $cc $44
    ld   A, [wCB03]                                    ;; 0e:4289 $fa $03 $cb
    dec  A                                             ;; 0e:428c $3d
    ld   [wCB03], A                                    ;; 0e:428d $ea $03 $cb
    ldh  [hFFB5], A                                    ;; 0e:4290 $e0 $b5
    jp   NZ, jp_0e_44cc                                ;; 0e:4292 $c2 $cc $44
.jp_0e_4295:
    call call_0e_47bd                                  ;; 0e:4295 $cd $bd $47
    ld   E, A                                          ;; 0e:4298 $5f
    cp   A, $d0                                        ;; 0e:4299 $fe $d0
    jr   NC, .jr_0e_4307                               ;; 0e:429b $30 $6a
    and  A, $f0                                        ;; 0e:429d $e6 $f0
    swap A                                             ;; 0e:429f $cb $37
    ld   C, A                                          ;; 0e:42a1 $4f
    ld   HL, data_0e_4244                              ;; 0e:42a2 $21 $44 $42
    ld   B, $00                                        ;; 0e:42a5 $06 $00
    add  HL, BC                                        ;; 0e:42a7 $09
    ld   A, [HL]                                       ;; 0e:42a8 $7e
    ld   [wCB03], A                                    ;; 0e:42a9 $ea $03 $cb
    ld   A, E                                          ;; 0e:42ac $7b
    and  A, $0f                                        ;; 0e:42ad $e6 $0f
    ld   [wCB11], A                                    ;; 0e:42af $ea $11 $cb
    cp   A, $0e                                        ;; 0e:42b2 $fe $0e
    jp   Z, jp_0e_44cc                                 ;; 0e:42b4 $ca $cc $44
    cp   A, $0f                                        ;; 0e:42b7 $fe $0f
    jr   NZ, .jr_0e_42c6                               ;; 0e:42b9 $20 $0b
    ld   A, $ff                                        ;; 0e:42bb $3e $ff
    ldh  [rNR23], A                                    ;; 0e:42bd $e0 $18
    ld   A, $07                                        ;; 0e:42bf $3e $07
    ldh  [rNR24], A                                    ;; 0e:42c1 $e0 $19
    jp   jp_0e_44cc                                    ;; 0e:42c3 $c3 $cc $44
.jr_0e_42c6:
    add  A, A                                          ;; 0e:42c6 $87
    ld   E, A                                          ;; 0e:42c7 $5f
    ld   A, [wCB0B]                                    ;; 0e:42c8 $fa $0b $cb
    add  A, E                                          ;; 0e:42cb $83
    ld   E, A                                          ;; 0e:42cc $5f
    ld   D, $00                                        ;; 0e:42cd $16 $00
    ld   HL, data_0e_419a                              ;; 0e:42cf $21 $9a $41
    add  HL, DE                                        ;; 0e:42d2 $19
    push HL                                            ;; 0e:42d3 $e5
    ld   A, [wCB15]                                    ;; 0e:42d4 $fa $15 $cb
    ld   L, A                                          ;; 0e:42d7 $6f
    ld   A, [wCB16]                                    ;; 0e:42d8 $fa $16 $cb
    ld   H, A                                          ;; 0e:42db $67
    ld   A, [HL+]                                      ;; 0e:42dc $2a
    ld   [wCB14], A                                    ;; 0e:42dd $ea $14 $cb
    ld   A, [HL+]                                      ;; 0e:42e0 $2a
    ldh  [rNR22], A                                    ;; 0e:42e1 $e0 $17
    ld   A, L                                          ;; 0e:42e3 $7d
    ld   A, [wCB17]                                    ;; 0e:42e4 $fa $17 $cb
    ld   A, H                                          ;; 0e:42e7 $7c
    ld   A, [wCB18]                                    ;; 0e:42e8 $fa $18 $cb
    pop  HL                                            ;; 0e:42eb $e1
    ld   A, [HL+]                                      ;; 0e:42ec $2a
    ldh  [rNR23], A                                    ;; 0e:42ed $e0 $18
    ld   [wCB0D], A                                    ;; 0e:42ef $ea $0d $cb
    ld   A, [HL]                                       ;; 0e:42f2 $7e
    ldh  [rNR24], A                                    ;; 0e:42f3 $e0 $19
    ld   [wCB0E], A                                    ;; 0e:42f5 $ea $0e $cb
    ld   HL, wCB06                                     ;; 0e:42f8 $21 $06 $cb
    call call_0e_47ac                                  ;; 0e:42fb $cd $ac $47
    ld   HL, wCB14                                     ;; 0e:42fe $21 $14 $cb
    call call_0e_47ac                                  ;; 0e:4301 $cd $ac $47
    jp   jp_0e_44cc                                    ;; 0e:4304 $c3 $cc $44
.jr_0e_4307:
    cp   A, $ff                                        ;; 0e:4307 $fe $ff
    jr   NZ, .jr_0e_4317                               ;; 0e:4309 $20 $0c
    ld   [wCB13], A                                    ;; 0e:430b $ea $13 $cb
    ldh  [rNR23], A                                    ;; 0e:430e $e0 $18
    ld   A, $07                                        ;; 0e:4310 $3e $07
    ldh  [rNR24], A                                    ;; 0e:4312 $e0 $19
    jp   jp_0e_44cc                                    ;; 0e:4314 $c3 $cc $44
.jr_0e_4317:
    cp   A, $e0                                        ;; 0e:4317 $fe $e0
    jr   NC, .jr_0e_4341                               ;; 0e:4319 $30 $26
    bit  3, A                                          ;; 0e:431b $cb $5f
    jr   NZ, .jr_0e_432d                               ;; 0e:431d $20 $0e
    and  A, $07                                        ;; 0e:431f $e6 $07
    add  A, A                                          ;; 0e:4321 $87
    add  A, A                                          ;; 0e:4322 $87
    add  A, A                                          ;; 0e:4323 $87
    ld   E, A                                          ;; 0e:4324 $5f
    add  A, A                                          ;; 0e:4325 $87
    add  A, E                                          ;; 0e:4326 $83
    ld   [wCB0B], A                                    ;; 0e:4327 $ea $0b $cb
    jp   .jp_0e_4295                                   ;; 0e:432a $c3 $95 $42
.jr_0e_432d:
    and  A, $07                                        ;; 0e:432d $e6 $07
    ld   E, A                                          ;; 0e:432f $5f
    ld   D, $00                                        ;; 0e:4330 $16 $00
    ld   HL, data_0e_47b5                              ;; 0e:4332 $21 $b5 $47
    add  HL, DE                                        ;; 0e:4335 $19
    ld   E, [HL]                                       ;; 0e:4336 $5e
    ld   A, [wCB0B]                                    ;; 0e:4337 $fa $0b $cb
    add  A, E                                          ;; 0e:433a $83
    ld   [wCB0B], A                                    ;; 0e:433b $ea $0b $cb
    jp   .jp_0e_4295                                   ;; 0e:433e $c3 $95 $42
.jr_0e_4341:
    and  A, $0f                                        ;; 0e:4341 $e6 $0f
    add  A, A                                          ;; 0e:4343 $87
    ld   HL, data_0e_4358                              ;; 0e:4344 $21 $58 $43
    ld   E, A                                          ;; 0e:4347 $5f
    ld   D, $00                                        ;; 0e:4348 $16 $00
    add  HL, DE                                        ;; 0e:434a $19
    call call_0e_4351                                  ;; 0e:434b $cd $51 $43
    jp   .jp_0e_4295                                   ;; 0e:434e $c3 $95 $42

call_0e_4351:
    ld   A, [HL+]                                      ;; 0e:4351 $2a
    ld   E, A                                          ;; 0e:4352 $5f
    ld   A, [HL]                                       ;; 0e:4353 $7e
    ld   H, A                                          ;; 0e:4354 $67
    ld   L, E                                          ;; 0e:4355 $6b
    jp   HL                                            ;; 0e:4356 $e9
    db   $c9                                           ;; 0e:4357 ?

data_0e_4358:
    dw   data_0e_4370                                  ;; 0e:4358 pP
    dw   data_0e_4391                                  ;; 0e:435a pP
    dw   data_0e_43a1                                  ;; 0e:435c pP
    dw   data_0e_4477                                  ;; 0e:435e pP
    dw   data_0e_4485                                  ;; 0e:4360 pP
    dw   data_0e_44a6                                  ;; 0e:4362 pP
    dw   data_0e_44af                                  ;; 0e:4364 pP
    dw   data_0e_44c5                                  ;; 0e:4366 pP
    db   $57, $43, $d1, $43, $7e, $44                  ;; 0e:4368 ??????
    dw   data_0e_4414                                  ;; 0e:436e pP

data_0e_4370:
    ld   HL, wCB04                                     ;; 0e:4370 $21 $04 $cb
    ld   E, [HL]                                       ;; 0e:4373 $5e
    inc  HL                                            ;; 0e:4374 $23
    ld   D, [HL]                                       ;; 0e:4375 $56
    ld   A, [DE]                                       ;; 0e:4376 $1a
    ld   C, A                                          ;; 0e:4377 $4f
    inc  DE                                            ;; 0e:4378 $13
    ld   A, [DE]                                       ;; 0e:4379 $1a
    inc  DE                                            ;; 0e:437a $13
    ld   [wCB16], A                                    ;; 0e:437b $ea $16 $cb
    ld   [wCB18], A                                    ;; 0e:437e $ea $18 $cb
    ld   A, C                                          ;; 0e:4381 $79
    ld   [wCB15], A                                    ;; 0e:4382 $ea $15 $cb
    ld   [wCB17], A                                    ;; 0e:4385 $ea $17 $cb
    ld   A, E                                          ;; 0e:4388 $7b
    ld   [wCB04], A                                    ;; 0e:4389 $ea $04 $cb
    ld   A, D                                          ;; 0e:438c $7a
    ld   [wCB05], A                                    ;; 0e:438d $ea $05 $cb
    ret                                                ;; 0e:4390 $c9

data_0e_4391:
    ld   HL, wCB04                                     ;; 0e:4391 $21 $04 $cb
    ld   E, [HL]                                       ;; 0e:4394 $5e
    inc  HL                                            ;; 0e:4395 $23
    ld   D, [HL]                                       ;; 0e:4396 $56
    ld   A, [DE]                                       ;; 0e:4397 $1a
    inc  DE                                            ;; 0e:4398 $13
    ld   [wCB04], A                                    ;; 0e:4399 $ea $04 $cb
    ld   A, [DE]                                       ;; 0e:439c $1a
    ld   [wCB05], A                                    ;; 0e:439d $ea $05 $cb
    ret                                                ;; 0e:43a0 $c9

data_0e_43a1:
    ld   HL, wCB04                                     ;; 0e:43a1 $21 $04 $cb
    call call_0e_4401                                  ;; 0e:43a4 $cd $01 $44
    ld   B, A                                          ;; 0e:43a7 $47
    ld   A, [wCB0F]                                    ;; 0e:43a8 $fa $0f $cb
    dec  A                                             ;; 0e:43ab $3d
    ld   [wCB0F], A                                    ;; 0e:43ac $ea $0f $cb
    jr   jr_0e_440a                                    ;; 0e:43af $18 $59

data_0e_43b1:
    ld   HL, wCB1C                                     ;; 0e:43b1 $21 $1c $cb
    call call_0e_4401                                  ;; 0e:43b4 $cd $01 $44
    ld   B, A                                          ;; 0e:43b7 $47
    ld   A, [wCB27]                                    ;; 0e:43b8 $fa $27 $cb
    dec  A                                             ;; 0e:43bb $3d
    ld   [wCB27], A                                    ;; 0e:43bc $ea $27 $cb
    jr   jr_0e_440a                                    ;; 0e:43bf $18 $49

data_0e_43c1:
    ld   HL, wCB34                                     ;; 0e:43c1 $21 $34 $cb
    call call_0e_4401                                  ;; 0e:43c4 $cd $01 $44
    ld   B, A                                          ;; 0e:43c7 $47
    ld   A, [wCB3F]                                    ;; 0e:43c8 $fa $3f $cb
    dec  A                                             ;; 0e:43cb $3d
    ld   [wCB3F], A                                    ;; 0e:43cc $ea $3f $cb
    jr   jr_0e_440a                                    ;; 0e:43cf $18 $39
    db   $21, $04, $cb, $cd, $01, $44, $47, $fa        ;; 0e:43d1 ????????
    db   $19, $cb, $3d, $ea, $19, $cb, $18, $29        ;; 0e:43d9 ????????
    db   $21, $1c, $cb, $cd, $01, $44, $47, $fa        ;; 0e:43e1 ????????
    db   $31, $cb, $3d, $ea, $31, $cb, $18, $19        ;; 0e:43e9 ????????
    db   $21, $34, $cb, $cd, $01, $44, $47, $fa        ;; 0e:43f1 ????????
    db   $49, $cb, $3d, $ea, $49, $cb, $18, $09        ;; 0e:43f9 ????????

call_0e_4401:
    ld   E, [HL]                                       ;; 0e:4401 $5e
    inc  HL                                            ;; 0e:4402 $23
    ld   D, [HL]                                       ;; 0e:4403 $56
    ld   A, [DE]                                       ;; 0e:4404 $1a
    ld   C, A                                          ;; 0e:4405 $4f
    inc  DE                                            ;; 0e:4406 $13
    ld   A, [DE]                                       ;; 0e:4407 $1a
    inc  DE                                            ;; 0e:4408 $13
    ret                                                ;; 0e:4409 $c9

jr_0e_440a:
    jr   NZ, jr_0e_4410                                ;; 0e:440a $20 $04
    ld   [HL], D                                       ;; 0e:440c $72
    dec  HL                                            ;; 0e:440d $2b
    ld   [HL], E                                       ;; 0e:440e $73
    ret                                                ;; 0e:440f $c9

jr_0e_4410:
    ld   [HL], B                                       ;; 0e:4410 $70
    dec  HL                                            ;; 0e:4411 $2b
    ld   [HL], C                                       ;; 0e:4412 $71
    ret                                                ;; 0e:4413 $c9

data_0e_4414:
    call call_0e_47bd                                  ;; 0e:4414 $cd $bd $47
    ld   C, A                                          ;; 0e:4417 $4f
    ld   A, [wCB04]                                    ;; 0e:4418 $fa $04 $cb
    ld   L, A                                          ;; 0e:441b $6f
    ld   A, [wCB05]                                    ;; 0e:441c $fa $05 $cb
    ld   H, A                                          ;; 0e:441f $67
    ld   A, [HL+]                                      ;; 0e:4420 $2a
    ld   E, A                                          ;; 0e:4421 $5f
    ld   A, [HL+]                                      ;; 0e:4422 $2a
    ld   D, A                                          ;; 0e:4423 $57
    ld   A, [wCB0F]                                    ;; 0e:4424 $fa $0f $cb
    cp   A, C                                          ;; 0e:4427 $b9
    jr   NZ, .jr_0e_442c                               ;; 0e:4428 $20 $02
    push DE                                            ;; 0e:442a $d5
    pop  HL                                            ;; 0e:442b $e1
.jr_0e_442c:
    ld   A, L                                          ;; 0e:442c $7d
    ld   [wCB04], A                                    ;; 0e:442d $ea $04 $cb
    ld   A, H                                          ;; 0e:4430 $7c
    ld   [wCB05], A                                    ;; 0e:4431 $ea $05 $cb
    ret                                                ;; 0e:4434 $c9

data_0e_4435:
    call call_0e_47c9                                  ;; 0e:4435 $cd $c9 $47
    ld   C, A                                          ;; 0e:4438 $4f
    ld   A, [wCB1C]                                    ;; 0e:4439 $fa $1c $cb
    ld   L, A                                          ;; 0e:443c $6f
    ld   A, [wCB1D]                                    ;; 0e:443d $fa $1d $cb
    ld   H, A                                          ;; 0e:4440 $67
    ld   A, [HL+]                                      ;; 0e:4441 $2a
    ld   E, A                                          ;; 0e:4442 $5f
    ld   A, [HL+]                                      ;; 0e:4443 $2a
    ld   D, A                                          ;; 0e:4444 $57
    ld   A, [wCB27]                                    ;; 0e:4445 $fa $27 $cb
    cp   A, C                                          ;; 0e:4448 $b9
    jr   NZ, .jr_0e_444d                               ;; 0e:4449 $20 $02
    push DE                                            ;; 0e:444b $d5
    pop  HL                                            ;; 0e:444c $e1
.jr_0e_444d:
    ld   A, L                                          ;; 0e:444d $7d
    ld   [wCB1C], A                                    ;; 0e:444e $ea $1c $cb
    ld   A, H                                          ;; 0e:4451 $7c
    ld   [wCB1D], A                                    ;; 0e:4452 $ea $1d $cb
    ret                                                ;; 0e:4455 $c9

data_0e_4456:
    call call_0e_47ce                                  ;; 0e:4456 $cd $ce $47
    ld   C, A                                          ;; 0e:4459 $4f
    ld   A, [wCB34]                                    ;; 0e:445a $fa $34 $cb
    ld   L, A                                          ;; 0e:445d $6f
    ld   A, [wCB35]                                    ;; 0e:445e $fa $35 $cb
    ld   H, A                                          ;; 0e:4461 $67
    ld   A, [HL+]                                      ;; 0e:4462 $2a
    ld   E, A                                          ;; 0e:4463 $5f
    ld   A, [HL+]                                      ;; 0e:4464 $2a
    ld   D, A                                          ;; 0e:4465 $57
    ld   A, [wCB3F]                                    ;; 0e:4466 $fa $3f $cb
    cp   A, C                                          ;; 0e:4469 $b9
    jr   NZ, .jr_0e_446e                               ;; 0e:446a $20 $02
    push DE                                            ;; 0e:446c $d5
    pop  HL                                            ;; 0e:446d $e1
.jr_0e_446e:
    ld   A, L                                          ;; 0e:446e $7d
    ld   [wCB34], A                                    ;; 0e:446f $ea $34 $cb
    ld   A, H                                          ;; 0e:4472 $7c
    ld   [wCB35], A                                    ;; 0e:4473 $ea $35 $cb
    ret                                                ;; 0e:4476 $c9

data_0e_4477:
    call call_0e_47bd                                  ;; 0e:4477 $cd $bd $47
    ld   [wCB0F], A                                    ;; 0e:447a $ea $0f $cb
    ret                                                ;; 0e:447d $c9
    db   $cd, $bd, $47, $ea, $19, $cb, $c9             ;; 0e:447e ???????

data_0e_4485:
    ld   HL, wCB04                                     ;; 0e:4485 $21 $04 $cb
    ld   E, [HL]                                       ;; 0e:4488 $5e
    inc  HL                                            ;; 0e:4489 $23
    ld   D, [HL]                                       ;; 0e:448a $56
    ld   A, [DE]                                       ;; 0e:448b $1a
    ld   C, A                                          ;; 0e:448c $4f
    inc  DE                                            ;; 0e:448d $13
    ld   A, [DE]                                       ;; 0e:448e $1a
    inc  DE                                            ;; 0e:448f $13
    ld   [wCB08], A                                    ;; 0e:4490 $ea $08 $cb
    ld   [wCB0A], A                                    ;; 0e:4493 $ea $0a $cb
    ld   A, C                                          ;; 0e:4496 $79
    ld   [wCB07], A                                    ;; 0e:4497 $ea $07 $cb
    ld   [wCB09], A                                    ;; 0e:449a $ea $09 $cb
    ld   A, E                                          ;; 0e:449d $7b
    ld   [wCB04], A                                    ;; 0e:449e $ea $04 $cb
    ld   A, D                                          ;; 0e:44a1 $7a
    ld   [wCB05], A                                    ;; 0e:44a2 $ea $05 $cb
    ret                                                ;; 0e:44a5 $c9

data_0e_44a6:
    call call_0e_47bd                                  ;; 0e:44a6 $cd $bd $47
    ldh  [rNR21], A                                    ;; 0e:44a9 $e0 $16
    ld   [wCB0C], A                                    ;; 0e:44ab $ea $0c $cb
    ret                                                ;; 0e:44ae $c9

data_0e_44af:
    call call_0e_47bd                                  ;; 0e:44af $cd $bd $47
    ld   E, A                                          ;; 0e:44b2 $5f
    ld   D, $00                                        ;; 0e:44b3 $16 $00
    ld   HL, data_0e_4648                              ;; 0e:44b5 $21 $48 $46
    add  HL, DE                                        ;; 0e:44b8 $19
    ldh  A, [rNR51]                                    ;; 0e:44b9 $f0 $25
    and  A, $dd                                        ;; 0e:44bb $e6 $dd
    or   A, [HL]                                       ;; 0e:44bd $b6
    ldh  [rNR51], A                                    ;; 0e:44be $e0 $25
    ret                                                ;; 0e:44c0 $c9

data_0e_44c1:
    db   $00, $01, $10, $11                            ;; 0e:44c1 ?...

data_0e_44c5:
    call call_0e_47bd                                  ;; 0e:44c5 $cd $bd $47
    ld   [wCB01], A                                    ;; 0e:44c8 $ea $01 $cb
    ret                                                ;; 0e:44cb $c9

jp_0e_44cc:
    ld   A, [wCB2B]                                    ;; 0e:44cc $fa $2b $cb
    cp   A, $ff                                        ;; 0e:44cf $fe $ff
    jp   Z, jp_0e_464c                                 ;; 0e:44d1 $ca $4c $46
    ld   A, [wCB1B]                                    ;; 0e:44d4 $fa $1b $cb
    dec  A                                             ;; 0e:44d7 $3d
    ld   [wCB1B], A                                    ;; 0e:44d8 $ea $1b $cb
    ldh  [hFFB6], A                                    ;; 0e:44db $e0 $b6
    jp   NZ, jp_0e_464c                                ;; 0e:44dd $c2 $4c $46
.jp_0e_44e0:
    call call_0e_47c9                                  ;; 0e:44e0 $cd $c9 $47
    ld   E, A                                          ;; 0e:44e3 $5f
    cp   A, $d0                                        ;; 0e:44e4 $fe $d0
    jr   NC, .jr_0e_455b                               ;; 0e:44e6 $30 $73
    and  A, $f0                                        ;; 0e:44e8 $e6 $f0
    swap A                                             ;; 0e:44ea $cb $37
    ld   C, A                                          ;; 0e:44ec $4f
    ld   HL, data_0e_4244                              ;; 0e:44ed $21 $44 $42
    ld   B, $00                                        ;; 0e:44f0 $06 $00
    add  HL, BC                                        ;; 0e:44f2 $09
    ld   A, [HL]                                       ;; 0e:44f3 $7e
    ld   [wCB1B], A                                    ;; 0e:44f4 $ea $1b $cb
    ld   A, E                                          ;; 0e:44f7 $7b
    and  A, $0f                                        ;; 0e:44f8 $e6 $0f
    ld   [wCB29], A                                    ;; 0e:44fa $ea $29 $cb
    cp   A, $0e                                        ;; 0e:44fd $fe $0e
    jp   Z, jp_0e_464c                                 ;; 0e:44ff $ca $4c $46
    ld   C, A                                          ;; 0e:4502 $4f
    ld   A, [wCB1A]                                    ;; 0e:4503 $fa $1a $cb
    or   A, A                                          ;; 0e:4506 $b7
    jp   NZ, jp_0e_464c                                ;; 0e:4507 $c2 $4c $46
    ld   A, C                                          ;; 0e:450a $79
    cp   A, $0f                                        ;; 0e:450b $fe $0f
    jr   NZ, .jr_0e_451a                               ;; 0e:450d $20 $0b
    ld   A, $ff                                        ;; 0e:450f $3e $ff
    ldh  [rNR13], A                                    ;; 0e:4511 $e0 $13
    ld   A, $07                                        ;; 0e:4513 $3e $07
    ldh  [rNR14], A                                    ;; 0e:4515 $e0 $14
    jp   jp_0e_464c                                    ;; 0e:4517 $c3 $4c $46
.jr_0e_451a:
    add  A, A                                          ;; 0e:451a $87
    ld   E, A                                          ;; 0e:451b $5f
    ld   A, [wCB23]                                    ;; 0e:451c $fa $23 $cb
    add  A, E                                          ;; 0e:451f $83
    ld   E, A                                          ;; 0e:4520 $5f
    ld   D, $00                                        ;; 0e:4521 $16 $00
    ld   HL, data_0e_419a                              ;; 0e:4523 $21 $9a $41
    add  HL, DE                                        ;; 0e:4526 $19
    push HL                                            ;; 0e:4527 $e5
    ld   A, [wCB2D]                                    ;; 0e:4528 $fa $2d $cb
    ld   L, A                                          ;; 0e:452b $6f
    ld   A, [wCB2E]                                    ;; 0e:452c $fa $2e $cb
    ld   H, A                                          ;; 0e:452f $67
    ld   A, [HL+]                                      ;; 0e:4530 $2a
    ld   [wCB2C], A                                    ;; 0e:4531 $ea $2c $cb
    ld   A, [HL+]                                      ;; 0e:4534 $2a
    ldh  [rNR12], A                                    ;; 0e:4535 $e0 $12
    ld   A, L                                          ;; 0e:4537 $7d
    ld   A, [wCB2F]                                    ;; 0e:4538 $fa $2f $cb
    ld   A, H                                          ;; 0e:453b $7c
    ld   A, [wCB30]                                    ;; 0e:453c $fa $30 $cb
    pop  HL                                            ;; 0e:453f $e1
    ld   A, [HL+]                                      ;; 0e:4540 $2a
    ldh  [rNR13], A                                    ;; 0e:4541 $e0 $13
    ld   [wCB25], A                                    ;; 0e:4543 $ea $25 $cb
    ld   A, [HL]                                       ;; 0e:4546 $7e
    ldh  [rNR14], A                                    ;; 0e:4547 $e0 $14
    ld   [wCB26], A                                    ;; 0e:4549 $ea $26 $cb
    ld   HL, wCB1E                                     ;; 0e:454c $21 $1e $cb
    call call_0e_47ac                                  ;; 0e:454f $cd $ac $47
    ld   HL, wCB2C                                     ;; 0e:4552 $21 $2c $cb
    call call_0e_47ac                                  ;; 0e:4555 $cd $ac $47
    jp   jp_0e_464c                                    ;; 0e:4558 $c3 $4c $46
.jr_0e_455b:
    cp   A, $ff                                        ;; 0e:455b $fe $ff
    jr   NZ, .jr_0e_456b                               ;; 0e:455d $20 $0c
    ld   [wCB2B], A                                    ;; 0e:455f $ea $2b $cb
    ldh  [rNR23], A                                    ;; 0e:4562 $e0 $18
    ld   A, $07                                        ;; 0e:4564 $3e $07
    ldh  [rNR24], A                                    ;; 0e:4566 $e0 $19
    jp   jp_0e_464c                                    ;; 0e:4568 $c3 $4c $46
.jr_0e_456b:
    cp   A, $e0                                        ;; 0e:456b $fe $e0
    jr   NC, .jr_0e_4595                               ;; 0e:456d $30 $26
    bit  3, A                                          ;; 0e:456f $cb $5f
    jr   NZ, .jr_0e_4581                               ;; 0e:4571 $20 $0e
    and  A, $07                                        ;; 0e:4573 $e6 $07
    add  A, A                                          ;; 0e:4575 $87
    add  A, A                                          ;; 0e:4576 $87
    add  A, A                                          ;; 0e:4577 $87
    ld   E, A                                          ;; 0e:4578 $5f
    add  A, A                                          ;; 0e:4579 $87
    add  A, E                                          ;; 0e:457a $83
    ld   [wCB23], A                                    ;; 0e:457b $ea $23 $cb
    jp   .jp_0e_44e0                                   ;; 0e:457e $c3 $e0 $44
.jr_0e_4581:
    and  A, $07                                        ;; 0e:4581 $e6 $07
    ld   E, A                                          ;; 0e:4583 $5f
    ld   D, $00                                        ;; 0e:4584 $16 $00
    ld   HL, data_0e_47b5                              ;; 0e:4586 $21 $b5 $47
    add  HL, DE                                        ;; 0e:4589 $19
    ld   E, [HL]                                       ;; 0e:458a $5e
    ld   A, [wCB23]                                    ;; 0e:458b $fa $23 $cb
    add  A, E                                          ;; 0e:458e $83
    ld   [wCB23], A                                    ;; 0e:458f $ea $23 $cb
    jp   .jp_0e_44e0                                   ;; 0e:4592 $c3 $e0 $44
.jr_0e_4595:
    and  A, $0f                                        ;; 0e:4595 $e6 $0f
    add  A, A                                          ;; 0e:4597 $87
    ld   HL, data_0e_45ab                              ;; 0e:4598 $21 $ab $45
    ld   E, A                                          ;; 0e:459b $5f
    ld   D, $00                                        ;; 0e:459c $16 $00
    add  HL, DE                                        ;; 0e:459e $19
    call call_0e_45a5                                  ;; 0e:459f $cd $a5 $45
    jp   .jp_0e_44e0                                   ;; 0e:45a2 $c3 $e0 $44

call_0e_45a5:
    ld   A, [HL+]                                      ;; 0e:45a5 $2a
    ld   E, A                                          ;; 0e:45a6 $5f
    ld   A, [HL]                                       ;; 0e:45a7 $7e
    ld   H, A                                          ;; 0e:45a8 $67
    ld   L, E                                          ;; 0e:45a9 $6b
    jp   HL                                            ;; 0e:45aa $e9

data_0e_45ab:
    dw   data_0e_45c3                                  ;; 0e:45ab pP
    dw   data_0e_45de                                  ;; 0e:45ad pP
    dw   data_0e_43b1                                  ;; 0e:45af pP
    dw   data_0e_45ee                                  ;; 0e:45b1 pP
    dw   data_0e_45fc                                  ;; 0e:45b3 pP
    dw   data_0e_461d                                  ;; 0e:45b5 pP
    dw   data_0e_462d                                  ;; 0e:45b7 pP
    db   $57, $43, $57, $43, $e1, $43, $f5, $45        ;; 0e:45b9 ????????
    dw   data_0e_4435                                  ;; 0e:45c1 pP

data_0e_45c3:
    ld   HL, wCB1C                                     ;; 0e:45c3 $21 $1c $cb
    ld   E, [HL]                                       ;; 0e:45c6 $5e
    inc  HL                                            ;; 0e:45c7 $23
    ld   D, [HL]                                       ;; 0e:45c8 $56
    ld   A, [DE]                                       ;; 0e:45c9 $1a
    ld   C, A                                          ;; 0e:45ca $4f
    inc  DE                                            ;; 0e:45cb $13
    ld   A, [DE]                                       ;; 0e:45cc $1a
    inc  DE                                            ;; 0e:45cd $13
    ld   [wCB2E], A                                    ;; 0e:45ce $ea $2e $cb
    ld   A, C                                          ;; 0e:45d1 $79
    ld   [wCB2D], A                                    ;; 0e:45d2 $ea $2d $cb
    ld   A, E                                          ;; 0e:45d5 $7b
    ld   [wCB1C], A                                    ;; 0e:45d6 $ea $1c $cb
    ld   A, D                                          ;; 0e:45d9 $7a
    ld   [wCB1D], A                                    ;; 0e:45da $ea $1d $cb
    ret                                                ;; 0e:45dd $c9

data_0e_45de:
    ld   HL, wCB1C                                     ;; 0e:45de $21 $1c $cb
    ld   E, [HL]                                       ;; 0e:45e1 $5e
    inc  HL                                            ;; 0e:45e2 $23
    ld   D, [HL]                                       ;; 0e:45e3 $56
    ld   A, [DE]                                       ;; 0e:45e4 $1a
    inc  DE                                            ;; 0e:45e5 $13
    ld   [wCB1C], A                                    ;; 0e:45e6 $ea $1c $cb
    ld   A, [DE]                                       ;; 0e:45e9 $1a
    ld   [wCB1D], A                                    ;; 0e:45ea $ea $1d $cb
    ret                                                ;; 0e:45ed $c9

data_0e_45ee:
    call call_0e_47c9                                  ;; 0e:45ee $cd $c9 $47
    ld   [wCB27], A                                    ;; 0e:45f1 $ea $27 $cb
    ret                                                ;; 0e:45f4 $c9
    db   $cd, $c9, $47, $ea, $31, $cb, $c9             ;; 0e:45f5 ???????

data_0e_45fc:
    ld   HL, wCB1C                                     ;; 0e:45fc $21 $1c $cb
    ld   E, [HL]                                       ;; 0e:45ff $5e
    inc  HL                                            ;; 0e:4600 $23
    ld   D, [HL]                                       ;; 0e:4601 $56
    ld   A, [DE]                                       ;; 0e:4602 $1a
    ld   C, A                                          ;; 0e:4603 $4f
    inc  DE                                            ;; 0e:4604 $13
    ld   A, [DE]                                       ;; 0e:4605 $1a
    inc  DE                                            ;; 0e:4606 $13
    ld   [wCB20], A                                    ;; 0e:4607 $ea $20 $cb
    ld   [wCB22], A                                    ;; 0e:460a $ea $22 $cb
    ld   A, C                                          ;; 0e:460d $79
    ld   [wCB1F], A                                    ;; 0e:460e $ea $1f $cb
    ld   [wCB21], A                                    ;; 0e:4611 $ea $21 $cb
    ld   A, E                                          ;; 0e:4614 $7b
    ld   [wCB1C], A                                    ;; 0e:4615 $ea $1c $cb
    ld   A, D                                          ;; 0e:4618 $7a
    ld   [wCB1D], A                                    ;; 0e:4619 $ea $1d $cb
    ret                                                ;; 0e:461c $c9

data_0e_461d:
    call call_0e_47c9                                  ;; 0e:461d $cd $c9 $47
    ld   [wCB24], A                                    ;; 0e:4620 $ea $24 $cb
    ld   B, A                                          ;; 0e:4623 $47
    ld   A, [wCB1A]                                    ;; 0e:4624 $fa $1a $cb
    or   A, A                                          ;; 0e:4627 $b7
    ret  NZ                                            ;; 0e:4628 $c0
    ld   A, B                                          ;; 0e:4629 $78
    ldh  [rNR11], A                                    ;; 0e:462a $e0 $11
    ret                                                ;; 0e:462c $c9

data_0e_462d:
    call call_0e_47c9                                  ;; 0e:462d $cd $c9 $47
    ld   E, A                                          ;; 0e:4630 $5f
    ld   D, $00                                        ;; 0e:4631 $16 $00
    ld   HL, data_0e_44c1                              ;; 0e:4633 $21 $c1 $44
    add  HL, DE                                        ;; 0e:4636 $19
    ld   A, [HL]                                       ;; 0e:4637 $7e
    ld   [wCB2A], A                                    ;; 0e:4638 $ea $2a $cb
    ld   A, [wCB1A]                                    ;; 0e:463b $fa $1a $cb
    or   A, A                                          ;; 0e:463e $b7
    ret  NZ                                            ;; 0e:463f $c0
    ldh  A, [rNR51]                                    ;; 0e:4640 $f0 $25
    and  A, $ee                                        ;; 0e:4642 $e6 $ee
    or   A, [HL]                                       ;; 0e:4644 $b6
    ldh  [rNR51], A                                    ;; 0e:4645 $e0 $25
    ret                                                ;; 0e:4647 $c9

data_0e_4648:
    db   $00, $02, $20, $22                            ;; 0e:4648 ????

jp_0e_464c:
    ld   A, [wCB43]                                    ;; 0e:464c $fa $43 $cb
    cp   A, $ff                                        ;; 0e:464f $fe $ff
    jp   Z, jp_0e_47ab                                 ;; 0e:4651 $ca $ab $47
    ld   A, [wCB33]                                    ;; 0e:4654 $fa $33 $cb
    dec  A                                             ;; 0e:4657 $3d
    ld   [wCB33], A                                    ;; 0e:4658 $ea $33 $cb
    ldh  [hFFB7], A                                    ;; 0e:465b $e0 $b7
    jp   NZ, jp_0e_47ab                                ;; 0e:465d $c2 $ab $47
.jp_0e_4660:
    call call_0e_47ce                                  ;; 0e:4660 $cd $ce $47
    ld   E, A                                          ;; 0e:4663 $5f
    cp   A, $d0                                        ;; 0e:4664 $fe $d0
    jr   NC, .jr_0e_46b6                               ;; 0e:4666 $30 $4e
    and  A, $f0                                        ;; 0e:4668 $e6 $f0
    swap A                                             ;; 0e:466a $cb $37
    ld   C, A                                          ;; 0e:466c $4f
    ld   HL, data_0e_4244                              ;; 0e:466d $21 $44 $42
    ld   B, $00                                        ;; 0e:4670 $06 $00
    add  HL, BC                                        ;; 0e:4672 $09
    ld   A, [HL]                                       ;; 0e:4673 $7e
    ld   [wCB33], A                                    ;; 0e:4674 $ea $33 $cb
    ld   A, E                                          ;; 0e:4677 $7b
    and  A, $0f                                        ;; 0e:4678 $e6 $0f
    ld   [wCB41], A                                    ;; 0e:467a $ea $41 $cb
    cp   A, $0e                                        ;; 0e:467d $fe $0e
    jp   Z, jp_0e_47ab                                 ;; 0e:467f $ca $ab $47
    cp   A, $0f                                        ;; 0e:4682 $fe $0f
    jr   NZ, .jr_0e_468d                               ;; 0e:4684 $20 $07
    ld   A, $00                                        ;; 0e:4686 $3e $00
    ldh  [rNR32], A                                    ;; 0e:4688 $e0 $1c
    jp   jp_0e_47ab                                    ;; 0e:468a $c3 $ab $47
.jr_0e_468d:
    add  A, A                                          ;; 0e:468d $87
    ld   E, A                                          ;; 0e:468e $5f
    ld   A, [wCB3B]                                    ;; 0e:468f $fa $3b $cb
    add  A, E                                          ;; 0e:4692 $83
    ld   E, A                                          ;; 0e:4693 $5f
    ld   D, $00                                        ;; 0e:4694 $16 $00
    ld   HL, data_0e_419a                              ;; 0e:4696 $21 $9a $41
    add  HL, DE                                        ;; 0e:4699 $19
    ld   A, [wCB40]                                    ;; 0e:469a $fa $40 $cb
    ldh  [rNR32], A                                    ;; 0e:469d $e0 $1c
    ld   A, [HL+]                                      ;; 0e:469f $2a
    ldh  [rNR33], A                                    ;; 0e:46a0 $e0 $1d
    ld   [wCB3D], A                                    ;; 0e:46a2 $ea $3d $cb
    ld   A, [HL]                                       ;; 0e:46a5 $7e
    and  A, $07                                        ;; 0e:46a6 $e6 $07
    ldh  [rNR34], A                                    ;; 0e:46a8 $e0 $1e
    ld   [wCB3E], A                                    ;; 0e:46aa $ea $3e $cb
    ld   HL, wCB36                                     ;; 0e:46ad $21 $36 $cb
    call call_0e_47ac                                  ;; 0e:46b0 $cd $ac $47
    jp   jp_0e_47ab                                    ;; 0e:46b3 $c3 $ab $47
.jr_0e_46b6:
    cp   A, $ff                                        ;; 0e:46b6 $fe $ff
    jr   NZ, .jr_0e_46c6                               ;; 0e:46b8 $20 $0c
    ld   [wCB43], A                                    ;; 0e:46ba $ea $43 $cb
    ldh  [rNR33], A                                    ;; 0e:46bd $e0 $1d
    ld   A, $07                                        ;; 0e:46bf $3e $07
    ldh  [rNR34], A                                    ;; 0e:46c1 $e0 $1e
    jp   jp_0e_47ab                                    ;; 0e:46c3 $c3 $ab $47
.jr_0e_46c6:
    cp   A, $e0                                        ;; 0e:46c6 $fe $e0
    jr   NC, .jr_0e_46f0                               ;; 0e:46c8 $30 $26
    bit  3, A                                          ;; 0e:46ca $cb $5f
    jr   NZ, .jr_0e_46dc                               ;; 0e:46cc $20 $0e
    and  A, $07                                        ;; 0e:46ce $e6 $07
    add  A, A                                          ;; 0e:46d0 $87
    add  A, A                                          ;; 0e:46d1 $87
    add  A, A                                          ;; 0e:46d2 $87
    ld   E, A                                          ;; 0e:46d3 $5f
    add  A, A                                          ;; 0e:46d4 $87
    add  A, E                                          ;; 0e:46d5 $83
    ld   [wCB3B], A                                    ;; 0e:46d6 $ea $3b $cb
    jp   .jp_0e_4660                                   ;; 0e:46d9 $c3 $60 $46
.jr_0e_46dc:
    and  A, $07                                        ;; 0e:46dc $e6 $07
    ld   E, A                                          ;; 0e:46de $5f
    ld   D, $00                                        ;; 0e:46df $16 $00
    ld   HL, data_0e_47b5                              ;; 0e:46e1 $21 $b5 $47
    add  HL, DE                                        ;; 0e:46e4 $19
    ld   E, [HL]                                       ;; 0e:46e5 $5e
    ld   A, [wCB3B]                                    ;; 0e:46e6 $fa $3b $cb
    add  A, E                                          ;; 0e:46e9 $83
    ld   [wCB3B], A                                    ;; 0e:46ea $ea $3b $cb
    jp   .jp_0e_4660                                   ;; 0e:46ed $c3 $60 $46
.jr_0e_46f0:
    and  A, $0f                                        ;; 0e:46f0 $e6 $0f
    add  A, A                                          ;; 0e:46f2 $87
    ld   HL, data_0e_4706                              ;; 0e:46f3 $21 $06 $47
    ld   E, A                                          ;; 0e:46f6 $5f
    ld   D, $00                                        ;; 0e:46f7 $16 $00
    add  HL, DE                                        ;; 0e:46f9 $19
    call call_0e_4700                                  ;; 0e:46fa $cd $00 $47
    jp   .jp_0e_4660                                   ;; 0e:46fd $c3 $60 $46

call_0e_4700:
    ld   A, [HL+]                                      ;; 0e:4700 $2a
    ld   E, A                                          ;; 0e:4701 $5f
    ld   A, [HL]                                       ;; 0e:4702 $7e
    ld   H, A                                          ;; 0e:4703 $67
    ld   L, E                                          ;; 0e:4704 $6b
    jp   HL                                            ;; 0e:4705 $e9

data_0e_4706:
    dw   data_0e_471e                                  ;; 0e:4706 pP
    dw   data_0e_4727                                  ;; 0e:4708 pP
    dw   data_0e_43c1                                  ;; 0e:470a pP
    dw   data_0e_4737                                  ;; 0e:470c pP
    dw   data_0e_4745                                  ;; 0e:470e pP
    db   $57, $43                                      ;; 0e:4710 ??
    dw   data_0e_4766                                  ;; 0e:4712 pP
    db   $57, $43                                      ;; 0e:4714 ??
    dw   data_0e_477c                                  ;; 0e:4716 pP
    db   $f1, $43, $3e, $47                            ;; 0e:4718 ????
    dw   data_0e_4456                                  ;; 0e:471c pP

data_0e_471e:
    call call_0e_47ce                                  ;; 0e:471e $cd $ce $47
    ld   [wCB40], A                                    ;; 0e:4721 $ea $40 $cb
    ldh  [rNR32], A                                    ;; 0e:4724 $e0 $1c
    ret                                                ;; 0e:4726 $c9

data_0e_4727:
    ld   HL, wCB34                                     ;; 0e:4727 $21 $34 $cb
    ld   E, [HL]                                       ;; 0e:472a $5e
    inc  HL                                            ;; 0e:472b $23
    ld   D, [HL]                                       ;; 0e:472c $56
    ld   A, [DE]                                       ;; 0e:472d $1a
    inc  DE                                            ;; 0e:472e $13
    ld   [wCB34], A                                    ;; 0e:472f $ea $34 $cb
    ld   A, [DE]                                       ;; 0e:4732 $1a
    ld   [wCB35], A                                    ;; 0e:4733 $ea $35 $cb
    ret                                                ;; 0e:4736 $c9

data_0e_4737:
    call call_0e_47ce                                  ;; 0e:4737 $cd $ce $47
    ld   [wCB3F], A                                    ;; 0e:473a $ea $3f $cb
    ret                                                ;; 0e:473d $c9
    db   $cd, $ce, $47, $ea, $49, $cb, $c9             ;; 0e:473e ???????

data_0e_4745:
    ld   HL, wCB34                                     ;; 0e:4745 $21 $34 $cb
    ld   E, [HL]                                       ;; 0e:4748 $5e
    inc  HL                                            ;; 0e:4749 $23
    ld   D, [HL]                                       ;; 0e:474a $56
    ld   A, [DE]                                       ;; 0e:474b $1a
    ld   C, A                                          ;; 0e:474c $4f
    inc  DE                                            ;; 0e:474d $13
    ld   A, [DE]                                       ;; 0e:474e $1a
    inc  DE                                            ;; 0e:474f $13
    ld   [wCB38], A                                    ;; 0e:4750 $ea $38 $cb
    ld   [wCB3A], A                                    ;; 0e:4753 $ea $3a $cb
    ld   A, C                                          ;; 0e:4756 $79
    ld   [wCB37], A                                    ;; 0e:4757 $ea $37 $cb
    ld   [wCB39], A                                    ;; 0e:475a $ea $39 $cb
    ld   A, E                                          ;; 0e:475d $7b
    ld   [wCB34], A                                    ;; 0e:475e $ea $34 $cb
    ld   A, D                                          ;; 0e:4761 $7a
    ld   [wCB35], A                                    ;; 0e:4762 $ea $35 $cb
    ret                                                ;; 0e:4765 $c9

data_0e_4766:
    call call_0e_47ce                                  ;; 0e:4766 $cd $ce $47
    ld   E, A                                          ;; 0e:4769 $5f
    ld   D, $00                                        ;; 0e:476a $16 $00
    ld   HL, .data_0e_4778                             ;; 0e:476c $21 $78 $47
    add  HL, DE                                        ;; 0e:476f $19
    ldh  A, [rNR51]                                    ;; 0e:4770 $f0 $25
    and  A, $bb                                        ;; 0e:4772 $e6 $bb
    or   A, [HL]                                       ;; 0e:4774 $b6
    ldh  [rNR51], A                                    ;; 0e:4775 $e0 $25
    ret                                                ;; 0e:4777 $c9
.data_0e_4778:
    db   $00, $04, $40, $44                            ;; 0e:4778 ????

data_0e_477c:
    ld   HL, wCB34                                     ;; 0e:477c $21 $34 $cb
    ld   E, [HL]                                       ;; 0e:477f $5e
    inc  HL                                            ;; 0e:4780 $23
    ld   D, [HL]                                       ;; 0e:4781 $56
    ld   A, [DE]                                       ;; 0e:4782 $1a
    ld   C, A                                          ;; 0e:4783 $4f
    ldh  [hFFBA], A                                    ;; 0e:4784 $e0 $ba
    inc  DE                                            ;; 0e:4786 $13
    ld   A, [DE]                                       ;; 0e:4787 $1a
    ld   B, A                                          ;; 0e:4788 $47
    ldh  [hFFBB], A                                    ;; 0e:4789 $e0 $bb
    inc  DE                                            ;; 0e:478b $13
    ld   [HL], D                                       ;; 0e:478c $72
    dec  HL                                            ;; 0e:478d $2b
    ld   [HL], E                                       ;; 0e:478e $73
    push BC                                            ;; 0e:478f $c5
    pop  HL                                            ;; 0e:4790 $e1

call_0e_4791:
    xor  A, A                                          ;; 0e:4791 $af
    ldh  [rNR30], A                                    ;; 0e:4792 $e0 $1a
    ld   C, $30                                        ;; 0e:4794 $0e $30
    ld   B, $10                                        ;; 0e:4796 $06 $10
.jr_0e_4798:
    ld   A, [HL+]                                      ;; 0e:4798 $2a
    ldh  [C], A                                        ;; 0e:4799 $e2
    inc  C                                             ;; 0e:479a $0c
    dec  B                                             ;; 0e:479b $05
    jr   NZ, .jr_0e_4798                               ;; 0e:479c $20 $fa
    ld   A, $80                                        ;; 0e:479e $3e $80
    ldh  [rNR30], A                                    ;; 0e:47a0 $e0 $1a
    ld   A, $00                                        ;; 0e:47a2 $3e $00
    ldh  [rNR32], A                                    ;; 0e:47a4 $e0 $1c
    ld   A, $87                                        ;; 0e:47a6 $3e $87
    ldh  [rNR34], A                                    ;; 0e:47a8 $e0 $1e
    ret                                                ;; 0e:47aa $c9

jp_0e_47ab:
    ret                                                ;; 0e:47ab $c9

call_0e_47ac:
    ld   A, $01                                        ;; 0e:47ac $3e $01
    ld   [HL+], A                                      ;; 0e:47ae $22
    ld   A, [HL+]                                      ;; 0e:47af $2a
    ld   E, [HL]                                       ;; 0e:47b0 $5e
    inc  HL                                            ;; 0e:47b1 $23
    ld   [HL+], A                                      ;; 0e:47b2 $22
    ld   [HL], E                                       ;; 0e:47b3 $73
    ret                                                ;; 0e:47b4 $c9

data_0e_47b5:
    db   $18, $30, $48, $60, $e8, $d0, $b8, $a0        ;; 0e:47b5 .???.???

call_0e_47bd:
    ld   HL, wCB04                                     ;; 0e:47bd $21 $04 $cb

jr_0e_47c0:
    ld   E, [HL]                                       ;; 0e:47c0 $5e
    inc  HL                                            ;; 0e:47c1 $23
    ld   D, [HL]                                       ;; 0e:47c2 $56
    ld   A, [DE]                                       ;; 0e:47c3 $1a
    inc  DE                                            ;; 0e:47c4 $13
    ld   [HL], D                                       ;; 0e:47c5 $72
    dec  HL                                            ;; 0e:47c6 $2b
    ld   [HL], E                                       ;; 0e:47c7 $73
    ret                                                ;; 0e:47c8 $c9

call_0e_47c9:
    ld   HL, wCB1C                                     ;; 0e:47c9 $21 $1c $cb
    jr   jr_0e_47c0                                    ;; 0e:47cc $18 $f2

call_0e_47ce:
    ld   HL, wCB34                                     ;; 0e:47ce $21 $34 $cb
    jr   jr_0e_47c0                                    ;; 0e:47d1 $18 $ed

call_0e_47d3:
    ld   A, [wCB02]                                    ;; 0e:47d3 $fa $02 $cb
    ld   E, A                                          ;; 0e:47d6 $5f
    ld   A, [wCB13]                                    ;; 0e:47d7 $fa $13 $cb
    or   A, E                                          ;; 0e:47da $b3
    ret  NZ                                            ;; 0e:47db $c0
    ldh  A, [hFFB5]                                    ;; 0e:47dc $f0 $b5
    or   A, A                                          ;; 0e:47de $b7
    ret  Z                                             ;; 0e:47df $c8
    ld   A, [wCB11]                                    ;; 0e:47e0 $fa $11 $cb
    cp   A, $0f                                        ;; 0e:47e3 $fe $0f
    ret  Z                                             ;; 0e:47e5 $c8
    ld   A, [wCB06]                                    ;; 0e:47e6 $fa $06 $cb
    dec  A                                             ;; 0e:47e9 $3d
    ld   [wCB06], A                                    ;; 0e:47ea $ea $06 $cb
    jr   NZ, .jr_0e_4821                               ;; 0e:47ed $20 $32
    ld   A, [wCB09]                                    ;; 0e:47ef $fa $09 $cb
    ld   L, A                                          ;; 0e:47f2 $6f
    ld   A, [wCB0A]                                    ;; 0e:47f3 $fa $0a $cb
    ld   H, A                                          ;; 0e:47f6 $67
    ld   A, [HL+]                                      ;; 0e:47f7 $2a
    or   A, A                                          ;; 0e:47f8 $b7
    call Z, call_0e_4916                               ;; 0e:47f9 $cc $16 $49
    ld   [wCB06], A                                    ;; 0e:47fc $ea $06 $cb
    ld   A, [HL+]                                      ;; 0e:47ff $2a
    ld   E, A                                          ;; 0e:4800 $5f
    ld   A, L                                          ;; 0e:4801 $7d
    ld   [wCB09], A                                    ;; 0e:4802 $ea $09 $cb
    ld   A, H                                          ;; 0e:4805 $7c
    ld   [wCB0A], A                                    ;; 0e:4806 $ea $0a $cb
    ld   D, $00                                        ;; 0e:4809 $16 $00
    bit  7, E                                          ;; 0e:480b $cb $7b
    jr   Z, .jr_0e_4810                                ;; 0e:480d $28 $01
    dec  D                                             ;; 0e:480f $15
.jr_0e_4810:
    ld   A, [wCB0D]                                    ;; 0e:4810 $fa $0d $cb
    ld   L, A                                          ;; 0e:4813 $6f
    ld   A, [wCB0E]                                    ;; 0e:4814 $fa $0e $cb
    ld   H, A                                          ;; 0e:4817 $67
    add  HL, DE                                        ;; 0e:4818 $19
    ld   A, L                                          ;; 0e:4819 $7d
    ldh  [rNR23], A                                    ;; 0e:481a $e0 $18
    ld   A, H                                          ;; 0e:481c $7c
    and  A, $07                                        ;; 0e:481d $e6 $07
    ldh  [rNR24], A                                    ;; 0e:481f $e0 $19
.jr_0e_4821:
    ld   A, [wCB14]                                    ;; 0e:4821 $fa $14 $cb
    cp   A, $ff                                        ;; 0e:4824 $fe $ff
    ret  Z                                             ;; 0e:4826 $c8
    dec  A                                             ;; 0e:4827 $3d
    ld   [wCB14], A                                    ;; 0e:4828 $ea $14 $cb
    ret  NZ                                            ;; 0e:482b $c0
    ld   A, [wCB17]                                    ;; 0e:482c $fa $17 $cb
    ld   L, A                                          ;; 0e:482f $6f
    ld   A, [wCB18]                                    ;; 0e:4830 $fa $18 $cb
    ld   H, A                                          ;; 0e:4833 $67
    ld   A, [HL+]                                      ;; 0e:4834 $2a
    or   A, A                                          ;; 0e:4835 $b7
    call Z, call_0e_4916                               ;; 0e:4836 $cc $16 $49
    ld   [wCB14], A                                    ;; 0e:4839 $ea $14 $cb
    ld   A, [HL+]                                      ;; 0e:483c $2a
    ldh  [rNR22], A                                    ;; 0e:483d $e0 $17
    ld   A, [wCB0E]                                    ;; 0e:483f $fa $0e $cb
    ldh  [rNR24], A                                    ;; 0e:4842 $e0 $19
    ld   A, L                                          ;; 0e:4844 $7d
    ld   [wCB17], A                                    ;; 0e:4845 $ea $17 $cb
    ld   A, H                                          ;; 0e:4848 $7c
    ld   [wCB18], A                                    ;; 0e:4849 $ea $18 $cb
    ret                                                ;; 0e:484c $c9

call_0e_484d:
    ld   A, [wCB1A]                                    ;; 0e:484d $fa $1a $cb
    ld   E, A                                          ;; 0e:4850 $5f
    ld   A, [wCB2B]                                    ;; 0e:4851 $fa $2b $cb
    or   A, E                                          ;; 0e:4854 $b3
    ret  NZ                                            ;; 0e:4855 $c0
    ldh  A, [hFFB6]                                    ;; 0e:4856 $f0 $b6
    or   A, A                                          ;; 0e:4858 $b7
    ret  Z                                             ;; 0e:4859 $c8
    ld   A, [wCB29]                                    ;; 0e:485a $fa $29 $cb
    cp   A, $0f                                        ;; 0e:485d $fe $0f
    ret  Z                                             ;; 0e:485f $c8
    ld   A, [wCB1E]                                    ;; 0e:4860 $fa $1e $cb
    dec  A                                             ;; 0e:4863 $3d
    ld   [wCB1E], A                                    ;; 0e:4864 $ea $1e $cb
    jr   NZ, .jr_0e_489b                               ;; 0e:4867 $20 $32
    ld   A, [wCB21]                                    ;; 0e:4869 $fa $21 $cb
    ld   L, A                                          ;; 0e:486c $6f
    ld   A, [wCB22]                                    ;; 0e:486d $fa $22 $cb
    ld   H, A                                          ;; 0e:4870 $67
    ld   A, [HL+]                                      ;; 0e:4871 $2a
    or   A, A                                          ;; 0e:4872 $b7
    call Z, call_0e_4916                               ;; 0e:4873 $cc $16 $49
    ld   [wCB1E], A                                    ;; 0e:4876 $ea $1e $cb
    ld   A, [HL+]                                      ;; 0e:4879 $2a
    ld   E, A                                          ;; 0e:487a $5f
    ld   A, L                                          ;; 0e:487b $7d
    ld   [wCB21], A                                    ;; 0e:487c $ea $21 $cb
    ld   A, H                                          ;; 0e:487f $7c
    ld   [wCB22], A                                    ;; 0e:4880 $ea $22 $cb
    ld   D, $00                                        ;; 0e:4883 $16 $00
    bit  7, E                                          ;; 0e:4885 $cb $7b
    jr   Z, .jr_0e_488a                                ;; 0e:4887 $28 $01
    dec  D                                             ;; 0e:4889 $15
.jr_0e_488a:
    ld   A, [wCB25]                                    ;; 0e:488a $fa $25 $cb
    ld   L, A                                          ;; 0e:488d $6f
    ld   A, [wCB26]                                    ;; 0e:488e $fa $26 $cb
    ld   H, A                                          ;; 0e:4891 $67
    add  HL, DE                                        ;; 0e:4892 $19
    ld   A, L                                          ;; 0e:4893 $7d
    ldh  [rNR13], A                                    ;; 0e:4894 $e0 $13
    ld   A, H                                          ;; 0e:4896 $7c
    and  A, $07                                        ;; 0e:4897 $e6 $07
    ldh  [rNR14], A                                    ;; 0e:4899 $e0 $14
.jr_0e_489b:
    ld   A, [wCB2C]                                    ;; 0e:489b $fa $2c $cb
    cp   A, $ff                                        ;; 0e:489e $fe $ff
    ret  Z                                             ;; 0e:48a0 $c8
    dec  A                                             ;; 0e:48a1 $3d
    ld   [wCB2C], A                                    ;; 0e:48a2 $ea $2c $cb
    ret  NZ                                            ;; 0e:48a5 $c0
    ld   A, [wCB2F]                                    ;; 0e:48a6 $fa $2f $cb
    ld   L, A                                          ;; 0e:48a9 $6f
    ld   A, [wCB30]                                    ;; 0e:48aa $fa $30 $cb
    ld   H, A                                          ;; 0e:48ad $67
    ld   A, [HL+]                                      ;; 0e:48ae $2a
    or   A, A                                          ;; 0e:48af $b7
    call Z, call_0e_4916                               ;; 0e:48b0 $cc $16 $49
    ld   [wCB2C], A                                    ;; 0e:48b3 $ea $2c $cb
    ld   A, [HL+]                                      ;; 0e:48b6 $2a
    ldh  [rNR12], A                                    ;; 0e:48b7 $e0 $12
    ld   A, [wCB26]                                    ;; 0e:48b9 $fa $26 $cb
    ldh  [rNR14], A                                    ;; 0e:48bc $e0 $14
    ld   A, L                                          ;; 0e:48be $7d
    ld   [wCB2F], A                                    ;; 0e:48bf $ea $2f $cb
    ld   A, H                                          ;; 0e:48c2 $7c
    ld   [wCB30], A                                    ;; 0e:48c3 $ea $30 $cb
    ret                                                ;; 0e:48c6 $c9

call_0e_48c7:
    ld   A, [wCB32]                                    ;; 0e:48c7 $fa $32 $cb
    ld   E, A                                          ;; 0e:48ca $5f
    ld   A, [wCB43]                                    ;; 0e:48cb $fa $43 $cb
    or   A, E                                          ;; 0e:48ce $b3
    ret  NZ                                            ;; 0e:48cf $c0
    ldh  A, [hFFB7]                                    ;; 0e:48d0 $f0 $b7
    or   A, A                                          ;; 0e:48d2 $b7
    ret  Z                                             ;; 0e:48d3 $c8
    ld   A, [wCB41]                                    ;; 0e:48d4 $fa $41 $cb
    cp   A, $0f                                        ;; 0e:48d7 $fe $0f
    ret  Z                                             ;; 0e:48d9 $c8
    ld   A, [wCB36]                                    ;; 0e:48da $fa $36 $cb
    dec  A                                             ;; 0e:48dd $3d
    ld   [wCB36], A                                    ;; 0e:48de $ea $36 $cb
    jr   NZ, .jr_0e_4915                               ;; 0e:48e1 $20 $32
    ld   A, [wCB39]                                    ;; 0e:48e3 $fa $39 $cb
    ld   L, A                                          ;; 0e:48e6 $6f
    ld   A, [wCB3A]                                    ;; 0e:48e7 $fa $3a $cb
    ld   H, A                                          ;; 0e:48ea $67
    ld   A, [HL+]                                      ;; 0e:48eb $2a
    or   A, A                                          ;; 0e:48ec $b7
    call Z, call_0e_4916                               ;; 0e:48ed $cc $16 $49
    ld   [wCB36], A                                    ;; 0e:48f0 $ea $36 $cb
    ld   A, [HL+]                                      ;; 0e:48f3 $2a
    ld   E, A                                          ;; 0e:48f4 $5f
    ld   A, L                                          ;; 0e:48f5 $7d
    ld   [wCB39], A                                    ;; 0e:48f6 $ea $39 $cb
    ld   A, H                                          ;; 0e:48f9 $7c
    ld   [wCB3A], A                                    ;; 0e:48fa $ea $3a $cb
    ld   D, $00                                        ;; 0e:48fd $16 $00
    bit  7, E                                          ;; 0e:48ff $cb $7b
    jr   Z, .jr_0e_4904                                ;; 0e:4901 $28 $01
    dec  D                                             ;; 0e:4903 $15
.jr_0e_4904:
    ld   A, [wCB3D]                                    ;; 0e:4904 $fa $3d $cb
    ld   L, A                                          ;; 0e:4907 $6f
    ld   A, [wCB3E]                                    ;; 0e:4908 $fa $3e $cb
    ld   H, A                                          ;; 0e:490b $67
    add  HL, DE                                        ;; 0e:490c $19
    ld   A, L                                          ;; 0e:490d $7d
    ldh  [rNR33], A                                    ;; 0e:490e $e0 $1d
    ld   A, H                                          ;; 0e:4910 $7c
    and  A, $07                                        ;; 0e:4911 $e6 $07
    ldh  [rNR34], A                                    ;; 0e:4913 $e0 $1e
.jr_0e_4915:
    ret                                                ;; 0e:4915 $c9

call_0e_4916:
    ld   A, [HL+]                                      ;; 0e:4916 $2a
    ld   E, A                                          ;; 0e:4917 $5f
    ld   A, [HL+]                                      ;; 0e:4918 $2a
    ld   [HL], E                                       ;; 0e:4919 $73
    inc  HL                                            ;; 0e:491a $23
    ld   [HL+], A                                      ;; 0e:491b $22
    ld   L, E                                          ;; 0e:491c $6b
    ld   H, A                                          ;; 0e:491d $67
    ld   A, [HL+]                                      ;; 0e:491e $2a
    ret                                                ;; 0e:491f $c9

call_0e_4920:
    dec  A                                             ;; 0e:4920 $3d
    add  A, A                                          ;; 0e:4921 $87
    ld   E, A                                          ;; 0e:4922 $5f
    ld   D, $00                                        ;; 0e:4923 $16 $00
    ld   HL, data_0e_7ac5                              ;; 0e:4925 $21 $c5 $7a
    add  HL, DE                                        ;; 0e:4928 $19
    ld   A, [HL+]                                      ;; 0e:4929 $2a
    ld   [wCBC4], A                                    ;; 0e:492a $ea $c4 $cb
    ld   A, [HL]                                       ;; 0e:492d $7e
    ld   [wCBC5], A                                    ;; 0e:492e $ea $c5 $cb
    ld   HL, data_0e_7b37                              ;; 0e:4931 $21 $37 $7b
    add  HL, DE                                        ;; 0e:4934 $19
    ld   A, [HL+]                                      ;; 0e:4935 $2a
    ld   [wCBC6], A                                    ;; 0e:4936 $ea $c6 $cb
    ld   A, [HL+]                                      ;; 0e:4939 $2a
    ld   [wCBC7], A                                    ;; 0e:493a $ea $c7 $cb
    ld   A, $01                                        ;; 0e:493d $3e $01
    ld   [wCB1A], A                                    ;; 0e:493f $ea $1a $cb
    ld   [wCB4A], A                                    ;; 0e:4942 $ea $4a $cb
    xor  A, A                                          ;; 0e:4945 $af
    ldh  [hFFB2], A                                    ;; 0e:4946 $e0 $b2
    ret                                                ;; 0e:4948 $c9

call_0e_4949:
    ld   A, [wCB1A]                                    ;; 0e:4949 $fa $1a $cb
    or   A, A                                          ;; 0e:494c $b7
    jp   Z, .jp_0e_499f                                ;; 0e:494d $ca $9f $49
    dec  A                                             ;; 0e:4950 $3d
    ld   [wCB1A], A                                    ;; 0e:4951 $ea $1a $cb
    jr   NZ, .jp_0e_499f                               ;; 0e:4954 $20 $49
    ld   A, [wCBC4]                                    ;; 0e:4956 $fa $c4 $cb
    ld   L, A                                          ;; 0e:4959 $6f
    ld   A, [wCBC5]                                    ;; 0e:495a $fa $c5 $cb
    ld   H, A                                          ;; 0e:495d $67
.jr_0e_495e:
    ld   A, [HL+]                                      ;; 0e:495e $2a
    ld   [wCB1A], A                                    ;; 0e:495f $ea $1a $cb
    or   A, A                                          ;; 0e:4962 $b7
    jr   NZ, .jr_0e_496a                               ;; 0e:4963 $20 $05
    call call_0e_414a                                  ;; 0e:4965 $cd $4a $41
    jr   .jp_0e_499f                                   ;; 0e:4968 $18 $35
.jr_0e_496a:
    cp   A, $ef                                        ;; 0e:496a $fe $ef
    jr   NZ, .jr_0e_497d                               ;; 0e:496c $20 $0f
    ld   A, [HL+]                                      ;; 0e:496e $2a
    ld   C, A                                          ;; 0e:496f $4f
    ld   A, [HL+]                                      ;; 0e:4970 $2a
    ld   B, A                                          ;; 0e:4971 $47
    ldh  A, [hFFBC]                                    ;; 0e:4972 $f0 $bc
    dec  A                                             ;; 0e:4974 $3d
    ldh  [hFFBC], A                                    ;; 0e:4975 $e0 $bc
    jr   Z, .jr_0e_495e                                ;; 0e:4977 $28 $e5
    ld   L, C                                          ;; 0e:4979 $69
    ld   H, B                                          ;; 0e:497a $60
    jr   .jr_0e_495e                                   ;; 0e:497b $18 $e1
.jr_0e_497d:
    cp   A, $f0                                        ;; 0e:497d $fe $f0
    jr   C, .jr_0e_4987                                ;; 0e:497f $38 $06
    and  A, $0f                                        ;; 0e:4981 $e6 $0f
    ldh  [hFFBC], A                                    ;; 0e:4983 $e0 $bc
    jr   .jr_0e_495e                                   ;; 0e:4985 $18 $d7
.jr_0e_4987:
    ld   C, $10                                        ;; 0e:4987 $0e $10
    ld   B, $05                                        ;; 0e:4989 $06 $05
.jr_0e_498b:
    ld   A, [HL+]                                      ;; 0e:498b $2a
    ldh  [C], A                                        ;; 0e:498c $e2
    inc  C                                             ;; 0e:498d $0c
    dec  B                                             ;; 0e:498e $05
    jr   NZ, .jr_0e_498b                               ;; 0e:498f $20 $fa
    ldh  A, [rNR51]                                    ;; 0e:4991 $f0 $25
    or   A, $11                                        ;; 0e:4993 $f6 $11
    ldh  [rNR51], A                                    ;; 0e:4995 $e0 $25
    ld   A, L                                          ;; 0e:4997 $7d
    ld   [wCBC4], A                                    ;; 0e:4998 $ea $c4 $cb
    ld   A, H                                          ;; 0e:499b $7c
    ld   [wCBC5], A                                    ;; 0e:499c $ea $c5 $cb
.jp_0e_499f:
    ld   A, [wCB4A]                                    ;; 0e:499f $fa $4a $cb
    or   A, A                                          ;; 0e:49a2 $b7
    jr   Z, .jr_0e_49f4                                ;; 0e:49a3 $28 $4f
    dec  A                                             ;; 0e:49a5 $3d
    ld   [wCB4A], A                                    ;; 0e:49a6 $ea $4a $cb
    jr   NZ, .jr_0e_49f4                               ;; 0e:49a9 $20 $49
    ld   A, [wCBC6]                                    ;; 0e:49ab $fa $c6 $cb
    ld   L, A                                          ;; 0e:49ae $6f
    ld   A, [wCBC7]                                    ;; 0e:49af $fa $c7 $cb
    ld   H, A                                          ;; 0e:49b2 $67
.jr_0e_49b3:
    ld   A, [HL+]                                      ;; 0e:49b3 $2a
    ld   [wCB4A], A                                    ;; 0e:49b4 $ea $4a $cb
    or   A, A                                          ;; 0e:49b7 $b7
    jr   NZ, .jr_0e_49bf                               ;; 0e:49b8 $20 $05
    call call_0e_416b                                  ;; 0e:49ba $cd $6b $41
    jr   .jr_0e_49f4                                   ;; 0e:49bd $18 $35
.jr_0e_49bf:
    cp   A, $ef                                        ;; 0e:49bf $fe $ef
    jr   NZ, .jr_0e_49d2                               ;; 0e:49c1 $20 $0f
    ld   A, [HL+]                                      ;; 0e:49c3 $2a
    ld   C, A                                          ;; 0e:49c4 $4f
    ld   A, [HL+]                                      ;; 0e:49c5 $2a
    ld   B, A                                          ;; 0e:49c6 $47
    ldh  A, [hFFBD]                                    ;; 0e:49c7 $f0 $bd
    dec  A                                             ;; 0e:49c9 $3d
    ldh  [hFFBD], A                                    ;; 0e:49ca $e0 $bd
    jr   Z, .jr_0e_49b3                                ;; 0e:49cc $28 $e5
    ld   L, C                                          ;; 0e:49ce $69
    ld   H, B                                          ;; 0e:49cf $60
    jr   .jr_0e_49b3                                   ;; 0e:49d0 $18 $e1
.jr_0e_49d2:
    cp   A, $f0                                        ;; 0e:49d2 $fe $f0
    jr   C, .jr_0e_49dc                                ;; 0e:49d4 $38 $06
    and  A, $0f                                        ;; 0e:49d6 $e6 $0f
    ldh  [hFFBD], A                                    ;; 0e:49d8 $e0 $bd
    jr   .jr_0e_49b3                                   ;; 0e:49da $18 $d7
.jr_0e_49dc:
    ld   A, [HL+]                                      ;; 0e:49dc $2a
    ldh  [rNR42], A                                    ;; 0e:49dd $e0 $21
    ld   A, [HL+]                                      ;; 0e:49df $2a
    ldh  [rNR43], A                                    ;; 0e:49e0 $e0 $22
    ld   A, $80                                        ;; 0e:49e2 $3e $80
    ldh  [rNR44], A                                    ;; 0e:49e4 $e0 $23
    ldh  A, [rNR51]                                    ;; 0e:49e6 $f0 $25
    or   A, $88                                        ;; 0e:49e8 $f6 $88
    ldh  [rNR51], A                                    ;; 0e:49ea $e0 $25
    ld   A, L                                          ;; 0e:49ec $7d
    ld   [wCBC6], A                                    ;; 0e:49ed $ea $c6 $cb
    ld   A, H                                          ;; 0e:49f0 $7c
    ld   [wCBC7], A                                    ;; 0e:49f1 $ea $c7 $cb
.jr_0e_49f4:
    ret                                                ;; 0e:49f4 $c9

data_0e_49f5:
    db   $68, $4a, $b9, $4a, $e5, $4a, $55, $4b        ;; 0e:49f5 ????????
    db   $2f, $4c, $ab, $4d                            ;; 0e:49fd ????
    dw   .data_0e_4e15                                 ;; 0e:4a01 pP
    dw   .data_0e_4e7a                                 ;; 0e:4a03 pP
    dw   .data_0e_4ed6                                 ;; 0e:4a05 pP
    db   $15, $4f, $42, $4f, $79, $4f                  ;; 0e:4a07 ??????
    dw   .data_0e_4fa9                                 ;; 0e:4a0d pP
    dw   .data_0e_500d                                 ;; 0e:4a0f pP
    dw   .data_0e_5134                                 ;; 0e:4a11 pP
    db   $61, $53, $94, $53, $ca, $53, $ff, $53        ;; 0e:4a13 ????????
    db   $37, $54, $a6, $54, $14, $55, $c5, $55        ;; 0e:4a1b ????????
    db   $a8, $56, $0e, $57, $79, $57, $26, $58        ;; 0e:4a23 ????????
    dw   .data_0e_58e2                                 ;; 0e:4a2b pP
    dw   .data_0e_5968                                 ;; 0e:4a2d pP
    dw   .data_0e_5a10                                 ;; 0e:4a2f pP
    db   $73, $5a, $3a, $5b, $e9, $5c                  ;; 0e:4a31 ??????
    dw   .data_0e_6688                                 ;; 0e:4a37 pP
    dw   .data_0e_674b                                 ;; 0e:4a39 pP
    dw   .data_0e_68b8                                 ;; 0e:4a3b pP
    db   $cd, $6e, $4d, $6f, $64, $71, $dd, $71        ;; 0e:4a3d ????????
    db   $51, $72, $02, $73, $45, $73, $88, $75        ;; 0e:4a45 ????????
    db   $e3, $77, $48, $51, $bf, $51, $80, $52        ;; 0e:4a4d ????????
    dw   .data_0e_5e4d                                 ;; 0e:4a55 pP
    dw   .data_0e_5fa3                                 ;; 0e:4a57 pP
    dw   .data_0e_61c7                                 ;; 0e:4a59 pP
    db   $5c, $63, $39, $64, $ac, $65, $6e, $69        ;; 0e:4a5b ????????
    db   $81, $6c, $ac, $6d, $ff, $e7, $46, $e4        ;; 0e:4a63 ????????
    db   $fe, $79, $e0, $31, $7a, $e5, $80, $e6        ;; 0e:4a6b ????????
    db   $03, $d2, $84, $84, $2b, $aa, $ab, $8d        ;; 0e:4a73 ????????
    db   $5b, $d8, $54, $81, $dc, $8b, $59, $ae        ;; 0e:4a7b ????????
    db   $af, $86, $88, $89, $5b, $58, $1d, $8d        ;; 0e:4a83 ????????
    db   $d8, $83, $84, $83, $84, $86, $53, $83        ;; 0e:4a8b ????????
    db   $84, $86, $84, $86, $88, $54, $83, $84        ;; 0e:4a93 ????????
    db   $81, $dc, $8b, $89, $8b, $5d, $d8, $53        ;; 0e:4a9b ????????
    db   $54, $53, $54, $56, $28, $54, $56, $28        ;; 0e:4aa3 ????????
    db   $54, $56, $28, $dc, $e7, $37, $54, $e7        ;; 0e:4aab ????????
    db   $34, $56, $e7, $32, $08, $ff, $e4, $fe        ;; 0e:4ab3 ????????
    db   $79, $e0, $6f, $7a, $e6, $03, $e5, $40        ;; 0e:4abb ????????
    db   $d2, $0f, $0f, $0f, $0f, $8d, $8b, $5d        ;; 0e:4ac3 ????????
    db   $2b, $2c, $58, $56, $89, $88, $86, $88        ;; 0e:4acb ????????
    db   $59, $5b, $09, $e0, $31, $7a, $2b, $57        ;; 0e:4ad3 ????????
    db   $59, $2b, $57, $59, $2b, $dc, $57, $59        ;; 0e:4adb ????????
    db   $0b, $ff, $e4, $fe, $79, $e8, $85, $7a        ;; 0e:4ae3 ????????
    db   $e0, $40, $e6, $03, $d2, $24, $23, $22        ;; 0e:4aeb ????????
    db   $49, $88, $26, $58, $d8, $53, $51, $56        ;; 0e:4af3 ????????
    db   $54, $dc, $5b, $29, $5b, $59, $28, $5d        ;; 0e:4afb ????????
    db   $5b, $06, $2b, $5d, $d8, $53, $dc, $e6        ;; 0e:4b03 ????????
    db   $02, $a4, $af, $dc, $e6, $01, $ab, $af        ;; 0e:4b0b ????????
    db   $d8, $e6, $02, $a4, $af, $dc, $e6, $01        ;; 0e:4b13 ????????
    db   $ab, $af, $d8, $e6, $03, $50, $52, $e6        ;; 0e:4b1b ????????
    db   $02, $a4, $af, $dc, $e6, $01, $ab, $af        ;; 0e:4b23 ????????
    db   $d8, $e6, $02, $a4, $af, $dc, $e6, $01        ;; 0e:4b2b ????????
    db   $ab, $af, $d8, $e6, $03, $50, $52, $e6        ;; 0e:4b33 ????????
    db   $02, $a4, $af, $dc, $e6, $01, $ab, $af        ;; 0e:4b3b ????????
    db   $d8, $e6, $02, $a4, $af, $dc, $e6, $01        ;; 0e:4b43 ????????
    db   $ab, $af, $d8, $e6, $03, $50, $52, $14        ;; 0e:4b4b ????????
    db   $8e, $ff, $e7, $78, $e0, $3f, $7a, $e5        ;; 0e:4b53 ????????
    db   $40, $e6, $03, $e3, $02, $ea, $02, $d0        ;; 0e:4b5b ????????
    db   $a9, $af, $d8, $a4, $a4, $dc, $a9, $af        ;; 0e:4b63 ????????
    db   $d8, $a5, $a5, $dc, $a9, $af, $d8, $a6        ;; 0e:4b6b ????????
    db   $a6, $dc, $a9, $af, $d8, $a5, $a5, $e9        ;; 0e:4b73 ????????
    db   $62, $4b, $ea, $02, $dc, $ab, $af, $d8        ;; 0e:4b7b ????????
    db   $a6, $a6, $dc, $ab, $af, $d8, $a7, $a7        ;; 0e:4b83 ????????
    db   $dc, $ab, $af, $d8, $a8, $a8, $dc, $ab        ;; 0e:4b8b ????????
    db   $af, $d8, $a7, $a7, $e9, $7f, $4b, $e2        ;; 0e:4b93 ????????
    db   $60, $4b, $e3, $02, $dc, $59, $59, $a9        ;; 0e:4b9b ????????
    db   $af, $84, $a9, $af, $84, $55, $55, $85        ;; 0e:4ba3 ????????
    db   $8c, $89, $85, $57, $57, $a7, $af, $82        ;; 0e:4bab ????????
    db   $a7, $af, $82, $54, $54, $84, $5b, $8b        ;; 0e:4bb3 ????????
    db   $55, $55, $85, $8c, $89, $85, $57, $57        ;; 0e:4bbb ????????
    db   $a7, $af, $82, $a7, $af, $82, $54, $54        ;; 0e:4bc3 ????????
    db   $84, $8b, $84, $8b, $54, $54, $84, $8b        ;; 0e:4bcb ????????
    db   $88, $89, $d8, $e2, $9f, $4b, $dc, $55        ;; 0e:4bd3 ????????
    db   $55, $a5, $ab, $ac, $d8, $a5, $dc, $55        ;; 0e:4bdb ????????
    db   $55, $55, $a5, $ab, $d8, $a2, $a7, $dc        ;; 0e:4be3 ????????
    db   $55, $54, $54, $a4, $a9, $ab, $d8, $a4        ;; 0e:4beb ????????
    db   $dc, $84, $d8, $84, $e0, $55, $7a, $dc        ;; 0e:4bf3 ????????
    db   $59, $d8, $59, $57, $dc, $87, $55, $e0        ;; 0e:4bfb ????????
    db   $3f, $7a, $85, $8b, $8c, $85, $85, $8b        ;; 0e:4c03 ????????
    db   $8c, $86, $86, $89, $8c, $86, $86, $89        ;; 0e:4c0b ????????
    db   $e0, $55, $7a, $54, $e0, $3f, $7a, $84        ;; 0e:4c13 ????????
    db   $89, $8b, $84, $84, $89, $8b, $84, $84        ;; 0e:4c1b ????????
    db   $8b, $d8, $82, $dc, $84, $84, $8b, $d8        ;; 0e:4c23 ????????
    db   $82, $e1, $9d, $4b, $e0, $43, $7a, $e5        ;; 0e:4c2b ????????
    db   $00, $e6, $03, $e3, $02, $ea, $02, $d1        ;; 0e:4c33 ????????
    db   $a9, $a9, $a9, $a9, $ac, $a9, $a9, $a9        ;; 0e:4c3b ????????
    db   $d8, $a2, $dc, $a9, $d8, $a3, $dc, $a9        ;; 0e:4c43 ????????
    db   $d8, $a2, $80, $a0, $e9, $3a, $4c, $ea        ;; 0e:4c4b ????????
    db   $02, $dc, $ab, $ab, $ab, $ab, $d8, $a2        ;; 0e:4c53 ????????
    db   $dc, $ab, $ab, $ab, $d8, $a4, $dc, $ab        ;; 0e:4c5b ????????
    db   $d8, $a5, $dc, $ab, $d8, $a4, $82, $a2        ;; 0e:4c63 ????????
    db   $e9, $54, $4c, $e2, $38, $4c, $e3, $02        ;; 0e:4c6b ????????
    db   $e6, $02, $dc, $a9, $a9, $a9, $a9, $ac        ;; 0e:4c73 ????????
    db   $a9, $a9, $a9, $d8, $a2, $dc, $a9, $d8        ;; 0e:4c7b ????????
    db   $a4, $dc, $a9, $d8, $a2, $80, $a0, $e6        ;; 0e:4c83 ????????
    db   $01, $dc, $a5, $a5, $a5, $a5, $a9, $a5        ;; 0e:4c8b ????????
    db   $a5, $a5, $ab, $a5, $ac, $a5, $ab, $89        ;; 0e:4c93 ????????
    db   $a9, $e6, $02, $a7, $a7, $a7, $a7, $ab        ;; 0e:4c9b ????????
    db   $a7, $a7, $a7, $ac, $a7, $d8, $a2, $dc        ;; 0e:4ca3 ????????
    db   $a7, $ac, $8b, $ab, $e6, $01, $a4, $a4        ;; 0e:4cab ????????
    db   $a4, $a4, $a8, $a4, $a4, $a4, $a9, $a4        ;; 0e:4cb3 ????????
    db   $ab, $a4, $a9, $88, $a8, $e6, $02, $a5        ;; 0e:4cbb ????????
    db   $a5, $a5, $a5, $a9, $a5, $a5, $a5, $ab        ;; 0e:4cc3 ????????
    db   $a5, $ac, $a5, $ab, $89, $a9, $e6, $01        ;; 0e:4ccb ????????
    db   $a7, $a7, $a7, $a7, $ab, $a7, $a7, $a7        ;; 0e:4cd3 ????????
    db   $ac, $a7, $d8, $a2, $dc, $a7, $ac, $8b        ;; 0e:4cdb ????????
    db   $ab, $e6, $02, $a4, $a4, $a4, $a4, $a9        ;; 0e:4ce3 ????????
    db   $a4, $a4, $a4, $ab, $a4, $ac, $a4, $ab        ;; 0e:4ceb ????????
    db   $89, $a9, $e6, $01, $a4, $a4, $a4, $a4        ;; 0e:4cf3 ????????
    db   $d8, $a4, $dc, $a4, $a4, $a4, $d8, $a2        ;; 0e:4cfb ????????
    db   $dc, $a4, $ac, $a4, $ab, $a9, $a8, $ab        ;; 0e:4d03 ????????
    db   $d8, $e2, $73, $4c, $e6, $02, $80, $a4        ;; 0e:4d0b ????????
    db   $a5, $80, $a4, $a5, $80, $a4, $a5, $80        ;; 0e:4d13 ????????
    db   $a4, $a5, $e6, $01, $dc, $8b, $d8, $a2        ;; 0e:4d1b ????????
    db   $a7, $dc, $8b, $d8, $a2, $a7, $dc, $8b        ;; 0e:4d23 ????????
    db   $d8, $a2, $a7, $dc, $8b, $d8, $a2, $a7        ;; 0e:4d2b ????????
    db   $e6, $02, $dc, $8b, $d8, $a2, $a7, $dc        ;; 0e:4d33 ????????
    db   $8b, $d8, $a2, $a7, $dc, $8b, $d8, $a2        ;; 0e:4d3b ????????
    db   $a7, $dc, $8b, $d8, $a2, $a7, $e0, $57        ;; 0e:4d43 ????????
    db   $7a, $e6, $03, $89, $84, $80, $89, $87        ;; 0e:4d4b ????????
    db   $82, $dc, $8b, $e6, $02, $5c, $e0, $43        ;; 0e:4d53 ????????
    db   $7a, $ac, $ac, $d8, $85, $a5, $a5, $84        ;; 0e:4d5b ????????
    db   $a4, $a4, $82, $a0, $a0, $e6, $01, $80        ;; 0e:4d63 ????????
    db   $a0, $a0, $84, $a4, $a4, $82, $a2, $a2        ;; 0e:4d6b ????????
    db   $80, $a0, $a0, $e6, $03, $dc, $ab, $ab        ;; 0e:4d73 ????????
    db   $ab, $ab, $d8, $a2, $dc, $ab, $ab, $ab        ;; 0e:4d7b ????????
    db   $d8, $a4, $dc, $ab, $d8, $a5, $dc, $ab        ;; 0e:4d83 ????????
    db   $d8, $a4, $82, $a2, $e6, $02, $dc, $a4        ;; 0e:4d8b ????????
    db   $a4, $a4, $a4, $e6, $03, $a8, $a4, $a4        ;; 0e:4d93 ????????
    db   $a4, $e6, $01, $a9, $a4, $ab, $a4, $e6        ;; 0e:4d9b ????????
    db   $03, $a9, $88, $a8, $d8, $e1, $71, $4c        ;; 0e:4da3 ????????
    db   $e4, $1b, $7a, $e8, $b5, $7a, $e0, $20        ;; 0e:4dab ????????
    db   $e6, $03, $0f, $0f, $0f, $0f, $0f, $0f        ;; 0e:4db3 ????????
    db   $0f, $0f, $e3, $02, $d4, $24, $8e, $dc        ;; 0e:4dbb ????????
    db   $89, $8c, $d8, $84, $75, $ce, $cf, $85        ;; 0e:4dc3 ????????
    db   $54, $82, $50, $22, $8e, $dc, $87, $8b        ;; 0e:4dcb ????????
    db   $d8, $82, $74, $ce, $cf, $84, $42, $54        ;; 0e:4dd3 ????????
    db   $20, $8e, $dc, $85, $89, $8c, $d8, $72        ;; 0e:4ddb ????????
    db   $ce, $cf, $82, $40, $52, $dc, $0b, $5e        ;; 0e:4de3 ????????
    db   $1f, $e2, $bf, $4d, $4c, $49, $5c, $d8        ;; 0e:4deb ????????
    db   $42, $dc, $2b, $8e, $d8, $42, $dc, $4b        ;; 0e:4df3 ????????
    db   $d8, $52, $54, $85, $84, $82, $84, $82        ;; 0e:4dfb ????????
    db   $00, $dc, $ab, $ac, $d8, $52, $50, $dc        ;; 0e:4e03 ????????
    db   $8b, $89, $8c, $0b, $8e, $5e, $1f, $e1        ;; 0e:4e0b ????????
    db   $bd, $4d                                      ;; 0e:4e13 ??
.data_0e_4e15:
    db   $e7, $7d, $e4, $fe, $79, $e0, $55, $7a        ;; 0e:4e15 ........
    db   $e5, $40, $e6, $03, $d3, $b7, $b8, $b9        ;; 0e:4e1d ...w....
    db   $e7, $78, $5a, $e7, $73, $e0, $3f, $7a        ;; 0e:4e25 ........
    db   $9a, $9a, $9a, $e7, $6e, $e0, $55, $7a        ;; 0e:4e2d ........
    db   $89, $87, $e7, $69, $85, $89, $e0, $6b        ;; 0e:4e35 ........
    db   $7a, $17, $e7, $7d, $e0, $55, $7a, $dc        ;; 0e:4e3d ..??????
    db   $b6, $b7, $b9, $bb, $d8, $b0, $b2, $54        ;; 0e:4e45 ????????
    db   $54, $82, $54, $84, $82, $54, $85, $54        ;; 0e:4e4d ????????
    db   $52, $54, $54, $82, $54, $84, $82, $54        ;; 0e:4e55 ????????
    db   $85, $54, $52, $87, $85, $83, $55, $85        ;; 0e:4e5d ????????
    db   $83, $85, $57, $55, $53, $55, $87, $85        ;; 0e:4e65 ????????
    db   $83, $55, $85, $83, $85, $57, $55, $83        ;; 0e:4e6d ????????
    db   $55, $85, $e1, $4c, $4e                       ;; 0e:4e75 ?????
.data_0e_4e7a:
    db   $e4, $fe, $79, $e0, $57, $7a, $e5, $40        ;; 0e:4e7a ........
    db   $e6, $03, $d3, $b4, $b5, $b6, $57, $e0        ;; 0e:4e82 .w......
    db   $43, $7a, $97, $95, $93, $e0, $57, $7a        ;; 0e:4e8a ........
    db   $50, $dc, $59, $e0, $6d, $7a, $1b, $e0        ;; 0e:4e92 .......?
    db   $57, $7a, $b2, $b4, $b6, $b7, $b9, $bb        ;; 0e:4e9a ????????
    db   $5c, $5c, $8b, $5c, $8c, $8b, $5c, $d8        ;; 0e:4ea2 ????????
    db   $82, $50, $dc, $5b, $5c, $5c, $8b, $5c        ;; 0e:4eaa ????????
    db   $8c, $8b, $5c, $d8, $82, $50, $dc, $5b        ;; 0e:4eb2 ????????
    db   $d8, $83, $81, $80, $51, $81, $80, $81        ;; 0e:4eba ????????
    db   $53, $51, $50, $51, $83, $81, $80, $51        ;; 0e:4ec2 ????????
    db   $81, $80, $81, $53, $51, $80, $51, $dc        ;; 0e:4eca ????????
    db   $81, $e1, $a2, $4e                            ;; 0e:4ed2 ????
.data_0e_4ed6:
    db   $e4, $fe, $79, $e8, $a5, $7a, $e0, $20        ;; 0e:4ed6 ........
    db   $e6, $03, $d2, $8f, $53, $d8, $93, $dc        ;; 0e:4ede .w......
    db   $9a, $97, $55, $dc, $55, $17, $5f, $d8        ;; 0e:4ee6 ......??
    db   $e3, $08, $e6, $03, $80, $e6, $01, $ab        ;; 0e:4eee ????????
    db   $ac, $e6, $03, $dc, $87, $e6, $02, $d8        ;; 0e:4ef6 ????????
    db   $ab, $d8, $a2, $dc, $e2, $f0, $4e, $e3        ;; 0e:4efe ????????
    db   $08, $e6, $03, $81, $ad, $af, $a7, $a8        ;; 0e:4f06 ????????
    db   $8d, $e2, $07, $4f, $e1, $ee, $4e, $e7        ;; 0e:4f0e ????????
    db   $96, $e4, $fe, $79, $e0, $53, $7a, $e5        ;; 0e:4f16 ????????
    db   $40, $e6, $03, $e3, $04, $d3, $ab, $ac        ;; 0e:4f1e ????????
    db   $a6, $a7, $dc, $ab, $ac, $a6, $a7, $e2        ;; 0e:4f26 ????????
    db   $23, $4f, $e3, $04, $a5, $a4, $aa, $a9        ;; 0e:4f2e ????????
    db   $d8, $a3, $a2, $a8, $a7, $dc, $e2, $32        ;; 0e:4f36 ????????
    db   $4f, $e1, $21, $4f, $e4, $fe, $79, $e0        ;; 0e:4f3e ????????
    db   $57, $7a, $e5, $40, $e3, $04, $e6, $02        ;; 0e:4f46 ????????
    db   $d1, $a0, $af, $e6, $03, $a0, $af, $e6        ;; 0e:4f4e ????????
    db   $01, $a0, $af, $e6, $03, $a0, $af, $e2        ;; 0e:4f56 ????????
    db   $4c, $4f, $dc, $e3, $04, $e6, $01, $aa        ;; 0e:4f5e ????????
    db   $af, $e6, $03, $aa, $af, $e6, $02, $aa        ;; 0e:4f66 ????????
    db   $af, $e6, $03, $aa, $af, $e2, $63, $4f        ;; 0e:4f6e ????????
    db   $e1, $4a, $4f, $e4, $fe, $79, $e8, $85        ;; 0e:4f76 ????????
    db   $7a, $e0, $40, $e6, $03, $e3, $04, $d2        ;; 0e:4f7e ????????
    db   $a0, $ac, $a3, $d8, $a3, $dc, $a6, $d8        ;; 0e:4f86 ????????
    db   $a6, $dc, $a3, $d8, $a3, $e2, $85, $4f        ;; 0e:4f8e ????????
    db   $e3, $04, $dd, $aa, $d8, $aa, $a1, $ad        ;; 0e:4f96 ????????
    db   $a0, $ac, $a3, $d8, $a3, $e2, $98, $4f        ;; 0e:4f9e ????????
    db   $e1, $83, $4f                                 ;; 0e:4fa6 ???
.data_0e_4fa9:
    db   $e7, $4b, $e4, $fe, $79, $e0, $31, $7a        ;; 0e:4fa9 ........
    db   $e5, $80, $e6, $02, $d1, $d8, $82, $82        ;; 0e:4fb1 ...w....
    db   $29, $a8, $a9, $8b, $09, $e6, $03, $d8        ;; 0e:4fb9 ......w.
    db   $82, $82, $29, $a8, $a9, $8b, $09             ;; 0e:4fc1 .......
.data_0e_4fc8:
    db   $46, $86, $87, $86, $84, $87, $56, $22        ;; 0e:4fc8 ........
    db   $dc, $59, $5a, $d8, $52, $54, $52, $22        ;; 0e:4fd0 ........
    db   $21, $46, $86, $87, $86, $84, $87, $56        ;; 0e:4fd8 ........
    db   $22, $dc, $59, $5a, $d8, $52, $54, $52        ;; 0e:4fe0 ........
    db   $19, $5f, $82, $82, $29, $a8, $a9, $8b        ;; 0e:4fe8 ........
    db   $59, $22, $52, $4a, $8a, $5c, $5a, $19        ;; 0e:4ff0 ........
    db   $5f, $82, $82, $29, $a8, $a9, $8b, $59        ;; 0e:4ff8 ........
    db   $22, $52, $d8, $42, $82, $50, $dc, $5a        ;; 0e:5000 ........
    db   $19, $5f, $e1                                 ;; 0e:5008 ...
    dw   .data_0e_4fc8                                 ;; 0e:500b pP
.data_0e_500d:
    db   $e0, $31, $7a, $e5, $80, $e6, $01, $0f        ;; 0e:500d ......w.
    db   $d2, $82, $82, $29, $a8, $a9, $8b, $09        ;; 0e:5015 ........
    db   $e6, $02, $d8, $82, $82, $29, $a8, $a9        ;; 0e:501d .w......
    db   $8b, $dc, $e5, $40, $e0, $5b, $7a             ;; 0e:5025 .......
.data_0e_502c:
    db   $e0, $5b, $7a, $a9, $a4, $a6, $a2, $e6        ;; 0e:502c ........
    db   $03, $e0, $5f, $7a, $a9, $a4, $a6, $a2        ;; 0e:5034 w.......
    db   $e0, $63, $7a, $a9, $a4, $a6, $a2, $e6        ;; 0e:503c ........
    db   $01, $e0, $67, $7a, $a9, $a4, $a6, $a2        ;; 0e:5044 w.......
    db   $e0, $5b, $7a, $a9, $a4, $a6, $a2, $e6        ;; 0e:504c ........
    db   $03, $e0, $5f, $7a, $a9, $a4, $a6, $a2        ;; 0e:5054 w.......
    db   $e0, $63, $7a, $a9, $a4, $a6, $a2, $e6        ;; 0e:505c ........
    db   $02, $e0, $67, $7a, $a9, $a4, $a6, $a2        ;; 0e:5064 w.......
    db   $e0, $5b, $7a, $aa, $a4, $a5, $a2, $e6        ;; 0e:506c ........
    db   $03, $e0, $5f, $7a, $aa, $a4, $a5, $a2        ;; 0e:5074 w.......
    db   $e0, $63, $7a, $aa, $a4, $a5, $a2, $e6        ;; 0e:507c ........
    db   $01, $e0, $67, $7a, $aa, $a4, $a5, $a2        ;; 0e:5084 w.......
    db   $e0, $5b, $7a, $a9, $a2, $a4, $a2, $e6        ;; 0e:508c ........
    db   $03, $e0, $5f, $7a, $a9, $a2, $a4, $a2        ;; 0e:5094 w.......
    db   $e0, $63, $7a, $a9, $a1, $a4, $a1, $e6        ;; 0e:509c ........
    db   $02, $e0, $67, $7a, $a9, $a1, $a4, $a1        ;; 0e:50a4 w.......
    db   $e3, $03                                      ;; 0e:50ac ..
.data_0e_50ae:
    db   $e0, $5b, $7a, $a9, $a4, $a6, $a2, $e6        ;; 0e:50ae ........
    db   $03, $e0, $5f, $7a, $a9, $a4, $a6, $a2        ;; 0e:50b6 w.......
    db   $e0, $63, $7a, $a9, $a4, $a6, $a2, $e6        ;; 0e:50be ........
    db   $01, $e0, $67, $7a, $a9, $a4, $a6, $a2        ;; 0e:50c6 w.......
    db   $e0, $5b, $7a, $a9, $a4, $a6, $a2, $e6        ;; 0e:50ce ........
    db   $03, $e0, $5f, $7a, $a9, $a4, $a6, $a2        ;; 0e:50d6 w.......
    db   $e0, $63, $7a, $a9, $a4, $a6, $a2, $e6        ;; 0e:50de ........
    db   $02, $e0, $67, $7a, $a9, $a4, $a6, $a2        ;; 0e:50e6 w.......
    db   $e0, $5b, $7a, $aa, $a4, $a5, $a2, $e6        ;; 0e:50ee ........
    db   $03, $e0, $5f, $7a, $aa, $a4, $a5, $a2        ;; 0e:50f6 w.......
    db   $e0, $63, $7a, $aa, $a4, $a5, $a2, $e6        ;; 0e:50fe ........
    db   $01, $e0, $67, $7a, $aa, $a4, $a5, $a2        ;; 0e:5106 w.......
    db   $e0, $5b, $7a, $a9, $a2, $a4, $a1, $e6        ;; 0e:510e ........
    db   $03, $e0, $5f, $7a, $a9, $a2, $a4, $a1        ;; 0e:5116 w.......
    db   $e0, $63, $7a, $a9, $a2, $a4, $a1, $e6        ;; 0e:511e ........
    db   $02, $e0, $67, $7a, $a9, $a2, $a4, $a1        ;; 0e:5126 w.......
    db   $e2                                           ;; 0e:512e .
    dw   .data_0e_50ae                                 ;; 0e:512f pP
    db   $e1                                           ;; 0e:5131 .
    dw   .data_0e_502c                                 ;; 0e:5132 pP
.data_0e_5134:
    db   $e8, $75, $7a, $e0, $40, $e6, $03, $0f        ;; 0e:5134 ......w.
    db   $0f, $0f, $0f                                 ;; 0e:513c ...
.data_0e_513f:
    db   $d2, $02, $00, $dc, $0a, $09, $e1             ;; 0e:513f .......
    dw   .data_0e_513f                                 ;; 0e:5146 pP
    db   $e4, $fe, $79, $e0, $31, $7a, $e5, $80        ;; 0e:5148 ????????
    db   $e7, $4c, $e6, $03, $e3, $02, $d2, $8b        ;; 0e:5150 ????????
    db   $d8, $86, $87, $89, $0b, $8b, $89, $d8        ;; 0e:5158 ????????
    db   $82, $dc, $8b, $07, $2f, $86, $84, $89        ;; 0e:5160 ????????
    db   $82, $eb, $01, $7f, $51, $10, $80, $82        ;; 0e:5168 ????????
    db   $44, $84, $52, $50, $dc, $4b, $8b, $5a        ;; 0e:5170 ????????
    db   $5d, $d8, $24, $23, $e2, $56, $51, $20        ;; 0e:5178 ????????
    db   $8e, $dc, $8b, $8c, $d8, $87, $56, $54        ;; 0e:5180 ????????
    db   $52, $56, $04, $0e, $e3, $02, $82, $84        ;; 0e:5188 ????????
    db   $85, $89, $5c, $8b, $89, $5b, $17, $84        ;; 0e:5190 ????????
    db   $85, $89, $8c, $d8, $54, $82, $80, $eb        ;; 0e:5198 ????????
    db   $01, $a8, $51, $02, $dc, $e2, $8e, $51        ;; 0e:51a0 ????????
    db   $dc, $5b, $e7, $4a, $8e, $e7, $48, $8e        ;; 0e:51a8 ????????
    db   $e7, $46, $8e, $e7, $43, $8e, $e7, $3f        ;; 0e:51b0 ????????
    db   $8e, $e7, $37, $8e, $e1, $50, $51, $e4        ;; 0e:51b8 ????????
    db   $fe, $79, $e0, $4b, $7a, $e5, $40, $e6        ;; 0e:51c0 ????????
    db   $03, $e3, $02, $d2, $84, $87, $84, $87        ;; 0e:51c8 ????????
    db   $84, $87, $84, $87, $86, $89, $86, $89        ;; 0e:51d0 ????????
    db   $86, $89, $86, $89, $84, $8b, $84, $8b        ;; 0e:51d8 ????????
    db   $84, $8b, $84, $8b, $86, $89, $86, $89        ;; 0e:51e0 ????????
    db   $86, $89, $86, $89, $84, $87, $84, $87        ;; 0e:51e8 ????????
    db   $84, $87, $84, $87, $86, $89, $86, $89        ;; 0e:51f0 ????????
    db   $86, $89, $86, $89, $eb, $01, $13, $52        ;; 0e:51f8 ????????
    db   $84, $86, $84, $86, $84, $86, $84, $86        ;; 0e:5200 ????????
    db   $84, $86, $84, $86, $83, $86, $83, $89        ;; 0e:5208 ????????
    db   $e2, $cb, $51, $84, $87, $84, $87, $84        ;; 0e:5210 ????????
    db   $87, $84, $87, $84, $87, $84, $87, $84        ;; 0e:5218 ????????
    db   $87, $84, $87, $e0, $36, $7a, $e5, $40        ;; 0e:5220 ????????
    db   $e6, $02, $25, $e5, $80, $e6, $01, $85        ;; 0e:5228 ????????
    db   $87, $89, $8c, $d8, $52, $e5, $40, $e6        ;; 0e:5230 ????????
    db   $02, $dc, $82, $84, $85, $87, $89, $8b        ;; 0e:5238 ????????
    db   $29, $e5, $00, $e6, $01, $85, $87, $89        ;; 0e:5240 ????????
    db   $8c, $5b, $e5, $40, $e6, $02, $dc, $8b        ;; 0e:5248 ????????
    db   $8c, $d8, $82, $84, $85, $87, $25, $e5        ;; 0e:5250 ????????
    db   $80, $e6, $01, $85, $87, $89, $8c, $d8        ;; 0e:5258 ????????
    db   $52, $e5, $40, $e6, $02, $dc, $82, $84        ;; 0e:5260 ????????
    db   $85, $87, $89, $8b, $29, $e5, $00, $e6        ;; 0e:5268 ????????
    db   $03, $85, $87, $89, $8c, $8b, $86, $84        ;; 0e:5270 ????????
    db   $86, $83, $89, $87, $86, $e1, $bf, $51        ;; 0e:5278 ????????
    db   $e4, $fe, $79, $e8, $75, $7a, $e0, $40        ;; 0e:5280 ????????
    db   $e6, $03, $d2, $14, $ae, $af, $84, $02        ;; 0e:5288 ????????
    db   $10, $ae, $af, $80, $dc, $0b, $19, $ae        ;; 0e:5290 ????????
    db   $af, $89, $d8, $02, $26, $21, $dc, $0b        ;; 0e:5298 ????????
    db   $d8, $14, $ae, $af, $84, $02, $10, $ae        ;; 0e:52a0 ????????
    db   $af, $80, $dc, $0b, $19, $ae, $af, $89        ;; 0e:52a8 ????????
    db   $0b, $1c, $ae, $af, $8c, $0d, $d8, $82        ;; 0e:52b0 ????????
    db   $8f, $e0, $40, $e6, $01, $82, $8f, $e0        ;; 0e:52b8 ????????
    db   $40, $e6, $02, $89, $8f, $e0, $60, $e6        ;; 0e:52c0 ????????
    db   $03, $89, $8f, $e0, $40, $e6, $01, $dc        ;; 0e:52c8 ????????
    db   $87, $8f, $e0, $60, $e6, $03, $d8, $87        ;; 0e:52d0 ????????
    db   $8f, $e0, $40, $e6, $02, $82, $8f, $e0        ;; 0e:52d8 ????????
    db   $60, $e6, $03, $87, $8f, $e0, $40, $85        ;; 0e:52e0 ????????
    db   $8f, $e0, $60, $e6, $02, $85, $8f, $e0        ;; 0e:52e8 ????????
    db   $40, $e6, $01, $8c, $8f, $e0, $60, $e6        ;; 0e:52f0 ????????
    db   $03, $8c, $8f, $e0, $40, $e6, $02, $dc        ;; 0e:52f8 ????????
    db   $87, $8f, $e0, $60, $e6, $03, $d8, $87        ;; 0e:5300 ????????
    db   $8f, $e0, $40, $e6, $01, $82, $8f, $e0        ;; 0e:5308 ????????
    db   $60, $e6, $03, $87, $8f, $e0, $40, $82        ;; 0e:5310 ????????
    db   $8f, $e0, $60, $e6, $01, $82, $8f, $e0        ;; 0e:5318 ????????
    db   $40, $e6, $02, $89, $8f, $e0, $60, $e6        ;; 0e:5320 ????????
    db   $03, $89, $8f, $e0, $40, $e6, $01, $dc        ;; 0e:5328 ????????
    db   $87, $8f, $e0, $60, $e6, $03, $d8, $87        ;; 0e:5330 ????????
    db   $8f, $e0, $40, $e6, $02, $82, $8f, $e0        ;; 0e:5338 ????????
    db   $60, $e6, $03, $87, $8f, $e0, $40, $85        ;; 0e:5340 ????????
    db   $8f, $e0, $60, $e6, $02, $85, $8f, $e0        ;; 0e:5348 ????????
    db   $40, $e6, $01, $8c, $8f, $e0, $40, $e6        ;; 0e:5350 ????????
    db   $03, $8c, $8f, $2b, $dc, $2b, $e1, $8a        ;; 0e:5358 ????????
    db   $52, $e7, $78, $e4, $24, $7a, $e5, $00        ;; 0e:5360 ????????
    db   $e0, $69, $7a, $e6, $03, $0f, $0f, $0f        ;; 0e:5368 ????????
    db   $0f, $0f, $0f, $d4, $10, $dc, $07, $2e        ;; 0e:5370 ????????
    db   $57, $55, $57, $1a, $05, $2e, $1f, $1c        ;; 0e:5378 ????????
    db   $07, $2e, $57, $55, $57, $28, $53, $1d        ;; 0e:5380 ????????
    db   $e6, $02, $e0, $6f, $7a, $d8, $28, $53        ;; 0e:5388 ????????
    db   $1d, $e1, $68, $53, $e4, $fe, $79, $e0        ;; 0e:5390 ????????
    db   $73, $7a, $e5, $80, $e6, $02, $af, $e3        ;; 0e:5398 ????????
    db   $02, $d2, $80, $82, $85, $87, $89, $8c        ;; 0e:53a0 ????????
    db   $d8, $82, $85, $87, $89, $8c, $d8, $82        ;; 0e:53a8 ????????
    db   $e2, $a1, $53, $e3, $02, $dd, $81, $83        ;; 0e:53b0 ????????
    db   $86, $88, $8a, $8d, $d8, $83, $86, $88        ;; 0e:53b8 ????????
    db   $8a, $8d, $d8, $83, $e2, $b5, $53, $e1        ;; 0e:53c0 ????????
    db   $9f, $53, $e4, $fe, $79, $e8, $75, $7a        ;; 0e:53c8 ????????
    db   $e0, $40, $e6, $01, $e3, $02, $d3, $80        ;; 0e:53d0 ????????
    db   $82, $85, $87, $89, $8c, $d8, $82, $85        ;; 0e:53d8 ????????
    db   $87, $89, $8c, $d8, $82, $e2, $d6, $53        ;; 0e:53e0 ????????
    db   $e3, $02, $dd, $81, $83, $86, $88, $8a        ;; 0e:53e8 ????????
    db   $8d, $d8, $83, $86, $88, $8a, $8d, $d8        ;; 0e:53f0 ????????
    db   $83, $e2, $ea, $53, $e1, $d4, $53, $e7        ;; 0e:53f8 ????????
    db   $46, $e4, $fe, $79, $e0, $31, $7a, $e5        ;; 0e:5400 ????????
    db   $80, $e6, $03, $d3, $57, $85, $84, $45        ;; 0e:5408 ????????
    db   $85, $83, $dc, $8a, $8c, $8d, $5c, $5a        ;; 0e:5410 ????????
    db   $88, $8c, $d8, $85, $88, $87, $82, $85        ;; 0e:5418 ????????
    db   $84, $07, $54, $82, $81, $42, $82, $81        ;; 0e:5420 ????????
    db   $dc, $88, $8b, $89, $5d, $5b, $49, $89        ;; 0e:5428 ????????
    db   $58, $88, $89, $09, $e1, $0b, $54, $e4        ;; 0e:5430 ????????
    db   $fe, $79, $e0, $73, $7a, $e5, $80, $e6        ;; 0e:5438 ????????
    db   $02, $af, $d2, $80, $87, $8c, $d8, $84        ;; 0e:5440 ????????
    db   $dc, $81, $88, $8d, $d8, $85, $dc, $83        ;; 0e:5448 ????????
    db   $8a, $d8, $83, $87, $dc, $88, $8c, $87        ;; 0e:5450 ????????
    db   $d8, $83, $dc, $85, $88, $8c, $d8, $85        ;; 0e:5458 ????????
    db   $dc, $87, $d8, $82, $87, $8b, $dc, $80        ;; 0e:5460 ????????
    db   $87, $8c, $d8, $84, $dc, $81, $87, $8d        ;; 0e:5468 ????????
    db   $d8, $85, $dd, $89, $d8, $84, $89, $8d        ;; 0e:5470 ????????
    db   $dc, $8b, $d8, $86, $8b, $d8, $82, $dc        ;; 0e:5478 ????????
    db   $81, $88, $8d, $d8, $85, $dc, $86, $89        ;; 0e:5480 ????????
    db   $84, $8b, $82, $89, $d8, $82, $86, $dc        ;; 0e:5488 ????????
    db   $84, $88, $8b, $d8, $84, $dd, $85, $8c        ;; 0e:5490 ????????
    db   $d8, $89, $d8, $85, $dd, $87, $d8, $82        ;; 0e:5498 ????????
    db   $8b, $d8, $87, $e1, $42, $54, $e4, $fe        ;; 0e:54a0 ????????
    db   $79, $e8, $75, $7a, $e0, $40, $e6, $01        ;; 0e:54a8 ????????
    db   $d3, $80, $87, $8c, $d8, $84, $dc, $81        ;; 0e:54b0 ????????
    db   $88, $8d, $d8, $85, $dc, $83, $8a, $d8        ;; 0e:54b8 ????????
    db   $83, $87, $dc, $88, $8c, $87, $d8, $83        ;; 0e:54c0 ????????
    db   $dc, $85, $88, $8c, $d8, $85, $dc, $87        ;; 0e:54c8 ????????
    db   $d8, $82, $87, $8b, $dc, $80, $87, $8c        ;; 0e:54d0 ????????
    db   $d8, $84, $dc, $81, $87, $8d, $d8, $85        ;; 0e:54d8 ????????
    db   $dd, $89, $d8, $84, $89, $8d, $dc, $8b        ;; 0e:54e0 ????????
    db   $d8, $86, $8b, $d8, $82, $dc, $81, $88        ;; 0e:54e8 ????????
    db   $8d, $d8, $85, $dc, $86, $89, $84, $8b        ;; 0e:54f0 ????????
    db   $82, $89, $d8, $82, $86, $dc, $84, $88        ;; 0e:54f8 ????????
    db   $8b, $d8, $84, $dd, $85, $8c, $d8, $89        ;; 0e:5500 ????????
    db   $d8, $85, $dd, $87, $d8, $82, $8b, $d8        ;; 0e:5508 ????????
    db   $87, $e1, $b0, $54, $e7, $55, $e4, $fe        ;; 0e:5510 ????????
    db   $79, $e0, $36, $7a, $e6, $03, $e3, $02        ;; 0e:5518 ????????
    db   $e5, $80, $d2, $a8, $aa, $ab, $aa, $ab        ;; 0e:5520 ????????
    db   $ad, $d8, $a3, $a1, $dc, $ab, $ad, $ab        ;; 0e:5528 ????????
    db   $aa, $a8, $aa, $a8, $a6, $e5, $40, $a8        ;; 0e:5530 ????????
    db   $aa, $ab, $aa, $ab, $ad, $d8, $a3, $a1        ;; 0e:5538 ????????
    db   $dc, $ab, $ad, $ab, $aa, $a8, $aa, $a8        ;; 0e:5540 ????????
    db   $a6, $e5, $80, $a4, $a6, $a7, $a6, $a7        ;; 0e:5548 ????????
    db   $a9, $ab, $a9, $a7, $a9, $a7, $a6, $a4        ;; 0e:5550 ????????
    db   $a6, $a4, $a2, $eb, $01, $74, $55, $e5        ;; 0e:5558 ????????
    db   $40, $a4, $a6, $a7, $a6, $a7, $a9, $ab        ;; 0e:5560 ????????
    db   $a9, $a7, $a9, $a7, $a6, $a4, $a6, $a7        ;; 0e:5568 ????????
    db   $a9, $e2, $20, $55, $e5, $40, $a4, $a6        ;; 0e:5570 ????????
    db   $a7, $a6, $a7, $a9, $ab, $a9, $a7, $a9        ;; 0e:5578 ????????
    db   $a7, $a6, $a4, $a6, $a4, $a2, $e3, $06        ;; 0e:5580 ????????
    db   $e5, $00, $a1, $af, $c1, $cf, $c1, $cf        ;; 0e:5588 ????????
    db   $e2, $88, $55, $81, $a2, $af, $81, $a2        ;; 0e:5590 ????????
    db   $af, $e3, $06, $a3, $af, $c3, $cf, $c3        ;; 0e:5598 ????????
    db   $cf, $e2, $9b, $55, $83, $a4, $af, $83        ;; 0e:55a0 ????????
    db   $a4, $af, $e5, $40, $45, $a4, $a5, $46        ;; 0e:55a8 ????????
    db   $a5, $a6, $a7, $a5, $a7, $a9, $aa, $a9        ;; 0e:55b0 ????????
    db   $aa, $ac, $d8, $82, $a0, $dc, $aa, $89        ;; 0e:55b8 ????????
    db   $85, $07, $e1, $1e, $55, $e4, $fe, $79        ;; 0e:55c0 ????????
    db   $e0, $36, $7a, $e5, $80, $e3, $02, $e6        ;; 0e:55c8 ????????
    db   $01, $d2, $a1, $a3, $a4, $a3, $a1, $af        ;; 0e:55d0 ????????
    db   $a4, $a3, $a1, $af, $a4, $a3, $a1, $af        ;; 0e:55d8 ????????
    db   $a4, $a3, $e6, $03, $e5, $40, $a1, $a3        ;; 0e:55e0 ????????
    db   $a4, $a3, $a1, $af, $a4, $a3, $a1, $af        ;; 0e:55e8 ????????
    db   $a4, $a3, $a1, $af, $a1, $dc, $ab, $e6        ;; 0e:55f0 ????????
    db   $02, $e5, $80, $a9, $ab, $ac, $ab, $a9        ;; 0e:55f8 ????????
    db   $af, $ac, $ab, $a9, $af, $ac, $ab, $a9        ;; 0e:5600 ????????
    db   $af, $ac, $ab, $eb, $01, $26, $56, $e6        ;; 0e:5608 ????????
    db   $03, $e5, $40, $a9, $ab, $ac, $ab, $a9        ;; 0e:5610 ????????
    db   $af, $ac, $ab, $a9, $af, $ac, $ab, $a9        ;; 0e:5618 ????????
    db   $ab, $ac, $ab, $e2, $cf, $55, $e6, $03        ;; 0e:5620 ????????
    db   $e5, $40, $a9, $ab, $ac, $ab, $a9, $af        ;; 0e:5628 ????????
    db   $ac, $ab, $a9, $af, $ac, $ab, $a9, $af        ;; 0e:5630 ????????
    db   $ac, $ab, $e3, $02, $e6, $02, $e5, $80        ;; 0e:5638 ????????
    db   $a9, $ab, $e6, $03, $a9, $a8, $e6, $01        ;; 0e:5640 ????????
    db   $a9, $ab, $e6, $03, $a9, $a8, $e2, $3c        ;; 0e:5648 ????????
    db   $56, $e6, $02, $a9, $ab, $e6, $03, $a9        ;; 0e:5650 ????????
    db   $a8, $e6, $01, $a9, $ab, $e6, $02, $a9        ;; 0e:5658 ????????
    db   $a8, $e6, $03, $89, $aa, $af, $89, $aa        ;; 0e:5660 ????????
    db   $af, $e3, $02, $e6, $02, $ab, $ad, $e6        ;; 0e:5668 ????????
    db   $03, $ab, $aa, $e6, $01, $ab, $ad, $e6        ;; 0e:5670 ????????
    db   $03, $ab, $aa, $e2, $6b, $56, $e6, $02        ;; 0e:5678 ????????
    db   $ab, $ad, $e6, $03, $ab, $aa, $e6, $01        ;; 0e:5680 ????????
    db   $ab, $ad, $e6, $02, $ab, $aa, $e6, $03        ;; 0e:5688 ????????
    db   $e5, $00, $8b, $ac, $af, $8b, $ac, $af        ;; 0e:5690 ????????
    db   $d8, $52, $51, $53, $52, $23, $55, $83        ;; 0e:5698 ????????
    db   $82, $50, $51, $52, $51, $e1, $cd, $55        ;; 0e:56a0 ????????
    db   $e4, $12, $7a, $e8, $a5, $7a, $e0, $20        ;; 0e:56a8 ????????
    db   $e3, $02, $e6, $02, $d2, $41, $48, $81        ;; 0e:56b0 ????????
    db   $dc, $88, $e6, $03, $4d, $d8, $48, $81        ;; 0e:56b8 ????????
    db   $dc, $88, $e6, $01, $49, $d8, $44, $dc        ;; 0e:56c0 ????????
    db   $89, $84, $eb, $01, $d9, $56, $e6, $03        ;; 0e:56c8 ????????
    db   $49, $d8, $44, $dc, $89, $8b, $e2, $b2        ;; 0e:56d0 ????????
    db   $56, $e6, $03, $49, $d8, $44, $dc, $89        ;; 0e:56d8 ????????
    db   $88, $e3, $06, $a6, $af, $a6, $af, $e2        ;; 0e:56e0 ????????
    db   $e3, $56, $86, $a7, $af, $86, $a7, $af        ;; 0e:56e8 ????????
    db   $e3, $06, $a8, $af, $a8, $af, $e2, $f2        ;; 0e:56f0 ????????
    db   $56, $88, $a9, $af, $88, $a9, $af, $2a        ;; 0e:56f8 ????????
    db   $2b, $0c, $2e, $8e, $d8, $a7, $a6, $a5        ;; 0e:5700 ????????
    db   $a4, $a3, $a2, $e1, $b0, $56, $e7, $6b        ;; 0e:5708 ????????
    db   $e4, $fe, $79, $e5, $40, $e0, $6b, $7a        ;; 0e:5710 ????????
    db   $e6, $03, $e3, $02, $d2, $34, $92, $94        ;; 0e:5718 ????????
    db   $97, $9f, $96, $9f, $92, $9f, $34, $92        ;; 0e:5720 ????????
    db   $94, $97, $9f, $96, $9f, $92, $9f, $96        ;; 0e:5728 ????????
    db   $92, $96, $39, $9f, $9c, $9b, $99, $97        ;; 0e:5730 ????????
    db   $eb, $01, $47, $57, $36, $97, $98, $29        ;; 0e:5738 ????????
    db   $e2, $1c, $57, $34, $92, $94, $97, $26        ;; 0e:5740 ????????
    db   $2f, $98, $96, $94, $2b, $9d, $98, $9b        ;; 0e:5748 ????????
    db   $99, $98, $96, $29, $9b, $96, $99, $98        ;; 0e:5750 ????????
    db   $96, $94, $2b, $9d, $98, $9b, $39, $98        ;; 0e:5758 ????????
    db   $96, $54, $58, $36, $96, $96, $36, $96        ;; 0e:5760 ????????
    db   $96, $e0, $3f, $7a, $96, $96, $96, $96        ;; 0e:5768 ????????
    db   $96, $96, $96, $9f, $9f, $5f, $e1, $15        ;; 0e:5770 ????????
    db   $57, $e4, $fe, $79, $e5, $00, $e0, $59        ;; 0e:5778 ????????
    db   $7a, $e3, $02, $e6, $03, $d2, $50, $e6        ;; 0e:5780 ????????
    db   $01, $90, $dc, $9b, $9a, $e6, $03, $59        ;; 0e:5788 ????????
    db   $e6, $02, $99, $9a, $9b, $e6, $03, $5c        ;; 0e:5790 ????????
    db   $e6, $01, $9c, $9b, $9a, $e6, $03, $59        ;; 0e:5798 ????????
    db   $e6, $02, $99, $9a, $9b, $e6, $03, $d8        ;; 0e:57a0 ????????
    db   $92, $dc, $99, $d8, $92, $e6, $01, $56        ;; 0e:57a8 ????????
    db   $e6, $02, $54, $e6, $03, $62, $dc, $99        ;; 0e:57b0 ????????
    db   $eb, $01, $cf, $57, $e6, $01, $d8, $52        ;; 0e:57b8 ????????
    db   $e6, $02, $92, $94, $95, $66, $e6, $03        ;; 0e:57c0 ????????
    db   $64, $e6, $01, $62, $e2, $83, $57, $e0        ;; 0e:57c8 ????????
    db   $47, $7a, $e6, $03, $d8, $92, $94, $92        ;; 0e:57d0 ????????
    db   $90, $92, $90, $dc, $9b, $9c, $9b, $99        ;; 0e:57d8 ????????
    db   $9b, $99, $e0, $59, $7a, $d8, $94, $93        ;; 0e:57e0 ????????
    db   $dc, $98, $d8, $48, $be, $96, $54, $96        ;; 0e:57e8 ????????
    db   $92, $dc, $99, $d8, $16, $94, $93, $dc        ;; 0e:57f0 ????????
    db   $98, $d8, $48, $be, $96, $54, $52, $96        ;; 0e:57f8 ????????
    db   $94, $92, $dc, $3b, $9d, $9b, $e6, $01        ;; 0e:5800 ????????
    db   $3b, $e6, $02, $9b, $9b, $e6, $01, $3b        ;; 0e:5808 ????????
    db   $e6, $02, $9b, $9b, $e0, $47, $7a, $e6        ;; 0e:5810 ????????
    db   $03, $9a, $9a, $9a, $9a, $9a, $9a, $9a        ;; 0e:5818 ????????
    db   $9f, $9f, $5f, $e1, $7e, $57, $e8, $85        ;; 0e:5820 ????????
    db   $7a, $e0, $40, $e3, $02, $e6, $03, $d1        ;; 0e:5828 ????????
    db   $89, $8f, $e6, $02, $89, $8f, $e6, $03        ;; 0e:5830 ????????
    db   $89, $8f, $e6, $01, $69, $d8, $94, $e6        ;; 0e:5838 ????????
    db   $03, $dc, $89, $8f, $e6, $02, $89, $8f        ;; 0e:5840 ????????
    db   $e6, $03, $89, $8f, $e6, $01, $69, $d8        ;; 0e:5848 ????????
    db   $94, $e6, $03, $82, $8f, $e6, $02, $82        ;; 0e:5850 ????????
    db   $8f, $e6, $03, $82, $8f, $e6, $01, $62        ;; 0e:5858 ????????
    db   $dc, $99, $eb, $01, $7a, $58, $e6, $03        ;; 0e:5860 ????????
    db   $d8, $82, $8f, $82, $8f, $e6, $02, $62        ;; 0e:5868 ????????
    db   $e6, $03, $60, $e6, $01, $dc, $6b, $e2        ;; 0e:5870 ????????
    db   $2d, $58, $e6, $03, $d8, $22, $9e, $94        ;; 0e:5878 ????????
    db   $92, $90, $92, $90, $e6, $02, $81, $8f        ;; 0e:5880 ????????
    db   $e6, $01, $81, $8f, $e6, $02, $81, $8f        ;; 0e:5888 ????????
    db   $e6, $03, $91, $94, $91, $e6, $01, $82        ;; 0e:5890 ????????
    db   $8f, $e6, $02, $82, $8f, $e6, $01, $82        ;; 0e:5898 ????????
    db   $8f, $e6, $03, $92, $96, $92, $e6, $02        ;; 0e:58a0 ????????
    db   $81, $8f, $e6, $01, $81, $8f, $e6, $02        ;; 0e:58a8 ????????
    db   $81, $8f, $e6, $03, $91, $94, $91, $e6        ;; 0e:58b0 ????????
    db   $02, $dc, $2b, $e6, $01, $2d, $e6, $03        ;; 0e:58b8 ????????
    db   $86, $8f, $86, $8f, $86, $8f, $96, $d8        ;; 0e:58c0 ????????
    db   $96, $91, $dc, $b6, $bf, $b6, $bf, $b6        ;; 0e:58c8 ????????
    db   $bf, $b6, $bf, $b6, $bf, $b6, $bf, $96        ;; 0e:58d0 ????????
    db   $9f, $d8, $94, $92, $90, $dc, $9b, $e1        ;; 0e:58d8 ????????
    db   $2b, $58                                      ;; 0e:58e0 ??
.data_0e_58e2:
    db   $e7, $49, $e4, $fe, $79, $e0, $31, $7a        ;; 0e:58e2 ........
    db   $e5, $80, $e6, $03                            ;; 0e:58ea ...w
.data_0e_58ee:
    db   $e3, $02                                      ;; 0e:58ee ..
.data_0e_58f0:
    db   $d3, $51, $dc, $8b, $8d, $d8, $82, $81        ;; 0e:58f0 ........
    db   $dc, $8b, $89, $5b, $d8, $56, $54, $86        ;; 0e:58f8 ........
    db   $88, $49, $89, $88, $86, $84, $83, $14        ;; 0e:5900 ........
    db   $84, $86, $27, $8f, $81, $86, $84, $82        ;; 0e:5908 ........
    db   $81, $82, $86, $dc, $59, $5b, $eb, $01        ;; 0e:5910 ........
    dw   .data_0e_592c                                 ;; 0e:5918 pP
    db   $5d, $d8, $82, $81, $dc, $8b, $89, $88        ;; 0e:591a ........
    db   $89, $5d, $5b, $8f, $84, $86, $84, $e2        ;; 0e:5922 ........
    dw   .data_0e_58f0                                 ;; 0e:592a pP
.data_0e_592c:
    db   $5d, $8b, $89, $56, $58, $09, $88, $86        ;; 0e:592c ........
    db   $88, $5d, $d8, $82, $81, $dc, $8b, $89        ;; 0e:5934 ........
    db   $88, $86, $88, $29, $88, $86, $88, $5d        ;; 0e:593c ........
    db   $88, $89, $8b, $5b, $59, $8f, $89, $8b        ;; 0e:5944 ........
    db   $8d, $d8, $52, $81, $82, $54, $51, $86        ;; 0e:594c ........
    db   $88, $49, $dc, $89, $8b, $d8, $82, $51        ;; 0e:5954 ........
    db   $54, $43, $84, $24, $8e, $dc, $88, $89        ;; 0e:595c ........
    db   $8b, $e1                                      ;; 0e:5964 ..
    dw   .data_0e_58ee                                 ;; 0e:5966 pP
.data_0e_5968:
    db   $e0, $5b, $7a, $e5, $40                       ;; 0e:5968 .....
.data_0e_596d:
    db   $e3, $02                                      ;; 0e:596d ..
.data_0e_596f:
    db   $e6, $02, $8f, $d2, $84, $86, $84, $e6        ;; 0e:596f .w......
    db   $01, $8f, $86, $88, $86, $e6, $03, $58        ;; 0e:5977 w.....w.
    db   $59, $88, $8b, $89, $8b, $e6, $02, $8f        ;; 0e:597f ......w.
    db   $8d, $d8, $82, $81, $e6, $01, $8f, $80        ;; 0e:5987 .....w..
    db   $dc, $88, $86, $e6, $03, $88, $89, $88        ;; 0e:598f ....w...
    db   $86, $58, $88, $89, $e6, $02, $8b, $89        ;; 0e:5997 .....w..
    db   $87, $8b, $5a, $86, $88, $e6, $01, $86        ;; 0e:599f ......w.
    db   $84, $86, $82, $51, $56, $eb, $01             ;; 0e:59a7 .......
    dw   .data_0e_59c6                                 ;; 0e:59ae pP
    db   $e6, $02, $8f, $84, $86, $84, $e6, $01        ;; 0e:59b0 .w.....w
    db   $53, $84, $86, $e6, $03, $28, $8f, $dc        ;; 0e:59b8 ....w...
    db   $88, $89, $88, $e2                            ;; 0e:59c0 ....
    dw   .data_0e_596f                                 ;; 0e:59c4 pP
.data_0e_59c6:
    db   $e6, $03, $24, $52, $81, $dc, $8b, $8d        ;; 0e:59c6 .w......
    db   $d8, $84, $82, $dc, $8b, $2d, $e6, $02        ;; 0e:59ce .......w
    db   $5f, $d8, $84, $86, $54, $58, $e6, $01        ;; 0e:59d6 .......w
    db   $86, $84, $82, $84, $22, $e6, $02, $5f        ;; 0e:59de ......w.
    db   $84, $86, $e6, $01, $54, $86, $84, $e6        ;; 0e:59e6 ...w....
    db   $03, $21, $5f, $86, $84, $e6, $02, $56        ;; 0e:59ee w.....w.
    db   $84, $86, $88, $86, $84, $88, $e6, $01        ;; 0e:59f6 .......w
    db   $82, $84, $56, $5f, $e6, $03, $55, $29        ;; 0e:59fe .....w..
    db   $5b, $59, $59, $88, $86, $44, $82, $e1        ;; 0e:5a06 ........
    dw   .data_0e_596d                                 ;; 0e:5a0e pP
.data_0e_5a10:
    db   $e8, $75, $7a, $e0, $40, $e6, $03             ;; 0e:5a10 ......w
.data_0e_5a17:
    db   $e3, $02                                      ;; 0e:5a17 ..
.data_0e_5a19:
    db   $d1, $29, $d8, $22, $54, $52, $21, $26        ;; 0e:5a19 ........
    db   $58, $dc, $58, $2d, $8e, $8f, $8d, $d8        ;; 0e:5a21 ........
    db   $82, $24, $56, $dc, $56, $2b, $d8, $54        ;; 0e:5a29 ........
    db   $52, $dc, $eb, $01                            ;; 0e:5a31 ....
    dw   .data_0e_5a43                                 ;; 0e:5a35 pP
    db   $29, $4b, $d8, $83, $24, $ae, $5f, $8f        ;; 0e:5a37 ........
    db   $af, $e2                                      ;; 0e:5a3f ..
    dw   .data_0e_5a19                                 ;; 0e:5a41 pP
.data_0e_5a43:
    db   $29, $5b, $d8, $54, $dc, $59, $d8, $86        ;; 0e:5a43 ........
    db   $82, $dc, $49, $8f, $2d, $d8, $58, $51        ;; 0e:5a4b ........
    db   $22, $8f, $86, $84, $82, $21, $58, $51        ;; 0e:5a53 ........
    db   $26, $8e, $84, $82, $81, $dc, $2b, $2d        ;; 0e:5a5b ........
    db   $d8, $22, $2f, $d8, $24, $26, $54, $dc        ;; 0e:5a63 ........
    db   $54, $52, $81, $dc, $8b, $e1                  ;; 0e:5a6b ......
    dw   .data_0e_5a17                                 ;; 0e:5a71 pP
    db   $e7, $8e, $e4, $fe, $79, $e0, $55, $7a        ;; 0e:5a73 ????????
    db   $e5, $40, $e6, $03, $d2, $a7, $a8, $e3        ;; 0e:5a7b ????????
    db   $02, $d8, $44, $dc, $88, $d8, $86, $84        ;; 0e:5a83 ????????
    db   $83, $dc, $8b, $5d, $d8, $83, $84, $83        ;; 0e:5a8b ????????
    db   $84, $83, $dc, $8b, $eb, $01, $a4, $5a        ;; 0e:5a93 ????????
    db   $5d, $18, $1f, $8f, $a7, $a8, $e2, $84        ;; 0e:5a9b ????????
    db   $5a, $5d, $8c, $8d, $d8, $53, $54, $dc        ;; 0e:5aa3 ????????
    db   $0b, $e0, $31, $7a, $59, $5b, $8d, $8b        ;; 0e:5aab ????????
    db   $89, $8b, $5d, $d8, $53, $84, $86, $84        ;; 0e:5ab3 ????????
    db   $89, $08, $e0, $57, $7a, $e5, $80, $af        ;; 0e:5abb ????????
    db   $dc, $a9, $a8, $a6, $a8, $a9, $a8, $a6        ;; 0e:5ac3 ????????
    db   $a8, $aa, $ac, $ad, $d8, $a3, $a4, $a6        ;; 0e:5acb ????????
    db   $a8, $dc, $e3, $02, $e0, $55, $7a, $e5        ;; 0e:5ad3 ????????
    db   $40, $8b, $89, $88, $89, $d8, $44, $dc        ;; 0e:5adb ????????
    db   $89, $88, $89, $d8, $54, $86, $84, $83        ;; 0e:5ae3 ????????
    db   $81, $43, $dc, $5b, $8b, $8d, $d8, $83        ;; 0e:5aeb ????????
    db   $54, $53, $81, $dc, $88, $89, $8b, $eb        ;; 0e:5af3 ????????
    db   $01, $18, $5b, $4b, $59, $89, $8b, $8d        ;; 0e:5afb ????????
    db   $d8, $53, $51, $dc, $6b, $6d, $d8, $63        ;; 0e:5b03 ????????
    db   $44, $51, $81, $83, $84, $53, $51, $dc        ;; 0e:5b0b ????????
    db   $4b, $8f, $e2, $d7, $5a, $49, $a8, $a9        ;; 0e:5b13 ????????
    db   $4b, $a9, $ab, $8d, $ab, $ad, $d8, $83        ;; 0e:5b1b ????????
    db   $a1, $a3, $84, $a3, $a4, $86, $a4, $a6        ;; 0e:5b23 ????????
    db   $48, $aa, $a8, $57, $83, $a5, $a7, $18        ;; 0e:5b2b ????????
    db   $8f, $dc, $a7, $a8, $e1, $82, $5a, $e4        ;; 0e:5b33 ????????
    db   $fe, $79, $e0, $59, $7a, $e5, $40, $8f        ;; 0e:5b3b ????????
    db   $e3, $02, $e6, $01, $d2, $a4, $af, $a4        ;; 0e:5b43 ????????
    db   $a3, $e6, $02, $a4, $af, $a4, $a3, $e6        ;; 0e:5b4b ????????
    db   $01, $a4, $af, $a4, $a3, $e6, $02, $a4        ;; 0e:5b53 ????????
    db   $af, $a4, $a3, $e6, $01, $a1, $af, $a1        ;; 0e:5b5b ????????
    db   $dc, $ab, $e6, $02, $ad, $af, $ad, $ab        ;; 0e:5b63 ????????
    db   $e6, $01, $d8, $a3, $af, $a3, $a1, $e6        ;; 0e:5b6b ????????
    db   $02, $a3, $a4, $a6, $a3, $eb, $01, $9b        ;; 0e:5b73 ????????
    db   $5b, $e6, $01, $8f, $81, $84, $83, $e6        ;; 0e:5b7b ????????
    db   $02, $84, $86, $84, $81, $e6, $01, $8f        ;; 0e:5b83 ????????
    db   $dc, $89, $d8, $84, $81, $e6, $02, $83        ;; 0e:5b8b ????????
    db   $86, $83, $dc, $8b, $d8, $e2, $45, $5b        ;; 0e:5b93 ????????
    db   $e6, $01, $a4, $a6, $a4, $a3, $e6, $02        ;; 0e:5b9b ????????
    db   $a4, $a6, $a4, $a3, $e6, $01, $a6, $a8        ;; 0e:5ba3 ????????
    db   $a6, $a4, $e6, $02, $a6, $a8, $a6, $a4        ;; 0e:5bab ????????
    db   $e6, $03, $8f, $86, $88, $89, $88, $86        ;; 0e:5bb3 ????????
    db   $84, $83, $e0, $31, $7a, $e6, $01, $24        ;; 0e:5bbb ????????
    db   $51, $54, $e6, $02, $59, $5b, $8d, $89        ;; 0e:5bc3 ????????
    db   $8b, $8d, $e6, $01, $ac, $ad, $ac, $aa        ;; 0e:5bcb ????????
    db   $ac, $af, $e6, $03, $ac, $ad, $ac, $aa        ;; 0e:5bd3 ????????
    db   $ac, $af, $e6, $02, $ac, $ad, $ac, $aa        ;; 0e:5bdb ????????
    db   $ac, $e0, $5b, $7a, $e5, $80, $e6, $03        ;; 0e:5be3 ????????
    db   $a1, $a0, $dc, $a9, $ac, $ad, $ac, $a9        ;; 0e:5beb ????????
    db   $ac, $ad, $d8, $a3, $a4, $a6, $a8, $a9        ;; 0e:5bf3 ????????
    db   $ab, $e3, $02, $e6, $01, $e0, $59, $7a        ;; 0e:5bfb ????????
    db   $e5, $40, $a1, $af, $a1, $dc, $ab, $e6        ;; 0e:5c03 ????????
    db   $02, $ad, $af, $ad, $ab, $e6, $01, $ad        ;; 0e:5c0b ????????
    db   $af, $ad, $ab, $e6, $02, $ad, $af, $ad        ;; 0e:5c13 ????????
    db   $ab, $e6, $01, $ad, $af, $ad, $ab, $e6        ;; 0e:5c1b ????????
    db   $02, $ad, $af, $ad, $ab, $e6, $01, $ad        ;; 0e:5c23 ????????
    db   $af, $ad, $ab, $e6, $02, $ad, $af, $ad        ;; 0e:5c2b ????????
    db   $ab, $e6, $01, $ab, $af, $ab, $ad, $e6        ;; 0e:5c33 ????????
    db   $02, $ab, $af, $ab, $ad, $e6, $01, $ab        ;; 0e:5c3b ????????
    db   $af, $ab, $ad, $e6, $02, $ab, $af, $ab        ;; 0e:5c43 ????????
    db   $ad, $d8, $e6, $03, $58, $56, $84, $81        ;; 0e:5c4b ????????
    db   $86, $88, $eb, $01, $b5, $5c, $e6, $02        ;; 0e:5c53 ????????
    db   $dc, $a9, $ab, $a9, $a8, $a9, $e6, $03        ;; 0e:5c5b ????????
    db   $af, $a9, $ab, $a9, $a8, $a9, $e6, $01        ;; 0e:5c63 ????????
    db   $af, $a9, $ab, $a9, $a8, $e6, $03, $d8        ;; 0e:5c6b ????????
    db   $a3, $a4, $a3, $a1, $a1, $a3, $a1, $dc        ;; 0e:5c73 ????????
    db   $ab, $e6, $02, $d8, $63, $e6, $03, $64        ;; 0e:5c7b ????????
    db   $e6, $01, $66, $e6, $02, $a1, $a3, $a1        ;; 0e:5c83 ????????
    db   $dc, $ab, $ad, $e6, $03, $af, $ad, $d8        ;; 0e:5c8b ????????
    db   $a3, $a1, $dc, $ab, $ad, $e6, $01, $af        ;; 0e:5c93 ????????
    db   $ad, $d8, $a3, $a1, $dc, $ab, $e6, $03        ;; 0e:5c9b ????????
    db   $d8, $56, $54, $e6, $02, $83, $dc, $8b        ;; 0e:5ca3 ????????
    db   $d8, $e6, $01, $86, $dc, $8b, $d8, $e2        ;; 0e:5cab ????????
    db   $fe, $5b, $e6, $01, $8f, $81, $83, $81        ;; 0e:5cb3 ????????
    db   $e6, $02, $8f, $83, $84, $83, $e6, $01        ;; 0e:5cbb ????????
    db   $84, $a3, $a4, $e6, $03, $86, $a4, $a6        ;; 0e:5cc3 ????????
    db   $e6, $02, $88, $a6, $a8, $e6, $03, $89        ;; 0e:5ccb ????????
    db   $a8, $a9, $2b, $5a, $87, $a8, $aa, $8c        ;; 0e:5cd3 ????????
    db   $8f, $40, $e6, $02, $80, $e6, $03, $81        ;; 0e:5cdb ????????
    db   $e6, $01, $83, $e1, $43, $5b, $e4, $fe        ;; 0e:5ce3 ????????
    db   $79, $e8, $95, $7a, $e0, $20, $8f, $e3        ;; 0e:5ceb ????????
    db   $02, $e6, $03, $d2, $81, $a8, $af, $81        ;; 0e:5cf3 ????????
    db   $a8, $af, $81, $a8, $af, $81, $a8, $af        ;; 0e:5cfb ????????
    db   $dc, $89, $d8, $a4, $af, $dc, $89, $d8        ;; 0e:5d03 ????????
    db   $a4, $af, $dc, $8b, $d8, $a6, $af, $dc        ;; 0e:5d0b ????????
    db   $8b, $d8, $a6, $af, $eb, $01, $3a, $5d        ;; 0e:5d13 ????????
    db   $81, $5f, $e6, $02, $81, $dc, $e6, $03        ;; 0e:5d1b ????????
    db   $8b, $5f, $e6, $01, $8b, $e6, $03, $89        ;; 0e:5d23 ????????
    db   $5f, $e6, $02, $89, $e6, $03, $58, $d8        ;; 0e:5d2b ????????
    db   $a8, $af, $dc, $88, $e2, $f4, $5c, $dc        ;; 0e:5d33 ????????
    db   $86, $e6, $01, $ad, $af, $e6, $03, $86        ;; 0e:5d3b ????????
    db   $e6, $02, $ad, $af, $e6, $03, $8b, $e6        ;; 0e:5d43 ????????
    db   $01, $d8, $a6, $af, $e6, $03, $dc, $8b        ;; 0e:5d4b ????????
    db   $e6, $02, $d8, $a6, $af, $e6, $01, $54        ;; 0e:5d53 ????????
    db   $e6, $02, $53, $e6, $01, $52, $e6, $02        ;; 0e:5d5b ????????
    db   $51, $e6, $03, $dc, $19, $8e, $8f, $16        ;; 0e:5d63 ????????
    db   $8e, $8f, $e6, $01, $88, $5f, $e6, $03        ;; 0e:5d6b ????????
    db   $88, $5f, $e6, $02, $88, $0f, $8f, $e3        ;; 0e:5d73 ????????
    db   $02, $e6, $03, $89, $d8, $e6, $01, $a4        ;; 0e:5d7b ????????
    db   $af, $e6, $03, $dc, $89, $d8, $e6, $02        ;; 0e:5d83 ????????
    db   $a4, $af, $dc, $e6, $03, $89, $d8, $e6        ;; 0e:5d8b ????????
    db   $01, $a4, $af, $e6, $03, $dc, $89, $d8        ;; 0e:5d93 ????????
    db   $e6, $02, $a4, $af, $dc, $e6, $03, $89        ;; 0e:5d9b ????????
    db   $d8, $e6, $01, $a4, $af, $e6, $03, $dc        ;; 0e:5da3 ????????
    db   $89, $d8, $e6, $02, $a4, $af, $dc, $e6        ;; 0e:5dab ????????
    db   $03, $89, $d8, $e6, $01, $a4, $af, $e6        ;; 0e:5db3 ????????
    db   $03, $dc, $89, $d8, $e6, $02, $a4, $af        ;; 0e:5dbb ????????
    db   $dc, $e6, $03, $88, $e6, $01, $d8, $a3        ;; 0e:5dc3 ????????
    db   $af, $e6, $03, $dc, $88, $e6, $02, $d8        ;; 0e:5dcb ????????
    db   $a3, $af, $e6, $03, $dc, $88, $e6, $01        ;; 0e:5dd3 ????????
    db   $d8, $a3, $af, $e6, $03, $dc, $88, $e6        ;; 0e:5ddb ????????
    db   $02, $d8, $a3, $af, $21, $e6, $01, $dc        ;; 0e:5de3 ????????
    db   $2b, $eb, $01, $23, $5e, $e6, $03, $86        ;; 0e:5deb ????????
    db   $5f, $86, $5f, $a6, $af, $a6, $af, $5b        ;; 0e:5df3 ????????
    db   $59, $e6, $02, $68, $e6, $03, $69, $e6        ;; 0e:5dfb ????????
    db   $01, $6b, $e6, $03, $89, $5f, $89, $5f        ;; 0e:5e03 ????????
    db   $a9, $af, $a9, $af, $e6, $02, $5b, $e6        ;; 0e:5e0b ????????
    db   $01, $59, $e6, $03, $88, $d8, $a8, $af        ;; 0e:5e13 ????????
    db   $a3, $af, $dc, $a8, $af, $e2, $7c, $5d        ;; 0e:5e1b ????????
    db   $e6, $03, $56, $8f, $a6, $af, $58, $8f        ;; 0e:5e23 ????????
    db   $a8, $af, $59, $5b, $5d, $d8, $53, $e6        ;; 0e:5e2b ????????
    db   $02, $24, $e6, $01, $23, $e6, $03, $a8        ;; 0e:5e33 ????????
    db   $7f, $dc, $58, $8f, $e6, $02, $a8, $af        ;; 0e:5e3b ????????
    db   $e6, $03, $8a, $e6, $01, $ac, $af, $e1        ;; 0e:5e43 ????????
    db   $f2, $5c                                      ;; 0e:5e4b ??
.data_0e_5e4d:
    db   $e7, $91, $e4, $fe, $79, $e0, $53, $7a        ;; 0e:5e4d ........
    db   $e7, $91, $e5, $40, $e6, $03, $d2, $81        ;; 0e:5e55 .....w..
    db   $dc, $86, $89, $d8, $84, $83, $dc, $8b        ;; 0e:5e5d ........
    db   $8f, $8b, $8d, $86, $d8, $84, $83, $8f        ;; 0e:5e65 ........
    db   $e5, $80, $ad, $d8, $a2, $a1, $dc, $ab        ;; 0e:5e6d ........
    db   $a9, $a8, $e5, $40, $81, $dc, $86, $89        ;; 0e:5e75 ........
    db   $d8, $84, $83, $dc, $8b, $8f, $8b, $8d        ;; 0e:5e7d ........
    db   $86, $d8, $84, $83, $8f, $e5, $80, $dc        ;; 0e:5e85 ........
    db   $a8, $a9, $ab, $ad, $d8, $a2, $a4, $e0        ;; 0e:5e8d ........
    db   $69, $7a, $e5, $00, $46, $a4, $a6, $48        ;; 0e:5e95 ........
    db   $a6, $a8, $49, $a8, $a6, $58, $54, $e5        ;; 0e:5e9d ........
    db   $40, $89, $88, $86, $88, $a9, $7f, $5d        ;; 0e:5ea5 ........
    db   $8b, $8d, $8b, $89, $a8, $7f, $54, $89        ;; 0e:5ead ........
    db   $88, $16, $af, $e5, $80, $ab, $a9, $a8        ;; 0e:5eb5 ........
    db   $a6, $a8, $a6, $a2, $a4, $a6, $a8, $a9        ;; 0e:5ebd ........
    db   $ab, $ad, $d8, $a2, $a4, $dc, $e5, $40        ;; 0e:5ec5 ........
    db   $89, $88, $86, $88, $a9, $7f, $5d, $5c        ;; 0e:5ecd ........
    db   $8c, $8d, $d8, $a3, $7f, $56, $84, $83        ;; 0e:5ed5 ........
    db   $14, $af, $e5, $80, $dc, $a6, $a4, $a2        ;; 0e:5edd ........
    db   $a4, $a6, $a4, $a2, $a1, $a2, $a4, $a6        ;; 0e:5ee5 ........
    db   $a8, $a9, $ab, $ad, $e0, $53, $7a, $e5        ;; 0e:5eed ........
    db   $40, $d8, $56, $e0, $69, $7a, $86, $87        ;; 0e:5ef5 ........
    db   $a6, $7f, $54, $82, $81, $52, $dc, $8b        ;; 0e:5efd ........
    db   $8d, $d8, $82, $86, $e0, $53, $7a, $54        ;; 0e:5f05 .???????
    db   $e0, $69, $7a, $84, $86, $a4, $7f, $52        ;; 0e:5f0d ????????
    db   $81, $dc, $8b, $5d, $89, $8b, $8d, $d8        ;; 0e:5f15 ????????
    db   $84, $e0, $53, $7a, $52, $e0, $69, $7a        ;; 0e:5f1d ????????
    db   $82, $81, $dc, $ab, $7f, $59, $e7, $90        ;; 0e:5f25 ????????
    db   $58, $59, $5b, $58, $e7, $8f, $ad, $d8        ;; 0e:5f2d ????????
    db   $a2, $a4, $a2, $a1, $af, $a1, $a2, $a4        ;; 0e:5f35 ????????
    db   $a2, $a1, $af, $e7, $8c, $a1, $a2, $a4        ;; 0e:5f3d ????????
    db   $a2, $01, $e3, $02, $e7, $91, $e5, $80        ;; 0e:5f45 ????????
    db   $a6, $a8, $a6, $a4, $a2, $a4, $a2, $a1        ;; 0e:5f4d ????????
    db   $dc, $ab, $ad, $ab, $a9, $ab, $ad, $d8        ;; 0e:5f55 ????????
    db   $a2, $a6, $a4, $a6, $a4, $a2, $a1, $a2        ;; 0e:5f5d ????????
    db   $a1, $dc, $ab, $a9, $ab, $a9, $a8, $a9        ;; 0e:5f65 ????????
    db   $ab, $ad, $a9, $eb, $01, $89, $5f, $e5        ;; 0e:5f6d ????????
    db   $40, $8b, $8d, $d8, $82, $dc, $8b, $ad        ;; 0e:5f75 ????????
    db   $7f, $d8, $54, $46, $a8, $a6, $a5, $7f        ;; 0e:5f7d ????????
    db   $51, $e2, $49, $5f, $e7, $8e, $ab, $ad        ;; 0e:5f85 ????????
    db   $d8, $a2, $dc, $ab, $ad, $d8, $a2, $a4        ;; 0e:5f8d ????????
    db   $a1, $a2, $a4, $a6, $a2, $b4, $b6, $b8        ;; 0e:5f95 ????????
    db   $b9, $bb, $bd, $e1, $55, $5e                  ;; 0e:5f9d ??????
.data_0e_5fa3:
    db   $e4, $fe, $79, $e0, $3f, $7a, $e5, $40        ;; 0e:5fa3 ........
    db   $e6, $03, $d2, $af, $81, $dc, $86, $89        ;; 0e:5fab .w......
    db   $d8, $84, $83, $dc, $8b, $8f, $8b, $8d        ;; 0e:5fb3 ........
    db   $86, $d8, $84, $83, $af, $e5, $00, $d2        ;; 0e:5fbb ........
    db   $a9, $ab, $a9, $a8, $a6, $a4, $e5, $40        ;; 0e:5fc3 ........
    db   $d2, $af, $81, $dc, $86, $89, $d8, $84        ;; 0e:5fcb ........
    db   $83, $dc, $8b, $8f, $8b, $8d, $86, $d8        ;; 0e:5fd3 ........
    db   $84, $83, $af, $e5, $00, $dc, $a4, $a6        ;; 0e:5fdb ........
    db   $a8, $a9, $ab, $ad, $e0, $57, $7a, $e6        ;; 0e:5fe3 ........
    db   $02, $8f, $d8, $82, $dc, $89, $ad, $d8        ;; 0e:5feb w.......
    db   $a2, $e6, $01, $8f, $84, $dc, $8b, $d8        ;; 0e:5ff3 ..w.....
    db   $a2, $a4, $e6, $02, $8f, $86, $82, $a4        ;; 0e:5ffb ...w....
    db   $a2, $e6, $01, $e0, $57, $7a, $e5, $80        ;; 0e:6003 ..w.....
    db   $a4, $a6, $e6, $02, $a4, $a2, $e6, $01        ;; 0e:600b ...w...w
    db   $a1, $a2, $e6, $02, $a1, $dc, $ab, $e0        ;; 0e:6013 ...w....
    db   $43, $7a, $e5, $40, $a9, $af, $a9, $a8        ;; 0e:601b ........
    db   $e6, $01, $a9, $af, $a9, $a8, $e6, $02        ;; 0e:6023 .w.....w
    db   $a9, $af, $a9, $a8, $e6, $01, $a9, $af        ;; 0e:602b .....w..
    db   $a9, $a8, $e6, $02, $a6, $af, $a6, $a4        ;; 0e:6033 ...w....
    db   $e6, $01, $a6, $af, $a6, $a4, $e6, $02        ;; 0e:603b .w.....w
    db   $a8, $af, $a8, $a6, $e6, $01, $a8, $af        ;; 0e:6043 .....w..
    db   $a8, $a6, $e6, $03, $ad, $d8, $a2, $a1        ;; 0e:604b ...w....
    db   $dc, $ab, $ad, $d8, $a2, $a1, $dc, $ab        ;; 0e:6053 ........
    db   $ad, $d8, $a2, $a1, $dc, $ab, $ad, $d8        ;; 0e:605b ........
    db   $a2, $a1, $dc, $ab, $ad, $d8, $a2, $a1        ;; 0e:6063 ........
    db   $dc, $ab, $a9, $ab, $a9, $a6, $a8, $a9        ;; 0e:606b ........
    db   $ab, $ad, $d8, $a2, $a4, $a6, $a8, $dc        ;; 0e:6073 ........
    db   $e6, $02, $a9, $af, $a9, $a8, $e6, $01        ;; 0e:607b .w.....w
    db   $a9, $af, $a9, $a8, $e6, $02, $a9, $af        ;; 0e:6083 .....w..
    db   $a9, $a8, $e6, $01, $a9, $af, $a9, $a8        ;; 0e:608b ...w....
    db   $e6, $02, $ac, $af, $ac, $aa, $e6, $01        ;; 0e:6093 .w.....w
    db   $ac, $af, $ac, $aa, $e6, $02, $ac, $af        ;; 0e:609b .....w..
    db   $ac, $aa, $e6, $01, $ac, $af, $ac, $aa        ;; 0e:60a3 ...w....
    db   $d8, $e6, $03, $a8, $a9, $a8, $a6, $a8        ;; 0e:60ab ..w.....
    db   $a9, $a8, $a6, $a8, $a9, $a8, $a6, $a8        ;; 0e:60b3 ........
    db   $a9, $a8, $a6, $a8, $a9, $a8, $a6, $a8        ;; 0e:60bb ........
    db   $a9, $a8, $a6, $a4, $a6, $a8, $a9, $ab        ;; 0e:60c3 ........
    db   $ad, $d8, $a2, $a4, $dc, $e6, $02, $a1        ;; 0e:60cb ......w.
    db   $af, $a1, $a2, $e6, $01, $a1, $af, $a1        ;; 0e:60d3 ....w...
    db   $a2, $e6, $02, $a1, $af, $a1, $a2, $e6        ;; 0e:60db ..w.....
    db   $01, $a4, $a2, $a1, $a4, $e6, $02, $a6        ;; 0e:60e3 w.....w.
    db   $af, $a6, $a4, $e6, $01, $a6, $af, $a6        ;; 0e:60eb ....w...
    db   $a4, $e6, $02, $a6, $af, $a6, $a4, $e6        ;; 0e:60f3 ..w...??
    db   $01, $a6, $a8, $a9, $a2, $e6, $02, $a8        ;; 0e:60fb ????????
    db   $af, $a8, $a6, $e6, $01, $a8, $af, $a8        ;; 0e:6103 ????????
    db   $a6, $e6, $02, $a8, $af, $a8, $a6, $e6        ;; 0e:610b ????????
    db   $01, $a8, $a9, $a8, $a6, $e6, $02, $a4        ;; 0e:6113 ????????
    db   $af, $a4, $a2, $e6, $01, $a4, $af, $a4        ;; 0e:611b ????????
    db   $a2, $e6, $02, $a4, $af, $a4, $a2, $e6        ;; 0e:6123 ????????
    db   $01, $a4, $a8, $a9, $a1, $e6, $03, $e0        ;; 0e:612b ????????
    db   $6f, $7a, $a6, $a8, $a9, $a8, $a6, $af        ;; 0e:6133 ????????
    db   $49, $56, $a2, $a4, $a6, $a4, $a2, $af        ;; 0e:613b ????????
    db   $46, $52, $a8, $a6, $a8, $a9, $a8, $af        ;; 0e:6143 ????????
    db   $a8, $a6, $a8, $a9, $a8, $af, $a8, $a6        ;; 0e:614b ????????
    db   $a8, $a9, $56, $55, $56, $58, $d8, $e3        ;; 0e:6153 ????????
    db   $02, $e0, $43, $7a, $e6, $03, $a2, $a4        ;; 0e:615b ????????
    db   $a2, $a1, $dc, $ab, $ad, $ab, $a9, $a8        ;; 0e:6163 ????????
    db   $a9, $a8, $a6, $a8, $a9, $ab, $d8, $a2        ;; 0e:616b ????????
    db   $a1, $a2, $a1, $dc, $ab, $a9, $ab, $a9        ;; 0e:6173 ????????
    db   $a8, $a6, $a8, $a6, $a4, $a6, $a8, $a9        ;; 0e:617b ????????
    db   $a6, $eb, $01, $a6, $61, $e6, $02, $8f        ;; 0e:6183 ????????
    db   $a6, $a4, $a2, $7f, $e6, $01, $88, $86        ;; 0e:618b ????????
    db   $88, $8b, $e6, $02, $8f, $a9, $a8, $a6        ;; 0e:6193 ????????
    db   $7f, $e6, $01, $88, $8b, $85, $88, $d8        ;; 0e:619b ????????
    db   $e2, $5c, $61, $e0, $5b, $7a, $e5, $80        ;; 0e:61a3 ????????
    db   $a6, $a4, $a2, $a6, $a8, $a6, $a4, $a8        ;; 0e:61ab ????????
    db   $a9, $a8, $a6, $a9, $e6, $02, $bb, $bd        ;; 0e:61b3 ????????
    db   $d8, $e6, $03, $b2, $b4, $e6, $01, $b6        ;; 0e:61bb ????????
    db   $b8, $e1, $a6, $5f                            ;; 0e:61c3 ????
.data_0e_61c7:
    db   $e4, $fe, $79, $e8, $a5, $7a, $e0, $20        ;; 0e:61c7 ........
    db   $e6, $02, $d1, $a6, $af, $a6, $af, $a6        ;; 0e:61cf .w......
    db   $af, $a6, $af, $e6, $01, $ab, $af, $ab        ;; 0e:61d7 ....w...
    db   $af, $ab, $af, $ab, $af, $e6, $02, $a6        ;; 0e:61df ......w.
    db   $af, $a6, $af, $a6, $af, $ab, $af, $2f        ;; 0e:61e7 ........
    db   $e6, $01, $a6, $af, $a6, $af, $a6, $af        ;; 0e:61ef .w......
    db   $a6, $af, $e6, $02, $ab, $af, $ab, $af        ;; 0e:61f7 ...w....
    db   $ab, $af, $ab, $af, $e6, $01, $a6, $af        ;; 0e:61ff .....w..
    db   $a6, $af, $a6, $af, $ab, $af, $2f, $d8        ;; 0e:6207 ........
    db   $e6, $03, $22, $21, $dc, $2b, $e6, $01        ;; 0e:620f .w.....w
    db   $8d, $e6, $02, $8b, $e6, $01, $89, $e6        ;; 0e:6217 ..w..w..
    db   $02, $88, $e6, $03, $86, $d8, $a6, $af        ;; 0e:621f w..w....
    db   $dc, $86, $d8, $a6, $af, $dc, $86, $d8        ;; 0e:6227 ........
    db   $a6, $af, $dc, $86, $d8, $a6, $af, $dc        ;; 0e:622f ........
    db   $82, $d8, $a2, $af, $dc, $82, $d8, $a2        ;; 0e:6237 ........
    db   $af, $dc, $84, $d8, $a4, $af, $dc, $84        ;; 0e:623f ........
    db   $d8, $a4, $af, $dc, $e6, $02, $86, $5f        ;; 0e:6247 .....w..
    db   $e6, $01, $86, $e6, $02, $84, $5f, $e6        ;; 0e:624f .w..w...
    db   $01, $84, $e6, $02, $82, $5f, $e6, $01        ;; 0e:6257 w..w...w
    db   $82, $e6, $02, $84, $5f, $e6, $01, $84        ;; 0e:625f ..w...w.
    db   $e6, $03, $86, $d8, $a6, $af, $dc, $86        ;; 0e:6267 .w......
    db   $d8, $a6, $af, $dc, $86, $d8, $a6, $af        ;; 0e:626f ........
    db   $dc, $86, $d8, $a6, $af, $dc, $88, $d8        ;; 0e:6277 ........
    db   $a8, $af, $dc, $88, $d8, $a8, $af, $dc        ;; 0e:627f ........
    db   $8a, $d8, $aa, $af, $80, $ac, $af, $e6        ;; 0e:6287 ........
    db   $02, $81, $5f, $e6, $01, $81, $e6, $02        ;; 0e:628f w...w..w
    db   $80, $5f, $e6, $01, $80, $dc, $e6, $02        ;; 0e:6297 ...w...w
    db   $8b, $5f, $e6, $01, $8b, $e6, $02, $8a        ;; 0e:629f ...w..w.
    db   $5f, $e6, $01, $8a, $e6, $03, $86, $d8        ;; 0e:62a7 ..w..w..
    db   $a6, $af, $dc, $86, $d8, $a6, $af, $dc        ;; 0e:62af ........
    db   $88, $d8, $a8, $af, $dc, $8a, $d8, $aa        ;; 0e:62b7 ........
    db   $af, $dc, $8b, $d8, $ab, $af, $dc, $8b        ;; 0e:62bf ........
    db   $d8, $ab, $af, $dc, $8b, $d8, $ab, $af        ;; 0e:62c7 .......?
    db   $dc, $8b, $d8, $ab, $af, $dc, $84, $d8        ;; 0e:62cf ????????
    db   $a4, $af, $dc, $84, $d8, $a4, $af, $dc        ;; 0e:62d7 ????????
    db   $86, $d8, $a6, $af, $dc, $88, $d8, $a8        ;; 0e:62df ????????
    db   $af, $dc, $89, $d8, $a9, $af, $dc, $89        ;; 0e:62e7 ????????
    db   $d8, $a9, $af, $dc, $89, $d8, $a9, $af        ;; 0e:62ef ????????
    db   $dc, $89, $d8, $a9, $af, $dc, $e6, $01        ;; 0e:62f7 ????????
    db   $42, $e6, $02, $49, $e6, $01, $52, $dc        ;; 0e:62ff ????????
    db   $e6, $02, $4b, $d8, $e6, $01, $46, $dc        ;; 0e:6307 ????????
    db   $e6, $02, $5b, $e6, $01, $8d, $5f, $e6        ;; 0e:630f ????????
    db   $03, $8d, $5f, $e6, $02, $8d, $d8, $88        ;; 0e:6317 ????????
    db   $e6, $01, $5d, $e6, $02, $5b, $e6, $01        ;; 0e:631f ????????
    db   $59, $e6, $02, $58, $d8, $e3, $02, $e6        ;; 0e:6327 ????????
    db   $01, $22, $e6, $02, $24, $e6, $01, $29        ;; 0e:632f ????????
    db   $e6, $02, $22, $eb, $01, $51, $63, $e6        ;; 0e:6337 ????????
    db   $03, $dc, $8b, $8b, $8f, $8b, $5d, $5d        ;; 0e:633f ????????
    db   $d8, $82, $82, $8f, $82, $51, $51, $e2        ;; 0e:6347 ????????
    db   $2e, $63, $e6, $03, $dc, $5b, $5d, $d8        ;; 0e:634f ????????
    db   $52, $54, $e1, $cf, $61, $e7, $87, $e4        ;; 0e:6357 ????????
    db   $fe, $79, $e6, $03, $e3, $02, $e0, $53        ;; 0e:635f ????????
    db   $7a, $e5, $00, $d2, $a7, $ab, $a9, $ab        ;; 0e:6367 ????????
    db   $a7, $ab, $a9, $ab, $a9, $ac, $ab, $ac        ;; 0e:636f ????????
    db   $a9, $ac, $ab, $ac, $ab, $d8, $a2, $a0        ;; 0e:6377 ????????
    db   $a2, $dc, $ab, $d8, $a2, $a0, $a2, $dc        ;; 0e:637f ????????
    db   $ab, $d8, $a2, $a0, $a2, $dc, $ab, $d8        ;; 0e:6387 ????????
    db   $a2, $a0, $a2, $a0, $a4, $a2, $a4, $a0        ;; 0e:638f ????????
    db   $a4, $a2, $a4, $dc, $a9, $ac, $ab, $ac        ;; 0e:6397 ????????
    db   $a9, $ac, $ab, $ac, $29, $8e, $d8, $e0        ;; 0e:639f ????????
    db   $31, $7a, $e5, $40, $e6, $02, $84, $e6        ;; 0e:63a7 ????????
    db   $03, $83, $dc, $e6, $01, $8b, $d8, $e0        ;; 0e:63af ????????
    db   $57, $7a, $e6, $03, $44, $dc, $5b, $d8        ;; 0e:63b7 ????????
    db   $84, $86, $87, $89, $a7, $a9, $87, $a6        ;; 0e:63bf ????????
    db   $a7, $86, $a4, $a6, $84, $a2, $a4, $42        ;; 0e:63c7 ????????
    db   $a0, $dc, $ab, $29, $e0, $36, $7a, $8f        ;; 0e:63cf ????????
    db   $86, $87, $89, $87, $86, $84, $82, $a0        ;; 0e:63d7 ????????
    db   $a2, $a4, $a2, $a4, $a6, $a7, $a6, $87        ;; 0e:63df ????????
    db   $d8, $84, $82, $dc, $8b, $a9, $ab, $ac        ;; 0e:63e7 ????????
    db   $ab, $a9, $a7, $a6, $a7, $89, $a7, $a9        ;; 0e:63ef ????????
    db   $8b, $a9, $ab, $eb, $01, $12, $64, $8c        ;; 0e:63f7 ????????
    db   $8b, $8c, $d8, $82, $84, $87, $86, $84        ;; 0e:63ff ????????
    db   $83, $81, $83, $84, $86, $89, $87, $86        ;; 0e:6407 ????????
    db   $e2, $b6, $63, $8c, $8b, $8c, $d8, $82        ;; 0e:640f ????????
    db   $84, $87, $86, $84, $53, $dc, $5b, $d8        ;; 0e:6417 ????????
    db   $8b, $89, $87, $86, $e0, $31, $7a, $e5        ;; 0e:641f ????????
    db   $40, $27, $8f, $a6, $a7, $a9, $a7, $a6        ;; 0e:6427 ????????
    db   $a4, $53, $a4, $a6, $a7, $a9, $2b, $e1        ;; 0e:642f ????????
    db   $63, $63, $e4, $fe, $79, $e3, $02, $e0        ;; 0e:6437 ????????
    db   $57, $7a, $e5, $00, $e6, $03, $d2, $a4        ;; 0e:643f ????????
    db   $a7, $a6, $a7, $e6, $02, $a4, $a7, $a6        ;; 0e:6447 ????????
    db   $a7, $e6, $03, $a6, $a9, $a7, $a9, $e6        ;; 0e:644f ????????
    db   $01, $a6, $a9, $a7, $a9, $e6, $03, $a7        ;; 0e:6457 ????????
    db   $ab, $a9, $ab, $e6, $02, $a7, $ab, $a9        ;; 0e:645f ????????
    db   $ab, $e6, $03, $a8, $ab, $a9, $ab, $e6        ;; 0e:6467 ????????
    db   $01, $a8, $ab, $a9, $ab, $e6, $03, $a9        ;; 0e:646f ????????
    db   $ac, $ab, $ac, $e6, $02, $a9, $ac, $ab        ;; 0e:6477 ????????
    db   $ac, $e6, $03, $a6, $a9, $a7, $a9, $e6        ;; 0e:647f ????????
    db   $01, $a6, $a9, $a7, $a9, $e0, $43, $7a        ;; 0e:6487 ????????
    db   $e6, $03, $26, $ae, $a7, $e6, $02, $a9        ;; 0e:648f ????????
    db   $ab, $e6, $03, $a9, $a7, $e6, $01, $a6        ;; 0e:6497 ????????
    db   $a3, $dc, $e5, $40, $e6, $02, $a7, $a9        ;; 0e:649f ????????
    db   $a7, $a6, $a7, $af, $e6, $03, $a7, $a9        ;; 0e:64a7 ????????
    db   $a7, $a6, $a7, $af, $e6, $01, $a7, $a9        ;; 0e:64af ????????
    db   $a7, $a6, $e6, $02, $a7, $a9, $a7, $a6        ;; 0e:64b7 ????????
    db   $a7, $af, $e6, $03, $a7, $a9, $a7, $a6        ;; 0e:64bf ????????
    db   $a7, $af, $e6, $01, $a7, $a9, $a7, $a6        ;; 0e:64c7 ????????
    db   $e6, $02, $5f, $a6, $a7, $a9, $a7, $e6        ;; 0e:64cf ????????
    db   $01, $5f, $a6, $a7, $a9, $a7, $e6, $03        ;; 0e:64d7 ????????
    db   $8b, $89, $8b, $8c, $8b, $89, $87, $86        ;; 0e:64df ????????
    db   $e0, $31, $7a, $e6, $01, $e5, $00, $e6        ;; 0e:64e7 ????????
    db   $01, $a4, $a7, $a6, $a7, $e6, $02, $a4        ;; 0e:64ef ????????
    db   $a7, $a6, $a7, $e6, $01, $a4, $a7, $a6        ;; 0e:64f7 ????????
    db   $a7, $e6, $02, $a4, $a7, $a6, $a7, $e6        ;; 0e:64ff ????????
    db   $01, $a6, $a9, $a7, $a9, $e6, $02, $a6        ;; 0e:6507 ????????
    db   $a9, $a7, $a9, $e6, $01, $a6, $a9, $a7        ;; 0e:650f ????????
    db   $a9, $e6, $02, $a6, $a9, $a7, $a9, $eb        ;; 0e:6517 ????????
    db   $01, $47, $65, $e6, $01, $a7, $ab, $a9        ;; 0e:651f ????????
    db   $ab, $e6, $02, $a7, $ab, $a9, $ab, $e6        ;; 0e:6527 ????????
    db   $01, $a7, $ab, $a9, $ab, $e6, $02, $a7        ;; 0e:652f ????????
    db   $ab, $a9, $ab, $e6, $03, $8b, $89, $8b        ;; 0e:6537 ????????
    db   $8d, $8b, $8d, $8b, $89, $e2, $a1, $64        ;; 0e:653f ????????
    db   $e6, $01, $e5, $40, $a7, $ab, $a9, $ab        ;; 0e:6547 ????????
    db   $e6, $02, $a7, $ab, $a9, $ab, $e6, $01        ;; 0e:654f ????????
    db   $a7, $ab, $a9, $ab, $e6, $02, $a7, $ab        ;; 0e:6557 ????????
    db   $a9, $ab, $d8, $e6, $01, $a3, $dc, $ab        ;; 0e:655f ????????
    db   $d8, $a3, $dc, $ab, $d8, $e6, $02, $a4        ;; 0e:6567 ????????
    db   $dc, $ab, $d8, $a4, $dc, $ab, $e6, $01        ;; 0e:656f ????????
    db   $d8, $a5, $dc, $ab, $d8, $a5, $dc, $ab        ;; 0e:6577 ????????
    db   $d8, $e6, $02, $a6, $dc, $ab, $d8, $a6        ;; 0e:657f ????????
    db   $dc, $ab, $d8, $e6, $01, $a4, $a6, $aa        ;; 0e:6587 ????????
    db   $a4, $e6, $02, $a6, $aa, $a4, $a6, $e6        ;; 0e:658f ????????
    db   $03, $2a, $a6, $a9, $a7, $a6, $a9, $a6        ;; 0e:6597 ????????
    db   $a7, $a9, $ab, $ac, $ab, $a9, $a7, $a9        ;; 0e:659f ????????
    db   $a7, $a6, $e1, $3c, $64, $e4, $fe, $79        ;; 0e:65a7 ????????
    db   $e8, $a5, $7a, $e0, $20, $e3, $02, $e6        ;; 0e:65af ????????
    db   $01, $d1, $24, $e6, $02, $26, $e6, $01        ;; 0e:65b7 ????????
    db   $27, $e6, $02, $28, $e6, $01, $29, $e6        ;; 0e:65bf ????????
    db   $02, $26, $e6, $03, $5b, $d8, $5b, $56        ;; 0e:65c7 ????????
    db   $dc, $5b, $8c, $5f, $8c, $5f, $8c, $8f        ;; 0e:65cf ????????
    db   $8c, $5f, $8c, $5f, $8c, $8f, $ab, $af        ;; 0e:65d7 ????????
    db   $ab, $af, $5f, $ab, $af, $ab, $af, $5f        ;; 0e:65df ????????
    db   $54, $d8, $54, $52, $dc, $5b, $a9, $af        ;; 0e:65e7 ????????
    db   $a9, $af, $e6, $01, $8f, $89, $e6, $03        ;; 0e:65ef ????????
    db   $8f, $89, $e6, $02, $8f, $89, $e6, $03        ;; 0e:65f7 ????????
    db   $ab, $af, $ab, $af, $e6, $01, $8f, $8b        ;; 0e:65ff ????????
    db   $e6, $03, $8f, $8b, $e6, $02, $8f, $8b        ;; 0e:6607 ????????
    db   $eb, $01, $32, $66, $e6, $03, $ac, $af        ;; 0e:660f ????????
    db   $ac, $af, $e6, $01, $8f, $8c, $e6, $03        ;; 0e:6617 ????????
    db   $8f, $8c, $e6, $02, $8f, $8c, $e6, $03        ;; 0e:661f ????????
    db   $7b, $af, $7b, $af, $5d, $d8, $53, $dc        ;; 0e:6627 ????????
    db   $e2, $d1, $65, $e3, $04, $e6, $03, $ac        ;; 0e:662f ????????
    db   $af, $e6, $01, $ac, $af, $e6, $03, $ac        ;; 0e:6637 ????????
    db   $af, $e6, $02, $ac, $af, $e6, $03, $ac        ;; 0e:663f ????????
    db   $af, $e6, $01, $ac, $af, $e6, $03, $ac        ;; 0e:6647 ????????
    db   $af, $e6, $02, $ac, $af, $e6, $03, $ab        ;; 0e:664f ????????
    db   $af, $e6, $01, $ab, $af, $e6, $03, $ab        ;; 0e:6657 ????????
    db   $af, $e6, $02, $ab, $af, $e6, $03, $ad        ;; 0e:665f ????????
    db   $af, $e6, $01, $ad, $af, $e6, $03, $d8        ;; 0e:6667 ????????
    db   $a3, $af, $e6, $02, $a3, $af, $e6, $03        ;; 0e:666f ????????
    db   $01, $e6, $01, $dc, $5b, $e6, $02, $59        ;; 0e:6677 ????????
    db   $e6, $01, $57, $e6, $02, $56, $e1, $b4        ;; 0e:667f ????????
    db   $65                                           ;; 0e:6687 ?
.data_0e_6688:
    db   $e7, $78, $e4, $fe, $79, $e0, $55, $7a        ;; 0e:6688 ........
    db   $e5, $40, $e6, $03, $d2, $a9, $e0, $65        ;; 0e:6690 ...w....
    db   $7a, $af, $a9, $af, $e0, $67, $7a, $a9        ;; 0e:6698 ........
    db   $af, $e0, $55, $7a, $a9, $a9, $a9, $e0        ;; 0e:66a0 ........
    db   $65, $7a, $af, $a9, $a9, $a9, $af, $e0        ;; 0e:66a8 ........
    db   $67, $7a, $a9, $a9, $e0, $55, $7a, $a9        ;; 0e:66b0 ........
    db   $af, $a9, $af, $e0, $65, $7a, $a9, $af        ;; 0e:66b8 ........
    db   $e0, $55, $7a, $a9, $a9, $a9, $e0, $65        ;; 0e:66c0 ........
    db   $7a, $af, $a9, $a9, $e0, $53, $7a, $d2        ;; 0e:66c8 ........
    db   $99, $d8, $94, $99                            ;; 0e:66d0 ....
.data_0e_66d4:
    db   $57, $96, $94, $97, $56, $52, $94, $9f        ;; 0e:66d4 ........
    db   $dc, $99, $29, $99, $99, $9b, $4c, $ab        ;; 0e:66dc ........
    db   $a9, $d8, $62, $60, $dc, $6b, $19, $99        ;; 0e:66e4 ........
    db   $d8, $94, $99, $57, $96, $94, $97, $56        ;; 0e:66ec ........
    db   $52, $94, $9f, $dc, $99, $29, $99, $99        ;; 0e:66f4 ........
    db   $9b, $4c, $d8, $a2, $a4, $62, $60, $dc        ;; 0e:66fc ........
    db   $6b, $19, $e0, $6b, $7a, $b9, $bf, $99        ;; 0e:6704 ........
    db   $9b, $2c, $8e, $8c, $8b, $89, $d8, $a2        ;; 0e:670c ........
    db   $8f, $dc, $c9, $cf, $29, $89, $8b, $5c        ;; 0e:6714 ........
    db   $d8, $82, $84, $72, $70, $dc, $8b, $19        ;; 0e:671c ........
    db   $b9, $bf, $b9, $bf, $bb, $bf, $2c, $8e        ;; 0e:6724 ........
    db   $8c, $8b, $89, $d8, $a2, $8f, $dc, $c9        ;; 0e:672c ........
    db   $cf, $29, $89, $8b, $5c, $d8, $82, $84        ;; 0e:6734 ........
    db   $73, $75, $87, $19, $e0, $55, $7a, $dc        ;; 0e:673c ........
    db   $99, $d8, $94, $99, $e1                       ;; 0e:6744 .....
    dw   .data_0e_66d4                                 ;; 0e:6749 pP
.data_0e_674b:
    db   $e4, $fe, $79, $e0, $55, $7a, $e5, $40        ;; 0e:674b ........
    db   $e6, $03, $d2, $a4, $e0, $65, $7a, $af        ;; 0e:6753 .w......
    db   $a4, $af, $e0, $67, $7a, $a4, $af, $e0        ;; 0e:675b ........
    db   $55, $7a, $a4, $a4, $a4, $e0, $65, $7a        ;; 0e:6763 ........
    db   $af, $a4, $a4, $a4, $af, $e0, $67, $7a        ;; 0e:676b ........
    db   $a4, $a4, $e0, $55, $7a, $a4, $af, $a4        ;; 0e:6773 ........
    db   $af, $e0, $65, $7a, $a4, $af, $e0, $55        ;; 0e:677b ........
    db   $7a, $a4, $a4, $a4, $e0, $65, $7a, $af        ;; 0e:6783 ........
    db   $a4, $a4, $a4, $af, $e0, $67, $7a, $a4        ;; 0e:678b ........
    db   $a4                                           ;; 0e:6793 .
.data_0e_6794:
    db   $e3, $02                                      ;; 0e:6794 ..
.data_0e_6796:
    db   $e6, $02, $e0, $55, $7a, $d3, $52, $dc        ;; 0e:6796 .w......
    db   $5b, $59, $56, $54, $e6, $01, $dc, $99        ;; 0e:679e .....w..
    db   $98, $99, $9d, $9c, $9d, $d8, $94, $93        ;; 0e:67a6 ........
    db   $94, $e6, $02, $dc, $94, $97, $9c, $d8        ;; 0e:67ae ..w.....
    db   $92, $94, $97, $e6, $01, $dc, $92, $96        ;; 0e:67b6 ....w...
    db   $99, $d8, $92, $94, $96, $eb, $01             ;; 0e:67be .......
    dw   .data_0e_67cf                                 ;; 0e:67c5 pP
    db   $54, $92, $94, $92, $21, $e2                  ;; 0e:67c7 ......
    dw   .data_0e_6796                                 ;; 0e:67cd pP
.data_0e_67cf:
    db   $54, $e6, $03, $dc, $a1, $a2, $a4, $a6        ;; 0e:67cf ..w.....
    db   $a8, $a9, $ab, $ad, $d8, $54, $e3, $02        ;; 0e:67d7 ........
.data_0e_67df:
    db   $e5, $00, $e6, $02, $e0, $55, $7a, $a4        ;; 0e:67df ...w....
    db   $a5, $a4, $e0, $61, $7a, $a0, $e6, $01        ;; 0e:67e7 .......w
    db   $e0, $55, $7a, $a4, $a5, $a4, $e0, $61        ;; 0e:67ef ........
    db   $7a, $a0, $e2                                 ;; 0e:67f7 ...
    dw   .data_0e_67df                                 ;; 0e:67fa pP
    db   $e3, $02                                      ;; 0e:67fc ..
.data_0e_67fe:
    db   $e6, $02, $e0, $55, $7a, $a2, $a5, $a2        ;; 0e:67fe .w......
    db   $e0, $61, $7a, $dc, $ab, $d8, $e6, $01        ;; 0e:6806 .......w
    db   $e0, $55, $7a, $a2, $a5, $a2, $e0, $61        ;; 0e:680e ........
    db   $7a, $dc, $ab, $d8, $e2                       ;; 0e:6816 .....
    dw   .data_0e_67fe                                 ;; 0e:681b pP
    db   $e6, $02, $e0, $55, $7a, $dc, $a9, $ab        ;; 0e:681d .w......
    db   $ac, $d8, $a2, $a4, $a5, $a7, $a9, $e6        ;; 0e:6825 ........
    db   $01, $dc, $a7, $a9, $ab, $ac, $d8, $a2        ;; 0e:682d w.......
    db   $a4, $a5, $a7, $e0, $31, $7a, $e5, $80        ;; 0e:6835 ........
    db   $d8, $56, $54, $e6, $03, $52, $e6, $02        ;; 0e:683d ....w..w
    db   $51, $dc, $e3, $02                            ;; 0e:6845 ....
.data_0e_6849:
    db   $e6, $02, $e0, $55, $7a, $e5, $00, $a4        ;; 0e:6849 .w......
    db   $a5, $a4, $e0, $61, $7a, $a0, $e6, $01        ;; 0e:6851 .......w
    db   $e0, $55, $7a, $a4, $a5, $a4, $e0, $61        ;; 0e:6859 ........
    db   $7a, $a0, $e2                                 ;; 0e:6861 ...
    dw   .data_0e_6849                                 ;; 0e:6864 pP
    db   $e3, $02                                      ;; 0e:6866 ..
.data_0e_6868:
    db   $e6, $02, $e0, $55, $7a, $a2, $a5, $a2        ;; 0e:6868 .w......
    db   $e0, $61, $7a, $dc, $ab, $d8, $e6, $01        ;; 0e:6870 .......w
    db   $e0, $55, $7a, $a2, $a5, $a2, $e0, $61        ;; 0e:6878 ........
    db   $7a, $dc, $ab, $d8, $e2                       ;; 0e:6880 .....
    dw   .data_0e_6868                                 ;; 0e:6885 pP
    db   $e6, $02, $e0, $55, $7a, $dc, $a9, $ab        ;; 0e:6887 .w......
    db   $ac, $d8, $a2, $a4, $a5, $a7, $a9, $e6        ;; 0e:688f ........
    db   $01, $dc, $aa, $ac, $d8, $a2, $a3, $a5        ;; 0e:6897 w.......
    db   $a7, $a9, $aa, $e6, $03, $e5, $40, $a2        ;; 0e:689f ....w...
    db   $a4, $a9, $a4, $ab, $a4, $a9, $d8, $a2        ;; 0e:68a7 ........
    db   $a4, $a1, $dc, $a9, $a4, $51, $e1             ;; 0e:68af .......
    dw   .data_0e_6794                                 ;; 0e:68b6 pP
.data_0e_68b8:
    db   $e4, $fe, $79, $e8, $a5, $7a, $e0, $20        ;; 0e:68b8 ........
    db   $e6, $03, $d1, $a9, $7f, $8f, $c9, $cf        ;; 0e:68c0 .w......
    db   $c9, $cf, $a9, $7f, $5f, $a9, $af, $a9        ;; 0e:68c8 ........
    db   $af, $8f, $c9, $cf, $c9, $cf, $a9, $7f        ;; 0e:68d0 ........
    db   $5f                                           ;; 0e:68d8 .
.data_0e_68d9:
    db   $e3, $02                                      ;; 0e:68d9 ..
.data_0e_68db:
    db   $d1, $79, $af, $b9, $bf, $b9, $bf, $b9        ;; 0e:68db ........
    db   $bf, $79, $af, $79, $af, $b9, $bf, $b9        ;; 0e:68e3 ........
    db   $bf, $b9, $bf, $79, $af, $79, $af, $b9        ;; 0e:68eb ........
    db   $bf, $b9, $bf, $b9, $bf, $5c, $b0, $bf        ;; 0e:68f3 ........
    db   $b0, $bf, $b0, $bf, $52, $56, $eb, $01        ;; 0e:68fb ........
    dw   .data_0e_690e                                 ;; 0e:6903 pP
    db   $29, $d8, $99, $94, $92, $51, $e2             ;; 0e:6905 .......
    dw   .data_0e_68db                                 ;; 0e:690c pP
.data_0e_690e:
    db   $79, $af, $a9, $ab, $ad, $d8, $a2, $a4        ;; 0e:690e ........
    db   $a6, $a8, $a9, $5d, $a2, $af, $a2, $7f        ;; 0e:6916 ........
    db   $a2, $7f, $a2, $7f, $a2, $af, $a7, $af        ;; 0e:691e ........
    db   $dc, $57, $59, $5b, $d8, $84, $55, $dc        ;; 0e:6926 ........
    db   $55, $57, $d8, $57, $a2, $af, $dc, $89        ;; 0e:692e ........
    db   $d8, $a2, $af, $dc, $89, $d8, $a2, $af        ;; 0e:6936 ........
    db   $dc, $89, $d8, $a2, $af, $dc, $89, $d8        ;; 0e:693e ........
    db   $a2, $af, $a2, $7f, $a2, $7f, $a2, $7f        ;; 0e:6946 ........
    db   $a2, $af, $a7, $af, $dc, $57, $59, $5b        ;; 0e:694e ........
    db   $d8, $84, $55, $dc, $55, $d8, $53, $dc        ;; 0e:6956 ........
    db   $5a, $59, $d8, $b9, $bf, $b9, $bf, $b9        ;; 0e:695e ........
    db   $bf, $59, $dc, $79, $af, $e1                  ;; 0e:6966 ......
    dw   .data_0e_68d9                                 ;; 0e:696c pP
    db   $e7, $96, $e4, $12, $7a, $e0, $53, $7a        ;; 0e:696e ????????
    db   $e5, $40, $e3, $02, $e6, $02, $e0, $53        ;; 0e:6976 ????????
    db   $7a, $d3, $b5, $b0, $dc, $b5, $e0, $55        ;; 0e:697e ????????
    db   $7a, $d3, $b5, $b0, $dc, $b5, $e0, $57        ;; 0e:6986 ????????
    db   $7a, $d3, $b5, $b0, $dc, $b5, $e0, $59        ;; 0e:698e ????????
    db   $7a, $d3, $b5, $b0, $dc, $b5, $e0, $5b        ;; 0e:6996 ????????
    db   $7a, $d3, $b5, $b0, $dc, $b5, $e0, $5d        ;; 0e:699e ????????
    db   $7a, $d3, $b5, $b0, $dc, $b5, $e0, $5f        ;; 0e:69a6 ????????
    db   $7a, $d3, $b5, $b0, $dc, $b5, $e0, $61        ;; 0e:69ae ????????
    db   $7a, $d3, $b5, $b0, $dc, $b5, $e6, $03        ;; 0e:69b6 ????????
    db   $e0, $63, $7a, $d8, $b7, $b0, $dc, $b7        ;; 0e:69be ????????
    db   $e0, $61, $7a, $d8, $b7, $b0, $dc, $b7        ;; 0e:69c6 ????????
    db   $e0, $5f, $7a, $d8, $b7, $b0, $dc, $b7        ;; 0e:69ce ????????
    db   $e0, $5d, $7a, $d8, $b7, $b0, $dc, $b7        ;; 0e:69d6 ????????
    db   $e0, $5b, $7a, $d8, $b7, $b0, $dc, $b7        ;; 0e:69de ????????
    db   $e0, $59, $7a, $d8, $b7, $b0, $dc, $b7        ;; 0e:69e6 ????????
    db   $e0, $57, $7a, $d8, $b7, $b0, $dc, $b7        ;; 0e:69ee ????????
    db   $e0, $55, $7a, $d8, $b7, $b0, $dc, $b7        ;; 0e:69f6 ????????
    db   $e6, $01, $e0, $53, $7a, $d8, $b8, $b0        ;; 0e:69fe ????????
    db   $dc, $b8, $e0, $55, $7a, $d8, $b8, $b0        ;; 0e:6a06 ????????
    db   $dc, $b8, $e0, $57, $7a, $d8, $b8, $b0        ;; 0e:6a0e ????????
    db   $dc, $b8, $e0, $59, $7a, $d8, $b8, $b0        ;; 0e:6a16 ????????
    db   $dc, $b8, $e0, $5b, $7a, $d8, $b8, $b0        ;; 0e:6a1e ????????
    db   $dc, $b8, $e0, $5d, $7a, $d8, $b8, $b0        ;; 0e:6a26 ????????
    db   $dc, $b8, $e0, $5f, $7a, $d8, $b8, $b0        ;; 0e:6a2e ????????
    db   $dc, $b8, $e0, $61, $7a, $d8, $b8, $b0        ;; 0e:6a36 ????????
    db   $dc, $b8, $e6, $03, $e0, $63, $7a, $d8        ;; 0e:6a3e ????????
    db   $ba, $b2, $dc, $ba, $e0, $61, $7a, $d8        ;; 0e:6a46 ????????
    db   $ba, $b2, $dc, $ba, $e0, $5f, $7a, $d8        ;; 0e:6a4e ????????
    db   $ba, $b2, $dc, $ba, $e0, $5d, $7a, $d8        ;; 0e:6a56 ????????
    db   $ba, $b2, $dc, $ba, $e0, $5b, $7a, $d8        ;; 0e:6a5e ????????
    db   $ba, $b2, $dc, $ba, $e0, $59, $7a, $d8        ;; 0e:6a66 ????????
    db   $ba, $b2, $dc, $ba, $e0, $57, $7a, $d8        ;; 0e:6a6e ????????
    db   $ba, $b2, $dc, $ba, $e0, $55, $7a, $d8        ;; 0e:6a76 ????????
    db   $ba, $b2, $dc, $ba, $e2, $7a, $69, $e7        ;; 0e:6a7e ????????
    db   $9b, $e0, $53, $7a, $a5, $af, $a5, $af        ;; 0e:6a86 ????????
    db   $e0, $63, $7a, $e6, $02, $a5, $af, $e6        ;; 0e:6a8e ????????
    db   $01, $a5, $af, $e6, $02, $a5, $af, $e6        ;; 0e:6a96 ????????
    db   $03, $e0, $53, $7a, $47, $48, $4a, $5c        ;; 0e:6a9e ????????
    db   $a5, $af, $a5, $af, $e0, $63, $7a, $e6        ;; 0e:6aa6 ????????
    db   $02, $a5, $af, $e6, $01, $a5, $af, $e6        ;; 0e:6aae ????????
    db   $02, $a5, $af, $e6, $03, $e0, $53, $7a        ;; 0e:6ab6 ????????
    db   $47, $48, $4a, $5c, $d8, $e3, $02, $e6        ;; 0e:6abe ????????
    db   $02, $a5, $d8, $a5, $dc, $a0, $ac, $e6        ;; 0e:6ac6 ????????
    db   $03, $dc, $ab, $d8, $ab, $a5, $d8, $a5        ;; 0e:6ace ????????
    db   $e6, $01, $dc, $a4, $d8, $a4, $dd, $ab        ;; 0e:6ad6 ????????
    db   $d8, $ab, $e6, $03, $dc, $aa, $d8, $aa        ;; 0e:6ade ????????
    db   $a4, $d8, $a4, $e6, $02, $dc, $a3, $d8        ;; 0e:6ae6 ????????
    db   $a3, $dd, $aa, $d8, $aa, $e6, $03, $dc        ;; 0e:6aee ????????
    db   $a9, $d8, $a9, $a3, $d8, $a3, $eb, $01        ;; 0e:6af6 ????????
    db   $17, $6b, $e6, $01, $dc, $a4, $d8, $a4        ;; 0e:6afe ????????
    db   $dd, $ab, $d8, $ab, $e6, $03, $dc, $aa        ;; 0e:6b06 ????????
    db   $d8, $aa, $a4, $d8, $a4, $dc, $e2, $c5        ;; 0e:6b0e ????????
    db   $6a, $e6, $01, $dc, $a2, $d8, $a2, $dd        ;; 0e:6b16 ????????
    db   $a9, $d8, $a9, $e6, $03, $dc, $a8, $d8        ;; 0e:6b1e ????????
    db   $a8, $a2, $d8, $a2, $dd, $a5, $af, $a5        ;; 0e:6b26 ????????
    db   $af, $e0, $63, $7a, $e6, $02, $a5, $af        ;; 0e:6b2e ????????
    db   $e6, $01, $a5, $af, $e6, $02, $a5, $af        ;; 0e:6b36 ????????
    db   $e6, $03, $e0, $53, $7a, $47, $48, $4a        ;; 0e:6b3e ????????
    db   $5c, $a5, $af, $a5, $af, $e0, $63, $7a        ;; 0e:6b46 ????????
    db   $e6, $02, $a5, $af, $e6, $01, $a5, $af        ;; 0e:6b4e ????????
    db   $e6, $02, $a5, $af, $e6, $03, $e0, $53        ;; 0e:6b56 ????????
    db   $7a, $47, $48, $4a, $5c, $e5, $40, $e4        ;; 0e:6b5e ????????
    db   $12, $7a, $e0, $53, $7a, $5c, $d8, $53        ;; 0e:6b66 ????????
    db   $52, $50, $55, $83, $52, $82, $50, $57        ;; 0e:6b6e ????????
    db   $55, $53, $52, $55, $83, $52, $82, $50        ;; 0e:6b76 ????????
    db   $dc, $ab, $ac, $d8, $a2, $dc, $ab, $27        ;; 0e:6b7e ????????
    db   $e6, $01, $d8, $a2, $a3, $a5, $a2, $dc        ;; 0e:6b86 ????????
    db   $8b, $e6, $03, $d8, $a5, $a7, $a8, $a5        ;; 0e:6b8e ????????
    db   $82, $e6, $02, $ab, $ac, $d8, $a2, $dc        ;; 0e:6b96 ????????
    db   $ab, $57, $e6, $03, $e0, $3b, $7a, $e5        ;; 0e:6b9e ????????
    db   $00, $a2, $dc, $a7, $ab, $d8, $a5, $a3        ;; 0e:6ba6 ????????
    db   $a1, $a2, $aa, $a8, $a6, $a7, $d8, $a3        ;; 0e:6bae ????????
    db   $a2, $dc, $aa, $ab, $d8, $a5, $e6, $01        ;; 0e:6bb6 ????????
    db   $87, $dc, $c7, $cf, $c7, $cf, $e6, $02        ;; 0e:6bbe ????????
    db   $d8, $85, $dc, $c7, $cf, $c7, $cf, $e6        ;; 0e:6bc6 ????????
    db   $01, $d8, $83, $dc, $c7, $cf, $c7, $cf        ;; 0e:6bce ????????
    db   $e6, $03, $d8, $a2, $dc, $ab, $a7, $ab        ;; 0e:6bd6 ????????
    db   $e0, $53, $7a, $e5, $40, $50, $53, $52        ;; 0e:6bde ????????
    db   $50, $55, $83, $52, $82, $50, $57, $55        ;; 0e:6be6 ????????
    db   $53, $52, $55, $83, $52, $82, $50, $dc        ;; 0e:6bee ????????
    db   $ab, $ac, $d8, $a2, $dc, $ab, $d8, $27        ;; 0e:6bf6 ????????
    db   $e6, $01, $ab, $ac, $d8, $a2, $dc, $ab        ;; 0e:6bfe ????????
    db   $d8, $87, $e6, $02, $dc, $ab, $ac, $d8        ;; 0e:6c06 ????????
    db   $a2, $dc, $ab, $d8, $85, $e6, $03, $e0        ;; 0e:6c0e ????????
    db   $3b, $7a, $e5, $00, $dc, $ab, $ac, $d8        ;; 0e:6c16 ????????
    db   $a2, $dc, $ab, $d8, $a3, $a2, $a0, $dc        ;; 0e:6c1e ????????
    db   $ab, $e5, $80, $a7, $a8, $a7, $a5, $a3        ;; 0e:6c26 ????????
    db   $a2, $a5, $a3, $e5, $40, $a2, $a3, $a2        ;; 0e:6c2e ????????
    db   $a0, $dc, $ab, $a7, $d8, $a2, $a0, $e5        ;; 0e:6c36 ????????
    db   $00, $dc, $ab, $ac, $ab, $a7, $a8, $aa        ;; 0e:6c3e ????????
    db   $a8, $a5, $e5, $80, $a7, $a8, $aa, $ab        ;; 0e:6c46 ????????
    db   $ac, $d8, $a2, $a3, $a5, $e4, $fe, $79        ;; 0e:6c4e ????????
    db   $e0, $31, $7a, $e5, $40, $87, $85, $80        ;; 0e:6c56 ????????
    db   $dc, $88, $87, $85, $d8, $83, $12, $82        ;; 0e:6c5e ????????
    db   $83, $85, $52, $52, $53, $55, $57, $88        ;; 0e:6c66 ????????
    db   $87, $85, $87, $85, $03, $a2, $a3, $55        ;; 0e:6c6e ????????
    db   $53, $82, $80, $83, $02, $0e, $8f, $dc        ;; 0e:6c76 ????????
    db   $e1, $63, $6b, $e4, $fe, $79, $e0, $57        ;; 0e:6c7e ????????
    db   $7a, $e5, $00, $e3, $02, $e6, $01, $d1        ;; 0e:6c86 ????????
    db   $a8, $aa, $8c, $a7, $a8, $8a, $a8, $aa        ;; 0e:6c8e ????????
    db   $8c, $a7, $a8, $aa, $ac, $d1, $a8, $aa        ;; 0e:6c96 ????????
    db   $8c, $a7, $a8, $8a, $a8, $aa, $8c, $a7        ;; 0e:6c9e ????????
    db   $a8, $aa, $ac, $e6, $02, $d1, $a8, $aa        ;; 0e:6ca6 ????????
    db   $8c, $a7, $a8, $8a, $a8, $aa, $8c, $a7        ;; 0e:6cae ????????
    db   $a8, $aa, $ac, $a8, $aa, $8c, $a7, $a8        ;; 0e:6cb6 ????????
    db   $8a, $a5, $a7, $a8, $aa, $ac, $d8, $a2        ;; 0e:6cbe ????????
    db   $a3, $a5, $e2, $8b, $6c, $dc, $e3, $02        ;; 0e:6cc6 ????????
    db   $e6, $03, $e5, $40, $a0, $af, $a0, $af        ;; 0e:6cce ????????
    db   $e0, $65, $7a, $e6, $02, $a0, $af, $e6        ;; 0e:6cd6 ????????
    db   $01, $a0, $af, $e6, $02, $a0, $af, $e6        ;; 0e:6cde ????????
    db   $03, $e0, $57, $7a, $42, $43, $45, $58        ;; 0e:6ce6 ????????
    db   $a0, $af, $a0, $af, $e0, $65, $7a, $e6        ;; 0e:6cee ????????
    db   $02, $a0, $af, $e6, $01, $a0, $af, $e6        ;; 0e:6cf6 ????????
    db   $02, $a0, $af, $e0, $57, $7a, $e6, $03        ;; 0e:6cfe ????????
    db   $42, $43, $45, $58, $eb, $01, $38, $6d        ;; 0e:6d06 ????????
    db   $a0, $af, $a0, $af, $4f, $dc, $47, $aa        ;; 0e:6d0e ????????
    db   $af, $aa, $af, $4f, $46, $a8, $af, $a8        ;; 0e:6d16 ????????
    db   $af, $4f, $4b, $aa, $af, $aa, $af, $5f        ;; 0e:6d1e ????????
    db   $e6, $02, $a3, $a4, $a5, $e6, $03, $a6        ;; 0e:6d26 ????????
    db   $a7, $a8, $e6, $01, $a9, $aa, $d8, $e2        ;; 0e:6d2e ????????
    db   $ce, $6c, $ea, $02, $e3, $0a, $e5, $00        ;; 0e:6d36 ????????
    db   $e0, $43, $7a, $e6, $02, $83, $85, $87        ;; 0e:6d3e ????????
    db   $e2, $3c, $6d, $83, $85, $e3, $0a, $82        ;; 0e:6d46 ????????
    db   $83, $85, $e2, $4d, $6d, $82, $83, $e9        ;; 0e:6d4e ????????
    db   $3a, $6d, $e5, $40, $e0, $57, $7a, $58        ;; 0e:6d56 ????????
    db   $55, $53, $8c, $5a, $8c, $88, $8a, $87        ;; 0e:6d5e ????????
    db   $88, $87, $85, $87, $8b, $87, $8b, $89        ;; 0e:6d66 ????????
    db   $8c, $8b, $d8, $82, $53, $52, $50, $dc        ;; 0e:6d6e ????????
    db   $8a, $59, $86, $83, $80, $dc, $89, $8c        ;; 0e:6d76 ????????
    db   $d8, $83, $86, $82, $86, $89, $8c, $80        ;; 0e:6d7e ????????
    db   $83, $86, $89, $8c, $c5, $cf, $c7, $cf        ;; 0e:6d86 ????????
    db   $82, $8c, $c5, $cf, $c7, $cf, $82, $ac        ;; 0e:6d8e ????????
    db   $a5, $a7, $a2, $8b, $c5, $cf, $c7, $cf        ;; 0e:6d96 ????????
    db   $82, $8b, $c5, $cf, $c7, $cf, $82, $ab        ;; 0e:6d9e ????????
    db   $a5, $a7, $a2, $e1, $38, $6d, $e4, $fe        ;; 0e:6da6 ????????
    db   $79, $e8, $a5, $7a, $e0, $20, $e6, $03        ;; 0e:6dae ????????
    db   $e3, $02, $d1, $05, $04, $03, $22, $8e        ;; 0e:6db6 ????????
    db   $8a, $d8, $85, $82, $e2, $b8, $6d, $e3        ;; 0e:6dbe ????????
    db   $02, $dc, $a5, $af, $a5, $af, $88, $87        ;; 0e:6dc6 ????????
    db   $85, $8b, $8a, $88, $85, $8c, $8a, $d8        ;; 0e:6dce ????????
    db   $82, $80, $83, $82, $85, $e2, $c7, $6d        ;; 0e:6dd6 ????????
    db   $a5, $af, $a5, $af, $4f, $40, $a3, $af        ;; 0e:6dde ????????
    db   $a3, $af, $4f, $dc, $4b, $ad, $af, $ad        ;; 0e:6de6 ????????
    db   $af, $4f, $d8, $44, $a3, $af, $a3, $af        ;; 0e:6dee ????????
    db   $5f, $e6, $02, $dc, $a5, $a6, $e6, $03        ;; 0e:6df6 ????????
    db   $a7, $a8, $a9, $e6, $01, $aa, $ab, $ac        ;; 0e:6dfe ????????
    db   $d8, $e3, $02, $e6, $03, $dc, $a5, $af        ;; 0e:6e06 ????????
    db   $a5, $af, $88, $87, $85, $8b, $8a, $88        ;; 0e:6e0e ????????
    db   $85, $8c, $8a, $d8, $82, $80, $83, $eb        ;; 0e:6e16 ????????
    db   $01, $26, $6e, $82, $85, $e2, $09, $6e        ;; 0e:6e1e ????????
    db   $e8, $85, $7a, $c2, $c1, $c0, $dc, $cb        ;; 0e:6e26 ????????
    db   $ca, $c9, $c8, $c7, $d8, $ea, $02, $e3        ;; 0e:6e2e ????????
    db   $04, $e8, $a5, $7a, $dc, $88, $d8, $88        ;; 0e:6e36 ????????
    db   $87, $88, $8c, $88, $87, $88, $e2, $37        ;; 0e:6e3e ????????
    db   $6e, $e3, $04, $dc, $87, $d8, $87, $85        ;; 0e:6e46 ????????
    db   $87, $8b, $87, $85, $87, $e2, $49, $6e        ;; 0e:6e4e ????????
    db   $e9, $35, $6e, $e3, $04, $dc, $a5, $af        ;; 0e:6e56 ????????
    db   $d8, $85, $e2, $5b, $6e, $e3, $03, $dc        ;; 0e:6e5e ????????
    db   $aa, $af, $d8, $8a, $e2, $65, $6e, $dc        ;; 0e:6e66 ????????
    db   $a8, $af, $d8, $88, $e3, $04, $dc, $a7        ;; 0e:6e6e ????????
    db   $af, $d8, $87, $e2, $74, $6e, $a0, $af        ;; 0e:6e76 ????????
    db   $8c, $dc, $aa, $af, $d8, $8a, $dc, $a8        ;; 0e:6e7e ????????
    db   $af, $d8, $88, $dc, $a7, $af, $d8, $87        ;; 0e:6e86 ????????
    db   $e3, $04, $dc, $a6, $af, $d8, $86, $e2        ;; 0e:6e8e ????????
    db   $90, $6e, $e3, $04, $dc, $a2, $af, $d8        ;; 0e:6e96 ????????
    db   $82, $e2, $9a, $6e, $a7, $af, $dc, $a7        ;; 0e:6e9e ????????
    db   $af, $a7, $af, $d8, $a5, $af, $dc, $a7        ;; 0e:6ea6 ????????
    db   $af, $a7, $af, $d8, $a3, $af, $dc, $a7        ;; 0e:6eae ????????
    db   $af, $d8, $a2, $af, $dc, $a7, $af, $a7        ;; 0e:6eb6 ????????
    db   $af, $ac, $af, $a7, $af, $a7, $af, $ab        ;; 0e:6ebe ????????
    db   $af, $a7, $af, $d8, $e1, $33, $6e, $e4        ;; 0e:6ec6 ????????
    db   $fe, $79, $e0, $31, $7a, $e5, $80, $e6        ;; 0e:6ece ????????
    db   $03, $e3, $02, $e7, $46, $d3, $84, $83        ;; 0e:6ed6 ????????
    db   $84, $dc, $8b, $2d, $8f, $d8, $86, $84        ;; 0e:6ede ????????
    db   $83, $84, $83, $84, $dc, $8b, $2d, $59        ;; 0e:6ee6 ????????
    db   $5b, $8c, $8b, $8c, $87, $29, $8f, $d8        ;; 0e:6eee ????????
    db   $82, $80, $dc, $8b, $8c, $8b, $8c, $87        ;; 0e:6ef6 ????????
    db   $29, $5b, $8c, $d8, $82, $e2, $d9, $6e        ;; 0e:6efe ????????
    db   $e3, $02, $82, $81, $82, $87, $86, $84        ;; 0e:6f06 ????????
    db   $dc, $8b, $8d, $d8, $82, $80, $dc, $87        ;; 0e:6f0e ????????
    db   $d8, $27, $8e, $eb, $01, $2b, $6f, $87        ;; 0e:6f16 ????????
    db   $85, $80, $83, $52, $83, $85, $52, $dc        ;; 0e:6f1e ????????
    db   $1a, $d8, $e2, $08, $6f, $82, $80, $dc        ;; 0e:6f26 ????????
    db   $87, $d8, $47, $55, $e7, $45, $87, $e7        ;; 0e:6f2e ????????
    db   $44, $8e, $e7, $42, $8e, $e7, $40, $8e        ;; 0e:6f36 ????????
    db   $e7, $3e, $8e, $e7, $3c, $8e, $e7, $3a        ;; 0e:6f3e ????????
    db   $8e, $e7, $38, $8e, $e1, $d7, $6e, $e4        ;; 0e:6f46 ????????
    db   $0b, $7a, $e5, $40, $e6, $01, $ea, $02        ;; 0e:6f4e ????????
    db   $d2, $e3, $03, $e0, $65, $7a, $c4, $c6        ;; 0e:6f56 ????????
    db   $c4, $c6, $e0, $63, $7a, $c4, $c6, $c4        ;; 0e:6f5e ????????
    db   $c6, $e0, $61, $7a, $c4, $c6, $c4, $c6        ;; 0e:6f66 ????????
    db   $e0, $5f, $7a, $c4, $c6, $c4, $c6, $e0        ;; 0e:6f6e ????????
    db   $5d, $7a, $c4, $c6, $c4, $c6, $e0, $5b        ;; 0e:6f76 ????????
    db   $7a, $c4, $c6, $c4, $c6, $e0, $59, $7a        ;; 0e:6f7e ????????
    db   $c4, $c6, $c4, $c6, $e0, $57, $7a, $c4        ;; 0e:6f86 ????????
    db   $c6, $c4, $c6, $e2, $59, $6f, $e3, $03        ;; 0e:6f8e ????????
    db   $e0, $65, $7a, $c4, $c5, $c4, $c5, $e0        ;; 0e:6f96 ????????
    db   $63, $7a, $c4, $c5, $c4, $c5, $e0, $61        ;; 0e:6f9e ????????
    db   $7a, $c4, $c5, $c4, $c5, $e0, $5f, $7a        ;; 0e:6fa6 ????????
    db   $c4, $c5, $c4, $c5, $e0, $5d, $7a, $c4        ;; 0e:6fae ????????
    db   $c5, $c4, $c5, $e0, $5b, $7a, $c4, $c5        ;; 0e:6fb6 ????????
    db   $c4, $c5, $e0, $59, $7a, $c4, $c5, $c4        ;; 0e:6fbe ????????
    db   $c5, $e0, $57, $7a, $c4, $c5, $c4, $c5        ;; 0e:6fc6 ????????
    db   $e2, $96, $6f, $e9, $56, $6f, $e0, $65        ;; 0e:6fce ????????
    db   $7a, $c2, $c4, $c2, $c4, $e0, $63, $7a        ;; 0e:6fd6 ????????
    db   $c2, $c4, $c2, $c4, $e0, $61, $7a, $c2        ;; 0e:6fde ????????
    db   $c4, $c2, $c4, $e0, $5f, $7a, $c2, $c4        ;; 0e:6fe6 ????????
    db   $c2, $c4, $e0, $5d, $7a, $c2, $c4, $c2        ;; 0e:6fee ????????
    db   $c4, $e0, $5b, $7a, $c2, $c4, $c2, $c4        ;; 0e:6ff6 ????????
    db   $e0, $59, $7a, $c2, $c4, $c2, $c4, $e0        ;; 0e:6ffe ????????
    db   $57, $7a, $c2, $c4, $c2, $c4, $e0, $65        ;; 0e:7006 ????????
    db   $7a, $c3, $c5, $c3, $c5, $e0, $63, $7a        ;; 0e:700e ????????
    db   $c3, $c5, $c3, $c5, $e0, $61, $7a, $c3        ;; 0e:7016 ????????
    db   $c5, $c3, $c5, $e0, $5f, $7a, $c3, $c5        ;; 0e:701e ????????
    db   $c3, $c5, $e0, $5d, $7a, $c3, $c5, $c3        ;; 0e:7026 ????????
    db   $c5, $e0, $5b, $7a, $c3, $c5, $c3, $c5        ;; 0e:702e ????????
    db   $e0, $59, $7a, $c3, $c5, $c3, $c5, $e0        ;; 0e:7036 ????????
    db   $57, $7a, $c3, $c5, $c3, $c5, $e3, $02        ;; 0e:703e ????????
    db   $e0, $65, $7a, $c5, $c7, $c5, $c7, $e0        ;; 0e:7046 ????????
    db   $63, $7a, $c5, $c7, $c5, $c7, $e0, $61        ;; 0e:704e ????????
    db   $7a, $c5, $c7, $c5, $c7, $e0, $5f, $7a        ;; 0e:7056 ????????
    db   $c5, $c7, $c5, $c7, $e0, $5d, $7a, $c5        ;; 0e:705e ????????
    db   $c7, $c5, $c7, $e0, $5b, $7a, $c5, $c7        ;; 0e:7066 ????????
    db   $c5, $c7, $e0, $59, $7a, $c5, $c7, $c5        ;; 0e:706e ????????
    db   $c7, $e0, $57, $7a, $c5, $c7, $c5, $c7        ;; 0e:7076 ????????
    db   $e2, $46, $70, $e0, $65, $7a, $c2, $c4        ;; 0e:707e ????????
    db   $c2, $c4, $e0, $63, $7a, $c2, $c4, $c2        ;; 0e:7086 ????????
    db   $c4, $e0, $61, $7a, $c2, $c4, $c2, $c4        ;; 0e:708e ????????
    db   $e0, $5f, $7a, $c2, $c4, $c2, $c4, $e0        ;; 0e:7096 ????????
    db   $5d, $7a, $c2, $c4, $c2, $c4, $e0, $5b        ;; 0e:709e ????????
    db   $7a, $c2, $c4, $c2, $c4, $e0, $59, $7a        ;; 0e:70a6 ????????
    db   $c2, $c4, $c2, $c4, $e0, $57, $7a, $c2        ;; 0e:70ae ????????
    db   $c4, $c2, $c4, $e0, $65, $7a, $c3, $c5        ;; 0e:70b6 ????????
    db   $c3, $c5, $e0, $63, $7a, $c3, $c5, $c3        ;; 0e:70be ????????
    db   $c5, $e0, $61, $7a, $c3, $c5, $c3, $c5        ;; 0e:70c6 ????????
    db   $e0, $5f, $7a, $c3, $c5, $c3, $c5, $e0        ;; 0e:70ce ????????
    db   $5d, $7a, $c3, $c5, $c3, $c5, $e0, $5b        ;; 0e:70d6 ????????
    db   $7a, $c3, $c5, $c3, $c5, $e0, $59, $7a        ;; 0e:70de ????????
    db   $c3, $c5, $c3, $c5, $e0, $57, $7a, $c3        ;; 0e:70e6 ????????
    db   $c5, $c3, $c5, $e0, $65, $7a, $c2, $c5        ;; 0e:70ee ????????
    db   $c2, $c5, $e0, $63, $7a, $c2, $c5, $c2        ;; 0e:70f6 ????????
    db   $c5, $e0, $61, $7a, $c2, $c5, $c2, $c5        ;; 0e:70fe ????????
    db   $e0, $5f, $7a, $c2, $c5, $c2, $c5, $e0        ;; 0e:7106 ????????
    db   $5d, $7a, $c2, $c5, $c2, $c5, $e0, $5b        ;; 0e:710e ????????
    db   $7a, $c2, $c5, $c2, $c5, $e0, $59, $7a        ;; 0e:7116 ????????
    db   $c2, $c5, $c2, $c5, $e0, $57, $7a, $c2        ;; 0e:711e ????????
    db   $c5, $c2, $c5, $e0, $65, $7a, $c4, $c5        ;; 0e:7126 ????????
    db   $c4, $c5, $e0, $63, $7a, $c4, $c5, $c4        ;; 0e:712e ????????
    db   $c5, $e0, $61, $7a, $c4, $c5, $c4, $c5        ;; 0e:7136 ????????
    db   $e0, $5f, $7a, $c4, $c5, $c4, $c5, $e0        ;; 0e:713e ????????
    db   $5d, $7a, $c4, $c5, $c4, $c5, $e0, $5b        ;; 0e:7146 ????????
    db   $7a, $c4, $c5, $c4, $c5, $e0, $59, $7a        ;; 0e:714e ????????
    db   $c4, $c5, $c4, $c5, $e0, $57, $7a, $c4        ;; 0e:7156 ????????
    db   $c5, $c4, $c5, $e1, $54, $6f, $e4, $fe        ;; 0e:715e ????????
    db   $79, $e8, $a5, $7a, $e0, $20, $e6, $02        ;; 0e:7166 ????????
    db   $ea, $02, $e3, $03, $d1, $89, $d8, $84        ;; 0e:716e ????????
    db   $89, $84, $8d, $89, $84, $89, $e2, $72        ;; 0e:7176 ????????
    db   $71, $e3, $03, $dc, $85, $8c, $d8, $85        ;; 0e:717e ????????
    db   $80, $89, $85, $80, $85, $e2, $81, $71        ;; 0e:7186 ????????
    db   $e9, $70, $71, $e3, $02, $dc, $87, $d8        ;; 0e:718e ????????
    db   $82, $87, $82, $8b, $87, $82, $87, $dc        ;; 0e:7196 ????????
    db   $88, $d8, $83, $88, $83, $8c, $88, $83        ;; 0e:719e ????????
    db   $88, $eb, $01, $c6, $71, $dc, $85, $8c        ;; 0e:71a6 ????????
    db   $d8, $85, $88, $dc, $8a, $d8, $85, $8a        ;; 0e:71ae ????????
    db   $85, $dc, $83, $8a, $d8, $83, $87, $8a        ;; 0e:71b6 ????????
    db   $87, $83, $dc, $8a, $d8, $e2, $93, $71        ;; 0e:71be ????????
    db   $dc, $8a, $d8, $85, $8a, $85, $82, $85        ;; 0e:71c6 ????????
    db   $8a, $85, $dc, $80, $8c, $d8, $84, $87        ;; 0e:71ce ????????
    db   $8c, $87, $84, $80, $e1, $6e, $71, $e4        ;; 0e:71d6 ????????
    db   $fe, $79, $e0, $31, $7a, $e5, $40, $e6        ;; 0e:71de ????????
    db   $03, $e7, $49, $d2, $8a, $e7, $46, $89        ;; 0e:71e6 ????????
    db   $e7, $44, $8a, $e7, $41, $8b, $e7, $3c        ;; 0e:71ee ????????
    db   $5c, $5b, $e3, $02, $e7, $4e, $e0, $6d        ;; 0e:71f6 ????????
    db   $7a, $4a, $ab, $ac, $4d, $d8, $a2, $a3        ;; 0e:71fe ????????
    db   $84, $b3, $b4, $b3, $41, $b0, $b1, $b0        ;; 0e:7206 ????????
    db   $dc, $8a, $88, $57, $be, $ba, $bc, $ba        ;; 0e:720e ????????
    db   $b7, $b5, $07, $eb, $01, $29, $72, $ba        ;; 0e:7216 ????????
    db   $b7, $ba, $bd, $ba, $bd, $d8, $54, $dc        ;; 0e:721e ????????
    db   $e2, $fa, $71, $8a, $a9, $a8, $57, $e0        ;; 0e:7226 ????????
    db   $31, $7a, $e6, $01, $b6, $b9, $b6, $bc        ;; 0e:722e ????????
    db   $b9, $bc, $d8, $53, $dc, $e6, $02, $b5        ;; 0e:7236 ????????
    db   $b8, $b5, $bb, $b8, $bb, $d8, $52, $dc        ;; 0e:723e ????????
    db   $e6, $03, $84, $85, $86, $87, $58, $59        ;; 0e:7246 ????????
    db   $e1, $e7, $71, $e4, $fe, $79, $e0, $31        ;; 0e:724e ????????
    db   $7a, $e5, $00, $e6, $03, $d2, $87, $86        ;; 0e:7256 ????????
    db   $87, $88, $59, $58, $e3, $02, $e0, $71        ;; 0e:725e ????????
    db   $7a, $e6, $01, $47, $e6, $03, $a8, $a9        ;; 0e:7266 ????????
    db   $e6, $02, $4a, $e6, $03, $ab, $ac, $e6        ;; 0e:726e ????????
    db   $01, $8d, $e6, $03, $bc, $bd, $bc, $e6        ;; 0e:7276 ????????
    db   $02, $4a, $e6, $03, $b9, $ba, $b9, $e6        ;; 0e:727e ????????
    db   $01, $87, $85, $e6, $02, $a4, $a3, $e6        ;; 0e:7286 ????????
    db   $03, $a2, $a1, $e6, $01, $a4, $a3, $e6        ;; 0e:728e ????????
    db   $03, $a2, $a1, $e6, $02, $a4, $a3, $e6        ;; 0e:7296 ????????
    db   $03, $a2, $a1, $e6, $01, $a4, $a3, $e6        ;; 0e:729e ????????
    db   $03, $a2, $a1, $eb, $01, $ce, $72, $e6        ;; 0e:72a6 ????????
    db   $02, $a4, $a3, $e6, $03, $a2, $a1, $e6        ;; 0e:72ae ????????
    db   $01, $a4, $a3, $e6, $02, $a2, $a1, $e6        ;; 0e:72b6 ????????
    db   $03, $b7, $b4, $b7, $ba, $b7, $ba, $e6        ;; 0e:72be ????????
    db   $01, $a3, $a4, $a5, $a6, $e2, $64, $72        ;; 0e:72c6 ????????
    db   $e6, $02, $a4, $a3, $e6, $03, $a2, $a1        ;; 0e:72ce ????????
    db   $e6, $01, $a4, $a3, $e6, $03, $a2, $a1        ;; 0e:72d6 ????????
    db   $e6, $02, $a4, $a3, $e6, $03, $a2, $a1        ;; 0e:72de ????????
    db   $e6, $01, $a4, $a3, $e6, $03, $a2, $a1        ;; 0e:72e6 ????????
    db   $e0, $31, $7a, $e6, $02, $23, $e6, $01        ;; 0e:72ee ????????
    db   $22, $e6, $03, $81, $82, $83, $84, $55        ;; 0e:72f6 ????????
    db   $56, $e1, $5b, $72, $e4, $fe, $79, $e8        ;; 0e:72fe ????????
    db   $95, $7a, $e0, $20, $e6, $03, $d2, $84        ;; 0e:7306 ????????
    db   $83, $84, $85, $56, $55, $e3, $0e, $a4        ;; 0e:730e ????????
    db   $af, $e2, $15, $73, $84, $a3, $a2, $e3        ;; 0e:7316 ????????
    db   $0e, $a1, $af, $e2, $1f, $73, $81, $a2        ;; 0e:731e ????????
    db   $a3, $e3, $0e, $a4, $af, $e2, $29, $73        ;; 0e:7326 ????????
    db   $84, $a3, $a2, $e3, $10, $a1, $af, $e2        ;; 0e:732e ????????
    db   $33, $73, $20, $dc, $2b, $8a, $8b, $8c        ;; 0e:7336 ????????
    db   $8d, $d8, $52, $53, $e1, $0c, $73, $e4        ;; 0e:733e ????????
    db   $fe, $79, $e6, $03, $e7, $42, $e0, $31        ;; 0e:7346 ????????
    db   $7a, $e5, $80, $d1, $8f, $8b, $d8, $86        ;; 0e:734e ????????
    db   $84, $5b, $88, $89, $8b, $89, $88, $89        ;; 0e:7356 ????????
    db   $54, $56, $dc, $8f, $8b, $d8, $86, $84        ;; 0e:735e ????????
    db   $5b, $88, $89, $8b, $89, $88, $89, $54        ;; 0e:7366 ????????
    db   $56, $d8, $e0, $6d, $7a, $e5, $40, $88        ;; 0e:736e ????????
    db   $86, $88, $89, $4b, $8d, $1b, $89, $88        ;; 0e:7376 ????????
    db   $59, $51, $54, $59, $18, $86, $84, $26        ;; 0e:737e ????????
    db   $88, $86, $84, $86, $24, $86, $84, $83        ;; 0e:7386 ????????
    db   $84, $81, $83, $84, $86, $53, $dc, $8b        ;; 0e:738e ????????
    db   $8d, $0d, $e0, $31, $7a, $e7, $3c, $89        ;; 0e:7396 ????????
    db   $88, $89, $8b, $e7, $35, $8c, $8b, $8c        ;; 0e:739e ????????
    db   $d8, $e7, $31, $82, $14, $e7, $7d, $5e        ;; 0e:73a6 ????????
    db   $e0, $57, $7a, $dc, $53, $93, $91, $93        ;; 0e:73ae ????????
    db   $54, $94, $93, $94, $55, $95, $94, $95        ;; 0e:73b6 ????????
    db   $96, $98, $99, $98, $96, $94, $53, $93        ;; 0e:73be ????????
    db   $91, $93, $54, $94, $93, $94, $55, $95        ;; 0e:73c6 ????????
    db   $94, $95, $e5, $80, $a6, $a8, $a9, $ab        ;; 0e:73ce ????????
    db   $bd, $d8, $b3, $b4, $b6, $b8, $b9, $dc        ;; 0e:73d6 ????????
    db   $e0, $43, $7a, $e5, $40, $9b, $9b, $9b        ;; 0e:73de ????????
    db   $9b, $96, $9b, $9d, $9d, $9d, $9d, $99        ;; 0e:73e6 ????????
    db   $9d, $d8, $e0, $57, $7a, $03, $dc, $e3        ;; 0e:73ee ????????
    db   $02, $e7, $7d, $28, $8e, $86, $88, $89        ;; 0e:73f6 ????????
    db   $56, $5b, $5d, $d8, $53, $22, $8e, $82        ;; 0e:73fe ????????
    db   $81, $dc, $8b, $eb, $01, $2c, $74, $5b        ;; 0e:7406 ????????
    db   $29, $89, $8b, $2c, $8e, $d8, $84, $82        ;; 0e:740e ????????
    db   $80, $dc, $5b, $57, $52, $56, $24, $8e        ;; 0e:7416 ????????
    db   $87, $86, $84, $44, $a3, $a1, $53, $e7        ;; 0e:741e ????????
    db   $76, $84, $86, $e2, $f7, $73, $5b, $59        ;; 0e:7426 ????????
    db   $ae, $a6, $a5, $a6, $a8, $a6, $a5, $a6        ;; 0e:742e ????????
    db   $d8, $23, $84, $83, $81, $83, $54, $dc        ;; 0e:7436 ????????
    db   $5b, $5d, $59, $38, $99, $98, $46, $84        ;; 0e:743e ????????
    db   $54, $e0, $31, $7a, $e5, $80, $e7, $7a        ;; 0e:7446 ????????
    db   $58, $59, $5b, $e0, $55, $7a, $e7, $7d        ;; 0e:744e ????????
    db   $99, $9d, $99, $d8, $94, $91, $94, $e0        ;; 0e:7456 ????????
    db   $6b, $7a, $28, $e0, $57, $7a, $e5, $40        ;; 0e:745e ????????
    db   $8f, $a3, $a1, $83, $84, $a6, $a8, $a6        ;; 0e:7466 ????????
    db   $a4, $a3, $a4, $a3, $a1, $e0, $55, $7a        ;; 0e:746e ????????
    db   $e5, $80, $dc, $98, $9b, $98, $d8, $93        ;; 0e:7476 ????????
    db   $dc, $9b, $d8, $93, $e0, $6b, $7a, $26        ;; 0e:747e ????????
    db   $e0, $57, $7a, $e5, $40, $8f, $a4, $a3        ;; 0e:7486 ????????
    db   $81, $83, $a4, $a6, $a4, $a3, $a1, $a3        ;; 0e:748e ????????
    db   $a1, $dc, $ab, $e0, $6d, $7a, $49, $a8        ;; 0e:7496 ????????
    db   $a9, $4b, $a9, $ab, $8d, $ab, $ad, $d8        ;; 0e:749e ????????
    db   $83, $a1, $a3, $84, $a3, $a4, $86, $a4        ;; 0e:74a6 ????????
    db   $a6, $48, $a4, $a6, $88, $86, $88, $89        ;; 0e:74ae ????????
    db   $46, $a8, $a9, $88, $86, $84, $83, $41        ;; 0e:74b6 ????????
    db   $dc, $ab, $ad, $d8, $43, $a1, $a3, $a4        ;; 0e:74be ????????
    db   $a3, $a1, $a3, $e5, $00, $a4, $a3, $a4        ;; 0e:74c6 ????????
    db   $a6, $e5, $40, $a8, $a6, $a4, $a6, $e5        ;; 0e:74ce ????????
    db   $80, $a8, $a6, $a8, $a9, $e0, $31, $7a        ;; 0e:74d6 ????????
    db   $0b, $0e, $dc, $e0, $6d, $7a, $a6, $a4        ;; 0e:74de ????????
    db   $a6, $a8, $a9, $a8, $a9, $ab, $ad, $ab        ;; 0e:74e6 ????????
    db   $ad, $d8, $a2, $a4, $a6, $a8, $a9, $e7        ;; 0e:74ee ????????
    db   $78, $a8, $a6, $a8, $a9, $e7, $6e, $e5        ;; 0e:74f6 ????????
    db   $40, $ab, $a9, $a8, $a6, $e7, $64, $e5        ;; 0e:74fe ????????
    db   $00, $a4, $a6, $e7, $50, $a4, $a2, $e7        ;; 0e:7506 ????????
    db   $44, $e5, $40, $a1, $a2, $a1, $dc, $ab        ;; 0e:750e ????????
    db   $e0, $31, $7a, $e5, $80, $e7, $4b, $5d        ;; 0e:7516 ????????
    db   $8b, $8d, $d8, $82, $81, $82, $86, $54        ;; 0e:751e ????????
    db   $86, $88, $86, $84, $82, $81, $22, $dc        ;; 0e:7526 ????????
    db   $59, $5b, $4d, $d8, $a2, $a1, $dc, $2b        ;; 0e:752e ????????
    db   $56, $5d, $5b, $8d, $d8, $82, $84, $81        ;; 0e:7536 ????????
    db   $82, $84, $56, $51, $dc, $2b, $56, $58        ;; 0e:753e ????????
    db   $19, $e0, $6d, $7a, $e5, $40, $e7, $55        ;; 0e:7546 ????????
    db   $b7, $b9, $bb, $d8, $b0, $b2, $b3, $e0        ;; 0e:754e ????????
    db   $6b, $7a, $e5, $80, $24, $8e, $82, $84        ;; 0e:7556 ????????
    db   $85, $27, $8e, $89, $84, $87, $25, $8e        ;; 0e:755e ????????
    db   $84, $85, $87, $25, $8e, $82, $84, $85        ;; 0e:7566 ????????
    db   $54, $dc, $4b, $d8, $82, $80, $dc, $8b        ;; 0e:756e ????????
    db   $5c, $d8, $54, $52, $dc, $89, $8b, $2c        ;; 0e:7576 ????????
    db   $8e, $8b, $8c, $d8, $84, $12, $50, $00        ;; 0e:757e ????????
    db   $0e, $ff, $e4, $fe, $79, $e0, $71, $7a        ;; 0e:7586 ????????
    db   $e5, $80, $e6, $03, $d1, $0f, $0f, $0f        ;; 0e:758e ????????
    db   $0f, $8f, $8b, $d8, $84, $86, $48, $89        ;; 0e:7596 ????????
    db   $5b, $d8, $53, $51, $dc, $5b, $8f, $81        ;; 0e:759e ????????
    db   $86, $88, $89, $8b, $5d, $1b, $89, $88        ;; 0e:75a6 ????????
    db   $89, $8b, $89, $88, $29, $88, $89, $88        ;; 0e:75ae ????????
    db   $86, $28, $84, $86, $88, $89, $26, $56        ;; 0e:75b6 ????????
    db   $88, $86, $25, $e0, $31, $7a, $e5, $40        ;; 0e:75be ????????
    db   $86, $84, $86, $88, $89, $87, $89, $87        ;; 0e:75c6 ????????
    db   $09, $dc, $e0, $5b, $7a, $e5, $00, $5b        ;; 0e:75ce ????????
    db   $9b, $99, $9b, $5d, $9d, $9b, $9d, $d8        ;; 0e:75d6 ????????
    db   $52, $92, $91, $92, $93, $94, $96, $94        ;; 0e:75de ????????
    db   $93, $91, $dc, $5b, $9b, $99, $9b, $5d        ;; 0e:75e6 ????????
    db   $9d, $9b, $9d, $d8, $52, $92, $91, $92        ;; 0e:75ee ????????
    db   $e5, $80, $a3, $a4, $a6, $a8, $e6, $02        ;; 0e:75f6 ????????
    db   $b9, $bb, $e6, $03, $bd, $d8, $b3, $e6        ;; 0e:75fe ????????
    db   $01, $b4, $b6, $e0, $4b, $7a, $e5, $00        ;; 0e:7606 ????????
    db   $e6, $03, $dc, $93, $93, $93, $93, $dc        ;; 0e:760e ????????
    db   $9b, $d8, $93, $94, $94, $94, $94, $91        ;; 0e:7616 ????????
    db   $94, $e0, $5b, $7a, $06, $dc, $e3, $02        ;; 0e:761e ????????
    db   $3b, $98, $99, $8b, $d8, $83, $84, $86        ;; 0e:7626 ????????
    db   $dc, $5b, $d8, $23, $56, $36, $96, $98        ;; 0e:762e ????????
    db   $89, $86, $84, $82, $eb, $01, $5c, $76        ;; 0e:7636 ????????
    db   $92, $94, $92, $21, $54, $37, $94, $96        ;; 0e:763e ????????
    db   $87, $8c, $8b, $89, $22, $dc, $2b, $2c        ;; 0e:7646 ????????
    db   $8e, $d8, $84, $82, $80, $dc, $5b, $59        ;; 0e:764e ????????
    db   $5b, $89, $8b, $e2, $26, $76, $92, $94        ;; 0e:7656 ????????
    db   $92, $51, $ae, $a3, $a1, $a3, $a4, $a3        ;; 0e:765e ????????
    db   $a1, $a3, $46, $a9, $a8, $26, $24, $26        ;; 0e:7666 ????????
    db   $dc, $3b, $9d, $9b, $49, $86, $58, $d8        ;; 0e:766e ????????
    db   $e0, $31, $7a, $e6, $02, $54, $53, $52        ;; 0e:7676 ????????
    db   $e0, $6f, $7a, $54, $e6, $01, $59, $e6        ;; 0e:767e ????????
    db   $03, $2d, $e0, $5b, $7a, $8f, $ab, $a9        ;; 0e:7686 ????????
    db   $8b, $d8, $81, $e6, $02, $a3, $a4, $a3        ;; 0e:768e ????????
    db   $a1, $dc, $e6, $01, $ab, $ad, $ab, $a9        ;; 0e:7696 ????????
    db   $e0, $6f, $7a, $53, $e6, $02, $58, $e6        ;; 0e:769e ????????
    db   $03, $2b, $e0, $5b, $7a, $8f, $d8, $a1        ;; 0e:76a6 ????????
    db   $dc, $ab, $88, $8b, $e6, $01, $ad, $d8        ;; 0e:76ae ????????
    db   $a3, $a1, $dc, $ab, $e6, $02, $a9, $ab        ;; 0e:76b6 ????????
    db   $a9, $a8, $8f, $81, $83, $81, $e6, $01        ;; 0e:76be ????????
    db   $8f, $83, $84, $83, $e6, $03, $84, $a3        ;; 0e:76c6 ????????
    db   $a4, $86, $a4, $a6, $88, $a6, $a8, $89        ;; 0e:76ce ????????
    db   $a8, $a9, $4b, $a8, $a9, $8b, $d8, $83        ;; 0e:76d6 ????????
    db   $84, $86, $43, $a3, $a1, $50, $81, $80        ;; 0e:76de ????????
    db   $dc, $e6, $02, $8f, $84, $86, $a3, $a4        ;; 0e:76e6 ????????
    db   $e6, $01, $8f, $86, $88, $a4, $a6, $e5        ;; 0e:76ee ????????
    db   $40, $e6, $03, $a8, $a6, $a4, $a6, $e5        ;; 0e:76f6 ????????
    db   $00, $a8, $a6, $a8, $a9, $e5, $40, $ab        ;; 0e:76fe ????????
    db   $a9, $a8, $a9, $e5, $80, $ab, $a9, $ab        ;; 0e:7706 ????????
    db   $ad, $e5, $00, $a7, $a9, $a7, $a6, $e6        ;; 0e:770e ????????
    db   $01, $a7, $a9, $a7, $a6, $e6, $03, $a7        ;; 0e:7716 ????????
    db   $a9, $a7, $a6, $e6, $02, $a7, $a9, $a7        ;; 0e:771e ????????
    db   $a6, $e6, $03, $a4, $a6, $a7, $a6, $e6        ;; 0e:7726 ????????
    db   $01, $a7, $a9, $ab, $a9, $e6, $03, $a7        ;; 0e:772e ????????
    db   $a9, $a7, $a6, $e6, $02, $a4, $a6, $a7        ;; 0e:7736 ????????
    db   $a6, $e5, $80, $e6, $03, $a2, $a1, $a2        ;; 0e:773e ????????
    db   $a4, $a6, $a4, $a6, $a8, $a9, $a8, $a9        ;; 0e:7746 ????????
    db   $ab, $ad, $d8, $a2, $a4, $a6, $a4, $a2        ;; 0e:774e ????????
    db   $a4, $a6, $e5, $40, $a8, $a6, $a4, $a2        ;; 0e:7756 ????????
    db   $e5, $00, $a1, $a2, $a1, $dc, $ab, $e5        ;; 0e:775e ????????
    db   $40, $a9, $ab, $a9, $a8, $e0, $59, $7a        ;; 0e:7766 ????????
    db   $e5, $00, $e6, $03, $8f, $84, $86, $84        ;; 0e:776e ????????
    db   $56, $59, $8f, $88, $89, $8b, $2a, $8f        ;; 0e:7776 ????????
    db   $86, $88, $86, $22, $8f, $84, $86, $84        ;; 0e:777e ????????
    db   $88, $86, $84, $82, $52, $59, $88, $86        ;; 0e:7786 ????????
    db   $84, $86, $58, $5b, $2a, $8f, $82, $84        ;; 0e:778e ????????
    db   $86, $52, $54, $42, $a1, $dc, $ab, $5d        ;; 0e:7796 ????????
    db   $e0, $71, $7a, $e6, $02, $bb, $d8, $b0        ;; 0e:779e ????????
    db   $e6, $03, $b2, $b4, $e6, $01, $b5, $b6        ;; 0e:77a6 ????????
    db   $e6, $03, $17, $87, $89, $5a, $d8, $52        ;; 0e:77ae ????????
    db   $81, $84, $dc, $87, $8d, $29, $8e, $87        ;; 0e:77b6 ????????
    db   $89, $8b, $89, $8c, $8b, $89, $5b, $8c        ;; 0e:77be ????????
    db   $d8, $82, $dc, $58, $42, $88, $86, $84        ;; 0e:77c6 ????????
    db   $24, $59, $56, $84, $82, $84, $85, $27        ;; 0e:77ce ????????
    db   $8b, $89, $87, $89, $57, $55, $24, $8e        ;; 0e:77d6 ????????
    db   $85, $84, $82, $04, $ff, $e4, $fe, $79        ;; 0e:77de ????????
    db   $e8, $85, $7a, $e0, $40, $e6, $03, $d2        ;; 0e:77e6 ????????
    db   $04, $09, $04, $29, $2b, $14, $8e, $86        ;; 0e:77ee ????????
    db   $08, $06, $51, $58, $2d, $d8, $02, $11        ;; 0e:77f6 ????????
    db   $dc, $5b, $29, $28, $2d, $8e, $8b, $89        ;; 0e:77fe ????????
    db   $88, $46, $88, $49, $8b, $1c, $cb, $c9        ;; 0e:7806 ????????
    db   $c8, $c6, $c4, $c3, $c1, $c0, $dc, $e6        ;; 0e:780e ????????
    db   $02, $8b, $8f, $e6, $03, $bb, $bf, $bb        ;; 0e:7816 ????????
    db   $bf, $bb, $bf, $e6, $01, $8b, $8f, $e6        ;; 0e:781e ????????
    db   $03, $bb, $bf, $bb, $bf, $bb, $bf, $e6        ;; 0e:7826 ????????
    db   $02, $8b, $8f, $e6, $03, $bb, $bf, $bb        ;; 0e:782e ????????
    db   $bf, $bb, $bf, $e6, $01, $9b, $9e, $9f        ;; 0e:7836 ????????
    db   $d8, $e6, $03, $96, $9f, $96, $dc, $e6        ;; 0e:783e ????????
    db   $02, $8b, $8f, $e6, $03, $bb, $bf, $bb        ;; 0e:7846 ????????
    db   $bf, $bb, $bf, $e6, $01, $8b, $8f, $e6        ;; 0e:784e ????????
    db   $03, $bb, $bf, $bb, $bf, $bb, $bf, $e6        ;; 0e:7856 ????????
    db   $02, $8b, $8f, $e6, $03, $bb, $bf, $bb        ;; 0e:785e ????????
    db   $bf, $bb, $bf, $8b, $4f, $d8, $2b, $29        ;; 0e:7866 ????????
    db   $8b, $8f, $89, $8f, $88, $8f, $86, $8f        ;; 0e:786e ????????
    db   $e3, $02, $e6, $02, $84, $8f, $e6, $01        ;; 0e:7876 ????????
    db   $84, $8f, $e6, $02, $84, $8f, $e6, $01        ;; 0e:787e ????????
    db   $84, $8f, $e6, $02, $83, $8f, $e6, $01        ;; 0e:7886 ????????
    db   $83, $8f, $e6, $02, $83, $8f, $e6, $01        ;; 0e:788e ????????
    db   $83, $8f, $e6, $02, $82, $8f, $e6, $01        ;; 0e:7896 ????????
    db   $82, $8f, $e6, $02, $82, $8f, $e6, $01        ;; 0e:789e ????????
    db   $82, $8f, $dc, $eb, $01, $f8, $78, $e6        ;; 0e:78a6 ????????
    db   $02, $89, $8f, $e6, $01, $89, $8f, $e6        ;; 0e:78ae ????????
    db   $02, $89, $8f, $e6, $01, $89, $8f, $e6        ;; 0e:78b6 ????????
    db   $02, $8c, $8f, $e6, $01, $8c, $8f, $e6        ;; 0e:78be ????????
    db   $02, $8c, $8f, $e6, $01, $8c, $8f, $e6        ;; 0e:78c6 ????????
    db   $02, $87, $8f, $e6, $01, $87, $8f, $e6        ;; 0e:78ce ????????
    db   $02, $87, $8f, $e6, $01, $87, $8f, $e6        ;; 0e:78d6 ????????
    db   $02, $8c, $8f, $e6, $01, $8c, $8f, $e6        ;; 0e:78de ????????
    db   $02, $8c, $8f, $e6, $01, $8c, $8f, $e6        ;; 0e:78e6 ????????
    db   $03, $2b, $8e, $8f, $8d, $d8, $83, $e2        ;; 0e:78ee ????????
    db   $78, $78, $e6, $02, $89, $8f, $e6, $01        ;; 0e:78f6 ????????
    db   $89, $8f, $e6, $02, $89, $8f, $e6, $01        ;; 0e:78fe ????????
    db   $89, $8f, $d8, $e6, $03, $2b, $29, $28        ;; 0e:7906 ????????
    db   $29, $e6, $02, $84, $8f, $e6, $01, $84        ;; 0e:790e ????????
    db   $8f, $dc, $e6, $02, $8b, $8f, $e6, $01        ;; 0e:7916 ????????
    db   $8b, $8f, $e6, $03, $d8, $84, $8f, $e6        ;; 0e:791e ????????
    db   $01, $54, $56, $58, $e6, $03, $09, $8b        ;; 0e:7926 ????????
    db   $8f, $1f, $08, $8d, $4f, $2b, $dc, $a6        ;; 0e:792e ????????
    db   $af, $a6, $7f, $86, $a8, $af, $a8, $7f        ;; 0e:7936 ????????
    db   $88, $e6, $02, $59, $e6, $01, $5b, $e6        ;; 0e:793e ????????
    db   $02, $5d, $d8, $e6, $01, $53, $e6, $02        ;; 0e:7946 ????????
    db   $54, $e6, $01, $5b, $d8, $e6, $03, $24        ;; 0e:794e ????????
    db   $dc, $e6, $02, $5b, $e6, $01, $59, $e6        ;; 0e:7956 ????????
    db   $03, $28, $dc, $a9, $af, $a9, $7f, $a9        ;; 0e:795e ????????
    db   $af, $ab, $af, $ab, $7f, $ab, $af, $d8        ;; 0e:7966 ????????
    db   $11, $5f, $a0, $af, $a0, $7f, $a0, $af        ;; 0e:796e ????????
    db   $a0, $af, $a0, $7f, $a0, $af, $a0, $af        ;; 0e:7976 ????????
    db   $a0, $7f, $a0, $af, $a0, $af, $a0, $7f        ;; 0e:797e ????????
    db   $a0, $af, $02, $e6, $02, $54, $d8, $e6        ;; 0e:7986 ????????
    db   $01, $52, $e6, $02, $51, $dc, $e6, $01        ;; 0e:798e ????????
    db   $5b, $e6, $03, $29, $2b, $2d, $26, $2b        ;; 0e:7996 ????????
    db   $54, $58, $29, $24, $22, $24, $4d, $88        ;; 0e:799e ????????
    db   $26, $dc, $2b, $d8, $24, $59, $54, $dc        ;; 0e:79a6 ????????
    db   $59, $57, $7c, $af, $7c, $af, $7b, $af        ;; 0e:79ae ????????
    db   $7b, $af, $7a, $af, $7a, $af, $79, $af        ;; 0e:79b6 ????????
    db   $79, $af, $d8, $72, $af, $72, $af, $71        ;; 0e:79be ????????
    db   $af, $71, $af, $70, $af, $70, $af, $57        ;; 0e:79c6 ????????
    db   $89, $8b, $54, $48, $8b, $89, $88, $59        ;; 0e:79ce ????????
    db   $57, $26, $77, $af, $77, $af, $77, $af        ;; 0e:79d6 ????????
    db   $77, $af, $dc, $77, $af, $77, $af, $77        ;; 0e:79de ????????
    db   $af, $77, $af, $d8, $70, $af, $70, $af        ;; 0e:79e6 ????????
    db   $80, $e6, $02, $89, $e6, $03, $87, $e6        ;; 0e:79ee ????????
    db   $01, $85, $e6, $03, $20, $5e, $5f, $ff        ;; 0e:79f6 ????????
    db   $0a, $00, $01, $01, $01, $02, $01, $01        ;; 0e:79fe .w.w.w.w
    db   $01, $00, $00, $00, $7a, $02, $00, $02        ;; 0e:7a06 .w...???
    db   $0a, $00, $0b, $7a, $04, $00, $01, $02        ;; 0e:7a0e ????????
    db   $01, $ff, $00, $14, $7a, $05, $00, $02        ;; 0e:7a16 ????????
    db   $01, $02, $00, $00, $1d, $7a, $0a, $00        ;; 0e:7a1e ????????
    db   $01, $02, $01, $04, $01, $02, $01, $00        ;; 0e:7a26 ????????
    db   $00, $26, $7a, $0a, $8c, $63, $f7, $ff        ;; 0e:7a2e ???....?
    db   $08, $8c, $63, $c7, $ff, $63, $c2, $63        ;; 0e:7a36 ????????
    db   $10, $63, $b2, $63, $10, $63, $a2, $63        ;; 0e:7a3e ?..??..?
    db   $10, $05, $92, $63, $10, $05, $82, $63        ;; 0e:7a46 ????????
    db   $10, $63, $62, $63, $10, $63, $c4, $63        ;; 0e:7a4e ?????...
    db   $b4, $63, $a4, $63, $94, $63, $84, $63        ;; 0e:7a56 ...??..?
    db   $74, $63, $64, $63, $54, $63, $44, $63        ;; 0e:7a5e ?.......
    db   $34, $63, $24, $63, $c7, $63, $b7, $63        ;; 0e:7a66 ........
    db   $a7, $63, $97, $63, $87, $63, $67, $ff        ;; 0e:7a6e .??????.
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00        ;; 0e:7a76 ........
    db   $00, $00, $00, $00, $00, $00, $00, $ff        ;; 0e:7a7e .......?
    db   $ff, $ff, $ff, $00, $00, $00, $00, $00        ;; 0e:7a86 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $bb        ;; 0e:7a8e ????????
    db   $bb, $bb, $bb, $bb, $bb, $bb, $bb, $00        ;; 0e:7a96 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $bb        ;; 0e:7a9e ???????.
    db   $bb, $bb, $bb, $00, $00, $00, $00, $00        ;; 0e:7aa6 ........
    db   $00, $00, $00, $00, $00, $00, $00, $ff        ;; 0e:7aae .......?
    db   $cc, $99, $66, $99, $cc, $ff, $00, $00        ;; 0e:7ab6 ????????
    db   $00, $00, $00, $00, $00, $00, $00             ;; 0e:7abe ???????

data_0e_7ac5:
    db   $aa, $7b, $d9, $7b, $f5, $7b, $a9, $7b        ;; 0e:7ac5 ????????
    db   $0d, $7c, $a9, $7b, $a9, $7b, $2c, $7c        ;; 0e:7acd ????????
    db   $39, $7c, $52, $7c, $65, $7c, $a9, $7b        ;; 0e:7ad5 ????????
    db   $7f, $7c, $97, $7c, $9e, $7c, $a9, $7b        ;; 0e:7add ????????
    db   $c8, $7c, $a9, $7b, $ee, $7c, $a9, $7b        ;; 0e:7ae5 ????..??
    db   $06, $7d, $a9, $7b, $a9, $7b, $a9, $7b        ;; 0e:7aed ??..????
    db   $47, $7d, $76, $7d, $a9, $7b, $c6, $7d        ;; 0e:7af5 ????????
    db   $da, $7d, $fd, $7d, $16, $7e, $32, $7e        ;; 0e:7afd ??????..
    db   $46, $7e, $69, $7e, $76, $7e, $84, $7e        ;; 0e:7b05 ??..????
    db   $98, $7e, $a9, $7b, $b0, $7e, $a9, $7b        ;; 0e:7b0d ??..??..
    db   $a9, $7b, $e8, $7e, $ef, $7e, $03, $7f        ;; 0e:7b15 ..??????
    db   $11, $7f, $30, $7f, $a9, $7b, $51, $7f        ;; 0e:7b1d ????????
    db   $6a, $7f, $77, $7f, $90, $7f, $97, $7f        ;; 0e:7b25 ????..??
    db   $a9, $7b, $a9, $7b, $bf, $7f, $a9, $7b        ;; 0e:7b2d ????....
    db   $e2, $7f                                      ;; 0e:7b35 ??

data_0e_7b37:
    db   $c9, $7b, $ea, $7b, $a9, $7b, $fc, $7b        ;; 0e:7b37 ????????
    db   $14, $7c, $18, $7c, $22, $7c, $a9, $7b        ;; 0e:7b3f ????????
    db   $44, $7c, $5d, $7c, $a9, $7b, $78, $7c        ;; 0e:7b47 ????????
    db   $90, $7c, $a9, $7b, $a9, $7b, $b7, $7c        ;; 0e:7b4f ????????
    db   $d9, $7c, $e4, $7c, $a9, $7b, $ff, $7c        ;; 0e:7b57 ????..??
    db   $a9, $7b, $0d, $7d, $11, $7d, $31, $7d        ;; 0e:7b5f ??..????
    db   $66, $7d, $8d, $7d, $9b, $7d, $d3, $7d        ;; 0e:7b67 ????????
    db   $f3, $7d, $a9, $7b, $27, $7e, $3f, $7e        ;; 0e:7b6f ??????..
    db   $5f, $7e, $a9, $7b, $7d, $7e, $91, $7e        ;; 0e:7b77 ??..????
    db   $9f, $7e, $a6, $7e, $c3, $7e, $d3, $7e        ;; 0e:7b7f ??..??..
    db   $dd, $7e, $a9, $7b, $fc, $7e, $0a, $7f        ;; 0e:7b87 ..??????
    db   $22, $7f, $43, $7f, $4d, $7f, $a9, $7b        ;; 0e:7b8f ????????
    db   $a9, $7b, $a9, $7b, $a9, $7b, $a4, $7f        ;; 0e:7b97 ????..??
    db   $ae, $7f, $b8, $7f, $a9, $7b, $cc, $7f        ;; 0e:7b9f ????....
    db   $a9, $7b, $00, $05, $44, $00, $f3, $ff        ;; 0e:7ba7 ??.?????
    db   $85, $29, $2f, $80, $f0, $ff, $87, $04        ;; 0e:7baf ????????
    db   $00, $00, $f0, $00, $80, $09, $2b, $80        ;; 0e:7bb7 ????????
    db   $f3, $ff, $86, $39, $2b, $00, $f3, $ff        ;; 0e:7bbf ????????
    db   $86, $00, $07, $da, $42, $21, $f3, $7b        ;; 0e:7bc7 ????????
    db   $04, $ca, $61, $09, $fc, $7c, $39, $f5        ;; 0e:7bcf ????????
    db   $35, $00, $f8, $02, $2a, $80, $f3, $ff        ;; 0e:7bd7 ????????
    db   $85, $01, $2f, $80, $f0, $ff, $87, $ef        ;; 0e:7bdf ????????
    db   $da, $7b, $00, $f8, $02, $f1, $42, $01        ;; 0e:7be7 ????????
    db   $a0, $00, $ef, $eb, $7b, $00, $0f, $27        ;; 0e:7bef ????????
    db   $80, $f7, $ee, $86, $00, $f2, $06, $89        ;; 0e:7bf7 ????????
    db   $12, $06, $39, $36, $06, $89, $62, $06        ;; 0e:7bff ????????
    db   $29, $26, $ef, $fd, $7b, $00, $60, $27        ;; 0e:7c07 ????????
    db   $00, $ff, $00, $82, $00, $60, $58, $41        ;; 0e:7c0f ????????
    db   $00, $03, $f1, $6c, $01, $32, $11, $27        ;; 0e:7c17 ????????
    db   $f2, $32, $00, $02, $ca, $6a, $08, $fc        ;; 0e:7c1f ????????
    db   $7c, $30, $a7, $35, $00, $02, $00, $40        ;; 0e:7c27 ????????
    db   $fa, $a0, $87, $10, $00, $00, $a2, $e0        ;; 0e:7c2f ????????
    db   $87, $00, $f3, $23, $4d, $00, $d1, $00        ;; 0e:7c37 ????????
    db   $85, $ef, $3a, $7c, $00, $f3, $13, $91        ;; 0e:7c3f ????????
    db   $2b, $08, $91, $2a, $08, $91, $2a, $ef        ;; 0e:7c47 ????????
    db   $45, $7c, $00, $f6, $21, $75, $80, $f8        ;; 0e:7c4f ????????
    db   $ff, $80, $ef, $53, $7c, $00, $f6, $21        ;; 0e:7c57 ????????
    db   $f1, $5d, $ef, $5e, $7c, $00, $16, $57        ;; 0e:7c5f ????????
    db   $80, $f7, $f7, $86, $16, $47, $80, $94        ;; 0e:7c67 ????????
    db   $f7, $86, $16, $37, $80, $55, $f7, $86        ;; 0e:7c6f ????????
    db   $00, $1a, $f4, $37, $20, $f7, $10, $00        ;; 0e:7c77 ????????
    db   $f4, $05, $2f, $80, $f8, $ff, $87, $04        ;; 0e:7c7f ????????
    db   $3f, $80, $f8, $ff, $87, $ef, $80, $7c        ;; 0e:7c87 ????????
    db   $00, $05, $f8, $08, $22, $f3, $17, $00        ;; 0e:7c8f ????????
    db   $1a, $37, $80, $fd, $50, $87, $00, $17        ;; 0e:7c97 ????????
    db   $37, $80, $ff, $20, $86, $17, $37, $80        ;; 0e:7c9f ????????
    db   $cf, $50, $86, $17, $37, $40, $9f, $80        ;; 0e:7ca7 ????????
    db   $86, $17, $37, $00, $6f, $b0, $86, $00        ;; 0e:7caf ????????
    db   $f3, $03, $8f, $12, $05, $89, $31, $03        ;; 0e:7cb7 ????????
    db   $8f, $24, $05, $89, $31, $ef, $b8, $7c        ;; 0e:7cbf ????????
    db   $00, $f4, $05, $4d, $80, $f1, $ff, $87        ;; 0e:7cc7 ????????
    db   $08, $00, $80, $91, $ff, $86, $ef, $c9        ;; 0e:7ccf ????????
    db   $7c, $00, $f4, $05, $91, $13, $08, $f7        ;; 0e:7cd7 ????????
    db   $09, $ef, $da, $7c, $00, $04, $c1, $4b        ;; 0e:7cdf ????????
    db   $01, $01, $34, $04, $a1, $34, $00, $f6        ;; 0e:7ce7 ???????.
    db   $01, $00, $40, $f0, $00, $86, $01, $00        ;; 0e:7cef ........
    db   $80, $f0, $00, $87, $ef, $ef, $7c, $00        ;; 0e:7cf7 ........
    db   $40, $2f, $32, $40, $f5, $32, $00, $17        ;; 0e:7cff ????????
    db   $7c, $80, $f3, $aa, $86, $00, $20, $f2        ;; 0e:7d07 ??????..
    db   $80, $00, $03, $f1, $31, $08, $05, $22        ;; 0e:7d0f ..??????
    db   $04, $a1, $01, $04, $d1, $11, $04, $f1        ;; 0e:7d17 ????????
    db   $31, $f3, $02, $f1, $31, $08, $01, $44        ;; 0e:7d1f ????????
    db   $02, $f1, $31, $08, $01, $44, $ef, $21        ;; 0e:7d27 ????????
    db   $7d, $00, $03, $f1, $30, $01, $01, $33        ;; 0e:7d2f ????????
    db   $05, $f2, $33, $03, $81, $32, $03, $f1        ;; 0e:7d37 ????????
    db   $30, $01, $01, $43, $17, $f2, $33, $00        ;; 0e:7d3f ????????
    db   $04, $08, $00, $f9, $aa, $85, $13, $23        ;; 0e:7d47 ????????
    db   $80, $f2, $aa, $82, $13, $23, $40, $c2        ;; 0e:7d4f ????????
    db   $aa, $82, $13, $23, $00, $82, $aa, $82        ;; 0e:7d57 ????????
    db   $13, $23, $80, $53, $aa, $82, $00, $04        ;; 0e:7d5f ????????
    db   $f1, $35, $13, $f2, $3b, $13, $c3, $3b        ;; 0e:7d67 ????????
    db   $13, $84, $3b, $13, $55, $3b, $00, $f2        ;; 0e:7d6f ????????
    db   $04, $2a, $80, $f1, $aa, $85, $01, $22        ;; 0e:7d77 ????????
    db   $80, $02, $aa, $82, $0a, $23, $40, $f2        ;; 0e:7d7f ????????
    db   $aa, $82, $ef, $77, $7d, $00, $f2, $04        ;; 0e:7d87 ????????
    db   $f1, $3d, $01, $f2, $33, $0a, $f1, $43        ;; 0e:7d8f ????????
    db   $ef, $8e, $7d, $00, $06, $19, $25, $03        ;; 0e:7d97 ????????
    db   $09, $25, $06, $49, $25, $03, $09, $25        ;; 0e:7d9f ????????
    db   $06, $79, $25, $03, $09, $25, $06, $a9        ;; 0e:7da7 ????????
    db   $25, $03, $09, $25, $06, $79, $25, $03        ;; 0e:7daf ????????
    db   $09, $25, $06, $49, $25, $03, $09, $25        ;; 0e:7db7 ????????
    db   $06, $19, $25, $03, $09, $25, $00, $03        ;; 0e:7dbf ????????
    db   $68, $00, $f0, $ca, $84, $20, $46, $00        ;; 0e:7dc7 ????????
    db   $0a, $ca, $84, $00, $03, $f1, $34, $20        ;; 0e:7dcf ????????
    db   $0a, $33, $00, $0a, $15, $00, $f0, $ca        ;; 0e:7dd7 ????????
    db   $84, $0a, $15, $00, $c0, $ca, $84, $0a        ;; 0e:7ddf ????????
    db   $15, $00, $90, $ca, $84, $0a, $15, $00        ;; 0e:7de7 ????????
    db   $60, $ca, $84, $00, $0c, $09, $35, $01        ;; 0e:7def ????????
    db   $03, $33, $21, $f3, $34, $00, $10, $26        ;; 0e:7df7 ????????
    db   $c0, $f4, $20, $83, $10, $26, $80, $f4        ;; 0e:7dff ????????
    db   $50, $85, $10, $26, $40, $f4, $80, $84        ;; 0e:7e07 ????????
    db   $17, $26, $00, $f7, $b0, $85, $00, $f4        ;; 0e:7e0f ????????
    db   $05, $13, $80, $f4, $20, $82, $05, $13        ;; 0e:7e17 ????????
    db   $00, $f4, $50, $82, $ef, $17, $7e, $00        ;; 0e:7e1f ????????
    db   $f4, $05, $f1, $28, $05, $f1, $38, $ef        ;; 0e:7e27 ????????
    db   $28, $7e, $00, $06, $13, $00, $f1, $5a        ;; 0e:7e2f ???.....
    db   $84, $09, $15, $40, $d1, $ff, $85, $00        ;; 0e:7e37 ........
    db   $03, $9a, $4e, $07, $f3, $24, $00, $20        ;; 0e:7e3f .......?
    db   $47, $40, $b7, $20, $85, $20, $37, $40        ;; 0e:7e47 ????????
    db   $c5, $2a, $85, $20, $27, $40, $d5, $30        ;; 0e:7e4f ????????
    db   $85, $20, $36, $40, $f7, $3a, $85, $00        ;; 0e:7e57 ????????
    db   $90, $00, $00, $0e, $ff, $14, $25, $f0        ;; 0e:7e5f ????????
    db   $62, $00, $02, $47, $80, $61, $0e, $87        ;; 0e:7e67 ??......
    db   $03, $44, $80, $f1, $0e, $87, $00, $03        ;; 0e:7e6f .......?
    db   $1e, $c0, $f7, $99, $87, $00, $04, $82        ;; 0e:7e77 ????????
    db   $07, $02, $91, $02, $00, $03, $15, $c0        ;; 0e:7e7f ????????
    db   $e7, $99, $87, $05, $26, $40, $b0, $0e        ;; 0e:7e87 ????????
    db   $87, $00, $04, $72, $07, $08, $f1, $32        ;; 0e:7e8f ????????
    db   $00, $1e, $08, $40, $f6, $89, $87, $00        ;; 0e:7e97 ????????
    db   $02, $81, $1f, $1c, $ff, $42, $00, $05        ;; 0e:7e9f ???????.
    db   $f2, $65, $01, $07, $53, $32, $f7, $54        ;; 0e:7ea7 ........
    db   $00, $03, $00, $40, $91, $00, $80, $02        ;; 0e:7eaf .???????
    db   $00, $00, $00, $00, $80, $47, $5b, $40        ;; 0e:7eb7 ????????
    db   $97, $00, $80, $00, $03, $f4, $6e, $03        ;; 0e:7ebf ????????
    db   $f4, $7c, $02, $f4, $6e, $08, $f4, $7c        ;; 0e:7ec7 ????????
    db   $40, $f7, $65, $00, $06, $fa, $5e, $02        ;; 0e:7ecf ????....
    db   $fc, $6f, $37, $f4, $62, $00, $f2, $06        ;; 0e:7ed7 ........
    db   $f8, $5c, $07, $f1, $27, $ef, $de, $7e        ;; 0e:7edf ........
    db   $00, $17, $67, $80, $f2, $20, $87, $00        ;; 0e:7ee7 .???????
    db   $06, $43, $00, $f1, $5a, $84, $04, $25        ;; 0e:7eef ????????
    db   $00, $f0, $96, $86, $00, $06, $99, $4d        ;; 0e:7ef7 ????????
    db   $06, $a3, $34, $00, $0a, $34, $40, $d0        ;; 0e:7eff ????????
    db   $96, $86, $00, $06, $a9, $52, $02, $f0        ;; 0e:7f07 ????????
    db   $34, $00, $f2, $09, $4a, $80, $b0, $ff        ;; 0e:7f0f ????????
    db   $83, $05, $4a, $80, $00, $ff, $83, $ef        ;; 0e:7f17 ????????
    db   $12, $7f, $00, $f2, $05, $f1, $37, $02        ;; 0e:7f1f ????????
    db   $f1, $6c, $07, $f1, $65, $ef, $23, $7f        ;; 0e:7f27 ????????
    db   $00, $04, $00, $00, $c2, $da, $87, $06        ;; 0e:7f2f ????????
    db   $00, $00, $c2, $d0, $87, $12, $00, $00        ;; 0e:7f37 ????????
    db   $c2, $cc, $87, $00, $04, $f2, $08, $06        ;; 0e:7f3f ????????
    db   $f2, $08, $12, $f2, $08, $00, $40, $f4        ;; 0e:7f47 ????????
    db   $4b, $00, $08, $7f, $80, $f0, $d0, $87        ;; 0e:7f4f ????????
    db   $08, $7f, $80, $d1, $d0, $87, $08, $7f        ;; 0e:7f57 ????????
    db   $80, $b1, $c0, $87, $08, $7f, $80, $92        ;; 0e:7f5f ????????
    db   $ba, $87, $00, $0c, $2f, $80, $d0, $00        ;; 0e:7f67 ????????
    db   $87, $11, $2f, $80, $a0, $75, $86, $00        ;; 0e:7f6f ????????
    db   $07, $0f, $80, $f1, $ff, $86, $07, $0f        ;; 0e:7f77 ????????
    db   $80, $d1, $e8, $86, $07, $07, $80, $b1        ;; 0e:7f7f ????????
    db   $da, $86, $07, $07, $80, $91, $c6, $86        ;; 0e:7f87 ????????
    db   $00, $1a, $37, $80, $fd, $50, $87, $00        ;; 0e:7f8f ?.......
    db   $06, $71, $00, $a7, $80, $83, $20, $17        ;; 0e:7f97 ????????
    db   $80, $c6, $ff, $84, $00, $1f, $8f, $5f        ;; 0e:7f9f ????????
    db   $0c, $c4, $54, $35, $f4, $37, $00, $0a        ;; 0e:7fa7 ????????
    db   $f7, $31, $20, $f7, $11, $0f, $f2, $08        ;; 0e:7faf ????????
    db   $00, $02, $fc, $5c, $0c, $f4, $57, $00        ;; 0e:7fb7 ????????
    db   $06, $00, $80, $a1, $ad, $87, $0f, $00        ;; 0e:7fbf ........
    db   $80, $f1, $31, $87, $00, $02, $f1, $27        ;; 0e:7fc7 ........
    db   $08, $04, $54, $02, $b1, $27, $08, $04        ;; 0e:7fcf ........
    db   $54, $02, $81, $27, $08, $04, $54, $02        ;; 0e:7fd7 ........
    db   $51, $27, $00, $50, $77, $80, $0d, $ff        ;; 0e:7fdf ...?????
    db   $85                                           ;; 0e:7fe7 ?
