;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank0d", ROMX[$4000], BANK[$0d]

call_0d_4000:
    ld   HL, wCF00                                     ;; 0d:4000 $21 $00 $cf
    ld   B, $e0                                        ;; 0d:4003 $06 $e0
    xor  A, A                                          ;; 0d:4005 $af
.jr_0d_4006:
    ld   [HL+], A                                      ;; 0d:4006 $22
    dec  B                                             ;; 0d:4007 $05
    jr   NZ, .jr_0d_4006                               ;; 0d:4008 $20 $fc
    ld   A, [wCFEA]                                    ;; 0d:400a $fa $ea $cf
    ld   [wD844], A                                    ;; 0d:400d $ea $44 $d8
    ld   H, $d0                                        ;; 0d:4010 $26 $d0
    ld   B, $08                                        ;; 0d:4012 $06 $08
    xor  A, A                                          ;; 0d:4014 $af
.jr_0d_4015:
    ld   L, $00                                        ;; 0d:4015 $2e $00
    ld   [HL+], A                                      ;; 0d:4017 $22
    ld   [HL], A                                       ;; 0d:4018 $77
    inc  H                                             ;; 0d:4019 $24
    dec  B                                             ;; 0d:401a $05
    jr   NZ, .jr_0d_4015                               ;; 0d:401b $20 $f8
    ld   H, $d5                                        ;; 0d:401d $26 $d5
    ld   DE, wCFE0                                     ;; 0d:401f $11 $e0 $cf
    ld   B, $03                                        ;; 0d:4022 $06 $03
.jr_0d_4024:
    ld   A, [DE]                                       ;; 0d:4024 $1a
    or   A, A                                          ;; 0d:4025 $b7
    jr   Z, .jr_0d_4033                                ;; 0d:4026 $28 $0b
    ld   L, $00                                        ;; 0d:4028 $2e $00
    ld   [HL+], A                                      ;; 0d:402a $22
    ld   [HL], A                                       ;; 0d:402b $77
    inc  DE                                            ;; 0d:402c $13
    ld   A, [DE]                                       ;; 0d:402d $1a
    dec  DE                                            ;; 0d:402e $1b
    ld   L, $0a                                        ;; 0d:402f $2e $0a
    ld   [HL], A                                       ;; 0d:4031 $77
    inc  H                                             ;; 0d:4032 $24
.jr_0d_4033:
    inc  DE                                            ;; 0d:4033 $13
    inc  DE                                            ;; 0d:4034 $13
    dec  B                                             ;; 0d:4035 $05
    jr   NZ, .jr_0d_4024                               ;; 0d:4036 $20 $ec
    ld   D, $d5                                        ;; 0d:4038 $16 $d5
    ld   B, $03                                        ;; 0d:403a $06 $03
.jr_0d_403c:
    push BC                                            ;; 0d:403c $c5
    push DE                                            ;; 0d:403d $d5
    ld   E, $00                                        ;; 0d:403e $1e $00
    ld   A, [DE]                                       ;; 0d:4040 $1a
    or   A, A                                          ;; 0d:4041 $b7
    jr   Z, .jr_0d_4047                                ;; 0d:4042 $28 $03
    call call_0d_44f4                                  ;; 0d:4044 $cd $f4 $44
.jr_0d_4047:
    pop  DE                                            ;; 0d:4047 $d1
    inc  D                                             ;; 0d:4048 $14
    pop  BC                                            ;; 0d:4049 $c1
    push BC                                            ;; 0d:404a $c5
    ld   A, $03                                        ;; 0d:404b $3e $03
    sub  A, B                                          ;; 0d:404d $90
    add  A, $49                                        ;; 0d:404e $c6 $49
    ld   C, A                                          ;; 0d:4050 $4f
    ld   B, $d8                                        ;; 0d:4051 $06 $d8
    ld   A, [wDE10]                                    ;; 0d:4053 $fa $10 $de
    ld   [BC], A                                       ;; 0d:4056 $02
    pop  BC                                            ;; 0d:4057 $c1
    dec  B                                             ;; 0d:4058 $05
    jr   NZ, .jr_0d_403c                               ;; 0d:4059 $20 $e1
    xor  A, A                                          ;; 0d:405b $af
    ld   D, $d0                                        ;; 0d:405c $16 $d0
    ld   B, $05                                        ;; 0d:405e $06 $05
.jr_0d_4060:
    push BC                                            ;; 0d:4060 $c5
    push AF                                            ;; 0d:4061 $f5
    ld   HL, wC200                                     ;; 0d:4062 $21 $00 $c2
    call call_00_1918                                  ;; 0d:4065 $cd $18 $19
    push DE                                            ;; 0d:4068 $d5
    call call_0d_449a                                  ;; 0d:4069 $cd $9a $44
    pop  DE                                            ;; 0d:406c $d1
    inc  D                                             ;; 0d:406d $14
    pop  AF                                            ;; 0d:406e $f1
    inc  A                                             ;; 0d:406f $3c
    pop  BC                                            ;; 0d:4070 $c1
    dec  B                                             ;; 0d:4071 $05
    jr   NZ, .jr_0d_4060                               ;; 0d:4072 $20 $ec
    call call_00_0198                                  ;; 0d:4074 $cd $98 $01
    jr   NZ, .jr_0d_407f                               ;; 0d:4077 $20 $06
    ld   HL, wD400                                     ;; 0d:4079 $21 $00 $d4
    xor  A, A                                          ;; 0d:407c $af
    ld   [HL+], A                                      ;; 0d:407d $22
    ld   [HL], A                                       ;; 0d:407e $77
.jr_0d_407f:
    ld   BC, wD500                                     ;; 0d:407f $01 $00 $d5
    ld   A, $03                                        ;; 0d:4082 $3e $03
.jr_0d_4084:
    push AF                                            ;; 0d:4084 $f5
    push BC                                            ;; 0d:4085 $c5
    call call_0d_443a                                  ;; 0d:4086 $cd $3a $44
    pop  BC                                            ;; 0d:4089 $c1
    inc  B                                             ;; 0d:408a $04
    pop  AF                                            ;; 0d:408b $f1
    dec  A                                             ;; 0d:408c $3d
    jr   NZ, .jr_0d_4084                               ;; 0d:408d $20 $f5
    ld   HL, wC2DA                                     ;; 0d:408f $21 $da $c2
    ld   B, $0e                                        ;; 0d:4092 $06 $0e
    ld   C, $00                                        ;; 0d:4094 $0e $00
.jr_0d_4096:
    push BC                                            ;; 0d:4096 $c5
    ld   A, [HL]                                       ;; 0d:4097 $7e
    and  A, $f0                                        ;; 0d:4098 $e6 $f0
    jr   Z, .jr_0d_40ae                                ;; 0d:409a $28 $12
    push HL                                            ;; 0d:409c $e5
    inc  HL                                            ;; 0d:409d $23
    ld   E, [HL]                                       ;; 0d:409e $5e
    swap A                                             ;; 0d:409f $cb $37
    dec  A                                             ;; 0d:40a1 $3d
    add  A, $d0                                        ;; 0d:40a2 $c6 $d0
    ld   H, A                                          ;; 0d:40a4 $67
    ld   L, $2a                                        ;; 0d:40a5 $2e $2a
    ld   [HL], C                                       ;; 0d:40a7 $71
    inc  L                                             ;; 0d:40a8 $2c
    ld   [HL], $01                                     ;; 0d:40a9 $36 $01
    inc  L                                             ;; 0d:40ab $2c
    ld   [HL], E                                       ;; 0d:40ac $73
    pop  HL                                            ;; 0d:40ad $e1
.jr_0d_40ae:
    inc  HL                                            ;; 0d:40ae $23
    inc  HL                                            ;; 0d:40af $23
    pop  BC                                            ;; 0d:40b0 $c1
    inc  C                                             ;; 0d:40b1 $0c
    dec  B                                             ;; 0d:40b2 $05
    jr   NZ, .jr_0d_4096                               ;; 0d:40b3 $20 $e1
    ld   HL, wD012                                     ;; 0d:40b5 $21 $12 $d0
    ld   A, $08                                        ;; 0d:40b8 $3e $08
.jr_0d_40ba:
    push AF                                            ;; 0d:40ba $f5
    push HL                                            ;; 0d:40bb $e5
    call call_0d_43fa                                  ;; 0d:40bc $cd $fa $43
    pop  HL                                            ;; 0d:40bf $e1
    inc  H                                             ;; 0d:40c0 $24
    pop  AF                                            ;; 0d:40c1 $f1
    dec  A                                             ;; 0d:40c2 $3d
    jr   NZ, .jr_0d_40ba                               ;; 0d:40c3 $20 $f5
    ld   HL, wD84D                                     ;; 0d:40c5 $21 $4d $d8
    ld   B, $08                                        ;; 0d:40c8 $06 $08
.jr_0d_40ca:
    ld   A, $ff                                        ;; 0d:40ca $3e $ff
    ld   [HL+], A                                      ;; 0d:40cc $22
    xor  A, A                                          ;; 0d:40cd $af
    ld   [HL+], A                                      ;; 0d:40ce $22
    dec  B                                             ;; 0d:40cf $05
    jr   NZ, .jr_0d_40ca                               ;; 0d:40d0 $20 $f8
    ld   A, [wCFE9]                                    ;; 0d:40d2 $fa $e9 $cf
    cp   A, $03                                        ;; 0d:40d5 $fe $03
    jr   Z, .jr_0d_40dd                                ;; 0d:40d7 $28 $04
    add  A, $11                                        ;; 0d:40d9 $c6 $11
    ldh  [hFFB0], A                                    ;; 0d:40db $e0 $b0
.jr_0d_40dd:
    call call_00_01d4                                  ;; 0d:40dd $cd $d4 $01
    ld   A, $00                                        ;; 0d:40e0 $3e $00
    call call_0d_4361                                  ;; 0d:40e2 $cd $61 $43
    xor  A, A                                          ;; 0d:40e5 $af
    ld   [wD848], A                                    ;; 0d:40e6 $ea $48 $d8

jp_0d_40e9:
    call call_00_01d7                                  ;; 0d:40e9 $cd $d7 $01
    ld   A, [wD848]                                    ;; 0d:40ec $fa $48 $d8
    inc  A                                             ;; 0d:40ef $3c
    ld   [wD848], A                                    ;; 0d:40f0 $ea $48 $d8
    ld   HL, wD803                                     ;; 0d:40f3 $21 $03 $d8
    ld   B, $41                                        ;; 0d:40f6 $06 $41
    ld   A, $ff                                        ;; 0d:40f8 $3e $ff
.jr_0d_40fa:
    ld   [HL+], A                                      ;; 0d:40fa $22
    dec  B                                             ;; 0d:40fb $05
    jr   NZ, .jr_0d_40fa                               ;; 0d:40fc $20 $fc
    xor  A, A                                          ;; 0d:40fe $af
    ld   [wD802], A                                    ;; 0d:40ff $ea $02 $d8
    ld   HL, wD000                                     ;; 0d:4102 $21 $00 $d0
    ld   C, $08                                        ;; 0d:4105 $0e $08
.jr_0d_4107:
    ld   A, [HL]                                       ;; 0d:4107 $7e
    or   A, A                                          ;; 0d:4108 $b7
    jr   Z, .jr_0d_411a                                ;; 0d:4109 $28 $0f
    ld   B, A                                          ;; 0d:410b $47
    ld   L, $43                                        ;; 0d:410c $2e $43
.jr_0d_410e:
    ld   [HL], $ff                                     ;; 0d:410e $36 $ff
    inc  L                                             ;; 0d:4110 $2c
    ld   [HL], $00                                     ;; 0d:4111 $36 $00
    ld   A, L                                          ;; 0d:4113 $7d
    add  A, $07                                        ;; 0d:4114 $c6 $07
    ld   L, A                                          ;; 0d:4116 $6f
    dec  B                                             ;; 0d:4117 $05
    jr   NZ, .jr_0d_410e                               ;; 0d:4118 $20 $f4
.jr_0d_411a:
    inc  H                                             ;; 0d:411a $24
    ld   L, $00                                        ;; 0d:411b $2e $00
    dec  C                                             ;; 0d:411d $0d
    jr   NZ, .jr_0d_4107                               ;; 0d:411e $20 $e7
    call call_0d_4579                                  ;; 0d:4120 $cd $79 $45
    ld   A, [wD800]                                    ;; 0d:4123 $fa $00 $d8
    cp   A, $02                                        ;; 0d:4126 $fe $02
    jr   Z, jr_0d_4167                                 ;; 0d:4128 $28 $3d
    call call_00_01da                                  ;; 0d:412a $cd $da $01
    ld_long_load A, hFF8C                              ;; 0d:412d $fa $8c $ff
    cp   A, $ff                                        ;; 0d:4130 $fe $ff
    jr   NZ, jr_0d_4167                                ;; 0d:4132 $20 $33
    ld   A, $01                                        ;; 0d:4134 $3e $01
    call call_0d_4361                                  ;; 0d:4136 $cd $61 $43
    ld   A, [wD801]                                    ;; 0d:4139 $fa $01 $d8
    or   A, A                                          ;; 0d:413c $b7
    jr   Z, jr_0d_4164                                 ;; 0d:413d $28 $25
    ld   A, $38                                        ;; 0d:413f $3e $38
    ldh  [hFFB2], A                                    ;; 0d:4141 $e0 $b2
    call call_0d_4152                                  ;; 0d:4143 $cd $52 $41
    call call_0d_437e                                  ;; 0d:4146 $cd $7e $43
    call call_00_1915                                  ;; 0d:4149 $cd $15 $19
    ld   A, [wC31A]                                    ;; 0d:414c $fa $1a $c3
    ldh  [hFFB0], A                                    ;; 0d:414f $e0 $b0
    ret                                                ;; 0d:4151 $c9

call_0d_4152:
    ld_long_load A, hFF89                              ;; 0d:4152 $fa $89 $ff
    ld   B, A                                          ;; 0d:4155 $47
.jr_0d_4156:
    rst  waitForVBlank                                 ;; 0d:4156 $d7
    ld_long_load A, hFF89                              ;; 0d:4157 $fa $89 $ff
    cp   A, B                                          ;; 0d:415a $b8
    jr   Z, .jr_0d_4156                                ;; 0d:415b $28 $f9
    or   A, A                                          ;; 0d:415d $b7
    jr   Z, call_0d_4152                               ;; 0d:415e $28 $f2
    call call_00_01f2                                  ;; 0d:4160 $cd $f2 $01
    ret                                                ;; 0d:4163 $c9

jr_0d_4164:
    call call_0d_4579                                  ;; 0d:4164 $cd $79 $45

jr_0d_4167:
    ld   A, [wD800]                                    ;; 0d:4167 $fa $00 $d8
    dec  A                                             ;; 0d:416a $3d
    jr   Z, .jr_0d_4172                                ;; 0d:416b $28 $05
    ld   A, $02                                        ;; 0d:416d $3e $02
    call call_0d_4361                                  ;; 0d:416f $cd $61 $43
.jr_0d_4172:
    xor  A, A                                          ;; 0d:4172 $af
    ld   [wD800], A                                    ;; 0d:4173 $ea $00 $d8
    ld   A, $03                                        ;; 0d:4176 $3e $03
    call call_0d_4361                                  ;; 0d:4178 $cd $61 $43
    ld   HL, wD803                                     ;; 0d:417b $21 $03 $d8
.jp_0d_417e:
    push HL                                            ;; 0d:417e $e5
    ld   A, [HL+]                                      ;; 0d:417f $2a
    cp   A, $ff                                        ;; 0d:4180 $fe $ff
    jr   NZ, .jr_0d_4188                               ;; 0d:4182 $20 $04
    pop  HL                                            ;; 0d:4184 $e1
    jp   .jp_0d_4217                                   ;; 0d:4185 $c3 $17 $42
.jr_0d_4188:
    add  A, A                                          ;; 0d:4188 $87
    add  A, A                                          ;; 0d:4189 $87
    add  A, A                                          ;; 0d:418a $87
    add  A, $40                                        ;; 0d:418b $c6 $40
    ld   C, A                                          ;; 0d:418d $4f
    ld   A, [HL+]                                      ;; 0d:418e $2a
    ld   L, A                                          ;; 0d:418f $6f
    add  A, $d0                                        ;; 0d:4190 $c6 $d0
    ld   D, A                                          ;; 0d:4192 $57
    ld   E, $01                                        ;; 0d:4193 $1e $01
    ld   A, L                                          ;; 0d:4195 $7d
    add  A, A                                          ;; 0d:4196 $87
    add  A, $4d                                        ;; 0d:4197 $c6 $4d
    ld   L, A                                          ;; 0d:4199 $6f
    ld   H, $d8                                        ;; 0d:419a $26 $d8
    ld   A, [DE]                                       ;; 0d:419c $1a
    or   A, A                                          ;; 0d:419d $b7
    jr   Z, .jr_0d_4207                                ;; 0d:419e $28 $67
    ld   E, C                                          ;; 0d:41a0 $59
    ld   A, [DE]                                       ;; 0d:41a1 $1a
    ld   C, A                                          ;; 0d:41a2 $4f
    and  A, $90                                        ;; 0d:41a3 $e6 $90
    jr   NZ, .jr_0d_4207                               ;; 0d:41a5 $20 $60
    bit  3, C                                          ;; 0d:41a7 $cb $59
    jr   Z, .jr_0d_41b4                                ;; 0d:41a9 $28 $09
    push DE                                            ;; 0d:41ab $d5
    push HL                                            ;; 0d:41ac $e5
    ld   A, $04                                        ;; 0d:41ad $3e $04
    call call_0d_4361                                  ;; 0d:41af $cd $61 $43
    pop  HL                                            ;; 0d:41b2 $e1
    pop  DE                                            ;; 0d:41b3 $d1
.jr_0d_41b4:
    push DE                                            ;; 0d:41b4 $d5
    push HL                                            ;; 0d:41b5 $e5
    ld   A, $05                                        ;; 0d:41b6 $3e $05
    call call_0d_4361                                  ;; 0d:41b8 $cd $61 $43
    pop  HL                                            ;; 0d:41bb $e1
    pop  DE                                            ;; 0d:41bc $d1
    inc  E                                             ;; 0d:41bd $1c
    inc  E                                             ;; 0d:41be $1c
    inc  E                                             ;; 0d:41bf $1c
    ld   A, [DE]                                       ;; 0d:41c0 $1a
    ld   [HL+], A                                      ;; 0d:41c1 $22
    ld   C, A                                          ;; 0d:41c2 $4f
    inc  E                                             ;; 0d:41c3 $1c
    ld   A, [DE]                                       ;; 0d:41c4 $1a
    ld   [HL], A                                       ;; 0d:41c5 $77
    ld   H, A                                          ;; 0d:41c6 $67
    ld   L, C                                          ;; 0d:41c7 $69
    ld   A, C                                          ;; 0d:41c8 $79
    cp   A, $ff                                        ;; 0d:41c9 $fe $ff
    jr   Z, .jr_0d_41f1                                ;; 0d:41cb $28 $24
    cp   A, $0e                                        ;; 0d:41cd $fe $0e
    jr   Z, .jr_0d_41d9                                ;; 0d:41cf $28 $08
    cp   A, $0f                                        ;; 0d:41d1 $fe $0f
    jr   NZ, .jr_0d_41dd                               ;; 0d:41d3 $20 $08
    ld   A, H                                          ;; 0d:41d5 $7c
    or   A, A                                          ;; 0d:41d6 $b7
    jr   Z, .jr_0d_41dd                                ;; 0d:41d7 $28 $04
.jr_0d_41d9:
    ld   A, H                                          ;; 0d:41d9 $7c
    dec  A                                             ;; 0d:41da $3d
    jr   Z, .jr_0d_41f1                                ;; 0d:41db $28 $14
.jr_0d_41dd:
    inc  E                                             ;; 0d:41dd $1c
    inc  E                                             ;; 0d:41de $1c
    ld   A, [DE]                                       ;; 0d:41df $1a
    cp   A, $ff                                        ;; 0d:41e0 $fe $ff
    jr   Z, .jr_0d_41f1                                ;; 0d:41e2 $28 $0d
    ld   E, A                                          ;; 0d:41e4 $5f
    add  A, A                                          ;; 0d:41e5 $87
    add  A, E                                          ;; 0d:41e6 $83
    add  A, $14                                        ;; 0d:41e7 $c6 $14
    ld   E, A                                          ;; 0d:41e9 $5f
    ld   A, [DE]                                       ;; 0d:41ea $1a
    cp   A, $fe                                        ;; 0d:41eb $fe $fe
    jr   Z, .jr_0d_41f1                                ;; 0d:41ed $28 $02
    dec  A                                             ;; 0d:41ef $3d
    ld   [DE], A                                       ;; 0d:41f0 $12
.jr_0d_41f1:
    call call_00_01e3                                  ;; 0d:41f1 $cd $e3 $01
    ld   HL, wD001                                     ;; 0d:41f4 $21 $01 $d0
    ld   B, $05                                        ;; 0d:41f7 $06 $05
    call call_0d_435a                                  ;; 0d:41f9 $cd $5a $43
    or   A, A                                          ;; 0d:41fc $b7
    jr   Z, .jr_0d_4250                                ;; 0d:41fd $28 $51
    ld   B, $03                                        ;; 0d:41ff $06 $03
    call call_0d_435a                                  ;; 0d:4201 $cd $5a $43
    or   A, A                                          ;; 0d:4204 $b7
    jr   Z, .jr_0d_4273                                ;; 0d:4205 $28 $6c
.jr_0d_4207:
    pop  HL                                            ;; 0d:4207 $e1
    inc  HL                                            ;; 0d:4208 $23
    inc  HL                                            ;; 0d:4209 $23
    ld   A, [wD802]                                    ;; 0d:420a $fa $02 $d8
    inc  A                                             ;; 0d:420d $3c
    ld   [wD802], A                                    ;; 0d:420e $ea $02 $d8
    ld   A, [HL]                                       ;; 0d:4211 $7e
    cp   A, $ff                                        ;; 0d:4212 $fe $ff
    jp   NZ, .jp_0d_417e                               ;; 0d:4214 $c2 $7e $41
.jp_0d_4217:
    ld   HL, wD001                                     ;; 0d:4217 $21 $01 $d0
    ld   B, $05                                        ;; 0d:421a $06 $05
    call call_0d_435a                                  ;; 0d:421c $cd $5a $43
    or   A, A                                          ;; 0d:421f $b7
    jr   Z, .jr_0d_4251                                ;; 0d:4220 $28 $2f
    ld   B, $03                                        ;; 0d:4222 $06 $03
    call call_0d_435a                                  ;; 0d:4224 $cd $5a $43
    or   A, A                                          ;; 0d:4227 $b7
    jr   Z, .jr_0d_4274                                ;; 0d:4228 $28 $4a
    ld   A, $06                                        ;; 0d:422a $3e $06
    call call_0d_4361                                  ;; 0d:422c $cd $61 $43
    call call_00_01e3                                  ;; 0d:422f $cd $e3 $01
    ld   HL, wD001                                     ;; 0d:4232 $21 $01 $d0
    ld   B, $05                                        ;; 0d:4235 $06 $05
    call call_0d_435a                                  ;; 0d:4237 $cd $5a $43
    or   A, A                                          ;; 0d:423a $b7
    jr   Z, .jr_0d_4251                                ;; 0d:423b $28 $14
    ld   B, $03                                        ;; 0d:423d $06 $03
    call call_0d_435a                                  ;; 0d:423f $cd $5a $43
    or   A, A                                          ;; 0d:4242 $b7
    jr   Z, .jr_0d_4274                                ;; 0d:4243 $28 $2f
    ld   A, $07                                        ;; 0d:4245 $3e $07
    call call_0d_4361                                  ;; 0d:4247 $cd $61 $43
    ld   HL, wD803                                     ;; 0d:424a $21 $03 $d8
    jp   jp_0d_40e9                                    ;; 0d:424d $c3 $e9 $40
.jr_0d_4250:
    pop  HL                                            ;; 0d:4250 $e1
.jr_0d_4251:
    ld   A, $59                                        ;; 0d:4251 $3e $59
    ld   [wD90C], A                                    ;; 0d:4253 $ea $0c $d9
    rst  rst_00_0020                                   ;; 0d:4256 $e7
    call call_0d_4152                                  ;; 0d:4257 $cd $52 $41
    xor  A, A                                          ;; 0d:425a $af
    ldh  [rBGP], A                                     ;; 0d:425b $e0 $47
    ldh  [rOBP0], A                                    ;; 0d:425d $e0 $48
    ldh  [rOBP1], A                                    ;; 0d:425f $e0 $49
    ld   A, $01                                        ;; 0d:4261 $3e $01
    ld   [wD85E], A                                    ;; 0d:4263 $ea $5e $d8
    ld   [wC763], A                                    ;; 0d:4266 $ea $63 $c7
    ld   A, $02                                        ;; 0d:4269 $3e $02
    ld_long_store hFFC0, A                             ;; 0d:426b $ea $c0 $ff
    ld   A, $07                                        ;; 0d:426e $3e $07
    ldh  [hFFB0], A                                    ;; 0d:4270 $e0 $b0
    ret                                                ;; 0d:4272 $c9
.jr_0d_4273:
    pop  HL                                            ;; 0d:4273 $e1
.jr_0d_4274:
    ld   A, [wD50A]                                    ;; 0d:4274 $fa $0a $d5
    inc  A                                             ;; 0d:4277 $3c
    jr   Z, .jr_0d_427e                                ;; 0d:4278 $28 $04
    ld   A, $03                                        ;; 0d:427a $3e $03
    ldh  [hFFB0], A                                    ;; 0d:427c $e0 $b0
.jr_0d_427e:
    xor  A, A                                          ;; 0d:427e $af
    ld   [wD85E], A                                    ;; 0d:427f $ea $5e $d8
    ld   A, $5a                                        ;; 0d:4282 $3e $5a
    ld   [wD90C], A                                    ;; 0d:4284 $ea $0c $d9
    rst  rst_00_0020                                   ;; 0d:4287 $e7
    call call_0d_437e                                  ;; 0d:4288 $cd $7e $43
    ld   A, [wD50A]                                    ;; 0d:428b $fa $0a $d5
    inc  A                                             ;; 0d:428e $3c
    jp   Z, .jp_0d_434e                                ;; 0d:428f $ca $4e $43
    ld   A, $08                                        ;; 0d:4292 $3e $08
    call call_0d_4361                                  ;; 0d:4294 $cd $61 $43
    ld   A, [wD845]                                    ;; 0d:4297 $fa $45 $d8
    or   A, A                                          ;; 0d:429a $b7
    jp   Z, .jp_0d_4349                                ;; 0d:429b $ca $49 $43
    call call_00_01dd                                  ;; 0d:429e $cd $dd $01
    ld_long_load A, hFF8C                              ;; 0d:42a1 $fa $8c $ff
    cp   A, $ff                                        ;; 0d:42a4 $fe $ff
    jp   Z, .jp_0d_4349                                ;; 0d:42a6 $ca $49 $43
    ld   [wD84C], A                                    ;; 0d:42a9 $ea $4c $d8
    ld   HL, wC204                                     ;; 0d:42ac $21 $04 $c2
    call call_00_1918                                  ;; 0d:42af $cd $18 $19
    push HL                                            ;; 0d:42b2 $e5
    ld   A, $09                                        ;; 0d:42b3 $3e $09
    call call_0d_4361                                  ;; 0d:42b5 $cd $61 $43
    pop  HL                                            ;; 0d:42b8 $e1
    ld   A, [wD846]                                    ;; 0d:42b9 $fa $46 $d8
    or   A, A                                          ;; 0d:42bc $b7
    jp   Z, .jp_0d_4349                                ;; 0d:42bd $ca $49 $43
    ld   A, [wD847]                                    ;; 0d:42c0 $fa $47 $d8
    ld   [HL+], A                                      ;; 0d:42c3 $22
    push HL                                            ;; 0d:42c4 $e5
    ld   L, A                                          ;; 0d:42c5 $6f
    ld   H, $00                                        ;; 0d:42c6 $26 $00
    add  HL, HL                                        ;; 0d:42c8 $29
    ld   E, L                                          ;; 0d:42c9 $5d
    ld   D, H                                          ;; 0d:42ca $54
    add  HL, HL                                        ;; 0d:42cb $29
    add  HL, HL                                        ;; 0d:42cc $29
    add  HL, DE                                        ;; 0d:42cd $19
    ld   DE, data_0d_6f80                              ;; 0d:42ce $11 $80 $6f
    add  HL, DE                                        ;; 0d:42d1 $19
    ld   A, $0d                                        ;; 0d:42d2 $3e $0d
    call call_00_00d2                                  ;; 0d:42d4 $cd $d2 $00
    ld   B, A                                          ;; 0d:42d7 $47
    swap A                                             ;; 0d:42d8 $cb $37
    and  A, $0f                                        ;; 0d:42da $e6 $0f
    pop  DE                                            ;; 0d:42dc $d1
    ld   [DE], A                                       ;; 0d:42dd $12
    inc  E                                             ;; 0d:42de $1c
    inc  E                                             ;; 0d:42df $1c
    inc  HL                                            ;; 0d:42e0 $23
    inc  HL                                            ;; 0d:42e1 $23
    ld   A, $0d                                        ;; 0d:42e2 $3e $0d
    call call_00_00d2                                  ;; 0d:42e4 $cd $d2 $00
    ld   [DE], A                                       ;; 0d:42e7 $12
    ld   C, A                                          ;; 0d:42e8 $4f
    inc  E                                             ;; 0d:42e9 $1c
    inc  HL                                            ;; 0d:42ea $23
    ld   A, $0d                                        ;; 0d:42eb $3e $0d
    call call_00_00d2                                  ;; 0d:42ed $cd $d2 $00
    ld   [DE], A                                       ;; 0d:42f0 $12
    inc  E                                             ;; 0d:42f1 $1c
    inc  E                                             ;; 0d:42f2 $1c
    ld   [DE], A                                       ;; 0d:42f3 $12
    dec  E                                             ;; 0d:42f4 $1d
    ld   A, C                                          ;; 0d:42f5 $79
    ld   [DE], A                                       ;; 0d:42f6 $12
    inc  E                                             ;; 0d:42f7 $1c
    inc  E                                             ;; 0d:42f8 $1c
    inc  HL                                            ;; 0d:42f9 $23
    ld   C, $04                                        ;; 0d:42fa $0e $04
