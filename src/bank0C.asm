;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank0c", ROMX[$4000], BANK[$0c]

call_0c_4000:
    ld   A, $b1                                        ;; 0c:4000 $3e $b1
    ld   [wC1AF], A                                    ;; 0c:4002 $ea $af $c1
    ld   A, $c1                                        ;; 0c:4005 $3e $c1
    ld   [wC1B0], A                                    ;; 0c:4007 $ea $b0 $c1

jp_0c_400a:
    ld   A, [DE]                                       ;; 0c:400a $1a
    and  A, $1f                                        ;; 0c:400b $e6 $1f
    cp   A, $1f                                        ;; 0c:400d $fe $1f
    ret  Z                                             ;; 0c:400f $c8
    add  A, A                                          ;; 0c:4010 $87
    add  A, $2d                                        ;; 0c:4011 $c6 $2d
    ld   L, A                                          ;; 0c:4013 $6f
    ld   A, $00                                        ;; 0c:4014 $3e $00
    adc  A, $40                                        ;; 0c:4016 $ce $40
    ld   H, A                                          ;; 0c:4018 $67
    ld   A, [HL+]                                      ;; 0c:4019 $2a
    ld   H, [HL]                                       ;; 0c:401a $66
    ld   L, A                                          ;; 0c:401b $6f
    jp   HL                                            ;; 0c:401c $e9

jp_0c_401d:
    ld   A, [DE]                                       ;; 0c:401d $1a
    and  A, $1f                                        ;; 0c:401e $e6 $1f
    add  A, A                                          ;; 0c:4020 $87
    add  A, $29                                        ;; 0c:4021 $c6 $29
    ld   L, A                                          ;; 0c:4023 $6f
    ld   A, $00                                        ;; 0c:4024 $3e $00
    adc  A, $41                                        ;; 0c:4026 $ce $41
    ld   H, A                                          ;; 0c:4028 $67
    ld   A, [HL+]                                      ;; 0c:4029 $2a
    ld   H, [HL]                                       ;; 0c:402a $66
    ld   L, A                                          ;; 0c:402b $6f
    jp   HL                                            ;; 0c:402c $e9
    dw   .data_0c_4084                                 ;; 0c:402d pP
    dw   .data_0c_40b6                                 ;; 0c:402f pP
    dw   .data_0c_4104                                 ;; 0c:4031 pP
    dw   .data_0c_410e                                 ;; 0c:4033 pP
    db   $20, $41                                      ;; 0c:4035 ??
    dw   .data_0c_40cd                                 ;; 0c:4037 pP
    dw   .data_0c_40ed                                 ;; 0c:4039 pP
    dw   .data_0c_4041                                 ;; 0c:403b pP
    dw   .data_0c_4041                                 ;; 0c:403d pP
    dw   .data_0c_40be                                 ;; 0c:403f pP
.data_0c_4041:
    ld   A, [DE]                                       ;; 0c:4041 $1a
    swap A                                             ;; 0c:4042 $cb $37
    srl  A                                             ;; 0c:4044 $cb $3f
    and  A, $07                                        ;; 0c:4046 $e6 $07
    inc  A                                             ;; 0c:4048 $3c
    ld   C, A                                          ;; 0c:4049 $4f
    ld   A, [DE]                                       ;; 0c:404a $1a
    and  A, $1f                                        ;; 0c:404b $e6 $1f
    ld   B, A                                          ;; 0c:404d $47
    inc  DE                                            ;; 0c:404e $13
    ld   A, [DE]                                       ;; 0c:404f $1a
    ld   L, A                                          ;; 0c:4050 $6f
    inc  DE                                            ;; 0c:4051 $13
    ld   H, $cf                                        ;; 0c:4052 $26 $cf
    ld   A, B                                          ;; 0c:4054 $78
    cp   A, $08                                        ;; 0c:4055 $fe $08
    jr   Z, .jr_0c_406a                                ;; 0c:4057 $28 $11
    inc  [HL]                                          ;; 0c:4059 $34
    jr   NZ, .jr_0c_4081                               ;; 0c:405a $20 $25
    dec  C                                             ;; 0c:405c $0d
    jr   Z, .jr_0c_4081                                ;; 0c:405d $28 $22
    inc  HL                                            ;; 0c:405f $23
    inc  [HL]                                          ;; 0c:4060 $34
    jr   NZ, .jr_0c_4081                               ;; 0c:4061 $20 $1e
    dec  C                                             ;; 0c:4063 $0d
    jr   Z, .jr_0c_4081                                ;; 0c:4064 $28 $1b
    inc  HL                                            ;; 0c:4066 $23
    inc  [HL]                                          ;; 0c:4067 $34
    jr   .jr_0c_4081                                   ;; 0c:4068 $18 $17
.jr_0c_406a:
    dec  [HL]                                          ;; 0c:406a $35
    ld   A, [HL]                                       ;; 0c:406b $7e
    cp   A, $ff                                        ;; 0c:406c $fe $ff
    jr   NZ, .jr_0c_4081                               ;; 0c:406e $20 $11
    dec  C                                             ;; 0c:4070 $0d
    jr   Z, .jr_0c_4081                                ;; 0c:4071 $28 $0e
    inc  HL                                            ;; 0c:4073 $23
    dec  [HL]                                          ;; 0c:4074 $35
    ld   A, [HL]                                       ;; 0c:4075 $7e
    cp   A, $ff                                        ;; 0c:4076 $fe $ff
    jr   NZ, .jr_0c_4081                               ;; 0c:4078 $20 $07
    dec  C                                             ;; 0c:407a $0d
    jr   Z, .jr_0c_4081                                ;; 0c:407b $28 $04
    inc  HL                                            ;; 0c:407d $23
    dec  [HL]                                          ;; 0c:407e $35
    jr   .jr_0c_4081                                   ;; 0c:407f $18 $00
.jr_0c_4081:
    jp   jp_0c_400a                                    ;; 0c:4081 $c3 $0a $40
.data_0c_4084:
    ld   A, [DE]                                       ;; 0c:4084 $1a
    swap A                                             ;; 0c:4085 $cb $37
    srl  A                                             ;; 0c:4087 $cb $3f
    and  A, $07                                        ;; 0c:4089 $e6 $07
    ld   C, A                                          ;; 0c:408b $4f
    inc  DE                                            ;; 0c:408c $13
    ld   A, [DE]                                       ;; 0c:408d $1a
    ld   L, A                                          ;; 0c:408e $6f
    inc  DE                                            ;; 0c:408f $13
    ld   H, $cf                                        ;; 0c:4090 $26 $cf
    ld   A, C                                          ;; 0c:4092 $79
    cp   A, $03                                        ;; 0c:4093 $fe $03
    jr   C, .jr_0c_40a3                                ;; 0c:4095 $38 $0c
    cp   A, $05                                        ;; 0c:4097 $fe $05
    jr   NC, .jr_0c_40a0                               ;; 0c:4099 $30 $05
    ld   A, [HL+]                                      ;; 0c:409b $2a
    ld   H, [HL]                                       ;; 0c:409c $66
    ld   L, A                                          ;; 0c:409d $6f
    jr   .jr_0c_40a3                                   ;; 0c:409e $18 $03
.jr_0c_40a0:
    ld   A, [DE]                                       ;; 0c:40a0 $1a
    ld   H, A                                          ;; 0c:40a1 $67
    inc  DE                                            ;; 0c:40a2 $13
.jr_0c_40a3:
    ld   A, L                                          ;; 0c:40a3 $7d
    ld   [wC1A1], A                                    ;; 0c:40a4 $ea $a1 $c1
    ld   A, H                                          ;; 0c:40a7 $7c
    ld   [wC1A2], A                                    ;; 0c:40a8 $ea $a2 $c1
    ld   A, C                                          ;; 0c:40ab $79
    ld   [wC1A3], A                                    ;; 0c:40ac $ea $a3 $c1
    xor  A, A                                          ;; 0c:40af $af
    ld   [wC1A4], A                                    ;; 0c:40b0 $ea $a4 $c1
    jp   jp_0c_401d                                    ;; 0c:40b3 $c3 $1d $40
.data_0c_40b6:
    ld   A, $01                                        ;; 0c:40b6 $3e $01
    ld   [wC1A4], A                                    ;; 0c:40b8 $ea $a4 $c1
    jp   jp_0c_424f                                    ;; 0c:40bb $c3 $4f $42
.data_0c_40be:
    inc  DE                                            ;; 0c:40be $13
    ld   A, [DE]                                       ;; 0c:40bf $1a
    ld   C, A                                          ;; 0c:40c0 $4f
    inc  DE                                            ;; 0c:40c1 $13
    ld   B, $cf                                        ;; 0c:40c2 $06 $cf
    ld   A, [BC]                                       ;; 0c:40c4 $0a
    push AF                                            ;; 0c:40c5 $f5
    inc  BC                                            ;; 0c:40c6 $03
    ld   A, [BC]                                       ;; 0c:40c7 $0a
    ld   B, A                                          ;; 0c:40c8 $47
    pop  AF                                            ;; 0c:40c9 $f1
    ld   C, A                                          ;; 0c:40ca $4f
    jr   .jr_0c_40d4                                   ;; 0c:40cb $18 $07
.data_0c_40cd:
    inc  DE                                            ;; 0c:40cd $13
    ld   A, [DE]                                       ;; 0c:40ce $1a
    ld   C, A                                          ;; 0c:40cf $4f
    inc  DE                                            ;; 0c:40d0 $13
    ld   A, [DE]                                       ;; 0c:40d1 $1a
    ld   B, A                                          ;; 0c:40d2 $47
    inc  DE                                            ;; 0c:40d3 $13
.jr_0c_40d4:
    ld   A, [wC1AF]                                    ;; 0c:40d4 $fa $af $c1
    ld   L, A                                          ;; 0c:40d7 $6f
    ld   A, [wC1B0]                                    ;; 0c:40d8 $fa $b0 $c1
    ld   H, A                                          ;; 0c:40db $67
    ld   [HL], E                                       ;; 0c:40dc $73
    inc  HL                                            ;; 0c:40dd $23
    ld   [HL], D                                       ;; 0c:40de $72
    inc  HL                                            ;; 0c:40df $23
    ld   A, L                                          ;; 0c:40e0 $7d
    ld   [wC1AF], A                                    ;; 0c:40e1 $ea $af $c1
    ld   A, H                                          ;; 0c:40e4 $7c
    ld   [wC1B0], A                                    ;; 0c:40e5 $ea $b0 $c1
    ld   D, B                                          ;; 0c:40e8 $50
    ld   E, C                                          ;; 0c:40e9 $59
    jp   jp_0c_400a                                    ;; 0c:40ea $c3 $0a $40
.data_0c_40ed:
    ld   A, [wC1AF]                                    ;; 0c:40ed $fa $af $c1
    ld   L, A                                          ;; 0c:40f0 $6f
    ld   A, [wC1B0]                                    ;; 0c:40f1 $fa $b0 $c1
    ld   H, A                                          ;; 0c:40f4 $67
    dec  HL                                            ;; 0c:40f5 $2b
    ld   D, [HL]                                       ;; 0c:40f6 $56
    dec  HL                                            ;; 0c:40f7 $2b
    ld   E, [HL]                                       ;; 0c:40f8 $5e
    ld   A, L                                          ;; 0c:40f9 $7d
    ld   [wC1AF], A                                    ;; 0c:40fa $ea $af $c1
    ld   A, H                                          ;; 0c:40fd $7c
    ld   [wC1B0], A                                    ;; 0c:40fe $ea $b0 $c1
    jp   jp_0c_400a                                    ;; 0c:4101 $c3 $0a $40
.data_0c_4104:
    inc  DE                                            ;; 0c:4104 $13
    ld   A, [DE]                                       ;; 0c:4105 $1a
    ld   C, A                                          ;; 0c:4106 $4f
    inc  DE                                            ;; 0c:4107 $13
    ld   A, [DE]                                       ;; 0c:4108 $1a
    ld   D, A                                          ;; 0c:4109 $57
    ld   E, C                                          ;; 0c:410a $59
    jp   jp_0c_400a                                    ;; 0c:410b $c3 $0a $40
.data_0c_410e:
    inc  DE                                            ;; 0c:410e $13
    ld   A, [DE]                                       ;; 0c:410f $1a
    ld   C, A                                          ;; 0c:4110 $4f
    inc  DE                                            ;; 0c:4111 $13
    ld   A, [DE]                                       ;; 0c:4112 $1a
    inc  DE                                            ;; 0c:4113 $13
    ld   B, A                                          ;; 0c:4114 $47
    push DE                                            ;; 0c:4115 $d5
    ld   HL, .data_0c_411c                             ;; 0c:4116 $21 $1c $41
    push HL                                            ;; 0c:4119 $e5
    push BC                                            ;; 0c:411a $c5
    ret                                                ;; 0c:411b $c9
.data_0c_411c:
    pop  DE                                            ;; 0c:411c $d1
    jp   jp_0c_400a                                    ;; 0c:411d $c3 $0a $40
    db   $13, $1a, $ea, $a0, $c1, $13, $c3, $0a        ;; 0c:4120 ????????
    db   $40, $4f, $42                                 ;; 0c:4128 ???
    dw   data_0c_4264                                  ;; 0c:412b pP
    dw   data_0c_42cd                                  ;; 0c:412d pP
    dw   data_0c_4320                                  ;; 0c:412f pP
    dw   data_0c_4331                                  ;; 0c:4131 pP
    dw   data_0c_435c                                  ;; 0c:4133 pP
    dw   data_0c_4375                                  ;; 0c:4135 pP
    db   $8e, $43, $aa, $43, $c3, $43                  ;; 0c:4137 ??????
    dw   data_0c_43dc                                  ;; 0c:413d pP
    db   $f4, $43                                      ;; 0c:413f ??
    dw   data_0c_440c                                  ;; 0c:4141 pP
    dw   data_0c_440c                                  ;; 0c:4143 pP
    dw   data_0c_440c                                  ;; 0c:4145 pP
    dw   data_0c_440c                                  ;; 0c:4147 pP
    dw   data_0c_440c                                  ;; 0c:4149 pP
    dw   data_0c_4342                                  ;; 0c:414b pP
    dw   data_0c_440c                                  ;; 0c:414d pP
    dw   data_0c_440c                                  ;; 0c:414f pP
    db   $4f, $42, $4f, $42, $4f, $42, $4f, $42        ;; 0c:4151 ????????
    db   $4f, $42, $4f, $42, $4f, $42, $4f, $42        ;; 0c:4159 ????????
    db   $4f, $42, $4f, $42, $4f, $42                  ;; 0c:4161 ??????
    dw   .data_0c_4169                                 ;; 0c:4167 pP
.data_0c_4169:
    inc  DE                                            ;; 0c:4169 $13
    ld   A, [wC1A4]                                    ;; 0c:416a $fa $a4 $c1
    or   A, A                                          ;; 0c:416d $b7
    jr   Z, .jr_0c_41ba                                ;; 0c:416e $28 $4a
    push DE                                            ;; 0c:4170 $d5
    ld   DE, wC1AC                                     ;; 0c:4171 $11 $ac $c1
    ld   HL, wC1A5                                     ;; 0c:4174 $21 $a5 $c1
    call call_00_0168                                  ;; 0c:4177 $cd $68 $01
    pop  DE                                            ;; 0c:417a $d1
    jr   Z, .jr_0c_418e                                ;; 0c:417b $28 $11
    jr   C, .jr_0c_41a7                                ;; 0c:417d $38 $28
    ld   A, [wC1A4]                                    ;; 0c:417f $fa $a4 $c1
    cp   A, $0e                                        ;; 0c:4182 $fe $0e
    jp   Z, jp_0c_400a                                 ;; 0c:4184 $ca $0a $40
    cp   A, $10                                        ;; 0c:4187 $fe $10
    jp   Z, jp_0c_400a                                 ;; 0c:4189 $ca $0a $40
    jr   .jr_0c_41b4                                   ;; 0c:418c $18 $26
.jr_0c_418e:
    ld   A, [wC1A4]                                    ;; 0c:418e $fa $a4 $c1
    cp   A, $0c                                        ;; 0c:4191 $fe $0c
    jp   Z, jp_0c_400a                                 ;; 0c:4193 $ca $0a $40
    cp   A, $13                                        ;; 0c:4196 $fe $13
    jp   Z, jp_0c_400a                                 ;; 0c:4198 $ca $0a $40
    cp   A, $0f                                        ;; 0c:419b $fe $0f
    jp   Z, jp_0c_400a                                 ;; 0c:419d $ca $0a $40
    cp   A, $10                                        ;; 0c:41a0 $fe $10
    jp   Z, jp_0c_400a                                 ;; 0c:41a2 $ca $0a $40
    jr   .jr_0c_41b4                                   ;; 0c:41a5 $18 $0d
.jr_0c_41a7:
    ld   A, [wC1A4]                                    ;; 0c:41a7 $fa $a4 $c1
    cp   A, $0d                                        ;; 0c:41aa $fe $0d
    jp   Z, jp_0c_400a                                 ;; 0c:41ac $ca $0a $40
    cp   A, $0f                                        ;; 0c:41af $fe $0f
    jp   Z, jp_0c_400a                                 ;; 0c:41b1 $ca $0a $40
.jr_0c_41b4:
    call call_0c_41eb                                  ;; 0c:41b4 $cd $eb $41
    jp   jp_0c_400a                                    ;; 0c:41b7 $c3 $0a $40
.jr_0c_41ba:
    push DE                                            ;; 0c:41ba $d5
    ld   A, [wC1A3]                                    ;; 0c:41bb $fa $a3 $c1
    cp   A, $03                                        ;; 0c:41be $fe $03
    jr   C, .jr_0c_41cc                                ;; 0c:41c0 $38 $0a
    cp   A, $05                                        ;; 0c:41c2 $fe $05
    jr   NC, .jr_0c_41ca                               ;; 0c:41c4 $30 $04
    sub  A, $03                                        ;; 0c:41c6 $d6 $03
    jr   .jr_0c_41cc                                   ;; 0c:41c8 $18 $02
.jr_0c_41ca:
    sub  A, $05                                        ;; 0c:41ca $d6 $05
.jr_0c_41cc:
    inc  A                                             ;; 0c:41cc $3c
    ld   C, A                                          ;; 0c:41cd $4f
    ld   A, [wC1A1]                                    ;; 0c:41ce $fa $a1 $c1
    ld   L, A                                          ;; 0c:41d1 $6f
    ld   A, [wC1A2]                                    ;; 0c:41d2 $fa $a2 $c1
    ld   H, A                                          ;; 0c:41d5 $67
    ld   DE, wC1A5                                     ;; 0c:41d6 $11 $a5 $c1
    ld   A, [DE]                                       ;; 0c:41d9 $1a
    inc  DE                                            ;; 0c:41da $13
    ld   [HL+], A                                      ;; 0c:41db $22
    dec  C                                             ;; 0c:41dc $0d
    jr   Z, .jr_0c_41e7                                ;; 0c:41dd $28 $08
    ld   A, [DE]                                       ;; 0c:41df $1a
    inc  DE                                            ;; 0c:41e0 $13
    ld   [HL+], A                                      ;; 0c:41e1 $22
    dec  C                                             ;; 0c:41e2 $0d
    jr   Z, .jr_0c_41e7                                ;; 0c:41e3 $28 $02
    ld   A, [DE]                                       ;; 0c:41e5 $1a
    ld   [HL], A                                       ;; 0c:41e6 $77
.jr_0c_41e7:
    pop  DE                                            ;; 0c:41e7 $d1
    jp   jp_0c_400a                                    ;; 0c:41e8 $c3 $0a $40

call_0c_41eb:
    ld   A, [DE]                                       ;; 0c:41eb $1a
    ld   C, A                                          ;; 0c:41ec $4f
    and  A, $1f                                        ;; 0c:41ed $e6 $1f
    cp   A, $1f                                        ;; 0c:41ef $fe $1f
    jr   Z, .jp_0c_4221                                ;; 0c:41f1 $28 $2e
    add  A, A                                          ;; 0c:41f3 $87
    add  A, $23                                        ;; 0c:41f4 $c6 $23
    ld   C, A                                          ;; 0c:41f6 $4f
    ld   A, $42                                        ;; 0c:41f7 $3e $42
    adc  A, $00                                        ;; 0c:41f9 $ce $00
    ld   B, A                                          ;; 0c:41fb $47
    ld   A, [BC]                                       ;; 0c:41fc $0a
    push AF                                            ;; 0c:41fd $f5
    inc  BC                                            ;; 0c:41fe $03
    ld   A, [BC]                                       ;; 0c:41ff $0a
    ld   B, A                                          ;; 0c:4200 $47
    pop  AF                                            ;; 0c:4201 $f1
    ld   C, A                                          ;; 0c:4202 $4f
    push BC                                            ;; 0c:4203 $c5
    ret                                                ;; 0c:4204 $c9
.jp_0c_4205:
    ld   A, [DE]                                       ;; 0c:4205 $1a
    ld   C, A                                          ;; 0c:4206 $4f
    and  A, $1f                                        ;; 0c:4207 $e6 $1f
    cp   A, $1f                                        ;; 0c:4209 $fe $1f
    jr   Z, .jp_0c_4221                                ;; 0c:420b $28 $14
    ld   A, C                                          ;; 0c:420d $79
    and  A, $1f                                        ;; 0c:420e $e6 $1f
    cp   A, $13                                        ;; 0c:4210 $fe $13
    jr   Z, .jr_0c_4244                                ;; 0c:4212 $28 $30
    ld   A, C                                          ;; 0c:4214 $79
    swap A                                             ;; 0c:4215 $cb $37
    srl  A                                             ;; 0c:4217 $cb $3f
    and  A, $07                                        ;; 0c:4219 $e6 $07
    cp   A, $07                                        ;; 0c:421b $fe $07
    jr   Z, .jr_0c_4244                                ;; 0c:421d $28 $25
    jr   .jr_0c_4245                                   ;; 0c:421f $18 $24
.jp_0c_4221:
    inc  DE                                            ;; 0c:4221 $13
    ret                                                ;; 0c:4222 $c9
    dw   .data_0c_4239                                 ;; 0c:4223 pP
    db   $0d, $42                                      ;; 0c:4225 ??
    dw   .data_0c_424a                                 ;; 0c:4227 pP
    db   $4a, $42, $4b, $42                            ;; 0c:4229 ????
    dw   .data_0c_424a                                 ;; 0c:422d pP
    dw   .jp_0c_4221                                   ;; 0c:422f pP
    dw   .data_0c_424b                                 ;; 0c:4231 pP
    db   $4b, $42, $4b, $42, $21, $42                  ;; 0c:4233 ??????
.data_0c_4239:
    ld   A, [DE]                                       ;; 0c:4239 $1a
    swap A                                             ;; 0c:423a $cb $37
    srl  A                                             ;; 0c:423c $cb $3f
    and  A, $07                                        ;; 0c:423e $e6 $07
    cp   A, $05                                        ;; 0c:4240 $fe $05
    jr   C, .jr_0c_4245                                ;; 0c:4242 $38 $01
.jr_0c_4244:
    inc  DE                                            ;; 0c:4244 $13
.jr_0c_4245:
    inc  DE                                            ;; 0c:4245 $13
    inc  DE                                            ;; 0c:4246 $13
    jp   .jp_0c_4205                                   ;; 0c:4247 $c3 $05 $42
.data_0c_424a:
    inc  DE                                            ;; 0c:424a $13
.data_0c_424b:
    inc  DE                                            ;; 0c:424b $13
    jp   .jp_0c_4221                                   ;; 0c:424c $c3 $21 $42

jp_0c_424f:
    call call_0c_4476                                  ;; 0c:424f $cd $76 $44
    ld   HL, wC1A5                                     ;; 0c:4252 $21 $a5 $c1
    ld   BC, wC1A8                                     ;; 0c:4255 $01 $a8 $c1
    ld   A, [BC]                                       ;; 0c:4258 $0a
    inc  BC                                            ;; 0c:4259 $03
    ld   [HL+], A                                      ;; 0c:425a $22
    ld   A, [BC]                                       ;; 0c:425b $0a
    inc  BC                                            ;; 0c:425c $03
    ld   [HL+], A                                      ;; 0c:425d $22
    ld   A, [BC]                                       ;; 0c:425e $0a
    inc  BC                                            ;; 0c:425f $03
    ld   [HL], A                                       ;; 0c:4260 $77
    jp   jp_0c_401d                                    ;; 0c:4261 $c3 $1d $40

data_0c_4264:
    call call_0c_4476                                  ;; 0c:4264 $cd $76 $44
    ld   HL, wC1A7                                     ;; 0c:4267 $21 $a7 $c1
    ld   A, [HL]                                       ;; 0c:426a $7e
    ld   [wC1AB], A                                    ;; 0c:426b $ea $ab $c1
    call call_0c_42b9                                  ;; 0c:426e $cd $b9 $42
    ld   HL, wC1AA                                     ;; 0c:4271 $21 $aa $c1
    ld   A, [wC1AB]                                    ;; 0c:4274 $fa $ab $c1
    xor  A, [HL]                                       ;; 0c:4277 $ae
    ld   [wC1AB], A                                    ;; 0c:4278 $ea $ab $c1
    call call_0c_42b9                                  ;; 0c:427b $cd $b9 $42
    ld   A, [wC1A5]                                    ;; 0c:427e $fa $a5 $c1
    ld   L, A                                          ;; 0c:4281 $6f
    ld   A, [wC1A6]                                    ;; 0c:4282 $fa $a6 $c1
    ld   H, A                                          ;; 0c:4285 $67
    push DE                                            ;; 0c:4286 $d5
    ld   A, [wC1A8]                                    ;; 0c:4287 $fa $a8 $c1
    ld   E, A                                          ;; 0c:428a $5f
    ld   A, [wC1A9]                                    ;; 0c:428b $fa $a9 $c1
    ld   D, A                                          ;; 0c:428e $57
    call call_00_015c                                  ;; 0c:428f $cd $5c $01
    ld   A, [wC1AB]                                    ;; 0c:4292 $fa $ab $c1
    and  A, $80                                        ;; 0c:4295 $e6 $80
    jr   Z, .jr_0c_42a9                                ;; 0c:4297 $28 $10
    ld   A, E                                          ;; 0c:4299 $7b
    cpl                                                ;; 0c:429a $2f
    ld   E, A                                          ;; 0c:429b $5f
    ld   A, D                                          ;; 0c:429c $7a
    cpl                                                ;; 0c:429d $2f
    ld   D, A                                          ;; 0c:429e $57
    ld   A, L                                          ;; 0c:429f $7d
    cpl                                                ;; 0c:42a0 $2f
    ld   L, A                                          ;; 0c:42a1 $6f
    inc  E                                             ;; 0c:42a2 $1c
    jr   NZ, .jr_0c_42a9                               ;; 0c:42a3 $20 $04
    inc  D                                             ;; 0c:42a5 $14
    jr   NZ, .jr_0c_42a9                               ;; 0c:42a6 $20 $01
    inc  L                                             ;; 0c:42a8 $2c
.jr_0c_42a9:
    ld   A, E                                          ;; 0c:42a9 $7b
    ld   [wC1A5], A                                    ;; 0c:42aa $ea $a5 $c1
    ld   A, D                                          ;; 0c:42ad $7a
    ld   [wC1A6], A                                    ;; 0c:42ae $ea $a6 $c1
    ld   A, L                                          ;; 0c:42b1 $7d
    ld   [wC1A7], A                                    ;; 0c:42b2 $ea $a7 $c1
    pop  DE                                            ;; 0c:42b5 $d1
    jp   jp_0c_401d                                    ;; 0c:42b6 $c3 $1d $40

call_0c_42b9:
    ld   A, [HL]                                       ;; 0c:42b9 $7e
    bit  7, A                                          ;; 0c:42ba $cb $7f
    ret  Z                                             ;; 0c:42bc $c8
    cpl                                                ;; 0c:42bd $2f
    ld   [HL-], A                                      ;; 0c:42be $32
    ld   A, [HL]                                       ;; 0c:42bf $7e
    cpl                                                ;; 0c:42c0 $2f
    ld   [HL-], A                                      ;; 0c:42c1 $32
    ld   A, [HL]                                       ;; 0c:42c2 $7e
    cpl                                                ;; 0c:42c3 $2f
    inc  A                                             ;; 0c:42c4 $3c
    ld   [HL], A                                       ;; 0c:42c5 $77
    ret  NZ                                            ;; 0c:42c6 $c0
    inc  HL                                            ;; 0c:42c7 $23
    inc  [HL]                                          ;; 0c:42c8 $34
    ret  NZ                                            ;; 0c:42c9 $c0
    inc  HL                                            ;; 0c:42ca $23
    inc  [HL]                                          ;; 0c:42cb $34
    ret                                                ;; 0c:42cc $c9

data_0c_42cd:
    call call_0c_4476                                  ;; 0c:42cd $cd $76 $44
    ld   HL, wC1A7                                     ;; 0c:42d0 $21 $a7 $c1
    ld   A, [HL]                                       ;; 0c:42d3 $7e
    ld   [wC1AB], A                                    ;; 0c:42d4 $ea $ab $c1
    call call_0c_42b9                                  ;; 0c:42d7 $cd $b9 $42
    ld   HL, wC1AA                                     ;; 0c:42da $21 $aa $c1
    ld   A, [wC1AB]                                    ;; 0c:42dd $fa $ab $c1
    xor  A, [HL]                                       ;; 0c:42e0 $ae
    ld   [wC1AB], A                                    ;; 0c:42e1 $ea $ab $c1
    call call_0c_42b9                                  ;; 0c:42e4 $cd $b9 $42
    ld   A, [wC1A5]                                    ;; 0c:42e7 $fa $a5 $c1
    ld   L, A                                          ;; 0c:42ea $6f
    ld   A, [wC1A6]                                    ;; 0c:42eb $fa $a6 $c1
    ld   H, A                                          ;; 0c:42ee $67
    push DE                                            ;; 0c:42ef $d5
    ld   A, [wC1A8]                                    ;; 0c:42f0 $fa $a8 $c1
    ld   E, A                                          ;; 0c:42f3 $5f
    ld   A, [wC1A9]                                    ;; 0c:42f4 $fa $a9 $c1
    ld   D, A                                          ;; 0c:42f7 $57
    call call_00_015f                                  ;; 0c:42f8 $cd $5f $01
    ld   E, $00                                        ;; 0c:42fb $1e $00
    ld   A, [wC1AB]                                    ;; 0c:42fd $fa $ab $c1
    and  A, $80                                        ;; 0c:4300 $e6 $80
    jr   Z, .jr_0c_4310                                ;; 0c:4302 $28 $0c
    ld   E, $ff                                        ;; 0c:4304 $1e $ff
    ld   A, L                                          ;; 0c:4306 $7d
    cpl                                                ;; 0c:4307 $2f
    ld   L, A                                          ;; 0c:4308 $6f
    ld   A, H                                          ;; 0c:4309 $7c
    cpl                                                ;; 0c:430a $2f
    ld   H, A                                          ;; 0c:430b $67
    inc  L                                             ;; 0c:430c $2c
    jr   NZ, .jr_0c_4310                               ;; 0c:430d $20 $01
    inc  H                                             ;; 0c:430f $24
.jr_0c_4310:
    ld   A, L                                          ;; 0c:4310 $7d
    ld   [wC1A5], A                                    ;; 0c:4311 $ea $a5 $c1
    ld   A, H                                          ;; 0c:4314 $7c
    ld   [wC1A6], A                                    ;; 0c:4315 $ea $a6 $c1
    ld   A, E                                          ;; 0c:4318 $7b
    ld   [wC1A7], A                                    ;; 0c:4319 $ea $a7 $c1
    pop  DE                                            ;; 0c:431c $d1
    jp   jp_0c_401d                                    ;; 0c:431d $c3 $1d $40

data_0c_4320:
    call call_0c_4476                                  ;; 0c:4320 $cd $76 $44
    push DE                                            ;; 0c:4323 $d5
    ld   DE, wC1A5                                     ;; 0c:4324 $11 $a5 $c1
    ld   HL, wC1A8                                     ;; 0c:4327 $21 $a8 $c1
    call call_00_0162                                  ;; 0c:432a $cd $62 $01
    pop  DE                                            ;; 0c:432d $d1
    jp   jp_0c_401d                                    ;; 0c:432e $c3 $1d $40

data_0c_4331:
    call call_0c_4476                                  ;; 0c:4331 $cd $76 $44
    push DE                                            ;; 0c:4334 $d5
    ld   DE, wC1A5                                     ;; 0c:4335 $11 $a5 $c1
    ld   HL, wC1A8                                     ;; 0c:4338 $21 $a8 $c1
    call call_00_0165                                  ;; 0c:433b $cd $65 $01
    pop  DE                                            ;; 0c:433e $d1
    jp   jp_0c_401d                                    ;; 0c:433f $c3 $1d $40

data_0c_4342:
    call call_0c_4476                                  ;; 0c:4342 $cd $76 $44
    push DE                                            ;; 0c:4345 $d5
    ld   DE, wC1A5                                     ;; 0c:4346 $11 $a5 $c1
    ld   HL, wC1A8                                     ;; 0c:4349 $21 $a8 $c1
    call call_00_0165                                  ;; 0c:434c $cd $65 $01
    jr   NC, .jr_0c_4358                               ;; 0c:434f $30 $07
    ld   HL, wC1A5                                     ;; 0c:4351 $21 $a5 $c1
    xor  A, A                                          ;; 0c:4354 $af
    ld   [HL+], A                                      ;; 0c:4355 $22
    ld   [HL+], A                                      ;; 0c:4356 $22
    ld   [HL], A                                       ;; 0c:4357 $77
.jr_0c_4358:
    pop  DE                                            ;; 0c:4358 $d1
    jp   jp_0c_401d                                    ;; 0c:4359 $c3 $1d $40