.jr_0d_42fc:
    ld   A, $0d                                        ;; 0d:42fc $3e $0d
    call call_00_00d2                                  ;; 0d:42fe $cd $d2 $00
    ld   [DE], A                                       ;; 0d:4301 $12
    inc  E                                             ;; 0d:4302 $1c
    inc  HL                                            ;; 0d:4303 $23
    dec  C                                             ;; 0d:4304 $0d
    jr   NZ, .jr_0d_42fc                               ;; 0d:4305 $20 $f5
    ld   A, $0d                                        ;; 0d:4307 $3e $0d
    call call_00_00d2                                  ;; 0d:4309 $cd $d2 $00
    ld   C, A                                          ;; 0d:430c $4f
    inc  HL                                            ;; 0d:430d $23
    ld   A, $0d                                        ;; 0d:430e $3e $0d
    call call_00_00d2                                  ;; 0d:4310 $cd $d2 $00
    ld   H, A                                          ;; 0d:4313 $67
    ld   L, C                                          ;; 0d:4314 $69
    push DE                                            ;; 0d:4315 $d5
    ld   C, $10                                        ;; 0d:4316 $0e $10
    ld   A, $ff                                        ;; 0d:4318 $3e $ff
.jr_0d_431a:
    ld   [DE], A                                       ;; 0d:431a $12
    inc  DE                                            ;; 0d:431b $13
    dec  C                                             ;; 0d:431c $0d
    jr   NZ, .jr_0d_431a                               ;; 0d:431d $20 $fb
    pop  DE                                            ;; 0d:431f $d1
    ld   A, B                                          ;; 0d:4320 $78
    and  A, $0f                                        ;; 0d:4321 $e6 $0f
    inc  A                                             ;; 0d:4323 $3c
    ld   B, A                                          ;; 0d:4324 $47
    push BC                                            ;; 0d:4325 $c5
    push DE                                            ;; 0d:4326 $d5
.jr_0d_4327:
    ld   A, $0d                                        ;; 0d:4327 $3e $0d
    call call_00_00d2                                  ;; 0d:4329 $cd $d2 $00
    ld   [DE], A                                       ;; 0d:432c $12
    inc  E                                             ;; 0d:432d $1c
    inc  E                                             ;; 0d:432e $1c
    inc  HL                                            ;; 0d:432f $23
    dec  B                                             ;; 0d:4330 $05
    jr   NZ, .jr_0d_4327                               ;; 0d:4331 $20 $f4
    pop  DE                                            ;; 0d:4333 $d1
    pop  BC                                            ;; 0d:4334 $c1
.jr_0d_4335:
    ld   A, [DE]                                       ;; 0d:4335 $1a
    add  A, $80                                        ;; 0d:4336 $c6 $80
    ld   L, A                                          ;; 0d:4338 $6f
    ld   A, $7e                                        ;; 0d:4339 $3e $7e
    adc  A, $00                                        ;; 0d:433b $ce $00
    ld   H, A                                          ;; 0d:433d $67
    inc  E                                             ;; 0d:433e $1c
    ld   A, $0c                                        ;; 0d:433f $3e $0c
    call call_00_00d2                                  ;; 0d:4341 $cd $d2 $00
    ld   [DE], A                                       ;; 0d:4344 $12
    inc  E                                             ;; 0d:4345 $1c
    dec  B                                             ;; 0d:4346 $05
    jr   NZ, .jr_0d_4335                               ;; 0d:4347 $20 $ec
.jp_0d_4349:
    ld   A, $0a                                        ;; 0d:4349 $3e $0a
    call call_0d_4361                                  ;; 0d:434b $cd $61 $43
.jp_0d_434e:
    call call_0d_4152                                  ;; 0d:434e $cd $52 $41
    call call_00_1915                                  ;; 0d:4351 $cd $15 $19
    ld   A, [wC31A]                                    ;; 0d:4354 $fa $1a $c3
    ldh  [hFFB0], A                                    ;; 0d:4357 $e0 $b0
    ret                                                ;; 0d:4359 $c9

call_0d_435a:
    xor  A, A                                          ;; 0d:435a $af
.jr_0d_435b:
    add  A, [HL]                                       ;; 0d:435b $86
    inc  H                                             ;; 0d:435c $24
    dec  B                                             ;; 0d:435d $05
    jr   NZ, .jr_0d_435b                               ;; 0d:435e $20 $fb
    ret                                                ;; 0d:4360 $c9

call_0d_4361:
    add  A, A                                          ;; 0d:4361 $87
    add  A, $80                                        ;; 0d:4362 $c6 $80
    ld   L, A                                          ;; 0d:4364 $6f
    ld   A, $46                                        ;; 0d:4365 $3e $46
    adc  A, $00                                        ;; 0d:4367 $ce $00
    ld   H, A                                          ;; 0d:4369 $67
    ld   A, $0c                                        ;; 0d:436a $3e $0c
    call call_00_00d2                                  ;; 0d:436c $cd $d2 $00
    ld   E, A                                          ;; 0d:436f $5f
    inc  HL                                            ;; 0d:4370 $23
    ld   A, $0c                                        ;; 0d:4371 $3e $0c
    call call_00_00d2                                  ;; 0d:4373 $cd $d2 $00
    ld   D, A                                          ;; 0d:4376 $57
    farcall2 call_0c_4000                              ;; 0d:4377 $cd $7d $01 $00 $40 $0c
    ret                                                ;; 0d:437d $c9

call_0d_437e:
    xor  A, A                                          ;; 0d:437e $af
    ld   D, $d0                                        ;; 0d:437f $16 $d0
    ld   B, $05                                        ;; 0d:4381 $06 $05
.jr_0d_4383:
    push AF                                            ;; 0d:4383 $f5
    push BC                                            ;; 0d:4384 $c5
    push DE                                            ;; 0d:4385 $d5
    ld   HL, wC206                                     ;; 0d:4386 $21 $06 $c2
    call call_00_1918                                  ;; 0d:4389 $cd $18 $19
    ld   E, $40                                        ;; 0d:438c $1e $40
    ld   A, [DE]                                       ;; 0d:438e $1a
    and  A, $f0                                        ;; 0d:438f $e6 $f0
    ld   [HL], A                                       ;; 0d:4391 $77
    bit  7, A                                          ;; 0d:4392 $cb $7f
    jr   Z, .jr_0d_43a4                                ;; 0d:4394 $28 $0e
    and  A, $70                                        ;; 0d:4396 $e6 $70
    ld   [HL], A                                       ;; 0d:4398 $77
.jr_0d_4399:
    inc  E                                             ;; 0d:4399 $1c
    ld   A, $01                                        ;; 0d:439a $3e $01
    ld   [DE], A                                       ;; 0d:439c $12
    inc  E                                             ;; 0d:439d $1c
    dec  A                                             ;; 0d:439e $3d
    ld   [DE], A                                       ;; 0d:439f $12
    dec  E                                             ;; 0d:43a0 $1d
    dec  E                                             ;; 0d:43a1 $1d
    jr   .jr_0d_43ae                                   ;; 0d:43a2 $18 $0a
.jr_0d_43a4:
    inc  E                                             ;; 0d:43a4 $1c
    ld   A, [DE]                                       ;; 0d:43a5 $1a
    ld   B, A                                          ;; 0d:43a6 $47
    inc  E                                             ;; 0d:43a7 $1c
    ld   A, [DE]                                       ;; 0d:43a8 $1a
    dec  E                                             ;; 0d:43a9 $1d
    dec  E                                             ;; 0d:43aa $1d
    or   A, B                                          ;; 0d:43ab $b0
    jr   Z, .jr_0d_4399                                ;; 0d:43ac $28 $eb
.jr_0d_43ae:
    inc  L                                             ;; 0d:43ae $2c
    inc  DE                                            ;; 0d:43af $13
    ld   A, [DE]                                       ;; 0d:43b0 $1a
    ld   [HL+], A                                      ;; 0d:43b1 $22
    inc  DE                                            ;; 0d:43b2 $13
    ld   A, [DE]                                       ;; 0d:43b3 $1a
    ld   [HL+], A                                      ;; 0d:43b4 $22
    ld   E, $12                                        ;; 0d:43b5 $1e $12
    ld   A, L                                          ;; 0d:43b7 $7d
    add  A, $06                                        ;; 0d:43b8 $c6 $06
    ld   L, A                                          ;; 0d:43ba $6f
    ld   B, $08                                        ;; 0d:43bb $06 $08
.jr_0d_43bd:
    ld   A, [DE]                                       ;; 0d:43bd $1a
    ld   C, A                                          ;; 0d:43be $4f
    inc  DE                                            ;; 0d:43bf $13
    inc  DE                                            ;; 0d:43c0 $13
    ld   A, [DE]                                       ;; 0d:43c1 $1a
    or   A, A                                          ;; 0d:43c2 $b7
    jr   NZ, .jr_0d_43d7                               ;; 0d:43c3 $20 $12
    push DE                                            ;; 0d:43c5 $d5
    ld   E, $0b                                        ;; 0d:43c6 $1e $0b
    ld   A, [DE]                                       ;; 0d:43c8 $1a
    pop  DE                                            ;; 0d:43c9 $d1
    cp   A, $02                                        ;; 0d:43ca $fe $02
    jr   NC, .jr_0d_43d7                               ;; 0d:43cc $30 $09
    ld   A, C                                          ;; 0d:43ce $79
    cp   A, $80                                        ;; 0d:43cf $fe $80
    jr   NC, .jr_0d_43d7                               ;; 0d:43d1 $30 $04
    ld   C, $ff                                        ;; 0d:43d3 $0e $ff
    ld   A, C                                          ;; 0d:43d5 $79
    ld   [DE], A                                       ;; 0d:43d6 $12
.jr_0d_43d7:
    ld   A, C                                          ;; 0d:43d7 $79
    ld   [HL+], A                                      ;; 0d:43d8 $22
    ld   A, [DE]                                       ;; 0d:43d9 $1a
    ld   [HL+], A                                      ;; 0d:43da $22
    inc  DE                                            ;; 0d:43db $13
    dec  B                                             ;; 0d:43dc $05
    jr   NZ, .jr_0d_43bd                               ;; 0d:43dd $20 $de
    ld   A, [DE]                                       ;; 0d:43df $1a
    cp   A, $ff                                        ;; 0d:43e0 $fe $ff
    jr   Z, .jr_0d_43f1                                ;; 0d:43e2 $28 $0d
    add  A, A                                          ;; 0d:43e4 $87
    add  A, $db                                        ;; 0d:43e5 $c6 $db
    ld   L, A                                          ;; 0d:43e7 $6f
    ld   A, $c2                                        ;; 0d:43e8 $3e $c2
    adc  A, $00                                        ;; 0d:43ea $ce $00
    ld   H, A                                          ;; 0d:43ec $67
    inc  E                                             ;; 0d:43ed $1c
    inc  E                                             ;; 0d:43ee $1c
    ld   A, [DE]                                       ;; 0d:43ef $1a
    ld   [HL], A                                       ;; 0d:43f0 $77
.jr_0d_43f1:
    pop  DE                                            ;; 0d:43f1 $d1
    inc  D                                             ;; 0d:43f2 $14
    pop  BC                                            ;; 0d:43f3 $c1
    pop  AF                                            ;; 0d:43f4 $f1
    inc  A                                             ;; 0d:43f5 $3c
    dec  B                                             ;; 0d:43f6 $05
    jr   NZ, .jr_0d_4383                               ;; 0d:43f7 $20 $8a
    ret                                                ;; 0d:43f9 $c9

call_0d_43fa:
    ld   E, $2d                                        ;; 0d:43fa $1e $2d
    ld   D, H                                          ;; 0d:43fc $54
    xor  A, A                                          ;; 0d:43fd $af
    ld   [DE], A                                       ;; 0d:43fe $12
    inc  E                                             ;; 0d:43ff $1c
    ld   [DE], A                                       ;; 0d:4400 $12
    dec  E                                             ;; 0d:4401 $1d
    ld   B, $09                                        ;; 0d:4402 $06 $09
.jr_0d_4404:
    push BC                                            ;; 0d:4404 $c5
    ld   A, [HL+]                                      ;; 0d:4405 $2a
    cp   A, $ff                                        ;; 0d:4406 $fe $ff
    jr   Z, .jr_0d_4433                                ;; 0d:4408 $28 $29
    push HL                                            ;; 0d:440a $e5
    ld   H, [HL]                                       ;; 0d:440b $66
    ld   L, A                                          ;; 0d:440c $6f
    push DE                                            ;; 0d:440d $d5
    add  HL, HL                                        ;; 0d:440e $29
    add  HL, HL                                        ;; 0d:440f $29
    add  HL, HL                                        ;; 0d:4410 $29
    ld   DE, data_0d_6f82                              ;; 0d:4411 $11 $82 $6f
    add  HL, DE                                        ;; 0d:4414 $19
    ld   A, $0c                                        ;; 0d:4415 $3e $0c
    call call_00_00d2                                  ;; 0d:4417 $cd $d2 $00
    and  A, $30                                        ;; 0d:441a $e6 $30
    jr   Z, .jr_0d_4431                                ;; 0d:441c $28 $13
    pop  DE                                            ;; 0d:441e $d1
    push DE                                            ;; 0d:441f $d5
    cp   A, $10                                        ;; 0d:4420 $fe $10
    jr   Z, .jr_0d_4425                                ;; 0d:4422 $28 $01
    inc  DE                                            ;; 0d:4424 $13
.jr_0d_4425:
    inc  HL                                            ;; 0d:4425 $23
    inc  HL                                            ;; 0d:4426 $23
    inc  HL                                            ;; 0d:4427 $23
    ld   A, $0c                                        ;; 0d:4428 $3e $0c
    call call_00_00d2                                  ;; 0d:442a $cd $d2 $00
    ld   L, A                                          ;; 0d:442d $6f
    ld   A, [DE]                                       ;; 0d:442e $1a
    or   A, L                                          ;; 0d:442f $b5
    ld   [DE], A                                       ;; 0d:4430 $12
.jr_0d_4431:
    pop  DE                                            ;; 0d:4431 $d1
    pop  HL                                            ;; 0d:4432 $e1
.jr_0d_4433:
    inc  HL                                            ;; 0d:4433 $23
    inc  HL                                            ;; 0d:4434 $23
    pop  BC                                            ;; 0d:4435 $c1
    dec  B                                             ;; 0d:4436 $05
    jr   NZ, .jr_0d_4404                               ;; 0d:4437 $20 $cb
    ret                                                ;; 0d:4439 $c9

call_0d_443a:
    ld   A, [BC]                                       ;; 0d:443a $0a
    or   A, A                                          ;; 0d:443b $b7
    ret  Z                                             ;; 0d:443c $c8
    push AF                                            ;; 0d:443d $f5
    ld   C, $0c                                        ;; 0d:443e $0e $0c
    ld   A, [BC]                                       ;; 0d:4440 $0a
    ld   L, A                                          ;; 0d:4441 $6f
    inc  C                                             ;; 0d:4442 $0c
    ld   A, [BC]                                       ;; 0d:4443 $0a
    ld   H, A                                          ;; 0d:4444 $67
    ld   D, H                                          ;; 0d:4445 $54
    ld   E, L                                          ;; 0d:4446 $5d
    ld   C, $0a                                        ;; 0d:4447 $0e $0a
    ld   A, [BC]                                       ;; 0d:4449 $0a
    inc  A                                             ;; 0d:444a $3c
    jr   NZ, .jr_0d_4450                               ;; 0d:444b $20 $03
    ld   DE, $00                                       ;; 0d:444d $11 $00 $00
.jr_0d_4450:
    srl  D                                             ;; 0d:4450 $cb $3a
    rr   E                                             ;; 0d:4452 $cb $1b
    srl  D                                             ;; 0d:4454 $cb $3a
    rr   E                                             ;; 0d:4456 $cb $1b
    srl  D                                             ;; 0d:4458 $cb $3a
    rr   E                                             ;; 0d:445a $cb $1b
    pop  AF                                            ;; 0d:445c $f1
    ld   C, $40                                        ;; 0d:445d $0e $40
.jr_0d_445f:
    push AF                                            ;; 0d:445f $f5
    push HL                                            ;; 0d:4460 $e5
    push BC                                            ;; 0d:4461 $c5
    push DE                                            ;; 0d:4462 $d5
    ld   E, $00                                        ;; 0d:4463 $1e $00
    ld   A, $07                                        ;; 0d:4465 $3e $07
    call call_00_016b                                  ;; 0d:4467 $cd $6b $01
    ld   C, A                                          ;; 0d:446a $4f
    pop  DE                                            ;; 0d:446b $d1
    push DE                                            ;; 0d:446c $d5
    ld   D, E                                          ;; 0d:446d $53
    ld   E, $00                                        ;; 0d:446e $1e $00
    ld   A, $08                                        ;; 0d:4470 $3e $08
    call call_00_016b                                  ;; 0d:4472 $cd $6b $01
    ld   E, A                                          ;; 0d:4475 $5f
    ld   D, C                                          ;; 0d:4476 $51
    ld   A, D                                          ;; 0d:4477 $7a
    cpl                                                ;; 0d:4478 $2f
    ld   D, A                                          ;; 0d:4479 $57
    ld   A, E                                          ;; 0d:447a $7b
    cpl                                                ;; 0d:447b $2f
    add  A, $01                                        ;; 0d:447c $c6 $01
    ld   E, A                                          ;; 0d:447e $5f
    ld   A, D                                          ;; 0d:447f $7a
    adc  A, $00                                        ;; 0d:4480 $ce $00
    ld   D, A                                          ;; 0d:4482 $57
    add  HL, DE                                        ;; 0d:4483 $19
    pop  DE                                            ;; 0d:4484 $d1
    pop  BC                                            ;; 0d:4485 $c1
    xor  A, A                                          ;; 0d:4486 $af
    ld   [BC], A                                       ;; 0d:4487 $02
    inc  C                                             ;; 0d:4488 $0c
    ld   A, L                                          ;; 0d:4489 $7d
    ld   [BC], A                                       ;; 0d:448a $02
    inc  C                                             ;; 0d:448b $0c
    ld   A, H                                          ;; 0d:448c $7c
    ld   [BC], A                                       ;; 0d:448d $02
    ld   A, C                                          ;; 0d:448e $79
    and  A, $f8                                        ;; 0d:448f $e6 $f8
    add  A, $08                                        ;; 0d:4491 $c6 $08
    ld   C, A                                          ;; 0d:4493 $4f
    pop  HL                                            ;; 0d:4494 $e1
    pop  AF                                            ;; 0d:4495 $f1
    dec  A                                             ;; 0d:4496 $3d
    jr   NZ, .jr_0d_445f                               ;; 0d:4497 $20 $c6
    ret                                                ;; 0d:4499 $c9

call_0d_449a:
    ld   A, $01                                        ;; 0d:449a $3e $01
    ld   E, $00                                        ;; 0d:449c $1e $00
    ld   [DE], A                                       ;; 0d:449e $12
    ld   E, $02                                        ;; 0d:449f $1e $02
    ld   B, $04                                        ;; 0d:44a1 $06 $04
.jr_0d_44a3:
    ld   A, [HL+]                                      ;; 0d:44a3 $2a
    ld   [DE], A                                       ;; 0d:44a4 $12
    inc  E                                             ;; 0d:44a5 $1c
    dec  B                                             ;; 0d:44a6 $05
    jr   NZ, .jr_0d_44a3                               ;; 0d:44a7 $20 $fa
    ld   B, $04                                        ;; 0d:44a9 $06 $04
.jr_0d_44ab:
    ld   A, $ff                                        ;; 0d:44ab $3e $ff
    ld   [DE], A                                       ;; 0d:44ad $12
    inc  E                                             ;; 0d:44ae $1c
    dec  B                                             ;; 0d:44af $05
    jr   NZ, .jr_0d_44ab                               ;; 0d:44b0 $20 $f9
    ld   A, [HL+]                                      ;; 0d:44b2 $2a
    ld   [DE], A                                       ;; 0d:44b3 $12
    inc  E                                             ;; 0d:44b4 $1c
    ld   A, [HL+]                                      ;; 0d:44b5 $2a
    ld   [DE], A                                       ;; 0d:44b6 $12
    inc  E                                             ;; 0d:44b7 $1c
    push DE                                            ;; 0d:44b8 $d5
    ld   E, $40                                        ;; 0d:44b9 $1e $40
    ld   A, [HL+]                                      ;; 0d:44bb $2a
    ld   [DE], A                                       ;; 0d:44bc $12
    inc  E                                             ;; 0d:44bd $1c
    push DE                                            ;; 0d:44be $d5
    and  A, $10                                        ;; 0d:44bf $e6 $10
    swap A                                             ;; 0d:44c1 $cb $37
    xor  A, $01                                        ;; 0d:44c3 $ee $01
    ld   E, $01                                        ;; 0d:44c5 $1e $01
    ld   [DE], A                                       ;; 0d:44c7 $12
    pop  DE                                            ;; 0d:44c8 $d1
    ld   A, [HL+]                                      ;; 0d:44c9 $2a
    ld   [DE], A                                       ;; 0d:44ca $12
    inc  E                                             ;; 0d:44cb $1c
    ld   A, [HL+]                                      ;; 0d:44cc $2a
    ld   [DE], A                                       ;; 0d:44cd $12
    pop  DE                                            ;; 0d:44ce $d1
    ld   B, $06                                        ;; 0d:44cf $06 $06
.jr_0d_44d1:
    ld   A, [HL+]                                      ;; 0d:44d1 $2a
    ld   [DE], A                                       ;; 0d:44d2 $12
    inc  E                                             ;; 0d:44d3 $1c
    dec  B                                             ;; 0d:44d4 $05
    jr   NZ, .jr_0d_44d1                               ;; 0d:44d5 $20 $fa
    ld   B, $08                                        ;; 0d:44d7 $06 $08
.jr_0d_44d9:
    ld   A, [HL+]                                      ;; 0d:44d9 $2a
    ld   [DE], A                                       ;; 0d:44da $12
    inc  E                                             ;; 0d:44db $1c
    xor  A, A                                          ;; 0d:44dc $af
    ld   [DE], A                                       ;; 0d:44dd $12
    inc  E                                             ;; 0d:44de $1c
    ld   A, [HL+]                                      ;; 0d:44df $2a
    ld   [DE], A                                       ;; 0d:44e0 $12
    inc  E                                             ;; 0d:44e1 $1c
    dec  B                                             ;; 0d:44e2 $05
    jr   NZ, .jr_0d_44d9                               ;; 0d:44e3 $20 $f4
    ld   A, $ff                                        ;; 0d:44e5 $3e $ff
    ld   [DE], A                                       ;; 0d:44e7 $12
    inc  E                                             ;; 0d:44e8 $1c
    inc  A                                             ;; 0d:44e9 $3c
    ld   [DE], A                                       ;; 0d:44ea $12
    dec  A                                             ;; 0d:44eb $3d
    inc  E                                             ;; 0d:44ec $1c
    ld   [DE], A                                       ;; 0d:44ed $12
    inc  E                                             ;; 0d:44ee $1c
    xor  A, A                                          ;; 0d:44ef $af
    ld   [DE], A                                       ;; 0d:44f0 $12
    inc  E                                             ;; 0d:44f1 $1c
    ld   [DE], A                                       ;; 0d:44f2 $12
    ret                                                ;; 0d:44f3 $c9

call_0d_44f4:
    ld   E, $0a                                        ;; 0d:44f4 $1e $0a
    ld   A, [DE]                                       ;; 0d:44f6 $1a
    ld   L, A                                          ;; 0d:44f7 $6f
    ld   E, $02                                        ;; 0d:44f8 $1e $02
    ld   H, $00                                        ;; 0d:44fa $26 $00
    add  HL, HL                                        ;; 0d:44fc $29
    push HL                                            ;; 0d:44fd $e5
    add  HL, HL                                        ;; 0d:44fe $29
    add  HL, HL                                        ;; 0d:44ff $29
    push DE                                            ;; 0d:4500 $d5
    ld   DE, data_0d_6ec0                              ;; 0d:4501 $11 $c0 $6e
    add  HL, DE                                        ;; 0d:4504 $19
    pop  DE                                            ;; 0d:4505 $d1
    ld   A, $0f                                        ;; 0d:4506 $3e $0f
    ld   B, $08                                        ;; 0d:4508 $06 $08
    call memcopySmallFromBank                          ;; 0d:450a $cd $b5 $00
    pop  HL                                            ;; 0d:450d $e1
    push DE                                            ;; 0d:450e $d5
    ld   E, L                                          ;; 0d:450f $5d
    ld   D, H                                          ;; 0d:4510 $54
    add  HL, HL                                        ;; 0d:4511 $29
    add  HL, HL                                        ;; 0d:4512 $29
    add  HL, DE                                        ;; 0d:4513 $19
    ld   DE, data_0d_6f80                              ;; 0d:4514 $11 $80 $6f
    add  HL, DE                                        ;; 0d:4517 $19
    ld   B, $0a                                        ;; 0d:4518 $06 $0a
    ld   DE, wDE00                                     ;; 0d:451a $11 $00 $de
    ld   A, $0d                                        ;; 0d:451d $3e $0d
    call memcopySmallFromBank                          ;; 0d:451f $cd $b5 $00
    pop  DE                                            ;; 0d:4522 $d1
    ld   HL, wDE00                                     ;; 0d:4523 $21 $00 $de
    ld   A, [HL+]                                      ;; 0d:4526 $2a
    push AF                                            ;; 0d:4527 $f5
    and  A, $f0                                        ;; 0d:4528 $e6 $f0
    swap A                                             ;; 0d:452a $cb $37
    ld   E, $0b                                        ;; 0d:452c $1e $0b
    ld   [DE], A                                       ;; 0d:452e $12
    inc  HL                                            ;; 0d:452f $23
    ld   A, [HL+]                                      ;; 0d:4530 $2a
    ld   E, $0c                                        ;; 0d:4531 $1e $0c
    ld   [DE], A                                       ;; 0d:4533 $12
    inc  E                                             ;; 0d:4534 $1c
    ld   A, [HL+]                                      ;; 0d:4535 $2a
    ld   [DE], A                                       ;; 0d:4536 $12
    inc  E                                             ;; 0d:4537 $1c
    ld   A, [HL+]                                      ;; 0d:4538 $2a
    ld   [DE], A                                       ;; 0d:4539 $12
    inc  E                                             ;; 0d:453a $1c
    ld   A, [HL+]                                      ;; 0d:453b $2a
    ld   [DE], A                                       ;; 0d:453c $12
    inc  E                                             ;; 0d:453d $1c
    ld   A, [HL+]                                      ;; 0d:453e $2a
    ld   [DE], A                                       ;; 0d:453f $12
    inc  E                                             ;; 0d:4540 $1c
    ld   A, [HL+]                                      ;; 0d:4541 $2a
    ld   [DE], A                                       ;; 0d:4542 $12
    ld   A, [HL+]                                      ;; 0d:4543 $2a
    ld   H, [HL]                                       ;; 0d:4544 $66
    ld   L, A                                          ;; 0d:4545 $6f
    pop  AF                                            ;; 0d:4546 $f1
    and  A, $0f                                        ;; 0d:4547 $e6 $0f
    ld   [wDE10], A                                    ;; 0d:4549 $ea $10 $de
    inc  A                                             ;; 0d:454c $3c
    ld   B, A                                          ;; 0d:454d $47
    ld   E, $12                                        ;; 0d:454e $1e $12
.jr_0d_4550:
    ld   A, $0d                                        ;; 0d:4550 $3e $0d
    call call_00_00d2                                  ;; 0d:4552 $cd $d2 $00
    inc  HL                                            ;; 0d:4555 $23
    ld   [DE], A                                       ;; 0d:4556 $12
    inc  E                                             ;; 0d:4557 $1c
    xor  A, A                                          ;; 0d:4558 $af
    ld   [DE], A                                       ;; 0d:4559 $12
    inc  E                                             ;; 0d:455a $1c
    ld   A, $fe                                        ;; 0d:455b $3e $fe
    ld   [DE], A                                       ;; 0d:455d $12
    inc  E                                             ;; 0d:455e $1c
    dec  B                                             ;; 0d:455f $05
    jr   NZ, .jr_0d_4550                               ;; 0d:4560 $20 $ee
.jr_0d_4562:
    ld   A, $ff                                        ;; 0d:4562 $3e $ff
    ld   [DE], A                                       ;; 0d:4564 $12
    inc  E                                             ;; 0d:4565 $1c
    xor  A, A                                          ;; 0d:4566 $af
    ld   [DE], A                                       ;; 0d:4567 $12
    inc  E                                             ;; 0d:4568 $1c
    ld   A, $ff                                        ;; 0d:4569 $3e $ff
    ld   [DE], A                                       ;; 0d:456b $12
    inc  E                                             ;; 0d:456c $1c
    ld   A, E                                          ;; 0d:456d $7b
    cp   A, $2d                                        ;; 0d:456e $fe $2d
    jr   C, .jr_0d_4562                                ;; 0d:4570 $38 $f0
    xor  A, A                                          ;; 0d:4572 $af
    ld   E, $2d                                        ;; 0d:4573 $1e $2d
    ld   [DE], A                                       ;; 0d:4575 $12
    inc  E                                             ;; 0d:4576 $1c
    ld   [DE], A                                       ;; 0d:4577 $12
    ret                                                ;; 0d:4578 $c9

call_0d_4579:
    ld   H, $d0                                        ;; 0d:4579 $26 $d0
    ld   C, $05                                        ;; 0d:457b $0e $05
.jr_0d_457d:
    ld   DE, .data_0d_4598                             ;; 0d:457d $11 $98 $45
    ld   L, $01                                        ;; 0d:4580 $2e $01
    ld   A, [HL]                                       ;; 0d:4582 $7e
    or   A, A                                          ;; 0d:4583 $b7
    ld   A, $80                                        ;; 0d:4584 $3e $80
    ld   L, $40                                        ;; 0d:4586 $2e $40
    ld   B, $07                                        ;; 0d:4588 $06 $07
    jr   Z, .jr_0d_45af                                ;; 0d:458a $28 $23
    ld   A, [HL+]                                      ;; 0d:458c $2a
.jr_0d_458d:
    rrca                                               ;; 0d:458d $0f
    jr   C, .jp_0d_45a8                                ;; 0d:458e $38 $18
    inc  DE                                            ;; 0d:4590 $13
    inc  DE                                            ;; 0d:4591 $13
    dec  B                                             ;; 0d:4592 $05
    jr   NZ, .jr_0d_458d                               ;; 0d:4593 $20 $f8
    jp   .jp_0d_45a8                                   ;; 0d:4595 $c3 $a8 $45