data_0c_435c:
    call call_0c_4476                                  ;; 0c:435c $cd $76 $44
    push DE                                            ;; 0c:435f $d5
    ld   HL, wC1A5                                     ;; 0c:4360 $21 $a5 $c1
    ld   DE, wC1A8                                     ;; 0c:4363 $11 $a8 $c1
    ld   A, [DE]                                       ;; 0c:4366 $1a
    and  A, [HL]                                       ;; 0c:4367 $a6
    ld   [HL+], A                                      ;; 0c:4368 $22
    inc  DE                                            ;; 0c:4369 $13
    ld   A, [DE]                                       ;; 0c:436a $1a
    and  A, [HL]                                       ;; 0c:436b $a6
    ld   [HL+], A                                      ;; 0c:436c $22
    inc  DE                                            ;; 0c:436d $13
    ld   A, [DE]                                       ;; 0c:436e $1a
    and  A, [HL]                                       ;; 0c:436f $a6
    ld   [HL], A                                       ;; 0c:4370 $77
    pop  DE                                            ;; 0c:4371 $d1
    jp   jp_0c_401d                                    ;; 0c:4372 $c3 $1d $40

data_0c_4375:
    call call_0c_4476                                  ;; 0c:4375 $cd $76 $44
    push DE                                            ;; 0c:4378 $d5
    ld   HL, wC1A5                                     ;; 0c:4379 $21 $a5 $c1
    ld   DE, wC1A8                                     ;; 0c:437c $11 $a8 $c1
    ld   A, [DE]                                       ;; 0c:437f $1a
    or   A, [HL]                                       ;; 0c:4380 $b6
    ld   [HL+], A                                      ;; 0c:4381 $22
    inc  DE                                            ;; 0c:4382 $13
    ld   A, [DE]                                       ;; 0c:4383 $1a
    or   A, [HL]                                       ;; 0c:4384 $b6
    ld   [HL+], A                                      ;; 0c:4385 $22
    inc  DE                                            ;; 0c:4386 $13
    ld   A, [DE]                                       ;; 0c:4387 $1a
    or   A, [HL]                                       ;; 0c:4388 $b6
    ld   [HL], A                                       ;; 0c:4389 $77
    pop  DE                                            ;; 0c:438a $d1
    jp   jp_0c_401d                                    ;; 0c:438b $c3 $1d $40
    db   $cd, $76, $44, $d5, $21, $a5, $c1, $11        ;; 0c:438e ????????
    db   $a8, $c1, $1a, $a6, $2f, $22, $13, $1a        ;; 0c:4396 ????????
    db   $a6, $2f, $22, $13, $1a, $a6, $2f, $77        ;; 0c:439e ????????
    db   $d1, $c3, $1d, $40, $cd, $76, $44, $d5        ;; 0c:43a6 ????????
    db   $21, $a5, $c1, $11, $a8, $c1, $1a, $ae        ;; 0c:43ae ????????
    db   $22, $13, $1a, $ae, $22, $13, $1a, $ae        ;; 0c:43b6 ????????
    db   $77, $d1, $c3, $1d, $40, $cd, $76, $44        ;; 0c:43be ????????
    db   $d5, $21, $a5, $c1, $11, $a8, $c1, $1a        ;; 0c:43c6 ????????
    db   $2f, $22, $13, $1a, $2f, $22, $13, $1a        ;; 0c:43ce ????????
    db   $2f, $77, $d1, $c3, $1d, $40                  ;; 0c:43d6 ??????

data_0c_43dc:
    call call_0c_4476                                  ;; 0c:43dc $cd $76 $44
    ld   A, [wC1A8]                                    ;; 0c:43df $fa $a8 $c1
.jr_0c_43e2:
    or   A, A                                          ;; 0c:43e2 $b7
    jp   Z, jp_0c_401d                                 ;; 0c:43e3 $ca $1d $40
    dec  A                                             ;; 0c:43e6 $3d
    ld   HL, wC1A7                                     ;; 0c:43e7 $21 $a7 $c1
    srl  [HL]                                          ;; 0c:43ea $cb $3e
    dec  HL                                            ;; 0c:43ec $2b
    rr   [HL]                                          ;; 0c:43ed $cb $1e
    dec  HL                                            ;; 0c:43ef $2b
    rr   [HL]                                          ;; 0c:43f0 $cb $1e
    jr   .jr_0c_43e2                                   ;; 0c:43f2 $18 $ee
    db   $cd, $76, $44, $fa, $a8, $c1, $b7, $ca        ;; 0c:43f4 ????????
    db   $1d, $40, $3d, $21, $a5, $c1, $cb, $26        ;; 0c:43fc ????????
    db   $23, $cb, $16, $23, $cb, $16, $18, $ee        ;; 0c:4404 ????????

data_0c_440c:
    ld   A, [wC1A4]                                    ;; 0c:440c $fa $a4 $c1
    or   A, A                                          ;; 0c:440f $b7
    jr   Z, .jr_0c_4427                                ;; 0c:4410 $28 $15
    ld   A, [DE]                                       ;; 0c:4412 $1a
    and  A, $1f                                        ;; 0c:4413 $e6 $1f
    ld   [wC1A4], A                                    ;; 0c:4415 $ea $a4 $c1
    ld   HL, wC1AC                                     ;; 0c:4418 $21 $ac $c1
    ld   BC, wC1A5                                     ;; 0c:441b $01 $a5 $c1
    ld   A, [BC]                                       ;; 0c:441e $0a
    inc  BC                                            ;; 0c:441f $03
    ld   [HL+], A                                      ;; 0c:4420 $22
    ld   A, [BC]                                       ;; 0c:4421 $0a
    inc  BC                                            ;; 0c:4422 $03
    ld   [HL+], A                                      ;; 0c:4423 $22
    ld   A, [BC]                                       ;; 0c:4424 $0a
    inc  BC                                            ;; 0c:4425 $03
    ld   [HL], A                                       ;; 0c:4426 $77
.jr_0c_4427:
    ld   A, [DE]                                       ;; 0c:4427 $1a
    and  A, $1f                                        ;; 0c:4428 $e6 $1f
    cp   A, $13                                        ;; 0c:442a $fe $13
    jr   Z, .jr_0c_444d                                ;; 0c:442c $28 $1f
    cp   A, $12                                        ;; 0c:442e $fe $12
    jr   NZ, .jr_0c_4461                               ;; 0c:4430 $20 $2f
    inc  DE                                            ;; 0c:4432 $13
    ld   A, [DE]                                       ;; 0c:4433 $1a
    ld   C, A                                          ;; 0c:4434 $4f
    inc  DE                                            ;; 0c:4435 $13
    ld   B, $cf                                        ;; 0c:4436 $06 $cf
    push DE                                            ;; 0c:4438 $d5
    ld   A, [BC]                                       ;; 0c:4439 $0a
    ld   D, A                                          ;; 0c:443a $57
    ld   E, $00                                        ;; 0c:443b $1e $00
    ld   A, $05                                        ;; 0c:443d $3e $05
    call call_00_016b                                  ;; 0c:443f $cd $6b $01
    pop  DE                                            ;; 0c:4442 $d1
    ld   HL, wC1A5                                     ;; 0c:4443 $21 $a5 $c1
    ld   [HL+], A                                      ;; 0c:4446 $22
    xor  A, A                                          ;; 0c:4447 $af
    ld   [HL+], A                                      ;; 0c:4448 $22
    ld   [HL], A                                       ;; 0c:4449 $77
    jp   jp_0c_401d                                    ;; 0c:444a $c3 $1d $40
.jr_0c_444d:
    ld   A, [DE]                                       ;; 0c:444d $1a
    inc  DE                                            ;; 0c:444e $13
    swap A                                             ;; 0c:444f $cb $37
    srl  A                                             ;; 0c:4451 $cb $3f
    and  A, $07                                        ;; 0c:4453 $e6 $07
    ld   C, A                                          ;; 0c:4455 $4f
    ld   A, [DE]                                       ;; 0c:4456 $1a
    inc  DE                                            ;; 0c:4457 $13
    ld   L, A                                          ;; 0c:4458 $6f
    ld   A, [DE]                                       ;; 0c:4459 $1a
    inc  DE                                            ;; 0c:445a $13
    ld   H, A                                          ;; 0c:445b $67
    call call_0c_4490                                  ;; 0c:445c $cd $90 $44
    jr   .jr_0c_4464                                   ;; 0c:445f $18 $03
.jr_0c_4461:
    call call_0c_4476                                  ;; 0c:4461 $cd $76 $44
.jr_0c_4464:
    ld   HL, wC1A5                                     ;; 0c:4464 $21 $a5 $c1
    ld   BC, wC1A8                                     ;; 0c:4467 $01 $a8 $c1
    ld   A, [BC]                                       ;; 0c:446a $0a
    inc  BC                                            ;; 0c:446b $03
    ld   [HL+], A                                      ;; 0c:446c $22
    ld   A, [BC]                                       ;; 0c:446d $0a
    inc  BC                                            ;; 0c:446e $03
    ld   [HL+], A                                      ;; 0c:446f $22
    ld   A, [BC]                                       ;; 0c:4470 $0a
    inc  BC                                            ;; 0c:4471 $03
    ld   [HL], A                                       ;; 0c:4472 $77
    jp   jp_0c_401d                                    ;; 0c:4473 $c3 $1d $40

call_0c_4476:
    ld   A, [DE]                                       ;; 0c:4476 $1a
    inc  DE                                            ;; 0c:4477 $13
    swap A                                             ;; 0c:4478 $cb $37
    srl  A                                             ;; 0c:447a $cb $3f
    and  A, $07                                        ;; 0c:447c $e6 $07
    ld   C, A                                          ;; 0c:447e $4f
    cp   A, $05                                        ;; 0c:447f $fe $05
    jr   Z, jr_0c_44cb                                 ;; 0c:4481 $28 $48
    cp   A, $06                                        ;; 0c:4483 $fe $06
    jr   Z, jr_0c_44c1                                 ;; 0c:4485 $28 $3a
    cp   A, $07                                        ;; 0c:4487 $fe $07
    jr   Z, jr_0c_44b5                                 ;; 0c:4489 $28 $2a
    ld   A, [DE]                                       ;; 0c:448b $1a
    inc  DE                                            ;; 0c:448c $13
    ld   L, A                                          ;; 0c:448d $6f
    ld   H, $cf                                        ;; 0c:448e $26 $cf

call_0c_4490:
    ld   A, C                                          ;; 0c:4490 $79
    cp   A, $03                                        ;; 0c:4491 $fe $03
    jr   C, .jr_0c_449b                                ;; 0c:4493 $38 $06
    dec  C                                             ;; 0c:4495 $0d
    dec  C                                             ;; 0c:4496 $0d
    dec  C                                             ;; 0c:4497 $0d
    ld   A, [HL+]                                      ;; 0c:4498 $2a
    ld   H, [HL]                                       ;; 0c:4499 $66
    ld   L, A                                          ;; 0c:449a $6f
.jr_0c_449b:
    inc  C                                             ;; 0c:449b $0c
    push DE                                            ;; 0c:449c $d5
    ld   DE, wC1AA                                     ;; 0c:449d $11 $aa $c1
    xor  A, A                                          ;; 0c:44a0 $af
    ld   [DE], A                                       ;; 0c:44a1 $12
    dec  DE                                            ;; 0c:44a2 $1b
    ld   [DE], A                                       ;; 0c:44a3 $12
    dec  DE                                            ;; 0c:44a4 $1b
    ld   A, [HL+]                                      ;; 0c:44a5 $2a
    ld   [DE], A                                       ;; 0c:44a6 $12
    inc  DE                                            ;; 0c:44a7 $13
    dec  C                                             ;; 0c:44a8 $0d
    jr   Z, .jr_0c_44b3                                ;; 0c:44a9 $28 $08
    ld   A, [HL+]                                      ;; 0c:44ab $2a
    ld   [DE], A                                       ;; 0c:44ac $12
    inc  DE                                            ;; 0c:44ad $13
    dec  C                                             ;; 0c:44ae $0d
    jr   Z, .jr_0c_44b3                                ;; 0c:44af $28 $02
    ld   A, [HL+]                                      ;; 0c:44b1 $2a
    ld   [DE], A                                       ;; 0c:44b2 $12
.jr_0c_44b3:
    pop  DE                                            ;; 0c:44b3 $d1
    ret                                                ;; 0c:44b4 $c9

jr_0c_44b5:
    ld   A, [DE]                                       ;; 0c:44b5 $1a
    inc  DE                                            ;; 0c:44b6 $13
    ld   HL, wC1A8                                     ;; 0c:44b7 $21 $a8 $c1
    ld   [HL+], A                                      ;; 0c:44ba $22
    ld   A, [DE]                                       ;; 0c:44bb $1a
    inc  DE                                            ;; 0c:44bc $13
    ld   [HL+], A                                      ;; 0c:44bd $22
    ld   [HL], $00                                     ;; 0c:44be $36 $00
    ret                                                ;; 0c:44c0 $c9

jr_0c_44c1:
    ld   A, [DE]                                       ;; 0c:44c1 $1a
    inc  DE                                            ;; 0c:44c2 $13
    ld   HL, wC1A8                                     ;; 0c:44c3 $21 $a8 $c1
    ld   [HL+], A                                      ;; 0c:44c6 $22
    xor  A, A                                          ;; 0c:44c7 $af
    ld   [HL+], A                                      ;; 0c:44c8 $22
    ld   [HL], A                                       ;; 0c:44c9 $77
    ret                                                ;; 0c:44ca $c9

jr_0c_44cb:
    ld   A, [DE]                                       ;; 0c:44cb $1a
    inc  DE                                            ;; 0c:44cc $13
    push DE                                            ;; 0c:44cd $d5
    ld   D, A                                          ;; 0c:44ce $57
    ld   E, $00                                        ;; 0c:44cf $1e $00
    ld   A, $06                                        ;; 0c:44d1 $3e $06
    call call_00_016b                                  ;; 0c:44d3 $cd $6b $01
    ld   HL, wC1A8                                     ;; 0c:44d6 $21 $a8 $c1
    ld   [HL+], A                                      ;; 0c:44d9 $22
    xor  A, A                                          ;; 0c:44da $af
    ld   [HL+], A                                      ;; 0c:44db $22
    ld   [HL], A                                       ;; 0c:44dc $77
    pop  DE                                            ;; 0c:44dd $d1
    ret                                                ;; 0c:44de $c9
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:44df ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:44e7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:44ef ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:44f7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:44ff ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4507 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:450f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4517 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:451f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4527 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:452f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4537 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:453f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4547 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:454f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4557 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:455f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4567 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:456f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4577 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:457f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4587 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:458f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4597 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:459f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45a7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45af ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45b7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45bf ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45c7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45cf ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45d7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45df ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45e7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45ef ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45f7 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:45ff ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4607 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:460f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4617 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:461f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4627 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:462f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4637 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:463f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4647 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:464f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4657 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:465f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4667 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:466f ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:4677 ????????
    db   $00                                           ;; 0c:467f ?
    dw   .data_0c_4696                                 ;; 0c:4680 pP
    dw   .data_0c_4773                                 ;; 0c:4682 pP
    dw   .data_0c_4818                                 ;; 0c:4684 pP
    dw   .data_0c_49e5                                 ;; 0c:4686 pP
    db   $cf, $4a                                      ;; 0c:4688 ??
    dw   .data_0c_5232                                 ;; 0c:468a pP
    dw   .data_0c_4b98                                 ;; 0c:468c pP
    dw   .data_0c_4c43                                 ;; 0c:468e pP
    dw   .data_0c_4d08                                 ;; 0c:4690 pP
    db   $5a, $4e                                      ;; 0c:4692 ??
    dw   .data_0c_4f6b                                 ;; 0c:4694 pP
.data_0c_4696:
    db   $00, $00, $cc, $00, $1f, $00, $01, $cc        ;; 0c:4696 ...w....
    db   $04, $1f, $05                                 ;; 0c:469e ...
    dw   .data_0c_472f                                 ;; 0c:46a1 pP
    db   $00, $40, $13, $00, $d8, $c5, $80, $1f        ;; 0c:46a3 ........
    db   $00, $41, $13, $00, $d8, $c5, $40, $1f        ;; 0c:46ab ........
    db   $00, $00, $cc, $05, $1f, $00, $01, $cc        ;; 0c:46b3 ...w....
    db   $07, $1f, $05                                 ;; 0c:46bb ...
    dw   .data_0c_472f                                 ;; 0c:46be pP
    db   $00, $42, $13, $00, $d8, $c5, $80, $1f        ;; 0c:46c0 ........
    db   $00, $43, $13, $00, $d8, $c5, $40, $1f        ;; 0c:46c8 ........
    db   $a1, $64, $ce, $32, $1f, $02                  ;; 0c:46d0 ......
    dw   .data_0c_46dd                                 ;; 0c:46d6 pP
    db   $01, $43, $cc, $40, $1f                       ;; 0c:46d8 ?????
.data_0c_46dd:
    db   $00, $40, $cc, $00, $1f, $a1, $64, $ce        ;; 0c:46dd ........
    db   $14, $1f, $02, $ef, $46, $01, $41, $cc        ;; 0c:46e5 ...??...
    db   $40, $1f, $00, $42, $cc, $00, $1f, $a0        ;; 0c:46ed ...?.?..
    db   $00, $d8, $cc, $00, $1f, $01, $40, $0e        ;; 0c:46f5 ...w....
    db   $42, $1f, $02, $0b, $47, $01, $42, $0e        ;; 0c:46fd ...??...
    db   $40, $1f, $02, $1d, $47, $1f, $a0, $00        ;; 0c:4705 ...??.??
    db   $d8, $cc, $01, $1f, $a0, $0c, $d9, $cc        ;; 0c:470d ????????
    db   $00, $1f, $03, $20, $00, $02, $0a, $47        ;; 0c:4715 ????????
    db   $a0, $00, $d8, $cc, $02, $1f, $a0, $0c        ;; 0c:471d ????????
    db   $d9, $cc, $01, $1f, $03, $20, $00, $02        ;; 0c:4725 ????????
    db   $0a, $47                                      ;; 0c:472d ??
.data_0c_472f:
    db   $a0, $00, $d8, $cc, $00, $1f                  ;; 0c:472f ......
.data_0c_4735:
    db   $05                                           ;; 0c:4735 .
    dw   .data_0c_6ec7                                 ;; 0c:4736 pP
    db   $05                                           ;; 0c:4738 .
    dw   .data_0c_6755                                 ;; 0c:4739 pP
    db   $01, $1a, $cc, $00, $1f, $02                  ;; 0c:473b ......
    dw   .data_0c_4768                                 ;; 0c:4741 pP
.data_0c_4743:
    db   $05                                           ;; 0c:4743 .
    dw   .data_0c_6771                                 ;; 0c:4744 pP
    db   $20, $34, $2c, $13, $c1, $08, $e3, $81        ;; 0c:4746 ........
    db   $6f, $1f, $00, $21, $6c, $34, $1f, $a0        ;; 0c:474e ........
    db   $00, $d8, $13, $00, $d8, $06, $21, $1f        ;; 0c:4756 ........
    db   $07, $04, $01, $04, $cf, $07, $1f, $02        ;; 0c:475e .p......
    dw   .data_0c_4743                                 ;; 0c:4766 pP
.data_0c_4768:
    db   $07, $00, $01, $00, $0f, $01, $1f, $02        ;; 0c:4768 .p......
    dw   .data_0c_4735                                 ;; 0c:4770 pP
    db   $06                                           ;; 0c:4772 .
.data_0c_4773:
    db   $a0, $01, $d8, $cc, $01, $1f, $c1, $20        ;; 0c:4773 ........
    db   $13, $44, $d8, $c5, $20, $1f, $02, $c0        ;; 0c:477b .......?
    db   $47, $c1, $01, $13, $00, $d8, $1f, $02        ;; 0c:4783 ?.......
    db   $d6, $47, $00, $00, $cc, $00, $1f, $00        ;; 0c:478b ??...w..
    db   $01, $cc, $04, $1f, $05                       ;; 0c:4793 .....
    dw   .data_0c_47df                                 ;; 0c:4798 pP
    db   $20, $45, $2c, $49, $1f, $00, $00, $cc        ;; 0c:479a ........
    db   $05, $1f, $00, $01, $cc, $07, $1f, $05        ;; 0c:47a2 w.......
    dw   .data_0c_47df                                 ;; 0c:47aa pP
    db   $20, $47, $2c, $49, $1f, $20, $47, $2c        ;; 0c:47ac ........
    db   $47, $a3, $32, $1f, $21, $45, $2e, $47        ;; 0c:47b4 ........
    db   $1f, $02                                      ;; 0c:47bc ..
    dw   .data_0c_47d6                                 ;; 0c:47be pP
    db   $a0, $01, $d8, $cc, $00, $1f, $a0, $00        ;; 0c:47c0 ........
    db   $d8, $cc, $02, $1f, $a0, $0c, $d9, $cc        ;; 0c:47c8 ........
    db   $02, $1f                                      ;; 0c:47d0 w.
.data_0c_47d2:
    db   $03                                           ;; 0c:47d2 .
    dw   $0020                                         ;; 0c:47d3 pP
    db   $1f                                           ;; 0c:47d5 .
.data_0c_47d6:
    db   $a0, $0c, $d9, $cc, $03, $1f, $02             ;; 0c:47d6 ....w..
    dw   .data_0c_47d2                                 ;; 0c:47dd pP
.data_0c_47df:
    db   $20, $49, $cc, $00, $1f                       ;; 0c:47df .....
.data_0c_47e4:
    db   $05                                           ;; 0c:47e4 .
    dw   .data_0c_6755                                 ;; 0c:47e5 pP
    db   $01, $1a, $cc, $00, $1f, $02                  ;; 0c:47e7 ......
    dw   .data_0c_4801                                 ;; 0c:47ed pP
    db   $05                                           ;; 0c:47ef .
    dw   .data_0c_6e72                                 ;; 0c:47f0 pP
    db   $00, $30, $cc, $0f, $1f, $20, $49, $2c        ;; 0c:47f2 ........
    db   $49, $63, $30, $1f, $02                       ;; 0c:47fa .....
    dw   .data_0c_480d                                 ;; 0c:47ff pP
.data_0c_4801:
    db   $01, $00, $cf, $04, $1f, $20, $49, $2c        ;; 0c:4801 ......?.
    db   $49, $c3, $64, $1f                            ;; 0c:4809 ?.?.
.data_0c_480d:
    db   $07, $00, $01, $00, $0f, $01, $1f, $02        ;; 0c:480d .p......
    dw   .data_0c_47e4                                 ;; 0c:4815 pP
    db   $06                                           ;; 0c:4817 .
.data_0c_4818:
    db   $00, $00, $cc, $05, $1f                       ;; 0c:4818 ...w.
.data_0c_481d:
    db   $00, $02, $cc, $00, $1f, $05                  ;; 0c:481d ......
    dw   .data_0c_6755                                 ;; 0c:4823 pP
    db   $01, $1a, $cc, $00, $1f, $02                  ;; 0c:4825 ......
    dw   .data_0c_4984                                 ;; 0c:482b pP
    db   $05                                           ;; 0c:482d .
    dw   .data_0c_6788                                 ;; 0c:482e pP
    db   $05                                           ;; 0c:4830 .
    dw   .data_0c_6796                                 ;; 0c:4831 pP
    db   $01, $1b, $cc, $fe, $1f, $02, $9f, $49        ;; 0c:4833 ......??
    db   $20, $53, $0c, $1b, $e3, $50, $7d, $1f        ;; 0c:483b ........
.data_0c_4843:
    db   $05                                           ;; 0c:4843 .
    dw   .data_0c_67d4                                 ;; 0c:4844 pP
    db   $c1, $00, $0d, $06, $c5, $98, $1f, $20        ;; 0c:4846 ........
    db   $13, $cc, $ff, $1f, $c1, $02, $0c, $06        ;; 0c:484e ?.?.....
    db   $c5, $02, $1f, $20, $13, $ec, $0e, $01        ;; 0c:4856 ....?.??
    db   $1f, $c1, $01, $0c, $06, $c5, $01, $1f        ;; 0c:485e ........
    db   $20, $13, $ec, $0f, $01, $1f, $c1, $00        ;; 0c:4866 .?.??...
    db   $0c, $06, $c5, $9b, $1f, $02                  ;; 0c:486e ......
    dw   .data_0c_487c                                 ;; 0c:4874 pP
    db   $05, $04, $68, $02, $7a, $49                  ;; 0c:4876 ??????
.data_0c_487c:
    db   $00, $52, $ac, $ff, $1f, $05                  ;; 0c:487c ......
    dw   .data_0c_6ec7                                 ;; 0c:4882 pP
    db   $20, $30, $0c, $00, $e3, $44, $d8, $1f        ;; 0c:4884 ........
    db   $00, $05, $6c, $30, $1f, $20, $62, $6c        ;; 0c:488c ........
    db   $53, $ca, $04, $c1, $08, $e3, $00, $6f        ;; 0c:4894 ........
    db   $03, $04, $1f, $01, $52, $6d, $62, $1f        ;; 0c:489c ........
    db   $02                                           ;; 0c:48a4 .
    dw   .data_0c_48b4                                 ;; 0c:48a5 pP
    db   $07, $04, $01, $04, $0f, $05, $1f, $02        ;; 0c:48a7 ????????
    db   $91, $48, $05, $c7, $6e                       ;; 0c:48af ?????
.data_0c_48b4:
    db   $05                                           ;; 0c:48b4 .
    dw   .data_0c_6771                                 ;; 0c:48b5 pP
    db   $05                                           ;; 0c:48b7 .
    dw   .data_0c_67a4                                 ;; 0c:48b8 pP
    db   $c1, $00, $0c, $20, $c5, $01, $1f, $02        ;; 0c:48ba ........
    db   $a7, $48, $05                                 ;; 0c:48c2 ??.
    dw   .data_0c_6804                                 ;; 0c:48c5 pP
    db   $20, $32, $2c, $32, $c3, $03, $1f, $60        ;; 0c:48c7 ........
    db   $32, $0c, $04, $1f, $c1, $20, $0c, $20        ;; 0c:48cf ........
    db   $c5, $20, $1f, $02                            ;; 0c:48d7 ....
    dw   .data_0c_4908                                 ;; 0c:48db pP
    db   $c1, $10, $0c, $20, $c5, $10, $1f, $02        ;; 0c:48dd ????????
    db   $8f, $49, $00, $15, $ac, $02, $c3, $05        ;; 0c:48e5 ????????
    db   $1f, $07, $15, $01, $15, $ce, $07, $1f        ;; 0c:48ed ????????
    db   $00, $15, $cc, $05, $1f, $05, $63, $67        ;; 0c:48f5 ????????
    db   $01, $1a, $cc, $00, $1f, $02, $ee, $48        ;; 0c:48fd ????????
    db   $02, $73, $49                                 ;; 0c:4905 ???
.data_0c_4908:
    db   $c1, $10, $0c, $20, $c5, $10, $1f, $02        ;; 0c:4908 ........
    db   $97, $49, $c1, $00, $0c, $20, $c5, $80        ;; 0c:4910 ??......
    db   $1f, $02, $56, $49, $00, $50, $cc, $00        ;; 0c:4918 ..??...w
    db   $1f                                           ;; 0c:4920 .
.data_0c_4921:
    db   $20, $30, $0c, $50, $e1, $00, $01, $e3        ;; 0c:4921 ........
    db   $01, $d0, $1f, $00, $1a, $6c, $30, $1f        ;; 0c:4929 ........
    db   $01, $1a, $cc, $00, $1f, $02, $49, $49        ;; 0c:4931 ......??
    db   $a1, $64, $ce, $32, $1f, $02                  ;; 0c:4939 ......
    dw   .data_0c_4949                                 ;; 0c:493f pP
    db   $00, $15, $0c, $50, $1f, $02                  ;; 0c:4941 ......
    dw   .data_0c_4973                                 ;; 0c:4947 pP
.data_0c_4949:
    db   $07, $50, $01, $50, $ce, $04, $1f, $02        ;; 0c:4949 .p......
    db   $56, $49, $02                                 ;; 0c:4951 ??.
    dw   .data_0c_4921                                 ;; 0c:4954 pP
    db   $00, $15, $ac, $04, $1f, $01, $15, $ce        ;; 0c:4956 ????????
    db   $04, $1f, $05, $dc, $6e, $05, $63, $67        ;; 0c:495e ????????
    db   $01, $1a, $ce, $00, $1f, $02, $73, $49        ;; 0c:4966 ????????
    db   $07, $15, $02, $5b, $49                       ;; 0c:496e ?????
.data_0c_4973:
    db   $28, $32, $60, $32, $0c, $15, $1f, $07        ;; 0c:4973 .p......
    db   $02, $01, $02, $0d, $03, $1f, $02             ;; 0c:497b p......
    dw   .data_0c_4843                                 ;; 0c:4982 pP
.data_0c_4984:
    db   $07, $00, $01, $00, $cf, $07, $1f, $02        ;; 0c:4984 .p......
    dw   .data_0c_481d                                 ;; 0c:498c pP
    db   $1f, $00, $15, $cc, $08, $1f, $02, $73        ;; 0c:498e .???????
    db   $49, $00, $15, $cc, $09, $1f, $02, $73        ;; 0c:4996 ????????
    db   $49, $01, $c0, $cc, $01, $1f, $02, $dd        ;; 0c:499e ????????
    db   $49, $00, $54, $13, $48, $d8, $1f, $01        ;; 0c:49a6 ????????
    db   $54, $ce, $05, $1f, $02, $bd, $49, $20        ;; 0c:49ae ????????
    db   $13, $cc, $f7, $1f, $02, $cf, $49, $01        ;; 0c:49b6 ????????
    db   $54, $cc, $06, $1f, $02, $d5, $49, $20        ;; 0c:49be ????????
    db   $13, $13, $48, $d8, $c5, $01, $c3, $f9        ;; 0c:49c6 ????????
    db   $1f, $05, $c7, $6e, $02, $b7, $48, $20        ;; 0c:49ce ????????
    db   $13, $cc, $f8, $1f, $02, $cf, $49, $20        ;; 0c:49d6 ????????
    db   $13, $cc, $fc, $1f, $02, $cf, $49             ;; 0c:49de ???????
.data_0c_49e5:
    db   $00, $00, $cc, $00, $1f, $20, $62, $ec        ;; 0c:49e5 ...w....
    db   $03, $d8, $1f, $00, $6b, $cc, $00, $1f        ;; 0c:49ed ........
.data_0c_49f5:
    db   $00, $02, $cc, $00, $1f, $05                  ;; 0c:49f5 ......
    dw   .data_0c_6788                                 ;; 0c:49fb pP
    db   $20, $68, $ec, $6c, $cf, $03, $00, $1f        ;; 0c:49fd ........
    db   $60, $68, $0c, $03, $1f, $01, $03, $cc        ;; 0c:4a05 ........
    db   $00, $1f, $02                                 ;; 0c:4a0d ...
    dw   .data_0c_4a49                                 ;; 0c:4a10 pP
    db   $05                                           ;; 0c:4a12 .
    dw   .data_0c_6e72                                 ;; 0c:4a13 pP
    db   $00, $30, $cc, $0f, $1f, $00, $6a, $6c        ;; 0c:4a15 ........
    db   $30, $1f, $01, $00, $cf, $04, $1f, $00        ;; 0c:4a1d ........
    db   $6a, $0c, $6a, $c2, $04, $03, $6a, $1f        ;; 0c:4a25 ....w...
.data_0c_4a2d:
    db   $60, $62, $12, $6a, $03, $6a, $1f, $07        ;; 0c:4a2d ...p....
    db   $62, $60, $62, $0c, $00, $1f, $07, $6b        ;; 0c:4a35 p......p
    db   $07, $62, $07, $02, $01, $02, $0d, $03        ;; 0c:4a3d .p.p....
    db   $1f, $02                                      ;; 0c:4a45 ..
    dw   .data_0c_4a2d                                 ;; 0c:4a47 pP
.data_0c_4a49:
    db   $07, $00, $01, $00, $cf, $07, $1f, $02        ;; 0c:4a49 .p......
    dw   .data_0c_49f5                                 ;; 0c:4a51 pP
    db   $00, $60, $cc, $00, $1f                       ;; 0c:4a53 .....
.data_0c_4a58:
    db   $00, $61, $cc, $00, $1f                       ;; 0c:4a58 ...w.
.data_0c_4a5d:
    db   $20, $62, $0c, $61, $c1, $02, $e3, $03        ;; 0c:4a5d ........
    db   $d8, $1f, $20, $64, $2c, $62, $c3, $02        ;; 0c:4a65 ........
    db   $1f, $61, $62, $6e, $64, $1f, $02             ;; 0c:4a6d .......
    dw   .data_0c_4a85                                 ;; 0c:4a74 pP
    db   $20, $66, $8c, $62, $1f, $80, $62, $8c        ;; 0c:4a76 ........
    db   $64, $1f, $80, $64, $2c, $66, $1f             ;; 0c:4a7e .......
.data_0c_4a85:
    db   $07, $61, $01, $61, $0d, $6b, $04, $60        ;; 0c:4a85 .p......
    db   $c4, $01, $1f, $02                            ;; 0c:4a8d ....
    dw   .data_0c_4a5d                                 ;; 0c:4a91 pP
    db   $07, $60, $01, $60, $0d, $6b, $1f, $02        ;; 0c:4a93 .p......
    dw   .data_0c_4a58                                 ;; 0c:4a9b pP
    db   $00, $60, $cc, $00, $1f                       ;; 0c:4a9d ...w.
.data_0c_4aa2:
    db   $20, $62, $0c, $60, $c1, $02, $e3, $04        ;; 0c:4aa2 ........
    db   $d8, $1f, $20, $64, $6c, $62, $e3, $6c        ;; 0c:4aaa ........
    db   $cf, $1f, $08, $62, $60, $62, $6c, $64        ;; 0c:4ab2 ...p....
    db   $c4, $01, $1f, $80, $64, $8c, $64, $c4        ;; 0c:4aba ........
    db   $01, $1f, $07, $60, $01, $60, $0d, $6b        ;; 0c:4ac2 ...p....
    db   $1f, $02                                      ;; 0c:4aca ..
    dw   .data_0c_4aa2                                 ;; 0c:4acc pP
    db   $1f, $05, $12, $68, $05, $e0, $67, $c1        ;; 0c:4ace .???????
    db   $00, $0d, $06, $c5, $03, $1f, $02, $97        ;; 0c:4ad6 ????????
    db   $4b, $a0, $0c, $d9, $cc, $5b, $1f, $03        ;; 0c:4ade ????????
    db   $20, $00, $c0, $06, $d9, $0c, $12, $1f        ;; 0c:4ae6 ????????
    db   $a0, $0c, $d9, $cc, $19, $1f, $03, $20        ;; 0c:4aee ????????
    db   $00, $a1, $64, $ce, $0a, $1f, $02, $15        ;; 0c:4af6 ????????
    db   $4b, $00, $06, $0c, $06, $c5, $f7, $1f        ;; 0c:4afe ????????
    db   $05, $f8, $67, $a0, $0c, $d9, $cc, $4d        ;; 0c:4b06 ????????
    db   $1f, $03, $20, $00, $02, $97, $4b, $a0        ;; 0c:4b0e ????????
    db   $0c, $d9, $cc, $05, $1f, $03, $20, $00        ;; 0c:4b16 ????????
    db   $05, $f9, $6e, $05, $94, $6e, $00, $52        ;; 0c:4b1e ????????
    db   $ac, $07, $c1, $03, $1f, $05, $7c, $6e        ;; 0c:4b26 ????????
    db   $00, $30, $cc, $12, $03, $52, $1f, $20        ;; 0c:4b2e ????????
    db   $13, $6c, $30, $1f, $05, $a4, $67, $c1        ;; 0c:4b36 ????????
    db   $01, $0c, $20, $c5, $01, $1f, $02, $4f        ;; 0c:4b3e ????????
    db   $4b, $20, $13, $cc, $ff, $1f, $02, $7f        ;; 0c:4b46 ????????
    db   $4b, $c1, $10, $0c, $20, $c5, $10, $1f        ;; 0c:4b4e ????????
    db   $02, $6c, $4b, $00, $15, $ac, $07, $1f        ;; 0c:4b56 ????????
    db   $05, $63, $67, $01, $1a, $cc, $00, $1f        ;; 0c:4b5e ????????
    db   $02, $47, $4b, $02, $73, $4b, $00, $15        ;; 0c:4b66 ????????
    db   $ac, $01, $c3, $08, $1f, $20, $36, $2c        ;; 0c:4b6e ????????
    db   $32, $c3, $05, $1f, $60, $36, $0c, $15        ;; 0c:4b76 ????????
    db   $1f, $20, $36, $2c, $32, $c3, $03, $1f        ;; 0c:4b7e ????????
    db   $80, $36, $2c, $13, $1f, $20, $36, $2c        ;; 0c:4b86 ????????
    db   $32, $c3, $06, $1f, $60, $36, $0c, $52        ;; 0c:4b8e ????????
    db   $1f, $1f                                      ;; 0c:4b96 ??
.data_0c_4b98:
    db   $05                                           ;; 0c:4b98 .
    dw   .data_0c_6edc                                 ;; 0c:4b99 pP
.data_0c_4b9b:
    db   $05                                           ;; 0c:4b9b .
    dw   .data_0c_6763                                 ;; 0c:4b9c pP
    db   $01, $1a, $cc, $00, $1f, $02                  ;; 0c:4b9e ......
    dw   .data_0c_4c38                                 ;; 0c:4ba4 pP
    db   $05                                           ;; 0c:4ba6 .
    dw   .data_0c_6a5a                                 ;; 0c:4ba7 pP
.data_0c_4ba9:
    db   $05                                           ;; 0c:4ba9 .
    dw   .data_0c_67ec                                 ;; 0c:4baa pP
    db   $c1, $00, $0d, $07, $c5, $90, $1f, $02        ;; 0c:4bac ........
    db   $2e, $4c, $c1, $00, $0c, $07, $c5, $04        ;; 0c:4bb4 ??......
    db   $1f, $02                                      ;; 0c:4bbc ..
    dw   .data_0c_4c2e                                 ;; 0c:4bbe pP
    db   $c0, $06, $d9, $0c, $15, $1f, $a0, $0c        ;; 0c:4bc0 ????????
    db   $d9, $cc, $19, $1f, $03, $20, $00, $a1        ;; 0c:4bc8 ????????
    db   $64, $cf, $14, $1f, $02, $1e, $4c, $05        ;; 0c:4bd0 ????????
    db   $84, $6e, $00, $30, $cc, $0c, $1f, $20        ;; 0c:4bd8 ????????
    db   $74, $8c, $30, $c2, $14, $1f, $20, $74        ;; 0c:4be0 ????????
    db   $12, $74, $23, $74, $c3, $01, $1f, $05        ;; 0c:4be8 ????????
    db   $6d, $6a, $c0, $00, $d9, $2c, $74, $1f        ;; 0c:4bf0 ????????
    db   $a0, $0c, $d9, $cc, $06, $1f, $03, $20        ;; 0c:4bf8 ????????
    db   $00, $20, $0a, $8c, $32, $31, $74, $1f        ;; 0c:4c00 ????????
    db   $80, $32, $2c, $0a, $1f, $05, $69, $69        ;; 0c:4c08 ????????
    db   $01, $76, $cc, $00, $1f, $02, $2e, $4c        ;; 0c:4c10 ????????
    db   $05, $43, $55, $02, $2e, $4c, $60, $32        ;; 0c:4c18 ????????
    db   $0c, $07, $c5, $fb, $1f, $a0, $0c, $d9        ;; 0c:4c20 ????????
    db   $cc, $4e, $1f, $03, $20, $00                  ;; 0c:4c28 ??????
.data_0c_4c2e:
    db   $07, $16, $01, $16, $0d, $03, $1f, $02        ;; 0c:4c2e .p......
    dw   .data_0c_4ba9                                 ;; 0c:4c36 pP
.data_0c_4c38:
    db   $07, $15, $01, $15, $cf, $07, $1f, $02        ;; 0c:4c38 .p......
    dw   .data_0c_4b9b                                 ;; 0c:4c40 pP
    db   $1f                                           ;; 0c:4c42 .
.data_0c_4c43:
    db   $00, $00, $cc, $00, $1f                       ;; 0c:4c43 ...w.
.data_0c_4c48:
    db   $05                                           ;; 0c:4c48 .
    dw   .data_0c_6755                                 ;; 0c:4c49 pP
    db   $01, $1a, $cc, $00, $1f, $02                  ;; 0c:4c4b ......
    dw   .data_0c_4c86                                 ;; 0c:4c51 pP
    db   $05                                           ;; 0c:4c53 .
    dw   .data_0c_6ec7                                 ;; 0c:4c54 pP
.data_0c_4c56:
    db   $05                                           ;; 0c:4c56 .
    dw   .data_0c_6771                                 ;; 0c:4c57 pP
    db   $c1, $fe, $0c, $13, $1f, $02, $91, $4c        ;; 0c:4c59 ......??
    db   $c1, $7e, $0c, $13, $1f, $02, $6c, $4c        ;; 0c:4c61 ......??
    db   $02                                           ;; 0c:4c69 .
    dw   .data_0c_4c7c                                 ;; 0c:4c6a pP
    db   $05, $72, $6e, $00, $30, $cc, $0b, $1f        ;; 0c:4c6c ????????
    db   $61, $30, $cc, $03, $1f, $02, $91, $4c        ;; 0c:4c74 ????????
.data_0c_4c7c:
    db   $07, $04, $01, $04, $cf, $07, $1f, $02        ;; 0c:4c7c .p......
    dw   .data_0c_4c56                                 ;; 0c:4c84 pP
.data_0c_4c86:
    db   $07, $00, $01, $00, $cf, $07, $1f, $02        ;; 0c:4c86 .p......
    dw   .data_0c_4c48                                 ;; 0c:4c8e pP
    db   $1f, $00, $76, $cc, $00, $1f, $c0, $06        ;; 0c:4c90 .???????
    db   $d9, $0c, $00, $1f, $a0, $0c, $d9, $cc        ;; 0c:4c98 ????????
    db   $09, $1f, $00, $02, $cc, $00, $1f, $05        ;; 0c:4ca0 ????????
    db   $88, $67, $05, $72, $6e, $00, $30, $cc        ;; 0c:4ca8 ????????
    db   $0c, $1f, $20, $0c, $8c, $30, $1f, $05        ;; 0c:4cb0 ????????
    db   $d4, $67, $c1, $00, $0d, $06, $c5, $90        ;; 0c:4cb8 ????????
    db   $1f, $02, $f3, $4c, $20, $32, $cc, $01        ;; 0c:4cc0 ????????
    db   $1f, $05, $b6, $6e, $20, $08, $8c, $32        ;; 0c:4cc8 ????????
    db   $1f, $20, $0a, $2c, $0c, $c2, $0a, $23        ;; 0c:4cd0 ????????
    db   $08, $1f, $21, $0a, $2e, $0c, $1f, $20        ;; 0c:4cd8 ????????
    db   $0a, $2c, $0c, $1f, $80, $32, $2c, $0a        ;; 0c:4ce0 ????????
    db   $1f, $21, $0a, $2e, $08, $1f, $00, $76        ;; 0c:4ce8 ????????
    db   $cc, $01, $1f, $07, $02, $01, $02, $0d        ;; 0c:4cf0 ????????
    db   $03, $1f, $02, $b7, $4c, $01, $76, $cc        ;; 0c:4cf8 ????????
    db   $01, $1f, $03, $20, $00, $02, $86, $4c        ;; 0c:4d00 ????????
.data_0c_4d08:
    db   $00, $00, $cc, $05, $1f, $40, $77, $cc        ;; 0c:4d08 ...w....
    db   $00, $1f, $a0, $45, $d8, $cc, $00, $1f        ;; 0c:4d10 ........
.data_0c_4d18:
    db   $05                                           ;; 0c:4d18 .
    dw   .data_0c_6e72                                 ;; 0c:4d19 pP
    db   $00, $30, $cc, $00, $1f, $00, $19, $6c        ;; 0c:4d1b ........
    db   $30, $1f, $01, $19, $cc, $00, $1f, $02        ;; 0c:4d23 ........
    dw   .data_0c_4d82                                 ;; 0c:4d2b pP
    db   $05                                           ;; 0c:4d2d .
    dw   .data_0c_6796                                 ;; 0c:4d2e pP
    db   $20, $7a, $0c, $1b, $e3, $50, $7c, $1f        ;; 0c:4d30 ........
    db   $20, $7a, $6c, $7a, $c5, $1f, $c1, $02        ;; 0c:4d38 ........
    db   $e3, $50, $7e, $1f, $40, $77, $8c, $7a        ;; 0c:4d40 ........
    db   $c2, $0a, $01, $19, $83, $7a, $01, $19        ;; 0c:4d48 .w......
    db   $43, $77, $1f, $20, $36, $ec, $50, $7c        ;; 0c:4d50 ........
    db   $03, $1b, $1f, $00, $38, $cc, $00, $1f        ;; 0c:4d58 ........
    db   $00, $38, $6c, $36, $ca, $06, $c5, $01        ;; 0c:4d60 ........
    db   $c1, $50, $1f, $00, $38, $6c, $36, $ca        ;; 0c:4d68 ........
    db   $05, $c5, $01, $c1, $14, $03, $38, $03        ;; 0c:4d70 ........
    db   $19, $1f, $a1, $64, $0f, $38, $1f, $02        ;; 0c:4d78 ........
    db   $90, $4d                                      ;; 0c:4d80 ??
.data_0c_4d82:
    db   $07, $00, $01, $00, $cf, $07, $1f, $02        ;; 0c:4d82 .p......
    dw   .data_0c_4d18                                 ;; 0c:4d8a pP
    db   $05                                           ;; 0c:4d8c .
    dw   .data_0c_4e25                                 ;; 0c:4d8d pP
    db   $1f, $c1, $80, $6c, $36, $c5, $80, $1f        ;; 0c:4d8f .???????
    db   $02, $07, $4e, $20, $30, $0c, $00, $e3        ;; 0c:4d97 ????????
    db   $44, $d8, $1f, $00, $04, $6c, $30, $1f        ;; 0c:4d9f ????????
    db   $00, $04, $12, $04, $1f, $05, $71, $67        ;; 0c:4da7 ????????
    db   $21, $13, $ce, $7f, $1f, $02, $82, $4d        ;; 0c:4daf ????????
    db   $20, $36, $ec, $80, $7e, $03, $13, $1f        ;; 0c:4db7 ????????
    db   $00, $38, $6c, $36, $1f, $00, $02, $cc        ;; 0c:4dbf ????????
    db   $00, $1f, $20, $34, $0c, $02, $c1, $02        ;; 0c:4dc7 ????????
    db   $e3, $b9, $c2, $1f, $c1, $ff, $6c, $34        ;; 0c:4dcf ????????
    db   $1f, $02, $e8, $4d, $07, $02, $01, $02        ;; 0c:4dd7 ????????
    db   $cf, $10, $1f, $02, $c9, $4d, $02, $82        ;; 0c:4ddf ????????
    db   $4d, $60, $34, $0c, $13, $1f, $27, $34        ;; 0c:4de7 ????????
    db   $60, $34, $0c, $38, $1f, $05, $25, $4e        ;; 0c:4def ????????
    db   $c0, $06, $d9, $0c, $13, $1f, $a0, $0c        ;; 0c:4df7 ????????
    db   $d9, $cc, $0b, $1f, $03, $20, $00, $1f        ;; 0c:4dff ????????
    db   $05, $25, $4e, $00, $10, $0c, $1b, $1f        ;; 0c:4e07 ????????
    db   $a0, $45, $d8, $cc, $01, $1f, $c0, $08        ;; 0c:4e0f ????????
    db   $d9, $0c, $00, $1f, $a0, $0c, $d9, $cc        ;; 0c:4e17 ????????
    db   $0c, $1f, $03, $20, $00, $1f                  ;; 0c:4e1f ??????
.data_0c_4e25:
    db   $40, $7c, $53, $a2, $c2, $1f, $40, $77        ;; 0c:4e25 ........
    db   $4c, $77, $43, $7c, $1f, $40, $4b, $53        ;; 0c:4e2d ........
    db   $f0, $7f, $1f, $41, $77, $4e, $4b, $1f        ;; 0c:4e35 ........
    db   $40, $77, $4c, $4b, $1f, $c0, $00, $d9        ;; 0c:4e3d .?.?....
    db   $4c, $77, $44, $7c, $1f, $a0, $0c, $d9        ;; 0c:4e45 ........
    db   $cc, $0a, $1f, $03                            ;; 0c:4e4d .w..
    dw   $0020                                         ;; 0c:4e51 pP
    db   $e0, $a2, $c2, $4c, $77, $1f, $06, $a0        ;; 0c:4e53 .......?
    db   $46, $d8, $cc, $00, $1f, $20, $30, $13        ;; 0c:4e5b ????????
    db   $4c, $d8, $e1, $00, $01, $e3, $0b, $d0        ;; 0c:4e63 ????????
    db   $1f, $00, $89, $6c, $30, $1f, $01, $89        ;; 0c:4e6b ????????
    db   $cc, $02, $1f, $02, $83, $4e, $a0, $0c        ;; 0c:4e73 ????????
    db   $d9, $cc, $0d, $1f, $03, $20, $00, $1f        ;; 0c:4e7b ????????
    db   $20, $30, $13, $4c, $d8, $e1, $00, $01        ;; 0c:4e83 ????????
    db   $e3, $0a, $d0, $1f, $00, $1b, $6c, $30        ;; 0c:4e8b ????????
    db   $1f, $20, $36, $ec, $00, $78, $03, $1b        ;; 0c:4e93 ????????
    db   $1f, $00, $38, $6c, $36, $1f, $00, $81        ;; 0c:4e9b ????????
    db   $0c, $38, $c2, $10, $1f, $00, $82, $0c        ;; 0c:4ea3 ????????
    db   $38, $c5, $0f, $1f, $20, $36, $ec, $00        ;; 0c:4eab ????????
    db   $78, $03, $10, $1f, $00, $38, $6c, $36        ;; 0c:4eb3 ????????
    db   $1f, $00, $83, $0c, $38, $c2, $10, $1f        ;; 0c:4ebb ????????
    db   $01, $83, $ce, $05, $1f, $07, $83, $00        ;; 0c:4ec3 ????????
    db   $84, $0c, $38, $c5, $0f, $1f, $00, $85        ;; 0c:4ecb ????????
    db   $0c, $81, $03, $83, $1f, $01, $85, $cd        ;; 0c:4ed3 ????????
    db   $06, $1f, $00, $85, $0c, $85, $c3, $0c        ;; 0c:4edb ????????
    db   $1f, $01, $85, $ce, $11, $1f, $00, $85        ;; 0c:4ee3 ????????
    db   $0c, $85, $c4, $0c, $1f, $00, $85, $0c        ;; 0c:4eeb ????????
    db   $85, $c4, $06, $1f, $00, $86, $0c, $82        ;; 0c:4ef3 ????????
    db   $03, $84, $d1, $01, $1f, $01, $86, $ce        ;; 0c:4efb ????????
    db   $02, $1f, $00, $86, $cc, $02, $1f, $20        ;; 0c:4f03 ????????
    db   $36, $ec, $50, $7d, $03, $1b, $1f, $00        ;; 0c:4f0b ????????
    db   $87, $6c, $36, $c5, $0f, $1f, $20, $36        ;; 0c:4f13 ????????
    db   $ec, $50, $7d, $03, $10, $1f, $01, $87        ;; 0c:4f1b ????????
    db   $6d, $36, $c5, $0f, $1f, $00, $87, $6c        ;; 0c:4f23 ????????
    db   $36, $c5, $0f, $1f, $20, $88, $0c, $85        ;; 0c:4f2b ????????
    db   $c1, $03, $03, $86, $c1, $10, $03, $87        ;; 0c:4f33 ????????
    db   $e3, $00, $79, $1f, $a0, $47, $d8, $6c        ;; 0c:4f3b ????????
    db   $88, $1f, $01, $1b, $13, $47, $d8, $1f        ;; 0c:4f43 ????????
    db   $02, $79, $4e, $a0, $46, $d8, $cc, $01        ;; 0c:4f4b ????????
    db   $1f, $c0, $08, $d9, $0c, $1b, $1f, $c0        ;; 0c:4f53 ????????
    db   $0a, $d9, $13, $47, $d8, $1f, $a0, $0c        ;; 0c:4f5b ????????
    db   $d9, $cc, $0e, $1f, $03, $20, $00, $1f        ;; 0c:4f63 ????????
.data_0c_4f6b:
    db   $00, $1b, $13, $0a, $d5, $1f, $20, $36        ;; 0c:4f6b ........
    db   $ec, $50, $7d, $03, $1b, $1f, $00, $1c        ;; 0c:4f73 ........
    db   $6c, $36, $c5, $0f, $1f, $00, $00, $cc        ;; 0c:4f7b ........
    db   $00, $1f                                      ;; 0c:4f83 w.
.data_0c_4f85:
    db   $00, $12, $0c, $00, $c1, $02, $1f, $05        ;; 0c:4f85 ........
    dw   .data_0c_6dd0                                 ;; 0c:4f8d pP
    db   $05                                           ;; 0c:4f8f .
    dw   .data_0c_6e72                                 ;; 0c:4f90 pP
    db   $00, $30, $cc, $0b, $1f, $00, $89, $6c        ;; 0c:4f92 ........
    db   $30, $1f, $01, $89, $ce, $01, $1f, $02        ;; 0c:4f9a ........
    dw   .data_0c_5034                                 ;; 0c:4fa2 pP
    db   $00, $02, $cc, $00, $1f, $05                  ;; 0c:4fa4 ......
    dw   .data_0c_67d4                                 ;; 0c:4faa pP
    db   $c1, $00, $0d, $06, $c5, $b0, $1f, $02        ;; 0c:4fac ........
    db   $34, $50, $05                                 ;; 0c:4fb4 ??.
    dw   .data_0c_6e72                                 ;; 0c:4fb7 pP
    db   $00, $30, $cc, $0c, $1f, $20, $0c, $8c        ;; 0c:4fb9 ........
    db   $30, $1f, $00, $b3, $0c, $0c, $c2, $1a        ;; 0c:4fc1 .......w
    db   $c3, $32, $1f, $20, $0e, $2c, $0c, $02        ;; 0c:4fc9 ........
    db   $b3, $1f, $20, $94, $0c, $89, $c1, $10        ;; 0c:4fd1 ........
    db   $e3, $90, $7f, $1f, $05                       ;; 0c:4fd9 .....
    dw   .data_0c_5218                                 ;; 0c:4fde pP
    db   $a1, $c8, $0d, $96, $1f, $02, $3f, $50        ;; 0c:4fe0 ......??
    db   $20, $94, $0c, $89, $c1, $10, $e3, $92        ;; 0c:4fe8 ........
    db   $7f, $1f, $05                                 ;; 0c:4ff0 ...
    dw   .data_0c_5218                                 ;; 0c:4ff3 pP
    db   $a1, $c8, $0f, $96, $1f, $02                  ;; 0c:4ff5 ......
    dw   .data_0c_515a                                 ;; 0c:4ffb pP
    db   $20, $36, $0c, $00, $c1, $02, $e3, $4d        ;; 0c:4ffd ........
    db   $d8, $1f, $20, $36, $ec, $40, $7b, $83        ;; 0c:5005 ........
    db   $36, $1f, $00, $38, $6c, $36, $1f, $00        ;; 0c:500d ........
    db   $61, $cc, $00, $1f, $c1, $00, $0d, $38        ;; 0c:5015 ........
    db   $c5, $80, $1f, $02                            ;; 0c:501d ....
    dw   .data_0c_5197                                 ;; 0c:5021 pP
    db   $00, $38, $0c, $38, $cb, $01, $1f, $07        ;; 0c:5023 ????????
    db   $61, $01, $61, $cf, $03, $1f, $02, $19        ;; 0c:502b ????????
    db   $50                                           ;; 0c:5033 ?
.data_0c_5034:
    db   $07, $00, $01, $00, $cf, $03, $1f, $02        ;; 0c:5034 .p......
    dw   .data_0c_4f85                                 ;; 0c:503c pP
    db   $1f, $00, $60, $cc, $00, $1f, $20, $8a        ;; 0c:503e .???????
    db   $0c, $1c, $c1, $18, $c3, $0f, $1f, $21        ;; 0c:5046 ????????
    db   $8a, $ce, $ff, $1f, $20, $8a, $cc, $ff        ;; 0c:504e ????????
    db   $1f, $00, $52, $12, $8a, $1f, $20, $36        ;; 0c:5056 ????????
    db   $ec, $b0, $7f, $03, $60, $1f, $01, $52        ;; 0c:505e ????????
    db   $6f, $36, $1f, $02, $79, $50, $07, $60        ;; 0c:5066 ????????
    db   $01, $60, $cf, $20, $1f, $02, $5c, $50        ;; 0c:506e ????????
    db   $02, $34, $50, $20, $36, $ec, $d0, $7f        ;; 0c:5076 ????????
    db   $03, $60, $1f, $00, $38, $6c, $36, $1f        ;; 0c:507e ????????
    db   $00, $b7, $cc, $00, $1f, $05, $c7, $6e        ;; 0c:5086 ????????
    db   $20, $8c, $0c, $d0, $e3, $0f, $c2, $1f        ;; 0c:508e ????????
    db   $20, $36, $0c, $04, $c1, $02, $23, $8c        ;; 0c:5096 ????????
    db   $1f, $61, $36, $d0, $80, $1f, $07, $b7        ;; 0c:509e ????????
    db   $61, $36, $cc, $ff, $1f, $08, $b7, $01        ;; 0c:50a6 ????????
    db   $b7, $cc, $04, $1f, $02, $00, $51, $07        ;; 0c:50ae ????????
    db   $04, $01, $04, $cf, $07, $1f, $02, $96        ;; 0c:50b6 ????????
    db   $50, $05, $c7, $6e, $20, $36, $0c, $04        ;; 0c:50be ????????
    db   $c1, $02, $23, $8c, $1f, $61, $36, $cc        ;; 0c:50c6 ????????
    db   $ff, $1f, $02, $00, $51, $07, $04, $01        ;; 0c:50ce ????????
    db   $04, $cf, $07, $1f, $02, $c2, $50, $00        ;; 0c:50d6 ????????
    db   $04, $cc, $08, $1f, $08, $04, $20, $36        ;; 0c:50de ????????
    db   $0c, $04, $c1, $02, $23, $8c, $1f, $61        ;; 0c:50e6 ????????
    db   $36, $ce, $7f, $1f, $02, $00, $51, $01        ;; 0c:50ee ????????
    db   $04, $ce, $00, $1f, $02, $e2, $50, $02        ;; 0c:50f6 ????????
    db   $34, $50, $c0, $06, $d9, $0c, $00, $1f        ;; 0c:50fe ????????
    db   $a0, $0c, $d9, $cc, $0f, $1f, $03, $20        ;; 0c:5106 ????????
    db   $00, $61, $36, $cc, $ff, $1f, $02, $26        ;; 0c:510e ????????
    db   $51, $c0, $06, $d9, $6c, $36, $1f, $a0        ;; 0c:5116 ????????
    db   $0c, $d9, $cc, $10, $1f, $03, $20, $00        ;; 0c:511e ????????
    db   $20, $8c, $0c, $04, $c1, $02, $23, $8c        ;; 0c:5126 ????????
    db   $1f, $60, $8c, $0c, $38, $1f, $c0, $06        ;; 0c:512e ????????
    db   $d9, $0c, $38, $1f, $20, $36, $ec, $80        ;; 0c:5136 ????????
    db   $7e, $03, $38, $1f, $00, $38, $6c, $36        ;; 0c:513e ????????
    db   $1f, $27, $8c, $60, $8c, $0c, $38, $1f        ;; 0c:5146 ????????
    db   $a0, $0c, $d9, $cc, $11, $1f, $03, $20        ;; 0c:514e ????????
    db   $00, $02, $34, $50                            ;; 0c:5156 ????
.data_0c_515a:
    db   $21, $0c, $f0, $e7, $03, $1f, $02, $34        ;; 0c:515a .......?
    db   $50, $20, $0e, $2c, $0c, $c2, $32, $a3        ;; 0c:5162 ?.....w.
    db   $0a, $c3, $05, $23, $0c, $1f, $20, $8e        ;; 0c:516a ........
    db   $0c, $d0, $e3, $09, $c2, $1f, $80, $8e        ;; 0c:5172 ........
    db   $2c, $0e, $1f, $c0, $06, $d9, $0c, $00        ;; 0c:517a ........
    db   $1f, $c0, $00, $d9, $2c, $0e, $24, $0c        ;; 0c:5182 ........
    db   $1f, $a0, $0c, $d9, $cc, $12, $1f, $03        ;; 0c:518a .....w..
    dw   $0020                                         ;; 0c:5192 pP
    db   $02                                           ;; 0c:5194 .
    dw   .data_0c_5034                                 ;; 0c:5195 pP
.data_0c_5197:
    db   $20, $94, $0c, $89, $c1, $05, $03, $61        ;; 0c:5197 ........
    db   $c1, $02, $e3, $94, $7f, $1f, $00, $96        ;; 0c:519f ........
    db   $6c, $94, $1f, $27, $94, $20, $90, $0c        ;; 0c:51a7 ....p...
    db   $d0, $e3, $0b, $c2, $03, $61, $1f, $00        ;; 0c:51af ........
    db   $92, $6c, $90, $1f, $01, $92, $d0, $63        ;; 0c:51b7 ........
    db   $1f, $02, $34, $50, $00, $b3, $0c, $92        ;; 0c:51bf ..??....
    db   $c2, $14, $c3, $05, $1f, $00, $93, $0c        ;; 0c:51c7 .w......
    db   $92, $61, $94, $02, $b3, $1f, $00, $96        ;; 0c:51cf ........
    db   $0c, $1c, $61, $94, $11, $93, $03, $96        ;; 0c:51d7 ........
    db   $1f, $a1, $c8, $0f, $96, $1f, $02, $eb        ;; 0c:51df .......?
    db   $51, $02                                      ;; 0c:51e7 ?.
    dw   .data_0c_5034                                 ;; 0c:51e9 pP
    db   $07, $92, $60, $90, $0c, $92, $1f, $c0        ;; 0c:51eb ????????
    db   $06, $d9, $0c, $00, $1f, $a0, $0c, $d9        ;; 0c:51f3 ????????
    db   $cc, $0f, $1f, $03, $20, $00, $a0, $0c        ;; 0c:51fb ????????
    db   $d9, $cc, $13, $03, $61, $1f, $03, $20        ;; 0c:5203 ????????
    db   $00, $a0, $0c, $d9, $cc, $08, $1f, $03        ;; 0c:520b ????????
    db   $20, $00, $02, $34, $50                       ;; 0c:5213 ?????
.data_0c_5218:
    db   $00, $96, $6c, $94, $1f, $27, $94, $00        ;; 0c:5218 ......p.
    db   $97, $0c, $0e, $61, $94, $1f, $00, $96        ;; 0c:5220 ........
    db   $0c, $1c, $61, $94, $11, $97, $03, $96        ;; 0c:5228 ........
    db   $1f, $06                                      ;; 0c:5230 ..
.data_0c_5232:
    db   $c1, $00, $13, $8b, $ff, $1f, $02             ;; 0c:5232 .......
    dw   .data_0c_5377                                 ;; 0c:5239 pP
    db   $05                                           ;; 0c:523b .
    dw   .data_0c_6812                                 ;; 0c:523c pP
    db   $a0, $0c, $d9, $cc, $5b, $1f, $c1, $00        ;; 0c:523e ....w...
    db   $13, $02, $d8, $1f, $02                       ;; 0c:5246 .....
    dw   .data_0c_5250                                 ;; 0c:524b pP
    db   $03                                           ;; 0c:524d .
    dw   $0020                                         ;; 0c:524e pP
.data_0c_5250:
    db   $05                                           ;; 0c:5250 .
    dw   .data_0c_67e0                                 ;; 0c:5251 pP
    db   $20, $32, $cc, $03, $1f, $05                  ;; 0c:5253 ......
    dw   .data_0c_6e94                                 ;; 0c:5259 pP
    db   $20, $13, $8c, $32, $1f, $20, $32, $2c        ;; 0c:525b ........
    db   $32, $c3, $02, $1f, $00, $15, $6c, $32        ;; 0c:5263 ........
    db   $1f, $01, $15, $d0, $08, $1f, $02             ;; 0c:526b .......
    dw   .data_0c_5294                                 ;; 0c:5272 pP
    db   $21, $13, $f0, $0e, $01, $1f, $02, $94        ;; 0c:5274 .......?
    db   $52, $05                                      ;; 0c:527c ?.
    dw   .data_0c_6763                                 ;; 0c:527e pP
    db   $01, $1a, $ce, $00, $1f, $02                  ;; 0c:5280 ......
    dw   .data_0c_5294                                 ;; 0c:5286 pP
    db   $20, $13, $cc, $ff, $1f, $27, $32, $60        ;; 0c:5288 ????????
    db   $32, $cc, $ff, $1f                            ;; 0c:5290 ????
.data_0c_5294:
    db   $20, $34, $2c, $13, $c1, $08, $e3, $83        ;; 0c:5294 ........
    db   $6f, $1f, $00, $23, $6c, $34, $1f, $05        ;; 0c:529c ........
    dw   .data_0c_67b4                                 ;; 0c:52a4 pP
    db   $05                                           ;; 0c:52a6 .
    dw   .data_0c_67c4                                 ;; 0c:52a7 pP
    db   $05                                           ;; 0c:52a9 .
    dw   .data_0c_691a                                 ;; 0c:52aa pP
    db   $05                                           ;; 0c:52ac .
    dw   .data_0c_69e1                                 ;; 0c:52ad pP
    db   $c0, $06, $d9, $0c, $12, $1f, $c0, $08        ;; 0c:52af ........
    db   $d9, $2c, $13, $1f, $05                       ;; 0c:52b7 .....
    dw   .data_0c_6e57                                 ;; 0c:52bc pP
    db   $20, $a0, $0c, $23, $c1, $02, $e3, $e1        ;; 0c:52be ........
    db   $53, $1f, $20, $a0, $8c, $a0, $1f, $09        ;; 0c:52c6 ........
    db   $a0, $c1, $ff, $13, $0a, $d5, $1f, $02        ;; 0c:52ce p.......
    db   $d9, $52, $1f, $01, $c0, $ce, $00, $1f        ;; 0c:52d6 ??.?????
    db   $02, $5a, $53, $20, $0a, $33, $41, $d5        ;; 0c:52de ????????
    db   $1f, $20, $0a, $33, $0c, $d5, $24, $0a        ;; 0c:52e6 ????????
    db   $1f, $00, $60, $cc, $00, $1f, $20, $30        ;; 0c:52ee ????????
    db   $ec, $cb, $cf, $03, $60, $1f, $61, $30        ;; 0c:52f6 ????????
    db   $cc, $00, $1f, $02, $0e, $53, $07, $60        ;; 0c:52fe ????????
    db   $01, $60, $cf, $03, $1f, $02, $f4, $52        ;; 0c:5306 ????????
    db   $20, $30, $0c, $60, $c1, $02, $e3, $c3        ;; 0c:530e ????????
    db   $cf, $1f, $80, $30, $8c, $30, $23, $0a        ;; 0c:5316 ????????
    db   $1f, $81, $30, $ee, $e8, $03, $1f, $02        ;; 0c:531e ????????
    db   $30, $53, $c0, $41, $d5, $33, $0c, $d5        ;; 0c:5326 ????????
    db   $1f, $1f, $a0, $0c, $d9, $cc, $6b, $1f        ;; 0c:532e ????????
    db   $c0, $00, $d9, $0c, $60, $c3, $01, $1f        ;; 0c:5336 ????????
    db   $03, $20, $00, $20, $30, $ec, $cb, $cf        ;; 0c:533e ????????
    db   $03, $60, $1f, $60, $30, $cc, $01, $1f        ;; 0c:5346 ????????
    db   $07, $cf, $01, $cf, $ce, $03, $1f, $07        ;; 0c:534e ????????
    db   $c0, $02, $28, $53, $01, $c0, $ce, $01        ;; 0c:5356 ????????
    db   $1f, $02, $76, $53, $20, $0a, $33, $41        ;; 0c:535e ????????
    db   $d5, $1f, $21, $0a, $ee, $88, $13, $1f        ;; 0c:5366 ????????
    db   $02, $76, $53, $00, $c0, $cc, $02, $1f        ;; 0c:536e ????????
    db   $1f                                           ;; 0c:5376 ?