.data_0d_4598:
    db   $0f, $01, $0e, $01, $ff, $00, $ff, $00        ;; 0d:4598 ????????
    db   $ff, $00, $ff, $00, $ff, $00                  ;; 0d:45a0 ??????
    dw   $00ff                                         ;; 0d:45a6 wW
.jp_0d_45a8:
    inc  L                                             ;; 0d:45a8 $2c
    inc  L                                             ;; 0d:45a9 $2c
    ld   A, [DE]                                       ;; 0d:45aa $1a
    ld   [HL+], A                                      ;; 0d:45ab $22
    inc  DE                                            ;; 0d:45ac $13
    ld   A, [DE]                                       ;; 0d:45ad $1a
    ld   [HL], A                                       ;; 0d:45ae $77
.jr_0d_45af:
    inc  H                                             ;; 0d:45af $24
    dec  C                                             ;; 0d:45b0 $0d
    jr   NZ, .jr_0d_457d                               ;; 0d:45b1 $20 $ca
    ret                                                ;; 0d:45b3 $c9
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45b4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45bc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45c4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45cc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45d4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45dc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45e4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45ec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45f4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:45fc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4604 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:460c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4614 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:461c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4624 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:462c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4634 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:463c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4644 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:464c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4654 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:465c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4664 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:466c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4674 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:467c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4684 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:468c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4694 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:469c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46a4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46ac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46b4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46bc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46c4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46cc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46d4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46dc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46e4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46ec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46f4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:46fc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4704 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:470c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4714 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:471c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4724 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:472c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4734 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:473c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4744 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:474c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4754 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:475c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4764 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:476c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4774 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:477c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4784 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:478c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4794 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:479c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47a4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47ac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47b4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47bc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47c4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47cc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47d4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47dc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47e4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47ec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47f4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:47fc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4804 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:480c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4814 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:481c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4824 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:482c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4834 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:483c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4844 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:484c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4854 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:485c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4864 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:486c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4874 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:487c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4884 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:488c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4894 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:489c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48a4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48ac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48b4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48bc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48c4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48cc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48d4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48dc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48e4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48ec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48f4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:48fc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4904 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:490c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4914 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:491c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4924 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:492c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4934 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:493c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4944 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:494c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4954 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:495c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4964 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:496c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4974 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:497c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4984 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:498c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4994 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:499c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49a4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49ac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49b4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49bc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49c4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49cc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49d4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49dc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49e4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49ec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49f4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:49fc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a04 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a0c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a14 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a1c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a24 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a2c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a34 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a3c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a44 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a4c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a54 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a5c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a64 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a6c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a74 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a7c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a84 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a8c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a94 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4a9c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4aa4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4aac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ab4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4abc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ac4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4acc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ad4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4adc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ae4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4aec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4af4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4afc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b04 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b0c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b14 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b1c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b24 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b2c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b34 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b3c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b44 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b4c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b54 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b5c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b64 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b6c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b74 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b7c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b84 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b8c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b94 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4b9c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ba4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bb4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bbc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bc4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bcc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bd4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bdc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4be4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bf4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4bfc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c04 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c0c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c14 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c1c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c24 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c2c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c34 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c3c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c44 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c4c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c54 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c5c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c64 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c6c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c74 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c7c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c84 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c8c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c94 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4c9c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ca4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4cac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4cb4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4cbc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4cc4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ccc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4cd4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4cdc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ce4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4cec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4cf4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4cfc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d04 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d0c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d14 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d1c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d24 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d2c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d34 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d3c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d44 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d4c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d54 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d5c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d64 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d6c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d74 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d7c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d84 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d8c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d94 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4d9c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4da4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4dac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4db4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4dbc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4dc4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4dcc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4dd4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ddc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4de4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4dec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4df4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4dfc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e04 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e0c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e14 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e1c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e24 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e2c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e34 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e3c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e44 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e4c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e54 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e5c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e64 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e6c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e74 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e7c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e84 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e8c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e94 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4e9c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ea4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4eac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4eb4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ebc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ec4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ecc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ed4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4edc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ee4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4eec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ef4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4efc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f04 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f0c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f14 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f1c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f24 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f2c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f34 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f3c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f44 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f4c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f54 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f5c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f64 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f6c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f74 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f7c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f84 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f8c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f94 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4f9c ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fa4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fac ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fb4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fbc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fc4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fcc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fd4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fdc ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fe4 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4fec ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:4ff4 ????????
    db   $00, $00, $00, $00                            ;; 0d:4ffc ????

call_0d_5000:
    jp   jp_0d_501b                                    ;; 0d:5000 $c3 $1b $50

call_0d_5003:
    jp   jp_0d_5399                                    ;; 0d:5003 $c3 $99 $53

call_0d_5006:
    jp   call_0d_60d3                                  ;; 0d:5006 $c3 $d3 $60

call_0d_5009:
    jp   jp_0d_60be                                    ;; 0d:5009 $c3 $be $60

call_0d_500c:
    jp   call_0d_60b9                                  ;; 0d:500c $c3 $b9 $60

call_0d_500f:
    jp   jp_0d_6082                                    ;; 0d:500f $c3 $82 $60

call_0d_5012:
    jp   jp_0d_525b                                    ;; 0d:5012 $c3 $5b $52

call_0d_5015:
    jp   call_0d_52e0                                  ;; 0d:5015 $c3 $e0 $52

call_0d_5018:
    jp   jp_0d_5302                                    ;; 0d:5018 $c3 $02 $53

jp_0d_501b:
    push AF                                            ;; 0d:501b $f5
    push BC                                            ;; 0d:501c $c5
    push DE                                            ;; 0d:501d $d5
    push HL                                            ;; 0d:501e $e5
    ld   A, $16                                        ;; 0d:501f $3e $16
    ldh  [rOBP1], A                                    ;; 0d:5021 $e0 $49
    ld   [wC702], A                                    ;; 0d:5023 $ea $02 $c7
    call call_0d_502c                                  ;; 0d:5026 $cd $2c $50
    jp   pop_all                                       ;; 0d:5029 $c3 $0b $00

call_0d_502c:
    ld   A, [wD910]                                    ;; 0d:502c $fa $10 $d9
    bit  7, A                                          ;; 0d:502f $cb $7f
    jp   Z, call_0d_533e                               ;; 0d:5031 $ca $3e $53
    and  A, $7f                                        ;; 0d:5034 $e6 $7f
    add  A, A                                          ;; 0d:5036 $87
    ld   HL, data_0d_6700                              ;; 0d:5037 $21 $00 $67
    rst  add_hl_a                                      ;; 0d:503a $c7
    call call_0d_5235                                  ;; 0d:503b $cd $35 $52
    ld   C, A                                          ;; 0d:503e $4f
    call call_0d_5235                                  ;; 0d:503f $cd $35 $52
    ld   B, A                                          ;; 0d:5042 $47
    and  A, $02                                        ;; 0d:5043 $e6 $02
    srl  A                                             ;; 0d:5045 $cb $3f
    ld   [wD93C], A                                    ;; 0d:5047 $ea $3c $d9
    ld   L, C                                          ;; 0d:504a $69
    ld   A, B                                          ;; 0d:504b $78
    and  A, $01                                        ;; 0d:504c $e6 $01
    ld   H, A                                          ;; 0d:504e $67
    ld   BC, data_0d_6000                              ;; 0d:504f $01 $00 $60
    call mul_hl_16_add_bc                              ;; 0d:5052 $cd $5d $00
    ld   DE, $8000                                     ;; 0d:5055 $11 $00 $80
    ld   A, $04                                        ;; 0d:5058 $3e $04
    ld   BC, $200                                      ;; 0d:505a $01 $00 $02
    call call_00_00ca                                  ;; 0d:505d $cd $ca $00
    xor  A, A                                          ;; 0d:5060 $af
    ld   HL, wD989                                     ;; 0d:5061 $21 $89 $d9
    ld   [HL+], A                                      ;; 0d:5064 $22
    ld   [HL-], A                                      ;; 0d:5065 $32
    ld   A, [wD910]                                    ;; 0d:5066 $fa $10 $d9
    cp   A, $a0                                        ;; 0d:5069 $fe $a0
    jr   NZ, .jr_0d_5070                               ;; 0d:506b $20 $03
    ld   [HL], A                                       ;; 0d:506d $77
    jr   .jr_0d_507d                                   ;; 0d:506e $18 $0d
.jr_0d_5070:
    ld   A, [wD93C]                                    ;; 0d:5070 $fa $3c $d9
    and  A, A                                          ;; 0d:5073 $a7
    jr   NZ, call_0d_50a6                              ;; 0d:5074 $20 $30
    ld   A, [wCFF5]                                    ;; 0d:5076 $fa $f5 $cf
    cp   A, $09                                        ;; 0d:5079 $fe $09
    jr   NZ, .jr_0d_50a1                               ;; 0d:507b $20 $24
.jr_0d_507d:
    xor  A, A                                          ;; 0d:507d $af
.jr_0d_507e:
    call call_0d_5251                                  ;; 0d:507e $cd $51 $52
    jr   NZ, .jr_0d_5086                               ;; 0d:5081 $20 $03
    inc  A                                             ;; 0d:5083 $3c
    jr   .jr_0d_507e                                   ;; 0d:5084 $18 $f8
.jr_0d_5086:
    ld   [wD974], A                                    ;; 0d:5086 $ea $74 $d9
    call call_0d_50a6                                  ;; 0d:5089 $cd $a6 $50
    ld   HL, wD98A                                     ;; 0d:508c $21 $8a $d9
    inc  [HL]                                          ;; 0d:508f $34
    ld   A, [wD974]                                    ;; 0d:5090 $fa $74 $d9
    cp   A, $02                                        ;; 0d:5093 $fe $02
    ret  NC                                            ;; 0d:5095 $d0
.jr_0d_5096:
    inc  A                                             ;; 0d:5096 $3c
    call call_0d_5251                                  ;; 0d:5097 $cd $51 $52
    jr   NZ, .jr_0d_5086                               ;; 0d:509a $20 $ea
    cp   A, $02                                        ;; 0d:509c $fe $02
    jr   C, .jr_0d_5096                                ;; 0d:509e $38 $f6
    ret                                                ;; 0d:50a0 $c9
.jr_0d_50a1:
    sub  A, $05                                        ;; 0d:50a1 $d6 $05
    ld   [wD974], A                                    ;; 0d:50a3 $ea $74 $d9

call_0d_50a6:
    xor  A, A                                          ;; 0d:50a6 $af
    ld   [wD973], A                                    ;; 0d:50a7 $ea $73 $d9
    ld   A, [wD910]                                    ;; 0d:50aa $fa $10 $d9
    and  A, $7f                                        ;; 0d:50ad $e6 $7f
    add  A, A                                          ;; 0d:50af $87
    ld   HL, data_0d_6800                              ;; 0d:50b0 $21 $00 $68
    rst  add_hl_a                                      ;; 0d:50b3 $c7
    call call_0d_5227                                  ;; 0d:50b4 $cd $27 $52
    call call_0d_5205                                  ;; 0d:50b7 $cd $05 $52
.jr_0d_50ba:
    call call_0d_51ff                                  ;; 0d:50ba $cd $ff $51
    cp   A, $ff                                        ;; 0d:50bd $fe $ff
    jp   Z, call_0d_60ce                               ;; 0d:50bf $ca $ce $60
    bit  7, A                                          ;; 0d:50c2 $cb $7f
    jr   Z, .jr_0d_50db                                ;; 0d:50c4 $28 $15
    bit  6, A                                          ;; 0d:50c6 $cb $77
    jr   NZ, .jr_0d_50d6                               ;; 0d:50c8 $20 $0c
    bit  5, A                                          ;; 0d:50ca $cb $6f
    jr   Z, .jr_0d_50d6                                ;; 0d:50cc $28 $08
    call call_0d_51ff                                  ;; 0d:50ce $cd $ff $51
    ld   [wD973], A                                    ;; 0d:50d1 $ea $73 $d9
    jr   .jr_0d_50ba                                   ;; 0d:50d4 $18 $e4
.jr_0d_50d6:
    call call_0d_533e                                  ;; 0d:50d6 $cd $3e $53
    jr   .jr_0d_50ba                                   ;; 0d:50d9 $18 $df
.jr_0d_50db:
    call call_0d_50e7                                  ;; 0d:50db $cd $e7 $50
    ld   A, [wD941]                                    ;; 0d:50de $fa $41 $d9
    ld   B, A                                          ;; 0d:50e1 $47
    call call_0d_60d3                                  ;; 0d:50e2 $cd $d3 $60
    jr   .jr_0d_50ba                                   ;; 0d:50e5 $18 $d3

call_0d_50e7:
    ld   HL, wD941                                     ;; 0d:50e7 $21 $41 $d9
    ld   C, A                                          ;; 0d:50ea $4f
    and  A, $0f                                        ;; 0d:50eb $e6 $0f
    inc  A                                             ;; 0d:50ed $3c
    add  A, A                                          ;; 0d:50ee $87
    add  A, A                                          ;; 0d:50ef $87
    ld   [HL+], A                                      ;; 0d:50f0 $22
    ld   A, C                                          ;; 0d:50f1 $79
    and  A, $70                                        ;; 0d:50f2 $e6 $70
    ld   [HL], A                                       ;; 0d:50f4 $77
    ld   HL, wD93F                                     ;; 0d:50f5 $21 $3f $d9
    ld   [HL], $10                                     ;; 0d:50f8 $36 $10
    inc  HL                                            ;; 0d:50fa $23
    ld   [HL], $40                                     ;; 0d:50fb $36 $40
    ld   A, [wD989]                                    ;; 0d:50fd $fa $89 $d9
    and  A, A                                          ;; 0d:5100 $a7
    jr   NZ, .jr_0d_5109                               ;; 0d:5101 $20 $06
    ld   A, [wD93C]                                    ;; 0d:5103 $fa $3c $d9
    and  A, A                                          ;; 0d:5106 $a7
    jr   NZ, .jr_0d_510c                               ;; 0d:5107 $20 $03
.jr_0d_5109:
    call call_0d_5240                                  ;; 0d:5109 $cd $40 $52
.jr_0d_510c:
    call call_0d_51ff                                  ;; 0d:510c $cd $ff $51
    ld   L, A                                          ;; 0d:510f $6f
    ld   H, $00                                        ;; 0d:5110 $26 $00
    ld   BC, data_0d_7000                              ;; 0d:5112 $01 $00 $70
    add  HL, HL                                        ;; 0d:5115 $29
    add  HL, BC                                        ;; 0d:5116 $09
    call call_0d_5219                                  ;; 0d:5117 $cd $19 $52
    ld   DE, wD943                                     ;; 0d:511a $11 $43 $d9
    ld   B, $30                                        ;; 0d:511d $06 $30
.jr_0d_511f:
    call call_0d_5239                                  ;; 0d:511f $cd $39 $52
    bit  7, A                                          ;; 0d:5122 $cb $7f
    jr   Z, .jr_0d_5138                                ;; 0d:5124 $28 $12
    and  A, $7f                                        ;; 0d:5126 $e6 $7f
    push AF                                            ;; 0d:5128 $f5
    call call_0d_5239                                  ;; 0d:5129 $cd $39 $52
    ld   C, A                                          ;; 0d:512c $4f
    pop  AF                                            ;; 0d:512d $f1
.jr_0d_512e:
    ld   [DE], A                                       ;; 0d:512e $12
    inc  DE                                            ;; 0d:512f $13
    dec  B                                             ;; 0d:5130 $05
    jr   Z, .jr_0d_513d                                ;; 0d:5131 $28 $0a
    dec  C                                             ;; 0d:5133 $0d
    jr   NZ, .jr_0d_512e                               ;; 0d:5134 $20 $f8
    jr   .jr_0d_511f                                   ;; 0d:5136 $18 $e7
.jr_0d_5138:
    ld   [DE], A                                       ;; 0d:5138 $12
    inc  DE                                            ;; 0d:5139 $13
    dec  B                                             ;; 0d:513a $05
    jr   NZ, .jr_0d_511f                               ;; 0d:513b $20 $e2
.jr_0d_513d:
    ld   A, [wD942]                                    ;; 0d:513d $fa $42 $d9
    bit  6, A                                          ;; 0d:5140 $cb $77
    call NZ, call_0d_51b0                              ;; 0d:5142 $c4 $b0 $51
    bit  5, A                                          ;; 0d:5145 $cb $6f
    call NZ, call_0d_51d6                              ;; 0d:5147 $c4 $d6 $51
    ld   HL, wD989                                     ;; 0d:514a $21 $89 $d9
    ld   A, [HL+]                                      ;; 0d:514d $2a
    and  A, A                                          ;; 0d:514e $a7
    jr   Z, .jr_0d_515a                                ;; 0d:514f $28 $09
    ld   A, [HL]                                       ;; 0d:5151 $7e
    rrca                                               ;; 0d:5152 $0f
    call C, call_0d_51b0                               ;; 0d:5153 $dc $b0 $51
    rrca                                               ;; 0d:5156 $0f
    call C, call_0d_51d6                               ;; 0d:5157 $dc $d6 $51
.jr_0d_515a:
    ld   HL, wCC00                                     ;; 0d:515a $21 $00 $cc
    ld   B, $a0                                        ;; 0d:515d $06 $a0
    call memclearSmall                                 ;; 0d:515f $cd $6c $00
    ld   HL, wD93F                                     ;; 0d:5162 $21 $3f $d9
    ld   A, [HL+]                                      ;; 0d:5165 $2a
    ldh  [hFF90], A                                    ;; 0d:5166 $e0 $90
    ld   A, [HL]                                       ;; 0d:5168 $7e
    ldh  [hFF91], A                                    ;; 0d:5169 $e0 $91
    ld   DE, wD943                                     ;; 0d:516b $11 $43 $d9
    ld   HL, wCC00                                     ;; 0d:516e $21 $00 $cc
    ld   B, $08                                        ;; 0d:5171 $06 $08
.jr_0d_5173:
    push BC                                            ;; 0d:5173 $c5
    ld   C, $06                                        ;; 0d:5174 $0e $06
.jr_0d_5176:
    ld   B, $1f                                        ;; 0d:5176 $06 $1f
    ld   A, [DE]                                       ;; 0d:5178 $1a
    and  A, B                                          ;; 0d:5179 $a0
    cp   A, B                                          ;; 0d:517a $b8
    jr   Z, .jr_0d_5196                                ;; 0d:517b $28 $19
    ldh  A, [hFF90]                                    ;; 0d:517d $f0 $90
    ld   [HL+], A                                      ;; 0d:517f $22
    ldh  A, [hFF91]                                    ;; 0d:5180 $f0 $91
    ld   [HL+], A                                      ;; 0d:5182 $22
    ld   A, [DE]                                       ;; 0d:5183 $1a
    and  A, B                                          ;; 0d:5184 $a0
    ld   B, A                                          ;; 0d:5185 $47
    ld   A, [wD973]                                    ;; 0d:5186 $fa $73 $d9
    add  A, B                                          ;; 0d:5189 $80
    ld   [HL+], A                                      ;; 0d:518a $22
    ld   A, [DE]                                       ;; 0d:518b $1a
    and  A, $60                                        ;; 0d:518c $e6 $60
    ld   B, A                                          ;; 0d:518e $47
    ld   A, [wD942]                                    ;; 0d:518f $fa $42 $d9
    and  A, $10                                        ;; 0d:5192 $e6 $10
    or   A, B                                          ;; 0d:5194 $b0
    ld   [HL+], A                                      ;; 0d:5195 $22
.jr_0d_5196:
    inc  DE                                            ;; 0d:5196 $13
    ldh  A, [hFF91]                                    ;; 0d:5197 $f0 $91
    add  A, $08                                        ;; 0d:5199 $c6 $08
    ldh  [hFF91], A                                    ;; 0d:519b $e0 $91
    dec  C                                             ;; 0d:519d $0d
    jr   NZ, .jr_0d_5176                               ;; 0d:519e $20 $d6
    ldh  A, [hFF90]                                    ;; 0d:51a0 $f0 $90
    add  A, $08                                        ;; 0d:51a2 $c6 $08
    ldh  [hFF90], A                                    ;; 0d:51a4 $e0 $90
    ld   A, [wD940]                                    ;; 0d:51a6 $fa $40 $d9
    ldh  [hFF91], A                                    ;; 0d:51a9 $e0 $91
    pop  BC                                            ;; 0d:51ab $c1
    dec  B                                             ;; 0d:51ac $05
    jr   NZ, .jr_0d_5173                               ;; 0d:51ad $20 $c4
    ret                                                ;; 0d:51af $c9

call_0d_51b0:
    push AF                                            ;; 0d:51b0 $f5
    ld   HL, wD943                                     ;; 0d:51b1 $21 $43 $d9
    ld   DE, wD96D                                     ;; 0d:51b4 $11 $6d $d9
    ld   B, $04                                        ;; 0d:51b7 $06 $04
.jr_0d_51b9:
    ld   C, $06                                        ;; 0d:51b9 $0e $06
.jr_0d_51bb:
    push BC                                            ;; 0d:51bb $c5
    ld   C, $40                                        ;; 0d:51bc $0e $40
    ld   B, [HL]                                       ;; 0d:51be $46
    ld   A, [DE]                                       ;; 0d:51bf $1a
    xor  A, C                                          ;; 0d:51c0 $a9
    ld   [HL+], A                                      ;; 0d:51c1 $22
    ld   A, B                                          ;; 0d:51c2 $78
    xor  A, C                                          ;; 0d:51c3 $a9
    ld   [DE], A                                       ;; 0d:51c4 $12
    inc  DE                                            ;; 0d:51c5 $13
    pop  BC                                            ;; 0d:51c6 $c1
    dec  C                                             ;; 0d:51c7 $0d
    jr   NZ, .jr_0d_51bb                               ;; 0d:51c8 $20 $f1
    ld   A, E                                          ;; 0d:51ca $7b
    sub  A, $0c                                        ;; 0d:51cb $d6 $0c
    ld   E, A                                          ;; 0d:51cd $5f
    jr   NC, .jr_0d_51d1                               ;; 0d:51ce $30 $01
    dec  D                                             ;; 0d:51d0 $15
.jr_0d_51d1:
    dec  B                                             ;; 0d:51d1 $05
    jr   NZ, .jr_0d_51b9                               ;; 0d:51d2 $20 $e5
    pop  AF                                            ;; 0d:51d4 $f1
    ret                                                ;; 0d:51d5 $c9

call_0d_51d6:
    push AF                                            ;; 0d:51d6 $f5
    ld   HL, wD943                                     ;; 0d:51d7 $21 $43 $d9
    ld   DE, wD948                                     ;; 0d:51da $11 $48 $d9
    ld   B, $08                                        ;; 0d:51dd $06 $08
.jr_0d_51df:
    ld   C, $03                                        ;; 0d:51df $0e $03
.jr_0d_51e1:
    push BC                                            ;; 0d:51e1 $c5
    ld   C, $20                                        ;; 0d:51e2 $0e $20
    ld   B, [HL]                                       ;; 0d:51e4 $46
    ld   A, [DE]                                       ;; 0d:51e5 $1a
    xor  A, C                                          ;; 0d:51e6 $a9
    ld   [HL+], A                                      ;; 0d:51e7 $22
    ld   A, B                                          ;; 0d:51e8 $78
    xor  A, C                                          ;; 0d:51e9 $a9
    ld   [DE], A                                       ;; 0d:51ea $12
    dec  DE                                            ;; 0d:51eb $1b
    pop  BC                                            ;; 0d:51ec $c1
    dec  C                                             ;; 0d:51ed $0d
    jr   NZ, .jr_0d_51e1                               ;; 0d:51ee $20 $f1
    ld   A, $03                                        ;; 0d:51f0 $3e $03
    rst  add_hl_a                                      ;; 0d:51f2 $c7
    ld   A, E                                          ;; 0d:51f3 $7b
    add  A, $09                                        ;; 0d:51f4 $c6 $09
    ld   E, A                                          ;; 0d:51f6 $5f
    jr   NC, .jr_0d_51fa                               ;; 0d:51f7 $30 $01
    inc  D                                             ;; 0d:51f9 $14
.jr_0d_51fa:
    dec  B                                             ;; 0d:51fa $05
    jr   NZ, .jr_0d_51df                               ;; 0d:51fb $20 $e2
    pop  AF                                            ;; 0d:51fd $f1
    ret                                                ;; 0d:51fe $c9

call_0d_51ff:
    call call_0d_5210                                  ;; 0d:51ff $cd $10 $52
    call call_0d_5235                                  ;; 0d:5202 $cd $35 $52

call_0d_5205:
    push AF                                            ;; 0d:5205 $f5
    ld   A, L                                          ;; 0d:5206 $7d
    ld   [wD93D], A                                    ;; 0d:5207 $ea $3d $d9
    ld   A, H                                          ;; 0d:520a $7c
    ld   [wD93E], A                                    ;; 0d:520b $ea $3e $d9
    pop  AF                                            ;; 0d:520e $f1
    ret                                                ;; 0d:520f $c9

call_0d_5210:
    push AF                                            ;; 0d:5210 $f5
    ld   HL, wD93D                                     ;; 0d:5211 $21 $3d $d9
    ld   A, [HL+]                                      ;; 0d:5214 $2a
    ld   H, [HL]                                       ;; 0d:5215 $66
    ld   L, A                                          ;; 0d:5216 $6f
    pop  AF                                            ;; 0d:5217 $f1
    ret                                                ;; 0d:5218 $c9

call_0d_5219:
    push AF                                            ;; 0d:5219 $f5
    push BC                                            ;; 0d:521a $c5
    call call_0d_5239                                  ;; 0d:521b $cd $39 $52
    ld   C, A                                          ;; 0d:521e $4f
    call call_0d_5239                                  ;; 0d:521f $cd $39 $52
    ld   H, A                                          ;; 0d:5222 $67
    ld   L, C                                          ;; 0d:5223 $69
    pop  BC                                            ;; 0d:5224 $c1
    pop  AF                                            ;; 0d:5225 $f1
    ret                                                ;; 0d:5226 $c9

call_0d_5227:
    push AF                                            ;; 0d:5227 $f5
    push BC                                            ;; 0d:5228 $c5
    call call_0d_5235                                  ;; 0d:5229 $cd $35 $52
    ld   C, A                                          ;; 0d:522c $4f
    call call_0d_5235                                  ;; 0d:522d $cd $35 $52
    ld   H, A                                          ;; 0d:5230 $67
    ld   L, C                                          ;; 0d:5231 $69
    pop  BC                                            ;; 0d:5232 $c1
    pop  AF                                            ;; 0d:5233 $f1
    ret                                                ;; 0d:5234 $c9

call_0d_5235:
    ld   A, $07                                        ;; 0d:5235 $3e $07
    jr   jp_0d_523b                                    ;; 0d:5237 $18 $02

call_0d_5239:
    ld   A, $01                                        ;; 0d:5239 $3e $01

jp_0d_523b:
    call call_00_00d2                                  ;; 0d:523b $cd $d2 $00
    inc  HL                                            ;; 0d:523e $23
    ret                                                ;; 0d:523f $c9

call_0d_5240:
    ld   A, [wD974]                                    ;; 0d:5240 $fa $74 $d9
    ld   HL, wD933                                     ;; 0d:5243 $21 $33 $d9
    rst  add_hl_a                                      ;; 0d:5246 $c7
    ld   A, [HL]                                       ;; 0d:5247 $7e
    add  A, A                                          ;; 0d:5248 $87
    add  A, A                                          ;; 0d:5249 $87
    add  A, A                                          ;; 0d:524a $87
    sub  A, $10                                        ;; 0d:524b $d6 $10
    ld   [wD940], A                                    ;; 0d:524d $ea $40 $d9
    ret                                                ;; 0d:5250 $c9

call_0d_5251:
    ld   B, A                                          ;; 0d:5251 $47
    ld   HL, wD501                                     ;; 0d:5252 $21 $01 $d5
    add  A, H                                          ;; 0d:5255 $84
    ld   H, A                                          ;; 0d:5256 $67
    ld   A, [HL]                                       ;; 0d:5257 $7e
    and  A, A                                          ;; 0d:5258 $a7
    ld   A, B                                          ;; 0d:5259 $78
    ret                                                ;; 0d:525a $c9

jp_0d_525b:
    ld   DE, wD500                                     ;; 0d:525b $11 $00 $d5
    ld   HL, wD920                                     ;; 0d:525e $21 $20 $d9
    ld   [HL], $00                                     ;; 0d:5261 $36 $00
    ld   B, $03                                        ;; 0d:5263 $06 $03
.jr_0d_5265:
    ld   A, [DE]                                       ;; 0d:5265 $1a
    inc  D                                             ;; 0d:5266 $14
    and  A, A                                          ;; 0d:5267 $a7
    jr   Z, .jr_0d_526b                                ;; 0d:5268 $28 $01
    inc  [HL]                                          ;; 0d:526a $34
.jr_0d_526b:
    dec  B                                             ;; 0d:526b $05
    jr   NZ, .jr_0d_5265                               ;; 0d:526c $20 $f7
    ld   A, [wD920]                                    ;; 0d:526e $fa $20 $d9
    ld   B, A                                          ;; 0d:5271 $47
    ld   DE, wD921                                     ;; 0d:5272 $11 $21 $d9
    ld   HL, wD50A                                     ;; 0d:5275 $21 $0a $d5
.jr_0d_5278:
    ld   A, [HL]                                       ;; 0d:5278 $7e
    push HL                                            ;; 0d:5279 $e5
    ld   HL, data_0d_6400                              ;; 0d:527a $21 $00 $64
    rst  add_hl_a                                      ;; 0d:527d $c7
    ld   A, [HL]                                       ;; 0d:527e $7e
    and  A, $f0                                        ;; 0d:527f $e6 $f0
    swap A                                             ;; 0d:5281 $cb $37
    ld   [DE], A                                       ;; 0d:5283 $12
    inc  DE                                            ;; 0d:5284 $13
    ld   A, [HL]                                       ;; 0d:5285 $7e
    and  A, $0f                                        ;; 0d:5286 $e6 $0f
    ld   [DE], A                                       ;; 0d:5288 $12
    dec  DE                                            ;; 0d:5289 $1b
    pop  HL                                            ;; 0d:528a $e1
    inc  DE                                            ;; 0d:528b $13
    inc  DE                                            ;; 0d:528c $13
    inc  H                                             ;; 0d:528d $24
    dec  B                                             ;; 0d:528e $05
    jr   NZ, .jr_0d_5278                               ;; 0d:528f $20 $e7
    call call_0d_52e0                                  ;; 0d:5291 $cd $e0 $52
    ld   A, [wD920]                                    ;; 0d:5294 $fa $20 $d9
    ld   C, A                                          ;; 0d:5297 $4f
    dec  A                                             ;; 0d:5298 $3d
    ld   B, A                                          ;; 0d:5299 $47
    add  A, A                                          ;; 0d:529a $87
    add  A, B                                          ;; 0d:529b $80
    ld   HL, data_0d_6540                              ;; 0d:529c $21 $40 $65
    rst  add_hl_a                                      ;; 0d:529f $c7
    ld   DE, wD933                                     ;; 0d:52a0 $11 $33 $d9
    ld   B, $03                                        ;; 0d:52a3 $06 $03
    call memcopySmall                                  ;; 0d:52a5 $cd $80 $00
    ld   B, C                                          ;; 0d:52a8 $41
    ld   DE, wD936                                     ;; 0d:52a9 $11 $36 $d9
    xor  A, A                                          ;; 0d:52ac $af
.jr_0d_52ad:
    ldh  [hFF90], A                                    ;; 0d:52ad $e0 $90
    add  A, A                                          ;; 0d:52af $87
    ld   HL, wD927                                     ;; 0d:52b0 $21 $27 $d9
    rst  add_hl_a                                      ;; 0d:52b3 $c7
    ld   C, [HL]                                       ;; 0d:52b4 $4e
    srl  C                                             ;; 0d:52b5 $cb $39
    ldh  A, [hFF90]                                    ;; 0d:52b7 $f0 $90
    ld   HL, wD933                                     ;; 0d:52b9 $21 $33 $d9
    rst  add_hl_a                                      ;; 0d:52bc $c7
    ld   A, [HL]                                       ;; 0d:52bd $7e
    sub  A, C                                          ;; 0d:52be $91
    ld   [DE], A                                       ;; 0d:52bf $12
    inc  DE                                            ;; 0d:52c0 $13
    ldh  A, [hFF90]                                    ;; 0d:52c1 $f0 $90
    inc  A                                             ;; 0d:52c3 $3c
    dec  B                                             ;; 0d:52c4 $05
    jr   NZ, .jr_0d_52ad                               ;; 0d:52c5 $20 $e6
    ld   A, [wD920]                                    ;; 0d:52c7 $fa $20 $d9
    ld   B, A                                          ;; 0d:52ca $47
    ld   DE, wD939                                     ;; 0d:52cb $11 $39 $d9
    ld   HL, wD921                                     ;; 0d:52ce $21 $21 $d9
.jr_0d_52d1:
    ld   A, [HL+]                                      ;; 0d:52d1 $2a
    inc  HL                                            ;; 0d:52d2 $23
    push HL                                            ;; 0d:52d3 $e5
    ld   HL, data_0d_6550                              ;; 0d:52d4 $21 $50 $65
    rst  add_hl_a                                      ;; 0d:52d7 $c7
    ld   A, [HL]                                       ;; 0d:52d8 $7e
    pop  HL                                            ;; 0d:52d9 $e1
    ld   [DE], A                                       ;; 0d:52da $12
    inc  DE                                            ;; 0d:52db $13
    dec  B                                             ;; 0d:52dc $05
    jr   NZ, .jr_0d_52d1                               ;; 0d:52dd $20 $f2
    ret                                                ;; 0d:52df $c9

call_0d_52e0:
    ld   A, [wD920]                                    ;; 0d:52e0 $fa $20 $d9
    ld   B, A                                          ;; 0d:52e3 $47
    ld   DE, wD927                                     ;; 0d:52e4 $11 $27 $d9
    ld   HL, wD921                                     ;; 0d:52e7 $21 $21 $d9
.jr_0d_52ea:
    ld   A, [HL+]                                      ;; 0d:52ea $2a
    inc  HL                                            ;; 0d:52eb $23
    push HL                                            ;; 0d:52ec $e5
    ld   HL, data_0d_6500                              ;; 0d:52ed $21 $00 $65
    rst  add_hl_a                                      ;; 0d:52f0 $c7
    ld   A, [HL]                                       ;; 0d:52f1 $7e
    and  A, $f0                                        ;; 0d:52f2 $e6 $f0
    swap A                                             ;; 0d:52f4 $cb $37
    ld   [DE], A                                       ;; 0d:52f6 $12
    inc  DE                                            ;; 0d:52f7 $13
    ld   A, [HL]                                       ;; 0d:52f8 $7e
    and  A, $0f                                        ;; 0d:52f9 $e6 $0f
    ld   [DE], A                                       ;; 0d:52fb $12
    inc  DE                                            ;; 0d:52fc $13
    pop  HL                                            ;; 0d:52fd $e1
    dec  B                                             ;; 0d:52fe $05
    jr   NZ, .jr_0d_52ea                               ;; 0d:52ff $20 $e9
    ret                                                ;; 0d:5301 $c9

jp_0d_5302:
    ldh  A, [hFF90]                                    ;; 0d:5302 $f0 $90
    add  A, A                                          ;; 0d:5304 $87
    ld   HL, wD921                                     ;; 0d:5305 $21 $21 $d9
    rst  add_hl_a                                      ;; 0d:5308 $c7
    ld   A, [HL]                                       ;; 0d:5309 $7e
    add  A, A                                          ;; 0d:530a $87
    add  A, [HL]                                       ;; 0d:530b $86
    ld   HL, data_0d_6510                              ;; 0d:530c $21 $10 $65
    rst  add_hl_a                                      ;; 0d:530f $c7
    ld   A, [HL+]                                      ;; 0d:5310 $2a
    push AF                                            ;; 0d:5311 $f5
    ld   C, [HL]                                       ;; 0d:5312 $4e
    inc  HL                                            ;; 0d:5313 $23
    ld   B, [HL]                                       ;; 0d:5314 $46
    ldh  A, [hFF90]                                    ;; 0d:5315 $f0 $90
    add  A, A                                          ;; 0d:5317 $87
    ld   HL, wD92E                                     ;; 0d:5318 $21 $2e $d9
    rst  add_hl_a                                      ;; 0d:531b $c7
    ld   D, [HL]                                       ;; 0d:531c $56
    ld   HL, wD922                                     ;; 0d:531d $21 $22 $d9
    rst  add_hl_a                                      ;; 0d:5320 $c7
    ld   H, [HL]                                       ;; 0d:5321 $66
    ld   L, D                                          ;; 0d:5322 $6a
    call call_00_0150                                  ;; 0d:5323 $cd $50 $01
    call mul_hl_16_add_bc                              ;; 0d:5326 $cd $5d $00
    ld   C, D                                          ;; 0d:5329 $4a
    ld   B, $00                                        ;; 0d:532a $06 $00
    sla  C                                             ;; 0d:532c $cb $21
    rl   B                                             ;; 0d:532e $cb $10
    sla  C                                             ;; 0d:5330 $cb $21
    rl   B                                             ;; 0d:5332 $cb $10
    sla  C                                             ;; 0d:5334 $cb $21
    rl   B                                             ;; 0d:5336 $cb $10
    sla  C                                             ;; 0d:5338 $cb $21
    rl   B                                             ;; 0d:533a $cb $10
    pop  AF                                            ;; 0d:533c $f1
    ret                                                ;; 0d:533d $c9

call_0d_533e:
    push AF                                            ;; 0d:533e $f5
    push BC                                            ;; 0d:533f $c5
    push DE                                            ;; 0d:5340 $d5
    push HL                                            ;; 0d:5341 $e5
    push AF                                            ;; 0d:5342 $f5
    call call_0d_60ce                                  ;; 0d:5343 $cd $ce $60
    pop  AF                                            ;; 0d:5346 $f1
    call call_0d_5350                                  ;; 0d:5347 $cd $50 $53
    call call_0d_60ce                                  ;; 0d:534a $cd $ce $60
    jp   pop_all                                       ;; 0d:534d $c3 $0b $00

call_0d_5350:
    and  A, $3f                                        ;; 0d:5350 $e6 $3f
    add  A, A                                          ;; 0d:5352 $87
    ld   HL, data_0d_5eb5                              ;; 0d:5353 $21 $b5 $5e
    rst  add_hl_a                                      ;; 0d:5356 $c7
    ld   A, [HL+]                                      ;; 0d:5357 $2a
    ld   H, [HL]                                       ;; 0d:5358 $66
    ld   L, A                                          ;; 0d:5359 $6f
    jp   HL                                            ;; 0d:535a $e9

data_0d_535b:
    ld   B, $02                                        ;; 0d:535b $06 $02
.jr_0d_535d:
    push BC                                            ;; 0d:535d $c5
    ld   HL, data_0d_5f03                              ;; 0d:535e $21 $03 $5f
    ld   BC, $84a                                      ;; 0d:5361 $01 $4a $08
    ld   E, $40                                        ;; 0d:5364 $1e $40
.jr_0d_5366:
    rst  waitForVBlank                                 ;; 0d:5366 $d7
    ld   A, E                                          ;; 0d:5367 $7b
    add  A, [HL]                                       ;; 0d:5368 $86
    inc  HL                                            ;; 0d:5369 $23
    ldh  [C], A                                        ;; 0d:536a $e2
    dec  B                                             ;; 0d:536b $05
    jr   NZ, .jr_0d_5366                               ;; 0d:536c $20 $f8
    pop  BC                                            ;; 0d:536e $c1
    dec  B                                             ;; 0d:536f $05
    jr   NZ, .jr_0d_535d                               ;; 0d:5370 $20 $eb
    rst  waitForVBlank                                 ;; 0d:5372 $d7
    ld   A, $40                                        ;; 0d:5373 $3e $40
    ldh  [rWY], A                                      ;; 0d:5375 $e0 $4a
    ret                                                ;; 0d:5377 $c9
    db   $cd, $dd, $53, $cd, $d3, $53, $5d, $54        ;; 0d:5378 ????????
    db   $21, $00, $99, $01, $40, $01, $cd, $ac        ;; 0d:5380 ????????
    db   $00, $cd, $46, $54, $cd, $ef, $53, $cd        ;; 0d:5388 ????????
    db   $ce, $53, $d7, $3e, $c3, $e0, $40, $18        ;; 0d:5390 ????????
    db   $64                                           ;; 0d:5398 ?

jp_0d_5399:
    call call_0d_53dd                                  ;; 0d:5399 $cd $dd $53
    ld   HL, $9800                                     ;; 0d:539c $21 $00 $98
    ld   DE, $9c00                                     ;; 0d:539f $11 $00 $9c
    ld   BC, $240                                      ;; 0d:53a2 $01 $40 $02
    call call_00_00ac                                  ;; 0d:53a5 $cd $ac $00
    call call_0d_53ef                                  ;; 0d:53a8 $cd $ef $53
    farcall2 call_0f_6086                              ;; 0d:53ab $cd $7d $01 $86 $60 $0f
    rst  waitForVBlank                                 ;; 0d:53b1 $d7
    ld   A, $c3                                        ;; 0d:53b2 $3e $c3
    ldh  [rLCDC], A                                    ;; 0d:53b4 $e0 $40
    ld   E, $00                                        ;; 0d:53b6 $1e $00
    call call_0d_5463                                  ;; 0d:53b8 $cd $63 $54
    call call_0d_542a                                  ;; 0d:53bb $cd $2a $54
    call call_0d_53fd                                  ;; 0d:53be $cd $fd $53
    ld   A, [wD98B]                                    ;; 0d:53c1 $fa $8b $d9
    cp   A, $02                                        ;; 0d:53c4 $fe $02
    ret  NZ                                            ;; 0d:53c6 $c0
    farcall2 call_0f_608f                              ;; 0d:53c7 $cd $7d $01 $8f $60 $0f
    ret                                                ;; 0d:53cd $c9
    db   $21, $00, $98, $18, $03, $21, $00, $9c        ;; 0d:53ce ????????
    db   $06, $00, $3e, $ff, $c3, $94, $00             ;; 0d:53d6 ???????

call_0d_53dd:
    ld   HL, $9c00                                     ;; 0d:53dd $21 $00 $9c
    ld   DE, $9900                                     ;; 0d:53e0 $11 $00 $99
    ld   BC, $140                                      ;; 0d:53e3 $01 $40 $01
    call call_00_00ac                                  ;; 0d:53e6 $cd $ac $00
    rst  waitForVBlank                                 ;; 0d:53e9 $d7
    ld   A, $c3                                        ;; 0d:53ea $3e $c3
    ldh  [rLCDC], A                                    ;; 0d:53ec $e0 $40
    ret                                                ;; 0d:53ee $c9

call_0d_53ef:
    rst  waitForVBlank                                 ;; 0d:53ef $d7
    ld   A, $e3                                        ;; 0d:53f0 $3e $e3
    ldh  [rLCDC], A                                    ;; 0d:53f2 $e0 $40
    ldh  A, [rWY]                                      ;; 0d:53f4 $f0 $4a
    ld   [wD97B], A                                    ;; 0d:53f6 $ea $7b $d9
    xor  A, A                                          ;; 0d:53f9 $af
    ldh  [rWY], A                                      ;; 0d:53fa $e0 $4a
    ret                                                ;; 0d:53fc $c9

call_0d_53fd:
    ld   HL, $9900                                     ;; 0d:53fd $21 $00 $99
    ld   DE, $9c00                                     ;; 0d:5400 $11 $00 $9c
    ld   BC, $140                                      ;; 0d:5403 $01 $40 $01
    call call_00_00ac                                  ;; 0d:5406 $cd $ac $00
    rst  waitForVBlank                                 ;; 0d:5409 $d7
    ld   A, $e3                                        ;; 0d:540a $3e $e3
    ldh  [rLCDC], A                                    ;; 0d:540c $e0 $40
    ld   A, [wD97B]                                    ;; 0d:540e $fa $7b $d9
    ldh  [rWY], A                                      ;; 0d:5411 $e0 $4a
    ld   HL, $9900                                     ;; 0d:5413 $21 $00 $99
    ld   BC, $140                                      ;; 0d:5416 $01 $40 $01
    ld   A, $ff                                        ;; 0d:5419 $3e $ff
    call call_00_009c                                  ;; 0d:541b $cd $9c $00
    ld   HL, $9d40                                     ;; 0d:541e $21 $40 $9d
    ld   BC, $80                                       ;; 0d:5421 $01 $80 $00
    jp   call_00_009c                                  ;; 0d:5424 $c3 $9c $00
    db   $cd, $46, $54                                 ;; 0d:5427 ???

call_0d_542a:
    ld   B, $03                                        ;; 0d:542a $06 $03
.jr_0d_542c:
    push BC                                            ;; 0d:542c $c5
    ld   A, B                                          ;; 0d:542d $78
    dec  A                                             ;; 0d:542e $3d
    ld   HL, data_0d_5f0f                              ;; 0d:542f $21 $0f $5f
    rst  add_hl_a                                      ;; 0d:5432 $c7
    ld   E, [HL]                                       ;; 0d:5433 $5e
    ld   D, $07                                        ;; 0d:5434 $16 $07
.jr_0d_5436:
    rst  waitForVBlank                                 ;; 0d:5436 $d7
    call call_0d_5463                                  ;; 0d:5437 $cd $63 $54
    dec  D                                             ;; 0d:543a $15
    jr   NZ, .jr_0d_5436                               ;; 0d:543b $20 $f9
    pop  BC                                            ;; 0d:543d $c1
    dec  B                                             ;; 0d:543e $05
    jr   NZ, .jr_0d_542c                               ;; 0d:543f $20 $eb
    xor  A, A                                          ;; 0d:5441 $af
    ld   [wD97A], A                                    ;; 0d:5442 $ea $7a $d9
    ret                                                ;; 0d:5445 $c9
    db   $06, $03, $c5, $78, $3d, $21, $0b, $5f        ;; 0d:5446 ????????
    db   $c7, $5e, $16, $07, $d7, $cd, $63, $54        ;; 0d:544e ????????
    db   $15, $20, $f9, $c1, $05, $20, $eb, $3e        ;; 0d:5456 ????????
    db   $01, $ea, $7a, $d9, $c9                       ;; 0d:545e ?????

call_0d_5463:
    ld   A, E                                          ;; 0d:5463 $7b
    ldh  [rBGP], A                                     ;; 0d:5464 $e0 $47
    ldh  [rOBP0], A                                    ;; 0d:5466 $e0 $48
    ldh  [rOBP1], A                                    ;; 0d:5468 $e0 $49