.data_0c_5377:
    db   $21, $f0, $cf, $ff, $1f, $02, $88, $53        ;; 0c:5377 ......??
    db   $c1, $03, $13, $fc, $c2, $1f, $02, $db        ;; 0c:537f .......?
    db   $53, $00, $12, $0c, $f3, $c1, $02, $1f        ;; 0c:5387 ?.......
    db   $05                                           ;; 0c:538f .
    dw   .data_0c_6dd0                                 ;; 0c:5390 pP
    db   $00, $94, $0c, $d0, $1f, $00, $12, $0c        ;; 0c:5392 ........
    db   $f2, $c1, $02, $1f, $05                       ;; 0c:539a .....
    dw   .data_0c_6dd0                                 ;; 0c:539f pP
    db   $00, $88, $0c, $d0, $1f, $20, $34, $2c        ;; 0c:53a1 ........
    db   $f0, $c1, $08, $e3, $83, $6f, $1f, $00        ;; 0c:53a9 ........
    db   $23, $6c, $34, $1f, $20, $34, $2c, $f0        ;; 0c:53b1 ........
    db   $c1, $08, $e3, $84, $6f, $1f, $00, $24        ;; 0c:53b9 ........
    db   $6c, $34, $1f, $00, $f4, $cc, $00, $1f        ;; 0c:53c1 ........
    db   $20, $a0, $0c, $23, $c1, $02, $e3, $45        ;; 0c:53c9 ........
    db   $54, $1f, $20, $a0, $8c, $a0, $1f, $09        ;; 0c:53d1 ........
    db   $a0, $1f, $00, $f4, $cc, $09, $1f, $1f        ;; 0c:53d9 p.??????
    dw   .data_0c_55ed                                 ;; 0c:53e1 pP
    db   $18, $59, $47, $59                            ;; 0c:53e3 ????
    dw   .data_0c_545a                                 ;; 0c:53e7 pP
    db   $63, $54, $88, $54, $ad, $54, $b6, $54        ;; 0c:53e9 ????????
    db   $09, $55, $19, $62, $4c, $55, $a4, $62        ;; 0c:53f1 ????????
    db   $5c, $55, $6c, $55, $2a, $56, $49, $56        ;; 0c:53f9 ????????
    db   $6b, $56, $95, $56, $b7, $56, $51, $57        ;; 0c:5401 ????????
    db   $be, $57, $d6, $57, $26, $58, $5f, $58        ;; 0c:5409 ????????
    db   $84, $58, $d4, $58, $68, $59, $bd, $59        ;; 0c:5411 ????????
    db   $11, $5a, $3e, $5a, $c0, $5a, $26, $5b        ;; 0c:5419 ????????
    db   $af, $5b                                      ;; 0c:5421 ??
    dw   .data_0c_5c0d                                 ;; 0c:5423 pP
    db   $78, $5c, $a9, $5c, $57, $5d, $9b, $5d        ;; 0c:5425 ????????
    db   $e1, $5d, $ec, $5d, $22, $5e, $ed, $62        ;; 0c:542d ????????
    db   $93, $5e, $f8, $5e, $10, $5f, $1c, $5f        ;; 0c:5435 ????????
    db   $46, $5f, $d0, $60, $98, $5f                  ;; 0c:543d ??????
    dw   .data_0c_5512                                 ;; 0c:5443 pP
    db   $8a, $65, $de, $65, $ff, $65, $19, $66        ;; 0c:5445 ????????
    db   $b9, $66, $bf, $66                            ;; 0c:544d ????
    dw   .data_0c_66c7                                 ;; 0c:5451 pP
    db   $cd, $66, $00, $67, $30, $67, $00             ;; 0c:5453 ???????
.data_0c_545a:
    db   $a0, $0c, $d9, $cc, $17, $1f, $02             ;; 0c:545a ....w..
    dw   .data_0c_6cd4                                 ;; 0c:5461 pP
    db   $a0, $0c, $d9, $cc, $18, $1f, $03, $20        ;; 0c:5463 ????????
    db   $00, $a1, $64, $0f, $24, $1f, $02, $75        ;; 0c:546b ????????
    db   $54, $06, $00, $06, $0c, $06, $c5, $fd        ;; 0c:5473 ????????
    db   $1f, $05, $f8, $67, $a0, $0c, $d9, $cc        ;; 0c:547b ????????
    db   $4f, $1f, $02, $d4, $6c, $a0, $0c, $d9        ;; 0c:5483 ????????
    db   $cc, $1a, $1f, $03, $20, $00, $a1, $64        ;; 0c:548b ????????
    db   $0f, $24, $1f, $02, $9a, $54, $06, $00        ;; 0c:5493 ????????
    db   $06, $0c, $06, $c5, $fe, $1f, $05, $f8        ;; 0c:549b ????????
    db   $67, $a0, $0c, $d9, $cc, $50, $1f, $02        ;; 0c:54a3 ????????
    db   $d4, $6c, $a0, $0c, $d9, $cc, $1c, $1f        ;; 0c:54ab ????????
    db   $02, $d4, $6c, $05, $ad, $54, $05, $f8        ;; 0c:54b3 ????????
    db   $6b, $01, $12, $ce, $04, $1f, $02, $f2        ;; 0c:54bb ????????
    db   $54, $01, $15, $cc, $09, $1f, $02, $fa        ;; 0c:54c3 ????????
    db   $54, $05, $5e, $6e, $a0, $0c, $d9, $cc        ;; 0c:54cb ????????
    db   $1d, $1f, $03, $20, $00, $05, $84, $6e        ;; 0c:54d3 ????????
    db   $00, $30, $cc, $2d, $1f, $60, $30, $6c        ;; 0c:54db ????????
    db   $30, $06, $24, $1f, $07, $15, $01, $15        ;; 0c:54e3 ????????
    db   $0f, $01, $1f, $02, $d8, $54, $06, $01        ;; 0c:54eb ????????
    db   $15, $cc, $09, $1f, $02, $cc, $54, $05        ;; 0c:54f3 ????????
    db   $67, $6e, $a0, $0c, $d9, $cc, $1e, $1f        ;; 0c:54fb ????????
    db   $03, $20, $00, $02, $d8, $54, $a0, $0c        ;; 0c:5503 ????????
    db   $d9, $cc, $1f, $1f, $02, $d4, $6c             ;; 0c:550b ???????
.data_0c_5512:
    db   $05                                           ;; 0c:5512 .
    dw   .data_0c_6572                                 ;; 0c:5513 pP
    db   $05                                           ;; 0c:5515 .
    dw   .data_0c_69ef                                 ;; 0c:5516 pP
    db   $05                                           ;; 0c:5518 .
    dw   .data_0c_6de7                                 ;; 0c:5519 pP
    db   $05                                           ;; 0c:551b .
    dw   .data_0c_6a32                                 ;; 0c:551c pP
    db   $05                                           ;; 0c:551e .
    dw   .data_0c_6a98                                 ;; 0c:551f pP
    db   $21, $74, $ce, $00, $1f, $02                  ;; 0c:5521 ......
    dw   .data_0c_552f                                 ;; 0c:5527 pP
    db   $05, $93, $6c, $02, $5f, $63                  ;; 0c:5529 ??????
.data_0c_552f:
    db   $05                                           ;; 0c:552f .
    dw   .data_0c_6bf8                                 ;; 0c:5530 pP
    db   $05                                           ;; 0c:5532 .
    dw   .data_0c_6b55                                 ;; 0c:5533 pP
    db   $05                                           ;; 0c:5535 .
    dw   .data_0c_6c2b                                 ;; 0c:5536 pP
    db   $05                                           ;; 0c:5538 .
    dw   .data_0c_694e                                 ;; 0c:5539 pP
    db   $01, $76, $cc, $00, $1f, $02                  ;; 0c:553b ......
    dw   .data_0c_635f                                 ;; 0c:5541 pP
    db   $a0, $0c, $d9, $cc, $24, $1f, $02             ;; 0c:5543 ....w..
    dw   .data_0c_6cd4                                 ;; 0c:554a pP
    db   $05, $5d, $68, $c1, $00, $0c, $a7, $05        ;; 0c:554c ????????
    db   $25, $1f, $02, $12, $55, $02, $ed, $62        ;; 0c:5554 ????????
    db   $05, $a4, $69, $01, $25, $0c, $a9, $c5        ;; 0c:555c ????????
    db   $f0, $1f, $02, $ed, $62, $02, $12, $55        ;; 0c:5564 ????????
    db   $05, $72, $65, $05, $6b, $68, $05, $cd        ;; 0c:556c ????????
    db   $6e, $05, $a4, $69, $01, $25, $0c, $a9        ;; 0c:5574 ????????
    db   $c5, $f0, $1f, $02, $b9, $55, $05, $f8        ;; 0c:557c ????????
    db   $6b, $05, $55, $6b, $05, $2b, $6c, $05        ;; 0c:5584 ????????
    db   $4e, $69, $01, $a9, $d0, $20, $1f, $02        ;; 0c:558c ????????
    db   $a2, $55, $a0, $0c, $d9, $cc, $25, $1f        ;; 0c:5594 ????????
    db   $03, $20, $00, $02, $ae, $55, $05, $d8        ;; 0c:559c ????????
    db   $6c, $a0, $0c, $d9, $cc, $26, $1f, $03        ;; 0c:55a4 ????????
    db   $20, $00, $01, $76, $cc, $00, $1f, $02        ;; 0c:55ac ????????
    db   $5f, $63, $02, $43, $55, $a0, $0c, $d9        ;; 0c:55b4 ????????
    db   $cc, $27, $1f, $03, $20, $00, $05, $d4        ;; 0c:55bc ????????
    db   $68, $05, $6d, $6a, $80, $32, $8c, $32        ;; 0c:55c4 ????????
    db   $23, $b5, $1f, $05, $76, $6a, $c0, $00        ;; 0c:55cc ????????
    db   $d9, $2c, $b5, $1f, $a0, $0c, $d9, $cc        ;; 0c:55d4 ????????
    db   $28, $1f, $03, $20, $00, $21, $08, $ce        ;; 0c:55dc ????????
    db   $00, $1f, $06, $05, $7b, $6c, $02, $b7        ;; 0c:55e4 ????????
    db   $68                                           ;; 0c:55ec ?
.data_0c_55ed:
    db   $05                                           ;; 0c:55ed .
    dw   .data_0c_6c60                                 ;; 0c:55ee pP
    db   $05                                           ;; 0c:55f0 .
    dw   .data_0c_686b                                 ;; 0c:55f1 pP
    db   $05                                           ;; 0c:55f3 .
    dw   .data_0c_6891                                 ;; 0c:55f4 pP
    db   $05                                           ;; 0c:55f6 .
    dw   .data_0c_6ee8                                 ;; 0c:55f7 pP
    db   $05                                           ;; 0c:55f9 .
    dw   .data_0c_6bf8                                 ;; 0c:55fa pP
    db   $05                                           ;; 0c:55fc .
    dw   .data_0c_6bcb                                 ;; 0c:55fd pP
    db   $05                                           ;; 0c:55ff .
    dw   .data_0c_6e45                                 ;; 0c:5600 pP
    db   $05                                           ;; 0c:5602 .
    dw   .data_0c_6a5a                                 ;; 0c:5603 pP
    db   $05                                           ;; 0c:5605 .
    dw   .data_0c_67ec                                 ;; 0c:5606 pP
    db   $c1, $00, $0d, $07, $c5, $90, $1f, $02        ;; 0c:5608 ........
    db   $1f, $56, $05                                 ;; 0c:5610 ??.
    dw   .data_0c_6a6d                                 ;; 0c:5613 pP
    db   $80, $32, $8c, $32, $23, $b5, $1f, $05        ;; 0c:5615 ........
    dw   .data_0c_6a76                                 ;; 0c:561d pP
    db   $07, $16, $01, $16, $0d, $03, $1f, $02        ;; 0c:561f .p......
    db   $05, $56, $06, $05, $72, $65, $05, $ef        ;; 0c:5627 ??.?????
    db   $69, $05, $e7, $6d, $00, $b8, $12, $ab        ;; 0c:562f ????????
    db   $1f, $05, $8c, $6e, $20, $74, $0c, $ab        ;; 0c:5637 ????????
    db   $01, $24, $03, $b8, $31, $74, $1f, $02        ;; 0c:563f ????????
    db   $1e, $55, $05, $72, $65, $05, $ef, $69        ;; 0c:5647 ????????
    db   $05, $e7, $6d, $05, $6b, $68, $00, $b8        ;; 0c:564f ????????
    db   $12, $ac, $1f, $05, $8c, $6e, $20, $74        ;; 0c:5657 ????????
    db   $0c, $ac, $01, $24, $03, $b8, $31, $74        ;; 0c:565f ????????
    db   $1f, $02, $1e, $55, $05, $43, $6c, $05        ;; 0c:5667 ????????
    db   $4f, $68, $01, $25, $0e, $aa, $1f, $00        ;; 0c:566f ????????
    db   $aa, $0c, $25, $1f, $05, $32, $6a, $05        ;; 0c:5677 ????????
    db   $89, $6a, $21, $74, $cc, $00, $1f, $02        ;; 0c:567f ????????
    db   $92, $56, $05, $f8, $6b, $05, $55, $6b        ;; 0c:5687 ????????
    db   $02, $e7, $64, $02, $93, $6c, $05, $3a        ;; 0c:568f ????????
    db   $6c, $05, $05, $69, $20, $74, $12, $aa        ;; 0c:5697 ????????
    db   $23, $24, $1f, $05, $f8, $6b, $05, $55        ;; 0c:569f ????????
    db   $6b, $05, $2b, $6c, $05, $4e, $69, $01        ;; 0c:56a7 ????????
    db   $76, $cc, $00, $1f, $06, $02, $43, $55        ;; 0c:56af ????????
    db   $05, $3a, $6c, $05, $05, $69, $05, $c3        ;; 0c:56b7 ????????
    db   $69, $05, $d1, $69, $c1, $00, $0c, $b0        ;; 0c:56bf ????????
    db   $c5, $08, $1f, $02, $e7, $56, $05, $23        ;; 0c:56c7 ????????
    db   $68, $a1, $64, $0e, $b2, $1f, $02, $e7        ;; 0c:56cf ????????
    db   $56, $c0, $06, $d9, $2c, $17, $1f, $a0        ;; 0c:56d7 ????????
    db   $0c, $d9, $cc, $2c, $1f, $02, $d4, $6c        ;; 0c:56df ????????
    db   $a1, $64, $0f, $24, $03, $aa, $1f, $02        ;; 0c:56e7 ????????
    db   $00, $57, $a0, $b2, $ff, $cc, $15, $1f        ;; 0c:56ef ????????
    db   $a0, $0c, $d9, $cc, $21, $1f, $02, $d4        ;; 0c:56f7 ????????
    db   $6c, $05, $ef, $69, $20, $74, $0c, $25        ;; 0c:56ff ????????
    db   $03, $aa, $1f, $05, $98, $6a, $05, $e7        ;; 0c:5707 ????????
    db   $6d, $01, $74, $0e, $a5, $1f, $02, $27        ;; 0c:570f ????????
    db   $57, $a0, $b2, $ff, $cc, $08, $1f, $a0        ;; 0c:5717 ????????
    db   $0c, $d9, $cc, $2d, $1f, $02, $d4, $6c        ;; 0c:571f ????????
    db   $05, $b5, $69, $01, $a8, $d0, $f8, $1f        ;; 0c:5727 ????????
    db   $02, $18, $57, $05, $f8, $6b, $05, $55        ;; 0c:572f ????????
    db   $6b, $a0, $0c, $d9, $cc, $2e, $1f, $03        ;; 0c:5737 ????????
    db   $20, $00, $05, $6d, $6a, $20, $0a, $cc        ;; 0c:573f ????????
    db   $00, $1f, $80, $32, $2c, $0a, $1f, $02        ;; 0c:5747 ????????
    db   $69, $69, $05, $3a, $6c, $05, $05, $69        ;; 0c:574f ????????
    db   $05, $c2, $6d, $00, $89, $0c, $89, $d1        ;; 0c:5757 ????????
    db   $02, $c3, $01, $1f, $00, $b3, $0c, $aa        ;; 0c:575f ????????
    db   $01, $89, $03, $25, $1f, $a1, $64, $0f        ;; 0c:5767 ????????
    db   $b3, $1f, $02, $77, $57, $02, $f1, $56        ;; 0c:576f ????????
    db   $05, $ef, $69, $05, $c3, $69, $05, $d1        ;; 0c:5777 ????????
    db   $69, $05, $23, $68, $05, $e7, $6d, $00        ;; 0c:577f ????????
    db   $b8, $12, $25, $01, $89, $1f, $05, $8c        ;; 0c:5787 ????????
    db   $6e, $20, $74, $0c, $24, $c1, $05, $03        ;; 0c:578f ????????
    db   $b8, $31, $74, $1f, $05, $98, $6a, $21        ;; 0c:5797 ????????
    db   $74, $ce, $00, $1f, $02, $a9, $57, $02        ;; 0c:579f ????????
    db   $93, $6c, $05, $f8, $6b, $05, $55, $6b        ;; 0c:57a7 ????????
    db   $05, $2b, $6c, $05, $4e, $69, $01, $76        ;; 0c:57af ????????
    db   $cc, $00, $1f, $06, $02, $43, $55, $05        ;; 0c:57b7 ????????
    db   $3a, $6c, $05, $05, $69, $05, $fe, $69        ;; 0c:57bf ????????
    db   $00, $b3, $0c, $ab, $c1, $02, $03, $25        ;; 0c:57c7 ????????
    db   $1f, $02, $6c, $57, $02, $f1, $56, $05        ;; 0c:57cf ????????
    db   $43, $6c, $05, $c2, $6d, $00, $89, $0c        ;; 0c:57d7 ????????
    db   $89, $d1, $02, $c3, $01, $1f, $20, $32        ;; 0c:57df ????????
    db   $0c, $15, $e1, $00, $01, $e3, $2d, $d0        ;; 0c:57e7 ????????
    db   $1f, $00, $a6, $6c, $32, $1f, $05, $e7        ;; 0c:57ef ????????
    db   $6d, $00, $b8, $12, $24, $c2, $02, $01        ;; 0c:57f7 ????????
    db   $89, $1f, $05, $8c, $6e, $20, $74, $0c        ;; 0c:57ff ????????
    db   $24, $c1, $05, $03, $b8, $31, $74, $1f        ;; 0c:5807 ????????
    db   $05, $89, $6a, $21, $74, $cc, $00, $1f        ;; 0c:580f ????????
    db   $02, $23, $58, $05, $f8, $6b, $05, $55        ;; 0c:5817 ????????
    db   $6b, $02, $e7, $64, $02, $93, $6c, $05        ;; 0c:581f ????????
    db   $3a, $6c, $05, $05, $69, $05, $fe, $69        ;; 0c:5827 ????????
    db   $00, $b3, $0c, $25, $03, $ab, $1f, $02        ;; 0c:582f ????????
    db   $3c, $58, $02, $f1, $56, $00, $b8, $12        ;; 0c:5837 ????????
    db   $25, $1f, $20, $74, $0c, $24, $c1, $05        ;; 0c:583f ????????
    db   $03, $b8, $1f, $05, $f8, $6b, $05, $55        ;; 0c:5847 ????????
    db   $6b, $05, $2b, $6c, $05, $4e, $69, $01        ;; 0c:584f ????????
    db   $76, $cc, $00, $1f, $06, $02, $43, $55        ;; 0c:5857 ????????
    db   $20, $74, $12, $25, $03, $24, $c1, $02        ;; 0c:585f ????????
    db   $1f, $05, $46, $65, $05, $63, $67, $01        ;; 0c:5867 ????????
    db   $1a, $cc, $00, $1f, $02, $79, $58, $05        ;; 0c:586f ????????
    db   $e7, $64, $07, $15, $01, $15, $0f, $01        ;; 0c:5877 ????????
    db   $1f, $02, $6b, $58, $06, $05, $72, $65        ;; 0c:587f ????????
    db   $05, $ef, $69, $05, $e7, $6d, $05, $32        ;; 0c:5887 ????????
    db   $6a, $05, $98, $6a, $21, $74, $ce, $00        ;; 0c:588f ????????
    db   $1f, $02, $9e, $58, $02, $93, $6c, $05        ;; 0c:5897 ????????
    db   $f8, $6b, $05, $55, $6b, $05, $2b, $6c        ;; 0c:589f ????????
    db   $05, $4e, $69, $01, $76, $cc, $00, $1f        ;; 0c:58a7 ????????
    db   $02, $b5, $58, $02, $43, $55, $a1, $64        ;; 0c:58af ????????
    db   $0f, $25, $1f, $02, $be, $58, $06, $20        ;; 0c:58b7 ????????
    db   $32, $cc, $03, $1f, $05, $a5, $6e, $80        ;; 0c:58bf ????????
    db   $32, $cc, $ff, $1f, $a0, $0c, $d9, $cc        ;; 0c:58c7 ????????
    db   $30, $1f, $02, $d4, $6c, $05, $e0, $58        ;; 0c:58cf ????????
    db   $01, $b7, $ce, $00, $1f, $06, $02, $84        ;; 0c:58d7 ????????
    db   $6c, $05, $46, $65, $05, $63, $67, $01        ;; 0c:58df ????????
    db   $1a, $cc, $00, $1f, $02, $0d, $59, $05        ;; 0c:58e7 ????????
    db   $84, $6e, $00, $30, $cc, $0a, $1f, $00        ;; 0c:58ef ????????
    db   $1b, $6c, $30, $1f, $01, $1b, $0e, $24        ;; 0c:58f7 ????????
    db   $1f, $02, $0d, $59, $05, $63, $67, $60        ;; 0c:58ff ????????
    db   $30, $cc, $00, $1f, $07, $b7, $07, $15        ;; 0c:5907 ????????
    db   $01, $15, $0f, $01, $1f, $02, $e3, $58        ;; 0c:590f ????????
    db   $06, $05, $60, $6c, $05, $05, $69, $20        ;; 0c:5917 ????????
    db   $74, $12, $25, $03, $24, $1f, $05, $6d        ;; 0c:591f ????????
    db   $6a, $20, $0a, $8c, $32, $1f, $80, $32        ;; 0c:5927 ????????
    db   $8c, $32, $23, $74, $1f, $05, $76, $6a        ;; 0c:592f ????????
    db   $20, $b5, $8c, $32, $24, $0a, $1f, $05        ;; 0c:5937 ????????
    db   $f8, $6b, $05, $cb, $6b, $02, $45, $6e        ;; 0c:593f ????????
    db   $05, $60, $6c, $05, $05, $69, $05, $ec        ;; 0c:5947 ????????
    db   $67, $60, $32, $0c, $07, $05, $24, $1f        ;; 0c:594f ????????
    db   $00, $76, $0c, $07, $68, $32, $1f, $05        ;; 0c:5957 ????????
    db   $f8, $6b, $05, $cb, $6b, $05, $0c, $6d        ;; 0c:595f ????????
    db   $06, $05, $43, $6c, $05, $a2, $6c, $05        ;; 0c:5967 ????????
    db   $6b, $68, $05, $4f, $68, $c1, $00, $0d        ;; 0c:596f ????????
    db   $a6, $05, $25, $1f, $02, $b7, $59, $05        ;; 0c:5977 ????????
    db   $5d, $68, $05, $91, $68, $c1, $00, $0c        ;; 0c:597f ????????
    db   $a7, $05, $25, $1f, $02, $9d, $59, $00        ;; 0c:5987 ????????
    db   $a4, $cc, $00, $1f, $00, $ac, $0c, $ac        ;; 0c:598f ????????
    db   $c3, $05, $1f, $05, $72, $6c, $05, $00        ;; 0c:5997 ????????
    db   $6e, $05, $46, $6a, $21, $74, $cc, $00        ;; 0c:599f ????????
    db   $1f, $02, $b4, $59, $05, $f8, $6b, $05        ;; 0c:59a7 ????????
    db   $55, $6b, $02, $e7, $64, $02, $93, $6c        ;; 0c:59af ????????
    db   $05, $69, $6c, $02, $84, $6c, $05, $43        ;; 0c:59b7 ????????
    db   $6c, $05, $a2, $6c, $05, $4f, $68, $c1        ;; 0c:59bf ????????
    db   $00, $0d, $a6, $05, $25, $1f, $02, $b7        ;; 0c:59c7 ????????
    db   $59, $05, $5d, $68, $05, $91, $68, $05        ;; 0c:59cf ????????
    db   $6b, $68, $05, $36, $6b, $01, $b4, $ae        ;; 0c:59d7 ????????
    db   $64, $1f, $02, $84, $6c, $05, $5a, $6a        ;; 0c:59df ????????
    db   $05, $96, $69, $05, $89, $6d, $07, $16        ;; 0c:59e7 ????????
    db   $01, $16, $0d, $03, $1f, $02, $e7, $59        ;; 0c:59ef ????????
    db   $05, $f8, $6b, $05, $55, $6b, $05, $3b        ;; 0c:59f7 ????????
    db   $6d, $c1, $00, $0c, $24, $c5, $90, $1f        ;; 0c:59ff ????????
    db   $06, $05, $63, $67, $60, $30, $cc, $00        ;; 0c:5a07 ????????
    db   $1f, $06, $05, $43, $6c, $05, $a4, $69        ;; 0c:5a0f ????????
    db   $01, $25, $0c, $a9, $c5, $f0, $1f, $02        ;; 0c:5a17 ????????
    db   $24, $5a, $02, $84, $6c, $05, $6b, $68        ;; 0c:5a1f ????????
    db   $05, $cd, $6e, $21, $74, $cc, $00, $1f        ;; 0c:5a27 ????????
    db   $02, $3b, $5a, $05, $f8, $6b, $05, $55        ;; 0c:5a2f ????????
    db   $6b, $02, $e7, $64, $02, $93, $6c, $05        ;; 0c:5a37 ????????
    db   $3a, $6c, $05, $ad, $6a, $01, $76, $cc        ;; 0c:5a3f ????????
    db   $01, $1f, $02, $89, $65, $05, $7c, $6e        ;; 0c:5a47 ????????
    db   $00, $30, $cc, $0b, $1f, $61, $30, $cc        ;; 0c:5a4f ????????
    db   $03, $1f, $02, $7f, $5a, $20, $32, $cc        ;; 0c:5a57 ????????
    db   $06, $1f, $05, $94, $6e, $05, $7c, $6e        ;; 0c:5a5f ????????
    db   $00, $30, $cc, $14, $1f, $20, $30, $6c        ;; 0c:5a67 ????????
    db   $32, $c1, $03, $23, $30, $1f, $00, $b9        ;; 0c:5a6f ????????
    db   $6c, $30, $1f, $01, $b9, $cc, $fe, $1f        ;; 0c:5a77 ????????
    db   $00, $b9, $0c, $25, $c4, $05, $1f, $00        ;; 0c:5a7f ????????
    db   $52, $12, $b9, $1f, $01, $52, $0f, $b3        ;; 0c:5a87 ????????
    db   $1f, $02, $96, $5a, $02, $f1, $56, $05        ;; 0c:5a8f ????????
    db   $ef, $69, $05, $e7, $6d, $00, $b8, $12        ;; 0c:5a97 ????????
    db   $ab, $1f, $05, $8c, $6e, $20, $74, $0c        ;; 0c:5a9f ????????
    db   $25, $04, $b9, $01, $24, $03, $b8, $31        ;; 0c:5aa7 ????????
    db   $74, $1f, $01, $b9, $cc, $01, $1f, $20        ;; 0c:5aaf ????????
    db   $74, $2c, $74, $c1, $03, $1f, $02, $1e        ;; 0c:5ab7 ????????
    db   $55, $05, $3a, $6c, $05, $ad, $6a, $01        ;; 0c:5abf ????????
    db   $76, $cc, $01, $1f, $02, $89, $65, $00        ;; 0c:5ac7 ????????
    db   $00, $cc, $00, $1f, $00, $b7, $cc, $00        ;; 0c:5acf ????????
    db   $1f, $20, $39, $cc, $00, $1f, $05, $ef        ;; 0c:5ad7 ????????
    db   $69, $05, $e7, $6d, $a1, $64, $0e, $b3        ;; 0c:5adf ????????
    db   $1f, $02, $fa, $5a, $07, $b7, $05, $32        ;; 0c:5ae7 ????????
    db   $6a, $05, $98, $6a, $20, $39, $2c, $39        ;; 0c:5aef ????????
    db   $23, $74, $1f, $07, $00, $01, $00, $0d        ;; 0c:5af7 ????????
    db   $25, $1f, $02, $e3, $5a, $01, $b7, $cc        ;; 0c:5aff ????????
    db   $00, $1f, $02, $23, $5b, $20, $74, $2c        ;; 0c:5b07 ????????
    db   $39, $1f, $c0, $00, $d9, $0c, $b7, $1f        ;; 0c:5b0f ????????
    db   $a0, $0c, $d9, $cc, $34, $1f, $03, $20        ;; 0c:5b17 ????????
    db   $00, $02, $21, $55, $02, $f1, $56, $05        ;; 0c:5b1f ????????
    db   $3a, $6c, $05, $4f, $68, $c1, $00, $0d        ;; 0c:5b27 ????????
    db   $a6, $05, $25, $1f, $02, $9e, $5b, $00        ;; 0c:5b2f ????????
    db   $76, $cc, $00, $1f, $05, $5a, $6a, $05        ;; 0c:5b37 ????????
    db   $ec, $67, $c1, $00, $0c, $90, $06, $24        ;; 0c:5b3f ????????
    db   $05, $07, $1f, $02, $5a, $5b, $07, $16        ;; 0c:5b47 ????????
    db   $01, $16, $0d, $03, $1f, $02, $3e, $5b        ;; 0c:5b4f ????????
    db   $02, $a1, $5b, $05, $b5, $6a, $01, $76        ;; 0c:5b57 ????????
    db   $cc, $01, $1f, $02, $89, $65, $a1, $64        ;; 0c:5b5f ????????
    db   $0f, $b3, $1f, $02, $70, $5b, $02, $f1        ;; 0c:5b67 ????????
    db   $56, $05, $5d, $68, $05, $91, $68, $05        ;; 0c:5b6f ????????
    db   $6b, $68, $05, $36, $6b, $01, $b4, $ae        ;; 0c:5b77 ????????
    db   $64, $1f, $02, $a1, $5b, $05, $96, $69        ;; 0c:5b7f ????????
    db   $05, $89, $6d, $05, $f8, $6b, $05, $55        ;; 0c:5b87 ????????
    db   $6b, $05, $3b, $6d, $c1, $00, $0c, $24        ;; 0c:5b8f ????????
    db   $c5, $90, $1f, $06, $02, $86, $69, $05        ;; 0c:5b97 ????????
    db   $69, $6c, $05, $84, $6c, $05, $05, $69        ;; 0c:5b9f ????????
    db   $20, $74, $cc, $00, $1f, $02, $5f, $63        ;; 0c:5ba7 ????????
    db   $05, $43, $6c, $05, $d6, $5d, $a1, $64        ;; 0c:5baf ????????
    db   $6e, $30, $11, $25, $1f, $02, $c2, $5b        ;; 0c:5bb7 ????????
    db   $02, $f1, $56, $00, $b8, $6c, $30, $c2        ;; 0c:5bbf ????????
    db   $04, $c3, $01, $1f, $60, $30, $6c, $30        ;; 0c:5bc7 ????????
    db   $11, $b8, $1f, $05, $f8, $6b, $05, $55        ;; 0c:5bcf ????????
    db   $6b, $05, $ea, $5b, $c0, $00, $d9, $0c        ;; 0c:5bd7 ????????
    db   $b8, $1f, $a0, $0c, $d9, $cc, $3e, $1f        ;; 0c:5bdf ????????
    db   $02, $d4, $6c, $a0, $0c, $d9, $cc, $37        ;; 0c:5be7 ????????
    db   $1f, $05, $63, $67, $01, $1a, $cc, $01        ;; 0c:5bef ????????
    db   $1f, $a0, $0c, $d9, $cc, $38, $1f, $03        ;; 0c:5bf7 ????????
    db   $20, $00, $a0, $0c, $d9, $cc, $13, $03        ;; 0c:5bff ????????
    db   $24, $1f, $03, $20, $00, $06                  ;; 0c:5c07 ??????