.jr_0d_546a:
    ldh  A, [rLY]                                      ;; 0d:546a $f0 $44
    cp   A, $40                                        ;; 0d:546c $fe $40
    jr   NZ, .jr_0d_546a                               ;; 0d:546e $20 $fa
    ld   A, [data_0d_5f0e]                             ;; 0d:5470 $fa $0e $5f
    ldh  [rBGP], A                                     ;; 0d:5473 $e0 $47
    ldh  [rOBP0], A                                    ;; 0d:5475 $e0 $48
    ldh  [rOBP1], A                                    ;; 0d:5477 $e0 $49
    ret                                                ;; 0d:5479 $c9
    db   $af, $e0, $90, $af, $e0, $91, $cd, $83        ;; 0d:547a ????????
    db   $54, $af, $e0, $92, $d7, $f0, $90, $e0        ;; 0d:5482 ????????
    db   $43, $d7, $af, $e0, $43, $d7, $f0, $90        ;; 0d:548a ????????
    db   $2f, $3c, $e0, $43, $f0, $92, $a7, $c0        ;; 0d:5492 ????????
    db   $f0, $91, $a7, $20, $12, $f0, $90, $c6        ;; 0d:549a ????????
    db   $01, $fe, $08, $38, $06, $3e, $01, $e0        ;; 0d:54a2 ????????
    db   $91, $3e, $08, $e0, $90, $18, $d5, $f0        ;; 0d:54aa ????????
    db   $90, $d6, $01, $30, $07, $3e, $ff, $e0        ;; 0d:54b2 ????????
    db   $92, $af, $e0, $91, $e0, $90, $18, $c4        ;; 0d:54ba ????????
    db   $06, $02, $c5, $21, $03, $5f, $01, $43        ;; 0d:54c2 ????????
    db   $08, $cd, $dd, $54, $0d, $cd, $dd, $54        ;; 0d:54ca ????????
    db   $c1, $05, $20, $ee, $d7, $af, $e0, $43        ;; 0d:54d2 ????????
    db   $e0, $42, $c9, $c5, $e5, $d7, $2a, $e2        ;; 0d:54da ????????
    db   $05, $20, $fa, $e1, $c1, $c9, $f5, $06        ;; 0d:54e2 ????????
    db   $02, $c5, $f0, $44, $fe, $91, $38, $fa        ;; 0d:54ea ????????
    db   $f0, $40, $cb, $bf, $e0, $40, $e0, $04        ;; 0d:54f2 ????????
    db   $f0, $04, $cb, $57, $28, $fa, $f0, $40        ;; 0d:54fa ????????
    db   $cb, $ff, $e0, $40, $06, $05, $d7, $05        ;; 0d:5502 ????????
    db   $20, $fc, $c1, $05, $20, $db, $f1, $c9        ;; 0d:550a ????????
    db   $c9, $fa, $f5, $cf, $fe, $09, $20, $15        ;; 0d:5512 ????????
    db   $af, $e0, $90, $21, $01, $d5, $84, $67        ;; 0d:551a ????????
    db   $7e, $a7, $c4, $33, $55, $f0, $90, $3c        ;; 0d:5522 ????????
    db   $fe, $03, $38, $ed, $c9, $d6, $05, $e0        ;; 0d:552a ????????
    db   $90, $f0, $90, $cd, $7d, $01, $95, $60        ;; 0d:5532 ????????
    db   $0f, $11, $e0, $ff, $19, $cd, $c3, $55        ;; 0d:553a ????????
    db   $5d, $54, $cd, $af, $55, $68, $26, $00        ;; 0d:5542 ????????
    db   $cd, $65, $00, $cd, $d3, $55, $3e, $07        ;; 0d:554a ????????
    db   $e0, $91, $3c, $e0, $92, $f0, $91, $a7        ;; 0d:5552 ????????
    db   $28, $1d, $cd, $7d, $01, $8c, $60, $0f        ;; 0d:555a ????????
    db   $cd, $bc, $55, $cd, $7d, $01, $89, $60        ;; 0d:5562 ????????
    db   $0f, $cd, $bc, $55, $11, $e0, $ff, $19        ;; 0d:556a ????????
    db   $cd, $c3, $55, $21, $91, $ff, $35, $f0        ;; 0d:5572 ????????
    db   $91, $fe, $05, $30, $20, $f0, $92, $a7        ;; 0d:557a ????????
    db   $28, $1b, $cd, $af, $55, $cd, $cc, $55        ;; 0d:5582 ????????
    db   $41, $3e, $ff, $d7, $cd, $6d, $00, $cd        ;; 0d:558a ????????
    db   $cc, $55, $11, $e0, $ff, $19, $cd, $d3        ;; 0d:5592 ????????
    db   $55, $21, $92, $ff, $35, $21, $91, $ff        ;; 0d:559a ????????
    db   $2a, $b6, $20, $b1, $f0, $90, $21, $86        ;; 0d:55a2 ????????
    db   $d9, $c7, $36, $01, $c9, $e5, $f0, $90        ;; 0d:55aa ????????
    db   $87, $21, $27, $d9, $c7, $4e, $23, $46        ;; 0d:55b2 ????????
    db   $e1, $c9, $21, $75, $d9, $2a, $66, $6f        ;; 0d:55ba ????????
    db   $c9, $7d, $ea, $75, $d9, $7c, $ea, $76        ;; 0d:55c2 ????????
    db   $d9, $c9, $21, $77, $d9, $2a, $66, $6f        ;; 0d:55ca ????????
    db   $c9, $7d, $ea, $77, $d9, $7c, $ea, $78        ;; 0d:55d2 ????????
    db   $d9, $c9, $fa, $f5, $cf, $fe, $09, $20        ;; 0d:55da ????????
    db   $11, $af, $e0, $90, $cd, $11, $56, $c4        ;; 0d:55e2 ????????
    db   $f8, $55, $f0, $90, $3c, $fe, $03, $38        ;; 0d:55ea ????????
    db   $f1, $c9, $d6, $05, $e0, $90, $cd, $55        ;; 0d:55f2 ????????
    db   $56, $06, $03, $c5, $cd, $7c, $56, $c5        ;; 0d:55fa ????????
    db   $cd, $1b, $56, $cd, $3c, $56, $c1, $0d        ;; 0d:5602 ????????
    db   $20, $f5, $c1, $05, $20, $ed, $c9, $f0        ;; 0d:560a ????????
    db   $90, $21, $01, $d5, $84, $67, $7e, $a7        ;; 0d:5612 ????????
    db   $c9, $cd, $7c, $56, $48, $21, $2e, $d9        ;; 0d:561a ????????
    db   $c7, $5e, $7b, $e0, $91, $f0, $90, $21        ;; 0d:5622 ????????
    db   $00, $c8, $84, $67, $57, $e5, $cd, $80        ;; 0d:562a ????????
    db   $00, $d1, $62, $69, $f0, $91, $47, $c3        ;; 0d:5632 ????????
    db   $80, $00, $cd, $6b, $56, $cd, $77, $01        ;; 0d:563a ????????
    db   $c5, $e5, $1a, $13, $22, $05, $20, $fa        ;; 0d:5642 ????????
    db   $e1, $c1, $3e, $20, $c7, $0d, $20, $f0        ;; 0d:564a ????????
    db   $c3, $7a, $01, $cd, $6b, $56, $cd, $77        ;; 0d:5652 ????????
    db   $01, $c5, $e5, $cd, $80, $00, $e1, $c1        ;; 0d:565a ????????
    db   $3e, $20, $c7, $0d, $20, $f3, $c3, $7a        ;; 0d:5662 ????????
    db   $01, $cd, $7c, $56, $f0, $90, $cd, $7d        ;; 0d:566a ????????
    db   $01, $95, $60, $0f, $11, $00, $c8, $82        ;; 0d:5672 ????????
    db   $57, $c9, $f0, $90, $87, $21, $27, $d9        ;; 0d:567a ????????
    db   $c7, $46, $23, $4e, $c9, $fa, $f5, $cf        ;; 0d:5682 ????????
    db   $fe, $09, $28, $0d, $21, $01, $d0, $84        ;; 0d:568a ????????
    db   $67, $36, $00, $cd, $7d, $01, $83, $60        ;; 0d:5692 ????????
    db   $0f, $c9, $16, $0f, $d7, $f0, $44, $fe        ;; 0d:569a ????????
    db   $2f, $20, $fa, $af, $e0, $47, $e0, $48        ;; 0d:56a2 ????????
    db   $e0, $49, $f0, $44, $fe, $31, $20, $fa        ;; 0d:56aa ????????
    db   $3e, $d2, $e0, $47, $e0, $48, $3e, $16        ;; 0d:56b2 ????????
    db   $e0, $49, $15, $20, $e0, $c9, $c9, $06        ;; 0d:56ba ????????
    db   $10, $21, $00, $71, $cd, $be, $60, $cd        ;; 0d:56c2 ????????
    db   $3e, $60, $21, $c8, $c8, $06, $28, $3e        ;; 0d:56ca ????????
    db   $0c, $cd, $6d, $00, $21, $a0, $c8, $06        ;; 0d:56d2 ????????
    db   $28, $3e, $ff, $cd, $6d, $00, $06, $14        ;; 0d:56da ????????
    db   $11, $01, $40, $cd, $89, $5e, $21, $92        ;; 0d:56e2 ????????
    db   $c9, $36, $06, $23, $36, $07, $21, $94        ;; 0d:56ea ????????
    db   $c9, $36, $14, $23, $36, $28, $c3, $bc        ;; 0d:56f2 ????????
    db   $5f, $f0, $90, $87, $21, $51, $c8, $c7        ;; 0d:56fa ????????
    db   $7e, $c6, $0c, $fe, $39, $30, $02, $77        ;; 0d:5702 ????????
    db   $c9, $21, $95, $c9, $7e, $a7, $ca, $4e        ;; 0d:570a ????????
    db   $60, $35, $f0, $90, $21, $00, $c8, $c7        ;; 0d:5712 ????????
    db   $36, $01, $21, $a0, $c8, $c7, $36, $ff        ;; 0d:571a ????????
    db   $c9, $06, $01, $cd, $d3, $60, $af, $e0        ;; 0d:5722 ????????
    db   $91, $21, $00, $c8, $c7, $34, $35, $20        ;; 0d:572a ????????
    db   $20, $21, $a0, $c8, $c7, $34, $7e, $a7        ;; 0d:5732 ????????
    db   $20, $17, $3e, $33, $11, $00, $13, $cd        ;; 0d:573a ????????
    db   $6b, $01, $87, $87, $87, $4f, $f0, $91        ;; 0d:5742 ????????
    db   $87, $21, $50, $c8, $c7, $71, $23, $36        ;; 0d:574a ????????
    db   $00, $fa, $94, $c9, $47, $f0, $91, $3c        ;; 0d:5752 ????????
    db   $b8, $da, $29, $57, $d7, $c9, $cd, $ce        ;; 0d:575a ????????
    db   $58, $06, $50, $21, $e0, $64, $cd, $be        ;; 0d:5762 ????????
    db   $60, $06, $10, $21, $f0, $65, $cd, $c1        ;; 0d:576a ????????
    db   $60, $cd, $3e, $60, $cd, $cb, $57, $f0        ;; 0d:5772 ????????
    db   $91, $4f, $fe, $03, $20, $05, $3e, $20        ;; 0d:577a ????????
    db   $ea, $53, $c8, $79, $21, $28, $c8, $c7        ;; 0d:5782 ????????
    db   $fe, $03, $28, $06, $36, $ff, $23, $3c        ;; 0d:578a ????????
    db   $18, $f6, $21, $c8, $c8, $11, $00, $c8        ;; 0d:5792 ????????
    db   $06, $03, $36, $05, $23, $af, $12, $13        ;; 0d:579a ????????
    db   $05, $20, $f7, $21, $92, $c9, $36, $09        ;; 0d:57a2 ????????
    db   $23, $36, $0a, $3e, $03, $ea, $94, $c9        ;; 0d:57aa ????????
    db   $c3, $bc, $5f, $f0, $90, $21, $41, $c9        ;; 0d:57b2 ????????
    db   $87, $c7, $7e, $d6, $03, $fe, $70, $da        ;; 0d:57ba ????????
    db   $4e, $60, $77, $c9, $06, $02, $c3, $d3        ;; 0d:57c2 ????????
    db   $60, $af, $e0, $91, $cd, $51, $52, $20        ;; 0d:57ca ????????
    db   $03, $3c, $18, $f8, $e0, $90, $21, $33        ;; 0d:57d2 ????????
    db   $d9, $c7, $4e, $f0, $91, $87, $21, $50        ;; 0d:57da ????????
    db   $c8, $c7, $79, $d6, $02, $87, $87, $87        ;; 0d:57e2 ????????
    db   $22, $36, $10, $21, $91, $ff, $34, $f0        ;; 0d:57ea ????????
    db   $90, $fe, $02, $d0, $3c, $cd, $51, $52        ;; 0d:57f2 ????????
    db   $20, $da, $fe, $02, $38, $f6, $c9, $cd        ;; 0d:57fa ????????
    db   $ce, $58, $06, $30, $21, $b0, $64, $cd        ;; 0d:5802 ????????
    db   $be, $60, $21, $13, $5f, $cd, $31, $60        ;; 0d:580a ????????
    db   $21, $50, $c8, $11, $1d, $5f, $06, $0a        ;; 0d:5812 ????????
    db   $1a, $13, $22, $36, $30, $23, $05, $20        ;; 0d:581a ????????
    db   $f7, $21, $c8, $c8, $01, $00, $0a, $79        ;; 0d:5822 ????????
    db   $e6, $01, $c6, $03, $22, $0c, $05, $20        ;; 0d:582a ????????
    db   $f6, $21, $a0, $c8, $06, $0a, $af, $22        ;; 0d:5832 ????????
    db   $ee, $01, $05, $20, $fa, $af, $e0, $91        ;; 0d:583a ????????
    db   $21, $92, $c9, $36, $01, $23, $36, $02        ;; 0d:5842 ????????
    db   $3e, $06, $ea, $94, $c9, $c3, $bc, $5f        ;; 0d:584a ????????
    db   $f0, $90, $21, $a0, $c8, $c7, $7e, $a7        ;; 0d:5852 ????????
    db   $20, $27, $f0, $90, $21, $51, $c8, $87        ;; 0d:585a ????????
    db   $c7, $7e, $d6, $04, $da, $4e, $60, $77        ;; 0d:5862 ????????
    db   $f0, $90, $87, $21, $40, $c9, $c7, $7e        ;; 0d:586a ????????
    db   $c6, $02, $77, $fe, $89, $d8, $36, $88        ;; 0d:5872 ????????
    db   $f0, $90, $21, $a0, $c8, $c7, $36, $01        ;; 0d:587a ????????
    db   $c9, $f0, $90, $21, $51, $c8, $87, $c7        ;; 0d:5882 ????????
    db   $7e, $d6, $04, $da, $4e, $60, $77, $f0        ;; 0d:588a ????????
    db   $90, $87, $21, $40, $c9, $c7, $7e, $d6        ;; 0d:5892 ????????
    db   $02, $77, $fe, $78, $d0, $36, $78, $f0        ;; 0d:589a ????????
    db   $90, $21, $a0, $c8, $c7, $36, $00, $c9        ;; 0d:58a2 ????????
    db   $06, $02, $cd, $d3, $60, $21, $91, $ff        ;; 0d:58aa ????????
    db   $34, $f0, $91, $e6, $04, $20, $14, $06        ;; 0d:58b2 ????????
    db   $0a, $21, $c8, $c8, $7e, $fe, $04, $30        ;; 0d:58ba ????????
    db   $04, $3e, $04, $18, $02, $3e, $03, $22        ;; 0d:58c2 ????????
    db   $05, $20, $f1, $c9, $21, $a0, $6e, $06        ;; 0d:58ca ????????
    db   $40, $cd, $be, $60, $21, $27, $5f, $cd        ;; 0d:58d2 ????????
    db   $31, $60, $21, $50, $c8, $11, $3b, $5f        ;; 0d:58da ????????
    db   $06, $14, $1a, $13, $22, $05, $20, $fa        ;; 0d:58e2 ????????
    db   $21, $c8, $c8, $01, $00, $0a, $79, $e6        ;; 0d:58ea ????????
    db   $01, $c6, $06, $22, $0c, $05, $20, $f6        ;; 0d:58f2 ????????
    db   $21, $a0, $c8, $06, $0a, $af, $ee, $01        ;; 0d:58fa ????????
    db   $22, $05, $20, $fa, $21, $92, $c9, $36        ;; 0d:5902 ????????
    db   $03, $23, $36, $04, $21, $94, $c9, $36        ;; 0d:590a ????????
    db   $0a, $23, $36, $14, $c3, $bc, $5f, $f0        ;; 0d:5912 ????????
    db   $90, $21, $50, $c8, $87, $c7, $7e, $c6        ;; 0d:591a ????????
    db   $06, $77, $fe, $91, $d2, $4e, $60, $f0        ;; 0d:5922 ????????
    db   $90, $21, $a0, $c8, $c7, $7e, $a7, $20        ;; 0d:592a ????????
    db   $17, $f0, $90, $21, $41, $c9, $87, $c7        ;; 0d:5932 ????????
    db   $34, $7e, $fe, $88, $d8, $36, $88, $f0        ;; 0d:593a ????????
    db   $90, $21, $a0, $c8, $c7, $36, $01, $c9        ;; 0d:5942 ????????
    db   $f0, $90, $21, $41, $c9, $87, $c7, $35        ;; 0d:594a ????????
    db   $7e, $fe, $78, $d0, $36, $78, $f0, $90        ;; 0d:5952 ????????
    db   $21, $a0, $c8, $c7, $36, $00, $c9, $06        ;; 0d:595a ????????
    db   $02, $cd, $d3, $60, $21, $95, $c9, $35        ;; 0d:5962 ????????
    db   $c0, $21, $28, $c8, $06, $28, $3e, $ff        ;; 0d:596a ????????
    db   $c3, $6d, $00, $21, $a0, $73, $06, $40        ;; 0d:5972 ????????
    db   $cd, $be, $60, $cd, $3e, $60, $21, $00        ;; 0d:597a ????????
    db   $c8, $06, $0a, $3e, $32, $11, $01, $05        ;; 0d:5982 ????????
    db   $cd, $6b, $01, $22, $05, $20, $f4, $21        ;; 0d:598a ????????
    db   $a0, $c8, $06, $28, $3e, $ff, $cd, $6d        ;; 0d:5992 ????????
    db   $00, $21, $92, $c9, $36, $00, $23, $36        ;; 0d:599a ????????
    db   $0b, $21, $94, $c9, $36, $05, $23, $36        ;; 0d:59a2 ????????
    db   $0a, $c3, $bc, $5f, $06, $04, $cd, $d3        ;; 0d:59aa ????????
    db   $60, $af, $e0, $91, $21, $00, $c8, $c7        ;; 0d:59b2 ????????
    db   $34, $35, $20, $46, $21, $a0, $c8, $c7        ;; 0d:59ba ????????
    db   $34, $7e, $a7, $28, $1e, $36, $ff, $f0        ;; 0d:59c2 ????????
    db   $91, $21, $00, $c8, $c7, $36, $01, $21        ;; 0d:59ca ????????
    db   $95, $c9, $7e, $a7, $28, $03, $35, $20        ;; 0d:59d2 ????????
    db   $29, $f0, $91, $21, $28, $c8, $c7, $36        ;; 0d:59da ????????
    db   $ff, $18, $1f, $3e, $30, $11, $00, $04        ;; 0d:59e2 ????????
    db   $cd, $6b, $01, $cd, $4c, $00, $4f, $f0        ;; 0d:59ea ????????
    db   $91, $87, $21, $50, $c8, $c7, $71, $23        ;; 0d:59f2 ????????
    db   $36, $00, $f0, $91, $21, $c8, $c8, $c7        ;; 0d:59fa ????????
    db   $36, $06, $fa, $94, $c9, $47, $f0, $91        ;; 0d:5a02 ????????
    db   $3c, $b8, $da, $b4, $59, $c9, $3e, $08        ;; 0d:5a0a ????????
    db   $e0, $90, $3e, $01, $e0, $92, $18, $08        ;; 0d:5a12 ????????
    db   $3e, $10, $e0, $90, $3e, $02, $e0, $92        ;; 0d:5a1a ????????
    db   $cd, $fe, $5c, $cd, $3e, $60, $21, $00        ;; 0d:5a22 ????????
    db   $c8, $06, $03, $3e, $01, $22, $3c, $05        ;; 0d:5a2a ????????
    db   $20, $fb, $21, $a0, $c8, $06, $28, $3e        ;; 0d:5a32 ????????
    db   $ff, $cd, $6d, $00, $21, $92, $c9, $36        ;; 0d:5a3a ????????
    db   $00, $23, $36, $05, $21, $94, $c9, $36        ;; 0d:5a42 ????????
    db   $03, $23, $f0, $90, $77, $c3, $bc, $5f        ;; 0d:5a4a ????????
    db   $f0, $92, $47, $cd, $d3, $60, $af, $e0        ;; 0d:5a52 ????????
    db   $91, $21, $00, $c8, $c7, $34, $35, $20        ;; 0d:5a5a ????????
    db   $59, $21, $a0, $c8, $c7, $34, $7e, $fe        ;; 0d:5a62 ????????
    db   $03, $38, $1e, $36, $ff, $f0, $91, $21        ;; 0d:5a6a ????????
    db   $00, $c8, $c7, $36, $01, $21, $95, $c9        ;; 0d:5a72 ????????
    db   $7e, $a7, $28, $03, $35, $20, $3b, $f0        ;; 0d:5a7a ????????
    db   $91, $21, $28, $c8, $c7, $36, $ff, $18        ;; 0d:5a82 ????????
    db   $31, $a7, $20, $22, $3e, $30, $11, $00        ;; 0d:5a8a ????????
    db   $10, $cd, $6b, $01, $87, $87, $87, $4f        ;; 0d:5a92 ????????
    db   $3e, $31, $11, $00, $04, $cd, $6b, $01        ;; 0d:5a9a ????????
    db   $87, $87, $87, $47, $f0, $91, $87, $21        ;; 0d:5aa2 ????????
    db   $50, $c8, $c7, $71, $23, $70, $f0, $91        ;; 0d:5aaa ????????
    db   $21, $a0, $c8, $c7, $4e, $21, $c8, $c8        ;; 0d:5ab2 ????????
    db   $c7, $71, $fa, $94, $c9, $47, $f0, $91        ;; 0d:5aba ????????
    db   $3c, $b8, $da, $59, $5a, $c9, $cd, $ce        ;; 0d:5ac2 ????????
    db   $5a, $c3, $78, $53, $21, $30, $79, $06        ;; 0d:5aca ????????
    db   $20, $cd, $be, $60, $cd, $3e, $60, $21        ;; 0d:5ad2 ????????
    db   $a0, $c8, $06, $28, $3e, $ff, $cd, $6d        ;; 0d:5ada ????????
    db   $00, $06, $28, $11, $01, $10, $cd, $89        ;; 0d:5ae2 ????????
    db   $5e, $21, $92, $c9, $36, $00, $23, $36        ;; 0d:5aea ????????
    db   $0e, $3e, $28, $ea, $94, $c9, $c3, $bc        ;; 0d:5af2 ????????
    db   $5f, $d7, $3e, $cc, $df, $af, $e0, $91        ;; 0d:5afa ????????
    db   $21, $00, $c8, $c7, $34, $35, $c2, $7a        ;; 0d:5b02 ????????
    db   $5b, $f0, $91, $21, $a0, $c8, $c7, $34        ;; 0d:5b0a ????????
    db   $7e, $a7, $20, $20, $3e, $30, $11, $00        ;; 0d:5b12 ????????
    db   $ff, $cd, $6b, $01, $21, $f0, $c8, $47        ;; 0d:5b1a ????????
    db   $f0, $91, $c7, $70, $3e, $31, $11, $10        ;; 0d:5b22 ????????
    db   $40, $cd, $6b, $01, $21, $18, $c9, $47        ;; 0d:5b2a ????????
    db   $f0, $91, $c7, $70, $f0, $91, $21, $f0        ;; 0d:5b32 ????????
    db   $c8, $c7, $5e, $21, $18, $c9, $c7, $56        ;; 0d:5b3a ????????
    db   $01, $4c, $1c, $cd, $61, $5f, $f0, $91        ;; 0d:5b42 ????????
    db   $87, $21, $50, $c8, $c7, $71, $23, $70        ;; 0d:5b4a ????????
    db   $f0, $91, $21, $a0, $c8, $c7, $4e, $21        ;; 0d:5b52 ????????
    db   $c8, $c8, $c7, $79, $e6, $01, $c6, $08        ;; 0d:5b5a ????????
    db   $77, $f0, $91, $21, $18, $c9, $c7, $7e        ;; 0d:5b62 ????????
    db   $d6, $08, $30, $0b, $e5, $f0, $91, $21        ;; 0d:5b6a ????????
    db   $28, $c8, $c7, $36, $ff, $e1, $af, $77        ;; 0d:5b72 ????????
    db   $fa, $94, $c9, $47, $f0, $91, $3c, $b8        ;; 0d:5b7a ????????
    db   $da, $00, $5b, $c9, $21, $20, $64, $06        ;; 0d:5b82 ????????
    db   $20, $cd, $be, $60, $cd, $3e, $60, $21        ;; 0d:5b8a ????????
    db   $00, $c8, $06, $0a, $3e, $32, $11, $01        ;; 0d:5b92 ????????
    db   $04, $cd, $6b, $01, $22, $05, $20, $f4        ;; 0d:5b9a ????????
    db   $21, $a0, $c8, $06, $28, $3e, $ff, $cd        ;; 0d:5ba2 ????????
    db   $6d, $00, $21, $92, $c9, $36, $00, $23        ;; 0d:5baa ????????
    db   $36, $08, $21, $94, $c9, $36, $0a, $23        ;; 0d:5bb2 ????????
    db   $36, $0a, $c3, $bc, $5f, $06, $04, $cd        ;; 0d:5bba ????????
    db   $d3, $60, $af, $e0, $91, $21, $00, $c8        ;; 0d:5bc2 ????????
    db   $c7, $34, $35, $20, $5c, $21, $a0, $c8        ;; 0d:5bca ????????
    db   $c7, $34, $7e, $fe, $02, $38, $1e, $36        ;; 0d:5bd2 ????????
    db   $ff, $f0, $91, $21, $00, $c8, $c7, $36        ;; 0d:5bda ????????
    db   $01, $21, $95, $c9, $7e, $a7, $28, $03        ;; 0d:5be2 ????????
    db   $35, $20, $3e, $f0, $91, $21, $28, $c8        ;; 0d:5bea ????????
    db   $c7, $36, $ff, $18, $34, $a7, $20, $22        ;; 0d:5bf2 ????????
    db   $3e, $30, $11, $00, $12, $cd, $6b, $01        ;; 0d:5bfa ????????
    db   $87, $87, $87, $4f, $3e, $31, $11, $00        ;; 0d:5c02 ????????
    db   $06, $cd, $6b, $01, $87, $87, $87, $47        ;; 0d:5c0a ????????
    db   $f0, $91, $87, $21, $50, $c8, $c7, $71        ;; 0d:5c12 ????????
    db   $23, $70, $f0, $91, $21, $a0, $c8, $c7        ;; 0d:5c1a ????????
    db   $4e, $21, $c8, $c8, $c7, $79, $c6, $0a        ;; 0d:5c22 ????????
    db   $77, $fa, $94, $c9, $47, $f0, $91, $3c        ;; 0d:5c2a ????????
    db   $b8, $da, $c5, $5b, $c9, $c9, $01, $28        ;; 0d:5c32 ????????
    db   $00, $cd, $0e, $5d, $01, $38, $10, $3e        ;; 0d:5c3a ????????
    db   $11, $e0, $90, $3e, $0d, $e0, $91, $af        ;; 0d:5c42 ????????
    db   $e0, $92, $18, $43, $01, $60, $18, $cd        ;; 0d:5c4a ????????
    db   $0e, $5d, $01, $68, $28, $3e, $11, $e0        ;; 0d:5c52 ????????
    db   $90, $3e, $0e, $e0, $91, $3e, $01, $e0        ;; 0d:5c5a ????????
    db   $92, $18, $2c, $01, $30, $20, $cd, $0e        ;; 0d:5c62 ????????
    db   $5d, $01, $40, $30, $3e, $09, $e0, $90        ;; 0d:5c6a ????????
    db   $3e, $0f, $e0, $91, $3e, $02, $e0, $92        ;; 0d:5c72 ????????
    db   $18, $15, $01, $60, $08, $cd, $0e, $5d        ;; 0d:5c7a ????????
    db   $01, $68, $10, $3e, $09, $e0, $90, $3e        ;; 0d:5c82 ????????
    db   $10, $e0, $91, $3e, $03, $e0, $92, $c5        ;; 0d:5c8a ????????
    db   $06, $30, $21, $40, $7f, $cd, $be, $60        ;; 0d:5c92 ????????
    db   $c1, $f0, $90, $21, $00, $cc, $cd, $6b        ;; 0d:5c9a ????????
    db   $60, $c5, $cd, $f9, $5c, $c1, $1e, $05        ;; 0d:5ca2 ????????
    db   $f0, $92, $a7, $28, $1c, $3d, $28, $0f        ;; 0d:5caa ????????
    db   $3d, $28, $06, $79, $d6, $08, $4f, $18        ;; 0d:5cb2 ????????
    db   $14, $79, $c6, $08, $4f, $18, $04, $79        ;; 0d:5cba ????????
    db   $d6, $08, $4f, $78, $d6, $08, $47, $18        ;; 0d:5cc2 ????????
    db   $08, $79, $c6, $08, $4f, $78, $c6, $08        ;; 0d:5cca ????????
    db   $47, $f0, $91, $cd, $68, $60, $c5, $cd        ;; 0d:5cd2 ????????
    db   $f9, $5c, $c1, $1d, $20, $ca, $21, $00        ;; 0d:5cda ????????
    db   $cc, $06, $04, $cd, $6c, $00, $cd, $f9        ;; 0d:5ce2 ????????
    db   $5c, $1e, $05, $06, $0c, $cd, $6c, $00        ;; 0d:5cea ????????
    db   $cd, $f9, $5c, $1d, $20, $f5, $c9, $06        ;; 0d:5cf2 ????????
    db   $01, $c3, $d3, $60, $21, $30, $63, $06        ;; 0d:5cfa ????????
    db   $90, $cd, $be, $60, $21, $40, $64, $06        ;; 0d:5d02 ????????
    db   $60, $c3, $c1, $60, $21, $90, $ff, $71        ;; 0d:5d0a ????????
    db   $23, $70, $cd, $fe, $5c, $3e, $00, $cd        ;; 0d:5d12 ????????
    db   $23, $5d, $3e, $15, $cd, $23, $5d, $3e        ;; 0d:5d1a ????????
    db   $01, $21, $90, $ff, $4e, $23, $46, $21        ;; 0d:5d22 ????????
    db   $00, $cc, $cd, $82, $60, $06, $04, $cd        ;; 0d:5d2a ????????
    db   $d3, $60, $21, $00, $cc, $06, $a0, $c3        ;; 0d:5d32 ????????
    db   $6d, $00, $21, $00, $93, $11, $8c, $d9        ;; 0d:5d3a ????????
    db   $cd, $77, $01, $cd, $38, $5e, $cd, $38        ;; 0d:5d42 ????????
    db   $5e, $cd, $38, $5e, $cd, $7a, $01, $21        ;; 0d:5d4a ????????
    db   $20, $7d, $06, $04, $c5, $cd, $20, $5e        ;; 0d:5d52 ????????
    db   $06, $0f, $cd, $d3, $60, $c1, $05, $20        ;; 0d:5d5a ????????
    db   $f3, $06, $60, $21, $a0, $7e, $cd, $be        ;; 0d:5d62 ????????
    db   $60, $06, $03, $c5, $cd, $48, $5e, $06        ;; 0d:5d6a ????????
    db   $04, $cd, $d3, $60, $21, $00, $cc, $06        ;; 0d:5d72 ????????
    db   $a0, $cd, $6c, $00, $06, $04, $cd, $d3        ;; 0d:5d7a ????????
    db   $60, $c1, $05, $20, $e6, $06, $90, $21        ;; 0d:5d82 ????????
    db   $90, $7c, $cd, $be, $60, $cd, $3e, $60        ;; 0d:5d8a ????????
    db   $21, $50, $c8, $06, $04, $36, $44, $23        ;; 0d:5d92 ????????
    db   $36, $14, $23, $05, $20, $f7, $21, $c8        ;; 0d:5d9a ????????
    db   $c8, $01, $00, $04, $79, $e6, $01, $c6        ;; 0d:5da2 ????????
    db   $13, $22, $0c, $05, $20, $f6, $21, $a0        ;; 0d:5daa ????????
    db   $c8, $af, $06, $04, $22, $c6, $40, $05        ;; 0d:5db2 ????????
    db   $20, $fa, $af, $e0, $91, $21, $92, $c9        ;; 0d:5dba ????????
    db   $36, $0c, $23, $36, $0d, $3e, $04, $ea        ;; 0d:5dc2 ????????
    db   $94, $c9, $3e, $26, $e0, $b2, $c3, $bc        ;; 0d:5dca ????????
    db   $5f, $f0, $90, $21, $a0, $c8, $c7, $5e        ;; 0d:5dd2 ????????
    db   $f0, $91, $57, $01, $44, $14, $cd, $61        ;; 0d:5dda ????????
    db   $5f, $f0, $90, $21, $a0, $c8, $c7, $7e        ;; 0d:5de2 ????????
    db   $c6, $10, $77, $f0, $90, $87, $21, $50        ;; 0d:5dea ????????
    db   $c8, $c7, $71, $23, $70, $f0, $90, $21        ;; 0d:5df2 ????????
    db   $c8, $c8, $c7, $06, $13, $7e, $b8, $78        ;; 0d:5dfa ????????
    db   $20, $02, $78, $3c, $77, $c9, $06, $02        ;; 0d:5e02 ????????
    db   $cd, $d3, $60, $f0, $91, $c6, $01, $e0        ;; 0d:5e0a ????????
    db   $91, $fe, $28, $d8, $21, $28, $c8, $06        ;; 0d:5e12 ????????
    db   $04, $3e, $ff, $c3, $6d, $00, $cd, $77        ;; 0d:5e1a ????????
    db   $01, $11, $00, $93, $cd, $41, $5e, $11        ;; 0d:5e22 ????????
    db   $e0, $93, $cd, $41, $5e, $11, $c0, $94        ;; 0d:5e2a ????????
    db   $cd, $41, $5e, $c3, $7a, $01, $06, $20        ;; 0d:5e32 ????????
    db   $cd, $80, $00, $3e, $c0, $c7, $c9, $06        ;; 0d:5e3a ????????
    db   $20, $3e, $04, $c3, $b5, $00, $3e, $12        ;; 0d:5e42 ????????
    db   $01, $48, $18, $21, $00, $cc, $c3, $82        ;; 0d:5e4a ????????
    db   $60, $01, $00, $04, $c5, $21, $fb, $5e        ;; 0d:5e52 ????????
    db   $79, $87, $c7, $2a, $66, $6f, $cd, $20        ;; 0d:5e5a ????????
    db   $5e, $06, $0f, $cd, $d3, $60, $c1, $0c        ;; 0d:5e62 ????????
    db   $05, $20, $e9, $c9, $01, $33, $00, $18        ;; 0d:5e6a ????????
    db   $08, $01, $34, $01, $18, $03, $01, $35        ;; 0d:5e72 ????????
    db   $01, $cd, $7d, $01, $2a, $50, $01, $c9        ;; 0d:5e7a ????????
    db   $cd, $7d, $01, $30, $50, $01, $c9, $21        ;; 0d:5e82 ????????
    db   $00, $c8, $3e, $32, $cd, $6b, $01, $22        ;; 0d:5e8a ????????
    db   $05, $20, $f7, $c9, $b4, $5e, $52, $58        ;; 0d:5e92 ????????
    db   $aa, $58, $19, $59, $61, $59, $52, $5a        ;; 0d:5e9a ????????
    db   $fb, $56, $23, $57, $bf, $5b, $b5, $57        ;; 0d:5ea2 ????????
    db   $c6, $57, $ae, $59, $d3, $5d, $08, $5e        ;; 0d:5eaa ????????
    db   $fb, $5a, $c9                                 ;; 0d:5eb2 ???

data_0d_5eb5:
    dw   data_0d_535b                                  ;; 0d:5eb5 pP
    db   $78, $53, $27, $54, $c2, $54, $e8, $54        ;; 0d:5eb7 ????????
    db   $12, $55, $13, $55, $dc, $55, $87, $56        ;; 0d:5ebf ????????
    db   $9c, $56, $c0, $56, $c1, $56, $60, $57        ;; 0d:5ec7 ????????
    db   $75, $59, $1a, $5a, $c8, $5a, $86, $5b        ;; 0d:5ecf ????????
    db   $01, $58, $7a, $54, $10, $5a, $37, $5c        ;; 0d:5ed7 ????????
    db   $38, $5c, $4e, $5c, $65, $5c, $7c, $5c        ;; 0d:5edf ????????
    db   $3c, $5d, $53, $5e, $6e, $5e, $87, $5d        ;; 0d:5ee7 ????????
    db   $b4, $5e, $6e, $5e, $73, $5e, $78, $5e        ;; 0d:5eef ????????
    db   $ce, $58, $82, $5e, $e0, $7d, $80, $7d        ;; 0d:5ef7 ????????
    db   $20, $7d, $8c, $d9                            ;; 0d:5eff ????

data_0d_5f03:
    db   $02, $04, $08, $10, $f0, $f8, $fc, $fe        ;; 0d:5f03 ????????
    db   $00, $40, $81                                 ;; 0d:5f0b ???

data_0d_5f0e:
    db   $d2                                           ;; 0d:5f0e ?

data_0d_5f0f:
    db   $d2, $81, $40, $00, $01, $0a, $03, $0c        ;; 0d:5f0f ????????
    db   $01, $05, $05, $0f, $19, $08, $10, $30        ;; 0d:5f17 ????????
    db   $48, $70, $88, $10, $30, $48, $70, $88        ;; 0d:5f1f ????????
    db   $01, $01, $01, $01, $01, $01, $01, $01        ;; 0d:5f27 ????????
    db   $08, $10, $02, $01, $00, $01, $02, $01        ;; 0d:5f2f ????????
    db   $01, $00, $00, $01, $08, $20, $18, $10        ;; 0d:5f37 ????????
    db   $30, $28, $38, $08, $50, $18, $68, $28        ;; 0d:5f3f ????????
    db   $70, $08, $80, $20, $00, $08, $00, $28        ;; 0d:5f47 ????????
    db   $08, $00, $28, $00, $48, $00, $68, $00        ;; 0d:5f4f ????????
    db   $88, $00, $18, $10, $38, $10, $58, $10        ;; 0d:5f57 ????????
    db   $78, $10, $f5, $d5, $e5, $7b, $c6, $40        ;; 0d:5f5f ????????
    db   $cd, $78, $5f, $81, $f5, $7b, $cd, $78        ;; 0d:5f67 ????????
    db   $5f, $80, $47, $f1, $4f, $e1, $d1, $f1        ;; 0d:5f6f ????????
    db   $c9, $6f, $26, $41, $3e, $0f, $cd, $d2        ;; 0d:5f77 ????????
    db   $00, $f5, $cb, $7f, $28, $02, $2f, $3c        ;; 0d:5f7f ????????
    db   $6f, $62, $cd, $50, $01, $3e, $7f, $cd        ;; 0d:5f87 ????????
    db   $9b, $5f, $f1, $07, $30, $04, $7d, $2f        ;; 0d:5f8f ????????
    db   $3c, $6f, $7d, $c9, $c5, $d5, $5f, $2f        ;; 0d:5f97 ????????
    db   $57, $14, $af, $06, $10, $cb, $25, $cb        ;; 0d:5f9f ????????
    db   $14, $17, $82, $38, $02, $83, $2c, $05        ;; 0d:5fa7 ????????
    db   $20, $f3, $47, $7d, $2f, $6f, $7c, $2f        ;; 0d:5faf ????????
    db   $67, $78, $d1, $c1, $c9, $cd, $c6, $60        ;; 0d:5fb7 ????????
    db   $21, $00, $cc, $cd, $6e, $60, $af, $e0        ;; 0d:5fbf ????????
    db   $90, $21, $00, $c8, $c7, $34, $35, $20        ;; 0d:5fc7 ????????
    db   $33, $21, $28, $c8, $c7, $34, $35, $20        ;; 0d:5fcf ????????
    db   $2b, $f0, $90, $87, $21, $50, $c8, $c7        ;; 0d:5fd7 ????????
    db   $4e, $23, $46, $f0, $90, $87, $21, $40        ;; 0d:5fdf ????????
    db   $c9, $c7, $2a, $d6, $80, $81, $4f, $7e        ;; 0d:5fe7 ????????
    db   $d6, $80, $80, $47, $f0, $90, $21, $c8        ;; 0d:5fef ????????
    db   $c8, $c7, $7e, $cd, $68, $60, $fa, $92        ;; 0d:5ff7 ????????
    db   $c9                                           ;; 0d:5fff ?

data_0d_6000:
    db   $cd, $28, $60, $f0, $90, $21, $00, $c8        ;; 0d:6000 ????????
    db   $c7, $7e, $a7, $28, $01, $35, $fa, $94        ;; 0d:6008 ????????
    db   $c9, $47, $f0, $90, $3c, $b8, $da, $c6        ;; 0d:6010 ????????
    db   $5f, $fa, $93, $c9, $cd, $28, $60, $cd        ;; 0d:6018 ????????
    db   $57, $60, $c2, $bc, $5f, $c3, $ce, $60        ;; 0d:6020 ????????
    db   $87, $21, $96, $5e, $c7, $2a, $66, $6f        ;; 0d:6028 ????????
    db   $e9, $e5, $cd, $3e, $60, $e1, $11, $00        ;; 0d:6030 ????????
    db   $c8, $06, $0a, $c3, $80, $00, $21, $00        ;; 0d:6038 ????????
    db   $c8, $01, $40, $01, $cd, $72, $00, $3e        ;; 0d:6040 ????????
    db   $80, $06, $50, $c3, $6d, $00, $f0, $90        ;; 0d:6048 ????????
    db   $21, $28, $c8, $c7, $36, $ff, $c9, $fa        ;; 0d:6050 ????????
    db   $94, $c9, $47, $0e, $ff, $21, $28, $c8        ;; 0d:6058 ????????
    db   $2a, $a1, $4f, $05, $20, $fa, $0c, $c9        ;; 0d:6060 ????????
    db   $cd, $79, $60, $cd, $82, $60, $f5, $7d        ;; 0d:6068 ????????
    db   $ea, $90, $c9, $7c, $ea, $91, $c9, $f1        ;; 0d:6070 ????????
    db   $c9, $f5, $21, $90, $c9, $2a, $66, $6f        ;; 0d:6078 ????????
    db   $f1, $c9                                      ;; 0d:6080 ??

jp_0d_6082:
    push AF                                            ;; 0d:6082 $f5
    push DE                                            ;; 0d:6083 $d5
    ld   E, L                                          ;; 0d:6084 $5d
    ld   D, H                                          ;; 0d:6085 $54
    add  A, A                                          ;; 0d:6086 $87
    ld   HL, data_0d_7b80                              ;; 0d:6087 $21 $80 $7b
    rst  add_hl_a                                      ;; 0d:608a $c7
    call call_0d_60b9                                  ;; 0d:608b $cd $b9 $60
    push AF                                            ;; 0d:608e $f5
    call call_0d_60b9                                  ;; 0d:608f $cd $b9 $60
    ld   H, A                                          ;; 0d:6092 $67
    pop  AF                                            ;; 0d:6093 $f1
    ld   L, A                                          ;; 0d:6094 $6f