.data_0c_5c0d:
    db   $05                                           ;; 0c:5c0d .
    dw   .data_0c_6546                                 ;; 0c:5c0e pP
.data_0c_5c10:
    db   $05                                           ;; 0c:5c10 .
    dw   .data_0c_686b                                 ;; 0c:5c11 pP
    db   $05                                           ;; 0c:5c13 .
    dw   .data_0c_6e00                                 ;; 0c:5c14 pP
    db   $05                                           ;; 0c:5c16 .
    dw   .data_0c_6763                                 ;; 0c:5c17 pP
    db   $01, $1a, $cc, $00, $1f, $02                  ;; 0c:5c19 ......
    dw   .data_0c_5c5e                                 ;; 0c:5c1f pP
    db   $05                                           ;; 0c:5c21 .
    dw   .data_0c_6e57                                 ;; 0c:5c22 pP
    db   $05                                           ;; 0c:5c24 .
    dw   .data_0c_684f                                 ;; 0c:5c25 pP
    db   $c1, $00, $0d, $a6, $05, $25, $1f, $02        ;; 0c:5c27 ........
    db   $69, $5c, $05                                 ;; 0c:5c2f ??.
    dw   .data_0c_685d                                 ;; 0c:5c32 pP
    db   $05                                           ;; 0c:5c34 .
    dw   .data_0c_6891                                 ;; 0c:5c35 pP
    db   $c1, $00, $0c, $a7, $05, $25, $1f, $02        ;; 0c:5c37 ........
    dw   .data_0c_5c50                                 ;; 0c:5c3f pP
    db   $00, $a4, $cc, $00, $1f, $00, $ac, $0c        ;; 0c:5c41 ????????
    db   $ac, $c3, $05, $1f, $05, $72, $6c             ;; 0c:5c49 ???????
.data_0c_5c50:
    db   $05                                           ;; 0c:5c50 .
    dw   .data_0c_6a46                                 ;; 0c:5c51 pP
    db   $21, $74, $ce, $00, $1f, $02                  ;; 0c:5c53 ......
    dw   .data_0c_5c72                                 ;; 0c:5c59 pP
    db   $05, $93, $6c                                 ;; 0c:5c5b ???
.data_0c_5c5e:
    db   $07, $15, $01, $15, $0f, $01, $1f, $02        ;; 0c:5c5e .p......
    dw   .data_0c_5c10                                 ;; 0c:5c66 pP
    db   $06, $05, $69, $6c, $05, $84, $6c, $02        ;; 0c:5c68 .???????
    db   $5e, $5c                                      ;; 0c:5c70 ??
.data_0c_5c72:
    db   $05                                           ;; 0c:5c72 .
    dw   .data_0c_64e7                                 ;; 0c:5c73 pP
    db   $02                                           ;; 0c:5c75 .
    dw   .data_0c_5c5e                                 ;; 0c:5c76 pP
    db   $05, $e0, $58, $05, $b7, $68, $20, $32        ;; 0c:5c78 ????????
    db   $0c, $12, $e1, $00, $01, $e3, $41, $d0        ;; 0c:5c80 ????????
    db   $1f, $20, $32, $0c, $11, $c1, $08, $23        ;; 0c:5c88 ????????
    db   $32, $1f, $80, $32, $cc, $00, $1f, $05        ;; 0c:5c90 ????????
    db   $7b, $6c, $01, $b7, $ce, $00, $1f, $06        ;; 0c:5c98 ????????
    db   $a0, $0c, $d9, $cc, $39, $1f, $02, $d4        ;; 0c:5ca0 ????????
    db   $6c, $a0, $0c, $d9, $cc, $3a, $1f, $03        ;; 0c:5ca8 ????????
    db   $20, $00, $05, $fe, $69, $a1, $64, $0f        ;; 0c:5cb0 ????????
    db   $ab, $03, $24, $1f, $02, $c8, $5c, $a0        ;; 0c:5cb8 ????????
    db   $0c, $d9, $cc, $3b, $1f, $02, $d4, $6c        ;; 0c:5cc0 ????????
    db   $20, $74, $0c, $ab, $01, $25, $1f, $40        ;; 0c:5cc8 ????????
    db   $77, $53, $a2, $c2, $1f, $01, $12, $cf        ;; 0c:5cd0 ????????
    db   $04, $1f, $02, $0f, $5d, $e0, $a2, $c2        ;; 0c:5cd8 ????????
    db   $4c, $77, $31, $74, $1f, $40, $7c, $53        ;; 0c:5ce0 ????????
    db   $a2, $c2, $1f, $40, $77, $4c, $77, $44        ;; 0c:5ce8 ????????
    db   $7c, $1f, $21, $77, $cc, $00, $1f, $02        ;; 0c:5cf0 ????????
    db   $bf, $5c, $05, $f8, $6b, $05, $55, $6b        ;; 0c:5cf8 ????????
    db   $c0, $00, $d9, $2c, $77, $1f, $a0, $0c        ;; 0c:5d00 ????????
    db   $d9, $cc, $3c, $1f, $02, $d4, $6c, $e0        ;; 0c:5d08 ????????
    db   $a2, $c2, $4c, $77, $23, $74, $1f, $40        ;; 0c:5d10 ????????
    db   $7c, $53, $a2, $c2, $1f, $40, $4b, $53        ;; 0c:5d18 ????????
    db   $f0, $7f, $1f, $41, $7c, $4e, $4b, $1f        ;; 0c:5d20 ????????
    db   $40, $7c, $4c, $4b, $1f, $e0, $a2, $c2        ;; 0c:5d28 ????????
    db   $4c, $7c, $1f, $40, $77, $4c, $7c, $44        ;; 0c:5d30 ????????
    db   $77, $1f, $01, $77, $cc, $00, $1f, $02        ;; 0c:5d38 ????????
    db   $bf, $5c, $05, $f8, $6b, $05, $55, $6b        ;; 0c:5d40 ????????
    db   $c0, $00, $d9, $2c, $77, $1f, $a0, $0c        ;; 0c:5d48 ????????
    db   $d9, $cc, $3d, $1f, $02, $d4, $6c, $05        ;; 0c:5d50 ????????
    db   $43, $6c, $05, $a2, $6c, $05, $84, $6e        ;; 0c:5d58 ????????
    db   $00, $30, $cc, $0b, $1f, $00, $89, $6c        ;; 0c:5d60 ????????
    db   $30, $1f, $01, $25, $10, $89, $1f, $02        ;; 0c:5d68 ????????
    db   $75, $5d, $02, $84, $6c, $05, $84, $6e        ;; 0c:5d70 ????????
    db   $00, $30, $cc, $0c, $1f, $20, $0e, $8c        ;; 0c:5d78 ????????
    db   $30, $1f, $00, $b8, $12, $24, $1f, $20        ;; 0c:5d80 ????????
    db   $74, $2c, $0e, $01, $24, $02, $64, $03        ;; 0c:5d88 ????????
    db   $b8, $1f, $05, $f8, $6b, $05, $55, $6b        ;; 0c:5d90 ????????
    db   $02, $e7, $64, $05, $60, $6c, $05, $d6        ;; 0c:5d98 ????????
    db   $5d, $20, $74, $6c, $30, $03, $25, $1f        ;; 0c:5da0 ????????
    db   $21, $74, $ce, $ff, $1f, $20, $74, $cc        ;; 0c:5da8 ????????
    db   $ff, $1f, $00, $b8, $0c, $74, $64, $30        ;; 0c:5db0 ????????
    db   $1f, $60, $30, $0c, $74, $1f, $05, $f8        ;; 0c:5db8 ????????
    db   $6b, $05, $cb, $6b, $c0, $00, $d9, $0c        ;; 0c:5dc0 ????????
    db   $b8, $1f, $05, $ea, $5b, $a0, $0c, $d9        ;; 0c:5dc8 ????????
    db   $cc, $3f, $1f, $02, $d4, $6c, $05, $84        ;; 0c:5dd0 ????????
    db   $6e, $00, $30, $cc, $0e, $03, $24, $1f        ;; 0c:5dd8 ????????
    db   $06, $00, $15, $0c, $12, $1f, $05, $57        ;; 0c:5de0 ????????
    db   $6e, $02, $9b, $5d, $05, $72, $65, $05        ;; 0c:5de8 ????????
    db   $6b, $68, $05, $91, $68, $05, $cd, $6e        ;; 0c:5df0 ????????
    db   $20, $74, $2c, $74, $11, $a4, $1f, $05        ;; 0c:5df8 ????????
    db   $f8, $6b, $05, $55, $6b, $05, $2b, $6c        ;; 0c:5e00 ????????
    db   $05, $4e, $69, $05, $d8, $6c, $a0, $0c        ;; 0c:5e08 ????????
    db   $d9, $cc, $26, $1f, $03, $20, $00, $01        ;; 0c:5e10 ????????
    db   $76, $cc, $00, $1f, $02, $5f, $63, $02        ;; 0c:5e18 ????????
    db   $43, $55, $05, $6b, $68, $05, $46, $65        ;; 0c:5e20 ????????
    db   $05, $63, $67, $01, $1a, $cc, $00, $1f        ;; 0c:5e28 ????????
    db   $02, $82, $5e, $05, $57, $6e, $05, $4f        ;; 0c:5e30 ????????
    db   $68, $c1, $00, $0d, $a6, $05, $25, $1f        ;; 0c:5e38 ????????
    db   $02, $8d, $5e, $05, $5d, $68, $05, $91        ;; 0c:5e40 ????????
    db   $68, $05, $36, $6b, $01, $b4, $ae, $64        ;; 0c:5e48 ????????
    db   $1f, $02, $7f, $5e, $05, $5a, $6a, $05        ;; 0c:5e50 ????????
    db   $96, $69, $05, $89, $6d, $07, $16, $01        ;; 0c:5e58 ????????
    db   $16, $0d, $03, $1f, $02, $57, $5e, $05        ;; 0c:5e60 ????????
    db   $3b, $6d, $c1, $00, $0c, $24, $c5, $90        ;; 0c:5e68 ????????
    db   $1f, $02, $82, $5e, $05, $63, $67, $60        ;; 0c:5e70 ????????
    db   $30, $cc, $00, $1f, $02, $82, $5e, $05        ;; 0c:5e78 ????????
    db   $84, $6c, $07, $15, $01, $15, $0f, $01        ;; 0c:5e80 ????????
    db   $1f, $02, $28, $5e, $06, $05, $69, $6c        ;; 0c:5e88 ????????
    db   $02, $7f, $5e, $05, $7c, $6e, $00, $30        ;; 0c:5e90 ????????
    db   $cc, $00, $1f, $00, $19, $6c, $30, $1f        ;; 0c:5e98 ????????
    db   $01, $19, $d0, $09, $1f, $02, $5a, $54        ;; 0c:5ea0 ????????
    db   $07, $19, $60, $30, $0c, $19, $1f, $27        ;; 0c:5ea8 ????????
    db   $30, $00, $1a, $6c, $30, $1f, $07, $1a        ;; 0c:5eb0 ????????
    db   $60, $30, $0c, $1a, $1f, $20, $32, $0c        ;; 0c:5eb8 ????????
    db   $12, $c1, $20, $03, $19, $c1, $08, $e3        ;; 0c:5ec0 ????????
    db   $38, $d0, $1f, $60, $32, $cc, $00, $1f        ;; 0c:5ec8 ????????
    db   $07, $32, $05, $7c, $6e, $00, $30, $cc        ;; 0c:5ed0 ????????
    db   $0c, $1f, $80, $32, $8c, $30, $c1, $08        ;; 0c:5ed8 ????????
    db   $c2, $0a, $1f, $a0, $0c, $d9, $cc, $5c        ;; 0c:5ee0 ????????
    db   $1f, $03, $20, $00, $05, $f8, $6b, $00        ;; 0c:5ee8 ????????
    db   $15, $0c, $12, $1f, $05, $55, $6b, $06        ;; 0c:5ef0 ????????
    db   $c1, $05, $13, $48, $d8, $1f, $a0, $b0        ;; 0c:5ef8 ????????
    db   $ff, $cc, $12, $1f, $a0, $0c, $d9, $13        ;; 0c:5f00 ????????
    db   $48, $d8, $c3, $5c, $1f, $02, $d4, $6c        ;; 0c:5f08 ????????
    db   $a0, $0c, $d9, $cc, $62, $1f, $03, $20        ;; 0c:5f10 ????????
    db   $00, $02, $95, $56, $20, $08, $33, $41        ;; 0c:5f18 ????????
    db   $d5, $1f, $05, $39, $5f, $21, $08, $ed        ;; 0c:5f20 ????????
    db   $10, $27, $1f, $02, $33, $5f, $01, $54        ;; 0c:5f28 ????????
    db   $ce, $14, $1f, $05, $63, $5f, $02, $95        ;; 0c:5f30 ????????
    db   $56, $20, $0e, $33, $0c, $d5, $1f, $00        ;; 0c:5f38 ????????
    db   $54, $13, $48, $d8, $1f, $06, $20, $08        ;; 0c:5f40 ????????
    db   $33, $41, $d5, $1f, $05, $39, $5f, $21        ;; 0c:5f48 ????????
    db   $08, $ed, $10, $27, $1f, $02, $5d, $5f        ;; 0c:5f50 ????????
    db   $01, $54, $ce, $14, $1f, $05, $63, $5f        ;; 0c:5f58 ????????
    db   $02, $0d, $5c, $00, $00, $cc, $00, $1f        ;; 0c:5f60 ????????
    db   $05, $55, $67, $01, $1a, $ce, $00, $1f        ;; 0c:5f68 ????????
    db   $02, $7d, $5f, $07, $00, $01, $00, $cf        ;; 0c:5f70 ????????
    db   $04, $1f, $02, $68, $5f, $c0, $0a, $d9        ;; 0c:5f78 ????????
    db   $0c, $00, $1f, $a0, $0c, $d9, $cc, $63        ;; 0c:5f80 ????????
    db   $1f, $a0, $b0, $ff, $cc, $04, $1f, $03        ;; 0c:5f88 ????????
    db   $20, $00, $00, $c0, $cc, $01, $1f, $06        ;; 0c:5f90 ????????
    db   $00, $16, $cc, $00, $1f, $a0, $0c, $d9        ;; 0c:5f98 ????????
    db   $cc, $64, $1f, $03, $20, $00, $00, $15        ;; 0c:5fa0 ????????
    db   $cc, $08, $1f, $c1, $01, $13, $01, $d4        ;; 0c:5fa8 ????????
    db   $1f, $02, $fc, $5f, $05, $f8, $6b, $05        ;; 0c:5fb0 ????????
    db   $55, $6b, $a0, $0c, $d9, $cc, $66, $1f        ;; 0c:5fb8 ????????
    db   $03, $20, $00, $05, $dc, $6e, $05, $63        ;; 0c:5fc0 ????????
    db   $67, $01, $1a, $cc, $00, $1f, $02, $ef        ;; 0c:5fc8 ????????
    db   $5f, $05, $57, $6e, $05, $b9, $60, $20        ;; 0c:5fd0 ????????
    db   $74, $2c, $74, $c2, $04, $1f, $05, $4e        ;; 0c:5fd8 ????????
    db   $69, $05, $2b, $6c, $01, $76, $cc, $00        ;; 0c:5fe0 ????????
    db   $1f, $02, $ef, $5f, $05, $43, $55, $07        ;; 0c:5fe8 ????????
    db   $15, $01, $15, $cf, $04, $1f, $02, $c6        ;; 0c:5ff0 ????????
    db   $5f, $02, $c4, $60, $00, $60, $cc, $00        ;; 0c:5ff8 ????????
    db   $1f, $00, $b7, $cc, $00, $1f, $a0, $0c        ;; 0c:6000 ????????
    db   $d9, $cc, $65, $1f, $03, $20, $00, $05        ;; 0c:6008 ????????
    db   $f8, $6b, $05, $55, $6b, $a0, $0c, $d9        ;; 0c:6010 ????????
    db   $cc, $66, $1f, $03, $20, $00, $20, $30        ;; 0c:6018 ????????
    db   $0c, $60, $e1, $00, $01, $e3, $01, $d0        ;; 0c:6020 ????????
    db   $1f, $61, $30, $cc, $01, $1f, $07, $b7        ;; 0c:6028 ????????
    db   $07, $60, $01, $60, $cf, $03, $1f, $02        ;; 0c:6030 ????????
    db   $1e, $60, $01, $b7, $ce, $00, $1f, $02        ;; 0c:6038 ????????
    db   $6a, $60, $c0, $0a, $d9, $cc, $04, $1f        ;; 0c:6040 ????????
    db   $05, $b9, $60, $00, $15, $cc, $04, $1f        ;; 0c:6048 ????????
    db   $05, $4e, $69, $05, $2b, $6c, $01, $76        ;; 0c:6050 ????????
    db   $cc, $00, $1f, $02, $ef, $5f, $c0, $0a        ;; 0c:6058 ????????
    db   $d9, $cc, $04, $1f, $05, $43, $55, $02        ;; 0c:6060 ????????
    db   $c4, $60, $05, $dc, $6e, $05, $63, $67        ;; 0c:6068 ????????
    db   $01, $1a, $cc, $00, $1f, $02, $9d, $60        ;; 0c:6070 ????????
    db   $05, $57, $6e, $05, $b9, $60, $20, $74        ;; 0c:6078 ????????
    db   $2c, $74, $02, $b7, $1f, $c0, $00, $d9        ;; 0c:6080 ????????
    db   $2c, $74, $1f, $a0, $10, $d9, $cc, $00        ;; 0c:6088 ????????
    db   $1f, $a0, $0c, $d9, $cc, $67, $1f, $03        ;; 0c:6090 ????????
    db   $20, $00, $03, $e0, $01, $07, $15, $01        ;; 0c:6098 ????????
    db   $15, $cf, $03, $1f, $02, $6d, $60, $c0        ;; 0c:60a0 ????????
    db   $41, $d4, $cc, $00, $1f, $c0, $0a, $d9        ;; 0c:60a8 ????????
    db   $cc, $04, $1f, $05, $43, $55, $02, $c4        ;; 0c:60b0 ????????
    db   $60, $00, $74, $12, $25, $1f, $00, $75        ;; 0c:60b8 ????????
    db   $0c, $24, $1f, $06, $a0, $01, $d5, $cc        ;; 0c:60c0 ????????
    db   $00, $1f, $00, $c0, $cc, $00, $1f, $06        ;; 0c:60c8 ????????
    db   $00, $16, $cc, $00, $1f, $01, $c0, $cc        ;; 0c:60d0 ????????
    db   $00, $1f, $02, $4e, $61, $01, $c0, $cc        ;; 0c:60d8 ????????
    db   $01, $1f, $02, $10, $62, $a0, $b0, $ff        ;; 0c:60e0 ????????
    db   $cc, $13, $1f, $a0, $0c, $d9, $cc, $6c        ;; 0c:60e8 ????????
    db   $1f, $03, $20, $00, $a0, $10, $d9, $cc        ;; 0c:60f0 ????????
    db   $19, $1f, $a0, $b2, $ff, $cc, $18, $1f        ;; 0c:60f8 ????????
    db   $03, $e0, $01, $05, $dc, $6e, $05, $63        ;; 0c:6100 ????????
    db   $67, $01, $1a, $cc, $00, $1f, $02, $3a        ;; 0c:6108 ????????
    db   $61, $20, $74, $12, $25, $c1, $12, $03        ;; 0c:6110 ????????
    db   $aa, $1f, $05, $4e, $69, $05, $57, $6e        ;; 0c:6118 ????????
    db   $05, $2b, $6c, $a0, $b2, $ff, $cc, $28        ;; 0c:6120 ????????
    db   $1f, $a0, $10, $d9, $cc, $00, $1f, $03        ;; 0c:6128 ????????
    db   $e0, $01, $01, $76, $ce, $00, $1f, $05        ;; 0c:6130 ????????
    db   $43, $55, $07, $15, $01, $15, $cf, $04        ;; 0c:6138 ????????
    db   $1f, $02, $06, $61, $a0, $10, $d9, $cc        ;; 0c:6140 ????????
    db   $1a, $1f, $03, $e0, $01, $06, $00, $60        ;; 0c:6148 ????????
    db   $cc, $00, $1f, $20, $74, $cc, $00, $1f        ;; 0c:6150 ????????
    db   $c0, $00, $d9, $0c, $60, $c3, $01, $1f        ;; 0c:6158 ????????
    db   $20, $30, $ec, $cb, $cf, $03, $60, $1f        ;; 0c:6160 ????????
    db   $61, $30, $cc, $01, $1f, $02, $9f, $61        ;; 0c:6168 ????????
    db   $20, $74, $12, $25, $23, $74, $03, $25        ;; 0c:6170 ????????
    db   $1f, $a0, $0c, $d9, $cc, $6a, $1f, $03        ;; 0c:6178 ????????
    db   $20, $00, $a0, $10, $d9, $cc, $15, $03        ;; 0c:6180 ????????
    db   $60, $1f, $a0, $b2, $ff, $cc, $25, $1f        ;; 0c:6188 ????????
    db   $03, $e0, $01, $a0, $10, $d9, $cc, $00        ;; 0c:6190 ????????
    db   $1f, $03, $e0, $01, $02, $c1, $61, $20        ;; 0c:6198 ????????
    db   $30, $0c, $60, $c1, $02, $e3, $c3, $cf        ;; 0c:61a0 ????????
    db   $1f, $80, $30, $8c, $30, $d1, $fb, $1f        ;; 0c:61a8 ????????
    db   $a0, $0c, $d9, $cc, $68, $1f, $03, $20        ;; 0c:61b0 ????????
    db   $00, $81, $30, $cc, $00, $1f, $02, $f5        ;; 0c:61b8 ????????
    db   $61, $07, $60, $01, $60, $cf, $03, $1f        ;; 0c:61c0 ????????
    db   $02, $58, $61, $05, $dc, $6e, $05, $63        ;; 0c:61c8 ????????
    db   $67, $01, $1a, $cc, $00, $1f, $02, $ea        ;; 0c:61d0 ????????
    db   $61, $05, $57, $6e, $05, $4e, $69, $05        ;; 0c:61d8 ????????
    db   $2b, $6c, $01, $76, $ce, $00, $1f, $05        ;; 0c:61e0 ????????
    db   $43, $55, $07, $15, $01, $15, $cf, $04        ;; 0c:61e8 ????????
    db   $1f, $02, $ce, $61, $06, $20, $30, $ec        ;; 0c:61f0 ????????
    db   $cb, $cf, $03, $60, $1f, $60, $30, $cc        ;; 0c:61f8 ????????
    db   $00, $1f, $08, $cf, $a0, $0c, $d9, $cc        ;; 0c:6200 ????????
    db   $69, $1f, $03, $20, $00, $02, $c1, $61        ;; 0c:6208 ????????
    db   $a0, $b0, $ff, $cc, $11, $1f, $02, $12        ;; 0c:6210 ????????
    db   $55, $05, $6b, $68, $05, $00, $6e, $a0        ;; 0c:6218 ????????
    db   $0c, $d9, $cc, $04, $1f, $03, $20, $00        ;; 0c:6220 ????????
    db   $05, $f8, $6b, $01, $12, $cf, $04, $1f        ;; 0c:6228 ????????
    db   $02, $44, $62, $01, $15, $cc, $09, $1f        ;; 0c:6230 ????????
    db   $02, $4c, $62, $05, $55, $6b, $05, $67        ;; 0c:6238 ????????
    db   $6e, $02, $4f, $62, $01, $15, $cc, $09        ;; 0c:6240 ????????
    db   $1f, $02, $3b, $62, $05, $5e, $6e, $05        ;; 0c:6248 ????????
    db   $63, $67, $01, $1a, $cc, $00, $1f, $02        ;; 0c:6250 ????????
    db   $99, $62, $05, $91, $68, $05, $e8, $6e        ;; 0c:6258 ????????
    db   $00, $b7, $cc, $00, $1f, $05, $5a, $6a        ;; 0c:6260 ????????
    db   $05, $ec, $67, $c1, $00, $0d, $07, $c5        ;; 0c:6268 ????????
    db   $90, $1f, $02, $84, $62, $05, $6d, $6a        ;; 0c:6270 ????????
    db   $80, $32, $8c, $32, $23, $b5, $1f, $07        ;; 0c:6278 ????????
    db   $b7, $05, $76, $6a, $07, $16, $01, $16        ;; 0c:6280 ????????
    db   $0d, $03, $1f, $02, $68, $62, $01, $b7        ;; 0c:6288 ????????
    db   $cc, $00, $1f, $02, $99, $62, $05, $45        ;; 0c:6290 ????????
    db   $6e, $07, $15, $01, $15, $0f, $01, $1f        ;; 0c:6298 ????????
    db   $02, $4f, $62, $06, $05, $dc, $6e, $05        ;; 0c:62a0 ????????
    db   $84, $6e, $00, $30, $cc, $00, $1f, $20        ;; 0c:62a8 ????????
    db   $88, $2c, $30, $c3, $01, $1f, $60, $88        ;; 0c:62b0 ????????
    db   $6c, $30, $1f, $20, $32, $2c, $30, $c3        ;; 0c:62b8 ????????
    db   $40, $1f, $60, $32, $cc, $00, $1f, $20        ;; 0c:62c0 ????????
    db   $88, $2c, $30, $c3, $0c, $1f, $20, $32        ;; 0c:62c8 ????????
    db   $2c, $30, $c3, $41, $1f, $80, $32, $8c        ;; 0c:62d0 ????????
    db   $88, $1f, $07, $15, $01, $15, $cf, $04        ;; 0c:62d8 ????????
    db   $1f, $02, $a7, $62, $a0, $0c, $d9, $cc        ;; 0c:62e0 ????????
    db   $36, $1f, $02, $d4, $6c, $05, $05, $69        ;; 0c:62e8 ????????
    db   $a0, $0c, $d9, $cc, $42, $1f, $03, $20        ;; 0c:62f0 ????????
    db   $00, $05, $b5, $69, $01, $a8, $ce, $f0        ;; 0c:62f8 ????????
    db   $1f, $02, $0c, $63, $a1, $64, $cf, $1e        ;; 0c:6300 ????????
    db   $1f, $02, $2f, $63, $00, $b8, $12, $aa        ;; 0c:6308 ????????
    db   $1f, $20, $74, $0c, $aa, $01, $24, $03        ;; 0c:6310 ????????
    db   $b8, $1f, $05, $f8, $6b, $05, $55, $6b        ;; 0c:6318 ????????
    db   $05, $2b, $6c, $05, $4e, $69, $01, $76        ;; 0c:6320 ????????
    db   $cc, $00, $1f, $06, $02, $43, $55, $a0        ;; 0c:6328 ????????
    db   $b2, $ff, $cc, $1a, $1f, $00, $f5, $0c        ;; 0c:6330 ????????
    db   $15, $1f, $a0, $10, $d9, $cc, $c7, $1f        ;; 0c:6338 ????????
    db   $03, $e0, $01, $a0, $0c, $d9, $cc, $43        ;; 0c:6340 ????????
    db   $1f, $03, $20, $00, $20, $0a, $cc, $00        ;; 0c:6348 ????????
    db   $1f, $05, $6d, $6a, $80, $32, $0c, $0a        ;; 0c:6350 ????????
    db   $1f, $05, $43, $55, $02, $69, $69             ;; 0c:6358 ???????
.data_0c_635f:
    db   $05                                           ;; 0c:635f .
    dw   .data_0c_69c3                                 ;; 0c:6360 pP
    db   $05                                           ;; 0c:6362 .
    dw   .data_0c_69d1                                 ;; 0c:6363 pP
    db   $c0, $08, $d9, $2c, $17, $1f, $c1, $00        ;; 0c:6365 ........
    db   $0d, $b0, $c5, $01, $1f, $05, $8a, $63        ;; 0c:636d ......??
    db   $c1, $00, $0d, $b0, $c5, $02, $1f, $05        ;; 0c:6375 ........
    db   $e5, $63, $c1, $00, $0d, $b0, $c5, $04        ;; 0c:637d ??......
    db   $1f, $05, $5d, $64, $06, $a0, $0c, $d9        ;; 0c:6385 ..??.???
    db   $cc, $44, $1f, $03, $20, $00, $05, $84        ;; 0c:638d ????????
    db   $6e, $00, $30, $cc, $0e, $1f, $00, $a2        ;; 0c:6395 ????????
    db   $6c, $30, $1f, $c1, $00, $0d, $07, $c5        ;; 0c:639d ????????
    db   $04, $1f, $00, $a2, $0c, $a2, $c2, $02        ;; 0c:63a5 ????????
    db   $1f, $05, $84, $6e, $05, $e2, $6e, $81        ;; 0c:63ad ????????
    db   $30, $ec, $00, $01, $1f, $00, $a2, $13        ;; 0c:63b5 ????????
    db   $da, $c2, $c5, $0f, $c3, $05, $03, $a2        ;; 0c:63bd ????????
    db   $1f, $05, $f5, $68, $21, $74, $0d, $a2        ;; 0c:63c5 ????????
    db   $c1, $02, $1f, $20, $74, $0c, $a2, $c1        ;; 0c:63cd ????????
    db   $02, $1f, $20, $74, $2c, $74, $01, $b1        ;; 0c:63d5 ????????
    db   $c2, $0a, $03, $a2, $1f, $02, $b7, $64        ;; 0c:63dd ????????
    db   $a0, $0c, $d9, $cc, $44, $1f, $03, $20        ;; 0c:63e5 ????????
    db   $00, $05, $f5, $68, $05, $33, $68, $05        ;; 0c:63ed ????????
    db   $23, $68, $c1, $00, $0d, $ad, $05, $b2        ;; 0c:63f5 ????????
    db   $1f, $02, $2c, $64, $05, $41, $68, $05        ;; 0c:63fd ????????
    db   $6b, $68, $05, $91, $68, $00, $b4, $cc        ;; 0c:6405 ????????
    db   $00, $1f, $c1, $00, $0d, $ae, $05, $b2        ;; 0c:640d ????????
    db   $1f, $00, $b4, $0c, $ac, $11, $a4, $c1        ;; 0c:6415 ????????
    db   $02, $c3, $32, $1f, $01, $b4, $ad, $64        ;; 0c:641d ????????
    db   $1f, $02, $32, $64, $02, $2f, $64, $05        ;; 0c:6425 ????????
    db   $69, $6c, $02, $84, $6c, $05, $f9, $6e        ;; 0c:642d ????????
    db   $05, $94, $6e, $60, $32, $6c, $32, $06        ;; 0c:6435 ????????
    db   $b1, $1f, $05, $09, $6c, $05, $ae, $6b        ;; 0c:643d ????????
    db   $00, $24, $0c, $b1, $1f, $00, $15, $0c        ;; 0c:6445 ????????
    db   $12, $1f, $05, $3b, $6d, $c1, $00, $6d        ;; 0c:644d ????????
    db   $32, $c5, $90, $1f, $05, $c4, $68, $06        ;; 0c:6455 ????????
    db   $a0, $0c, $d9, $cc, $44, $1f, $03, $20        ;; 0c:645d ????????
    db   $00, $05, $23, $68, $05, $33, $68, $c1        ;; 0c:6465 ????????
    db   $00, $0d, $ad, $05, $b2, $1f, $02, $db        ;; 0c:646d ????????
    db   $64, $05, $41, $68, $05, $6b, $68, $05        ;; 0c:6475 ????????
    db   $91, $68, $c1, $00, $0d, $ae, $05, $b2        ;; 0c:647d ????????
    db   $1f, $00, $ac, $cc, $00, $1f, $05, $f5        ;; 0c:6485 ????????
    db   $68, $00, $b8, $12, $a4, $1f, $20, $74        ;; 0c:648d ????????
    db   $0c, $a4, $01, $b1, $03, $b8, $1f, $20        ;; 0c:6495 ????????
    db   $39, $2c, $74, $01, $ac, $c2, $c8, $1f        ;; 0c:649d ????????
    db   $20, $74, $2c, $74, $31, $39, $1f, $21        ;; 0c:64a5 ????????
    db   $74, $ce, $00, $1f, $02, $b7, $64, $02        ;; 0c:64ad ????????
    db   $93, $6c, $05, $d4, $68, $05, $09, $6c        ;; 0c:64b5 ????????
    db   $05, $ae, $6b, $c0, $00, $d9, $2c, $74        ;; 0c:64bd ????????
    db   $1f, $a0, $0c, $d9, $cc, $45, $1f, $03        ;; 0c:64c5 ????????
    db   $20, $00, $21, $08, $ce, $00, $1f, $06        ;; 0c:64cd ????????
    db   $05, $7b, $6c, $02, $b7, $68, $a0, $0c        ;; 0c:64d5 ????????
    db   $d9, $cc, $46, $1f, $03, $20, $00, $02        ;; 0c:64dd ????????
    db   $84, $6c                                      ;; 0c:64e5 ??
.data_0c_64e7:
    db   $c0, $00, $d9, $2c, $74, $1f, $05             ;; 0c:64e7 .......
    dw   .data_0c_6e57                                 ;; 0c:64ee pP
    db   $a0, $0c, $d9, $cc, $40, $1f, $05             ;; 0c:64f0 .......
    dw   .data_0c_6763                                 ;; 0c:64f7 pP
    db   $01, $1a, $cc, $01, $1f, $a0, $0c, $d9        ;; 0c:64f9 ........
    db   $cc, $41, $1f, $03                            ;; 0c:6501 .w..
    dw   $0020                                         ;; 0c:6505 pP
    db   $05                                           ;; 0c:6507 .
    dw   .data_0c_6a5a                                 ;; 0c:6508 pP
    db   $00, $b7, $cc, $00, $1f, $05                  ;; 0c:650a ......
    dw   .data_0c_67ec                                 ;; 0c:6510 pP
    db   $c1, $00, $0d, $07, $c5, $90, $1f, $02        ;; 0c:6512 ........
    db   $26, $65, $05                                 ;; 0c:651a ??.
    dw   .data_0c_694e                                 ;; 0c:651d pP
    db   $01, $76, $cc, $01, $1f, $07, $b7, $07        ;; 0c:651f ......?.
    db   $16, $01, $16, $0d, $03, $1f, $02, $0f        ;; 0c:6527 p......?
    db   $65, $01, $b7, $cc, $00, $1f, $06, $c0        ;; 0c:652f ?......?
    db   $02, $d9, $0c, $b7, $1f, $a0, $0c, $d9        ;; 0c:6537 ????????
    db   $cc, $48, $1f, $03, $20, $00, $06             ;; 0c:653f ???????