.jr_0d_6095:
    call call_0d_60b9                                  ;; 0d:6095 $cd $b9 $60
    cp   A, $ff                                        ;; 0d:6098 $fe $ff
    jr   Z, .jr_0d_60b4                                ;; 0d:609a $28 $18
    add  A, B                                          ;; 0d:609c $80
    ld   [DE], A                                       ;; 0d:609d $12
    inc  DE                                            ;; 0d:609e $13
    call call_0d_60b9                                  ;; 0d:609f $cd $b9 $60
    add  A, C                                          ;; 0d:60a2 $81
    ld   [DE], A                                       ;; 0d:60a3 $12
    inc  DE                                            ;; 0d:60a4 $13
    call call_0d_60b9                                  ;; 0d:60a5 $cd $b9 $60
    push AF                                            ;; 0d:60a8 $f5
    and  A, $0f                                        ;; 0d:60a9 $e6 $0f
    ld   [DE], A                                       ;; 0d:60ab $12
    inc  DE                                            ;; 0d:60ac $13
    pop  AF                                            ;; 0d:60ad $f1
    and  A, $f0                                        ;; 0d:60ae $e6 $f0
    ld   [DE], A                                       ;; 0d:60b0 $12
    inc  DE                                            ;; 0d:60b1 $13
    jr   .jr_0d_6095                                   ;; 0d:60b2 $18 $e1
.jr_0d_60b4:
    ld   L, E                                          ;; 0d:60b4 $6b
    ld   H, D                                          ;; 0d:60b5 $62
    pop  DE                                            ;; 0d:60b6 $d1
    pop  AF                                            ;; 0d:60b7 $f1
    ret                                                ;; 0d:60b8 $c9

call_0d_60b9:
    ld   A, $0f                                        ;; 0d:60b9 $3e $0f
    jp   jp_0d_523b                                    ;; 0d:60bb $c3 $3b $52

jp_0d_60be:
    ld   DE, $8000                                     ;; 0d:60be $11 $00 $80
    ld   A, $04                                        ;; 0d:60c1 $3e $04
    jp   jp_00_00c3                                    ;; 0d:60c3 $c3 $c3 $00

call_0d_60c6:
    ld   B, $a0                                        ;; 0d:60c6 $06 $a0
    ld   HL, wCC00                                     ;; 0d:60c8 $21 $00 $cc
    jp   memclearSmall                                 ;; 0d:60cb $c3 $6c $00

call_0d_60ce:
    call call_0d_60c6                                  ;; 0d:60ce $cd $c6 $60
    ld   B, $01                                        ;; 0d:60d1 $06 $01

call_0d_60d3:
    rst  waitForVBlank                                 ;; 0d:60d3 $d7
    ld   A, $cc                                        ;; 0d:60d4 $3e $cc
    rst  executeOAM_DMA                                ;; 0d:60d6 $df
    dec  B                                             ;; 0d:60d7 $05
    jr   NZ, call_0d_60d3                              ;; 0d:60d8 $20 $f9
    ret                                                ;; 0d:60da $c9
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:60db ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:60e3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:60eb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:60f3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:60fb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6103 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:610b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6113 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:611b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6123 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:612b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6133 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:613b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6143 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:614b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6153 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:615b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6163 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:616b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6173 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:617b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6183 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:618b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6193 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:619b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61a3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61ab ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61b3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61bb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61c3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61cb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61d3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61db ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61e3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61eb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61f3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:61fb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6203 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:620b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6213 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:621b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6223 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:622b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6233 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:623b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6243 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:624b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6253 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:625b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6263 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:626b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6273 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:627b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6283 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:628b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6293 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:629b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62a3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62ab ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62b3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62bb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62c3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62cb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62d3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62db ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62e3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62eb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62f3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:62fb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6303 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:630b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6313 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:631b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6323 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:632b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6333 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:633b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6343 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:634b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6353 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:635b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6363 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:636b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6373 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:637b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6383 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:638b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6393 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:639b ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63a3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63ab ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63b3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63bb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63c3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63cb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63d3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63db ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63e3 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63eb ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:63f3 ????????
    db   $00, $00, $00, $00, $00                       ;; 0d:63fb ?????

data_0d_6400:
    db   $70, $70, $70, $70, $70, $10, $10, $10        ;; 0d:6400 ????????
    db   $10, $10, $20, $20, $20, $20, $20, $00        ;; 0d:6408 ????????
    db   $00, $00, $00, $00, $22, $22, $22, $22        ;; 0d:6410 ????????
    db   $22, $21, $21, $21, $21, $21, $01, $01        ;; 0d:6418 ????????
    db   $01, $01, $01, $12, $12, $12, $12, $12        ;; 0d:6420 ????????
    db   $11, $11, $11, $11, $11, $24, $24, $24        ;; 0d:6428 ?????.??
    db   $24, $24, $13, $13, $13, $13, $13, $23        ;; 0d:6430 ????????
    db   $23, $23, $23, $23, $26, $26, $26, $26        ;; 0d:6438 ????????
    db   $26, $14, $14, $14, $14, $14, $25, $25        ;; 0d:6440 ????????
    db   $25, $25, $25, $15, $15, $15, $15, $15        ;; 0d:6448 ????????
    db   $02, $02, $02, $02, $02, $27, $27, $27        ;; 0d:6450 ????????
    db   $27, $27, $03, $03, $03, $03, $03, $28        ;; 0d:6458 ????????
    db   $28, $28, $28, $28, $29, $29, $29, $29        ;; 0d:6460 ????????
    db   $29, $2a, $2a, $2a, $2a, $2a, $16, $16        ;; 0d:6468 ????????
    db   $16, $16, $16, $2b, $2b, $2b, $2b, $2b        ;; 0d:6470 ????????
    db   $2c, $2c, $2c, $2c, $2c, $2d, $2d, $2d        ;; 0d:6478 .???????
    db   $2d, $2d, $2e, $2e, $2e, $2e, $2e, $04        ;; 0d:6480 ????????
    db   $04, $04, $04, $04, $2f, $2f, $2f, $2f        ;; 0d:6488 ????????
    db   $2f, $17, $17, $17, $17, $17, $80, $80        ;; 0d:6490 ????????
    db   $80, $80, $80, $18, $18, $18, $18, $18        ;; 0d:6498 ????????
    db   $81, $81, $81, $81, $81, $82, $82, $82        ;; 0d:64a0 ????????
    db   $82, $82, $19, $19, $19, $19, $19, $05        ;; 0d:64a8 ????????
    db   $05, $05, $05, $05, $83, $83, $83, $83        ;; 0d:64b0 ????????
    db   $83, $1a, $1a, $1a, $1a, $29, $1b, $1b        ;; 0d:64b8 ????????
    db   $1b, $1b, $2c, $84, $84, $84, $84, $84        ;; 0d:64c0 ????????
    db   $85, $85, $85, $85, $00, $86, $86, $86        ;; 0d:64c8 ????????
    db   $86, $86, $87, $87, $87, $87, $86, $06        ;; 0d:64d0 ????????
    db   $06, $06, $06, $00, $88, $88, $88, $88        ;; 0d:64d8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:64e0 ????????
    db   $00, $00, $00, $00, $8b, $8a, $16, $51        ;; 0d:64e8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:64f0 ????????
    db   $40, $30, $89, $41, $31, $50, $32, $60        ;; 0d:64f8 ????????

data_0d_6500:
    db   $44, $46, $66, $68, $86, $88, $e8, $44        ;; 0d:6500 ??.?????
    db   $66, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6508 ????????

data_0d_6510:
    db   $06, $00, $40, $06, $00, $47, $05             ;; 0d:6510 ??????.
    dw   $4000                                         ;; 0d:6517 wW
    db   $06, $00, $5f, $06, $00, $59, $06, $00        ;; 0d:6519 ????????
    db   $71, $06, $00, $79, $05, $00, $7f, $05        ;; 0d:6521 ????????
    db   $00, $64, $00, $00, $00, $00, $00, $00        ;; 0d:6529 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6531 ????????
    db   $00, $00, $00, $00, $00, $00, $00             ;; 0d:6539 ???????

data_0d_6540:
    db   $0a, $00, $00, $06, $0e, $00, $03, $0a        ;; 0d:6540 ...?????
    db   $11, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6548 ????????

data_0d_6550:
    db   $04, $02, $02, $00, $02, $00, $00, $04        ;; 0d:6550 ??w?????
    db   $02, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6558 ????????
    db   $f6, $e5, $c3, $7f, $3b, $19, $08, $00        ;; 0d:6560 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6568 ????????
    db   $17, $17, $16, $14, $15, $96, $97, $97        ;; 0d:6570 ????????
    db   $17, $16, $15, $14, $96, $97, $10, $10        ;; 0d:6578 ?.?.????
    db   $15, $96, $96, $97, $10, $11, $11, $12        ;; 0d:6580 ????????
    db   $15, $96, $97, $10, $11, $12, $12, $13        ;; 0d:6588 ????????
    db   $97, $10, $10, $11, $12, $13, $94, $94        ;; 0d:6590 ????????
    db   $10, $11, $12, $12, $13, $94, $95, $93        ;; 0d:6598 ????????
    db   $11, $12, $13, $13, $94, $94, $95, $93        ;; 0d:65a0 ????????
    db   $11, $12, $13, $94, $95, $95, $93, $91        ;; 0d:65a8 ????????
    db   $12, $13, $94, $95, $93, $91, $90, $90        ;; 0d:65b0 ????????
    db   $13, $94, $95, $93, $92, $91, $90, $90        ;; 0d:65b8 ????????
    db   $95, $93, $92, $92, $91, $90, $90, $90        ;; 0d:65c0 ????????
    db   $22, $21, $1f, $19, $1c, $1b, $1d, $18        ;; 0d:65c8 ????????
    db   $22, $22, $1f, $20, $1a, $1a, $1b, $1d        ;; 0d:65d0 ????????
    db   $21, $19, $1c, $1b, $1e, $18, $18, $18        ;; 0d:65d8 ????????
    db   $21, $19, $1c, $1e, $1d, $18, $18, $a2        ;; 0d:65e0 ????????
    db   $1c, $1b, $1e, $1d, $18, $a2, $a2, $a2        ;; 0d:65e8 ????????
    db   $1d, $18, $a2, $a2, $98, $98, $98, $a0        ;; 0d:65f0 ????????
    db   $18, $a2, $98, $98, $a0, $a0, $9e, $9f        ;; 0d:65f8 ????????
    db   $a2, $a2, $a0, $a0, $9e, $9f, $99, $9a        ;; 0d:6600 ????????
    db   $98, $a0, $9e, $9f, $99, $9a, $9b, $9d        ;; 0d:6608 ????????
    db   $9e, $9e, $9e, $9f, $99, $9a, $9b, $9d        ;; 0d:6610 ????????
    db   $99, $9a, $9a, $9b, $a1, $9c, $9d, $9d        ;; 0d:6618 ????????
    db   $9a, $9a, $9b, $a1, $9c, $9d, $9d, $9d        ;; 0d:6620 ????????
    db   $2d, $2d, $2d, $2c, $28, $27, $29, $29        ;; 0d:6628 ????????
    db   $2d, $28, $28, $28, $2a, $27, $29, $29        ;; 0d:6630 ????????
    db   $2c, $2a, $2a, $2a, $27, $29, $29, $29        ;; 0d:6638 ????????
    db   $23, $23, $2b, $25, $24, $ad, $ad, $a4        ;; 0d:6640 ????????
    db   $23, $2b, $25, $a5, $ad, $a3, $a4, $ac        ;; 0d:6648 ????????
    db   $23, $24, $24, $a5, $a3, $a4, $ac, $a9        ;; 0d:6650 ????????
    db   $ad, $ad, $a3, $a4, $ac, $a9, $ab, $ab        ;; 0d:6658 ????????
    db   $a3, $a3, $a4, $ac, $a9, $ab, $a6, $a8        ;; 0d:6660 ????????
    db   $ac, $a9, $a9, $ab, $26, $a6, $a6, $a8        ;; 0d:6668 ????????
    db   $a9, $ab, $26, $a7, $a6, $aa, $a8, $a8        ;; 0d:6670 ????????
    db   $ab, $26, $26, $a7, $aa, $a8, $a8, $a8        ;; 0d:6678 ????????
    db   $3a, $3b, $3a, $39, $36, $3b, $36, $38        ;; 0d:6680 ????????
    db   $37, $37, $37, $30, $31, $32, $b0, $33        ;; 0d:6688 ????????
    db   $37, $37, $30, $31, $32, $b0, $2e, $33        ;; 0d:6690 ????????
    db   $30, $30, $32, $b0, $2f, $2e, $33, $33        ;; 0d:6698 ????????
    db   $32, $b0, $b0, $2f, $2e, $33, $33, $33        ;; 0d:66a0 ????????
    db   $b0, $2f, $2f, $2e, $33, $33, $33, $33        ;; 0d:66a8 ????????
    db   $36, $38, $35, $38, $35, $b3, $b3, $af        ;; 0d:66b0 ????????
    db   $35, $35, $34, $34, $b3, $af, $af, $ae        ;; 0d:66b8 ????????
    db   $35, $34, $34, $34, $b3, $af, $af, $ae        ;; 0d:66c0 ????????
    db   $34, $b3, $b3, $af, $ae, $ae, $ae, $ae        ;; 0d:66c8 ????????
    db   $b3, $b3, $af, $af, $ae, $ae, $ae, $ae        ;; 0d:66d0 ????????
    db   $35, $35, $b2, $35, $b2, $b1, $b1, $b4        ;; 0d:66d8 ????????
    db   $b2, $b2, $b2, $b2, $b1, $b4, $b4, $b5        ;; 0d:66e0 ????????
    db   $b2, $b1, $b1, $b1, $b4, $b5, $b5, $b6        ;; 0d:66e8 ????????
    db   $b2, $b4, $b4, $b5, $b6, $b7, $b7, $ba        ;; 0d:66f0 ????????
    db   $b4, $b5, $b5, $b6, $b7, $b8, $bb, $bb        ;; 0d:66f8 ????????

data_0d_6700:
    db   $b5, $b6, $b7, $b8, $b9, $ba, $bb, $bb        ;; 0d:6700 ????????
    db   $b6, $b7, $b8, $b9, $ba, $bb, $bb, $bb        ;; 0d:6708 ????????
    db   $49, $49, $48, $44, $46, $3e, $45, $c2        ;; 0d:6710 ????????
    db   $49, $48, $47, $45, $3e, $3f, $c2, $c2        ;; 0d:6718 ????????
    db   $49, $44, $3e, $3f, $42, $c2, $3d, $3c        ;; 0d:6720 ????????
    db   $47, $46, $3f, $42, $c2, $3d, $3c, $40        ;; 0d:6728 ????????
    db   $c2, $c2, $3d, $3d, $3c, $3c, $40, $43        ;; 0d:6730 ????????
    db   $c2, $3d, $3c, $40, $43, $43, $41, $bc        ;; 0d:6738 ????????
    db   $3d, $3c, $40, $40, $43, $41, $bc, $bd        ;; 0d:6740 ????????
    db   $40, $43, $41, $41, $bc, $bc, $bd, $c1        ;; 0d:6748 ????????
    db   $43, $41, $41, $bc, $bd, $bd, $c1, $bf        ;; 0d:6750 ????????
    db   $43, $41, $bc, $bd, $c1, $c1, $bf, $be        ;; 0d:6758 ????????
    db   $bc, $bc, $bd, $c1, $bf, $bf, $be, $c0        ;; 0d:6760 ????????
    db   $bd, $bd, $c1, $bf, $be, $be, $c0, $c3        ;; 0d:6768 ????????
    db   $c1, $c1, $bf, $be, $c0, $c3, $c4, $c5        ;; 0d:6770 ????????
    db   $be, $be, $c0, $c3, $c4, $c5, $c6, $c9        ;; 0d:6778 ????????
    db   $be, $c0, $c0, $c3, $c4, $c5, $c6, $c9        ;; 0d:6780 ????????
    db   $c4, $c5, $c5, $c6, $c7, $c8, $c9, $c9        ;; 0d:6788 ????????
    db   $c5, $c5, $c6, $c7, $c8, $c9, $c9, $c9        ;; 0d:6790 ????????
    db   $53, $53, $51, $50, $4f, $4c, $4c, $4b        ;; 0d:6798 ????????
    db   $53, $51, $54, $54, $52, $4c, $4b, $4d        ;; 0d:67a0 ????????
    db   $52, $52, $4c, $4b, $4d, $4e, $4e, $d3        ;; 0d:67a8 ????????
    db   $52, $4c, $4b, $4d, $4e, $d3, $d3, $d4        ;; 0d:67b0 ????????
    db   $4b, $4d, $4e, $d3, $4a, $d4, $d4, $d2        ;; 0d:67b8 ????????
    db   $4d, $4e, $d3, $4a, $d4, $d2, $d1, $d1        ;; 0d:67c0 ????????
    db   $4e, $d3, $d3, $4a, $d4, $d2, $d1, $d0        ;; 0d:67c8 ????????
    db   $4a, $d4, $d2, $d2, $d1, $d0, $d0, $d0        ;; 0d:67d0 ????????
    db   $d4, $d2, $d2, $d1, $d0, $cf, $cc, $cb        ;; 0d:67d8 ????????
    db   $d0, $d0, $cf, $cf, $ce, $ce, $cc, $cb        ;; 0d:67e0 ????????
    db   $d0, $cf, $ce, $cc, $cd, $ca, $cb, $cb        ;; 0d:67e8 ????????
    db   $cf, $ce, $cc, $cd, $ca, $cb, $cb, $cb        ;; 0d:67f0 ????????
    db   $56, $56, $5b, $5e, $5d, $5d, $59, $57        ;; 0d:67f8 ????????

data_0d_6800:
    db   $56, $5b, $5e, $59, $58, $57, $55, $55        ;; 0d:6800 ????????
    db   $56, $59, $59, $58, $57, $55, $5a, $5a        ;; 0d:6808 ????????
    db   $56, $59, $58, $57, $55, $5a, $5c, $dd        ;; 0d:6810 ????????
    db   $5b, $59, $57, $55, $5a, $5c, $5c, $dd        ;; 0d:6818 ????????
    db   $57, $55, $5a, $5a, $5c, $de, $dd, $dd        ;; 0d:6820 ????????
    db   $55, $5a, $5a, $5c, $de, $de, $dd, $d7        ;; 0d:6828 ????????
    db   $55, $5c, $5c, $de, $dd, $dd, $d7, $d7        ;; 0d:6830 ????????
    db   $5c, $5c, $de, $de, $dd, $d7, $d7, $d9        ;; 0d:6838 ????????
    db   $de, $de, $dd, $dd, $d7, $d9, $d9, $d9        ;; 0d:6840 ????????
    db   $d7, $d7, $d7, $d7, $d9, $da, $d5, $d8        ;; 0d:6848 ????????
    db   $d7, $d9, $d9, $d9, $da, $da, $d5, $d8        ;; 0d:6850 ????????
    db   $d9, $d9, $da, $d5, $dc, $d8, $d8, $d6        ;; 0d:6858 ????????
    db   $d9, $da, $da, $d5, $dc, $d8, $d8, $d6        ;; 0d:6860 ????????
    db   $da, $d5, $d5, $dc, $d8, $d6, $d6, $db        ;; 0d:6868 ????????
    db   $d5, $d8, $d6, $d6, $db, $db, $db, $db        ;; 0d:6870 ????????
    db   $64, $67, $66, $64, $65, $60, $60, $63        ;; 0d:6878 ????????
    db   $65, $67, $60, $61, $5f, $e1, $63, $e3        ;; 0d:6880 ????????
    db   $60, $60, $61, $5f, $e1, $63, $e3, $e2        ;; 0d:6888 ????????
    db   $61, $5f, $e1, $63, $62, $e3, $e2, $df        ;; 0d:6890 ????????
    db   $e1, $63, $63, $62, $e3, $e2, $df, $e5        ;; 0d:6898 ????????
    db   $63, $62, $62, $e3, $e2, $df, $e0, $e5        ;; 0d:68a0 ????????
    db   $e3, $e2, $e2, $df, $e0, $e4, $e6, $e7        ;; 0d:68a8 ????????
    db   $e2, $e2, $df, $e0, $e4, $e5, $e6, $e7        ;; 0d:68b0 ????????
    db   $df, $e0, $e4, $e5, $e6, $e7, $e7, $e7        ;; 0d:68b8 ????????
    db   $68, $68, $69, $6a, $6c, $6c, $6c, $6e        ;; 0d:68c0 ????????
    db   $68, $69, $6a, $6b, $6d, $6e, $6e, $70        ;; 0d:68c8 ????????
    db   $69, $6a, $6c, $6b, $6d, $6e, $70, $ee        ;; 0d:68d0 ????????
    db   $69, $6b, $6d, $6e, $6f, $70, $ee, $ec        ;; 0d:68d8 ????????
    db   $6b, $6b, $6e, $6f, $70, $ee, $ec, $f0        ;; 0d:68e0 ????????
    db   $6e, $6f, $70, $70, $ee, $ec, $f0, $f0        ;; 0d:68e8 ????????
    db   $6f, $70, $ee, $ee, $ec, $f0, $f0, $ef        ;; 0d:68f0 ????????
    db   $6f, $ee, $ec, $ec, $f0, $f0, $ef, $ef        ;; 0d:68f8 ????????
    db   $f0, $f0, $ef, $ef, $ea, $ea, $ed, $e8        ;; 0d:6900 ????????
    db   $f0, $ef, $ef, $ea, $eb, $ed, $ed, $e8        ;; 0d:6908 ????????
    db   $ef, $ea, $eb, $eb, $ed, $e8, $e8, $e9        ;; 0d:6910 ????????
    db   $ef, $ea, $ed, $e8, $e9, $e9, $e9, $e9        ;; 0d:6918 ????????
    db   $7d, $76, $72, $79, $78, $73, $77, $77        ;; 0d:6920 ????????
    db   $7d, $71, $75, $7a, $73, $7b, $fe, $fb        ;; 0d:6928 ????????
    db   $71, $75, $74, $7b, $77, $fe, $ff, $f7        ;; 0d:6930 ????????
    db   $71, $74, $fe, $ff, $fc, $f3, $7f, $f2        ;; 0d:6938 ????????
    db   $fe, $ff, $fc, $f3, $f4, $f5, $7e, $f6        ;; 0d:6940 ????????
    db   $fe, $f3, $f4, $f5, $fa, $f8, $f6, $fd        ;; 0d:6948 ????????
    db   $f4, $f5, $fa, $f8, $f9, $7f, $fd, $f1        ;; 0d:6950 ????????
    db   $f4, $f9, $7f, $7e, $7c, $f6, $f1, $f1        ;; 0d:6958 ????????
    db   $f9, $7c, $fb, $f7, $f2, $fd, $f1, $8d        ;; 0d:6960 ????????
    db   $64, $67, $66, $64, $65, $60, $60, $63        ;; 0d:6968 ????????
    db   $e3, $e2, $e2, $df, $e0, $e4, $e6, $e7        ;; 0d:6970 ????????
    db   $e2, $e2, $df, $e0, $e4, $e5, $e6, $e7        ;; 0d:6978 ????????
    db   $df, $e0, $e4, $e5, $e6, $e7, $e7, $e7        ;; 0d:6980 ????????
    db   $f0, $f0, $ef, $ef, $ea, $ea, $ed, $e8        ;; 0d:6988 ????????
    db   $f0, $ef, $ef, $ea, $eb, $ed, $ed, $e8        ;; 0d:6990 ????????
    db   $ef, $ea, $eb, $eb, $ed, $e8, $e8, $e9        ;; 0d:6998 ????????
    db   $ef, $ea, $ed, $e8, $e9, $e9, $e9, $e9        ;; 0d:69a0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69a8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69b0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69b8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69c0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69c8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69d0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69d8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69e0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69e8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69f0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:69f8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a00 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a08 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a10 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a18 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a20 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a28 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a30 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a38 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a40 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a48 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a50 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a58 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a60 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a68 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a70 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a78 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a80 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a88 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a90 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6a98 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6aa0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6aa8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6ab0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6ab8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6ac0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6ac8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6ad0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6ad8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6ae0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6ae8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6af0 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6af8 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b00 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b08 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b10 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b18 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b20 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b28 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b30 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b38 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b40 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b48 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b50 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b58 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b60 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6b68 ????????
    db   $05, $05, $05, $05, $05, $06, $06, $06        ;; 0d:6b70 ????????
    db   $06, $06, $07, $07, $07, $07, $07, $08        ;; 0d:6b78 ????????
    db   $08, $08, $08, $08, $0a, $0a, $0a, $0a        ;; 0d:6b80 ????????
    db   $0a, $09, $09, $09, $09, $09, $0b, $0b        ;; 0d:6b88 ????????
    db   $0b, $0b, $0b, $0c, $0c, $0c, $0c, $0c        ;; 0d:6b90 ????????
    db   $0d, $0d, $0d, $0d, $0d, $0e, $0e, $0e        ;; 0d:6b98 ????????
    db   $0e, $0e, $0f, $0f, $0f, $0f, $0f, $10        ;; 0d:6ba0 ????????
    db   $10, $10, $10, $10, $13, $13, $13, $13        ;; 0d:6ba8 ????????
    db   $13, $11, $11, $11, $11, $11, $12, $12        ;; 0d:6bb0 ????????
    db   $12, $12, $12, $14, $14, $14, $14, $14        ;; 0d:6bb8 ????????
    db   $15, $15, $15, $15, $15, $16, $16, $16        ;; 0d:6bc0 ????????
    db   $16, $16, $17, $17, $17, $17, $17, $18        ;; 0d:6bc8 ????????
    db   $18, $18, $18, $18, $19, $19, $19, $19        ;; 0d:6bd0 ????????
    db   $19, $1a, $1a, $1a, $1a, $1a, $1b, $1b        ;; 0d:6bd8 ????????
    db   $1b, $1b, $1b, $1c, $1c, $1c, $1c, $1c        ;; 0d:6be0 ????????
    db   $1d, $1d, $1d, $1d, $1d, $1e, $1e, $1e        ;; 0d:6be8 ????????
    db   $1e, $1e, $1f, $1f, $1f, $1f, $1f, $20        ;; 0d:6bf0 ????????
    db   $20, $20, $20, $20, $21, $21, $21, $21        ;; 0d:6bf8 ????????
    db   $21, $22, $22, $22, $22, $22, $23, $23        ;; 0d:6c00 ????????
    db   $23, $23, $23, $24, $24, $24, $24, $24        ;; 0d:6c08 ????????
    db   $25, $25, $25, $25, $25, $26, $26, $26        ;; 0d:6c10 ????????
    db   $26, $26, $27, $27, $27, $27, $27, $28        ;; 0d:6c18 ????????
    db   $28, $28, $28, $28, $00, $00, $00, $00        ;; 0d:6c20 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6c28 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6c30 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6c38 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6c40 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6c48 ????????
    db   $00, $2a, $2b, $2c, $2c, $2d, $29, $2d        ;; 0d:6c50 ?w??????
    db   $2e, $2f, $29, $30, $00, $00, $00, $00        ;; 0d:6c58 ????????
    db   $00, $01, $02, $03, $04, $0b, $19, $24        ;; 0d:6c60 pwwwpwww
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6c68 ????????
    db   $ff, $fe, $00, $60, $e1, $fd, $ef, $00        ;; 0d:6c70 ????????
    db   $60, $61, $80, $fc, $ee, $74, $20, $f9        ;; 0d:6c78 ????????
    db   $f8, $00, $60, $61, $fa, $fb, $00, $60        ;; 0d:6c80 ????????
    db   $61, $c7, $b8, $00, $3f, $2c, $57, $ac        ;; 0d:6c88 ????????
    db   $00, $2b, $2c, $92, $2a, $00, $24, $25        ;; 0d:6c90 ????????
    db   $47, $b6, $00, $20, $e1, $98, $83, $00        ;; 0d:6c98 ????????
    db   $20, $21, $c9, $c5, $00, $20, $21, $d1        ;; 0d:6ca0 ????????
    db   $d8, $00, $20, $2c, $14, $5f, $00, $20        ;; 0d:6ca8 ????????
    db   $21, $69, $ec, $00, $20, $01, $9c, $b0        ;; 0d:6cb0 ????????
    db   $bd, $27, $26, $ed, $ed, $c2, $20, $26        ;; 0d:6cb8 ????????
    db   $00, $5a, $96, $09, $1e, $4b, $00, $2d        ;; 0d:6cc0 ????????
    db   $07, $1b, $b4, $78, $5a, $0d, $0e, $a5        ;; 0d:6cc8 ????????
    db   $96, $87, $0d, $19, $78, $4b, $b9, $04        ;; 0d:6cd0 ????w...
    db   $0a, $b9, $2d, $b4, $04, $09, $2d, $a5        ;; 0d:6cd8 ??????w.
    db   $78, $00, $03, $96, $b4, $a5, $01, $03        ;; 0d:6ce0 ..??????
    db   $aa, $0f, $50, $0a, $0f, $1e, $41, $6e        ;; 0d:6ce8 ????????
    db   $03, $16, $50, $be, $05, $03, $17, $0f        ;; 0d:6cf0 ????????
    db   $32, $8c, $08, $1b, $aa, $1e, $3c, $07        ;; 0d:6cf8 ????????
    db   $1e, $69, $50, $41, $0b, $1e, $be, $6e        ;; 0d:6d00 ????????
    db   $32, $0d, $19, $05, $41, $aa, $04, $18        ;; 0d:6d08 ????????
    db   $41, $a6, $be, $06, $0e, $32, $aa, $69        ;; 0d:6d10 ????????
    db   $01, $1b, $6e, $3c, $a6, $00, $0a, $d7        ;; 0d:6d18 ????????
    db   $cd, $c3, $04, $10, $10, $23, $46, $0b        ;; 0d:6d20 ????????
    db   $10, $dc, $10, $d7, $08, $0a, $14, $5f        ;; 0d:6d28 ????????
    db   $10, $15, $1b, $23, $9b, $c8, $07, $1b        ;; 0d:6d30 ????????
    db   $9b, $97, $3d, $03, $1e, $c3, $b5, $23        ;; 0d:6d38 ????????
    db   $0b, $14, $7d, $46, $cd, $03, $1e, $97        ;; 0d:6d40 ????????
    db   $14, $dc, $06, $15, $5f, $c8, $b5, $00        ;; 0d:6d48 ????????
    db   $0a, $3d, $c3, $7d, $00, $0a, $5b, $1f        ;; 0d:6d50 ????????
    db   $19, $08, $0a, $d8, $28, $37, $07, $0a        ;; 0d:6d58 ????????
    db   $ab, $5b, $0a, $03, $08, $55, $d8, $73        ;; 0d:6d60 ????????
    db   $03, $12, $dd, $6a, $5b, $03, $0e, $1f        ;; 0d:6d68 ????????
    db   $7e, $2e, $0b, $0a, $28, $91, $79, $0c        ;; 0d:6d70 ????????
    db   $1a, $37, $19, $ab, $0c, $18, $82, $0a        ;; 0d:6d78 ????????
    db   $28, $06, $15, $91, $55, $6a, $05, $16        ;; 0d:6d80 ????????
    db   $73, $2e, $dd, $04, $1d, $19, $79, $7e        ;; 0d:6d88 ????????
    db   $02, $1b, $0a, $37, $55, $01, $1e, $82        ;; 0d:6d90 ????????
    db   $73, $6a, $00, $1e, $af, $88, $24, $09        ;; 0d:6d98 ????????
    db   $0a, $01, $af, $a0, $07, $0a, $4c, $01        ;; 0d:6da0 ????????
    db   $ba, $03, $13, $88, $6f, $ce, $03, $11        ;; 0d:6da8 ????????
    db   $64, $bf, $af, $0d, $1a, $8d, $15, $88        ;; 0d:6db0 ????????
    db   $0b, $0a, $56, $0b, $01, $03, $09, $33        ;; 0d:6db8 ????????
    db   $24, $4c, $0c, $18, $ba, $33, $d2, $06        ;; 0d:6dc0 ????????
    db   $15, $6f, $a0, $bf, $05, $16, $15, $64        ;; 0d:6dc8 ????????
    db   $33, $04, $1c, $bf, $ce, $8d, $01, $1c        ;; 0d:6dd0 ????????
    db   $0b, $d2, $74, $00, $1e, $a0, $64, $56        ;; 0d:6dd8 ????????
    db   $01, $1e, $51, $02, $c9, $0a, $1e, $5c        ;; 0d:6de0 ????????
    db   $d9, $60, $08, $1e, $20, $42, $d3, $09        ;; 0d:6de8 ????????
    db   $1d, $06, $51, $83, $0c, $1c, $02, $c4        ;; 0d:6df0 ????????
    db   $38, $0b, $17, $3e, $20, $a7, $06, $15        ;; 0d:6df8 ????????
    db   $34, $98, $06, $05, $1a, $c9, $60, $42        ;; 0d:6e00 ????????
    db   $02, $18, $83, $06, $d3, $03, $0e, $a7        ;; 0d:6e08 ????????
    db   $c9, $c4, $01, $0a, $60, $d3, $98, $03        ;; 0d:6e10 ????????
    db   $0f, $52, $11, $a1, $08, $18, $89, $b0        ;; 0d:6e18 ????????
    db   $47, $02, $1b, $29, $89, $16, $07, $13        ;; 0d:6e20 ????????
    db   $11, $2f, $0c, $03, $15, $b0, $6b, $1a        ;; 0d:6e28 ????????
    db   $03, $0e, $c0, $29, $c5, $0c, $1a, $a1        ;; 0d:6e30 ????????
    db   $47, $9c, $02, $1e, $b6, $16, $c0, $0d        ;; 0d:6e38 ????????
    db   $39, $0c, $1a, $de, $05, $0a, $2f, $c5        ;; 0d:6e40 ????????
    db   $6b, $04, $0a, $b1, $9d, $1b, $08, $13        ;; 0d:6e48 ????????
    db   $65, $b1, $8e, $03, $0f, $92, $25, $bb        ;; 0d:6e50 ????????
    db   $03, $08, $43, $7a, $92, $0b, $0a, $ac        ;; 0d:6e58 ????????
    db   $bb, $61, $0d, $0a, $25, $39, $65, $05        ;; 0d:6e60 ????????
    db   $1a, $9d, $7f, $57, $05, $16, $1b, $8e        ;; 0d:6e68 ????????
    db   $7f, $01, $1b, $61, $57, $7a, $01, $1e        ;; 0d:6e70 ????????
    db   $4d, $2a, $93, $00, $1e, $07, $cf, $4d        ;; 0d:6e78 ????????
    db   $05, $1e, $70, $48, $2a, $03, $16, $75        ;; 0d:6e80 ????????
    db   $07, $66, $0d, $1d, $a2, $70, $d4, $08        ;; 0d:6e88 ????????
    db   $19, $93, $ca, $84, $0c, $1c, $48, $75        ;; 0d:6e90 ????????
    db   $a2, $0a, $0e, $66, $84, $cf, $0a, $15        ;; 0d:6e98 ????????
    db   $ca, $d4, $48, $10, $1a, $21, $da, $6c        ;; 0d:6ea0 ????????
    db   $24, $3e, $8a, $03, $b7, $22, $39, $12        ;; 0d:6ea8 ????????
    db   $4e, $3f, $2c, $2f, $5d, $35, $49, $23        ;; 0d:6eb0 ????????
    db   $32, $53, $30, $df, $23, $2e, $b2, $c6        ;; 0d:6eb8 ????????