.data_0c_6546:
    db   $05                                           ;; 0c:6546 .
    dw   .data_0c_6c57                                 ;; 0c:6547 pP
    db   $05                                           ;; 0c:6549 .
    dw   .data_0c_6bf8                                 ;; 0c:654a pP
    db   $05                                           ;; 0c:654c .
    dw   .data_0c_6b55                                 ;; 0c:654d pP
    db   $00, $b7, $cc, $00, $1f, $01, $12, $cf        ;; 0c:654f ........
    db   $04, $1f, $02                                 ;; 0c:6557 ...
    dw   .data_0c_6567                                 ;; 0c:655a pP
    db   $01, $15, $cc, $08, $1f, $02, $67, $6e        ;; 0c:655c ????????
    db   $02, $5e, $6e                                 ;; 0c:6564 ???
.data_0c_6567:
    db   $01, $15, $cc, $08, $1f, $02, $5e, $6e        ;; 0c:6567 ......??
    db   $02                                           ;; 0c:656f .
    dw   .data_0c_6e67                                 ;; 0c:6570 pP
.data_0c_6572:
    db   $05                                           ;; 0c:6572 .
    dw   .data_0c_6c3a                                 ;; 0c:6573 pP
    db   $05                                           ;; 0c:6575 .
    dw   .data_0c_6aad                                 ;; 0c:6576 pP
    db   $01, $76, $cc, $01, $1f, $02, $89, $65        ;; 0c:6578 ......??
    db   $a1, $64, $0f, $b3, $1f, $06, $05, $f1        ;; 0c:6580 ......??
    db   $56, $1f, $05, $7b, $6d, $c1, $00, $0c        ;; 0c:6588 ????????
    db   $07, $c5, $90, $1f, $02, $9d, $65, $00        ;; 0c:6590 ????????
    db   $f4, $cc, $01, $1f, $06, $20, $30, $ec        ;; 0c:6598 ????????
    db   $0d, $c2, $03, $88, $1f, $00, $ac, $6c        ;; 0c:65a0 ????????
    db   $30, $1f, $20, $30, $ec, $0d, $c2, $03        ;; 0c:65a8 ????????
    db   $94, $1f, $00, $a4, $6c, $30, $1f, $05        ;; 0c:65b0 ????????
    db   $e8, $6e, $20, $32, $0c, $94, $e3, $07        ;; 0c:65b8 ????????
    db   $c2, $1f, $80, $32, $8c, $32, $23, $b5        ;; 0c:65c0 ????????
    db   $1f, $20, $30, $0c, $94, $e3, $09, $c2        ;; 0c:65c8 ????????
    db   $1f, $81, $32, $8e, $30, $1f, $80, $32        ;; 0c:65d0 ????????
    db   $8c, $30, $1f, $02, $aa, $66, $05, $7b        ;; 0c:65d8 ????????
    db   $6d, $c1, $00, $0c, $07, $c5, $90, $1f        ;; 0c:65e0 ????????
    db   $02, $ee, $65, $02, $97, $65, $27, $34        ;; 0c:65e8 ????????
    db   $00, $25, $6c, $34, $1f, $20, $b5, $12        ;; 0c:65f0 ????????
    db   $25, $03, $24, $1f, $02, $ba, $65, $05        ;; 0c:65f8 ????????
    db   $7b, $6d, $00, $06, $0c, $07, $05, $24        ;; 0c:6600 ????????
    db   $1f, $01, $06, $0c, $07, $1f, $02, $97        ;; 0c:6608 ????????
    db   $65, $60, $32, $0c, $06, $1f, $02, $aa        ;; 0c:6610 ????????
    db   $66, $20, $36, $0c, $94, $e3, $07, $c2        ;; 0c:6618 ????????
    db   $1f, $20, $30, $2c, $36, $c3, $02, $1f        ;; 0c:6620 ????????
    db   $80, $36, $8c, $30, $1f, $05, $7b, $6d        ;; 0c:6628 ????????
    db   $60, $32, $cc, $00, $1f, $20, $30, $0c        ;; 0c:6630 ????????
    db   $94, $e3, $05, $c2, $1f, $00, $89, $6c        ;; 0c:6638 ????????
    db   $30, $1f, $01, $89, $cc, $00, $1f, $02        ;; 0c:6640 ????????
    db   $aa, $66, $05, $c7, $6e, $20, $30, $0c        ;; 0c:6648 ????????
    db   $04, $c1, $02, $03, $94, $e3, $0f, $c2        ;; 0c:6650 ????????
    db   $1f, $20, $74, $8c, $30, $1f, $01, $74        ;; 0c:6658 ????????
    db   $cc, $ff, $1f, $02, $a0, $66, $20, $34        ;; 0c:6660 ????????
    db   $0c, $74, $c1, $08, $e3, $82, $6f, $1f        ;; 0c:6668 ????????
    db   $01, $00, $6d, $34, $c5, $80, $1f, $02        ;; 0c:6670 ????????
    db   $a0, $66, $20, $32, $ec, $80, $7e, $03        ;; 0c:6678 ????????
    db   $74, $1f, $00, $75, $6c, $32, $1f, $01        ;; 0c:6680 ????????
    db   $89, $cc, $01, $1f, $02, $ae, $66, $01        ;; 0c:6688 ????????
    db   $89, $cc, $03, $1f, $00, $75, $0c, $75        ;; 0c:6690 ????????
    db   $c2, $02, $1f, $80, $30, $2c, $74, $1f        ;; 0c:6698 ????????
    db   $07, $04, $01, $04, $cf, $07, $1f, $02        ;; 0c:66a0 ????????
    db   $4d, $66, $05, $1a, $6c, $06, $01, $74        ;; 0c:66a8 ????????
    db   $cd, $80, $1f, $02, $a0, $66, $02, $9b        ;; 0c:66b0 ????????
    db   $66, $00, $f4, $cc, $02, $1f, $06, $00        ;; 0c:66b8 ????????
    db   $f4, $cc, $03, $1f, $02, $aa, $66             ;; 0c:66c0 ???????
.data_0c_66c7:
    db   $00, $f4, $cc, $04, $1f, $06, $20, $30        ;; 0c:66c7 ......??
    db   $0c, $94, $e3, $05, $c2, $1f, $61, $30        ;; 0c:66cf ????????
    db   $ce, $01, $1f, $02, $97, $65, $20, $94        ;; 0c:66d7 ????????
    db   $ec, $0b, $c2, $03, $24, $03, $94, $1f        ;; 0c:66df ????????
    db   $61, $94, $d0, $63, $1f, $02, $97, $65        ;; 0c:66e7 ????????
    db   $60, $94, $6c, $94, $c3, $03, $1f, $00        ;; 0c:66ef ????????
    db   $f4, $cc, $05, $03, $24, $1f, $02, $aa        ;; 0c:66f7 ????????
    db   $66, $20, $30, $0c, $94, $e3, $05, $c2        ;; 0c:66ff ????????
    db   $1f, $61, $30, $ce, $01, $1f, $02, $97        ;; 0c:6707 ????????
    db   $65, $20, $94, $ec, $09, $c2, $03, $94        ;; 0c:670f ????????
    db   $1f, $81, $94, $f0, $e7, $03, $1f, $02        ;; 0c:6717 ????????
    db   $97, $65, $80, $94, $8c, $94, $c3, $28        ;; 0c:671f ????????
    db   $1f, $00, $f4, $cc, $08, $1f, $02, $aa        ;; 0c:6727 ????????
    db   $66, $00, $12, $cc, $00, $1f, $05, $d0        ;; 0c:672f ????????
    db   $6d, $00, $94, $0c, $d0, $1f, $05, $8a        ;; 0c:6737 ????????
    db   $65, $07, $12, $07, $12, $01, $12, $cf        ;; 0c:673f ????????
    db   $08, $1f, $02, $35, $67, $00, $f4, $cc        ;; 0c:6747 ????????
    db   $00, $1f, $02, $aa, $66, $00                  ;; 0c:674f ??????
.data_0c_6755:
    db   $05                                           ;; 0c:6755 .
    dw   .data_0c_6e72                                 ;; 0c:6756 pP
    db   $00, $30, $cc, $01, $1f, $00, $1a, $6c        ;; 0c:6758 ........
    db   $30, $1f, $06                                 ;; 0c:6760 ...
.data_0c_6763:
    db   $05                                           ;; 0c:6763 .
    dw   .data_0c_6e84                                 ;; 0c:6764 pP
    db   $00, $30, $cc, $01, $1f, $00, $1a, $6c        ;; 0c:6766 ........
    db   $30, $1f, $06                                 ;; 0c:676e ...
.data_0c_6771:
    db   $05                                           ;; 0c:6771 .
    dw   .data_0c_6e72                                 ;; 0c:6772 pP
    db   $00, $30, $cc, $12, $1f, $20, $30, $0c        ;; 0c:6774 ........
    db   $04, $c1, $03, $23, $30, $1f, $20, $13        ;; 0c:677c ........
    db   $8c, $30, $1f, $06                            ;; 0c:6784 ....
.data_0c_6788:
    db   $05                                           ;; 0c:6788 .
    dw   .data_0c_6e72                                 ;; 0c:6789 pP
    db   $00, $30, $cc, $00, $1f, $00, $03, $6c        ;; 0c:678b ........
    db   $30, $1f, $06                                 ;; 0c:6793 ...
.data_0c_6796:
    db   $05                                           ;; 0c:6796 .
    dw   .data_0c_6e72                                 ;; 0c:6797 pP
    db   $00, $30, $cc, $0a, $1f, $00, $1b, $6c        ;; 0c:6799 ........
    db   $30, $1f, $06                                 ;; 0c:67a1 ...
.data_0c_67a4:
    db   $20, $34, $2c, $13, $c1, $08, $e3, $80        ;; 0c:67a4 ........
    db   $6f, $1f, $00, $20, $6c, $34, $1f, $06        ;; 0c:67ac ........
.data_0c_67b4:
    db   $20, $34, $2c, $13, $c1, $08, $e3, $84        ;; 0c:67b4 ........
    db   $6f, $1f, $00, $24, $6c, $34, $1f, $06        ;; 0c:67bc ........
.data_0c_67c4:
    db   $20, $34, $2c, $13, $c1, $08, $e3, $85        ;; 0c:67c4 ........
    db   $6f, $1f, $00, $25, $6c, $34, $1f, $06        ;; 0c:67cc ........
.data_0c_67d4:
    db   $05                                           ;; 0c:67d4 .
    dw   .data_0c_6ef9                                 ;; 0c:67d5 pP
    db   $05                                           ;; 0c:67d7 .
    dw   .data_0c_6eb6                                 ;; 0c:67d8 pP
    db   $00, $06, $6c, $32, $1f, $06                  ;; 0c:67da ......
.data_0c_67e0:
    db   $05                                           ;; 0c:67e0 .
    dw   .data_0c_6ef9                                 ;; 0c:67e1 pP
    db   $05                                           ;; 0c:67e3 .
    dw   .data_0c_6e94                                 ;; 0c:67e4 pP
    db   $00, $06, $6c, $32, $1f, $06                  ;; 0c:67e6 ......
.data_0c_67ec:
    db   $05                                           ;; 0c:67ec .
    dw   .data_0c_6ef9                                 ;; 0c:67ed pP
    db   $05                                           ;; 0c:67ef .
    dw   .data_0c_6ea5                                 ;; 0c:67f0 pP
    db   $00, $07, $6c, $32, $1f, $06, $05, $f9        ;; 0c:67f2 ......??
    db   $6e, $05, $94, $6e, $60, $32, $0c, $06        ;; 0c:67fa ????????
    db   $1f, $06                                      ;; 0c:6802 ??
.data_0c_6804:
    db   $20, $32, $cc, $03, $1f, $05                  ;; 0c:6804 ......
    dw   .data_0c_6eb6                                 ;; 0c:680a pP
    db   $80, $32, $2c, $13, $1f, $06                  ;; 0c:680c ......
.data_0c_6812:
    db   $20, $30, $13, $02, $d8, $c1, $02, $e3        ;; 0c:6812 ........
    db   $03, $d8, $1f, $20, $11, $8c, $30, $1f        ;; 0c:681a ........
    db   $06, $20, $34, $2c, $17, $c1, $08, $e3        ;; 0c:6822 .???????
    db   $85, $6f, $1f, $00, $b2, $6c, $34, $1f        ;; 0c:682a ????????
    db   $06, $05, $7c, $6e, $00, $30, $cc, $2d        ;; 0c:6832 ????????
    db   $1f, $00, $ad, $6c, $30, $1f, $06, $05        ;; 0c:683a ????????
    db   $7c, $6e, $00, $30, $cc, $2e, $1f, $00        ;; 0c:6842 ????????
    db   $ae, $6c, $30, $1f, $06                       ;; 0c:684a ?????
.data_0c_684f:
    db   $05                                           ;; 0c:684f .
    dw   .data_0c_6e84                                 ;; 0c:6850 pP
    db   $00, $30, $cc, $2d, $1f, $00, $a6, $6c        ;; 0c:6852 ........
    db   $30, $1f, $06                                 ;; 0c:685a ...
.data_0c_685d:
    db   $05                                           ;; 0c:685d .
    dw   .data_0c_6e84                                 ;; 0c:685e pP
    db   $00, $30, $cc, $2e, $1f, $00, $a7, $6c        ;; 0c:6860 ........
    db   $30, $1f, $06                                 ;; 0c:6868 ...
.data_0c_686b:
    db   $05                                           ;; 0c:686b .
    dw   .data_0c_6e7c                                 ;; 0c:686c pP
    db   $00, $30, $cc, $10, $1f, $00, $ac, $6c        ;; 0c:686e ........
    db   $30, $1f, $05                                 ;; 0c:6876 ...
    dw   .data_0c_6e7c                                 ;; 0c:6879 pP
    db   $05                                           ;; 0c:687b .
    dw   .data_0c_6ee2                                 ;; 0c:687c pP
    db   $81, $30, $ec, $02, $01, $1f, $00, $ac        ;; 0c:687e .......?
    db   $13, $de, $c2, $c5, $0f, $c3, $05, $03        ;; 0c:6886 .??.?.?.
    db   $ac, $1f, $06                                 ;; 0c:688e ?..
.data_0c_6891:
    db   $05                                           ;; 0c:6891 .
    dw   .data_0c_6e84                                 ;; 0c:6892 pP
    db   $00, $30, $cc, $10, $1f, $00, $a4, $6c        ;; 0c:6894 ........
    db   $30, $1f, $05                                 ;; 0c:689c ...
    dw   .data_0c_6e84                                 ;; 0c:689f pP
    db   $05                                           ;; 0c:68a1 .
    dw   .data_0c_6ee2                                 ;; 0c:68a2 pP
    db   $81, $30, $ec, $02, $01, $1f, $00, $a4        ;; 0c:68a4 .......?
    db   $13, $de, $c2, $c5, $0f, $c3, $05, $03        ;; 0c:68ac .??.?.?.
    db   $a4, $1f, $06, $05, $f9, $6e, $05, $94        ;; 0c:68b4 ?..?????
    db   $6e, $60, $32, $6c, $32, $c6, $80, $1f        ;; 0c:68bc ????????
    db   $05, $7c, $6e, $00, $30, $cc, $01, $1f        ;; 0c:68c4 ????????
    db   $60, $30, $6c, $30, $c4, $01, $1f, $06        ;; 0c:68cc ????????
    db   $20, $32, $cc, $01, $1f, $05, $94, $6e        ;; 0c:68d4 ????????
    db   $20, $08, $8c, $32, $1f, $20, $08, $2c        ;; 0c:68dc ????????
    db   $08, $31, $74, $1f, $20, $b5, $8c, $32        ;; 0c:68e4 ????????
    db   $24, $08, $1f, $80, $32, $2c, $08, $1f        ;; 0c:68ec ????????
    db   $06, $20, $34, $2c, $17, $c1, $08, $e3        ;; 0c:68f4 ????????
    db   $84, $6f, $1f, $00, $b1, $6c, $34, $1f        ;; 0c:68fc ????????
    db   $06                                           ;; 0c:6904 ?
.data_0c_6905:
    db   $00, $16, $cc, $00, $1f, $05                  ;; 0c:6905 ......
    dw   .data_0c_67ec                                 ;; 0c:690b pP
    db   $c1, $00, $0c, $07, $c5, $90, $1f, $06        ;; 0c:690d ........
    db   $07, $16, $02, $0a, $69                       ;; 0c:6915 ?????
.data_0c_691a:
    db   $05                                           ;; 0c:691a .
    dw   .data_0c_6e7c                                 ;; 0c:691b pP
    db   $00, $30, $cc, $0e, $1f, $00, $aa, $6c        ;; 0c:691d ........
    db   $30, $1f, $c1, $00, $0d, $06, $c5, $20        ;; 0c:6925 ........
    db   $1f, $00, $aa, $0c, $aa, $c2, $02, $1f        ;; 0c:692d ..?.?.?.
    db   $05                                           ;; 0c:6935 .
    dw   .data_0c_6e7c                                 ;; 0c:6936 pP
    db   $05                                           ;; 0c:6938 .
    dw   .data_0c_6ee2                                 ;; 0c:6939 pP
    db   $81, $30, $ec, $00, $01, $1f, $00, $aa        ;; 0c:693b .......?
    db   $13, $da, $c2, $c5, $0f, $c3, $05, $03        ;; 0c:6943 .??.?.?.
    db   $aa, $1f, $06                                 ;; 0c:694b ?..
.data_0c_694e:
    db   $05                                           ;; 0c:694e .
    dw   .data_0c_6a6d                                 ;; 0c:694f pP
    db   $20, $0a, $8c, $32, $1f, $20, $0a, $2c        ;; 0c:6951 ........
    db   $0a, $31, $74, $1f, $20, $b5, $8c, $32        ;; 0c:6959 ........
    db   $24, $0a, $1f, $80, $32, $2c, $0a, $1f        ;; 0c:6961 ........
    db   $00, $76, $cc, $00, $1f, $21, $0a, $ce        ;; 0c:6969 ........
    db   $00, $1f, $06, $05                            ;; 0c:6971 ....
    dw   .data_0c_6ef9                                 ;; 0c:6975 pP
    db   $05                                           ;; 0c:6977 .
    dw   .data_0c_6ea5                                 ;; 0c:6978 pP
    db   $60, $32, $6c, $32, $c6, $80, $1f, $00        ;; 0c:697a ........
    db   $76, $cc, $01, $1f, $05                       ;; 0c:6982 .....
    dw   .data_0c_6e84                                 ;; 0c:6987 pP
    db   $00, $30, $cc, $01, $1f, $60, $30, $6c        ;; 0c:6989 ........
    db   $30, $c4, $01, $1f, $06, $05, $f9, $6e        ;; 0c:6991 .....???
    db   $05, $a5, $6e, $60, $32, $8c, $32, $06        ;; 0c:6999 ????????
    db   $24, $1f, $06, $05, $b5, $69, $20, $36        ;; 0c:69a1 ????????
    db   $ec, $00, $78, $03, $a8, $1f, $00, $a9        ;; 0c:69a9 ????????
    db   $6c, $36, $1f, $06, $05, $84, $6e, $00        ;; 0c:69b1 ????????
    db   $30, $cc, $0a, $1f, $00, $a8, $6c, $30        ;; 0c:69b9 ????????
    db   $1f, $06                                      ;; 0c:69c1 ??
.data_0c_69c3:
    db   $20, $32, $cc, $03, $1f, $05                  ;; 0c:69c3 ......
    dw   .data_0c_6ea5                                 ;; 0c:69c9 pP
    db   $20, $17, $8c, $32, $1f, $06                  ;; 0c:69cb ......
.data_0c_69d1:
    db   $20, $34, $2c, $17, $c1, $08, $e3, $81        ;; 0c:69d1 ........
    db   $6f, $1f, $00, $b0, $6c, $34, $1f, $06        ;; 0c:69d9 ........
.data_0c_69e1:
    db   $05                                           ;; 0c:69e1 .
    dw   .data_0c_6e84                                 ;; 0c:69e2 pP
    db   $00, $30, $cc, $11, $1f, $00, $a5, $6c        ;; 0c:69e4 ........
    db   $30, $1f, $06                                 ;; 0c:69ec ...
.data_0c_69ef:
    db   $c1, $00, $0d, $07, $c5, $20, $1f, $00        ;; 0c:69ef ........
    db   $a5, $0c, $a5, $c2, $02, $1f, $06             ;; 0c:69f7 ?.?.?..
.data_0c_69fe:
    db   $05                                           ;; 0c:69fe .
    dw   .data_0c_6e7c                                 ;; 0c:69ff pP
    db   $00, $30, $cc, $0f, $1f, $00, $ab, $6c        ;; 0c:6a01 ........
    db   $30, $1f                                      ;; 0c:6a09 ..
.data_0c_6a0b:
    db   $c1, $00, $0d, $06, $c5, $40, $1f, $00        ;; 0c:6a0b ........
    db   $ab, $0c, $ab, $c2, $02, $1f, $05             ;; 0c:6a13 ?.?.?..
    dw   .data_0c_6e7c                                 ;; 0c:6a1a pP
    db   $05                                           ;; 0c:6a1c .
    dw   .data_0c_6ee2                                 ;; 0c:6a1d pP
    db   $81, $30, $ec, $01, $01, $1f, $00, $ab        ;; 0c:6a1f .......?
    db   $13, $dc, $c2, $c5, $0f, $c3, $05, $03        ;; 0c:6a27 .??.?.?.
    db   $ab, $1f, $06                                 ;; 0c:6a2f ?..
.data_0c_6a32:
    db   $00, $b8, $12, $aa, $1f, $05                  ;; 0c:6a32 ...p..
    dw   .data_0c_6e8c                                 ;; 0c:6a38 pP
    db   $20, $74, $0c, $aa, $01, $24, $03, $b8        ;; 0c:6a3a ........
    db   $31, $74, $1f, $06                            ;; 0c:6a42 ....
.data_0c_6a46:
    db   $05                                           ;; 0c:6a46 .
    dw   .data_0c_6ecd                                 ;; 0c:6a47 pP
    db   $20, $39, $2c, $74, $01, $a4, $c2, $c8        ;; 0c:6a49 .......w
    db   $1f, $20, $74, $2c, $74, $31, $39, $1f        ;; 0c:6a51 ........
    db   $06                                           ;; 0c:6a59 .
.data_0c_6a5a:
    db   $00, $16, $cc, $00, $1f, $05                  ;; 0c:6a5a ......
    dw   .data_0c_6e84                                 ;; 0c:6a60 pP
    db   $00, $30, $cc, $00, $1f, $00, $03, $6c        ;; 0c:6a62 ........
    db   $30, $1f, $06                                 ;; 0c:6a6a ...
.data_0c_6a6d:
    db   $20, $32, $cc, $01, $1f, $05                  ;; 0c:6a6d ......
    dw   .data_0c_6ea5                                 ;; 0c:6a73 pP
    db   $06                                           ;; 0c:6a75 .
.data_0c_6a76:
    db   $05                                           ;; 0c:6a76 .
    dw   .data_0c_6e84                                 ;; 0c:6a77 pP
    db   $00, $30, $cc, $0c, $1f, $81, $32, $8e        ;; 0c:6a79 ........
    db   $30, $1f, $80, $32, $8c, $30, $1f, $06        ;; 0c:6a81 ........
.data_0c_6a89:
    db   $c1, $00, $0d, $a6, $c5, $02, $1f, $20        ;; 0c:6a89 ........
    db   $74, $2c, $74, $c2, $02, $1f, $06             ;; 0c:6a91 ?.?.?..
.data_0c_6a98:
    db   $05                                           ;; 0c:6a98 .
    dw   .data_0c_684f                                 ;; 0c:6a99 pP
    db   $c1, $00, $0d, $b0, $c5, $08, $1f, $20        ;; 0c:6a9b ........
    db   $74, $2c, $74, $c2, $02, $1f, $05             ;; 0c:6aa3 ?.?.?..
    dw   .data_0c_6a89                                 ;; 0c:6aaa pP
    db   $06                                           ;; 0c:6aac .
.data_0c_6aad:
    db   $00, $76, $cc, $00, $1f, $05                  ;; 0c:6aad ......
    dw   .data_0c_6905                                 ;; 0c:6ab3 pP
    db   $20, $32, $0c, $15, $e1, $00, $01, $e3        ;; 0c:6ab5 ........
    db   $0f, $d0, $1f, $00, $a3, $6c, $32, $1f        ;; 0c:6abd ........
    db   $c1, $00, $0d, $07, $c5, $40, $1f, $00        ;; 0c:6ac5 ........
    db   $a3, $0c, $a3, $c2, $02, $1f, $05             ;; 0c:6acd ?.?.?..
    dw   .data_0c_6e84                                 ;; 0c:6ad4 pP
    db   $05                                           ;; 0c:6ad6 .
    dw   .data_0c_6ee2                                 ;; 0c:6ad7 pP
    db   $81, $30, $ec, $01, $01, $1f, $00, $a3        ;; 0c:6ad9 .......?
    db   $13, $dc, $c2, $c5, $0f, $c3, $05, $03        ;; 0c:6ae1 .??.?.?.
    db   $a3, $1f, $05                                 ;; 0c:6ae9 ?..
    dw   .data_0c_69c3                                 ;; 0c:6aec pP
    db   $05                                           ;; 0c:6aee .
    dw   .data_0c_69d1                                 ;; 0c:6aef pP
    db   $c1, $00, $0c, $b0, $c5, $08, $1f, $02        ;; 0c:6af1 ........
    dw   .data_0c_6b1f                                 ;; 0c:6af9 pP
    db   $05, $23, $68, $a1, $64, $0e, $b2, $03        ;; 0c:6afb ????????
    db   $a3, $1f, $02, $1f, $6b, $00, $76, $cc        ;; 0c:6b03 ????????
    db   $01, $1f, $05, $09, $6c, $c0, $06, $d9        ;; 0c:6b0b ????????
    db   $2c, $17, $1f, $a0, $0c, $d9, $cc, $2c        ;; 0c:6b13 ????????
    db   $1f, $02, $d4, $6c                            ;; 0c:6b1b ????
.data_0c_6b1f:
    db   $05                                           ;; 0c:6b1f .
    dw   .data_0c_69fe                                 ;; 0c:6b20 pP
    db   $05                                           ;; 0c:6b22 .
    dw   .data_0c_6a0b                                 ;; 0c:6b23 pP
    db   $00, $b3, $0c, $a3, $11, $ab, $c1, $02        ;; 0c:6b25 ........
    db   $1f, $00, $b3, $cc, $61, $11, $b3, $1f        ;; 0c:6b2d ........
    db   $06, $00, $b4, $cc, $00, $1f, $c1, $00        ;; 0c:6b35 .???????
    db   $0d, $a7, $05, $25, $1f, $02, $51, $6b        ;; 0c:6b3d ????????
    db   $00, $b4, $0c, $a4, $11, $ac, $c1, $02        ;; 0c:6b45 ????????
    db   $c3, $32, $1f, $06, $05, $72, $6c, $06        ;; 0c:6b4d ????????
.data_0c_6b55:
    db   $01, $15, $cf, $04, $1f, $02                  ;; 0c:6b55 ......
    dw   .data_0c_6b7d                                 ;; 0c:6b5b pP
    db   $01, $15, $cf, $07, $1f, $02                  ;; 0c:6b5d ......
    dw   .data_0c_6b9b                                 ;; 0c:6b63 pP
    db   $01, $12, $cf, $04, $1f, $02                  ;; 0c:6b65 ......
    dw   .data_0c_6ba3                                 ;; 0c:6b6b pP
    db   $01, $15, $cc, $09, $1f, $02, $7d, $6b        ;; 0c:6b6d ????????
    db   $00, $f5, $cc, $09, $1f, $02, $87, $6b        ;; 0c:6b75 ????????
.data_0c_6b7d:
    db   $a0, $10, $d9, $cc, $00, $1f, $03             ;; 0c:6b7d .......
    dw   $01e0                                         ;; 0c:6b84 pP
    db   $06                                           ;; 0c:6b86 .
.data_0c_6b87:
    db   $20, $36, $0c, $13, $c1, $08, $e3, $86        ;; 0c:6b87 ........
    db   $6f, $1f, $a0, $10, $d9, $6c, $36, $1f        ;; 0c:6b8f ........
    db   $03                                           ;; 0c:6b97 .
    dw   $01e0                                         ;; 0c:6b98 pP
    db   $06                                           ;; 0c:6b9a .
.data_0c_6b9b:
    db   $00, $f5, $0c, $15, $1f, $02                  ;; 0c:6b9b ......
    dw   .data_0c_6b87                                 ;; 0c:6ba1 pP
.data_0c_6ba3:
    db   $01, $15, $cc, $08, $1f, $02, $7d, $6b        ;; 0c:6ba3 ......??
    db   $02                                           ;; 0c:6bab .
    dw   .data_0c_6b9b                                 ;; 0c:6bac pP
    db   $01, $12, $ce, $04, $1f, $02, $b9, $6b        ;; 0c:6bae ????????
    db   $02, $7d, $6b, $20, $36, $0c, $17, $c1        ;; 0c:6bb6 ????????
    db   $08, $e3, $86, $6f, $1f, $00, $f5, $0c        ;; 0c:6bbe ????????
    db   $12, $1f, $02, $91, $6b                       ;; 0c:6bc6 ?????
.data_0c_6bcb:
    db   $01, $15, $cf, $04, $1f, $06, $01, $15        ;; 0c:6bcb ......??
    db   $cf, $07, $1f, $02, $9b, $6b, $01, $12        ;; 0c:6bd3 ????????
    db   $cf, $04, $1f, $02, $ef, $6b, $01, $15        ;; 0c:6bdb ????????
    db   $cc, $09, $1f, $06, $00, $f5, $cc, $09        ;; 0c:6be3 ????????
    db   $1f, $02, $87, $6b, $01, $15, $cc, $08        ;; 0c:6beb ????????
    db   $1f, $06, $02, $9b, $6b                       ;; 0c:6bf3 ?????
.data_0c_6bf8:
    db   $20, $36, $2c, $13, $c1, $08, $e3, $87        ;; 0c:6bf8 ........
    db   $6f, $1f, $a0, $b2, $ff, $6c, $36, $1f        ;; 0c:6c00 ........
    db   $06, $20, $36, $2c, $17, $c1, $08, $e3        ;; 0c:6c08 .???????
    db   $87, $6f, $1f, $a0, $b2, $ff, $6c, $36        ;; 0c:6c10 ????????
    db   $1f, $06, $20, $36, $2c, $f0, $c1, $08        ;; 0c:6c18 ????????
    db   $e3, $87, $6f, $1f, $a0, $b2, $ff, $6c        ;; 0c:6c20 ????????
    db   $36, $1f, $06                                 ;; 0c:6c28 ???
.data_0c_6c2b:
    db   $c0, $00, $d9, $2c, $74, $1f, $a0, $0c        ;; 0c:6c2b ........
    db   $d9, $cc, $41, $1f, $02                       ;; 0c:6c33 ..w..
    dw   .data_0c_6cd4                                 ;; 0c:6c38 pP
.data_0c_6c3a:
    db   $a0, $0c, $d9, $cc, $20, $1f, $02             ;; 0c:6c3a ....w..
    dw   .data_0c_6cd4                                 ;; 0c:6c41 pP
    db   $05, $63, $67, $01, $1a, $cc, $01, $1f        ;; 0c:6c43 ????????
    db   $02, $3a, $6c, $a0, $0c, $d9, $cc, $2b        ;; 0c:6c4b ????????
    db   $1f, $02, $d4, $6c                            ;; 0c:6c53 ????
.data_0c_6c57:
    db   $a0, $0c, $d9, $cc, $2f, $1f, $02             ;; 0c:6c57 ....w..
    dw   .data_0c_6cd4                                 ;; 0c:6c5e pP
.data_0c_6c60:
    db   $a0, $0c, $d9, $cc, $29, $1f, $02             ;; 0c:6c60 ....w..
    dw   .data_0c_6cd4                                 ;; 0c:6c67 pP
    db   $a0, $0c, $d9, $cc, $33, $1f, $02, $d4        ;; 0c:6c69 ????????
    db   $6c, $a0, $0c, $d9, $cc, $32, $1f, $02        ;; 0c:6c71 ????????
    db   $d4, $6c, $a0, $0c, $d9, $cc, $07, $1f        ;; 0c:6c79 ????????
    db   $02, $d4, $6c, $a0, $b2, $ff, $cc, $15        ;; 0c:6c81 ????????
    db   $1f, $a0, $0c, $d9, $cc, $0d, $1f, $02        ;; 0c:6c89 ????????
    db   $d4, $6c, $a0, $b2, $ff, $cc, $08, $1f        ;; 0c:6c91 ????????
    db   $a0, $0c, $d9, $cc, $22, $1f, $02, $d4        ;; 0c:6c99 ????????
    db   $6c, $05, $05, $69, $05, $c3, $69, $05        ;; 0c:6ca1 ????????
    db   $d1, $69, $c1, $00, $0c, $b0, $c5, $10        ;; 0c:6ca9 ????????
    db   $1f, $06, $00, $b8, $0c, $12, $1f, $00        ;; 0c:6cb1 ????????
    db   $12, $0c, $15, $1f, $00, $15, $0c, $b8        ;; 0c:6cb9 ????????
    db   $1f, $c0, $06, $d9, $0c, $12, $1f, $c0        ;; 0c:6cc1 ????????
    db   $0a, $d9, $0c, $15, $1f, $a0, $0c, $d9        ;; 0c:6cc9 ????????
    db   $cc, $31, $1f                                 ;; 0c:6cd1 ???
.data_0c_6cd4:
    db   $03                                           ;; 0c:6cd4 .
    dw   $0020                                         ;; 0c:6cd5 pP
    db   $06, $20, $32, $cc, $01, $1f, $05, $94        ;; 0c:6cd7 .???????
    db   $6e, $20, $08, $8c, $32, $1f, $80, $32        ;; 0c:6cdf ????????
    db   $8c, $32, $23, $b5, $1f, $05, $7c, $6e        ;; 0c:6ce7 ????????
    db   $00, $30, $cc, $0c, $1f, $81, $32, $8e        ;; 0c:6cef ????????
    db   $30, $1f, $80, $32, $8c, $30, $1f, $20        ;; 0c:6cf7 ????????
    db   $b5, $8c, $32, $24, $08, $1f, $c0, $00        ;; 0c:6cff ????????
    db   $d9, $2c, $b5, $1f, $06, $00, $61, $cc        ;; 0c:6d07 ????????
    db   $00, $1f, $c1, $00, $0d, $76, $c5, $80        ;; 0c:6d0f ????????
    db   $1f, $02, $2d, $6d, $00, $76, $0c, $76        ;; 0c:6d17 ????????
    db   $cb, $01, $1f, $07, $61, $01, $61, $cf        ;; 0c:6d1f ????????
    db   $07, $1f, $02, $11, $6d, $06, $a0, $0c        ;; 0c:6d27 ????????
    db   $d9, $cc, $49, $03, $61, $1f, $03, $20        ;; 0c:6d2f ????????
    db   $00, $02, $1b, $6d, $00, $76, $0c, $24        ;; 0c:6d37 ????????
    db   $1f, $00, $61, $cc, $00, $1f, $c1, $00        ;; 0c:6d3f ????????
    db   $0d, $76, $c5, $80, $1f, $02, $61, $6d        ;; 0c:6d47 ????????
    db   $00, $76, $0c, $76, $cb, $01, $1f, $07        ;; 0c:6d4f ????????
    db   $61, $01, $61, $cf, $07, $1f, $02, $45        ;; 0c:6d57 ????????
    db   $6d, $06, $05, $57, $6e, $a0, $0c, $d9        ;; 0c:6d5f ????????
    db   $cc, $1b, $1f, $03, $20, $00, $a0, $0c        ;; 0c:6d67 ????????
    db   $d9, $cc, $51, $03, $61, $1f, $03, $20        ;; 0c:6d6f ????????
    db   $00, $02, $4f, $6d, $20, $32, $ec, $06        ;; 0c:6d77 ????????
    db   $c2, $03, $94, $1f, $00, $07, $6c, $32        ;; 0c:6d7f ????????
    db   $1f, $06, $00, $07, $6c, $32, $1f, $c1        ;; 0c:6d87 ????????
    db   $00, $0c, $07, $c5, $80, $1f, $02, $9f        ;; 0c:6d8f ????????
    db   $6d, $27, $32, $80, $32, $cc, $00, $1f        ;; 0c:6d97 ????????
    db   $20, $32, $cc, $03, $1f, $05, $a5, $6e        ;; 0c:6d9f ????????
    db   $c1, $00, $0d, $07, $c5, $01, $1f, $80        ;; 0c:6da7 ????????
    db   $32, $ec, $0f, $01, $1f, $c1, $00, $0d        ;; 0c:6daf ????????
    db   $07, $c5, $02, $1f, $80, $32, $ec, $0e        ;; 0c:6db7 ????????
    db   $01, $1f, $06, $05, $7c, $6e, $00, $30        ;; 0c:6dbf ????????
    db   $cc, $0b, $1f, $00, $89, $6c, $30, $1f        ;; 0c:6dc7 ????????
    db   $06                                           ;; 0c:6dcf ?
.data_0c_6dd0:
    db   $00, $d0, $13, $a0, $c2, $0a, $12, $c5        ;; 0c:6dd0 ........
    db   $03, $c1, $20, $1f, $01, $12, $cc, $08        ;; 0c:6dd8 ........
    db   $1f, $00, $d0, $cc, $80, $1f, $06             ;; 0c:6de0 ..?.?..
.data_0c_6de7:
    db   $05                                           ;; 0c:6de7 .
    dw   .data_0c_6e84                                 ;; 0c:6de8 pP
    db   $05                                           ;; 0c:6dea .
    dw   .data_0c_6ee2                                 ;; 0c:6deb pP
    db   $81, $30, $ec, $03, $01, $1f, $00, $a5        ;; 0c:6ded .......?
    db   $13, $e0, $c2, $c5, $0f, $c3, $05, $03        ;; 0c:6df5 .??.?.?.
    db   $a5, $1f, $06                                 ;; 0c:6dfd ?..
.data_0c_6e00:
    db   $05                                           ;; 0c:6e00 .
    dw   .data_0c_6e7c                                 ;; 0c:6e01 pP
    db   $05                                           ;; 0c:6e03 .
    dw   .data_0c_6ee2                                 ;; 0c:6e04 pP
    db   $20, $53, $8c, $30, $1f, $20, $30, $2c        ;; 0c:6e06 ........
    db   $53, $c1, $08, $e3, $81, $6f, $1f, $c1        ;; 0c:6e0e ........
    db   $00, $6c, $30, $c5, $20, $1f, $06, $20        ;; 0c:6e16 .......?
    db   $30, $2c, $53, $c1, $08, $e3, $84, $6f        ;; 0c:6e1e ????????
    db   $1f, $c1, $00, $6c, $25, $65, $30, $1f        ;; 0c:6e26 ????????
    db   $06, $20, $30, $0c, $53, $c1, $02, $e3        ;; 0c:6e2e ????????
    db   $da, $c2, $1f, $00, $ac, $6c, $30, $c5        ;; 0c:6e36 ????????
    db   $0f, $03, $ac, $c3, $05, $1f, $06             ;; 0c:6e3e ???????
.data_0c_6e45:
    db   $c0, $00, $d9, $2c, $b5, $1f, $05             ;; 0c:6e45 .......
    dw   .data_0c_6e57                                 ;; 0c:6e4c pP
    db   $a0, $0c, $d9, $cc, $2a, $1f, $02             ;; 0c:6e4e ....w..
    dw   .data_0c_6cd4                                 ;; 0c:6e55 pP
.data_0c_6e57:
    db   $c0, $0a, $d9, $0c, $15, $1f, $06, $05        ;; 0c:6e57 .......?
    db   $dc, $6e, $00, $01, $cc, $04, $1f, $06        ;; 0c:6e5f ????????
.data_0c_6e67:
    db   $00, $15, $cc, $05, $1f, $00, $01, $cc        ;; 0c:6e67 ...w....
    db   $07, $1f, $06                                 ;; 0c:6e6f ...
.data_0c_6e72:
    db   $00, $31, $0c, $00, $c1, $01, $c3, $d0        ;; 0c:6e72 ........
    db   $1f, $06                                      ;; 0c:6e7a ..
.data_0c_6e7c:
    db   $00, $31, $0c, $12, $c3, $d0, $1f, $06        ;; 0c:6e7c ........
.data_0c_6e84:
    db   $00, $31, $0c, $15, $c3, $d0, $1f, $06        ;; 0c:6e84 ........
.data_0c_6e8c:
    db   $20, $74, $0c, $a5, $c1, $05, $1f, $06        ;; 0c:6e8c ........
.data_0c_6e94:
    db   $20, $32, $0c, $12, $c1, $20, $03, $11        ;; 0c:6e94 ........
    db   $c1, $08, $e3, $40, $d0, $23, $32, $1f        ;; 0c:6e9c ........
    db   $06                                           ;; 0c:6ea4 .
.data_0c_6ea5:
    db   $20, $32, $0c, $15, $c1, $20, $03, $16        ;; 0c:6ea5 ........
    db   $c1, $08, $e3, $40, $d0, $23, $32, $1f        ;; 0c:6ead ........
    db   $06                                           ;; 0c:6eb5 .
.data_0c_6eb6:
    db   $20, $32, $0c, $00, $c1, $20, $03, $02        ;; 0c:6eb6 ........
    db   $c1, $08, $e3, $40, $d0, $23, $32, $1f        ;; 0c:6ebe ........
    db   $06                                           ;; 0c:6ec6 .
.data_0c_6ec7:
    db   $00, $04, $cc, $00, $1f, $06                  ;; 0c:6ec7 ...w..
.data_0c_6ecd:
    db   $00, $b8, $12, $ac, $1f, $20, $74, $0c        ;; 0c:6ecd ...p....
    db   $ac, $01, $24, $03, $b8, $1f, $06             ;; 0c:6ed5 .......
.data_0c_6edc:
    db   $00, $15, $cc, $00, $1f, $06                  ;; 0c:6edc ...w..
.data_0c_6ee2:
    db   $00, $30, $cc, $2a, $1f, $06                  ;; 0c:6ee2 ......
.data_0c_6ee8:
    db   $00, $b8, $12, $ac, $1f, $20, $b5, $0c        ;; 0c:6ee8 ...p....
    db   $ac, $03, $a4, $01, $24, $03, $b8, $1f        ;; 0c:6ef0 ........
    db   $06                                           ;; 0c:6ef8 .