data_0d_6ec0:
    db   $62, $21, $3e, $bc, $c1, $99, $2d, $3d        ;; 0d:6ec0 ????????
    db   $44, $71, $80, $27, $38, $08, $ad, $17        ;; 0d:6ec8 ????????
    db   $27, $38, $26, $2b, $d0, $27, $38, $9e        ;; 0d:6ed0 ????????
    db   $8f, $cb, $2b, $3b, $94, $1c, $a8, $35        ;; 0d:6ed8 ????????
    db   $2a, $58, $85, $d5, $22, $3e, $7b, $0d        ;; 0d:6ee0 ????????
    db   $a3, $36, $2a, $3a, $76, $67, $37, $2a        ;; 0d:6ee8 ????????
    db   $11, $00, $00, $00, $11, $00, $00, $00        ;; 0d:6ef0 ...?????
    db   $11, $11, $11, $11, $14, $00, $00, $00        ;; 0d:6ef8 ????...?
    db   $14, $00, $00, $00, $14, $13, $13, $00        ;; 0d:6f00 ????????
    db   $13, $00, $13, $00, $13, $13, $13, $13        ;; 0d:6f08 ????????
    db   $13, $48, $00, $00, $00, $48, $00, $00        ;; 0d:6f10 ????????
    db   $00, $48, $03, $36, $00, $03, $00, $36        ;; 0d:6f18 ????????
    db   $00, $03, $36, $36, $03, $00, $36, $00        ;; 0d:6f20 ????????
    db   $03, $00, $36, $03, $11, $11, $22, $36        ;; 0d:6f28 ????????
    db   $36, $00, $36, $00, $36, $00, $36, $36        ;; 0d:6f30 ????????
    db   $03, $03, $35, $03, $35, $03, $35, $03        ;; 0d:6f38 ????????
    db   $03, $03, $35, $35, $35, $03, $35, $35        ;; 0d:6f40 ????????
    db   $35, $03, $35, $35, $35, $11, $99, $00        ;; 0d:6f48 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6f50 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6f58 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6f60 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6f68 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6f70 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0d:6f78 ????????

data_0d_6f80:
    db   $20, $00                                      ;; 0d:6f80 ??

data_0d_6f82:
    db   $2d, $00, $05, $03, $05, $06, $80, $79        ;; 0d:6f82 ????????
    db   $23, $00, $f8, $00, $19, $16, $19, $1c        ;; 0d:6f8a ????????
    db   $81, $79, $24, $00, $44, $01, $20, $1d        ;; 0d:6f92 ????????
    db   $20, $24, $85, $79, $26, $00, $db, $02        ;; 0d:6f9a ????????
    db   $49, $44, $49, $4e, $8a, $79, $27, $00        ;; 0d:6fa2 ????????
    db   $5a, $03, $56, $50, $56, $5b, $91, $79        ;; 0d:6faa ????????
    db   $21, $00, $51, $00, $08, $06, $0a, $08        ;; 0d:6fb2 ????????
    db   $99, $79, $24, $00, $44, $01, $20, $1d        ;; 0d:6fba ????????
    db   $24, $20, $9b, $79, $25, $00, $66, $02        ;; 0d:6fc2 ????????
    db   $3d, $39, $42, $3d, $a0, $79, $26, $00        ;; 0d:6fca ????????
    db   $db, $02, $49, $44, $47, $49, $a6, $79        ;; 0d:6fd2 ????????
    db   $27, $00, $5a, $03, $56, $50, $5b, $56        ;; 0d:6fda ????????
    db   $ad, $79, $22, $00, $c3, $00, $12, $0e        ;; 0d:6fe2 ????????
    db   $12, $15, $b5, $79, $23, $00, $07, $01        ;; 0d:6fea ????????
    db   $19, $14, $19, $1c, $b8, $79, $24, $00        ;; 0d:6ff2 ????????
    db   $ae, $01, $29, $23, $29, $2d                  ;; 0d:6ffa ??????

data_0d_7000:
    db   $bc, $79, $26, $00, $f4, $02, $49, $42        ;; 0d:7000 ????????
    db   $49, $4e, $c1, $79, $27, $00, $75, $03        ;; 0d:7008 ????????
    db   $56, $4e, $56, $5b, $c8, $79, $21, $00        ;; 0d:7010 ????????
    db   $5a, $00, $07, $04, $08, $0d, $d0, $79        ;; 0d:7018 ????????
    db   $22, $00, $89, $00, $0c, $07, $0d, $12        ;; 0d:7020 ????????
    db   $d2, $79, $24, $00, $ae, $01, $27, $20        ;; 0d:7028 ????????
    db   $27, $33, $d5, $79, $26, $00, $f4, $02        ;; 0d:7030 ????????
    db   $47, $3d, $42, $56, $da, $79, $27, $00        ;; 0d:7038 ????????
    db   $75, $03, $53, $48, $56, $63, $e1, $79        ;; 0d:7040 ????????
    db   $21, $00, $94, $00, $0d, $08, $0d, $0f        ;; 0d:7048 ????????
    db   $e9, $79, $23, $00, $16, $01, $19, $13        ;; 0d:7050 ????????
    db   $19, $1c, $eb, $79, $24, $00, $c1, $01        ;; 0d:7058 ????????
    db   $29, $21, $25, $2d, $ef, $79, $26, $00        ;; 0d:7060 ????????
    db   $0d, $03, $49, $3f, $42, $4e, $f4, $79        ;; 0d:7068 ????????
    db   $27, $00, $90, $03, $56, $4b, $56, $5b        ;; 0d:7070 ????????
    db   $fb, $79, $22, $00, $9c, $00, $12, $14        ;; 0d:7078 ????????
    db   $15, $11, $03, $7a, $24, $00, $75, $01        ;; 0d:7080 ????????
    db   $29, $2b, $2d, $27, $06, $7a, $25, $00        ;; 0d:7088 ????????
    db   $d1, $01, $33, $35, $37, $31, $0b, $7a        ;; 0d:7090 ????????
    db   $26, $00, $a9, $02, $49, $4c, $4e, $47        ;; 0d:7098 ????????
    db   $11, $7a, $27, $00, $24, $03, $56, $59        ;; 0d:70a0 ????????
    db   $5b, $53, $18, $7a, $21, $00, $5a, $00        ;; 0d:70a8 ????????
    db   $08, $05, $0a, $08, $20, $7a, $22, $00        ;; 0d:70b0 ????????
    db   $c3, $00, $12, $0e, $15, $12, $22, $7a        ;; 0d:70b8 ????????
    db   $24, $00, $55, $01, $20, $1b, $24, $20        ;; 0d:70c0 ????????
    db   $25, $7a, $26, $00, $f4, $02, $49, $42        ;; 0d:70c8 ????????
    db   $47, $49, $2a, $7a, $27, $00, $75, $03        ;; 0d:70d0 ????????
    db   $56, $4e, $5b, $56, $31, $7a, $21, $00        ;; 0d:70d8 ????????
    db   $7e, $00, $0f, $09, $0f, $0c, $39, $7a        ;; 0d:70e0 ????????
    db   $23, $00, $f8, $00, $1c, $14, $1c, $17        ;; 0d:70e8 ????????
    db   $3b, $7a, $25, $00, $fb, $01, $37, $2c        ;; 0d:70f0 ????????
    db   $32, $31, $3f, $7a, $26, $00, $db, $02        ;; 0d:70f8 ????????
    db   $4e, $42, $47, $47, $45, $7a, $27, $00        ;; 0d:7100 ????????
    db   $5a, $03, $5b, $4e, $5b, $53, $4c, $7a        ;; 0d:7108 ????????
    db   $22, $00, $b6, $00, $11, $0e, $17, $12        ;; 0d:7110 ????????
    db   $54, $7a, $24, $00, $9b, $01, $27, $23        ;; 0d:7118 ????????
    db   $31, $29, $57, $7a, $25, $00, $66, $02        ;; 0d:7120 ????????
    db   $3b, $37, $47, $3d, $5c, $7a, $26, $00        ;; 0d:7128 ????????
    db   $db, $02, $47, $42, $53, $49, $62, $7a        ;; 0d:7130 ????????
    db   $27, $00, $5a, $03, $53, $4e, $61, $56        ;; 0d:7138 ????????
    db   $69, $7a, $20, $00                            ;; 0d:7140 ??..
    dw   $002d                                         ;; 0d:7144 wW
    db   $05, $05, $05, $05                            ;; 0d:7146 ...w
    dw   .data_0d_7a71                                 ;; 0d:714a pP
    db   $22, $00, $b6, $00, $12, $12, $12, $12        ;; 0d:714c ????????
    db   $72, $7a, $24, $00, $9b, $01, $29, $29        ;; 0d:7154 ????????
    db   $29, $29, $75, $7a, $26, $00, $db, $02        ;; 0d:715c ????????
    db   $49, $49, $42, $49, $7a, $7a, $27, $00        ;; 0d:7164 ????????
    db   $5a, $03, $56, $56, $56, $56, $81, $7a        ;; 0d:716c ????????
    db   $21, $00, $51, $00, $04, $0a, $08, $0a        ;; 0d:7174 ????????
    db   $89, $7a, $23, $00, $f8, $00, $13, $1c        ;; 0d:717c ????????
    db   $19, $1c, $8b, $7a, $24, $00, $44, $01        ;; 0d:7184 ????????
    db   $1a, $24, $20, $24, $8f, $7a, $26, $00        ;; 0d:718c ????????
    db   $db, $02, $3f, $4e, $42, $4e, $94, $7a        ;; 0d:7194 ????????
    db   $27, $00, $71, $03, $4b, $5b, $56, $5b        ;; 0d:719c ????????
    db   $9b, $7a, $22, $00, $b6, $00, $0d, $16        ;; 0d:71a4 ????????
    db   $16, $10, $a3, $7a, $24, $00, $44, $01        ;; 0d:71ac ????????
    db   $1a, $26, $26, $1d, $a6, $7a, $25, $00        ;; 0d:71b4 ????????
    db   $fb, $01, $2a, $39, $34, $2f, $ab, $7a        ;; 0d:71bc ????????
    db   $26, $00, $db, $02, $3f, $51, $51, $44        ;; 0d:71c4 ????????
    db   $b1, $7a, $27, $00, $5a, $03, $4b, $5e        ;; 0d:71cc ????????
    db   $5e, $50, $b8, $7a, $22, $00, $63, $00        ;; 0d:71d4 ????????
    db   $0a, $07, $08, $05, $c0, $7a, $22, $00        ;; 0d:71dc ????????
    db   $94, $00, $0f, $0c, $0c, $09, $c3, $7a        ;; 0d:71e4 ????????
    db   $25, $00, $66, $01, $24, $1f, $20, $1b        ;; 0d:71ec ????????
    db   $c6, $7a, $26, $00, $0d, $03, $4e, $47        ;; 0d:71f4 ????????
    db   $42, $42, $cc, $7a, $27, $00, $90, $03        ;; 0d:71fc ????????
    db   $5b, $53, $56, $4e, $d3, $7a, $21, $00        ;; 0d:7204 ????????
    db   $63, $00, $06, $0a, $08, $06, $db, $7a        ;; 0d:720c ????????
    db   $24, $00, $66, $01, $1d, $24, $20, $1d        ;; 0d:7214 ????????
    db   $dd, $7a, $25, $00, $25, $02, $2f, $37        ;; 0d:721c ????????
    db   $33, $2f, $e2, $7a, $26, $00, $0d, $03        ;; 0d:7224 ????????
    db   $44, $4e, $49, $44, $e8, $7a, $27, $00        ;; 0d:722c ????????
    db   $90, $03, $50, $5b, $56, $50, $ef, $7a        ;; 0d:7234 ????????
    db   $21, $00, $73, $00, $0a, $0c, $0d, $11        ;; 0d:723c ????????
    db   $f7, $7a, $24, $00, $88, $01, $25, $27        ;; 0d:7244 ????????
    db   $29, $31, $f9, $7a, $25, $00, $4f, $02        ;; 0d:724c ????????
    db   $39, $3b, $37, $47, $fe, $7a, $26, $00        ;; 0d:7254 ????????
    db   $c2, $02, $44, $47, $49, $53, $04, $7b        ;; 0d:725c ????????
    db   $27, $00, $3f, $03, $50, $53, $56, $61        ;; 0d:7264 ????????
    db   $0b, $7b, $21, $00, $34, $00, $05, $06        ;; 0d:726c ????????
    db   $03, $04, $13, $7b, $24, $00, $07, $01        ;; 0d:7274 ????????
    db   $19, $1c, $14, $17, $15, $7b, $25, $00        ;; 0d:727c ????????
    db   $7d, $02, $3d, $42, $34, $3b, $1a, $7b        ;; 0d:7284 ????????
    db   $26, $00, $f4, $02, $49, $4e, $3e, $47        ;; 0d:728c ????????
    db   $20, $7b, $27, $00, $75, $03, $56, $5b        ;; 0d:7294 ????????
    db   $50, $53, $27, $7b, $21, $00, $51, $00        ;; 0d:729c ????????
    db   $09, $08, $06, $09, $2f, $7b, $24, $00        ;; 0d:72a4 ????????
    db   $44, $01, $22, $20, $1d, $22, $31, $7b        ;; 0d:72ac ????????
    db   $25, $00, $9b, $01, $2b, $29, $22, $2b        ;; 0d:72b4 ????????
    db   $36, $7b, $26, $00, $db, $02, $4c, $49        ;; 0d:72bc ????????
    db   $3e, $4c, $3c, $7b, $27, $00, $5a, $03        ;; 0d:72c4 ????????
    db   $59, $56, $50, $59, $43, $7b, $22, $00        ;; 0d:72cc ????????
    db   $b6, $00, $12, $0d, $11, $19, $4b, $7b        ;; 0d:72d4 ????????
    db   $23, $00, $f8, $00, $19, $13, $17, $20        ;; 0d:72dc ????????
    db   $4e, $7b, $25, $00, $fb, $01, $33, $2a        ;; 0d:72e4 ????????
    db   $2d, $3d, $52, $7b, $26, $00, $db, $02        ;; 0d:72ec ????????
    db   $49, $3f, $40, $56, $58, $7b, $27, $00        ;; 0d:72f4 ????????
    db   $5a, $03, $56, $4b, $53, $63, $5f, $7b        ;; 0d:72fc ????????
    db   $21, $00, $3b, $00, $06, $02, $05, $05        ;; 0d:7304 ????????
    db   $67, $7b, $22, $00, $d0, $00, $15, $0d        ;; 0d:730c ????????
    db   $12, $12, $69, $7b, $24, $00, $66, $01        ;; 0d:7314 ????????
    db   $24, $1a, $20, $20, $6c, $7b, $26, $00        ;; 0d:731c ????????
    db   $0d, $03, $4e, $3f, $42, $49, $71, $7b        ;; 0d:7324 ????????
    db   $27, $00, $90, $03, $5b, $4b, $56, $56        ;; 0d:732c ????????
    db   $78, $7b, $21, $00, $aa, $00, $12, $08        ;; 0d:7334 ????????
    db   $07, $0d, $80, $7b, $24, $00, $88, $01        ;; 0d:733c ????????
    db   $29, $1a, $18, $20, $82, $7b, $25, $00        ;; 0d:7344 ????????
    db   $4f, $02, $3d, $2a, $28, $33, $87, $7b        ;; 0d:734c ????????
    db   $26, $00, $3f, $03, $56, $3f, $3d, $49        ;; 0d:7354 ????????
    db   $8d, $7b, $27, $00, $c6, $03, $63, $4b        ;; 0d:735c ????????
    db   $48, $56, $94, $7b, $23, $00, $f8, $00        ;; 0d:7364 ????????
    db   $1a, $14, $1a, $19, $9c, $7b, $24, $00        ;; 0d:736c ????????
    db   $fb, $01, $35, $2c, $32, $33, $a0, $7b        ;; 0d:7374 ????????
    db   $25, $00, $66, $02, $40, $37, $3c, $3d        ;; 0d:737c ????????
    db   $a5, $7b, $26, $00, $db, $02, $4c, $42        ;; 0d:7384 ????????
    db   $47, $49, $ab, $7b, $27, $00, $5a, $03        ;; 0d:738c ????????
    db   $59, $4e, $5b, $56, $b2, $7b, $21, $00        ;; 0d:7394 ????????
    db   $51, $00, $0a, $09, $05, $08, $ba, $7b        ;; 0d:739c ????????
    db   $22, $00, $b6, $00, $15, $14, $0e, $12        ;; 0d:73a4 ????????
    db   $bc, $7b, $24, $00, $9b, $01, $2d, $2b        ;; 0d:73ac ????????
    db   $23, $29, $bf, $7b, $26, $00, $db, $02        ;; 0d:73b4 ????????
    db   $4e, $4c, $3c, $49, $c4, $7b, $27, $00        ;; 0d:73bc ????????
    db   $5a, $03, $5b, $59, $4e, $56, $cb, $7b        ;; 0d:73c4 ????????
    db   $21, $00, $2d, $00, $08, $0d, $0a, $05        ;; 0d:73cc ????????
    db   $d3, $7b, $23, $00, $bc, $00, $19, $20        ;; 0d:73d4 ????????
    db   $1c, $14, $d5, $7b, $25, $00, $0a, $02        ;; 0d:73dc ????????
    db   $3d, $49, $42, $37, $d9, $7b, $26, $00        ;; 0d:73e4 ????????
    db   $77, $02, $49, $56, $47, $42, $df, $7b        ;; 0d:73ec ????????
    db   $27, $00, $ee, $02, $56, $63, $5b, $4e        ;; 0d:73f4 ????????
    db   $e6, $7b, $22, $00, $8f, $00, $11, $16        ;; 0d:73fc ????????
    db   $15, $11, $ee, $7b, $23, $00, $cb, $00        ;; 0d:7404 ????????
    db   $17, $1d, $1c, $17, $f1, $7b, $25, $00        ;; 0d:740c ????????
    db   $21, $02, $3b, $44, $3c, $3b, $f5, $7b        ;; 0d:7414 ????????
    db   $26, $00, $90, $02, $47, $51, $47, $47        ;; 0d:741c ????????
    db   $fb, $7b, $27, $00, $09, $03, $53, $5e        ;; 0d:7424 ????????
    db   $5b, $53, $02, $7c, $20, $00                  ;; 0d:742c ????..
    dw   $002d                                         ;; 0d:7432 wW
    db   $06, $05, $03, $05                            ;; 0d:7434 w...
    dw   data_0d_7c0a                                  ;; 0d:7438 pP
    db   $22, $00, $b6, $00, $15, $12, $10, $12        ;; 0d:743a ????????
    db   $0b, $7c, $25, $00, $fb, $01, $37, $33        ;; 0d:7442 ????????
    db   $2b, $33, $0e, $7c, $25, $00, $db, $02        ;; 0d:744a ????????
    db   $4e, $49, $44, $49, $14, $7c, $27, $00        ;; 0d:7452 ????????
    db   $5a, $03, $5b, $56, $50, $56, $1a, $7c        ;; 0d:745a ????????
    db   $21, $00, $7e, $00, $0e, $0e, $0a, $0d        ;; 0d:7462 ????????
    db   $22, $7c, $22, $00, $b6, $00, $14, $14        ;; 0d:746a ????????
    db   $10, $12, $24, $7c, $25, $00, $fb, $01        ;; 0d:7472 ????????
    db   $35, $35, $2b, $33, $27, $7c, $26, $00        ;; 0d:747a ????????
    db   $db, $02, $4c, $4c, $3e, $49, $2d, $7c        ;; 0d:7482 ????????
    db   $27, $00, $5a, $03, $59, $59, $50, $56        ;; 0d:748a ????????
    db   $34, $7c, $22, $00, $a9, $00, $16, $12        ;; 0d:7492 ????????
    db   $10, $12, $3c, $7c, $24, $00, $33, $01        ;; 0d:749a ????????
    db   $26, $20, $1d, $20, $3f, $7c, $25, $00        ;; 0d:74a2 ????????
    db   $4f, $02, $44, $3d, $34, $3d, $44, $7c        ;; 0d:74aa ????????
    db   $26, $00, $c2, $02, $51, $49, $44, $49        ;; 0d:74b2 ????????
    db   $4a, $7c, $27, $00, $3f, $03, $5e, $56        ;; 0d:74ba ????????
    db   $50, $56, $51, $7c, $22, $00, $26, $00        ;; 0d:74c2 ????????
    db   $04, $07, $04, $05, $59, $7c, $24, $00        ;; 0d:74ca ????????
    db   $e9, $00, $17, $1d, $17, $19, $5c, $7c        ;; 0d:74d2 ????????
    db   $25, $00, $88, $01, $27, $2f, $27, $29        ;; 0d:74da ????????
    db   $61, $7c, $27, $00, $c2, $02, $47, $51        ;; 0d:74e2 ????????
    db   $47, $49, $67, $7c, $27, $00, $3f, $03        ;; 0d:74ea ????????
    db   $53, $5e, $53, $56, $6f, $7c, $21, $00        ;; 0d:74f2 ????????
    db   $63, $00, $0a, $08, $06, $06, $77, $7c        ;; 0d:74fa ????????
    db   $23, $00, $16, $01, $1c, $19, $16, $16        ;; 0d:7502 ????????
    db   $79, $7c, $25, $00, $25, $02, $37, $33        ;; 0d:750a ????????
    db   $2f, $2f, $7d, $7c, $26, $00, $0d, $03        ;; 0d:7512 ????????
    db   $4e, $49, $44, $44, $83, $7c, $27, $00        ;; 0d:751a ????????
    db   $90, $03, $5b, $56, $50, $50, $8a, $7c        ;; 0d:7522 ????????
    db   $22, $00, $b6, $00, $11, $12, $16, $10        ;; 0d:752a ????????
    db   $92, $7c, $24, $00, $fb, $01, $31, $33        ;; 0d:7532 ????????
    db   $39, $2f, $95, $7c, $25, $00, $66, $02        ;; 0d:753a ????????
    db   $3b, $3d, $44, $39, $9a, $7c, $26, $00        ;; 0d:7542 ????????
    db   $db, $02, $47, $49, $49, $44, $a0, $7c        ;; 0d:754a ????????
    db   $27, $00, $5a, $03, $53, $56, $5e, $50        ;; 0d:7552 ????????
    db   $a7, $7c, $20, $00, $1f, $00, $07, $04        ;; 0d:755a ????????
    db   $05, $05, $af, $7c, $21, $00, $68, $00        ;; 0d:7562 ????????
    db   $10, $0c, $0d, $0d, $b0, $7c, $24, $00        ;; 0d:756a ????????
    db   $22, $01, $26, $1f, $20, $20, $b2, $7c        ;; 0d:7572 ????????
    db   $26, $00, $a9, $02, $51, $47, $49, $49        ;; 0d:757a ????????
    db   $b7, $7c, $27, $00, $24, $03, $5e, $53        ;; 0d:7582 ????????
    db   $56, $56, $be, $7c, $21, $00, $68, $00        ;; 0d:758a ????????
    db   $0d, $0d, $0f, $0d, $c6, $7c, $24, $00        ;; 0d:7592 ????????
    db   $75, $01, $29, $29, $2d, $29, $c8, $7c        ;; 0d:759a ????????
    db   $25, $00, $d1, $01, $33, $33, $37, $33        ;; 0d:75a2 ????????
    db   $cd, $7c, $26, $00, $a9, $02, $49, $49        ;; 0d:75aa ????????
    db   $4e, $49, $d3, $7c, $27, $00, $24, $03        ;; 0d:75b2 ????????
    db   $56, $56, $5b, $56, $da, $7c, $23, $00        ;; 0d:75ba ????????
    db   $da, $00, $11, $1f, $20, $16, $e2, $7c        ;; 0d:75c2 ????????
    db   $24, $00, $75, $01, $20, $31, $33, $25        ;; 0d:75ca ????????
    db   $e6, $7c, $25, $00, $38, $02, $32, $47        ;; 0d:75d2 ????????
    db   $42, $39, $eb, $7c, $26, $00, $a9, $02        ;; 0d:75da ????????
    db   $3d, $53, $4e, $44, $f1, $7c, $27, $00        ;; 0d:75e2 ????????
    db   $24, $03, $48, $61, $63, $50, $f8, $7c        ;; 0d:75ea ????????
    db   $22, $00, $34, $00, $04, $05, $07, $02        ;; 0d:75f2 ????????
    db   $00, $7d, $23, $00, $5a, $00, $07, $08        ;; 0d:75fa ????????
    db   $0b, $05, $03, $7d, $25, $00, $5b, $01        ;; 0d:7602 ????????
    db   $1f, $20, $26, $1b, $07, $7d, $26, $00        ;; 0d:760a ????????
    db   $f4, $02, $47, $49, $51, $42, $0d, $7d        ;; 0d:7612 ????????
    db   $27, $00, $75, $03, $53, $56, $5e, $4e        ;; 0d:761a ????????
    db   $14, $7d, $22, $00, $75, $00, $0c, $04        ;; 0d:7622 ????????
    db   $08, $04, $1c, $7d, $23, $00, $ea, $00        ;; 0d:762a ????????
    db   $17, $0d, $12, $0d, $1f, $7d, $26, $00        ;; 0d:7632 ????????
    db   $4f, $02, $3b, $2a, $33, $2a, $23, $7d        ;; 0d:763a ????????
    db   $26, $00, $3f, $03, $53, $3f, $49, $3f        ;; 0d:7642 ????????
    db   $2a, $7d, $27, $00, $c6, $03, $61, $4b        ;; 0d:764a ????????
    db   $56, $4b, $31, $7d, $23, $00, $07, $01        ;; 0d:7652 ????????
    db   $14, $1d, $1d, $13, $39, $7d, $24, $00        ;; 0d:765a ????????
    db   $ae, $01, $23, $2f, $2f, $21, $3d, $7d        ;; 0d:7662 ????????
    db   $25, $00, $10, $02, $2c, $39, $39, $2a        ;; 0d:766a ????????
    db   $42, $7d, $26, $00, $f4, $02, $42, $51        ;; 0d:7672 ????????
    db   $51, $3f, $48, $7d, $27, $00, $75, $03        ;; 0d:767a ????????
    db   $4e, $5e, $5e, $4b, $4f, $7d, $00, $00        ;; 0d:7682 ????????
    db   $78, $00, $05, $05, $02, $06, $57, $7d        ;; 0d:768a ????????
    db   $01, $00, $40, $01, $0e, $0e, $08, $0f        ;; 0d:7692 ????????
    db   $58, $7d, $05, $00, $bc, $02, $2b, $2b        ;; 0d:769a ????????
    db   $21, $2d, $5a, $7d, $06, $00, $d0, $07        ;; 0d:76a2 ????????
    db   $4c, $4c, $3f, $4e, $60, $7d, $05, $00        ;; 0d:76aa ????????
    db   $90, $01, $2b, $2b, $21, $2c, $67, $7d        ;; 0d:76b2 ????????
    db   $00, $00, $2d, $00, $05, $07, $03, $04        ;; 0d:76ba ????????
    db   $6b, $7d, $02, $00, $f8, $00, $19, $1d        ;; 0d:76c2 ????????
    db   $16, $17, $6c, $7d, $05, $00, $fb, $01        ;; 0d:76ca ????????
    db   $33, $39, $2f, $31, $6f, $7d, $06, $00        ;; 0d:76d2 ????????
    db   $db, $02, $49, $51, $44, $47, $75, $7d        ;; 0d:76da ????????
    db   $24, $00, $d0, $07, $56, $5e, $50, $53        ;; 0d:76e2 ????????
    db   $7c, $7d, $01, $00, $5a, $00, $08, $06        ;; 0d:76ea ????????
    db   $06, $0b, $81, $7d, $02, $00, $07, $01        ;; 0d:76f2 ????????
    db   $19, $16, $16, $1d, $83, $7d, $05, $00        ;; 0d:76fa ????????
    db   $86, $01, $29, $25, $25, $2f, $86, $7d        ;; 0d:7702 ????????
    db   $06, $00, $f4, $02, $49, $44, $44, $51        ;; 0d:770a ????????
    db   $8c, $7d, $24, $00, $c4, $09, $56, $50        ;; 0d:7712 ????????
    db   $50, $5e, $93, $7d, $01, $00, $94, $00        ;; 0d:771a ????????
    db   $0e, $0e, $08, $0d, $98, $7d, $03, $00        ;; 0d:7722 ????????
    db   $66, $01, $22, $22, $1a, $20, $9a, $7d        ;; 0d:772a ????????
    db   $05, $00, $9a, $01, $2b, $2b, $21, $29        ;; 0d:7732 ????????
    db   $9e, $7d, $06, $00, $0d, $03, $4c, $4c        ;; 0d:773a ????????
    db   $3f, $49, $a4, $7d, $02, $00, $bb, $01        ;; 0d:7742 ????????
    db   $2b, $2b, $24, $29, $ab, $7d, $01, $00        ;; 0d:774a ????????
    db   $7b, $00, $08, $10, $11, $09, $ae, $7d        ;; 0d:7752 ????????
    db   $03, $00, $44, $01, $1a, $26, $27, $1b        ;; 0d:775a ????????
    db   $b0, $7d, $05, $00, $66, $02, $34, $44        ;; 0d:7762 ????????
    db   $40, $37, $b4, $7d, $06, $00, $db, $02        ;; 0d:776a ????????
    db   $3f, $51, $4b, $42, $ba, $7d, $00, $00        ;; 0d:7772 ????????
    db   $5a, $03, $4b, $5e, $61, $4e, $c1, $7d        ;; 0d:777a ????????
    db   $31, $00, $89, $00, $0f, $0f, $00, $0e        ;; 0d:7782 ????????
    db   $c1, $7d, $33, $00, $07, $01, $1c, $1c        ;; 0d:778a ????????
    db   $00, $1a, $c3, $7d, $35, $00, $7d, $02        ;; 0d:7792 ????????
    db   $42, $42, $00, $40, $c7, $7d, $36, $00        ;; 0d:779a ????????
    db   $f4, $02, $4e, $4e, $00, $4c, $cd, $7d        ;; 0d:77a2 ????????
    db   $33, $00, $2c, $01, $1e, $1e, $00, $1d        ;; 0d:77aa ????????
    db   $d4, $7d, $32, $00, $f8, $00, $1d, $19        ;; 0d:77b2 ????????
    db   $00, $1d, $d8, $7d, $33, $00, $44, $01        ;; 0d:77ba ????????
    db   $26, $20, $00, $26, $db, $7d, $35, $00        ;; 0d:77c2 ????????
    db   $66, $02, $44, $3d, $00, $44, $df, $7d        ;; 0d:77ca ????????
    db   $36, $00, $db, $02, $51, $49, $00, $51        ;; 0d:77d2 ????????
    db   $e5, $7d, $30, $00, $5a, $03, $5e, $56        ;; 0d:77da ????????
    db   $00, $5e, $d4, $7d, $21, $00, $68, $00        ;; 0d:77e2 ????????
    db   $0f, $0d, $0d, $0d, $ec, $7d, $22, $00        ;; 0d:77ea ????????
    db   $9c, $00, $15, $12, $12, $12, $ee, $7d        ;; 0d:77f2 ????????
    db   $25, $00, $22, $01, $24, $20, $20, $20        ;; 0d:77fa ????????
    db   $f1, $7d, $26, $00, $a9, $02, $4e, $49        ;; 0d:7802 ????????
    db   $49, $49, $f7, $7d, $20, $00, $24, $03        ;; 0d:780a ????????
    db   $5b, $56, $56, $56, $fe, $7d, $21, $00        ;; 0d:7812 ????????
    db   $47, $00, $0c, $0f, $0e, $10, $fe, $7d        ;; 0d:781a ????????
    db   $22, $00, $75, $00, $11, $15, $14, $16        ;; 0d:7822 ????????
    db   $00, $7e, $24, $00, $3c, $01, $27, $2d        ;; 0d:782a ????????
    db   $2b, $2f, $03, $7e, $26, $00, $5e, $02        ;; 0d:7832 ????????
    db   $47, $4e, $4c, $51, $08, $7e, $20, $00        ;; 0d:783a ????????
    db   $d3, $02, $53, $5b, $59, $5e, $0f, $7e        ;; 0d:7842 ????????
    db   $27, $00, $b9, $00, $12, $0f, $13, $12        ;; 0d:784a .?wwwwww
    db   $0f, $7e, $07, $00, $50, $00, $08, $0d        ;; 0d:7852 ..??????
    db   $0e, $0b, $17, $7e, $27, $00, $41, $01        ;; 0d:785a ????????
    db   $23, $1d, $23, $02, $1f, $7e, $07, $00        ;; 0d:7862 ????????
    db   $41, $01, $23, $1d, $23, $0b, $27, $7e        ;; 0d:786a ????????
    db   $07, $00, $64, $00, $10, $19, $15, $00        ;; 0d:7872 ????????
    db   $2f, $7e, $07, $00, $41, $01, $23, $23        ;; 0d:787a ????????
    db   $1d, $0f, $37, $7e, $07, $00, $f7, $00        ;; 0d:7882 ????????
    db   $17, $21, $1c, $15, $3f, $7e, $07, $00        ;; 0d:788a ????????
    db   $d9, $01, $2e, $3e, $27, $31, $47, $7e        ;; 0d:7892 ????????
    db   $07, $00, $27, $02, $3f, $3c, $2d, $38        ;; 0d:789a ????????
    db   $4f, $7e, $07, $00, $bc, $02, $46, $50        ;; 0d:78a2 ????????
    db   $3c, $46, $57, $7e, $27, $00, $e7, $03        ;; 0d:78aa ????????
    db   $63, $63, $63, $63, $5f, $7e, $25, $00        ;; 0d:78b2 ????????
    db   $10, $27, $5a, $5a, $5a, $5a, $67, $7e        ;; 0d:78ba ????????
    db   $27, $00, $88, $13, $3c, $3c, $3c, $3c        ;; 0d:78c2 ????????
    db   $6d, $7e, $26, $00, $9d, $02, $4b, $55        ;; 0d:78ca ????????
    db   $4f, $45, $df, $7b, $34, $00, $10, $27        ;; 0d:78d2 ????????
    db   $78, $3c, $00, $5a, $7a, $7e, $01, $00        ;; 0d:78da ??????.?
    db   $3b, $00, $06, $05, $03, $03, $7f, $7e        ;; 0d:78e2 wwwwww..
    db   $01, $00, $34, $00, $05, $06, $04, $03        ;; 0d:78ea ????????
    db   $81, $7e, $12, $00, $34, $00, $05, $04        ;; 0d:78f2 ????????
    db   $06, $03, $83, $7e, $12, $00, $2d, $00        ;; 0d:78fa ????.?ww
    db   $04, $05, $06, $03, $86, $7e, $31, $00        ;; 0d:7902 wwww...?
    db   $3c, $00, $06, $05, $00, $06, $89, $7e        ;; 0d:790a wwwwww..
    db   $21, $00, $34, $00, $05, $02, $06, $05        ;; 0d:7912 ????????
    db   $8b, $7e, $22, $00, $2d, $00, $05, $02        ;; 0d:791a ??.?wwww
    db   $06, $05, $8d, $7e, $21, $00, $1f, $00        ;; 0d:7922 ww..????
    db   $05, $05, $06, $05, $90, $7e, $24, $00        ;; 0d:792a ????????
    db   $84, $03, $12, $12, $11, $12, $92, $7e        ;; 0d:7932 ????????
    db   $04, $00, $c4, $09, $34, $34, $34, $34        ;; 0d:793a ????????
    db   $97, $7e, $04, $00, $d0, $07, $29, $29        ;; 0d:7942 ????????
    db   $29, $29, $9c, $7e, $05, $00, $70, $17        ;; 0d:794a ????????
    db   $3f, $3f, $3f, $3f, $a1, $7e, $04, $00        ;; 0d:7952 ????????
    db   $74, $0e, $4b, $4b, $44, $4b, $a7, $7e        ;; 0d:795a ????????
    db   $24, $00, $88, $13, $3f, $3f, $39, $3f        ;; 0d:7962 ????????
    db   $ac, $7e, $01, $00, $a8, $61, $63, $63        ;; 0d:796a ????????
    db   $50, $63, $b1, $7e, $31, $00, $10, $27        ;; 0d:7972 ????????
    db   $63, $63, $78, $63, $b3, $7e, $86, $86        ;; 0d:797a ????????
    db   $cd, $c2, $ed, $86, $cd, $c2, $ca, $ed        ;; 0d:7982 ????????
    db   $86, $85, $cd, $c2, $ca, $c7, $ed, $86        ;; 0d:798a ????????
    db   $85, $cd, $c2, $ca, $c7, $fe, $ed, $81        ;; 0d:7992 ????????
    db   $f1, $89, $cd, $c2, $ec, $f1, $89, $cd        ;; 0d:799a ????????
    db   $c2, $c1, $ec, $f1, $89, $cd, $c2, $b8        ;; 0d:79a2 ????????
    db   $e8, $ec, $f1, $89, $98, $d1, $cd, $c2        ;; 0d:79aa ????????
    db   $ca, $c7, $ec, $84, $85, $f0, $84, $85        ;; 0d:79b2 ????????
    db   $ed, $f0, $85, $84, $ac, $ed, $f0, $84        ;; 0d:79ba ????????
    db   $85, $ac, $e0, $e4, $e7, $f0, $84, $85        ;; 0d:79c2 ????????
    db   $ac, $f4, $a9, $fe, $e4, $e7, $85, $e7        ;; 0d:79ca ????????
    db   $85, $d3, $e7, $85, $c6, $d3, $e3, $e7        ;; 0d:79d2 ????????
    db   $85, $c6, $da, $d3, $e4, $e3, $e7, $85        ;; 0d:79da ????????
    db   $c6, $da, $d3, $fe, $e4, $e3, $e7, $86        ;; 0d:79e2 ????????
    db   $f0, $86, $87, $ac, $ec, $85, $86, $b9        ;; 0d:79ea ????????
    db   $d3, $e7, $87, $85, $b9, $b8, $da, $ea        ;; 0d:79f2 ????????
    db   $e7, $8a, $85, $b8, $bc, $d9, $e4, $ea        ;; 0d:79fa ????????
    db   $e7, $83, $9a, $e7, $83, $92, $9a, $ea        ;; 0d:7a02 ????????
    db   $e7, $92, $9e, $9a, $83, $ea, $e7, $98        ;; 0d:7a0a ????????
    db   $83, $92, $9a, $9e, $ea, $e7, $98, $83        ;; 0d:7a12 ????????
    db   $92, $9a, $9e, $a5, $ea, $e7, $97, $f0        ;; 0d:7a1a ????????
    db   $97, $ac, $f0, $97, $ac, $e3, $eb, $f0        ;; 0d:7a22 ????????
    db   $97, $ac, $b1, $b9, $e3, $eb, $e6, $97        ;; 0d:7a2a ????????
    db   $ac, $bd, $d2, $b9, $e3, $eb, $e6, $8d        ;; 0d:7a32 ????????
    db   $e6, $af, $ad, $b1, $e6, $81, $b8, $8d        ;; 0d:7a3a ????????
    db   $9f, $e8, $f1, $81, $8d, $ad, $d3, $da        ;; 0d:7a42 ????????
    db   $e3, $e6, $81, $8d, $ad, $b7, $d9, $f3        ;; 0d:7a4a ????????
    db   $e6, $e8, $d0, $e4, $e6, $cb, $bc, $d0        ;; 0d:7a52 ????????
    db   $e4, $e6, $cb, $bc, $d0, $c4, $e4, $e6        ;; 0d:7a5a ????????
    db   $cb, $bc, $ce, $d0, $c4, $e4, $e6, $bc        ;; 0d:7a62 ????????
    db   $bf, $d0, $c4, $c8, $e4, $de, $e6             ;; 0d:7a6a ???????
.data_0d_7a71:
    db   $81, $81, $b0, $d4, $81, $b0, $ab, $d4        ;; 0d:7a71 w???????
    db   $e4, $81, $b0, $ab, $d4, $b9, $b8, $e4        ;; 0d:7a79 ????????
    db   $81, $b0, $ab, $d4, $b9, $d9, $e4, $e6        ;; 0d:7a81 ????????
    db   $88, $f1, $85, $dd, $e6, $f1, $8e, $d3        ;; 0d:7a89 ????????
    db   $ca, $e3, $f1, $81, $8e, $b8, $b9, $d8        ;; 0d:7a91 ????????
    db   $f3, $e6, $81, $b9, $85, $d7, $99, $f3        ;; 0d:7a99 ????????
    db   $e9, $e6, $85, $cd, $e6, $98, $cd, $cf        ;; 0d:7aa1 ????????
    db   $e4, $e6, $cf, $b8, $cd, $9f, $e4, $e6        ;; 0d:7aa9 ????????
    db   $98, $cd, $cf, $c7, $d1, $e4, $e6, $98        ;; 0d:7ab1 ????????
    db   $cd, $cf, $c7, $a8, $d1, $e4, $e6, $90        ;; 0d:7ab9 ????????
    db   $cc, $f2, $97, $df, $f2, $cc, $94, $81        ;; 0d:7ac1 ????????
    db   $9c, $e8, $f2, $81, $94, $cc, $ad, $b5        ;; 0d:7ac9 ????????
    db   $b9, $e8, $81, $94, $cc, $ad, $b5, $b9        ;; 0d:7ad1 ????????
    db   $db, $e8, $81, $f2, $8f, $81, $8d, $e8        ;; 0d:7ad9 ????????
    db   $f2, $8b, $81, $8d, $e4, $e8, $f2, $8f        ;; 0d:7ae1 ????????
    db   $81, $8d, $d5, $c0, $e6, $e8, $8f, $81        ;; 0d:7ae9 ????????
    db   $8d, $d5, $b5, $db, $e6, $e8, $91, $f2        ;; 0d:7af1 ????????
    db   $91, $9c, $ab, $e8, $f2, $91, $ba, $b2        ;; 0d:7af9 ????????
    db   $81, $ee, $f2, $91, $81, $ab, $b5, $ef        ;; 0d:7b01 ????????
    db   $e8, $f2, $91, $81, $ab, $b5, $db, $e9        ;; 0d:7b09 ????????
    db   $ef, $e8, $82, $f1, $82, $b1, $b9, $e9        ;; 0d:7b11 ????????
    db   $f1, $82, $87, $b9, $ad, $e1, $e9, $82        ;; 0d:7b19 ????????
    db   $87, $ad, $b9, $e1, $e4, $e9, $82, $87        ;; 0d:7b21 ????????
    db   $ad, $b9, $e2, $e1, $e4, $e9, $81, $f1        ;; 0d:7b29 ????????
    db   $81, $b0, $ad, $e3, $f1, $81, $b0, $b9        ;; 0d:7b31 ????????
    db   $ad, $e9, $f1, $81, $ad, $93, $b9, $fe        ;; 0d:7b39 ????????
    db   $e9, $f0, $81, $ad, $b9, $da, $f3, $fe        ;; 0d:7b41 ????????
    db   $e7, $e6, $81, $9b, $f1, $81, $85, $9b        ;; 0d:7b49 ????????
    db   $f1, $85, $b9, $9b, $81, $e9, $f1, $81        ;; 0d:7b51 ????????
    db   $85, $b9, $b8, $9b, $e9, $f1, $81, $85        ;; 0d:7b59 ????????
    db   $b9, $9b, $99, $fe, $e9, $ed, $81, $f1        ;; 0d:7b61 ????????
    db   $82, $e4, $f1, $81, $80, $8d, $85, $f1        ;; 0d:7b69 ????????
    db   $80, $81, $9f, $b8, $b7, $e8, $f1, $80        ;; 0d:7b71 ????????
    db   $81, $b0, $b2, $b9, $c4, $e4, $e7             ;; 0d:7b79 ???????

data_0d_7b80:
    db   $81, $f1, $80, $81, $a3, $85, $f1, $81        ;; 0d:7b80 ????????
    db   $80, $8d, $85, $e9, $f1, $80, $81, $8b        ;; 0d:7b88 ????????
    db   $85, $eb, $e9, $f1, $80, $81, $8b, $85        ;; 0d:7b90 ????????
    db   $da, $fe, $eb, $e9, $80, $81, $b8, $e6        ;; 0d:7b98 ????????
    db   $80, $81, $b8, $ad, $e6, $81, $b8, $80        ;; 0d:7ba0 ????????
    db   $ad, $e8, $e6, $80, $81, $b8, $ba, $ad        ;; 0d:7ba8 ????????
    db   $e8, $e6, $80, $81, $ad, $bb, $b9, $db        ;; 0d:7bb0 ????????
    db   $e6, $ea, $8c, $e6, $8c, $ca, $e6, $81        ;; 0d:7bb8 ????????
    db   $80, $af, $ca, $e6, $80, $81, $8d, $af        ;; 0d:7bc0 ????????
    db   $ca, $bb, $e6, $80, $81, $af, $ca, $bb        ;; 0d:7bc8 ????????
    db   $d9, $e6, $ea, $8c, $e6, $8c, $b5, $e4        ;; 0d:7bd0 ????????
    db   $e6, $b3, $b4, $80, $e3, $e4, $e6, $80        ;; 0d:7bd8 ????????
    db   $8c, $ca, $d9, $e3, $e4, $e6, $8c, $b8        ;; 0d:7be0 ????????
    db   $d9, $ca, $fe, $e4, $e6, $ea, $80, $8c        ;; 0d:7be8 ????????
    db   $e6, $80, $81, $e2, $e6, $8c, $b5, $80        ;; 0d:7bf0 ????????
    db   $d9, $ca, $e6, $80, $8c, $b5, $ca, $d9        ;; 0d:7bf8 ????????
    db   $e4, $e6, $8a, $b5, $ca, $9d, $d1, $d9        ;; 0d:7c00 ????????
    db   $e4, $e6                                      ;; 0d:7c08 ??

data_0d_7c0a:
    db   $81, $80, $a1, $e3, $81, $80, $ba, $e3        ;; 0d:7c0a w???????
    db   $ee, $f0, $80, $81, $ce, $c9, $e3, $e4        ;; 0d:7c12 ????????
    db   $81, $8a, $ba, $cb, $d9, $f3, $fe, $ea        ;; 0d:7c1a ????????
    db   $87, $ae, $81, $87, $ae, $81, $ae, $b8        ;; 0d:7c22 ????????
    db   $87, $ce, $e8, $81, $aa, $85, $ae, $b8        ;; 0d:7c2a ????????
    db   $e4, $e7, $87, $88, $d1, $99, $f4, $f3        ;; 0d:7c32 ????????
    db   $e4, $e7, $80, $8c, $e6, $80, $81, $af        ;; 0d:7c3a ????????
    db   $e4, $e6, $81, $80, $b8, $a2, $e4, $e6        ;; 0d:7c42 ????????
    db   $80, $81, $b7, $99, $e0, $e4, $e6, $88        ;; 0d:7c4a ????????
    db   $b5, $99, $d9, $f3, $fe, $e6, $ea, $80        ;; 0d:7c52 ????????
    db   $e6, $f1, $81, $af, $a7, $e6, $f1, $81        ;; 0d:7c5a ????????
    db   $98, $8a, $e3, $e6, $f1, $8a, $81, $98        ;; 0d:7c62 ????????
    db   $b5, $e2, $e1, $e6, $f1, $81, $a0, $d6        ;; 0d:7c6a ????????
    db   $b5, $f3, $e3, $e9, $e6, $80, $fe, $80        ;; 0d:7c72 ????????
    db   $81, $e3, $fe, $81, $80, $d1, $b0, $e3        ;; 0d:7c7a ????????
    db   $fe, $81, $b7, $b6, $99, $9d, $e3, $fe        ;; 0d:7c82 ????????
    db   $80, $81, $b6, $d8, $be, $f4, $99, $fe        ;; 0d:7c8a ????????
    db   $8d, $b0, $c4, $8d, $b0, $b6, $b7, $d1        ;; 0d:7c92 ????????
    db   $b0, $b6, $8d, $b7, $99, $d1, $8d, $93        ;; 0d:7c9a ????????
    db   $b0, $b6, $b7, $db, $d1, $8d, $a4, $ad        ;; 0d:7ca2 ????????
    db   $b5, $b8, $d1, $da, $ea, $86, $86, $88        ;; 0d:7caa ????????
    db   $87, $86, $85, $c3, $b6, $86, $87, $85        ;; 0d:7cb2 ????????
    db   $c3, $b6, $99, $f3, $8a, $85, $b5, $b6        ;; 0d:7cba ????????
    db   $d9, $f3, $ea, $fe, $80, $c3, $80, $c3        ;; 0d:7cc2 ????????
    db   $b7, $e8, $e6, $c3, $b7, $80, $00, $e8        ;; 0d:7cca ????????
    db   $e6, $80, $c3, $b7, $c5, $f3, $e8, $e6        ;; 0d:7cd2 ????????
    db   $8a, $ce, $dc, $c9, $99, $f3, $ea, $e6        ;; 0d:7cda ????????
    db   $c3, $b5, $99, $e6, $c3, $b5, $b6, $99        ;; 0d:7ce2 ????????
    db   $e6, $b5, $c3, $db, $b6, $99, $e6, $c3        ;; 0d:7cea ????????
    db   $b5, $b6, $d9, $99, $f3, $e6, $b7, $b5        ;; 0d:7cf2 ????????
    db   $b6, $dc, $99, $c9, $f3, $e6, $86, $eb        ;; 0d:7cfa ????????
    db   $f0, $86, $af, $eb, $f0, $8a, $96, $a6        ;; 0d:7d02 ????????
    db   $eb, $ec, $f0, $8a, $b5, $b6, $c9, $ee        ;; 0d:7d0a ????????
    db   $eb, $ec, $b5, $b6, $c9, $dc, $f3, $ee        ;; 0d:7d12 ????????
    db   $eb, $ec, $80, $81, $f0, $81, $ab, $ec        ;; 0d:7d1a ????????
    db   $f0, $81, $ab, $d7, $b1, $ee, $ec, $f0        ;; 0d:7d22 ????????
    db   $81, $ab, $d7, $b2, $95, $ee, $ec, $80        ;; 0d:7d2a ????????
    db   $b0, $d7, $b2, $95, $fe, $ee, $ec, $c3        ;; 0d:7d32 ????????
    db   $95, $e6, $f0, $b6, $c3, $95, $e6, $f0        ;; 0d:7d3a ????????
    db   $95, $b6, $c3, $e7, $e6, $f0, $b6, $c5        ;; 0d:7d42 ????????
    db   $95, $99, $eb, $e7, $e6, $d6, $ce, $c9        ;; 0d:7d4a ????????
    db   $95, $99, $eb, $e7, $e6, $01, $01, $32        ;; 0d:7d52 ????????
    db   $04, $ca, $d8, $0b, $e3, $e4, $83, $9a        ;; 0d:7d5a ????????
    db   $9e, $a0, $a5, $e4, $41, $04, $5c, $1e        ;; 0d:7d62 ????????
    db   $4e, $4f, $4f, $50, $51, $02, $4a, $56        ;; 0d:7d6a ????????
    db   $af, $49, $e3, $4f, $50, $51, $52, $53        ;; 0d:7d72 ????????
    db   $54, $69, $d9, $81, $bb, $b9, $f5, $01        ;; 0d:7d7a ????????
    db   $17, $05, $19, $1d, $0a, $0b, $0c, $1a        ;; 0d:7d82 ????????
    db   $1b, $1e, $09, $08, $0d, $1c, $34, $3e        ;; 0d:7d8a ????????
    db   $38, $d9, $81, $ba, $fe, $f5, $4c, $50        ;; 0d:7d92 ????????
    db   $4d, $5b, $5a, $1d, $52, $5f, $5c, $4e        ;; 0d:7d9a ????????
    db   $64, $e3, $6c, $5d, $5f, $60, $5e, $1e        ;; 0d:7da2 ????????
    db   $64, $21, $5d, $6e, $2a, $24, $26, $27        ;; 0d:7daa ????????
    db   $2a, $24, $28, $2b, $2d, $2c, $27, $24        ;; 0d:7db2 ????????
    db   $28, $29, $2b, $2d, $2e, $30, $2f, $71        ;; 0d:7dba ????????
    db   $ec, $71, $b8, $bc, $ec, $71, $6f, $5d        ;; 0d:7dc2 ????????
    db   $6c, $d5, $ec, $71, $6f, $5d, $6c, $60        ;; 0d:7dca ????????
    db   $7e, $ec, $5a, $4a, $49, $ec, $5a, $49        ;; 0d:7dd2 ????????
    db   $ec, $5b, $5f, $e4, $ec, $9a, $bf, $5d        ;; 0d:7dda ????????
    db   $bc, $e4, $ec, $bf, $5d, $bc, $60, $e4        ;; 0d:7de2 ????????
    db   $7e, $ec, $97, $f1, $ac, $97, $f1, $ac        ;; 0d:7dea ????????
    db   $97, $e5, $fe, $eb, $f1, $ac, $97, $e3        ;; 0d:7df2 ????????
    db   $e5, $fe, $eb, $f1, $f6, $f0, $f6, $57        ;; 0d:7dfa ????????
    db   $f0, $e5, $f6, $57, $b2, $f0, $f6, $57        ;; 0d:7e02 ????????
    db   $58, $e3, $e5, $59, $f0, $97, $b7, $99        ;; 0d:7e0a ?????www
    db   $ff, $ff, $ff, $ff, $ff, $00, $17, $28        ;; 0d:7e12 wwwww???
    db   $24, $35, $31, $3a, $ff, $3a, $ff, $ff        ;; 0d:7e1a ????????
    db   $ff, $ff, $ff, $ff, $ff, $00, $17, $35        ;; 0d:7e22 ????????
    db   $31, $3a, $ff, $ff, $ff, $4f, $50, $ff        ;; 0d:7e2a ????????
    db   $ff, $ff, $ff, $ff, $ff, $05, $5a, $49        ;; 0d:7e32 ????????
    db   $64, $24, $ff, $ff, $ff, $51, $52, $ff        ;; 0d:7e3a ????????
    db   $ff, $ff, $ff, $ff, $ff, $66, $67, $68        ;; 0d:7e42 ????????
    db   $55, $ff, $ff, $ff, $ff, $6a, $04, $3e        ;; 0d:7e4a ????????
    db   $68, $69, $24, $ff, $ff, $0d, $5d, $4e        ;; 0d:7e52 ????????
    db   $75, $2f, $24, $ff, $ff, $7a, $7b, $7c        ;; 0d:7e5a ????????
    db   $fb, $7d, $dc, $f5, $fe, $85, $da, $dc        ;; 0d:7e62 ????????
    db   $7f, $f5, $fe, $d5, $8f, $db, $81, $b5        ;; 0d:7e6a ????????
    db   $8d, $e6, $e8, $80, $a1, $ba, $e4, $e3        ;; 0d:7e72 ????????
    db   $60, $61, $85, $ab, $ec, $01, $35, $0f        ;; 0d:7e7a ?????ww?
    db   $35, $00, $ba, $35, $15, $b8, $35, $4c        ;; 0d:7e82 ????wwww
    db   $ec, $97, $f0, $80, $b8, $e6, $80, $c3        ;; 0d:7e8a w??www??
    db   $a4, $b8, $c3, $a6, $ea, $d1, $49, $b8        ;; 0d:7e92 ????????
    db   $c9, $ea, $e0, $cd, $c2, $04, $e7, $04        ;; 0d:7e9a ????????
    db   $b5, $d9, $5d, $c5, $e7, $6b, $bb, $b6        ;; 0d:7ea2 ????????
    db   $99, $e7, $b8, $b9, $d9, $ba, $bb, $fc        ;; 0d:7eaa ????????
    db   $f5, $fd, $e7                                 ;; 0d:7eb2 ???