.data_0c_6ef9:
    db   $20, $32, $cc, $00, $1f, $06, $00, $ff        ;; 0c:6ef9 ......?.
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $aa        ;; 0c:6f01 ????????
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $91        ;; 0c:6f09 ????????
    db   $da, $ff, $ff, $ff, $ff, $ff, $ff, $88        ;; 0c:6f11 ????????
    db   $cc, $ee, $ff, $ff, $ff, $ff, $ff, $84        ;; 0c:6f19 ????????
    db   $c6, $e7, $f7, $ff, $ff, $ff, $ff, $82        ;; 0c:6f21 ????????
    db   $c3, $e3, $f3, $fb, $ff, $ff, $ff, $81        ;; 0c:6f29 ????????
    db   $c1, $e1, $f1, $f9, $fd, $ff, $ff, $41        ;; 0c:6f31 ????????
    db   $c3, $e3, $f3, $fb, $ff, $ff, $ff, $40        ;; 0c:6f39 ????????
    db   $c1, $e1, $f1, $f9, $fd, $ff, $ff, $40        ;; 0c:6f41 ????????
    db   $60, $e1, $f1, $f9, $fd, $ff, $ff, $40        ;; 0c:6f49 ????????
    db   $60, $70, $f1, $f9, $fd, $ff, $ff, $40        ;; 0c:6f51 ????????
    db   $60, $70, $78, $f9, $fd, $ff, $ff, $40        ;; 0c:6f59 ????????
    db   $60, $70, $78, $7c, $fd, $ff, $ff, $40        ;; 0c:6f61 ????????
    db   $60, $70, $78, $7c, $7e, $ff, $ff, $41        ;; 0c:6f69 ????????
    db   $61, $e3, $f3, $fb, $ff, $ff, $ff, $41        ;; 0c:6f71 ????????
    db   $61, $71, $f3, $fb, $ff, $ff, $ff, $a1        ;; 0c:6f79 ????????
    db   $00, $00, $31, $06, $00, $90, $2b, $a1        ;; 0c:6f81 ?.?????.
    db   $00, $00, $31, $07, $00, $88, $20, $a1        ;; 0c:6f89 ..w....?
    db   $00, $00, $31, $08, $00, $90, $2b, $a1        ;; 0c:6f91 ????????
    db   $00, $00, $31, $09, $00, $88, $20, $a1        ;; 0c:6f99 ????????
    db   $00, $00, $31, $0a, $00, $8b, $20, $a1        ;; 0c:6fa1 ????????
    db   $00, $00, $31, $0b, $00, $88, $20, $a1        ;; 0c:6fa9 ????????
    db   $00, $00, $0c, $0d, $30, $88, $20, $a1        ;; 0c:6fb1 ????????
    db   $00, $00, $0c, $0d, $a0, $90, $20, $a1        ;; 0c:6fb9 ????????
    db   $00, $00, $0c, $0e, $60, $88, $20, $a1        ;; 0c:6fc1 ????????
    db   $00, $00, $0c, $0f, $b0, $8c, $20, $a1        ;; 0c:6fc9 ????????
    db   $00, $00, $0a, $0c, $80, $8d, $20, $a1        ;; 0c:6fd1 ????????
    db   $00, $00, $0a, $0c, $40, $8e, $20, $a1        ;; 0c:6fd9 ????????
    db   $00, $00, $0a, $0c, $20, $8f, $2b, $a1        ;; 0c:6fe1 ????????
    db   $08, $00, $31, $0e, $50, $88, $20, $a1        ;; 0c:6fe9 ????????
    db   $10, $00, $31, $0c, $00, $90, $2b, $a1        ;; 0c:6ff1 ????????
    db   $00, $00, $0e, $07, $00, $9e, $2c, $a1        ;; 0c:6ff9 ????????
    db   $00, $00, $0e, $09, $00, $9e, $2c, $a1        ;; 0c:7001 ????????
    db   $00, $00, $0e, $0d, $00, $9e, $2c, $a1        ;; 0c:7009 ????????
    db   $00, $00, $0d, $06, $b0, $8a, $20, $a1        ;; 0c:7011 ????????
    db   $00, $00, $11, $00, $04, $89, $20, $11        ;; 0c:7019 ????????
    db   $01, $00, $08, $14, $00, $89, $20, $21        ;; 0c:7021 ???????.
    db   $00, $00, $14, $0a, $32, $e4, $23, $21        ;; 0c:7029 ..??????
    db   $00, $00, $14, $40, $64, $e4, $23, $11        ;; 0c:7031 ???????.
    db   $08, $00, $06, $00, $32, $80, $08, $11        ;; 0c:7039 .......?
    db   $08, $00, $06, $00, $3c, $80, $08, $11        ;; 0c:7041 ????????
    db   $08, $00, $06, $00, $46, $80, $08, $11        ;; 0c:7049 ????????
    db   $08, $00, $07, $40, $50, $80, $08, $11        ;; 0c:7051 ????????
    db   $08, $00, $07, $80, $50, $80, $08, $11        ;; 0c:7059 ????????
    db   $08, $00, $07, $f0, $5a, $80, $08, $03        ;; 0c:7061 ????????
    db   $00, $00, $01, $28, $14, $a3, $33, $03        ;; 0c:7069 ????????
    db   $00, $00, $01, $96, $32, $a3, $33, $03        ;; 0c:7071 ????????
    db   $00, $00, $02, $df, $00, $a3, $33, $03        ;; 0c:7079 ????????
    db   $00, $00, $02, $bf, $00, $a3, $33, $a1        ;; 0c:7081 ????????
    db   $00, $00, $31, $0a, $00, $be, $17, $a1        ;; 0c:7089 ????????
    db   $00, $80, $10, $0f, $46, $89, $20, $a1        ;; 0c:7091 ????????
    db   $00, $00, $15, $c8, $64, $e4, $23, $83        ;; 0c:7099 ????????
    db   $00, $00, $00, $04, $00, $a3, $33, $a1        ;; 0c:70a1 ????????
    db   $00, $00, $1c, $0d, $b0, $ce, $0a, $a1        ;; 0c:70a9 ????????
    db   $00, $00, $1a, $0a, $80, $e8, $26, $a1        ;; 0c:70b1 ????????
    db   $00, $00, $1a, $0a, $40, $81, $35, $a1        ;; 0c:70b9 ????????
    db   $00, $00, $1a, $0a, $20, $82, $18, $a1        ;; 0c:70c1 ????????
    db   $00, $00, $1a, $0a, $10, $86, $36, $a1        ;; 0c:70c9 ????????
    db   $00, $00, $1b, $01, $08, $83, $30, $a1        ;; 0c:70d1 ????????
    db   $00, $00, $1b, $10, $04, $84, $2f, $a1        ;; 0c:70d9 ????????
    db   $00, $00, $1b, $80, $08, $85, $2f, $31        ;; 0c:70e1 ????????
    db   $00, $00, $21, $08, $80, $dd, $26, $31        ;; 0c:70e9 ????????
    db   $00, $00, $28, $80, $08, $de, $2f, $13        ;; 0c:70f1 ????????
    db   $00, $00, $09, $04, $00, $a4, $33, $31        ;; 0c:70f9 ????????
    db   $00, $00, $21, $0d, $00, $0e, $34, $00        ;; 0c:7101 ????????
    db   $00, $81, $00, $02, $00, $80, $00, $00        ;; 0c:7109 ????????
    db   $00, $81, $00, $04, $00, $80, $00, $00        ;; 0c:7111 ????????
    db   $00, $81, $00, $08, $00, $80, $00, $00        ;; 0c:7119 ????????
    db   $00, $91, $00, $14, $08, $80, $00, $00        ;; 0c:7121 ???????.
    db   $00, $82, $00, $03, $00, $80, $00, $00        ;; 0c:7129 ..??????
    db   $00, $82, $00, $07, $00, $80, $00, $00        ;; 0c:7131 ????????
    db   $00, $82, $00, $0d, $00, $80, $00, $00        ;; 0c:7139 ????????
    db   $00, $92, $00, $15, $f0, $80, $00, $00        ;; 0c:7141 ????????
    db   $00, $92, $00, $1f, $04, $80, $00, $00        ;; 0c:7149 ????????
    db   $00, $84, $00, $01, $00, $80, $00, $00        ;; 0c:7151 ????????
    db   $00, $84, $00, $02, $00, $80, $00, $00        ;; 0c:7159 ????????
    db   $00, $84, $00, $04, $00, $80, $00, $00        ;; 0c:7161 ????????
    db   $00, $c4, $00, $06, $8a, $80, $00, $00        ;; 0c:7169 ????????
    db   $00, $94, $00, $0a, $02, $80, $00, $00        ;; 0c:7171 ????????
    db   $00, $c8, $00, $04, $4a, $80, $00, $00        ;; 0c:7179 ????????
    db   $00, $c8, $00, $06, $2f, $80, $00, $02        ;; 0c:7181 ????????
    db   $00, $00, $03, $00, $00, $ba, $33, $02        ;; 0c:7189 ????????
    db   $00, $00, $02, $ef, $00, $80, $33, $02        ;; 0c:7191 ????????
    db   $00, $00, $07, $00, $00, $80, $33, $02        ;; 0c:7199 ????????
    db   $00, $00, $07, $01, $00, $80, $33, $02        ;; 0c:71a1 ????????
    db   $00, $00, $07, $02, $00, $80, $33, $02        ;; 0c:71a9 ????????
    db   $00, $00, $08, $00, $00, $80, $33, $12        ;; 0c:71b1 ????????
    db   $00, $00, $05, $00, $00, $80, $33, $a1        ;; 0c:71b9 ????????
    db   $00, $00, $18, $07, $32, $9c, $24, $a1        ;; 0c:71c1 ????????
    db   $00, $00, $18, $0a, $32, $db, $24, $a1        ;; 0c:71c9 ????????
    db   $00, $00, $12, $32, $0a, $93, $05, $11        ;; 0c:71d1 ????????
    db   $01, $00, $08, $14, $00, $b0, $29, $21        ;; 0c:71d9 ???????.
    db   $00, $00, $13, $14, $2d, $94, $06, $21        ;; 0c:71e1 ..??????
    db   $00, $00, $13, $46, $64, $94, $06, $21        ;; 0c:71e9 ????????
    db   $00, $00, $13, $5a, $96, $94, $06, $a1        ;; 0c:71f1 ????????
    db   $00, $80, $1d, $04, $5a, $b0, $29, $a1        ;; 0c:71f9 ????????
    db   $00, $80, $1d, $05, $5a, $b1, $29, $a1        ;; 0c:7201 ????????
    db   $00, $80, $1d, $06, $5a, $a8, $29, $a1        ;; 0c:7209 ????????
    db   $00, $80, $1d, $07, $5a, $b1, $29, $a1        ;; 0c:7211 ????????
    db   $00, $80, $1d, $09, $55, $cc, $29, $a1        ;; 0c:7219 ????????
    db   $00, $80, $1d, $0c, $50, $07, $29, $21        ;; 0c:7221 ????????
    db   $00, $00, $1b, $08, $08, $af, $30, $a1        ;; 0c:7229 ????????
    db   $00, $00, $1f, $02, $08, $dc, $06, $25        ;; 0c:7231 ????????
    db   $00, $00, $20, $00, $0a, $a5, $1c, $21        ;; 0c:7239 ????????
    db   $00, $00, $1c, $0d, $e0, $bd, $1f, $21        ;; 0c:7241 ????????
    db   $00, $00, $24, $0a, $02, $c9, $1f, $a1        ;; 0c:7249 ????????
    db   $00, $00, $15, $32, $00, $97, $02, $a1        ;; 0c:7251 ????????
    db   $00, $00, $15, $46, $00, $98, $07, $a1        ;; 0c:7259 ????????
    db   $00, $00, $15, $62, $00, $df, $07, $a1        ;; 0c:7261 ????????
    db   $00, $00, $15, $84, $00, $97, $02, $a1        ;; 0c:7269 ????????
    db   $08, $00, $15, $aa, $46, $df, $07, $a1        ;; 0c:7271 ????????
    db   $00, $00, $15, $32, $80, $e8, $26, $31        ;; 0c:7279 ????????
    db   $00, $00, $17, $64, $64, $a0, $07, $31        ;; 0c:7281 ????????
    db   $00, $00, $17, $c8, $64, $9a, $01, $00        ;; 0c:7289 ????????
    db   $00, $c2, $00, $14, $8a, $80, $00, $00        ;; 0c:7291 ????????
    db   $00, $81, $00, $0d, $00, $80, $00, $00        ;; 0c:7299 ????????
    db   $00, $82, $00, $10, $00, $80, $00, $00        ;; 0c:72a1 ????????
    db   $00, $c8, $00, $02, $85, $80, $00, $a1        ;; 0c:72a9 ????????
    db   $08, $00, $31, $06, $00, $95, $2c, $21        ;; 0c:72b1 ????????
    db   $00, $00, $14, $0a, $46, $96, $11, $00        ;; 0c:72b9 ????????
    db   $00, $c2, $00, $05, $45, $80, $00, $11        ;; 0c:72c1 ????????
    db   $08, $00, $06, $63, $63, $e0, $08, $a1        ;; 0c:72c9 ????????
    db   $00, $00, $0c, $0f, $f0, $e9, $20, $a1        ;; 0c:72d1 ????????
    db   $00, $00, $10, $0f, $46, $ca, $2c, $a1        ;; 0c:72d9 ????????
    db   $00, $00, $0e, $0b, $00, $9d, $2c, $a1        ;; 0c:72e1 ????????
    db   $00, $00, $0f, $08, $00, $d8, $2c, $a1        ;; 0c:72e9 ????????
    db   $00, $00, $0f, $0c, $00, $da, $20, $21        ;; 0c:72f1 ????????
    db   $00, $00, $16, $46, $32, $9f, $25, $11        ;; 0c:72f9 ????????
    db   $00, $00, $26, $01, $14, $80, $08, $21        ;; 0c:7301 ????????
    db   $00, $00, $13, $20, $37, $b0, $29, $a1        ;; 0c:7309 ????????
    db   $00, $00, $1a, $0c, $00, $d9, $07, $00        ;; 0c:7311 ????????
    db   $00, $c1, $00, $0d, $8a, $80, $00, $31        ;; 0c:7319 ????????
    db   $00, $00, $19, $ee, $00, $0f, $21, $00        ;; 0c:7321 ????????
    db   $00, $c2, $00, $1a, $85, $80, $00, $00        ;; 0c:7329 ????????
    db   $00, $df, $00, $49, $cf, $80, $00, $12        ;; 0c:7331 ????????
    db   $00, $00, $04, $00, $00, $80, $0b, $00        ;; 0c:7339 ????????
    db   $00, $80, $00, $00, $00, $80, $33, $00        ;; 0c:7341 ????????
    db   $00, $80, $00, $00, $00, $80, $33, $21        ;; 0c:7349 ????????
    db   $00, $80, $11, $00, $02, $e9, $20, $11        ;; 0c:7351 ????????
    db   $28, $10, $07, $ff, $64, $80, $08, $11        ;; 0c:7359 ????????
    db   $00, $00, $0b, $00, $00, $ba, $33, $12        ;; 0c:7361 ????????
    db   $00, $80, $04, $00, $00, $80, $0b, $00        ;; 0c:7369 ????????
    db   $00, $80, $00, $00, $00, $a3, $33, $a1        ;; 0c:7371 ????????
    db   $00, $00, $1e, $0f, $07, $8b, $20, $a5        ;; 0c:7379 ???????.
    db   $00, $00, $31, $06, $00, $92, $29, $a5        ;; 0c:7381 ........
    db   $00, $00, $31, $08, $00, $aa, $29, $a5        ;; 0c:7389 ..w..?.?
    db   $00, $00, $31, $06, $00, $bc, $29, $a5        ;; 0c:7391 ????????
    db   $00, $00, $31, $06, $00, $9e, $2c, $a5        ;; 0c:7399 ????????
    db   $00, $00, $31, $06, $00, $b3, $29, $a5        ;; 0c:73a1 ????????
    db   $00, $00, $31, $08, $00, $bb, $2b, $a5        ;; 0c:73a9 ????????
    db   $00, $00, $31, $06, $00, $b0, $29, $a5        ;; 0c:73b1 ????????
    db   $00, $00, $31, $08, $00, $b1, $29, $a5        ;; 0c:73b9 ????????
    db   $00, $00, $31, $08, $00, $e5, $2c, $a5        ;; 0c:73c1 ????????
    db   $00, $00, $31, $06, $00, $b3, $29, $a5        ;; 0c:73c9 ????????
    db   $00, $00, $31, $08, $00, $8b, $20, $a5        ;; 0c:73d1 ????????
    db   $00, $00, $31, $08, $00, $d3, $2b, $a5        ;; 0c:73d9 ????????
    db   $00, $00, $0e, $06, $00, $94, $2c, $a5        ;; 0c:73e1 ????????
    db   $00, $00, $0e, $08, $00, $9c, $29, $a5        ;; 0c:73e9 ????????
    db   $00, $00, $31, $08, $00, $bf, $20, $a5        ;; 0c:73f1 ????????
    db   $00, $00, $0e, $06, $00, $bb, $29, $a5        ;; 0c:73f9 ????????
    db   $00, $00, $31, $06, $00, $91, $29, $a5        ;; 0c:7401 ????????
    db   $00, $00, $1e, $08, $02, $c0, $20, $a5        ;; 0c:7409 ????????
    db   $00, $00, $1e, $06, $02, $a6, $20, $a5        ;; 0c:7411 ????????
    db   $00, $00, $1e, $05, $04, $d5, $29, $a5        ;; 0c:7419 ????????
    db   $00, $00, $1e, $05, $08, $91, $29, $a5        ;; 0c:7421 ????????
    db   $00, $00, $0d, $06, $b0, $b4, $2a, $a5        ;; 0c:7429 ????????
    db   $00, $00, $12, $32, $0a, $93, $04, $a5        ;; 0c:7431 ???????.
    db   $00, $00, $27, $06, $00, $bc, $2a, $a5        ;; 0c:7439 ..??????
    db   $00, $00, $0d, $06, $00, $b4, $2a, $07        ;; 0c:7441 ???????.
    db   $00, $00, $00, $04, $00, $a3, $33, $15        ;; 0c:7449 ..w..?.?
    db   $08, $00, $06, $00, $32, $e0, $08, $15        ;; 0c:7451 ????????
    db   $08, $00, $06, $00, $32, $e0, $08, $15        ;; 0c:7459 ????????
    db   $08, $00, $06, $00, $32, $e0, $08, $15        ;; 0c:7461 ????????
    db   $10, $00, $06, $00, $00, $c1, $08, $15        ;; 0c:7469 ????????
    db   $01, $00, $08, $14, $00, $88, $20, $15        ;; 0c:7471 ????????
    db   $04, $00, $08, $0a, $80, $a5, $26, $a5        ;; 0c:7479 ????????
    db   $00, $00, $1e, $08, $02, $a6, $20, $a5        ;; 0c:7481 ????????
    db   $00, $00, $1e, $08, $02, $ab, $29, $a5        ;; 0c:7489 ????????
    db   $00, $00, $1e, $06, $03, $d4, $2b, $a5        ;; 0c:7491 ????????
    db   $00, $00, $1e, $08, $03, $a8, $2c, $a5        ;; 0c:7499 ????????
    db   $00, $00, $1e, $05, $06, $a9, $29, $a5        ;; 0c:74a1 ????????
    db   $00, $00, $29, $08, $00, $c7, $1a, $a5        ;; 0c:74a9 ????????
    db   $00, $00, $31, $08, $00, $90, $2b, $07        ;; 0c:74b1 ????????
    db   $00, $00, $00, $04, $00, $a3, $33, $07        ;; 0c:74b9 ????????
    db   $00, $00, $00, $04, $00, $a3, $33, $17        ;; 0c:74c1 ????????
    db   $00, $00, $09, $06, $00, $ba, $33, $a5        ;; 0c:74c9 ????????
    db   $00, $00, $1e, $08, $02, $d2, $29, $a5        ;; 0c:74d1 ????????
    db   $00, $00, $1f, $02, $08, $d7, $29, $a5        ;; 0c:74d9 ????????
    db   $00, $00, $1f, $02, $08, $a2, $29, $a5        ;; 0c:74e1 ????????
    db   $00, $00, $1f, $02, $08, $a2, $29, $a5        ;; 0c:74e9 ????????
    db   $00, $00, $1f, $02, $08, $cb, $2e, $a5        ;; 0c:74f1 ????????
    db   $00, $00, $1f, $04, $10, $86, $2c, $a5        ;; 0c:74f9 ????????
    db   $00, $00, $1f, $04, $10, $aa, $2c, $15        ;; 0c:7501 ????????
    db   $02, $00, $08, $04, $10, $86, $36, $15        ;; 0c:7509 ????????
    db   $02, $00, $08, $02, $08, $ac, $30, $a5        ;; 0c:7511 ????????
    db   $00, $00, $1f, $10, $04, $94, $2f, $15        ;; 0c:7519 ????????
    db   $02, $00, $08, $10, $04, $84, $2f, $25        ;; 0c:7521 ????????
    db   $00, $00, $1a, $07, $20, $82, $18, $25        ;; 0c:7529 ????????
    db   $00, $00, $1a, $07, $40, $81, $35, $25        ;; 0c:7531 ???????.
    db   $00, $00, $1a, $07, $80, $e8, $26, $35        ;; 0c:7539 ..?????.
    db   $00, $00, $21, $05, $80, $c3, $26, $35        ;; 0c:7541 ..w....?
    db   $00, $00, $21, $05, $10, $c6, $36, $35        ;; 0c:7549 ????????
    db   $00, $00, $21, $05, $40, $c4, $35, $35        ;; 0c:7551 ????????
    db   $00, $00, $21, $05, $20, $c5, $18, $25        ;; 0c:7559 ????????
    db   $00, $00, $1a, $07, $00, $9f, $25, $35        ;; 0c:7561 ????????
    db   $00, $00, $21, $09, $00, $10, $0c, $25        ;; 0c:7569 ????????
    db   $00, $00, $1c, $0d, $b0, $ce, $19, $25        ;; 0c:7571 ????????
    db   $00, $00, $1c, $0d, $f0, $9f, $25, $25        ;; 0c:7579 ????????
    db   $00, $00, $1a, $07, $40, $b7, $03, $25        ;; 0c:7581 ????????
    db   $00, $00, $1c, $0d, $b0, $b5, $0d, $25        ;; 0c:7589 ????????
    db   $00, $00, $1b, $01, $08, $83, $30, $25        ;; 0c:7591 ????????
    db   $00, $00, $1b, $01, $08, $83, $30, $25        ;; 0c:7599 ????????
    db   $00, $00, $1b, $10, $04, $84, $2f, $25        ;; 0c:75a1 ????????
    db   $00, $00, $1b, $10, $04, $84, $2f, $25        ;; 0c:75a9 ????????
    db   $00, $00, $1b, $10, $04, $84, $2f, $25        ;; 0c:75b1 ????????
    db   $00, $00, $1b, $80, $08, $85, $2f, $25        ;; 0c:75b9 ????????
    db   $00, $00, $1b, $80, $08, $85, $2f, $25        ;; 0c:75c1 ????????
    db   $00, $00, $1b, $80, $08, $85, $2f, $25        ;; 0c:75c9 ????????
    db   $00, $00, $1b, $40, $08, $b5, $2e, $25        ;; 0c:75d1 ????????
    db   $00, $00, $1b, $40, $08, $b5, $2e, $25        ;; 0c:75d9 ????????
    db   $00, $00, $1b, $40, $08, $e6, $2e, $25        ;; 0c:75e1 ????????
    db   $00, $00, $1b, $04, $10, $86, $36, $25        ;; 0c:75e9 ????????
    db   $00, $00, $1b, $20, $08, $cf, $2e, $25        ;; 0c:75f1 ????????
    db   $00, $00, $1b, $02, $08, $ac, $30, $25        ;; 0c:75f9 ????????
    db   $00, $00, $1b, $02, $08, $d6, $30, $25        ;; 0c:7601 ????????
    db   $00, $00, $1b, $08, $08, $af, $30, $25        ;; 0c:7609 ????????
    db   $00, $00, $1b, $08, $08, $ae, $0c, $25        ;; 0c:7611 ????????
    db   $00, $00, $20, $01, $0a, $cd, $31, $25        ;; 0c:7619 ????????
    db   $00, $00, $20, $01, $0a, $e1, $31, $25        ;; 0c:7621 ????????
    db   $00, $00, $20, $01, $0a, $dc, $18, $25        ;; 0c:7629 ????????
    db   $00, $00, $20, $00, $0a, $b4, $31, $25        ;; 0c:7631 ????????
    db   $00, $00, $20, $00, $0a, $b8, $31, $15        ;; 0c:7639 ????????
    db   $00, $00, $26, $01, $0a, $b9, $1b, $35        ;; 0c:7641 ????????
    db   $00, $00, $21, $08, $00, $99, $10, $35        ;; 0c:7649 ????????
    db   $00, $00, $21, $08, $01, $12, $27, $35        ;; 0c:7651 ????????
    db   $00, $00, $21, $08, $00, $e2, $1d, $35        ;; 0c:7659 ????????
    db   $00, $00, $21, $0a, $00, $0e, $34, $35        ;; 0c:7661 ????????
    db   $00, $00, $23, $0a, $05, $b4, $0e, $35        ;; 0c:7669 ????????
    db   $00, $00, $22, $f0, $00, $9a, $07, $35        ;; 0c:7671 ????????
    db   $00, $00, $21, $05, $10, $0b, $14, $35        ;; 0c:7679 ????????
    db   $00, $00, $28, $08, $08, $0d, $09, $35        ;; 0c:7681 ????????
    db   $00, $00, $28, $20, $08, $0c, $2e, $35        ;; 0c:7689 ????????
    db   $00, $00, $28, $08, $08, $11, $2e, $04        ;; 0c:7691 ????????
    db   $80, $80, $00, $00, $00, $80, $00, $04        ;; 0c:7699 ????????
    db   $40, $80, $00, $00, $00, $80, $00, $15        ;; 0c:76a1 ????????
    db   $00, $00, $2a, $00, $00, $a3, $0f, $04        ;; 0c:76a9 ???????.
    db   $00, $90, $00, $00, $01, $80, $00, $04        ;; 0c:76b1 ..??.???
    db   $00, $90, $00, $00, $1e, $80, $00, $04        ;; 0c:76b9 ????????
    db   $00, $90, $00, $00, $80, $80, $00, $04        ;; 0c:76c1 ????????
    db   $00, $90, $00, $00, $10, $80, $00, $04        ;; 0c:76c9 ????????
    db   $00, $90, $00, $00, $f1, $80, $00, $04        ;; 0c:76d1 ????????
    db   $00, $90, $00, $00, $02, $80, $00, $04        ;; 0c:76d9 ???????.
    db   $00, $90, $00, $00, $18, $80, $00, $04        ;; 0c:76e1 ..??.???
    db   $00, $90, $00, $00, $08, $80, $00, $04        ;; 0c:76e9 ????????
    db   $00, $90, $00, $00, $40, $80, $00, $04        ;; 0c:76f1 ????????
    db   $00, $90, $00, $00, $04, $80, $00, $04        ;; 0c:76f9 ????????
    db   $00, $a0, $00, $00, $80, $80, $00, $04        ;; 0c:7701 ????????
    db   $00, $a0, $00, $00, $40, $80, $00, $04        ;; 0c:7709 ????????
    db   $00, $a0, $00, $00, $20, $80, $00, $16        ;; 0c:7711 ????????
    db   $00, $00, $04, $00, $00, $80, $0b, $06        ;; 0c:7719 ????????
    db   $00, $00, $02, $00, $00, $80, $33, $04        ;; 0c:7721 ????????
    db   $00, $90, $00, $00, $ff, $80, $00, $35        ;; 0c:7729 ????????
    db   $00, $00, $28, $04, $10, $86, $36, $11        ;; 0c:7731 ????????
    db   $28, $10, $2b, $ff, $64, $80, $08, $21        ;; 0c:7739 ????????
    db   $00, $80, $2c, $00, $02, $e9, $20, $21        ;; 0c:7741 ????????
    db   $00, $80, $2d, $00, $02, $e9, $20, $35        ;; 0c:7749 ????????
    db   $00, $00, $2e, $08, $00, $0e, $34, $00        ;; 0c:7751 ????????
    db   $00, $80, $00, $00, $00, $80, $33, $31        ;; 0c:7759 ????????
    db   $00, $80, $30, $03, $ff, $f0, $07, $21        ;; 0c:7761 ????????
    db   $00, $80, $2f, $05, $1e, $1b, $01, $04        ;; 0c:7769 ????????
    db   $00, $80, $00, $00, $00, $80, $00, $10        ;; 0c:7771 ???????.
    db   $00, $00, $03, $00, $00, $80, $01, $00        ;; 0c:7779 ..w....?
    db   $00, $40, $00, $00, $86, $80, $01, $00        ;; 0c:7781 ????????
    db   $00, $40, $00, $00, $46, $80, $01, $00        ;; 0c:7789 ????????
    db   $00, $40, $00, $00, $26, $80, $01, $00        ;; 0c:7791 ????????
    db   $00, $40, $00, $00, $16, $80, $01, $00        ;; 0c:7799 ????????
    db   $20, $10, $00, $80, $80, $80, $01, $00        ;; 0c:77a1 ????????
    db   $20, $10, $00, $20, $20, $80, $01, $00        ;; 0c:77a9 ????????
    db   $20, $10, $00, $40, $40, $80, $01, $00        ;; 0c:77b1 ????????
    db   $20, $10, $00, $10, $10, $80, $01, $21        ;; 0c:77b9 ????????
    db   $00, $00, $11, $00, $02, $e9, $20, $11        ;; 0c:77c1 ????????
    db   $08, $10, $07, $ff, $64, $80, $08, $00        ;; 0c:77c9 ????????
    db   $00, $00, $00, $00, $00, $80, $33, $11        ;; 0c:77d1 ????????
    db   $00, $00, $0b, $00, $00, $ba, $33, $12        ;; 0c:77d9 ????????
    db   $00, $00, $04, $00, $00, $80, $0b, $12        ;; 0c:77e1 ???????.
    db   $00, $00, $06, $00, $00, $80, $33, $10        ;; 0c:77e9 ?.w.????
    db   $00, $00, $04, $0f, $00, $80, $01, $10        ;; 0c:77f1 ????????
    db   $00, $00, $05, $1e, $00, $80, $01, $00        ;; 0c:77f9 ????????
    db   $00, $00, $00, $00, $01, $01, $01, $01        ;; 0c:7801 ????????
    db   $01, $02, $02, $02, $02, $02, $10, $10        ;; 0c:7809 ????????
    db   $10, $10, $10, $11, $11, $11, $11, $11        ;; 0c:7811 ????????
    db   $12, $12, $12, $12, $12, $20, $20, $20        ;; 0c:7819 ????????
    db   $20, $20, $21, $21, $21, $21, $21, $22        ;; 0c:7821 ????????
    db   $22, $22, $22, $22, $30, $30, $30, $30        ;; 0c:7829 ????????
    db   $30, $31, $31, $31, $31, $31, $32, $32        ;; 0c:7831 ????????
    db   $32, $32, $32, $40, $40, $40, $40, $40        ;; 0c:7839 ????????
    db   $41, $41, $41, $41, $41, $42, $42, $42        ;; 0c:7841 ????????
    db   $42, $42, $50, $50, $50, $50, $50, $51        ;; 0c:7849 ????????
    db   $51, $51, $51, $51, $52, $52, $52, $52        ;; 0c:7851 ????????
    db   $52, $60, $60, $60, $60, $60, $61, $61        ;; 0c:7859 ????????
    db   $61, $61, $61, $62, $62, $62, $62, $62        ;; 0c:7861 ????????
    db   $70, $70, $70, $70, $70, $71, $71, $71        ;; 0c:7869 ????????
    db   $71, $71, $72, $72, $72, $72, $72, $80        ;; 0c:7871 ????????
    db   $80, $80, $80, $80, $81, $81, $81, $81        ;; 0c:7879 ????????
    db   $81, $82, $82, $82, $82, $82, $90, $90        ;; 0c:7881 ????????
    db   $90, $90, $90, $91, $91, $91, $91, $91        ;; 0c:7889 ????????
    db   $92, $92, $92, $92, $92, $a0, $a0, $a0        ;; 0c:7891 ????????
    db   $a0, $a0, $a1, $a1, $a1, $a1, $a1, $a2        ;; 0c:7899 ????????
    db   $a2, $a2, $a2, $a2, $b0, $b0, $b0, $b0        ;; 0c:78a1 ????????
    db   $b0, $b1, $b1, $b1, $b1, $b1, $b2, $b2        ;; 0c:78a9 ????????
    db   $b2, $b2, $b2, $f0, $f0, $f0, $f0, $f0        ;; 0c:78b1 ????????
    db   $f0, $f0, $f0, $f0, $62, $f0, $f0, $f0        ;; 0c:78b9 ????????
    db   $f0, $80, $f0, $f0, $f0, $f0, $f0, $f0        ;; 0c:78c1 ????????
    db   $f0, $f0, $f0, $00, $e0, $e0, $e0, $e0        ;; 0c:78c9 ????????
    db   $00, $e0, $e0, $e0, $e0, $00, $20, $20        ;; 0c:78d1 ????????
    db   $20, $20, $00, $20, $20, $20, $20, $00        ;; 0c:78d9 ????????
    db   $00, $f0, $f0, $f0, $f0, $f0, $f0, $f0        ;; 0c:78e1 ????????
    db   $f0, $f0, $00, $00, $00, $80, $e0, $f0        ;; 0c:78e9 ????????
    db   $f0, $f0, $f0, $e0, $20, $62, $a1, $00        ;; 0c:78f1 ????????
    db   $00, $f0, $00, $00, $00, $00, $e0, $00        ;; 0c:78f9 ????????
    db   $00, $00, $00, $00, $01, $02, $02, $02        ;; 0c:7901 ????????
    db   $02, $03, $04, $04, $04, $04, $04, $05        ;; 0c:7909 ????????
    db   $05, $05, $05, $05, $05, $06, $06, $06        ;; 0c:7911 ????????
    db   $07, $08, $09, $09, $09, $09, $09, $0a        ;; 0c:7919 ????????
    db   $0a, $0a, $0a, $0a, $0b, $0b, $0c, $0c        ;; 0c:7921 ????????
    db   $0c, $0d, $0e, $0e, $0e, $0e, $0e, $0f        ;; 0c:7929 ????????
    db   $0f, $0f, $10, $10, $10, $10, $11, $11        ;; 0c:7931 ????????
    db   $11, $12, $13, $13, $13, $13, $13, $14        ;; 0c:7939 ????????
    db   $14, $14, $14, $14, $15, $15, $16, $16        ;; 0c:7941 ????????
    db   $16, $17, $18, $18, $18, $18, $18, $19        ;; 0c:7949 ????????
    db   $19, $19, $19, $19, $19, $19, $1a, $1b        ;; 0c:7951 ????????
    db   $1b, $1c, $1d, $1d, $1d, $1d, $1d, $f5        ;; 0c:7959 ????????
    db   $f5, $1e, $1e, $1f, $1f, $20, $20, $20        ;; 0c:7961 ????????
    db   $20, $21, $22, $22, $22, $22, $22, $23        ;; 0c:7969 ????????
    db   $23, $23, $23, $23, $24, $24, $24, $25        ;; 0c:7971 ????????
    db   $25, $26, $27, $27, $27, $27, $27, $28        ;; 0c:7979 ????????
    db   $28, $28, $28, $28, $28, $28, $29, $29        ;; 0c:7981 ????????
    db   $2a, $2b, $2c, $2c, $2c, $2c, $2c, $2d        ;; 0c:7989 ????????
    db   $2d, $2d, $2d, $2e, $2e, $2e, $2f, $2f        ;; 0c:7991 ????????
    db   $2f, $30, $31, $31, $31, $31, $31, $32        ;; 0c:7999 ????????
    db   $32, $32, $32, $32, $33, $34, $34, $34        ;; 0c:79a1 ????????
    db   $34, $35, $36, $36, $36, $36, $36, $37        ;; 0c:79a9 ????????
    db   $37, $37, $37, $37, $37, $38, $38, $39        ;; 0c:79b1 ????????
    db   $39, $3a, $3b, $3b, $3b, $3b, $3b, $3c        ;; 0c:79b9 ????????
    db   $3c, $3c, $3d, $3d, $3d, $3e, $3e, $3e        ;; 0c:79c1 ????????
    db   $3e, $3f, $40, $40, $40, $40, $40, $41        ;; 0c:79c9 ????????
    db   $41, $41, $41, $41, $41, $42, $42, $43        ;; 0c:79d1 ????????
    db   $43, $44, $45, $45, $45, $45, $45, $46        ;; 0c:79d9 ????????
    db   $46, $46, $46, $46, $46, $46, $47, $47        ;; 0c:79e1 ????????
    db   $48, $49, $4a, $4a, $4a, $4a, $4a, $4b        ;; 0c:79e9 ????????
    db   $4b, $4b, $4b, $4b, $4c, $4c, $4c, $4c        ;; 0c:79f1 ????????
    db   $4d, $4e, $4f, $4f, $4f, $4f, $4f, $50        ;; 0c:79f9 ????????
    db   $50, $50, $50, $50, $50, $51, $52, $52        ;; 0c:7a01 ????????
    db   $52, $53, $54, $54, $54, $54, $54, $55        ;; 0c:7a09 ????????
    db   $55, $55, $55, $55, $56, $56, $56, $57        ;; 0c:7a11 ????????
    db   $57, $58, $59, $59, $59, $59, $59, $5a        ;; 0c:7a19 ????????
    db   $5a, $5a, $5a, $5b, $5b, $5c, $5c, $5c        ;; 0c:7a21 ????????
    db   $5c, $5d, $5e, $5e, $5e, $5e, $5e, $5f        ;; 0c:7a29 ????????
    db   $5f, $5f, $5f, $5f, $6f, $60, $60, $61        ;; 0c:7a31 ????????
    db   $61, $62, $63, $63, $63, $63, $63, $f6        ;; 0c:7a39 ????????
    db   $f6, $f6, $f6, $f6, $64, $64, $64, $65        ;; 0c:7a41 ????????
    db   $66, $67, $68, $68, $68, $68, $68, $69        ;; 0c:7a49 ????????
    db   $69, $69, $69, $6a, $6a, $6a, $6b, $6b        ;; 0c:7a51 ????????
    db   $6b, $6c, $6d, $6d, $6d, $6d, $6d, $6e        ;; 0c:7a59 ????????
    db   $6e, $6e, $6e, $6e, $6f, $6f, $6f, $6f        ;; 0c:7a61 ????????
    db   $70, $71, $72, $72, $72, $72, $72, $73        ;; 0c:7a69 ????????
    db   $73, $73, $73, $73, $74, $74, $74, $74        ;; 0c:7a71 ????????
    db   $75, $76, $77, $77, $77, $77, $77, $78        ;; 0c:7a79 ????????
    db   $78, $78, $78, $79, $79, $79, $79, $7a        ;; 0c:7a81 ????????
    db   $7a, $7b, $7c, $7c, $7c, $7c, $7c, $7d        ;; 0c:7a89 ????????
    db   $7d, $7d, $7d, $7e, $7e, $7e, $7e, $7f        ;; 0c:7a91 ????????
    db   $7f, $80, $81, $81, $81, $81, $81, $82        ;; 0c:7a99 ????????
    db   $82, $82, $82, $82, $82, $83, $83, $83        ;; 0c:7aa1 ????????
    db   $84, $85, $86, $86, $86, $86, $86, $87        ;; 0c:7aa9 ????????
    db   $87, $87, $87, $87, $88, $88, $89, $89        ;; 0c:7ab1 ????????
    db   $89, $8a, $8b, $8b, $8b, $8b, $8b, $8c        ;; 0c:7ab9 ????????
    db   $8c, $8c, $8c, $8c, $8d, $8d, $8d, $8e        ;; 0c:7ac1 ????????
    db   $8e, $8f, $90, $90, $90, $90, $90, $91        ;; 0c:7ac9 ????????
    db   $91, $91, $91, $91, $91, $91, $91, $92        ;; 0c:7ad1 ????????
    db   $93, $94, $95, $95, $95, $95, $95, $96        ;; 0c:7ad9 ????????
    db   $96, $96, $97, $97, $97, $98, $98, $98        ;; 0c:7ae1 ????????
    db   $98, $99, $9a, $9a, $9a, $9a, $9a, $f7        ;; 0c:7ae9 ????????
    db   $f7, $f7, $9b, $9b, $9b, $9b, $9c, $9d        ;; 0c:7af1 ????????
    db   $9d, $9e, $9f, $9f, $9f, $9f, $9f, $a0        ;; 0c:7af9 ????????
    db   $a0, $a0, $a0, $a0, $a0, $a0, $a1, $a1        ;; 0c:7b01 ????????
    db   $a2, $a3, $a4, $a4, $a4, $a4, $a4, $a5        ;; 0c:7b09 ????????
    db   $a5, $a6, $a6, $a6, $a6, $a7, $a7, $a7        ;; 0c:7b11 ????????
    db   $a7, $a8, $a9, $a9, $a9, $a9, $a9, $aa        ;; 0c:7b19 ????????
    db   $aa, $aa, $aa, $ab, $ab, $ab, $ab, $ac        ;; 0c:7b21 ????????
    db   $ac, $ad, $ae, $ae, $ae, $ae, $ae, $af        ;; 0c:7b29 ????????
    db   $af, $af, $af, $af, $af, $af, $b0, $b1        ;; 0c:7b31 ????????
    db   $b1, $b2, $b3, $b3, $b3, $b3, $b3, $80        ;; 0c:7b39 ????????
    db   $81, $82, $83, $84, $86, $8a, $8a, $8c        ;; 0c:7b41 .???????
    db   $8f, $88, $88, $88, $1c, $24, $41, $43        ;; 0c:7b49 ????????
    db   $4a, $00, $8f, $84, $40, $44, $10, $12        ;; 0c:7b51 ????????
    db   $14, $18, $18, $1c, $00, $00, $00, $00        ;; 0c:7b59 ????????
    db   $00, $8f, $4c, $24, $24, $24, $24, $24        ;; 0c:7b61 ????????
    db   $24, $24, $26, $28, $28, $2c, $28, $2f        ;; 0c:7b69 ????????
    db   $10, $12, $14, $1c, $10, $12, $14, $18        ;; 0c:7b71 ????????
    db   $1c, $10, $12, $14, $18, $1c, $14, $18        ;; 0c:7b79 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $41        ;; 0c:7b81 ????????
    db   $44, $84, $44, $82, $86, $88, $40, $42        ;; 0c:7b89 ????????
    db   $44, $48, $4c, $4f, $24, $42, $00, $00        ;; 0c:7b91 ????????
    db   $00, $04, $06, $08, $0a, $0c, $08, $0c        ;; 0c:7b99 ????????
    db   $0f, $18, $18, $16, $12, $86, $46, $10        ;; 0c:7ba1 ????????
    db   $1a, $8a, $8f, $46, $22, $28, $4c, $04        ;; 0c:7ba9 ????????
    db   $84, $2f, $18, $0f, $1a, $1f, $00, $00        ;; 0c:7bb1 ????????
    db   $00, $00, $00, $00, $00, $0c, $0f, $00        ;; 0c:7bb9 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:7bc1 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:7bc9 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:7bd1 ????????
    db   $20, $10, $10, $10, $20, $00, $00, $00        ;; 0c:7bd9 ????????
    db   $00, $00, $00, $00, $00, $00, $20, $20        ;; 0c:7be1 ????????
    db   $20, $00, $00, $00, $00, $00, $00, $00        ;; 0c:7be9 ????????
    db   $00, $00, $00, $00, $20, $20, $20, $20        ;; 0c:7bf1 ????????
    db   $20, $20, $20, $00, $20, $20, $00, $00        ;; 0c:7bf9 ????????
    db   $00, $00, $20, $20, $20, $00, $00, $20        ;; 0c:7c01 ????????
    db   $20, $00, $00, $00, $00, $20, $00, $20        ;; 0c:7c09 ????????
    db   $20, $20, $00, $00, $20, $00, $00, $20        ;; 0c:7c11 ????????
    db   $20, $20, $20, $20, $40, $00, $00, $20        ;; 0c:7c19 ????????
    db   $20, $20, $00, $00, $00, $00, $00, $00        ;; 0c:7c21 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:7c29 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $00        ;; 0c:7c31 ????????
    db   $00, $00, $00, $00, $00, $00, $00, $8a        ;; 0c:7c39 ????????
    db   $4a, $0a, $1a, $0a, $0a, $0a, $0a, $8a        ;; 0c:7c41 ????????
    db   $1a, $0a, $0a, $0a, $0a, $00, $00, $a1        ;; 0c:7c49 ????????
    db   $a5, $a6, $aa, $ab, $a2, $a6, $a9, $aa        ;; 0c:7c51 ????????
    db   $ab, $a4, $a5, $a7, $aa, $ab, $a2, $a3        ;; 0c:7c59 ????????
    db   $a7, $aa, $ab, $a3, $a5, $a7, $aa, $ab        ;; 0c:7c61 ????????
    db   $a4, $a7, $a8, $aa, $ab, $a2, $a4, $a6        ;; 0c:7c69 ????????
    db   $aa, $ab, $a3, $a5, $a8, $aa, $ab, $a4        ;; 0c:7c71 ????????
    db   $a7, $a9, $aa, $ab, $a1, $a4, $a7, $aa        ;; 0c:7c79 ????.???
    db   $ab, $a2, $a5, $a6, $aa, $ab, $a4, $a6        ;; 0c:7c81 ????????
    db   $a8, $aa, $ab, $a2, $a3, $a6, $aa, $ab        ;; 0c:7c89 ????????
    db   $a2, $a6, $a8, $aa, $ab, $a3, $a7, $a9        ;; 0c:7c91 ????????
    db   $aa, $ab, $a1, $a5, $a9, $aa, $ab, $a2        ;; 0c:7c99 ????????
    db   $a6, $a7, $aa, $ab, $a4, $a5, $a8, $aa        ;; 0c:7ca1 ????????
    db   $ab, $a1, $a4, $a6, $aa, $ab, $a3, $a6        ;; 0c:7ca9 ????????
    db   $a8, $aa, $ab, $a5, $a8, $a9, $aa, $ab        ;; 0c:7cb1 ????????
    db   $a2, $a4, $a7, $aa, $ab, $a2, $a5, $a9        ;; 0c:7cb9 ????????
    db   $aa, $ab, $a4, $a5, $a9, $aa, $ab, $a1        ;; 0c:7cc1 ????????
    db   $a4, $a8, $aa, $ab, $a3, $a4, $a8, $aa        ;; 0c:7cc9 ????????
    db   $ab, $a4, $a6, $a9, $aa, $ab, $a1, $a5        ;; 0c:7cd1 ????????
    db   $a7, $aa, $ab, $a2, $a5, $a8, $aa, $ab        ;; 0c:7cd9 ????????
    db   $a4, $a8, $a9, $aa, $ab, $a1, $a3, $a6        ;; 0c:7ce1 ????????
    db   $aa, $ab, $a3, $a7, $a8, $aa, $ab, $a5        ;; 0c:7ce9 ????????
    db   $a7, $a9, $aa, $ab, $a1, $a2, $a6, $aa        ;; 0c:7cf1 ????????
    db   $ab, $a2, $a4, $a8, $aa, $ab, $a5, $a7        ;; 0c:7cf9 ????????
    db   $a8, $aa, $ab, $21, $23, $27, $2a, $27        ;; 0c:7d01 ????????
    db   $21, $25, $28, $2a, $eb, $22, $25, $27        ;; 0c:7d09 ????????
    db   $2a, $eb, $23, $26, $27, $2a, $2b, $23        ;; 0c:7d11 ????????
    db   $26, $29, $2a, $2b, $23, $25, $29, $2a        ;; 0c:7d19 ????????
    db   $2b, $25, $26, $29, $2a, $31, $a3, $a4        ;; 0c:7d21 ????????
    db   $a6, $aa, $2b, $a3, $a4, $a7, $aa, $2b        ;; 0c:7d29 ????????
    db   $20, $20, $20, $20, $20, $20, $20, $20        ;; 0c:7d31 ????????
    db   $20, $20, $20, $20, $00, $b1, $12, $20        ;; 0c:7d39 ????????
    db   $20, $20, $20, $20, $20, $20, $20, $13        ;; 0c:7d41 ????????
    db   $14, $15, $16, $37, $17, $00, $00, $01        ;; 0c:7d49 ????????
    db   $25, $36, $5a, $5b, $02, $26, $39, $3a        ;; 0c:7d51 ????????
    db   $6b, $14, $15, $27, $3a, $4b, $02, $13        ;; 0c:7d59 ????????
    db   $27, $3a, $3b, $03, $25, $37, $4a, $4b        ;; 0c:7d61 ????????
    db   $14, $27, $38, $4a, $5b, $02, $14, $16        ;; 0c:7d69 ????????
    db   $3a, $4b, $03, $25, $38, $4a, $4b, $04        ;; 0c:7d71 ????????
    db   $27, $39, $4a, $5b, $01, $24, $37, $5a        ;; 0c:7d79 ????.???
    db   $5b, $02, $15, $26, $4a, $4b, $14, $26        ;; 0c:7d81 ????????
    db   $38, $4a, $5b, $12, $13, $36, $5a, $6b        ;; 0c:7d89 ????????
    db   $02, $26, $28, $4a, $5b, $03, $27, $39        ;; 0c:7d91 ????????
    db   $3a, $4b, $01, $25, $49, $4a, $5b, $02        ;; 0c:7d99 ????????
    db   $26, $37, $3a, $3b, $14, $25, $38, $4a        ;; 0c:7da1 ????????
    db   $4b, $01, $04, $36, $4a, $5b, $03, $36        ;; 0c:7da9 ????????
    db   $38, $3a, $4b, $25, $38, $39, $4a, $5b        ;; 0c:7db1 ????????
    db   $02, $14, $37, $5a, $5b, $02, $15, $29        ;; 0c:7db9 ????????
    db   $3a, $3b, $14, $25, $49, $4a, $5b, $01        ;; 0c:7dc1 ???????.
    db   $14, $28, $3a, $4b, $13, $24, $48, $4a        ;; 0c:7dc9 ????????
    db   $4b, $14, $26, $39, $4a, $3b, $01, $25        ;; 0c:7dd1 ????????
    db   $27, $5a, $3b, $02, $15, $38, $4a, $6b        ;; 0c:7dd9 ????????
    db   $24, $48, $59, $6a, $6b, $01, $13, $46        ;; 0c:7de1 ????????
    db   $5a, $4b, $13, $27, $38, $3a, $4b, $25        ;; 0c:7de9 ????????
    db   $37, $49, $4a, $5b, $01, $12, $26, $3a        ;; 0c:7df1 ????????
    db   $3b, $12, $14, $38, $4a, $4b, $15, $27        ;; 0c:7df9 ????????
    db   $28, $3a, $4b, $01, $13, $37, $5a, $3b        ;; 0c:7e01 ????????
    db   $01, $25, $48, $6a, $3b, $12, $25, $57        ;; 0c:7e09 ????????
    db   $6a, $2b, $13, $36, $47, $6a, $2b, $13        ;; 0c:7e11 ????????
    db   $36, $59, $6a, $0b, $03, $25, $49, $4a        ;; 0c:7e19 ????????
    db   $0b, $15, $16, $39, $3a, $2b, $03, $14        ;; 0c:7e21 ????????
    db   $26, $2a, $0b, $03, $14, $37, $4a, $0b        ;; 0c:7e29 ????????
    db   $40, $60, $00, $40, $00, $40, $00, $30        ;; 0c:7e31 ????????
    db   $40, $40, $50, $3c, $49, $27, $3e, $10        ;; 0c:7e39 ????????
    db   $10, $20, $20, $10, $11, $11, $11, $37        ;; 0c:7e41 ????????
    db   $39, $37, $3c, $3d, $4e, $0f, $00, $00        ;; 0c:7e49 ????????
    db   $00, $1e, $00, $3c, $00, $5a, $00, $78        ;; 0c:7e51 ?..?????
    db   $00, $96, $00, $b4, $00, $d2, $00, $f0        ;; 0c:7e59 ????????
    db   $00, $0e, $01, $2c, $01, $4a, $01, $68        ;; 0c:7e61 ????????
    db   $01, $86, $01, $a4, $01, $c2, $01, $00        ;; 0c:7e69 ????????
    db   $00, $20, $03, $a0, $8c, $20, $03, $80        ;; 0c:7e71 ????????
    db   $3e, $01, $00, $60, $6d, $00, $7d, $32        ;; 0c:7e79 ????????
    db   $32, $32, $32, $32, $32, $28, $28, $28        ;; 0c:7e81 w???????
    db   $28, $28, $28, $28, $28, $28, $32, $32        ;; 0c:7e89 ????????
    db   $32, $1e, $01, $28, $32, $32, $32, $32        ;; 0c:7e91 ????w?w?
    db   $32, $1e, $1e, $1e, $04, $04, $04, $04        ;; 0c:7e99 ????w???
    db   $1e, $fe, $1e, $1e, $1e, $1e, $1e, $1e        ;; 0c:7ea1 ????????
    db   $1e, $1e, $0f, $0f, $0f, $0a, $0f, $0a        ;; 0c:7ea9 ????????
    db   $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe        ;; 0c:7eb1 ????w???
    db   $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe        ;; 0c:7eb9 ????????
    db   $01, $04, $01, $01, $01, $01, $01, $28        ;; 0c:7ec1 ????????
    db   $28, $1e, $28, $32, $32, $32, $5a, $50        ;; 0c:7ec9 ???.????
    db   $46, $3c, $32, $28, $1e, $28, $1e, $1e        ;; 0c:7ed1 ????????
    db   $1e, $1e, $1e, $1e, $1e, $14, $1e, $0a        ;; 0c:7ed9 ????????
    db   $01, $fe, $fe, $fe, $fe, $32, $32, $fe        ;; 0c:7ee1 ????????
    db   $32, $28, $1e, $32, $32, $32, $1e, $14        ;; 0c:7ee9 ????????
    db   $1e, $1e, $fe, $03, $fe, $fe, $03, $fe        ;; 0c:7ef1 ????????
    db   $fe, $fe, $fe, $01, $fe, $fe, $07, $1e        ;; 0c:7ef9 ???????w
    db   $0f, $1e, $1e, $1e, $0f, $1e, $0f, $0f        ;; 0c:7f01 ????????
    db   $1e, $1e, $0f, $1e, $1e, $1e, $1e, $1e        ;; 0c:7f09 ????????
    db   $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f        ;; 0c:7f11 ??????w?
    db   $0f, $1e, $1e, $1e, $0f, $1e, $1e, $0f        ;; 0c:7f19 .???????
    db   $0f, $0f, $0f, $0f, $0a, $14, $0a, $0a        ;; 0c:7f21 ????????
    db   $03, $0f, $14, $14, $14, $14, $14, $14        ;; 0c:7f29 ????????
    db   $1e, $1e, $14, $1e, $0f, $0f, $0f, $0f        ;; 0c:7f31 ??????ww
    db   $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f        ;; 0c:7f39 ????????
    db   $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f        ;; 0c:7f41 ????????
    db   $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f        ;; 0c:7f49 ????????
    db   $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f        ;; 0c:7f51 ????????
    db   $05, $05, $05, $05, $0a, $01, $05, $05        ;; 0c:7f59 ????????
    db   $05, $05, $fe, $fe, $fe, $fe, $fe, $fe        ;; 0c:7f61 ?????w??
    db   $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe        ;; 0c:7f69 ???w????
    db   $fe, $fe, $1e, $1e, $fe, $1e, $fe, $fe        ;; 0c:7f71 ????????
    db   $fe, $fe, $fe, $1e, $1e, $fe, $ff, $fe        ;; 0c:7f79 ??????w?
    db   $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe        ;; 0c:7f81 ????????
    db   $fe, $fe, $01, $fe, $fe, $01, $fe, $00        ;; 0c:7f89 ????w??.
    db   $00, $0a, $0f, $0a, $0f, $0a, $0f, $0a        ;; 0c:7f91 .....???
    db   $0f, $00, $00, $00, $00, $00, $00, $05        ;; 0c:7f99 ???????.
    db   $07, $05, $0f, $05, $0f, $05, $0f, $05        ;; 0c:7fa1 ...?????
    db   $0f, $05, $0f, $00, $00, $00, $00, $07        ;; 0c:7fa9 ????????
    db   $0f, $17, $1f, $27, $2f, $37, $3f, $47        ;; 0c:7fb1 ????????
    db   $4f, $57, $5f, $67, $6f, $77, $7f, $87        ;; 0c:7fb9 ????????
    db   $8f, $97, $9f, $a7, $af, $b7, $bf, $c7        ;; 0c:7fc1 ????????
    db   $cf, $d7, $df, $e7, $ef, $f7, $ff, $99        ;; 0c:7fc9 ????????
    db   $e4, $b7, $e9, $b6, $ed, $b5, $e6, $d5        ;; 0c:7fd1 ????????
    db   $f0, $dd, $f1, $b4, $f2, $d0, $e3, $c4        ;; 0c:7fd9 ????????
    db   $ef, $de, $f4, $d1, $eb, $d2, $f3, $95        ;; 0c:7fe1 ????????
    db   $ea, $bd, $e7, $9d, $fe, $dc, $f5, $3f        ;; 0c:7fe9 ???????.
    db   $42, $0f                                      ;; 0c:7ff1 ..
