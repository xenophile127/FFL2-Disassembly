;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "bank0e", ROMX[$4000], BANK[$0e]

; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy
updateSoundEngine:
    jr   updateSoundEngineImpl                         ;; 0e:4000 $18 $04
    db   $00                                           ;; 0e:4002 ?

initSoundEngine:
    jr   initSoundEngineImpl                           ;; 0e:4003 $18 $43
    db   $00                                           ;; 0e:4005 ?

updateSoundEngineImpl:
    push AF                                            ;; 0e:4006 $f5
    push BC                                            ;; 0e:4007 $c5
    push DE                                            ;; 0e:4008 $d5
    push HL                                            ;; 0e:4009 $e5
    ldh  A, [hMusicSpecialSongRequest]                 ;; 0e:400a $f0 $b1
    or   A, A                                          ;; 0e:400c $b7
    jr   Z, .noSpecialMusic                            ;; 0e:400d $28 $0f
    ldh  A, [hMusicSpecialSongPlaying]                 ;; 0e:400f $f0 $b9
    or   A, A                                          ;; 0e:4011 $b7
    jr   Z, .specialMusicStart                         ;; 0e:4012 $28 $05
    call musicSpecialSongCheckFinished                 ;; 0e:4014 $cd $0d $41
    jr   .audioPlayStep                                ;; 0e:4017 $18 $24
.specialMusicStart:
    call musicSpecialSongStart                         ;; 0e:4019 $cd $eb $40
    jr   .audioPlayStep                                ;; 0e:401c $18 $1f
.noSpecialMusic:
    ldh  A, [hMusicSpecialSongPlaying]                 ;; 0e:401e $f0 $b9
    or   A, A                                          ;; 0e:4020 $b7
    jr   Z, .startMusic                                ;; 0e:4021 $28 $05
    call musicSpecialSongResumeSavedSong               ;; 0e:4023 $cd $1d $41
    jr   .audioPlayStep                                ;; 0e:4026 $18 $15
.startMusic:
    ld   A, [wSoundEffectDurationChannel1]             ;; 0e:4028 $fa $1a $cb
    or   A, A                                          ;; 0e:402b $b7
    jr   NZ, .startSoundEffect                         ;; 0e:402c $20 $09
    ldh  A, [hPlayingMusic]                            ;; 0e:402e $f0 $b3
    ld   B, A                                          ;; 0e:4030 $47
    ldh  A, [hCurrentMusic]                            ;; 0e:4031 $f0 $b0
    cp   A, B                                          ;; 0e:4033 $b8
    call NZ, musicSongInit                             ;; 0e:4034 $c4 $9b $40
.startSoundEffect:
    ldh  A, [hSFX]                                     ;; 0e:4037 $f0 $b2
    or   A, A                                          ;; 0e:4039 $b7
    call NZ, soundEffectPlay                           ;; 0e:403a $c4 $20 $49
.audioPlayStep:
    call musicPlayStep                                 ;; 0e:403d $cd $51 $42
    call soundEffectPlayStep                           ;; 0e:4040 $cd $49 $49
    pop  HL                                            ;; 0e:4043 $e1
    pop  DE                                            ;; 0e:4044 $d1
    pop  BC                                            ;; 0e:4045 $c1
    pop  AF                                            ;; 0e:4046 $f1
    ret                                                ;; 0e:4047 $c9

initSoundEngineImpl:
    ld   A, $ff                                        ;; 0e:4048 $3e $ff
    ldh  [rNR52], A                                    ;; 0e:404a $e0 $26
    call musicInitChannels                             ;; 0e:404c $cd $81 $40
    ld   A, $ff                                        ;; 0e:404f $3e $ff
    ld   [wMusicEndedOnChannel2], A                    ;; 0e:4051 $ea $13 $cb
    ld   [wMusicEndedOnChannel1], A                    ;; 0e:4054 $ea $2b $cb
    ld   [wMusicEndedOnChannel3], A                    ;; 0e:4057 $ea $43 $cb
    ld   [wMusicEndedOnChannel4], A                    ;; 0e:405a $ea $5b $cb
    ld   A, $10                                        ;; 0e:405d $3e $10
    ldh  [rNR12], A                                    ;; 0e:405f $e0 $12
    ldh  [rNR22], A                                    ;; 0e:4061 $e0 $17
    ldh  [rNR32], A                                    ;; 0e:4063 $e0 $1c
    ldh  [rNR42], A                                    ;; 0e:4065 $e0 $21
    call muteSoundEngine                               ;; 0e:4067 $cd $ce $40
    xor  A, A                                          ;; 0e:406a $af
    ld   [wSoundEffectDurationChannel1], A             ;; 0e:406b $ea $1a $cb
    ld   A, $77                                        ;; 0e:406e $3e $77
    ldh  [rNR50], A                                    ;; 0e:4070 $e0 $24
    ld   A, $ff                                        ;; 0e:4072 $3e $ff
    ldh  [rNR51], A                                    ;; 0e:4074 $e0 $25
    ld   HL, hCurrentMusic                             ;; 0e:4076 $21 $b0 $ff
    ld   C, $10                                        ;; 0e:4079 $0e $10
    xor  A, A                                          ;; 0e:407b $af
.loop:
    ld   [HL+], A                                      ;; 0e:407c $22
    dec  C                                             ;; 0e:407d $0d
    jr   NZ, .loop                                     ;; 0e:407e $20 $fc
    ret                                                ;; 0e:4080 $c9

musicInitChannels:
    ld   HL, wMusicTempoTimeCounter                    ;; 0e:4081 $21 $00 $cb
    ld   A, $ff                                        ;; 0e:4084 $3e $ff
    ld   [HL+], A                                      ;; 0e:4086 $22
    ld   A, $3c                                        ;; 0e:4087 $3e $3c
    ld   [HL+], A                                      ;; 0e:4089 $22
    ld   B, $03                                        ;; 0e:408a $06 $03
.loop_outer:
    ld   DE, musicChannelInitData                      ;; 0e:408c $11 $75 $41
    ld   C, $18                                        ;; 0e:408f $0e $18
.loop_inner:
    ld   A, [DE]                                       ;; 0e:4091 $1a
    ld   [HL+], A                                      ;; 0e:4092 $22
    inc  E                                             ;; 0e:4093 $1c
    dec  C                                             ;; 0e:4094 $0d
    jr   NZ, .loop_inner                               ;; 0e:4095 $20 $fa
    dec  B                                             ;; 0e:4097 $05
    jr   NZ, .loop_outer                               ;; 0e:4098 $20 $f2
    ret                                                ;; 0e:409a $c9

musicSongInit:
    ldh  [hPlayingMusic], A                            ;; 0e:409b $e0 $b3
    or   A, A                                          ;; 0e:409d $b7
    jr   NZ, musicSongPlay                             ;; 0e:409e $20 $04
    call initSoundEngineImpl                           ;; 0e:40a0 $cd $48 $40
    ret                                                ;; 0e:40a3 $c9

musicSongPlay:
    push AF                                            ;; 0e:40a4 $f5
    call musicInitChannels                             ;; 0e:40a5 $cd $81 $40
    pop  AF                                            ;; 0e:40a8 $f1
    dec  A                                             ;; 0e:40a9 $3d
    ld   E, A                                          ;; 0e:40aa $5f
    add  A, A                                          ;; 0e:40ab $87
    add  A, E                                          ;; 0e:40ac $83
    add  A, A                                          ;; 0e:40ad $87
    ld   HL, musicSongChannelPointers                  ;; 0e:40ae $21 $f5 $49
    ld   E, A                                          ;; 0e:40b1 $5f
    ld   D, $00                                        ;; 0e:40b2 $16 $00
    add  HL, DE                                        ;; 0e:40b4 $19
    ld   A, [HL+]                                      ;; 0e:40b5 $2a
    ld   [wMusicInstructionPointerChannel2], A         ;; 0e:40b6 $ea $04 $cb
    ld   A, [HL+]                                      ;; 0e:40b9 $2a
    ld   [wMusicInstructionPointerChannel2.high], A    ;; 0e:40ba $ea $05 $cb
    ld   A, [HL+]                                      ;; 0e:40bd $2a
    ld   [wMusicInstructionPointerChannel1], A         ;; 0e:40be $ea $1c $cb
    ld   A, [HL+]                                      ;; 0e:40c1 $2a
    ld   [wMusicInstructionPointerChannel1.high], A    ;; 0e:40c2 $ea $1d $cb
    ld   A, [HL+]                                      ;; 0e:40c5 $2a
    ld   [wMusicInstructionPointerChannel3], A         ;; 0e:40c6 $ea $34 $cb
    ld   A, [HL+]                                      ;; 0e:40c9 $2a
    ld   [wMusicInstructionPointerChannel3.high], A    ;; 0e:40ca $ea $35 $cb
    ret                                                ;; 0e:40cd $c9

muteSoundEngine:
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

musicSpecialSongStart:
    call muteSoundEngine                               ;; 0e:40eb $cd $ce $40
    xor  A, A                                          ;; 0e:40ee $af
    ld   [wSoundEffectDurationChannel1], A             ;; 0e:40ef $ea $1a $cb
    ld   [wSoundEffectDurationChannel4], A             ;; 0e:40f2 $ea $4a $cb
    ld   C, $62                                        ;; 0e:40f5 $0e $62
    ld   HL, wMusicTempoTimeCounter                    ;; 0e:40f7 $21 $00 $cb
    ld   DE, wMusicDataBackup                          ;; 0e:40fa $11 $62 $cb
.loop:
    ld   A, [HL+]                                      ;; 0e:40fd $2a
    ld   [DE], A                                       ;; 0e:40fe $12
    inc  E                                             ;; 0e:40ff $1c
    dec  C                                             ;; 0e:4100 $0d
    jr   NZ, .loop                                     ;; 0e:4101 $20 $fa
    ldh  A, [hMusicSpecialSongRequest]                 ;; 0e:4103 $f0 $b1
    call musicSongPlay                                 ;; 0e:4105 $cd $a4 $40
    ld   A, $01                                        ;; 0e:4108 $3e $01
    ldh  [hMusicSpecialSongPlaying], A                 ;; 0e:410a $e0 $b9
    ret                                                ;; 0e:410c $c9

musicSpecialSongCheckFinished:
    ld   A, [wMusicEndedOnChannel2]                    ;; 0e:410d $fa $13 $cb
    ld   E, A                                          ;; 0e:4110 $5f
    ld   A, [wMusicEndedOnChannel1]                    ;; 0e:4111 $fa $2b $cb
    ld   D, A                                          ;; 0e:4114 $57
    ld   A, [wMusicEndedOnChannel3]                    ;; 0e:4115 $fa $43 $cb
    and  A, D                                          ;; 0e:4118 $a2
    and  A, E                                          ;; 0e:4119 $a3
    cp   A, $ff                                        ;; 0e:411a $fe $ff
    ret  NZ                                            ;; 0e:411c $c0

musicSpecialSongResumeSavedSong:
    call muteSoundEngine                               ;; 0e:411d $cd $ce $40
    ld   C, $62                                        ;; 0e:4120 $0e $62
    ld   HL, wMusicTempoTimeCounter                    ;; 0e:4122 $21 $00 $cb
    ld   DE, wMusicDataBackup                          ;; 0e:4125 $11 $62 $cb
.loop:
    ld   A, [DE]                                       ;; 0e:4128 $1a
    ld   [HL+], A                                      ;; 0e:4129 $22
    inc  E                                             ;; 0e:412a $1c
    dec  C                                             ;; 0e:412b $0d
    jr   NZ, .loop                                     ;; 0e:412c $20 $fa
    xor  A, A                                          ;; 0e:412e $af
    ldh  [hMusicSpecialSongRequest], A                 ;; 0e:412f $e0 $b1
    ldh  [hMusicSpecialSongPlaying], A                 ;; 0e:4131 $e0 $b9
    ld   A, [wMusicNR21DutyCycleChannel2]              ;; 0e:4133 $fa $0c $cb
    ldh  [rNR21], A                                    ;; 0e:4136 $e0 $16
    ld   A, [wMusicNR22DefaultVolumeChannel2]          ;; 0e:4138 $fa $10 $cb
    ldh  [rNR22], A                                    ;; 0e:413b $e0 $17
    ld   A, $87                                        ;; 0e:413d $3e $87
    ldh  [rNR24], A                                    ;; 0e:413f $e0 $19
    ldh  A, [hWaveTablePointer]                        ;; 0e:4141 $f0 $ba
    ld   L, A                                          ;; 0e:4143 $6f
    ldh  A, [hWaveTablePointer.high]                   ;; 0e:4144 $f0 $bb
    ld   H, A                                          ;; 0e:4146 $67
    call musicLoadWaveTable                            ;; 0e:4147 $cd $91 $47

soundEffectRestoreChannel1:
    xor  A, A                                          ;; 0e:414a $af
    ldh  [rNR10], A                                    ;; 0e:414b $e0 $10
    ld   A, [wMusicNR11DutyCycleChannel1]              ;; 0e:414d $fa $24 $cb
    ldh  [rNR11], A                                    ;; 0e:4150 $e0 $11
    ld   A, [wMusicNR12DefaultVolumeChannel1]          ;; 0e:4152 $fa $28 $cb
    ldh  [rNR12], A                                    ;; 0e:4155 $e0 $12
    ld   A, $ff                                        ;; 0e:4157 $3e $ff
    ldh  [rNR13], A                                    ;; 0e:4159 $e0 $13
    ld   A, $87                                        ;; 0e:415b $3e $87
    ldh  [rNR14], A                                    ;; 0e:415d $e0 $14
    ld   A, [wMusicStereoPanChannel1]                  ;; 0e:415f $fa $2a $cb
    ld   E, A                                          ;; 0e:4162 $5f
    ldh  A, [rNR51]                                    ;; 0e:4163 $f0 $25
    and  A, $ee                                        ;; 0e:4165 $e6 $ee
    or   A, E                                          ;; 0e:4167 $b3
    ldh  [rNR51], A                                    ;; 0e:4168 $e0 $25
    ret                                                ;; 0e:416a $c9

soundEffectMuteChannel4:
    xor  A, A                                          ;; 0e:416b $af
    ldh  [rNR42], A                                    ;; 0e:416c $e0 $21
    ldh  [rNR43], A                                    ;; 0e:416e $e0 $22
    ld   A, $80                                        ;; 0e:4170 $3e $80
    ldh  [rNR44], A                                    ;; 0e:4172 $e0 $23
    ret                                                ;; 0e:4174 $c9

;@data format=b amount=24
musicChannelInitData:
    db   $00                                           ;; 0e:4175 . $00
    db   $01                                           ;; 0e:4176 . $01
    db   $00                                           ;; 0e:4177 . $02
    db   $00                                           ;; 0e:4178 . $03
    db   $14                                           ;; 0e:4179 . $04
    db   $8c                                           ;; 0e:417a . $05
    db   $41                                           ;; 0e:417b . $06
    db   $8c                                           ;; 0e:417c . $07
    db   $41                                           ;; 0e:417d . $08
    db   $60                                           ;; 0e:417e . $09
    db   $00                                           ;; 0e:417f . $0a
    db   $00                                           ;; 0e:4180 . $0b
    db   $00                                           ;; 0e:4181 . $0c
    db   $00                                           ;; 0e:4182 . $0d
    db   $10                                           ;; 0e:4183 . $0e
    db   $0f                                           ;; 0e:4184 . $0f
    db   $00                                           ;; 0e:4185 . $10
    db   $00                                           ;; 0e:4186 . $11
    db   $01                                           ;; 0e:4187 . $12
    db   $95                                           ;; 0e:4188 . $13
    db   $41                                           ;; 0e:4189 . $14
    db   $95                                           ;; 0e:418a . $15
    db   $41                                           ;; 0e:418b . $16
    db   $0a                                           ;; 0e:418c . $17
    db   $00, $02, $01, $02, $00, $00, $8e, $41        ;; 0e:418d w.w.w...
    db   $ff, $f0, $00, $95, $41                       ;; 0e:4195 ?????

;@data format=wwwwwwwwwwww amount=7
musicNoteFrequencies:
    dw   $802c, $809d, $8107, $816b, $81c9, $8223, $8277, $82c7, $8312, $8358, $839b, $83da ;; 0e:419a ???????????????????????? $00
    dw   $8416, $844e, $8483, $84b5, $84e5, $8511, $853b, $8563, $8589, $85ac, $85ce, $85ed ;; 0e:41b2 w.wWwW??wWw.wWwWwWwWwWwW $01
    dw   $860b, $8627, $8642, $865b, $8672, $8689, $869e, $86b2, $86c4, $86d6, $86e7, $86f7 ;; 0e:41ca wWwWwWwWwWwWwWwWwWwWwWwW $02
    dw   $8706, $8714, $8721, $872d, $8739, $8744, $874f, $8759, $8762, $876b, $8773, $877b ;; 0e:41e2 wWwWwWwWwWwWwWwWwWwWwWwW $03
    dw   $8783, $878a, $8790, $8797, $879d, $87a2, $87a7, $87ac, $87b1, $87b6, $87ba, $87be ;; 0e:41fa wW??wW?????????????????? $04
    dw   $87c1, $87c5, $87c8, $87cb, $87ce, $87d1, $87d4, $87d6, $87d9, $87db, $87dd, $87df ;; 0e:4212 ???????????????????????? $05
    dw   $87e1, $87e2, $87e4, $87e6, $87e7, $87e9, $87ea, $87eb, $87ec, $87ed, $87ee, $87ef ;; 0e:422a ???????????????????????? $06
    db   $f0, $87                                      ;; 0e:4242 ??

musicNoteDurations:
    db   $60, $48, $30, $20, $24, $18, $10, $12        ;; 0e:4244 ...?....
    db   $0c, $08, $06, $04, $03                       ;; 0e:424c .....

musicPlayStep:
    ld   A, [wMusicTempoTimeCounter]                   ;; 0e:4251 $fa $00 $cb
    ld   B, A                                          ;; 0e:4254 $47
    ld   A, [wMusicTempo]                              ;; 0e:4255 $fa $01 $cb
    add  A, B                                          ;; 0e:4258 $80
    ld   [wMusicTempoTimeCounter], A                   ;; 0e:4259 $ea $00 $cb
    jr   NC, .vibratoAndVolume                         ;; 0e:425c $30 $06
    call musicTempoPlayNotes                           ;; 0e:425e $cd $81 $42
    call musicTempoPlayNotes                           ;; 0e:4261 $cd $81 $42
.vibratoAndVolume:
    ldh  A, [hVibratoVolumeChannelSelection]           ;; 0e:4264 $f0 $b4
    inc  A                                             ;; 0e:4266 $3c
    cp   A, $03                                        ;; 0e:4267 $fe $03
    jr   NZ, .vibratoAndVolumeSingleChannel            ;; 0e:4269 $20 $01
    xor  A, A                                          ;; 0e:426b $af
.vibratoAndVolumeSingleChannel:
    ldh  [hVibratoVolumeChannelSelection], A           ;; 0e:426c $e0 $b4
    or   A, A                                          ;; 0e:426e $b7
    call Z, musicVibratoAndVolumeChannel2              ;; 0e:426f $cc $d3 $47
    ldh  A, [hVibratoVolumeChannelSelection]           ;; 0e:4272 $f0 $b4
    cp   A, $01                                        ;; 0e:4274 $fe $01
    call Z, musicVibratoAndVolumeChannel1              ;; 0e:4276 $cc $4d $48
    ldh  A, [hVibratoVolumeChannelSelection]           ;; 0e:4279 $f0 $b4
    cp   A, $02                                        ;; 0e:427b $fe $02
    call Z, musicVibratoAndVolumeChannel3              ;; 0e:427d $cc $c7 $48
    ret                                                ;; 0e:4280 $c9

musicTempoPlayNotes:
    ld   A, [wMusicEndedOnChannel2]                    ;; 0e:4281 $fa $13 $cb
    cp   A, $ff                                        ;; 0e:4284 $fe $ff
    jp   Z, musicTempoPlayNotes_Channel1               ;; 0e:4286 $ca $cc $44
    ld   A, [wMusicNoteDurationChannel2]               ;; 0e:4289 $fa $03 $cb
    dec  A                                             ;; 0e:428c $3d
    ld   [wMusicNoteDurationChannel2], A               ;; 0e:428d $ea $03 $cb
    ldh  [hMusicNoteDurationChannel2Copy], A           ;; 0e:4290 $e0 $b5
    jp   NZ, musicTempoPlayNotes_Channel1              ;; 0e:4292 $c2 $cc $44
.nextMusicInstruction:
    call getNextMusicInstructionChannel2               ;; 0e:4295 $cd $bd $47
    ld   E, A                                          ;; 0e:4298 $5f
    cp   A, $d0                                        ;; 0e:4299 $fe $d0
    jr   NC, .notNote                                  ;; 0e:429b $30 $6a
    and  A, $f0                                        ;; 0e:429d $e6 $f0
    swap A                                             ;; 0e:429f $cb $37
    ld   C, A                                          ;; 0e:42a1 $4f
    ld   HL, musicNoteDurations                        ;; 0e:42a2 $21 $44 $42
    ld   B, $00                                        ;; 0e:42a5 $06 $00
    add  HL, BC                                        ;; 0e:42a7 $09
    ld   A, [HL]                                       ;; 0e:42a8 $7e
    ld   [wMusicNoteDurationChannel2], A               ;; 0e:42a9 $ea $03 $cb
    ld   A, E                                          ;; 0e:42ac $7b
    and  A, $0f                                        ;; 0e:42ad $e6 $0f
    ld   [wMusicNotePitchChannel2], A                  ;; 0e:42af $ea $11 $cb
    cp   A, $0e                                        ;; 0e:42b2 $fe $0e
    jp   Z, musicTempoPlayNotes_Channel1               ;; 0e:42b4 $ca $cc $44
    cp   A, $0f                                        ;; 0e:42b7 $fe $0f
    jr   NZ, .playNote                                 ;; 0e:42b9 $20 $0b
    ld   A, $ff                                        ;; 0e:42bb $3e $ff
    ldh  [rNR23], A                                    ;; 0e:42bd $e0 $18
    ld   A, $07                                        ;; 0e:42bf $3e $07
    ldh  [rNR24], A                                    ;; 0e:42c1 $e0 $19
    jp   musicTempoPlayNotes_Channel1                  ;; 0e:42c3 $c3 $cc $44
.playNote:
    add  A, A                                          ;; 0e:42c6 $87
    ld   E, A                                          ;; 0e:42c7 $5f
    ld   A, [wMusicOctaveChannel2]                     ;; 0e:42c8 $fa $0b $cb
    add  A, E                                          ;; 0e:42cb $83
    ld   E, A                                          ;; 0e:42cc $5f
    ld   D, $00                                        ;; 0e:42cd $16 $00
    ld   HL, musicNoteFrequencies                      ;; 0e:42cf $21 $9a $41
    add  HL, DE                                        ;; 0e:42d2 $19
    push HL                                            ;; 0e:42d3 $e5
    ld   A, [wMusicVolumeEnvelopeChannel2]             ;; 0e:42d4 $fa $15 $cb
    ld   L, A                                          ;; 0e:42d7 $6f
    ld   A, [wMusicVolumeEnvelopeChannel2.high]        ;; 0e:42d8 $fa $16 $cb
    ld   H, A                                          ;; 0e:42db $67
    ld   A, [HL+]                                      ;; 0e:42dc $2a
    ld   [wMusicVolumeDurationChannel2], A             ;; 0e:42dd $ea $14 $cb
    ld   A, [HL+]                                      ;; 0e:42e0 $2a
    ldh  [rNR22], A                                    ;; 0e:42e1 $e0 $17
    ld   A, L                                          ;; 0e:42e3 $7d
    ld   A, [wMusicVolumeEnvelopePointerChannel2]      ;; 0e:42e4 $fa $17 $cb
    ld   A, H                                          ;; 0e:42e7 $7c
    ld   A, [wMusicVolumeEnvelopePointerChannel2.high] ;; 0e:42e8 $fa $18 $cb
    pop  HL                                            ;; 0e:42eb $e1
    ld   A, [HL+]                                      ;; 0e:42ec $2a
    ldh  [rNR23], A                                    ;; 0e:42ed $e0 $18
    ld   [wMusicCurrentPitchChannel2], A               ;; 0e:42ef $ea $0d $cb
    ld   A, [HL]                                       ;; 0e:42f2 $7e
    ldh  [rNR24], A                                    ;; 0e:42f3 $e0 $19
    ld   [wMusicCurrentPitchChannel2.high], A          ;; 0e:42f5 $ea $0e $cb
    ld   HL, wMusicVibratoDurationChannel2             ;; 0e:42f8 $21 $06 $cb
    call musicStartEnvelope                            ;; 0e:42fb $cd $ac $47
    ld   HL, wMusicVolumeDurationChannel2              ;; 0e:42fe $21 $14 $cb
    call musicStartEnvelope                            ;; 0e:4301 $cd $ac $47
    jp   musicTempoPlayNotes_Channel1                  ;; 0e:4304 $c3 $cc $44
.notNote:
    cp   A, $ff                                        ;; 0e:4307 $fe $ff
    jr   NZ, .notTerminator                            ;; 0e:4309 $20 $0c
    ld   [wMusicEndedOnChannel2], A                    ;; 0e:430b $ea $13 $cb
    ldh  [rNR23], A                                    ;; 0e:430e $e0 $18
    ld   A, $07                                        ;; 0e:4310 $3e $07
    ldh  [rNR24], A                                    ;; 0e:4312 $e0 $19
    jp   musicTempoPlayNotes_Channel1                  ;; 0e:4314 $c3 $cc $44
.notTerminator:
    cp   A, $e0                                        ;; 0e:4317 $fe $e0
    jr   NC, .opCode                                   ;; 0e:4319 $30 $26
    bit  3, A                                          ;; 0e:431b $cb $5f
    jr   NZ, .relativeOctave                           ;; 0e:431d $20 $0e
    and  A, $07                                        ;; 0e:431f $e6 $07
    add  A, A                                          ;; 0e:4321 $87
    add  A, A                                          ;; 0e:4322 $87
    add  A, A                                          ;; 0e:4323 $87
    ld   E, A                                          ;; 0e:4324 $5f
    add  A, A                                          ;; 0e:4325 $87
    add  A, E                                          ;; 0e:4326 $83
    ld   [wMusicOctaveChannel2], A                     ;; 0e:4327 $ea $0b $cb
    jp   .nextMusicInstruction                         ;; 0e:432a $c3 $95 $42
.relativeOctave:
    and  A, $07                                        ;; 0e:432d $e6 $07
    ld   E, A                                          ;; 0e:432f $5f
    ld   D, $00                                        ;; 0e:4330 $16 $00
    ld   HL, musicOctaveRelatvieOffsets                ;; 0e:4332 $21 $b5 $47
    add  HL, DE                                        ;; 0e:4335 $19
    ld   E, [HL]                                       ;; 0e:4336 $5e
    ld   A, [wMusicOctaveChannel2]                     ;; 0e:4337 $fa $0b $cb
    add  A, E                                          ;; 0e:433a $83
    ld   [wMusicOctaveChannel2], A                     ;; 0e:433b $ea $0b $cb
    jp   .nextMusicInstruction                         ;; 0e:433e $c3 $95 $42
.opCode:
    and  A, $0f                                        ;; 0e:4341 $e6 $0f
    add  A, A                                          ;; 0e:4343 $87
    ld   HL, musicOpCodeTableChannel2                  ;; 0e:4344 $21 $58 $43
    ld   E, A                                          ;; 0e:4347 $5f
    ld   D, $00                                        ;; 0e:4348 $16 $00
    add  HL, DE                                        ;; 0e:434a $19
    call musicCallOpCode                               ;; 0e:434b $cd $51 $43
    jp   .nextMusicInstruction                         ;; 0e:434e $c3 $95 $42

musicCallOpCode:
    ld   A, [HL+]                                      ;; 0e:4351 $2a
    ld   E, A                                          ;; 0e:4352 $5f
    ld   A, [HL]                                       ;; 0e:4353 $7e
    ld   H, A                                          ;; 0e:4354 $67
    ld   L, E                                          ;; 0e:4355 $6b
    jp   HL                                            ;; 0e:4356 $e9

musicOpCodeNop:
    ret                                                ;; 0e:4357 $c9

;@jumptable
musicOpCodeTableChannel2:
    dw   musicOpCodeSetChannel2VolumeEnvelope          ;; 0e:4358 pP $00
    dw   musicOpCodeChannel2Jump                       ;; 0e:435a pP $01
    dw   musicOpCodeChannel2LoopCounter1               ;; 0e:435c pP $02
    dw   musicOpCodeSetChannel2LoopCounter1            ;; 0e:435e pP $03
    dw   musicOpCodeSetChannel2VibratoEnvelope         ;; 0e:4360 pP $04
    dw   musicChannel2SetDutyCycle                     ;; 0e:4362 pP $05
    dw   musicOpCodeSetChannel2StereoPan               ;; 0e:4364 pP $06
    dw   musicOpCodeSetTempo                           ;; 0e:4366 pP $07
    dw   musicOpCodeNop                                ;; 0e:4368 ?? $08
    dw   musicOpCodeChannel2LoopCounter2               ;; 0e:436a ?? $09
    dw   musicOpCodeSetChannel2LoopCounter2            ;; 0e:436c ?? $0a
    dw   musicOpCodeIfChannel2LoopCounter1Equal        ;; 0e:436e pP $0b

musicOpCodeSetChannel2VolumeEnvelope:
    ld   HL, wMusicInstructionPointerChannel2          ;; 0e:4370 $21 $04 $cb
    ld   E, [HL]                                       ;; 0e:4373 $5e
    inc  HL                                            ;; 0e:4374 $23
    ld   D, [HL]                                       ;; 0e:4375 $56
    ld   A, [DE]                                       ;; 0e:4376 $1a
    ld   C, A                                          ;; 0e:4377 $4f
    inc  DE                                            ;; 0e:4378 $13
    ld   A, [DE]                                       ;; 0e:4379 $1a
    inc  DE                                            ;; 0e:437a $13
    ld   [wMusicVolumeEnvelopeChannel2.high], A        ;; 0e:437b $ea $16 $cb
    ld   [wMusicVolumeEnvelopePointerChannel2.high], A ;; 0e:437e $ea $18 $cb
    ld   A, C                                          ;; 0e:4381 $79
    ld   [wMusicVolumeEnvelopeChannel2], A             ;; 0e:4382 $ea $15 $cb
    ld   [wMusicVolumeEnvelopePointerChannel2], A      ;; 0e:4385 $ea $17 $cb
    ld   A, E                                          ;; 0e:4388 $7b
    ld   [wMusicInstructionPointerChannel2], A         ;; 0e:4389 $ea $04 $cb
    ld   A, D                                          ;; 0e:438c $7a
    ld   [wMusicInstructionPointerChannel2.high], A    ;; 0e:438d $ea $05 $cb
    ret                                                ;; 0e:4390 $c9

musicOpCodeChannel2Jump:
    ld   HL, wMusicInstructionPointerChannel2          ;; 0e:4391 $21 $04 $cb
    ld   E, [HL]                                       ;; 0e:4394 $5e
    inc  HL                                            ;; 0e:4395 $23
    ld   D, [HL]                                       ;; 0e:4396 $56
    ld   A, [DE]                                       ;; 0e:4397 $1a
    inc  DE                                            ;; 0e:4398 $13
    ld   [wMusicInstructionPointerChannel2], A         ;; 0e:4399 $ea $04 $cb
    ld   A, [DE]                                       ;; 0e:439c $1a
    ld   [wMusicInstructionPointerChannel2.high], A    ;; 0e:439d $ea $05 $cb
    ret                                                ;; 0e:43a0 $c9

musicOpCodeChannel2LoopCounter1:
    ld   HL, wMusicInstructionPointerChannel2          ;; 0e:43a1 $21 $04 $cb
    call musicGetLoopTarget                            ;; 0e:43a4 $cd $01 $44
    ld   B, A                                          ;; 0e:43a7 $47
    ld   A, [wMusicLoopCounter1Channel2]               ;; 0e:43a8 $fa $0f $cb
    dec  A                                             ;; 0e:43ab $3d
    ld   [wMusicLoopCounter1Channel2], A               ;; 0e:43ac $ea $0f $cb
    jr   jumpIfCondition                               ;; 0e:43af $18 $59

musicOpCodeChannel1LoopCounter1:
    ld   HL, wMusicInstructionPointerChannel1          ;; 0e:43b1 $21 $1c $cb
    call musicGetLoopTarget                            ;; 0e:43b4 $cd $01 $44
    ld   B, A                                          ;; 0e:43b7 $47
    ld   A, [wMusicLoopCounter1Channel1]               ;; 0e:43b8 $fa $27 $cb
    dec  A                                             ;; 0e:43bb $3d
    ld   [wMusicLoopCounter1Channel1], A               ;; 0e:43bc $ea $27 $cb
    jr   jumpIfCondition                               ;; 0e:43bf $18 $49

musicOpCodeChannel3LoopCounter1:
    ld   HL, wMusicInstructionPointerChannel3          ;; 0e:43c1 $21 $34 $cb
    call musicGetLoopTarget                            ;; 0e:43c4 $cd $01 $44
    ld   B, A                                          ;; 0e:43c7 $47
    ld   A, [wMusicLoopCounter1Channel3]               ;; 0e:43c8 $fa $3f $cb
    dec  A                                             ;; 0e:43cb $3d
    ld   [wMusicLoopCounter1Channel3], A               ;; 0e:43cc $ea $3f $cb
    jr   jumpIfCondition                               ;; 0e:43cf $18 $39

musicOpCodeChannel2LoopCounter2:
    ld   HL, wMusicInstructionPointerChannel2          ;; 0e:43d1 $21 $04 $cb
    call musicGetLoopTarget                            ;; 0e:43d4 $cd $01 $44
    ld   B, A                                          ;; 0e:43d7 $47
    ld   A, [wMusicLoopCounter2Channel2]               ;; 0e:43d8 $fa $19 $cb
    dec  A                                             ;; 0e:43db $3d
    ld   [wMusicLoopCounter2Channel2], A               ;; 0e:43dc $ea $19 $cb
    jr   jumpIfCondition                               ;; 0e:43df $18 $29

musicOpCodeChannel1LoopCounter2:
    ld   HL, wMusicInstructionPointerChannel1          ;; 0e:43e1 $21 $1c $cb
    call musicGetLoopTarget                            ;; 0e:43e4 $cd $01 $44
    ld   B, A                                          ;; 0e:43e7 $47
    ld   A, [wMusicLoopCounter2Channel1]               ;; 0e:43e8 $fa $31 $cb
    dec  A                                             ;; 0e:43eb $3d
    ld   [wMusicLoopCounter2Channel1], A               ;; 0e:43ec $ea $31 $cb
    jr   jumpIfCondition                               ;; 0e:43ef $18 $19

musicOpCodeChannel3LoopCounter2:
    ld   HL, wMusicInstructionPointerChannel3          ;; 0e:43f1 $21 $34 $cb
    call musicGetLoopTarget                            ;; 0e:43f4 $cd $01 $44
    ld   B, A                                          ;; 0e:43f7 $47
    ld   A, [wMusicLoopCounter2Channel3]               ;; 0e:43f8 $fa $49 $cb
    dec  A                                             ;; 0e:43fb $3d
    ld   [wMusicLoopCounter2Channel3], A               ;; 0e:43fc $ea $49 $cb
    jr   jumpIfCondition                               ;; 0e:43ff $18 $09

musicGetLoopTarget:
    ld   E, [HL]                                       ;; 0e:4401 $5e
    inc  HL                                            ;; 0e:4402 $23
    ld   D, [HL]                                       ;; 0e:4403 $56
    ld   A, [DE]                                       ;; 0e:4404 $1a
    ld   C, A                                          ;; 0e:4405 $4f
    inc  DE                                            ;; 0e:4406 $13
    ld   A, [DE]                                       ;; 0e:4407 $1a
    inc  DE                                            ;; 0e:4408 $13
    ret                                                ;; 0e:4409 $c9

jumpIfCondition:
    jr   NZ, .true                                     ;; 0e:440a $20 $04
    ld   [HL], D                                       ;; 0e:440c $72
    dec  HL                                            ;; 0e:440d $2b
    ld   [HL], E                                       ;; 0e:440e $73
    ret                                                ;; 0e:440f $c9
.true:
    ld   [HL], B                                       ;; 0e:4410 $70
    dec  HL                                            ;; 0e:4411 $2b
    ld   [HL], C                                       ;; 0e:4412 $71
    ret                                                ;; 0e:4413 $c9

musicOpCodeIfChannel2LoopCounter1Equal:
    call getNextMusicInstructionChannel2               ;; 0e:4414 $cd $bd $47
    ld   C, A                                          ;; 0e:4417 $4f
    ld   A, [wMusicInstructionPointerChannel2]         ;; 0e:4418 $fa $04 $cb
    ld   L, A                                          ;; 0e:441b $6f
    ld   A, [wMusicInstructionPointerChannel2.high]    ;; 0e:441c $fa $05 $cb
    ld   H, A                                          ;; 0e:441f $67
    ld   A, [HL+]                                      ;; 0e:4420 $2a
    ld   E, A                                          ;; 0e:4421 $5f
    ld   A, [HL+]                                      ;; 0e:4422 $2a
    ld   D, A                                          ;; 0e:4423 $57
    ld   A, [wMusicLoopCounter1Channel2]               ;; 0e:4424 $fa $0f $cb
    cp   A, C                                          ;; 0e:4427 $b9
    jr   NZ, .write                                    ;; 0e:4428 $20 $02
    push DE                                            ;; 0e:442a $d5
    pop  HL                                            ;; 0e:442b $e1
.write:
    ld   A, L                                          ;; 0e:442c $7d
    ld   [wMusicInstructionPointerChannel2], A         ;; 0e:442d $ea $04 $cb
    ld   A, H                                          ;; 0e:4430 $7c
    ld   [wMusicInstructionPointerChannel2.high], A    ;; 0e:4431 $ea $05 $cb
    ret                                                ;; 0e:4434 $c9

musicOpCodeIfChannel1LoopCounter1Equal:
    call getNextMusicInstructionChannel1               ;; 0e:4435 $cd $c9 $47
    ld   C, A                                          ;; 0e:4438 $4f
    ld   A, [wMusicInstructionPointerChannel1]         ;; 0e:4439 $fa $1c $cb
    ld   L, A                                          ;; 0e:443c $6f
    ld   A, [wMusicInstructionPointerChannel1.high]    ;; 0e:443d $fa $1d $cb
    ld   H, A                                          ;; 0e:4440 $67
    ld   A, [HL+]                                      ;; 0e:4441 $2a
    ld   E, A                                          ;; 0e:4442 $5f
    ld   A, [HL+]                                      ;; 0e:4443 $2a
    ld   D, A                                          ;; 0e:4444 $57
    ld   A, [wMusicLoopCounter1Channel1]               ;; 0e:4445 $fa $27 $cb
    cp   A, C                                          ;; 0e:4448 $b9
    jr   NZ, .write                                    ;; 0e:4449 $20 $02
    push DE                                            ;; 0e:444b $d5
    pop  HL                                            ;; 0e:444c $e1
.write:
    ld   A, L                                          ;; 0e:444d $7d
    ld   [wMusicInstructionPointerChannel1], A         ;; 0e:444e $ea $1c $cb
    ld   A, H                                          ;; 0e:4451 $7c
    ld   [wMusicInstructionPointerChannel1.high], A    ;; 0e:4452 $ea $1d $cb
    ret                                                ;; 0e:4455 $c9

musicOpCodeIfChannel3LoopCounter1Equal:
    call getNextMusicInstructionChannel3               ;; 0e:4456 $cd $ce $47
    ld   C, A                                          ;; 0e:4459 $4f
    ld   A, [wMusicInstructionPointerChannel3]         ;; 0e:445a $fa $34 $cb
    ld   L, A                                          ;; 0e:445d $6f
    ld   A, [wMusicInstructionPointerChannel3.high]    ;; 0e:445e $fa $35 $cb
    ld   H, A                                          ;; 0e:4461 $67
    ld   A, [HL+]                                      ;; 0e:4462 $2a
    ld   E, A                                          ;; 0e:4463 $5f
    ld   A, [HL+]                                      ;; 0e:4464 $2a
    ld   D, A                                          ;; 0e:4465 $57
    ld   A, [wMusicLoopCounter1Channel3]               ;; 0e:4466 $fa $3f $cb
    cp   A, C                                          ;; 0e:4469 $b9
    jr   NZ, .write                                    ;; 0e:446a $20 $02
    push DE                                            ;; 0e:446c $d5
    pop  HL                                            ;; 0e:446d $e1
.write:
    ld   A, L                                          ;; 0e:446e $7d
    ld   [wMusicInstructionPointerChannel3], A         ;; 0e:446f $ea $34 $cb
    ld   A, H                                          ;; 0e:4472 $7c
    ld   [wMusicInstructionPointerChannel3.high], A    ;; 0e:4473 $ea $35 $cb
    ret                                                ;; 0e:4476 $c9

musicOpCodeSetChannel2LoopCounter1:
    call getNextMusicInstructionChannel2               ;; 0e:4477 $cd $bd $47
    ld   [wMusicLoopCounter1Channel2], A               ;; 0e:447a $ea $0f $cb
    ret                                                ;; 0e:447d $c9

musicOpCodeSetChannel2LoopCounter2:
    call getNextMusicInstructionChannel2               ;; 0e:447e $cd $bd $47
    ld   [wMusicLoopCounter2Channel2], A               ;; 0e:4481 $ea $19 $cb
    ret                                                ;; 0e:4484 $c9

musicOpCodeSetChannel2VibratoEnvelope:
    ld   HL, wMusicInstructionPointerChannel2          ;; 0e:4485 $21 $04 $cb
    ld   E, [HL]                                       ;; 0e:4488 $5e
    inc  HL                                            ;; 0e:4489 $23
    ld   D, [HL]                                       ;; 0e:448a $56
    ld   A, [DE]                                       ;; 0e:448b $1a
    ld   C, A                                          ;; 0e:448c $4f
    inc  DE                                            ;; 0e:448d $13
    ld   A, [DE]                                       ;; 0e:448e $1a
    inc  DE                                            ;; 0e:448f $13
    ld   [wMusicVibratoEnvelopeChannel2.high], A       ;; 0e:4490 $ea $08 $cb
    ld   [wMusicVibratoEnvelopePointerChannel2.high], A ;; 0e:4493 $ea $0a $cb
    ld   A, C                                          ;; 0e:4496 $79
    ld   [wMusicVibratoEnvelopeChannel2], A            ;; 0e:4497 $ea $07 $cb
    ld   [wMusicVibratoEnvelopePointerChannel2], A     ;; 0e:449a $ea $09 $cb
    ld   A, E                                          ;; 0e:449d $7b
    ld   [wMusicInstructionPointerChannel2], A         ;; 0e:449e $ea $04 $cb
    ld   A, D                                          ;; 0e:44a1 $7a
    ld   [wMusicInstructionPointerChannel2.high], A    ;; 0e:44a2 $ea $05 $cb
    ret                                                ;; 0e:44a5 $c9

musicChannel2SetDutyCycle:
    call getNextMusicInstructionChannel2               ;; 0e:44a6 $cd $bd $47
    ldh  [rNR21], A                                    ;; 0e:44a9 $e0 $16
    ld   [wMusicNR21DutyCycleChannel2], A              ;; 0e:44ab $ea $0c $cb
    ret                                                ;; 0e:44ae $c9

musicOpCodeSetChannel2StereoPan:
    call getNextMusicInstructionChannel2               ;; 0e:44af $cd $bd $47
    ld   E, A                                          ;; 0e:44b2 $5f
    ld   D, $00                                        ;; 0e:44b3 $16 $00
    ld   HL, channel2StereoPanValues                   ;; 0e:44b5 $21 $48 $46
    add  HL, DE                                        ;; 0e:44b8 $19
    ldh  A, [rNR51]                                    ;; 0e:44b9 $f0 $25
    and  A, $dd                                        ;; 0e:44bb $e6 $dd
    or   A, [HL]                                       ;; 0e:44bd $b6
    ldh  [rNR51], A                                    ;; 0e:44be $e0 $25
    ret                                                ;; 0e:44c0 $c9

channel1StereoPanValues:
    db   $00, $01, $10, $11                            ;; 0e:44c1 ?...

musicOpCodeSetTempo:
    call getNextMusicInstructionChannel2               ;; 0e:44c5 $cd $bd $47
    ld   [wMusicTempo], A                              ;; 0e:44c8 $ea $01 $cb
    ret                                                ;; 0e:44cb $c9

musicTempoPlayNotes_Channel1:
    ld   A, [wMusicEndedOnChannel1]                    ;; 0e:44cc $fa $2b $cb
    cp   A, $ff                                        ;; 0e:44cf $fe $ff
    jp   Z, musicTempoPlayNotes_Channel3               ;; 0e:44d1 $ca $4c $46
    ld   A, [wMusicNoteDurationChannel1]               ;; 0e:44d4 $fa $1b $cb
    dec  A                                             ;; 0e:44d7 $3d
    ld   [wMusicNoteDurationChannel1], A               ;; 0e:44d8 $ea $1b $cb
    ldh  [hMusicNoteDurationChannel1Copy], A           ;; 0e:44db $e0 $b6
    jp   NZ, musicTempoPlayNotes_Channel3              ;; 0e:44dd $c2 $4c $46
.nextMusicInstruction:
    call getNextMusicInstructionChannel1               ;; 0e:44e0 $cd $c9 $47
    ld   E, A                                          ;; 0e:44e3 $5f
    cp   A, $d0                                        ;; 0e:44e4 $fe $d0
    jr   NC, .notNote                                  ;; 0e:44e6 $30 $73
    and  A, $f0                                        ;; 0e:44e8 $e6 $f0
    swap A                                             ;; 0e:44ea $cb $37
    ld   C, A                                          ;; 0e:44ec $4f
    ld   HL, musicNoteDurations                        ;; 0e:44ed $21 $44 $42
    ld   B, $00                                        ;; 0e:44f0 $06 $00
    add  HL, BC                                        ;; 0e:44f2 $09
    ld   A, [HL]                                       ;; 0e:44f3 $7e
    ld   [wMusicNoteDurationChannel1], A               ;; 0e:44f4 $ea $1b $cb
    ld   A, E                                          ;; 0e:44f7 $7b
    and  A, $0f                                        ;; 0e:44f8 $e6 $0f
    ld   [wMusicNotePitchChannel1], A                  ;; 0e:44fa $ea $29 $cb
    cp   A, $0e                                        ;; 0e:44fd $fe $0e
    jp   Z, musicTempoPlayNotes_Channel3               ;; 0e:44ff $ca $4c $46
    ld   C, A                                          ;; 0e:4502 $4f
    ld   A, [wSoundEffectDurationChannel1]             ;; 0e:4503 $fa $1a $cb
    or   A, A                                          ;; 0e:4506 $b7
    jp   NZ, musicTempoPlayNotes_Channel3              ;; 0e:4507 $c2 $4c $46
    ld   A, C                                          ;; 0e:450a $79
    cp   A, $0f                                        ;; 0e:450b $fe $0f
    jr   NZ, .playNote                                 ;; 0e:450d $20 $0b
    ld   A, $ff                                        ;; 0e:450f $3e $ff
    ldh  [rNR13], A                                    ;; 0e:4511 $e0 $13
    ld   A, $07                                        ;; 0e:4513 $3e $07
    ldh  [rNR14], A                                    ;; 0e:4515 $e0 $14
    jp   musicTempoPlayNotes_Channel3                  ;; 0e:4517 $c3 $4c $46
.playNote:
    add  A, A                                          ;; 0e:451a $87
    ld   E, A                                          ;; 0e:451b $5f
    ld   A, [wMusicOctaveChannel1]                     ;; 0e:451c $fa $23 $cb
    add  A, E                                          ;; 0e:451f $83
    ld   E, A                                          ;; 0e:4520 $5f
    ld   D, $00                                        ;; 0e:4521 $16 $00
    ld   HL, musicNoteFrequencies                      ;; 0e:4523 $21 $9a $41
    add  HL, DE                                        ;; 0e:4526 $19
    push HL                                            ;; 0e:4527 $e5
    ld   A, [wMusicVolumeEnvelopeChannel1]             ;; 0e:4528 $fa $2d $cb
    ld   L, A                                          ;; 0e:452b $6f
    ld   A, [wMusicVolumeEnvelopeChannel1.high]        ;; 0e:452c $fa $2e $cb
    ld   H, A                                          ;; 0e:452f $67
    ld   A, [HL+]                                      ;; 0e:4530 $2a
    ld   [wMusicVolumeDurationChannel1], A             ;; 0e:4531 $ea $2c $cb
    ld   A, [HL+]                                      ;; 0e:4534 $2a
    ldh  [rNR12], A                                    ;; 0e:4535 $e0 $12
    ld   A, L                                          ;; 0e:4537 $7d
    ld   A, [wMusicVolumeEnvelopePointerChannel1]      ;; 0e:4538 $fa $2f $cb
    ld   A, H                                          ;; 0e:453b $7c
    ld   A, [wMusicVolumeEnvelopePointerChannel1.high] ;; 0e:453c $fa $30 $cb
    pop  HL                                            ;; 0e:453f $e1
    ld   A, [HL+]                                      ;; 0e:4540 $2a
    ldh  [rNR13], A                                    ;; 0e:4541 $e0 $13
    ld   [wMusicCurrentPitchChannel1], A               ;; 0e:4543 $ea $25 $cb
    ld   A, [HL]                                       ;; 0e:4546 $7e
    ldh  [rNR14], A                                    ;; 0e:4547 $e0 $14
    ld   [wMusicCurrentPitchChannel1.high], A          ;; 0e:4549 $ea $26 $cb
    ld   HL, wMusicVibratoDurationChannel1             ;; 0e:454c $21 $1e $cb
    call musicStartEnvelope                            ;; 0e:454f $cd $ac $47
    ld   HL, wMusicVolumeDurationChannel1              ;; 0e:4552 $21 $2c $cb
    call musicStartEnvelope                            ;; 0e:4555 $cd $ac $47
    jp   musicTempoPlayNotes_Channel3                  ;; 0e:4558 $c3 $4c $46
.notNote:
    cp   A, $ff                                        ;; 0e:455b $fe $ff
    jr   NZ, .notTerminator                            ;; 0e:455d $20 $0c
    ld   [wMusicEndedOnChannel1], A                    ;; 0e:455f $ea $2b $cb
    ldh  [rNR23], A                                    ;; 0e:4562 $e0 $18
    ld   A, $07                                        ;; 0e:4564 $3e $07
    ldh  [rNR24], A                                    ;; 0e:4566 $e0 $19
    jp   musicTempoPlayNotes_Channel3                  ;; 0e:4568 $c3 $4c $46
.notTerminator:
    cp   A, $e0                                        ;; 0e:456b $fe $e0
    jr   NC, .opCode                                   ;; 0e:456d $30 $26
    bit  3, A                                          ;; 0e:456f $cb $5f
    jr   NZ, .relativeOctave                           ;; 0e:4571 $20 $0e
    and  A, $07                                        ;; 0e:4573 $e6 $07
    add  A, A                                          ;; 0e:4575 $87
    add  A, A                                          ;; 0e:4576 $87
    add  A, A                                          ;; 0e:4577 $87
    ld   E, A                                          ;; 0e:4578 $5f
    add  A, A                                          ;; 0e:4579 $87
    add  A, E                                          ;; 0e:457a $83
    ld   [wMusicOctaveChannel1], A                     ;; 0e:457b $ea $23 $cb
    jp   .nextMusicInstruction                         ;; 0e:457e $c3 $e0 $44
.relativeOctave:
    and  A, $07                                        ;; 0e:4581 $e6 $07
    ld   E, A                                          ;; 0e:4583 $5f
    ld   D, $00                                        ;; 0e:4584 $16 $00
    ld   HL, musicOctaveRelatvieOffsets                ;; 0e:4586 $21 $b5 $47
    add  HL, DE                                        ;; 0e:4589 $19
    ld   E, [HL]                                       ;; 0e:458a $5e
    ld   A, [wMusicOctaveChannel1]                     ;; 0e:458b $fa $23 $cb
    add  A, E                                          ;; 0e:458e $83
    ld   [wMusicOctaveChannel1], A                     ;; 0e:458f $ea $23 $cb
    jp   .nextMusicInstruction                         ;; 0e:4592 $c3 $e0 $44
.opCode:
    and  A, $0f                                        ;; 0e:4595 $e6 $0f
    add  A, A                                          ;; 0e:4597 $87
    ld   HL, musicOpCodeTableChannel1                  ;; 0e:4598 $21 $ab $45
    ld   E, A                                          ;; 0e:459b $5f
    ld   D, $00                                        ;; 0e:459c $16 $00
    add  HL, DE                                        ;; 0e:459e $19
    call musicCallOpCode_DupChannel1                   ;; 0e:459f $cd $a5 $45
    jp   .nextMusicInstruction                         ;; 0e:45a2 $c3 $e0 $44

musicCallOpCode_DupChannel1:
    ld   A, [HL+]                                      ;; 0e:45a5 $2a
    ld   E, A                                          ;; 0e:45a6 $5f
    ld   A, [HL]                                       ;; 0e:45a7 $7e
    ld   H, A                                          ;; 0e:45a8 $67
    ld   L, E                                          ;; 0e:45a9 $6b
    jp   HL                                            ;; 0e:45aa $e9

;@jumptable
musicOpCodeTableChannel1:
    dw   musicOpCodeSetChannel1VolumeEnvelope          ;; 0e:45ab pP $00
    dw   musicOpCodeChannel1Jump                       ;; 0e:45ad pP $01
    dw   musicOpCodeChannel1LoopCounter1               ;; 0e:45af pP $02
    dw   musicOpCodeSetChannel1LoopCounter1            ;; 0e:45b1 pP $03
    dw   musicOpCodeSetChannel1VibratoEnvelope         ;; 0e:45b3 pP $04
    dw   musicChannel1SetDutyCycle                     ;; 0e:45b5 pP $05
    dw   musicOpCodeSetChannel1StereoPan               ;; 0e:45b7 pP $06
    dw   musicOpCodeNop                                ;; 0e:45b9 ?? $07
    dw   musicOpCodeNop                                ;; 0e:45bb ?? $08
    dw   musicOpCodeChannel1LoopCounter2               ;; 0e:45bd ?? $09
    dw   musicOpCodeSetChannel1LoopCounter2            ;; 0e:45bf ?? $0a
    dw   musicOpCodeIfChannel1LoopCounter1Equal        ;; 0e:45c1 pP $0b

musicOpCodeSetChannel1VolumeEnvelope:
    ld   HL, wMusicInstructionPointerChannel1          ;; 0e:45c3 $21 $1c $cb
    ld   E, [HL]                                       ;; 0e:45c6 $5e
    inc  HL                                            ;; 0e:45c7 $23
    ld   D, [HL]                                       ;; 0e:45c8 $56
    ld   A, [DE]                                       ;; 0e:45c9 $1a
    ld   C, A                                          ;; 0e:45ca $4f
    inc  DE                                            ;; 0e:45cb $13
    ld   A, [DE]                                       ;; 0e:45cc $1a
    inc  DE                                            ;; 0e:45cd $13
    ld   [wMusicVolumeEnvelopeChannel1.high], A        ;; 0e:45ce $ea $2e $cb
    ld   A, C                                          ;; 0e:45d1 $79
    ld   [wMusicVolumeEnvelopeChannel1], A             ;; 0e:45d2 $ea $2d $cb
    ld   A, E                                          ;; 0e:45d5 $7b
    ld   [wMusicInstructionPointerChannel1], A         ;; 0e:45d6 $ea $1c $cb
    ld   A, D                                          ;; 0e:45d9 $7a
    ld   [wMusicInstructionPointerChannel1.high], A    ;; 0e:45da $ea $1d $cb
    ret                                                ;; 0e:45dd $c9

musicOpCodeChannel1Jump:
    ld   HL, wMusicInstructionPointerChannel1          ;; 0e:45de $21 $1c $cb
    ld   E, [HL]                                       ;; 0e:45e1 $5e
    inc  HL                                            ;; 0e:45e2 $23
    ld   D, [HL]                                       ;; 0e:45e3 $56
    ld   A, [DE]                                       ;; 0e:45e4 $1a
    inc  DE                                            ;; 0e:45e5 $13
    ld   [wMusicInstructionPointerChannel1], A         ;; 0e:45e6 $ea $1c $cb
    ld   A, [DE]                                       ;; 0e:45e9 $1a
    ld   [wMusicInstructionPointerChannel1.high], A    ;; 0e:45ea $ea $1d $cb
    ret                                                ;; 0e:45ed $c9

musicOpCodeSetChannel1LoopCounter1:
    call getNextMusicInstructionChannel1               ;; 0e:45ee $cd $c9 $47
    ld   [wMusicLoopCounter1Channel1], A               ;; 0e:45f1 $ea $27 $cb
    ret                                                ;; 0e:45f4 $c9

musicOpCodeSetChannel1LoopCounter2:
    call getNextMusicInstructionChannel1               ;; 0e:45f5 $cd $c9 $47
    ld   [wMusicLoopCounter2Channel1], A               ;; 0e:45f8 $ea $31 $cb
    ret                                                ;; 0e:45fb $c9

musicOpCodeSetChannel1VibratoEnvelope:
    ld   HL, wMusicInstructionPointerChannel1          ;; 0e:45fc $21 $1c $cb
    ld   E, [HL]                                       ;; 0e:45ff $5e
    inc  HL                                            ;; 0e:4600 $23
    ld   D, [HL]                                       ;; 0e:4601 $56
    ld   A, [DE]                                       ;; 0e:4602 $1a
    ld   C, A                                          ;; 0e:4603 $4f
    inc  DE                                            ;; 0e:4604 $13
    ld   A, [DE]                                       ;; 0e:4605 $1a
    inc  DE                                            ;; 0e:4606 $13
    ld   [wMusicVibratoEnvelopeChannel1.high], A       ;; 0e:4607 $ea $20 $cb
    ld   [wMusicVibratoEnvelopePointerChannel1.high], A ;; 0e:460a $ea $22 $cb
    ld   A, C                                          ;; 0e:460d $79
    ld   [wMusicVibratoEnvelopeChannel1], A            ;; 0e:460e $ea $1f $cb
    ld   [wMusicVibratoEnvelopePointerChannel1], A     ;; 0e:4611 $ea $21 $cb
    ld   A, E                                          ;; 0e:4614 $7b
    ld   [wMusicInstructionPointerChannel1], A         ;; 0e:4615 $ea $1c $cb
    ld   A, D                                          ;; 0e:4618 $7a
    ld   [wMusicInstructionPointerChannel1.high], A    ;; 0e:4619 $ea $1d $cb
    ret                                                ;; 0e:461c $c9

musicChannel1SetDutyCycle:
    call getNextMusicInstructionChannel1               ;; 0e:461d $cd $c9 $47
    ld   [wMusicNR11DutyCycleChannel1], A              ;; 0e:4620 $ea $24 $cb
    ld   B, A                                          ;; 0e:4623 $47
    ld   A, [wSoundEffectDurationChannel1]             ;; 0e:4624 $fa $1a $cb
    or   A, A                                          ;; 0e:4627 $b7
    ret  NZ                                            ;; 0e:4628 $c0
    ld   A, B                                          ;; 0e:4629 $78
    ldh  [rNR11], A                                    ;; 0e:462a $e0 $11
    ret                                                ;; 0e:462c $c9

musicOpCodeSetChannel1StereoPan:
    call getNextMusicInstructionChannel1               ;; 0e:462d $cd $c9 $47
    ld   E, A                                          ;; 0e:4630 $5f
    ld   D, $00                                        ;; 0e:4631 $16 $00
    ld   HL, channel1StereoPanValues                   ;; 0e:4633 $21 $c1 $44
    add  HL, DE                                        ;; 0e:4636 $19
    ld   A, [HL]                                       ;; 0e:4637 $7e
    ld   [wMusicStereoPanChannel1], A                  ;; 0e:4638 $ea $2a $cb
    ld   A, [wSoundEffectDurationChannel1]             ;; 0e:463b $fa $1a $cb
    or   A, A                                          ;; 0e:463e $b7
    ret  NZ                                            ;; 0e:463f $c0
    ldh  A, [rNR51]                                    ;; 0e:4640 $f0 $25
    and  A, $ee                                        ;; 0e:4642 $e6 $ee
    or   A, [HL]                                       ;; 0e:4644 $b6
    ldh  [rNR51], A                                    ;; 0e:4645 $e0 $25
    ret                                                ;; 0e:4647 $c9

channel2StereoPanValues:
    db   $00, $02, $20, $22                            ;; 0e:4648 ????

musicTempoPlayNotes_Channel3:
    ld   A, [wMusicEndedOnChannel3]                    ;; 0e:464c $fa $43 $cb
    cp   A, $ff                                        ;; 0e:464f $fe $ff
    jp   Z, return                                     ;; 0e:4651 $ca $ab $47
    ld   A, [wMusicNoteDurationChannel3]               ;; 0e:4654 $fa $33 $cb
    dec  A                                             ;; 0e:4657 $3d
    ld   [wMusicNoteDurationChannel3], A               ;; 0e:4658 $ea $33 $cb
    ldh  [hMusicNoteDurationChannel3Copy], A           ;; 0e:465b $e0 $b7
    jp   NZ, return                                    ;; 0e:465d $c2 $ab $47
.nextMusicInstruction:
    call getNextMusicInstructionChannel3               ;; 0e:4660 $cd $ce $47
    ld   E, A                                          ;; 0e:4663 $5f
    cp   A, $d0                                        ;; 0e:4664 $fe $d0
    jr   NC, .notNote                                  ;; 0e:4666 $30 $4e
    and  A, $f0                                        ;; 0e:4668 $e6 $f0
    swap A                                             ;; 0e:466a $cb $37
    ld   C, A                                          ;; 0e:466c $4f
    ld   HL, musicNoteDurations                        ;; 0e:466d $21 $44 $42
    ld   B, $00                                        ;; 0e:4670 $06 $00
    add  HL, BC                                        ;; 0e:4672 $09
    ld   A, [HL]                                       ;; 0e:4673 $7e
    ld   [wMusicNoteDurationChannel3], A               ;; 0e:4674 $ea $33 $cb
    ld   A, E                                          ;; 0e:4677 $7b
    and  A, $0f                                        ;; 0e:4678 $e6 $0f
    ld   [wMusicNotePitchChannel3], A                  ;; 0e:467a $ea $41 $cb
    cp   A, $0e                                        ;; 0e:467d $fe $0e
    jp   Z, return                                     ;; 0e:467f $ca $ab $47
    cp   A, $0f                                        ;; 0e:4682 $fe $0f
    jr   NZ, .playNote                                 ;; 0e:4684 $20 $07
    ld   A, $00                                        ;; 0e:4686 $3e $00
    ldh  [rNR32], A                                    ;; 0e:4688 $e0 $1c
    jp   return                                        ;; 0e:468a $c3 $ab $47
.playNote:
    add  A, A                                          ;; 0e:468d $87
    ld   E, A                                          ;; 0e:468e $5f
    ld   A, [wMusicOctaveChannel3]                     ;; 0e:468f $fa $3b $cb
    add  A, E                                          ;; 0e:4692 $83
    ld   E, A                                          ;; 0e:4693 $5f
    ld   D, $00                                        ;; 0e:4694 $16 $00
    ld   HL, musicNoteFrequencies                      ;; 0e:4696 $21 $9a $41
    add  HL, DE                                        ;; 0e:4699 $19
    ld   A, [wMusicVolumeChannel3]                     ;; 0e:469a $fa $40 $cb
    ldh  [rNR32], A                                    ;; 0e:469d $e0 $1c
    ld   A, [HL+]                                      ;; 0e:469f $2a
    ldh  [rNR33], A                                    ;; 0e:46a0 $e0 $1d
    ld   [wMusicCurrentPitchChannel3], A               ;; 0e:46a2 $ea $3d $cb
    ld   A, [HL]                                       ;; 0e:46a5 $7e
    and  A, $07                                        ;; 0e:46a6 $e6 $07
    ldh  [rNR34], A                                    ;; 0e:46a8 $e0 $1e
    ld   [wMusicCurrentPitchChannel3.high], A          ;; 0e:46aa $ea $3e $cb
    ld   HL, wMusicVibratoDurationChannel3             ;; 0e:46ad $21 $36 $cb
    call musicStartEnvelope                            ;; 0e:46b0 $cd $ac $47
    jp   return                                        ;; 0e:46b3 $c3 $ab $47
.notNote:
    cp   A, $ff                                        ;; 0e:46b6 $fe $ff
    jr   NZ, .notTerminator                            ;; 0e:46b8 $20 $0c
    ld   [wMusicEndedOnChannel3], A                    ;; 0e:46ba $ea $43 $cb
    ldh  [rNR33], A                                    ;; 0e:46bd $e0 $1d
    ld   A, $07                                        ;; 0e:46bf $3e $07
    ldh  [rNR34], A                                    ;; 0e:46c1 $e0 $1e
    jp   return                                        ;; 0e:46c3 $c3 $ab $47
.notTerminator:
    cp   A, $e0                                        ;; 0e:46c6 $fe $e0
    jr   NC, .opCode                                   ;; 0e:46c8 $30 $26
    bit  3, A                                          ;; 0e:46ca $cb $5f
    jr   NZ, .relativeOctave                           ;; 0e:46cc $20 $0e
    and  A, $07                                        ;; 0e:46ce $e6 $07
    add  A, A                                          ;; 0e:46d0 $87
    add  A, A                                          ;; 0e:46d1 $87
    add  A, A                                          ;; 0e:46d2 $87
    ld   E, A                                          ;; 0e:46d3 $5f
    add  A, A                                          ;; 0e:46d4 $87
    add  A, E                                          ;; 0e:46d5 $83
    ld   [wMusicOctaveChannel3], A                     ;; 0e:46d6 $ea $3b $cb
    jp   .nextMusicInstruction                         ;; 0e:46d9 $c3 $60 $46
.relativeOctave:
    and  A, $07                                        ;; 0e:46dc $e6 $07
    ld   E, A                                          ;; 0e:46de $5f
    ld   D, $00                                        ;; 0e:46df $16 $00
    ld   HL, musicOctaveRelatvieOffsets                ;; 0e:46e1 $21 $b5 $47
    add  HL, DE                                        ;; 0e:46e4 $19
    ld   E, [HL]                                       ;; 0e:46e5 $5e
    ld   A, [wMusicOctaveChannel3]                     ;; 0e:46e6 $fa $3b $cb
    add  A, E                                          ;; 0e:46e9 $83
    ld   [wMusicOctaveChannel3], A                     ;; 0e:46ea $ea $3b $cb
    jp   .nextMusicInstruction                         ;; 0e:46ed $c3 $60 $46
.opCode:
    and  A, $0f                                        ;; 0e:46f0 $e6 $0f
    add  A, A                                          ;; 0e:46f2 $87
    ld   HL, musicOpCodeTableChannel3                  ;; 0e:46f3 $21 $06 $47
    ld   E, A                                          ;; 0e:46f6 $5f
    ld   D, $00                                        ;; 0e:46f7 $16 $00
    add  HL, DE                                        ;; 0e:46f9 $19
    call musicCallOpCode_DupChannel3                   ;; 0e:46fa $cd $00 $47
    jp   .nextMusicInstruction                         ;; 0e:46fd $c3 $60 $46

musicCallOpCode_DupChannel3:
    ld   A, [HL+]                                      ;; 0e:4700 $2a
    ld   E, A                                          ;; 0e:4701 $5f
    ld   A, [HL]                                       ;; 0e:4702 $7e
    ld   H, A                                          ;; 0e:4703 $67
    ld   L, E                                          ;; 0e:4704 $6b
    jp   HL                                            ;; 0e:4705 $e9

;@jumptable
musicOpCodeTableChannel3:
    dw   musicOpCodeSetChannel3Volume                  ;; 0e:4706 pP $00
    dw   musicOpCodeChannel3Jump                       ;; 0e:4708 pP $01
    dw   musicOpCodeChannel3LoopCounter1               ;; 0e:470a pP $02
    dw   musicOpCodeSetChannel3LoopCounter1            ;; 0e:470c pP $03
    dw   musicOpCodeSetChannel3VibratoEnvelope         ;; 0e:470e pP $04
    dw   musicOpCodeNop                                ;; 0e:4710 ?? $05
    dw   musicOpCodeSetChannel3StereoPan               ;; 0e:4712 pP $06
    dw   musicOpCodeNop                                ;; 0e:4714 ?? $07
    dw   musicOpCodeChannel3LoadWaveTable              ;; 0e:4716 pP $08
    dw   musicOpCodeChannel3LoopCounter2               ;; 0e:4718 ?? $09
    dw   musicOpCodeSetChannel3LoopCounter2            ;; 0e:471a ?? $0a
    dw   musicOpCodeIfChannel3LoopCounter1Equal        ;; 0e:471c pP $0b

musicOpCodeSetChannel3Volume:
    call getNextMusicInstructionChannel3               ;; 0e:471e $cd $ce $47
    ld   [wMusicVolumeChannel3], A                     ;; 0e:4721 $ea $40 $cb
    ldh  [rNR32], A                                    ;; 0e:4724 $e0 $1c
    ret                                                ;; 0e:4726 $c9

musicOpCodeChannel3Jump:
    ld   HL, wMusicInstructionPointerChannel3          ;; 0e:4727 $21 $34 $cb
    ld   E, [HL]                                       ;; 0e:472a $5e
    inc  HL                                            ;; 0e:472b $23
    ld   D, [HL]                                       ;; 0e:472c $56
    ld   A, [DE]                                       ;; 0e:472d $1a
    inc  DE                                            ;; 0e:472e $13
    ld   [wMusicInstructionPointerChannel3], A         ;; 0e:472f $ea $34 $cb
    ld   A, [DE]                                       ;; 0e:4732 $1a
    ld   [wMusicInstructionPointerChannel3.high], A    ;; 0e:4733 $ea $35 $cb
    ret                                                ;; 0e:4736 $c9

musicOpCodeSetChannel3LoopCounter1:
    call getNextMusicInstructionChannel3               ;; 0e:4737 $cd $ce $47
    ld   [wMusicLoopCounter1Channel3], A               ;; 0e:473a $ea $3f $cb
    ret                                                ;; 0e:473d $c9

musicOpCodeSetChannel3LoopCounter2:
    call getNextMusicInstructionChannel3               ;; 0e:473e $cd $ce $47
    ld   [wMusicLoopCounter2Channel3], A               ;; 0e:4741 $ea $49 $cb
    ret                                                ;; 0e:4744 $c9

musicOpCodeSetChannel3VibratoEnvelope:
    ld   HL, wMusicInstructionPointerChannel3          ;; 0e:4745 $21 $34 $cb
    ld   E, [HL]                                       ;; 0e:4748 $5e
    inc  HL                                            ;; 0e:4749 $23
    ld   D, [HL]                                       ;; 0e:474a $56
    ld   A, [DE]                                       ;; 0e:474b $1a
    ld   C, A                                          ;; 0e:474c $4f
    inc  DE                                            ;; 0e:474d $13
    ld   A, [DE]                                       ;; 0e:474e $1a
    inc  DE                                            ;; 0e:474f $13
    ld   [wMusicVibratoEnvelopeChannel3.high], A       ;; 0e:4750 $ea $38 $cb
    ld   [wMusicVibratoEnvelopePointerChannel3.high], A ;; 0e:4753 $ea $3a $cb
    ld   A, C                                          ;; 0e:4756 $79
    ld   [wMusicVibratoEnvelopeChannel3], A            ;; 0e:4757 $ea $37 $cb
    ld   [wMusicVibratoEnvelopePointerChannel3], A     ;; 0e:475a $ea $39 $cb
    ld   A, E                                          ;; 0e:475d $7b
    ld   [wMusicInstructionPointerChannel3], A         ;; 0e:475e $ea $34 $cb
    ld   A, D                                          ;; 0e:4761 $7a
    ld   [wMusicInstructionPointerChannel3.high], A    ;; 0e:4762 $ea $35 $cb
    ret                                                ;; 0e:4765 $c9

musicOpCodeSetChannel3StereoPan:
    call getNextMusicInstructionChannel3               ;; 0e:4766 $cd $ce $47
    ld   E, A                                          ;; 0e:4769 $5f
    ld   D, $00                                        ;; 0e:476a $16 $00
    ld   HL, .stereoPanValues                          ;; 0e:476c $21 $78 $47
    add  HL, DE                                        ;; 0e:476f $19
    ldh  A, [rNR51]                                    ;; 0e:4770 $f0 $25
    and  A, $bb                                        ;; 0e:4772 $e6 $bb
    or   A, [HL]                                       ;; 0e:4774 $b6
    ldh  [rNR51], A                                    ;; 0e:4775 $e0 $25
    ret                                                ;; 0e:4777 $c9
.stereoPanValues:
    db   $00, $04, $40, $44                            ;; 0e:4778 ????

musicOpCodeChannel3LoadWaveTable:
    ld   HL, wMusicInstructionPointerChannel3          ;; 0e:477c $21 $34 $cb
    ld   E, [HL]                                       ;; 0e:477f $5e
    inc  HL                                            ;; 0e:4780 $23
    ld   D, [HL]                                       ;; 0e:4781 $56
    ld   A, [DE]                                       ;; 0e:4782 $1a
    ld   C, A                                          ;; 0e:4783 $4f
    ldh  [hWaveTablePointer], A                        ;; 0e:4784 $e0 $ba
    inc  DE                                            ;; 0e:4786 $13
    ld   A, [DE]                                       ;; 0e:4787 $1a
    ld   B, A                                          ;; 0e:4788 $47
    ldh  [hWaveTablePointer.high], A                   ;; 0e:4789 $e0 $bb
    inc  DE                                            ;; 0e:478b $13
    ld   [HL], D                                       ;; 0e:478c $72
    dec  HL                                            ;; 0e:478d $2b
    ld   [HL], E                                       ;; 0e:478e $73
    push BC                                            ;; 0e:478f $c5
    pop  HL                                            ;; 0e:4790 $e1

musicLoadWaveTable:
    xor  A, A                                          ;; 0e:4791 $af
    ldh  [rNR30], A                                    ;; 0e:4792 $e0 $1a
    ld   C, $30                                        ;; 0e:4794 $0e $30
    ld   B, $10                                        ;; 0e:4796 $06 $10
.loop:
    ld   A, [HL+]                                      ;; 0e:4798 $2a
    ldh  [C], A                                        ;; 0e:4799 $e2
    inc  C                                             ;; 0e:479a $0c
    dec  B                                             ;; 0e:479b $05
    jr   NZ, .loop                                     ;; 0e:479c $20 $fa
    ld   A, $80                                        ;; 0e:479e $3e $80
    ldh  [rNR30], A                                    ;; 0e:47a0 $e0 $1a
    ld   A, $00                                        ;; 0e:47a2 $3e $00
    ldh  [rNR32], A                                    ;; 0e:47a4 $e0 $1c
    ld   A, $87                                        ;; 0e:47a6 $3e $87
    ldh  [rNR34], A                                    ;; 0e:47a8 $e0 $1e
    ret                                                ;; 0e:47aa $c9

return:
    ret                                                ;; 0e:47ab $c9

musicStartEnvelope:
    ld   A, $01                                        ;; 0e:47ac $3e $01
    ld   [HL+], A                                      ;; 0e:47ae $22
    ld   A, [HL+]                                      ;; 0e:47af $2a
    ld   E, [HL]                                       ;; 0e:47b0 $5e
    inc  HL                                            ;; 0e:47b1 $23
    ld   [HL+], A                                      ;; 0e:47b2 $22
    ld   [HL], E                                       ;; 0e:47b3 $73
    ret                                                ;; 0e:47b4 $c9

musicOctaveRelatvieOffsets:
    db   $18, $30, $48, $60, $e8, $d0, $b8, $a0        ;; 0e:47b5 .???.???

getNextMusicInstructionChannel2:
    ld   HL, wMusicInstructionPointerChannel2          ;; 0e:47bd $21 $04 $cb

getNextMusicalInstructionCommon:
    ld   E, [HL]                                       ;; 0e:47c0 $5e
    inc  HL                                            ;; 0e:47c1 $23
    ld   D, [HL]                                       ;; 0e:47c2 $56
    ld   A, [DE]                                       ;; 0e:47c3 $1a
    inc  DE                                            ;; 0e:47c4 $13
    ld   [HL], D                                       ;; 0e:47c5 $72
    dec  HL                                            ;; 0e:47c6 $2b
    ld   [HL], E                                       ;; 0e:47c7 $73
    ret                                                ;; 0e:47c8 $c9

getNextMusicInstructionChannel1:
    ld   HL, wMusicInstructionPointerChannel1          ;; 0e:47c9 $21 $1c $cb
    jr   getNextMusicalInstructionCommon               ;; 0e:47cc $18 $f2

getNextMusicInstructionChannel3:
    ld   HL, wMusicInstructionPointerChannel3          ;; 0e:47ce $21 $34 $cb
    jr   getNextMusicalInstructionCommon               ;; 0e:47d1 $18 $ed

musicVibratoAndVolumeChannel2:
    ld   A, [wSoundEffectDurationChannel2]             ;; 0e:47d3 $fa $02 $cb
    ld   E, A                                          ;; 0e:47d6 $5f
    ld   A, [wMusicEndedOnChannel2]                    ;; 0e:47d7 $fa $13 $cb
    or   A, E                                          ;; 0e:47da $b3
    ret  NZ                                            ;; 0e:47db $c0
    ldh  A, [hMusicNoteDurationChannel2Copy]           ;; 0e:47dc $f0 $b5
    or   A, A                                          ;; 0e:47de $b7
    ret  Z                                             ;; 0e:47df $c8
    ld   A, [wMusicNotePitchChannel2]                  ;; 0e:47e0 $fa $11 $cb
    cp   A, $0f                                        ;; 0e:47e3 $fe $0f
    ret  Z                                             ;; 0e:47e5 $c8
    ld   A, [wMusicVibratoDurationChannel2]            ;; 0e:47e6 $fa $06 $cb
    dec  A                                             ;; 0e:47e9 $3d
    ld   [wMusicVibratoDurationChannel2], A            ;; 0e:47ea $ea $06 $cb
    jr   NZ, .volume_envelope                          ;; 0e:47ed $20 $32
    ld   A, [wMusicVibratoEnvelopePointerChannel2]     ;; 0e:47ef $fa $09 $cb
    ld   L, A                                          ;; 0e:47f2 $6f
    ld   A, [wMusicVibratoEnvelopePointerChannel2.high] ;; 0e:47f3 $fa $0a $cb
    ld   H, A                                          ;; 0e:47f6 $67
    ld   A, [HL+]                                      ;; 0e:47f7 $2a
    or   A, A                                          ;; 0e:47f8 $b7
    call Z, musicVibratoAndVolumeJump                  ;; 0e:47f9 $cc $16 $49
    ld   [wMusicVibratoDurationChannel2], A            ;; 0e:47fc $ea $06 $cb
    ld   A, [HL+]                                      ;; 0e:47ff $2a
    ld   E, A                                          ;; 0e:4800 $5f
    ld   A, L                                          ;; 0e:4801 $7d
    ld   [wMusicVibratoEnvelopePointerChannel2], A     ;; 0e:4802 $ea $09 $cb
    ld   A, H                                          ;; 0e:4805 $7c
    ld   [wMusicVibratoEnvelopePointerChannel2.high], A ;; 0e:4806 $ea $0a $cb
    ld   D, $00                                        ;; 0e:4809 $16 $00
    bit  7, E                                          ;; 0e:480b $cb $7b
    jr   Z, .sign_extended                             ;; 0e:480d $28 $01
    dec  D                                             ;; 0e:480f $15
.sign_extended:
    ld   A, [wMusicCurrentPitchChannel2]               ;; 0e:4810 $fa $0d $cb
    ld   L, A                                          ;; 0e:4813 $6f
    ld   A, [wMusicCurrentPitchChannel2.high]          ;; 0e:4814 $fa $0e $cb
    ld   H, A                                          ;; 0e:4817 $67
    add  HL, DE                                        ;; 0e:4818 $19
    ld   A, L                                          ;; 0e:4819 $7d
    ldh  [rNR23], A                                    ;; 0e:481a $e0 $18
    ld   A, H                                          ;; 0e:481c $7c
    and  A, $07                                        ;; 0e:481d $e6 $07
    ldh  [rNR24], A                                    ;; 0e:481f $e0 $19
.volume_envelope:
    ld   A, [wMusicVolumeDurationChannel2]             ;; 0e:4821 $fa $14 $cb
    cp   A, $ff                                        ;; 0e:4824 $fe $ff
    ret  Z                                             ;; 0e:4826 $c8
    dec  A                                             ;; 0e:4827 $3d
    ld   [wMusicVolumeDurationChannel2], A             ;; 0e:4828 $ea $14 $cb
    ret  NZ                                            ;; 0e:482b $c0
    ld   A, [wMusicVolumeEnvelopePointerChannel2]      ;; 0e:482c $fa $17 $cb
    ld   L, A                                          ;; 0e:482f $6f
    ld   A, [wMusicVolumeEnvelopePointerChannel2.high] ;; 0e:4830 $fa $18 $cb
    ld   H, A                                          ;; 0e:4833 $67
    ld   A, [HL+]                                      ;; 0e:4834 $2a
    or   A, A                                          ;; 0e:4835 $b7
    call Z, musicVibratoAndVolumeJump                  ;; 0e:4836 $cc $16 $49
    ld   [wMusicVolumeDurationChannel2], A             ;; 0e:4839 $ea $14 $cb
    ld   A, [HL+]                                      ;; 0e:483c $2a
    ldh  [rNR22], A                                    ;; 0e:483d $e0 $17
    ld   A, [wMusicCurrentPitchChannel2.high]          ;; 0e:483f $fa $0e $cb
    ldh  [rNR24], A                                    ;; 0e:4842 $e0 $19
    ld   A, L                                          ;; 0e:4844 $7d
    ld   [wMusicVolumeEnvelopePointerChannel2], A      ;; 0e:4845 $ea $17 $cb
    ld   A, H                                          ;; 0e:4848 $7c
    ld   [wMusicVolumeEnvelopePointerChannel2.high], A ;; 0e:4849 $ea $18 $cb
    ret                                                ;; 0e:484c $c9

musicVibratoAndVolumeChannel1:
    ld   A, [wSoundEffectDurationChannel1]             ;; 0e:484d $fa $1a $cb
    ld   E, A                                          ;; 0e:4850 $5f
    ld   A, [wMusicEndedOnChannel1]                    ;; 0e:4851 $fa $2b $cb
    or   A, E                                          ;; 0e:4854 $b3
    ret  NZ                                            ;; 0e:4855 $c0
    ldh  A, [hMusicNoteDurationChannel1Copy]           ;; 0e:4856 $f0 $b6
    or   A, A                                          ;; 0e:4858 $b7
    ret  Z                                             ;; 0e:4859 $c8
    ld   A, [wMusicNotePitchChannel1]                  ;; 0e:485a $fa $29 $cb
    cp   A, $0f                                        ;; 0e:485d $fe $0f
    ret  Z                                             ;; 0e:485f $c8
    ld   A, [wMusicVibratoDurationChannel1]            ;; 0e:4860 $fa $1e $cb
    dec  A                                             ;; 0e:4863 $3d
    ld   [wMusicVibratoDurationChannel1], A            ;; 0e:4864 $ea $1e $cb
    jr   NZ, .volume_envelope                          ;; 0e:4867 $20 $32
    ld   A, [wMusicVibratoEnvelopePointerChannel1]     ;; 0e:4869 $fa $21 $cb
    ld   L, A                                          ;; 0e:486c $6f
    ld   A, [wMusicVibratoEnvelopePointerChannel1.high] ;; 0e:486d $fa $22 $cb
    ld   H, A                                          ;; 0e:4870 $67
    ld   A, [HL+]                                      ;; 0e:4871 $2a
    or   A, A                                          ;; 0e:4872 $b7
    call Z, musicVibratoAndVolumeJump                  ;; 0e:4873 $cc $16 $49
    ld   [wMusicVibratoDurationChannel1], A            ;; 0e:4876 $ea $1e $cb
    ld   A, [HL+]                                      ;; 0e:4879 $2a
    ld   E, A                                          ;; 0e:487a $5f
    ld   A, L                                          ;; 0e:487b $7d
    ld   [wMusicVibratoEnvelopePointerChannel1], A     ;; 0e:487c $ea $21 $cb
    ld   A, H                                          ;; 0e:487f $7c
    ld   [wMusicVibratoEnvelopePointerChannel1.high], A ;; 0e:4880 $ea $22 $cb
    ld   D, $00                                        ;; 0e:4883 $16 $00
    bit  7, E                                          ;; 0e:4885 $cb $7b
    jr   Z, .sign_extended                             ;; 0e:4887 $28 $01
    dec  D                                             ;; 0e:4889 $15
.sign_extended:
    ld   A, [wMusicCurrentPitchChannel1]               ;; 0e:488a $fa $25 $cb
    ld   L, A                                          ;; 0e:488d $6f
    ld   A, [wMusicCurrentPitchChannel1.high]          ;; 0e:488e $fa $26 $cb
    ld   H, A                                          ;; 0e:4891 $67
    add  HL, DE                                        ;; 0e:4892 $19
    ld   A, L                                          ;; 0e:4893 $7d
    ldh  [rNR13], A                                    ;; 0e:4894 $e0 $13
    ld   A, H                                          ;; 0e:4896 $7c
    and  A, $07                                        ;; 0e:4897 $e6 $07
    ldh  [rNR14], A                                    ;; 0e:4899 $e0 $14
.volume_envelope:
    ld   A, [wMusicVolumeDurationChannel1]             ;; 0e:489b $fa $2c $cb
    cp   A, $ff                                        ;; 0e:489e $fe $ff
    ret  Z                                             ;; 0e:48a0 $c8
    dec  A                                             ;; 0e:48a1 $3d
    ld   [wMusicVolumeDurationChannel1], A             ;; 0e:48a2 $ea $2c $cb
    ret  NZ                                            ;; 0e:48a5 $c0
    ld   A, [wMusicVolumeEnvelopePointerChannel1]      ;; 0e:48a6 $fa $2f $cb
    ld   L, A                                          ;; 0e:48a9 $6f
    ld   A, [wMusicVolumeEnvelopePointerChannel1.high] ;; 0e:48aa $fa $30 $cb
    ld   H, A                                          ;; 0e:48ad $67
    ld   A, [HL+]                                      ;; 0e:48ae $2a
    or   A, A                                          ;; 0e:48af $b7
    call Z, musicVibratoAndVolumeJump                  ;; 0e:48b0 $cc $16 $49
    ld   [wMusicVolumeDurationChannel1], A             ;; 0e:48b3 $ea $2c $cb
    ld   A, [HL+]                                      ;; 0e:48b6 $2a
    ldh  [rNR12], A                                    ;; 0e:48b7 $e0 $12
    ld   A, [wMusicCurrentPitchChannel1.high]          ;; 0e:48b9 $fa $26 $cb
    ldh  [rNR14], A                                    ;; 0e:48bc $e0 $14
    ld   A, L                                          ;; 0e:48be $7d
    ld   [wMusicVolumeEnvelopePointerChannel1], A      ;; 0e:48bf $ea $2f $cb
    ld   A, H                                          ;; 0e:48c2 $7c
    ld   [wMusicVolumeEnvelopePointerChannel1.high], A ;; 0e:48c3 $ea $30 $cb
    ret                                                ;; 0e:48c6 $c9

musicVibratoAndVolumeChannel3:
    ld   A, [wSoundEffectDurationChannel3]             ;; 0e:48c7 $fa $32 $cb
    ld   E, A                                          ;; 0e:48ca $5f
    ld   A, [wMusicEndedOnChannel3]                    ;; 0e:48cb $fa $43 $cb
    or   A, E                                          ;; 0e:48ce $b3
    ret  NZ                                            ;; 0e:48cf $c0
    ldh  A, [hMusicNoteDurationChannel3Copy]           ;; 0e:48d0 $f0 $b7
    or   A, A                                          ;; 0e:48d2 $b7
    ret  Z                                             ;; 0e:48d3 $c8
    ld   A, [wMusicNotePitchChannel3]                  ;; 0e:48d4 $fa $41 $cb
    cp   A, $0f                                        ;; 0e:48d7 $fe $0f
    ret  Z                                             ;; 0e:48d9 $c8
    ld   A, [wMusicVibratoDurationChannel3]            ;; 0e:48da $fa $36 $cb
    dec  A                                             ;; 0e:48dd $3d
    ld   [wMusicVibratoDurationChannel3], A            ;; 0e:48de $ea $36 $cb
    jr   NZ, .return                                   ;; 0e:48e1 $20 $32
    ld   A, [wMusicVibratoEnvelopePointerChannel3]     ;; 0e:48e3 $fa $39 $cb
    ld   L, A                                          ;; 0e:48e6 $6f
    ld   A, [wMusicVibratoEnvelopePointerChannel3.high] ;; 0e:48e7 $fa $3a $cb
    ld   H, A                                          ;; 0e:48ea $67
    ld   A, [HL+]                                      ;; 0e:48eb $2a
    or   A, A                                          ;; 0e:48ec $b7
    call Z, musicVibratoAndVolumeJump                  ;; 0e:48ed $cc $16 $49
    ld   [wMusicVibratoDurationChannel3], A            ;; 0e:48f0 $ea $36 $cb
    ld   A, [HL+]                                      ;; 0e:48f3 $2a
    ld   E, A                                          ;; 0e:48f4 $5f
    ld   A, L                                          ;; 0e:48f5 $7d
    ld   [wMusicVibratoEnvelopePointerChannel3], A     ;; 0e:48f6 $ea $39 $cb
    ld   A, H                                          ;; 0e:48f9 $7c
    ld   [wMusicVibratoEnvelopePointerChannel3.high], A ;; 0e:48fa $ea $3a $cb
    ld   D, $00                                        ;; 0e:48fd $16 $00
    bit  7, E                                          ;; 0e:48ff $cb $7b
    jr   Z, .sign_extended                             ;; 0e:4901 $28 $01
    dec  D                                             ;; 0e:4903 $15
.sign_extended:
    ld   A, [wMusicCurrentPitchChannel3]               ;; 0e:4904 $fa $3d $cb
    ld   L, A                                          ;; 0e:4907 $6f
    ld   A, [wMusicCurrentPitchChannel3.high]          ;; 0e:4908 $fa $3e $cb
    ld   H, A                                          ;; 0e:490b $67
    add  HL, DE                                        ;; 0e:490c $19
    ld   A, L                                          ;; 0e:490d $7d
    ldh  [rNR33], A                                    ;; 0e:490e $e0 $1d
    ld   A, H                                          ;; 0e:4910 $7c
    and  A, $07                                        ;; 0e:4911 $e6 $07
    ldh  [rNR34], A                                    ;; 0e:4913 $e0 $1e
.return:
    ret                                                ;; 0e:4915 $c9

musicVibratoAndVolumeJump:
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

soundEffectPlay:
    dec  A                                             ;; 0e:4920 $3d
    add  A, A                                          ;; 0e:4921 $87
    ld   E, A                                          ;; 0e:4922 $5f
    ld   D, $00                                        ;; 0e:4923 $16 $00
    ld   HL, soundEffectDataChannel1                   ;; 0e:4925 $21 $c5 $7a
    add  HL, DE                                        ;; 0e:4928 $19
    ld   A, [HL+]                                      ;; 0e:4929 $2a
    ld   [wSoundEffectInstructionPointerChannel1], A   ;; 0e:492a $ea $c4 $cb
    ld   A, [HL]                                       ;; 0e:492d $7e
    ld   [wSoundEffectInstructionPointerChannel1.high], A ;; 0e:492e $ea $c5 $cb
    ld   HL, soundEffectDataChannel4                   ;; 0e:4931 $21 $37 $7b
    add  HL, DE                                        ;; 0e:4934 $19
    ld   A, [HL+]                                      ;; 0e:4935 $2a
    ld   [wSoundEffectInstructionPointerChannel4], A   ;; 0e:4936 $ea $c6 $cb
    ld   A, [HL+]                                      ;; 0e:4939 $2a
    ld   [wSoundEffectInstructionPointerChannel4.high], A ;; 0e:493a $ea $c7 $cb
    ld   A, $01                                        ;; 0e:493d $3e $01
    ld   [wSoundEffectDurationChannel1], A             ;; 0e:493f $ea $1a $cb
    ld   [wSoundEffectDurationChannel4], A             ;; 0e:4942 $ea $4a $cb
    xor  A, A                                          ;; 0e:4945 $af
    ldh  [hSFX], A                                     ;; 0e:4946 $e0 $b2
    ret                                                ;; 0e:4948 $c9

soundEffectPlayStep:
    ld   A, [wSoundEffectDurationChannel1]             ;; 0e:4949 $fa $1a $cb
    or   A, A                                          ;; 0e:494c $b7
    jp   Z, .channel4                                  ;; 0e:494d $ca $9f $49
    dec  A                                             ;; 0e:4950 $3d
    ld   [wSoundEffectDurationChannel1], A             ;; 0e:4951 $ea $1a $cb
    jr   NZ, .channel4                                 ;; 0e:4954 $20 $49
    ld   A, [wSoundEffectInstructionPointerChannel1]   ;; 0e:4956 $fa $c4 $cb
    ld   L, A                                          ;; 0e:4959 $6f
    ld   A, [wSoundEffectInstructionPointerChannel1.high] ;; 0e:495a $fa $c5 $cb
    ld   H, A                                          ;; 0e:495d $67
.nextInstructionChannel1:
    ld   A, [HL+]                                      ;; 0e:495e $2a
    ld   [wSoundEffectDurationChannel1], A             ;; 0e:495f $ea $1a $cb
    or   A, A                                          ;; 0e:4962 $b7
    jr   NZ, .notTerminatorChannel1                    ;; 0e:4963 $20 $05
    call soundEffectRestoreChannel1                    ;; 0e:4965 $cd $4a $41
    jr   .channel4                                     ;; 0e:4968 $18 $35
.notTerminatorChannel1:
    cp   A, $ef                                        ;; 0e:496a $fe $ef
    jr   NZ, .notLoopChannel1                          ;; 0e:496c $20 $0f
    ld   A, [HL+]                                      ;; 0e:496e $2a
    ld   C, A                                          ;; 0e:496f $4f
    ld   A, [HL+]                                      ;; 0e:4970 $2a
    ld   B, A                                          ;; 0e:4971 $47
    ldh  A, [hSoundEffectLoopCounterChannel1]          ;; 0e:4972 $f0 $bc
    dec  A                                             ;; 0e:4974 $3d
    ldh  [hSoundEffectLoopCounterChannel1], A          ;; 0e:4975 $e0 $bc
    jr   Z, .nextInstructionChannel1                   ;; 0e:4977 $28 $e5
    ld   L, C                                          ;; 0e:4979 $69
    ld   H, B                                          ;; 0e:497a $60
    jr   .nextInstructionChannel1                      ;; 0e:497b $18 $e1
.notLoopChannel1:
    cp   A, $f0                                        ;; 0e:497d $fe $f0
    jr   C, .playChannel1                              ;; 0e:497f $38 $06
    and  A, $0f                                        ;; 0e:4981 $e6 $0f
    ldh  [hSoundEffectLoopCounterChannel1], A          ;; 0e:4983 $e0 $bc
    jr   .nextInstructionChannel1                      ;; 0e:4985 $18 $d7
.playChannel1:
    ld   C, $10                                        ;; 0e:4987 $0e $10
    ld   B, $05                                        ;; 0e:4989 $06 $05
.copyLoop:
    ld   A, [HL+]                                      ;; 0e:498b $2a
    ldh  [C], A                                        ;; 0e:498c $e2
    inc  C                                             ;; 0e:498d $0c
    dec  B                                             ;; 0e:498e $05
    jr   NZ, .copyLoop                                 ;; 0e:498f $20 $fa
    ldh  A, [rNR51]                                    ;; 0e:4991 $f0 $25
    or   A, $11                                        ;; 0e:4993 $f6 $11
    ldh  [rNR51], A                                    ;; 0e:4995 $e0 $25
    ld   A, L                                          ;; 0e:4997 $7d
    ld   [wSoundEffectInstructionPointerChannel1], A   ;; 0e:4998 $ea $c4 $cb
    ld   A, H                                          ;; 0e:499b $7c
    ld   [wSoundEffectInstructionPointerChannel1.high], A ;; 0e:499c $ea $c5 $cb
.channel4:
    ld   A, [wSoundEffectDurationChannel4]             ;; 0e:499f $fa $4a $cb
    or   A, A                                          ;; 0e:49a2 $b7
    jr   Z, .return                                    ;; 0e:49a3 $28 $4f
    dec  A                                             ;; 0e:49a5 $3d
    ld   [wSoundEffectDurationChannel4], A             ;; 0e:49a6 $ea $4a $cb
    jr   NZ, .return                                   ;; 0e:49a9 $20 $49
    ld   A, [wSoundEffectInstructionPointerChannel4]   ;; 0e:49ab $fa $c6 $cb
    ld   L, A                                          ;; 0e:49ae $6f
    ld   A, [wSoundEffectInstructionPointerChannel4.high] ;; 0e:49af $fa $c7 $cb
    ld   H, A                                          ;; 0e:49b2 $67
.nextInstructionChannel4:
    ld   A, [HL+]                                      ;; 0e:49b3 $2a
    ld   [wSoundEffectDurationChannel4], A             ;; 0e:49b4 $ea $4a $cb
    or   A, A                                          ;; 0e:49b7 $b7
    jr   NZ, .notTerminatorChannel4                    ;; 0e:49b8 $20 $05
    call soundEffectMuteChannel4                       ;; 0e:49ba $cd $6b $41
    jr   .return                                       ;; 0e:49bd $18 $35
.notTerminatorChannel4:
    cp   A, $ef                                        ;; 0e:49bf $fe $ef
    jr   NZ, .notLoopChannel4                          ;; 0e:49c1 $20 $0f
    ld   A, [HL+]                                      ;; 0e:49c3 $2a
    ld   C, A                                          ;; 0e:49c4 $4f
    ld   A, [HL+]                                      ;; 0e:49c5 $2a
    ld   B, A                                          ;; 0e:49c6 $47
    ldh  A, [hSoundEffectLoopCounterChannel4]          ;; 0e:49c7 $f0 $bd
    dec  A                                             ;; 0e:49c9 $3d
    ldh  [hSoundEffectLoopCounterChannel4], A          ;; 0e:49ca $e0 $bd
    jr   Z, .nextInstructionChannel4                   ;; 0e:49cc $28 $e5
    ld   L, C                                          ;; 0e:49ce $69
    ld   H, B                                          ;; 0e:49cf $60
    jr   .nextInstructionChannel4                      ;; 0e:49d0 $18 $e1
.notLoopChannel4:
    cp   A, $f0                                        ;; 0e:49d2 $fe $f0
    jr   C, .notSetCounterChannel4                     ;; 0e:49d4 $38 $06
    and  A, $0f                                        ;; 0e:49d6 $e6 $0f
    ldh  [hSoundEffectLoopCounterChannel4], A          ;; 0e:49d8 $e0 $bd
    jr   .nextInstructionChannel4                      ;; 0e:49da $18 $d7
.notSetCounterChannel4:
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
    ld   [wSoundEffectInstructionPointerChannel4], A   ;; 0e:49ed $ea $c6 $cb
    ld   A, H                                          ;; 0e:49f0 $7c
    ld   [wSoundEffectInstructionPointerChannel4.high], A ;; 0e:49f1 $ea $c7 $cb
.return:
    ret                                                ;; 0e:49f4 $c9

;@data format=ppp amount=19
; Music data table, 3 pointers per music:
; Channel 2, Channel 1, Channel 3
musicSongChannelPointers:
    dw   data_0e_4a68, data_0e_4ab9, data_0e_4ae5      ;; 0e:49f5 ?????? $00
    dw   data_0e_4b55, data_0e_4c2f, data_0e_4dab      ;; 0e:49fb ?????? $01
    dw   data_0e_4e15, data_0e_4e7a, data_0e_4ed6      ;; 0e:4a01 pPpPpP $02
    dw   data_0e_4f15, data_0e_4f42, data_0e_4f79      ;; 0e:4a07 ?????? $03
    dw   data_0e_4fa9, data_0e_500d, data_0e_5134      ;; 0e:4a0d pPpPpP $04
    dw   data_0e_5361, data_0e_5394, data_0e_53ca      ;; 0e:4a13 ?????? $05
    dw   data_0e_53ff, data_0e_5437, data_0e_54a6      ;; 0e:4a19 ?????? $06
    dw   data_0e_5514, data_0e_55c5, data_0e_56a8      ;; 0e:4a1f ?????? $07
    dw   data_0e_570e, data_0e_5779, data_0e_5826      ;; 0e:4a25 ?????? $08
    dw   data_0e_58e2, data_0e_5968, data_0e_5a10      ;; 0e:4a2b pPpPpP $09
    dw   data_0e_5a73, data_0e_5b3a, data_0e_5ce9      ;; 0e:4a31 ?????? $0a
    dw   data_0e_6688, data_0e_674b, data_0e_68b8      ;; 0e:4a37 pPpPpP $0b
    dw   data_0e_6ecd, data_0e_6f4d, data_0e_7164      ;; 0e:4a3d ?????? $0c
    dw   data_0e_71dd, data_0e_7251, data_0e_7302      ;; 0e:4a43 ?????? $0d
    dw   data_0e_7345, data_0e_7588, data_0e_77e3      ;; 0e:4a49 ?????? $0e
    dw   data_0e_5148, data_0e_51bf, data_0e_5280      ;; 0e:4a4f ?????? $0f
    dw   data_0e_5e4d, data_0e_5fa3, data_0e_61c7      ;; 0e:4a55 pPpPpP $10
    dw   data_0e_635c, data_0e_6439, data_0e_65ac      ;; 0e:4a5b ?????? $11
    dw   data_0e_696e, data_0e_6c81, data_0e_6dac      ;; 0e:4a61 ?????? $12
    db   $ff                                           ;; 0e:4a67 ?

data_0e_4a68:
    db   $e7, $46, $e4, $fe, $79, $e0, $31, $7a        ;; 0e:4a68 ????????
    db   $e5, $80, $e6, $03, $d2, $84, $84, $2b        ;; 0e:4a70 ????????
    db   $aa, $ab, $8d, $5b, $d8, $54, $81, $dc        ;; 0e:4a78 ????????
    db   $8b, $59, $ae, $af, $86, $88, $89, $5b        ;; 0e:4a80 ????????
    db   $58, $1d, $8d, $d8, $83, $84, $83, $84        ;; 0e:4a88 ????????
    db   $86, $53, $83, $84, $86, $84, $86, $88        ;; 0e:4a90 ????????
    db   $54, $83, $84, $81, $dc, $8b, $89, $8b        ;; 0e:4a98 ????????
    db   $5d, $d8, $53, $54, $53, $54, $56, $28        ;; 0e:4aa0 ????????
    db   $54, $56, $28, $54, $56, $28, $dc, $e7        ;; 0e:4aa8 ????????
    db   $37, $54, $e7, $34, $56, $e7, $32, $08        ;; 0e:4ab0 ????????
    db   $ff                                           ;; 0e:4ab8 ?

data_0e_4ab9:
    db   $e4, $fe, $79, $e0, $6f, $7a, $e6, $03        ;; 0e:4ab9 ????????
    db   $e5, $40, $d2, $0f, $0f, $0f, $0f, $8d        ;; 0e:4ac1 ????????
    db   $8b, $5d, $2b, $2c, $58, $56, $89, $88        ;; 0e:4ac9 ????????
    db   $86, $88, $59, $5b, $09, $e0, $31, $7a        ;; 0e:4ad1 ????????
    db   $2b, $57, $59, $2b, $57, $59, $2b, $dc        ;; 0e:4ad9 ????????
    db   $57, $59, $0b, $ff                            ;; 0e:4ae1 ????

data_0e_4ae5:
    db   $e4, $fe, $79, $e8, $85, $7a, $e0, $40        ;; 0e:4ae5 ????????
    db   $e6, $03, $d2, $24, $23, $22, $49, $88        ;; 0e:4aed ????????
    db   $26, $58, $d8, $53, $51, $56, $54, $dc        ;; 0e:4af5 ????????
    db   $5b, $29, $5b, $59, $28, $5d, $5b, $06        ;; 0e:4afd ????????
    db   $2b, $5d, $d8, $53, $dc, $e6, $02, $a4        ;; 0e:4b05 ????????
    db   $af, $dc, $e6, $01, $ab, $af, $d8, $e6        ;; 0e:4b0d ????????
    db   $02, $a4, $af, $dc, $e6, $01, $ab, $af        ;; 0e:4b15 ????????
    db   $d8, $e6, $03, $50, $52, $e6, $02, $a4        ;; 0e:4b1d ????????
    db   $af, $dc, $e6, $01, $ab, $af, $d8, $e6        ;; 0e:4b25 ????????
    db   $02, $a4, $af, $dc, $e6, $01, $ab, $af        ;; 0e:4b2d ????????
    db   $d8, $e6, $03, $50, $52, $e6, $02, $a4        ;; 0e:4b35 ????????
    db   $af, $dc, $e6, $01, $ab, $af, $d8, $e6        ;; 0e:4b3d ????????
    db   $02, $a4, $af, $dc, $e6, $01, $ab, $af        ;; 0e:4b45 ????????
    db   $d8, $e6, $03, $50, $52, $14, $8e, $ff        ;; 0e:4b4d ????????

data_0e_4b55:
    db   $e7, $78, $e0, $3f, $7a, $e5, $40, $e6        ;; 0e:4b55 ????????
    db   $03, $e3, $02, $ea, $02, $d0, $a9, $af        ;; 0e:4b5d ????????
    db   $d8, $a4, $a4, $dc, $a9, $af, $d8, $a5        ;; 0e:4b65 ????????
    db   $a5, $dc, $a9, $af, $d8, $a6, $a6, $dc        ;; 0e:4b6d ????????
    db   $a9, $af, $d8, $a5, $a5, $e9, $62, $4b        ;; 0e:4b75 ????????
    db   $ea, $02, $dc, $ab, $af, $d8, $a6, $a6        ;; 0e:4b7d ????????
    db   $dc, $ab, $af, $d8, $a7, $a7, $dc, $ab        ;; 0e:4b85 ????????
    db   $af, $d8, $a8, $a8, $dc, $ab, $af, $d8        ;; 0e:4b8d ????????
    db   $a7, $a7, $e9, $7f, $4b, $e2, $60, $4b        ;; 0e:4b95 ????????
    db   $e3, $02, $dc, $59, $59, $a9, $af, $84        ;; 0e:4b9d ????????
    db   $a9, $af, $84, $55, $55, $85, $8c, $89        ;; 0e:4ba5 ????????
    db   $85, $57, $57, $a7, $af, $82, $a7, $af        ;; 0e:4bad ????????
    db   $82, $54, $54, $84, $5b, $8b, $55, $55        ;; 0e:4bb5 ????????
    db   $85, $8c, $89, $85, $57, $57, $a7, $af        ;; 0e:4bbd ????????
    db   $82, $a7, $af, $82, $54, $54, $84, $8b        ;; 0e:4bc5 ????????
    db   $84, $8b, $54, $54, $84, $8b, $88, $89        ;; 0e:4bcd ????????
    db   $d8, $e2, $9f, $4b, $dc, $55, $55, $a5        ;; 0e:4bd5 ????????
    db   $ab, $ac, $d8, $a5, $dc, $55, $55, $55        ;; 0e:4bdd ????????
    db   $a5, $ab, $d8, $a2, $a7, $dc, $55, $54        ;; 0e:4be5 ????????
    db   $54, $a4, $a9, $ab, $d8, $a4, $dc, $84        ;; 0e:4bed ????????
    db   $d8, $84, $e0, $55, $7a, $dc, $59, $d8        ;; 0e:4bf5 ????????
    db   $59, $57, $dc, $87, $55, $e0, $3f, $7a        ;; 0e:4bfd ????????
    db   $85, $8b, $8c, $85, $85, $8b, $8c, $86        ;; 0e:4c05 ????????
    db   $86, $89, $8c, $86, $86, $89, $e0, $55        ;; 0e:4c0d ????????
    db   $7a, $54, $e0, $3f, $7a, $84, $89, $8b        ;; 0e:4c15 ????????
    db   $84, $84, $89, $8b, $84, $84, $8b, $d8        ;; 0e:4c1d ????????
    db   $82, $dc, $84, $84, $8b, $d8, $82, $e1        ;; 0e:4c25 ????????
    db   $9d, $4b                                      ;; 0e:4c2d ??

data_0e_4c2f:
    db   $e0, $43, $7a, $e5, $00, $e6, $03, $e3        ;; 0e:4c2f ????????
    db   $02, $ea, $02, $d1, $a9, $a9, $a9, $a9        ;; 0e:4c37 ????????
    db   $ac, $a9, $a9, $a9, $d8, $a2, $dc, $a9        ;; 0e:4c3f ????????
    db   $d8, $a3, $dc, $a9, $d8, $a2, $80, $a0        ;; 0e:4c47 ????????
    db   $e9, $3a, $4c, $ea, $02, $dc, $ab, $ab        ;; 0e:4c4f ????????
    db   $ab, $ab, $d8, $a2, $dc, $ab, $ab, $ab        ;; 0e:4c57 ????????
    db   $d8, $a4, $dc, $ab, $d8, $a5, $dc, $ab        ;; 0e:4c5f ????????
    db   $d8, $a4, $82, $a2, $e9, $54, $4c, $e2        ;; 0e:4c67 ????????
    db   $38, $4c, $e3, $02, $e6, $02, $dc, $a9        ;; 0e:4c6f ????????
    db   $a9, $a9, $a9, $ac, $a9, $a9, $a9, $d8        ;; 0e:4c77 ????????
    db   $a2, $dc, $a9, $d8, $a4, $dc, $a9, $d8        ;; 0e:4c7f ????????
    db   $a2, $80, $a0, $e6, $01, $dc, $a5, $a5        ;; 0e:4c87 ????????
    db   $a5, $a5, $a9, $a5, $a5, $a5, $ab, $a5        ;; 0e:4c8f ????????
    db   $ac, $a5, $ab, $89, $a9, $e6, $02, $a7        ;; 0e:4c97 ????????
    db   $a7, $a7, $a7, $ab, $a7, $a7, $a7, $ac        ;; 0e:4c9f ????????
    db   $a7, $d8, $a2, $dc, $a7, $ac, $8b, $ab        ;; 0e:4ca7 ????????
    db   $e6, $01, $a4, $a4, $a4, $a4, $a8, $a4        ;; 0e:4caf ????????
    db   $a4, $a4, $a9, $a4, $ab, $a4, $a9, $88        ;; 0e:4cb7 ????????
    db   $a8, $e6, $02, $a5, $a5, $a5, $a5, $a9        ;; 0e:4cbf ????????
    db   $a5, $a5, $a5, $ab, $a5, $ac, $a5, $ab        ;; 0e:4cc7 ????????
    db   $89, $a9, $e6, $01, $a7, $a7, $a7, $a7        ;; 0e:4ccf ????????
    db   $ab, $a7, $a7, $a7, $ac, $a7, $d8, $a2        ;; 0e:4cd7 ????????
    db   $dc, $a7, $ac, $8b, $ab, $e6, $02, $a4        ;; 0e:4cdf ????????
    db   $a4, $a4, $a4, $a9, $a4, $a4, $a4, $ab        ;; 0e:4ce7 ????????
    db   $a4, $ac, $a4, $ab, $89, $a9, $e6, $01        ;; 0e:4cef ????????
    db   $a4, $a4, $a4, $a4, $d8, $a4, $dc, $a4        ;; 0e:4cf7 ????????
    db   $a4, $a4, $d8, $a2, $dc, $a4, $ac, $a4        ;; 0e:4cff ????????
    db   $ab, $a9, $a8, $ab, $d8, $e2, $73, $4c        ;; 0e:4d07 ????????
    db   $e6, $02, $80, $a4, $a5, $80, $a4, $a5        ;; 0e:4d0f ????????
    db   $80, $a4, $a5, $80, $a4, $a5, $e6, $01        ;; 0e:4d17 ????????
    db   $dc, $8b, $d8, $a2, $a7, $dc, $8b, $d8        ;; 0e:4d1f ????????
    db   $a2, $a7, $dc, $8b, $d8, $a2, $a7, $dc        ;; 0e:4d27 ????????
    db   $8b, $d8, $a2, $a7, $e6, $02, $dc, $8b        ;; 0e:4d2f ????????
    db   $d8, $a2, $a7, $dc, $8b, $d8, $a2, $a7        ;; 0e:4d37 ????????
    db   $dc, $8b, $d8, $a2, $a7, $dc, $8b, $d8        ;; 0e:4d3f ????????
    db   $a2, $a7, $e0, $57, $7a, $e6, $03, $89        ;; 0e:4d47 ????????
    db   $84, $80, $89, $87, $82, $dc, $8b, $e6        ;; 0e:4d4f ????????
    db   $02, $5c, $e0, $43, $7a, $ac, $ac, $d8        ;; 0e:4d57 ????????
    db   $85, $a5, $a5, $84, $a4, $a4, $82, $a0        ;; 0e:4d5f ????????
    db   $a0, $e6, $01, $80, $a0, $a0, $84, $a4        ;; 0e:4d67 ????????
    db   $a4, $82, $a2, $a2, $80, $a0, $a0, $e6        ;; 0e:4d6f ????????
    db   $03, $dc, $ab, $ab, $ab, $ab, $d8, $a2        ;; 0e:4d77 ????????
    db   $dc, $ab, $ab, $ab, $d8, $a4, $dc, $ab        ;; 0e:4d7f ????????
    db   $d8, $a5, $dc, $ab, $d8, $a4, $82, $a2        ;; 0e:4d87 ????????
    db   $e6, $02, $dc, $a4, $a4, $a4, $a4, $e6        ;; 0e:4d8f ????????
    db   $03, $a8, $a4, $a4, $a4, $e6, $01, $a9        ;; 0e:4d97 ????????
    db   $a4, $ab, $a4, $e6, $03, $a9, $88, $a8        ;; 0e:4d9f ????????
    db   $d8, $e1, $71, $4c                            ;; 0e:4da7 ????

data_0e_4dab:
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

data_0e_4e15:
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

data_0e_4e7a:
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

data_0e_4ed6:
    db   $e4, $fe, $79, $e8, $a5, $7a, $e0, $20        ;; 0e:4ed6 ........
    db   $e6, $03, $d2, $8f, $53, $d8, $93, $dc        ;; 0e:4ede .w......
    db   $9a, $97, $55, $dc, $55, $17, $5f, $d8        ;; 0e:4ee6 ......??
    db   $e3, $08, $e6, $03, $80, $e6, $01, $ab        ;; 0e:4eee ????????
    db   $ac, $e6, $03, $dc, $87, $e6, $02, $d8        ;; 0e:4ef6 ????????
    db   $ab, $d8, $a2, $dc, $e2, $f0, $4e, $e3        ;; 0e:4efe ????????
    db   $08, $e6, $03, $81, $ad, $af, $a7, $a8        ;; 0e:4f06 ????????
    db   $8d, $e2, $07, $4f, $e1, $ee, $4e             ;; 0e:4f0e ???????

data_0e_4f15:
    db   $e7, $96, $e4, $fe, $79, $e0, $53, $7a        ;; 0e:4f15 ????????
    db   $e5, $40, $e6, $03, $e3, $04, $d3, $ab        ;; 0e:4f1d ????????
    db   $ac, $a6, $a7, $dc, $ab, $ac, $a6, $a7        ;; 0e:4f25 ????????
    db   $e2, $23, $4f, $e3, $04, $a5, $a4, $aa        ;; 0e:4f2d ????????
    db   $a9, $d8, $a3, $a2, $a8, $a7, $dc, $e2        ;; 0e:4f35 ????????
    db   $32, $4f, $e1, $21, $4f                       ;; 0e:4f3d ?????

data_0e_4f42:
    db   $e4, $fe, $79, $e0, $57, $7a, $e5, $40        ;; 0e:4f42 ????????
    db   $e3, $04, $e6, $02, $d1, $a0, $af, $e6        ;; 0e:4f4a ????????
    db   $03, $a0, $af, $e6, $01, $a0, $af, $e6        ;; 0e:4f52 ????????
    db   $03, $a0, $af, $e2, $4c, $4f, $dc, $e3        ;; 0e:4f5a ????????
    db   $04, $e6, $01, $aa, $af, $e6, $03, $aa        ;; 0e:4f62 ????????
    db   $af, $e6, $02, $aa, $af, $e6, $03, $aa        ;; 0e:4f6a ????????
    db   $af, $e2, $63, $4f, $e1, $4a, $4f             ;; 0e:4f72 ???????

data_0e_4f79:
    db   $e4, $fe, $79, $e8, $85, $7a, $e0, $40        ;; 0e:4f79 ????????
    db   $e6, $03, $e3, $04, $d2, $a0, $ac, $a3        ;; 0e:4f81 ????????
    db   $d8, $a3, $dc, $a6, $d8, $a6, $dc, $a3        ;; 0e:4f89 ????????
    db   $d8, $a3, $e2, $85, $4f, $e3, $04, $dd        ;; 0e:4f91 ????????
    db   $aa, $d8, $aa, $a1, $ad, $a0, $ac, $a3        ;; 0e:4f99 ????????
    db   $d8, $a3, $e2, $98, $4f, $e1, $83, $4f        ;; 0e:4fa1 ????????

data_0e_4fa9:
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

data_0e_500d:
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

data_0e_5134:
    db   $e8, $75, $7a, $e0, $40, $e6, $03, $0f        ;; 0e:5134 ......w.
    db   $0f, $0f, $0f                                 ;; 0e:513c ...
.data_0e_513f:
    db   $d2, $02, $00, $dc, $0a, $09, $e1             ;; 0e:513f .......
    dw   .data_0e_513f                                 ;; 0e:5146 pP

data_0e_5148:
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
    db   $8e, $e7, $37, $8e, $e1, $50, $51             ;; 0e:51b8 ???????

data_0e_51bf:
    db   $e4, $fe, $79, $e0, $4b, $7a, $e5, $40        ;; 0e:51bf ????????
    db   $e6, $03, $e3, $02, $d2, $84, $87, $84        ;; 0e:51c7 ????????
    db   $87, $84, $87, $84, $87, $86, $89, $86        ;; 0e:51cf ????????
    db   $89, $86, $89, $86, $89, $84, $8b, $84        ;; 0e:51d7 ????????
    db   $8b, $84, $8b, $84, $8b, $86, $89, $86        ;; 0e:51df ????????
    db   $89, $86, $89, $86, $89, $84, $87, $84        ;; 0e:51e7 ????????
    db   $87, $84, $87, $84, $87, $86, $89, $86        ;; 0e:51ef ????????
    db   $89, $86, $89, $86, $89, $eb, $01, $13        ;; 0e:51f7 ????????
    db   $52, $84, $86, $84, $86, $84, $86, $84        ;; 0e:51ff ????????
    db   $86, $84, $86, $84, $86, $83, $86, $83        ;; 0e:5207 ????????
    db   $89, $e2, $cb, $51, $84, $87, $84, $87        ;; 0e:520f ????????
    db   $84, $87, $84, $87, $84, $87, $84, $87        ;; 0e:5217 ????????
    db   $84, $87, $84, $87, $e0, $36, $7a, $e5        ;; 0e:521f ????????
    db   $40, $e6, $02, $25, $e5, $80, $e6, $01        ;; 0e:5227 ????????
    db   $85, $87, $89, $8c, $d8, $52, $e5, $40        ;; 0e:522f ????????
    db   $e6, $02, $dc, $82, $84, $85, $87, $89        ;; 0e:5237 ????????
    db   $8b, $29, $e5, $00, $e6, $01, $85, $87        ;; 0e:523f ????????
    db   $89, $8c, $5b, $e5, $40, $e6, $02, $dc        ;; 0e:5247 ????????
    db   $8b, $8c, $d8, $82, $84, $85, $87, $25        ;; 0e:524f ????????
    db   $e5, $80, $e6, $01, $85, $87, $89, $8c        ;; 0e:5257 ????????
    db   $d8, $52, $e5, $40, $e6, $02, $dc, $82        ;; 0e:525f ????????
    db   $84, $85, $87, $89, $8b, $29, $e5, $00        ;; 0e:5267 ????????
    db   $e6, $03, $85, $87, $89, $8c, $8b, $86        ;; 0e:526f ????????
    db   $84, $86, $83, $89, $87, $86, $e1, $bf        ;; 0e:5277 ????????
    db   $51                                           ;; 0e:527f ?

data_0e_5280:
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
    db   $52                                           ;; 0e:5360 ?

data_0e_5361:
    db   $e7, $78, $e4, $24, $7a, $e5, $00, $e0        ;; 0e:5361 ????????
    db   $69, $7a, $e6, $03, $0f, $0f, $0f, $0f        ;; 0e:5369 ????????
    db   $0f, $0f, $d4, $10, $dc, $07, $2e, $57        ;; 0e:5371 ????????
    db   $55, $57, $1a, $05, $2e, $1f, $1c, $07        ;; 0e:5379 ????????
    db   $2e, $57, $55, $57, $28, $53, $1d, $e6        ;; 0e:5381 ????????
    db   $02, $e0, $6f, $7a, $d8, $28, $53, $1d        ;; 0e:5389 ????????
    db   $e1, $68, $53                                 ;; 0e:5391 ???

data_0e_5394:
    db   $e4, $fe, $79, $e0, $73, $7a, $e5, $80        ;; 0e:5394 ????????
    db   $e6, $02, $af, $e3, $02, $d2, $80, $82        ;; 0e:539c ????????
    db   $85, $87, $89, $8c, $d8, $82, $85, $87        ;; 0e:53a4 ????????
    db   $89, $8c, $d8, $82, $e2, $a1, $53, $e3        ;; 0e:53ac ????????
    db   $02, $dd, $81, $83, $86, $88, $8a, $8d        ;; 0e:53b4 ????????
    db   $d8, $83, $86, $88, $8a, $8d, $d8, $83        ;; 0e:53bc ????????
    db   $e2, $b5, $53, $e1, $9f, $53                  ;; 0e:53c4 ??????

data_0e_53ca:
    db   $e4, $fe, $79, $e8, $75, $7a, $e0, $40        ;; 0e:53ca ????????
    db   $e6, $01, $e3, $02, $d3, $80, $82, $85        ;; 0e:53d2 ????????
    db   $87, $89, $8c, $d8, $82, $85, $87, $89        ;; 0e:53da ????????
    db   $8c, $d8, $82, $e2, $d6, $53, $e3, $02        ;; 0e:53e2 ????????
    db   $dd, $81, $83, $86, $88, $8a, $8d, $d8        ;; 0e:53ea ????????
    db   $83, $86, $88, $8a, $8d, $d8, $83, $e2        ;; 0e:53f2 ????????
    db   $ea, $53, $e1, $d4, $53                       ;; 0e:53fa ?????

data_0e_53ff:
    db   $e7, $46, $e4, $fe, $79, $e0, $31, $7a        ;; 0e:53ff ????????
    db   $e5, $80, $e6, $03, $d3, $57, $85, $84        ;; 0e:5407 ????????
    db   $45, $85, $83, $dc, $8a, $8c, $8d, $5c        ;; 0e:540f ????????
    db   $5a, $88, $8c, $d8, $85, $88, $87, $82        ;; 0e:5417 ????????
    db   $85, $84, $07, $54, $82, $81, $42, $82        ;; 0e:541f ????????
    db   $81, $dc, $88, $8b, $89, $5d, $5b, $49        ;; 0e:5427 ????????
    db   $89, $58, $88, $89, $09, $e1, $0b, $54        ;; 0e:542f ????????

data_0e_5437:
    db   $e4, $fe, $79, $e0, $73, $7a, $e5, $80        ;; 0e:5437 ????????
    db   $e6, $02, $af, $d2, $80, $87, $8c, $d8        ;; 0e:543f ????????
    db   $84, $dc, $81, $88, $8d, $d8, $85, $dc        ;; 0e:5447 ????????
    db   $83, $8a, $d8, $83, $87, $dc, $88, $8c        ;; 0e:544f ????????
    db   $87, $d8, $83, $dc, $85, $88, $8c, $d8        ;; 0e:5457 ????????
    db   $85, $dc, $87, $d8, $82, $87, $8b, $dc        ;; 0e:545f ????????
    db   $80, $87, $8c, $d8, $84, $dc, $81, $87        ;; 0e:5467 ????????
    db   $8d, $d8, $85, $dd, $89, $d8, $84, $89        ;; 0e:546f ????????
    db   $8d, $dc, $8b, $d8, $86, $8b, $d8, $82        ;; 0e:5477 ????????
    db   $dc, $81, $88, $8d, $d8, $85, $dc, $86        ;; 0e:547f ????????
    db   $89, $84, $8b, $82, $89, $d8, $82, $86        ;; 0e:5487 ????????
    db   $dc, $84, $88, $8b, $d8, $84, $dd, $85        ;; 0e:548f ????????
    db   $8c, $d8, $89, $d8, $85, $dd, $87, $d8        ;; 0e:5497 ????????
    db   $82, $8b, $d8, $87, $e1, $42, $54             ;; 0e:549f ???????

data_0e_54a6:
    db   $e4, $fe, $79, $e8, $75, $7a, $e0, $40        ;; 0e:54a6 ????????
    db   $e6, $01, $d3, $80, $87, $8c, $d8, $84        ;; 0e:54ae ????????
    db   $dc, $81, $88, $8d, $d8, $85, $dc, $83        ;; 0e:54b6 ????????
    db   $8a, $d8, $83, $87, $dc, $88, $8c, $87        ;; 0e:54be ????????
    db   $d8, $83, $dc, $85, $88, $8c, $d8, $85        ;; 0e:54c6 ????????
    db   $dc, $87, $d8, $82, $87, $8b, $dc, $80        ;; 0e:54ce ????????
    db   $87, $8c, $d8, $84, $dc, $81, $87, $8d        ;; 0e:54d6 ????????
    db   $d8, $85, $dd, $89, $d8, $84, $89, $8d        ;; 0e:54de ????????
    db   $dc, $8b, $d8, $86, $8b, $d8, $82, $dc        ;; 0e:54e6 ????????
    db   $81, $88, $8d, $d8, $85, $dc, $86, $89        ;; 0e:54ee ????????
    db   $84, $8b, $82, $89, $d8, $82, $86, $dc        ;; 0e:54f6 ????????
    db   $84, $88, $8b, $d8, $84, $dd, $85, $8c        ;; 0e:54fe ????????
    db   $d8, $89, $d8, $85, $dd, $87, $d8, $82        ;; 0e:5506 ????????
    db   $8b, $d8, $87, $e1, $b0, $54                  ;; 0e:550e ??????

data_0e_5514:
    db   $e7, $55, $e4, $fe, $79, $e0, $36, $7a        ;; 0e:5514 ????????
    db   $e6, $03, $e3, $02, $e5, $80, $d2, $a8        ;; 0e:551c ????????
    db   $aa, $ab, $aa, $ab, $ad, $d8, $a3, $a1        ;; 0e:5524 ????????
    db   $dc, $ab, $ad, $ab, $aa, $a8, $aa, $a8        ;; 0e:552c ????????
    db   $a6, $e5, $40, $a8, $aa, $ab, $aa, $ab        ;; 0e:5534 ????????
    db   $ad, $d8, $a3, $a1, $dc, $ab, $ad, $ab        ;; 0e:553c ????????
    db   $aa, $a8, $aa, $a8, $a6, $e5, $80, $a4        ;; 0e:5544 ????????
    db   $a6, $a7, $a6, $a7, $a9, $ab, $a9, $a7        ;; 0e:554c ????????
    db   $a9, $a7, $a6, $a4, $a6, $a4, $a2, $eb        ;; 0e:5554 ????????
    db   $01, $74, $55, $e5, $40, $a4, $a6, $a7        ;; 0e:555c ????????
    db   $a6, $a7, $a9, $ab, $a9, $a7, $a9, $a7        ;; 0e:5564 ????????
    db   $a6, $a4, $a6, $a7, $a9, $e2, $20, $55        ;; 0e:556c ????????
    db   $e5, $40, $a4, $a6, $a7, $a6, $a7, $a9        ;; 0e:5574 ????????
    db   $ab, $a9, $a7, $a9, $a7, $a6, $a4, $a6        ;; 0e:557c ????????
    db   $a4, $a2, $e3, $06, $e5, $00, $a1, $af        ;; 0e:5584 ????????
    db   $c1, $cf, $c1, $cf, $e2, $88, $55, $81        ;; 0e:558c ????????
    db   $a2, $af, $81, $a2, $af, $e3, $06, $a3        ;; 0e:5594 ????????
    db   $af, $c3, $cf, $c3, $cf, $e2, $9b, $55        ;; 0e:559c ????????
    db   $83, $a4, $af, $83, $a4, $af, $e5, $40        ;; 0e:55a4 ????????
    db   $45, $a4, $a5, $46, $a5, $a6, $a7, $a5        ;; 0e:55ac ????????
    db   $a7, $a9, $aa, $a9, $aa, $ac, $d8, $82        ;; 0e:55b4 ????????
    db   $a0, $dc, $aa, $89, $85, $07, $e1, $1e        ;; 0e:55bc ????????
    db   $55                                           ;; 0e:55c4 ?

data_0e_55c5:
    db   $e4, $fe, $79, $e0, $36, $7a, $e5, $80        ;; 0e:55c5 ????????
    db   $e3, $02, $e6, $01, $d2, $a1, $a3, $a4        ;; 0e:55cd ????????
    db   $a3, $a1, $af, $a4, $a3, $a1, $af, $a4        ;; 0e:55d5 ????????
    db   $a3, $a1, $af, $a4, $a3, $e6, $03, $e5        ;; 0e:55dd ????????
    db   $40, $a1, $a3, $a4, $a3, $a1, $af, $a4        ;; 0e:55e5 ????????
    db   $a3, $a1, $af, $a4, $a3, $a1, $af, $a1        ;; 0e:55ed ????????
    db   $dc, $ab, $e6, $02, $e5, $80, $a9, $ab        ;; 0e:55f5 ????????
    db   $ac, $ab, $a9, $af, $ac, $ab, $a9, $af        ;; 0e:55fd ????????
    db   $ac, $ab, $a9, $af, $ac, $ab, $eb, $01        ;; 0e:5605 ????????
    db   $26, $56, $e6, $03, $e5, $40, $a9, $ab        ;; 0e:560d ????????
    db   $ac, $ab, $a9, $af, $ac, $ab, $a9, $af        ;; 0e:5615 ????????
    db   $ac, $ab, $a9, $ab, $ac, $ab, $e2, $cf        ;; 0e:561d ????????
    db   $55, $e6, $03, $e5, $40, $a9, $ab, $ac        ;; 0e:5625 ????????
    db   $ab, $a9, $af, $ac, $ab, $a9, $af, $ac        ;; 0e:562d ????????
    db   $ab, $a9, $af, $ac, $ab, $e3, $02, $e6        ;; 0e:5635 ????????
    db   $02, $e5, $80, $a9, $ab, $e6, $03, $a9        ;; 0e:563d ????????
    db   $a8, $e6, $01, $a9, $ab, $e6, $03, $a9        ;; 0e:5645 ????????
    db   $a8, $e2, $3c, $56, $e6, $02, $a9, $ab        ;; 0e:564d ????????
    db   $e6, $03, $a9, $a8, $e6, $01, $a9, $ab        ;; 0e:5655 ????????
    db   $e6, $02, $a9, $a8, $e6, $03, $89, $aa        ;; 0e:565d ????????
    db   $af, $89, $aa, $af, $e3, $02, $e6, $02        ;; 0e:5665 ????????
    db   $ab, $ad, $e6, $03, $ab, $aa, $e6, $01        ;; 0e:566d ????????
    db   $ab, $ad, $e6, $03, $ab, $aa, $e2, $6b        ;; 0e:5675 ????????
    db   $56, $e6, $02, $ab, $ad, $e6, $03, $ab        ;; 0e:567d ????????
    db   $aa, $e6, $01, $ab, $ad, $e6, $02, $ab        ;; 0e:5685 ????????
    db   $aa, $e6, $03, $e5, $00, $8b, $ac, $af        ;; 0e:568d ????????
    db   $8b, $ac, $af, $d8, $52, $51, $53, $52        ;; 0e:5695 ????????
    db   $23, $55, $83, $82, $50, $51, $52, $51        ;; 0e:569d ????????
    db   $e1, $cd, $55                                 ;; 0e:56a5 ???

data_0e_56a8:
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
    db   $a4, $a3, $a2, $e1, $b0, $56                  ;; 0e:5708 ??????

data_0e_570e:
    db   $e7, $6b, $e4, $fe, $79, $e5, $40, $e0        ;; 0e:570e ????????
    db   $6b, $7a, $e6, $03, $e3, $02, $d2, $34        ;; 0e:5716 ????????
    db   $92, $94, $97, $9f, $96, $9f, $92, $9f        ;; 0e:571e ????????
    db   $34, $92, $94, $97, $9f, $96, $9f, $92        ;; 0e:5726 ????????
    db   $9f, $96, $92, $96, $39, $9f, $9c, $9b        ;; 0e:572e ????????
    db   $99, $97, $eb, $01, $47, $57, $36, $97        ;; 0e:5736 ????????
    db   $98, $29, $e2, $1c, $57, $34, $92, $94        ;; 0e:573e ????????
    db   $97, $26, $2f, $98, $96, $94, $2b, $9d        ;; 0e:5746 ????????
    db   $98, $9b, $99, $98, $96, $29, $9b, $96        ;; 0e:574e ????????
    db   $99, $98, $96, $94, $2b, $9d, $98, $9b        ;; 0e:5756 ????????
    db   $39, $98, $96, $54, $58, $36, $96, $96        ;; 0e:575e ????????
    db   $36, $96, $96, $e0, $3f, $7a, $96, $96        ;; 0e:5766 ????????
    db   $96, $96, $96, $96, $96, $9f, $9f, $5f        ;; 0e:576e ????????
    db   $e1, $15, $57                                 ;; 0e:5776 ???

data_0e_5779:
    db   $e4, $fe, $79, $e5, $00, $e0, $59, $7a        ;; 0e:5779 ????????
    db   $e3, $02, $e6, $03, $d2, $50, $e6, $01        ;; 0e:5781 ????????
    db   $90, $dc, $9b, $9a, $e6, $03, $59, $e6        ;; 0e:5789 ????????
    db   $02, $99, $9a, $9b, $e6, $03, $5c, $e6        ;; 0e:5791 ????????
    db   $01, $9c, $9b, $9a, $e6, $03, $59, $e6        ;; 0e:5799 ????????
    db   $02, $99, $9a, $9b, $e6, $03, $d8, $92        ;; 0e:57a1 ????????
    db   $dc, $99, $d8, $92, $e6, $01, $56, $e6        ;; 0e:57a9 ????????
    db   $02, $54, $e6, $03, $62, $dc, $99, $eb        ;; 0e:57b1 ????????
    db   $01, $cf, $57, $e6, $01, $d8, $52, $e6        ;; 0e:57b9 ????????
    db   $02, $92, $94, $95, $66, $e6, $03, $64        ;; 0e:57c1 ????????
    db   $e6, $01, $62, $e2, $83, $57, $e0, $47        ;; 0e:57c9 ????????
    db   $7a, $e6, $03, $d8, $92, $94, $92, $90        ;; 0e:57d1 ????????
    db   $92, $90, $dc, $9b, $9c, $9b, $99, $9b        ;; 0e:57d9 ????????
    db   $99, $e0, $59, $7a, $d8, $94, $93, $dc        ;; 0e:57e1 ????????
    db   $98, $d8, $48, $be, $96, $54, $96, $92        ;; 0e:57e9 ????????
    db   $dc, $99, $d8, $16, $94, $93, $dc, $98        ;; 0e:57f1 ????????
    db   $d8, $48, $be, $96, $54, $52, $96, $94        ;; 0e:57f9 ????????
    db   $92, $dc, $3b, $9d, $9b, $e6, $01, $3b        ;; 0e:5801 ????????
    db   $e6, $02, $9b, $9b, $e6, $01, $3b, $e6        ;; 0e:5809 ????????
    db   $02, $9b, $9b, $e0, $47, $7a, $e6, $03        ;; 0e:5811 ????????
    db   $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9f        ;; 0e:5819 ????????
    db   $9f, $5f, $e1, $7e, $57                       ;; 0e:5821 ?????

data_0e_5826:
    db   $e8, $85, $7a, $e0, $40, $e3, $02, $e6        ;; 0e:5826 ????????
    db   $03, $d1, $89, $8f, $e6, $02, $89, $8f        ;; 0e:582e ????????
    db   $e6, $03, $89, $8f, $e6, $01, $69, $d8        ;; 0e:5836 ????????
    db   $94, $e6, $03, $dc, $89, $8f, $e6, $02        ;; 0e:583e ????????
    db   $89, $8f, $e6, $03, $89, $8f, $e6, $01        ;; 0e:5846 ????????
    db   $69, $d8, $94, $e6, $03, $82, $8f, $e6        ;; 0e:584e ????????
    db   $02, $82, $8f, $e6, $03, $82, $8f, $e6        ;; 0e:5856 ????????
    db   $01, $62, $dc, $99, $eb, $01, $7a, $58        ;; 0e:585e ????????
    db   $e6, $03, $d8, $82, $8f, $82, $8f, $e6        ;; 0e:5866 ????????
    db   $02, $62, $e6, $03, $60, $e6, $01, $dc        ;; 0e:586e ????????
    db   $6b, $e2, $2d, $58, $e6, $03, $d8, $22        ;; 0e:5876 ????????
    db   $9e, $94, $92, $90, $92, $90, $e6, $02        ;; 0e:587e ????????
    db   $81, $8f, $e6, $01, $81, $8f, $e6, $02        ;; 0e:5886 ????????
    db   $81, $8f, $e6, $03, $91, $94, $91, $e6        ;; 0e:588e ????????
    db   $01, $82, $8f, $e6, $02, $82, $8f, $e6        ;; 0e:5896 ????????
    db   $01, $82, $8f, $e6, $03, $92, $96, $92        ;; 0e:589e ????????
    db   $e6, $02, $81, $8f, $e6, $01, $81, $8f        ;; 0e:58a6 ????????
    db   $e6, $02, $81, $8f, $e6, $03, $91, $94        ;; 0e:58ae ????????
    db   $91, $e6, $02, $dc, $2b, $e6, $01, $2d        ;; 0e:58b6 ????????
    db   $e6, $03, $86, $8f, $86, $8f, $86, $8f        ;; 0e:58be ????????
    db   $96, $d8, $96, $91, $dc, $b6, $bf, $b6        ;; 0e:58c6 ????????
    db   $bf, $b6, $bf, $b6, $bf, $b6, $bf, $b6        ;; 0e:58ce ????????
    db   $bf, $96, $9f, $d8, $94, $92, $90, $dc        ;; 0e:58d6 ????????
    db   $9b, $e1, $2b, $58                            ;; 0e:58de ????

data_0e_58e2:
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

data_0e_5968:
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

data_0e_5a10:
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

data_0e_5a73:
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
    db   $8f, $dc, $a7, $a8, $e1, $82, $5a             ;; 0e:5b33 ???????

data_0e_5b3a:
    db   $e4, $fe, $79, $e0, $59, $7a, $e5, $40        ;; 0e:5b3a ????????
    db   $8f, $e3, $02, $e6, $01, $d2, $a4, $af        ;; 0e:5b42 ????????
    db   $a4, $a3, $e6, $02, $a4, $af, $a4, $a3        ;; 0e:5b4a ????????
    db   $e6, $01, $a4, $af, $a4, $a3, $e6, $02        ;; 0e:5b52 ????????
    db   $a4, $af, $a4, $a3, $e6, $01, $a1, $af        ;; 0e:5b5a ????????
    db   $a1, $dc, $ab, $e6, $02, $ad, $af, $ad        ;; 0e:5b62 ????????
    db   $ab, $e6, $01, $d8, $a3, $af, $a3, $a1        ;; 0e:5b6a ????????
    db   $e6, $02, $a3, $a4, $a6, $a3, $eb, $01        ;; 0e:5b72 ????????
    db   $9b, $5b, $e6, $01, $8f, $81, $84, $83        ;; 0e:5b7a ????????
    db   $e6, $02, $84, $86, $84, $81, $e6, $01        ;; 0e:5b82 ????????
    db   $8f, $dc, $89, $d8, $84, $81, $e6, $02        ;; 0e:5b8a ????????
    db   $83, $86, $83, $dc, $8b, $d8, $e2, $45        ;; 0e:5b92 ????????
    db   $5b, $e6, $01, $a4, $a6, $a4, $a3, $e6        ;; 0e:5b9a ????????
    db   $02, $a4, $a6, $a4, $a3, $e6, $01, $a6        ;; 0e:5ba2 ????????
    db   $a8, $a6, $a4, $e6, $02, $a6, $a8, $a6        ;; 0e:5baa ????????
    db   $a4, $e6, $03, $8f, $86, $88, $89, $88        ;; 0e:5bb2 ????????
    db   $86, $84, $83, $e0, $31, $7a, $e6, $01        ;; 0e:5bba ????????
    db   $24, $51, $54, $e6, $02, $59, $5b, $8d        ;; 0e:5bc2 ????????
    db   $89, $8b, $8d, $e6, $01, $ac, $ad, $ac        ;; 0e:5bca ????????
    db   $aa, $ac, $af, $e6, $03, $ac, $ad, $ac        ;; 0e:5bd2 ????????
    db   $aa, $ac, $af, $e6, $02, $ac, $ad, $ac        ;; 0e:5bda ????????
    db   $aa, $ac, $e0, $5b, $7a, $e5, $80, $e6        ;; 0e:5be2 ????????
    db   $03, $a1, $a0, $dc, $a9, $ac, $ad, $ac        ;; 0e:5bea ????????
    db   $a9, $ac, $ad, $d8, $a3, $a4, $a6, $a8        ;; 0e:5bf2 ????????
    db   $a9, $ab, $e3, $02, $e6, $01, $e0, $59        ;; 0e:5bfa ????????
    db   $7a, $e5, $40, $a1, $af, $a1, $dc, $ab        ;; 0e:5c02 ????????
    db   $e6, $02, $ad, $af, $ad, $ab, $e6, $01        ;; 0e:5c0a ????????
    db   $ad, $af, $ad, $ab, $e6, $02, $ad, $af        ;; 0e:5c12 ????????
    db   $ad, $ab, $e6, $01, $ad, $af, $ad, $ab        ;; 0e:5c1a ????????
    db   $e6, $02, $ad, $af, $ad, $ab, $e6, $01        ;; 0e:5c22 ????????
    db   $ad, $af, $ad, $ab, $e6, $02, $ad, $af        ;; 0e:5c2a ????????
    db   $ad, $ab, $e6, $01, $ab, $af, $ab, $ad        ;; 0e:5c32 ????????
    db   $e6, $02, $ab, $af, $ab, $ad, $e6, $01        ;; 0e:5c3a ????????
    db   $ab, $af, $ab, $ad, $e6, $02, $ab, $af        ;; 0e:5c42 ????????
    db   $ab, $ad, $d8, $e6, $03, $58, $56, $84        ;; 0e:5c4a ????????
    db   $81, $86, $88, $eb, $01, $b5, $5c, $e6        ;; 0e:5c52 ????????
    db   $02, $dc, $a9, $ab, $a9, $a8, $a9, $e6        ;; 0e:5c5a ????????
    db   $03, $af, $a9, $ab, $a9, $a8, $a9, $e6        ;; 0e:5c62 ????????
    db   $01, $af, $a9, $ab, $a9, $a8, $e6, $03        ;; 0e:5c6a ????????
    db   $d8, $a3, $a4, $a3, $a1, $a1, $a3, $a1        ;; 0e:5c72 ????????
    db   $dc, $ab, $e6, $02, $d8, $63, $e6, $03        ;; 0e:5c7a ????????
    db   $64, $e6, $01, $66, $e6, $02, $a1, $a3        ;; 0e:5c82 ????????
    db   $a1, $dc, $ab, $ad, $e6, $03, $af, $ad        ;; 0e:5c8a ????????
    db   $d8, $a3, $a1, $dc, $ab, $ad, $e6, $01        ;; 0e:5c92 ????????
    db   $af, $ad, $d8, $a3, $a1, $dc, $ab, $e6        ;; 0e:5c9a ????????
    db   $03, $d8, $56, $54, $e6, $02, $83, $dc        ;; 0e:5ca2 ????????
    db   $8b, $d8, $e6, $01, $86, $dc, $8b, $d8        ;; 0e:5caa ????????
    db   $e2, $fe, $5b, $e6, $01, $8f, $81, $83        ;; 0e:5cb2 ????????
    db   $81, $e6, $02, $8f, $83, $84, $83, $e6        ;; 0e:5cba ????????
    db   $01, $84, $a3, $a4, $e6, $03, $86, $a4        ;; 0e:5cc2 ????????
    db   $a6, $e6, $02, $88, $a6, $a8, $e6, $03        ;; 0e:5cca ????????
    db   $89, $a8, $a9, $2b, $5a, $87, $a8, $aa        ;; 0e:5cd2 ????????
    db   $8c, $8f, $40, $e6, $02, $80, $e6, $03        ;; 0e:5cda ????????
    db   $81, $e6, $01, $83, $e1, $43, $5b             ;; 0e:5ce2 ???????

data_0e_5ce9:
    db   $e4, $fe, $79, $e8, $95, $7a, $e0, $20        ;; 0e:5ce9 ????????
    db   $8f, $e3, $02, $e6, $03, $d2, $81, $a8        ;; 0e:5cf1 ????????
    db   $af, $81, $a8, $af, $81, $a8, $af, $81        ;; 0e:5cf9 ????????
    db   $a8, $af, $dc, $89, $d8, $a4, $af, $dc        ;; 0e:5d01 ????????
    db   $89, $d8, $a4, $af, $dc, $8b, $d8, $a6        ;; 0e:5d09 ????????
    db   $af, $dc, $8b, $d8, $a6, $af, $eb, $01        ;; 0e:5d11 ????????
    db   $3a, $5d, $81, $5f, $e6, $02, $81, $dc        ;; 0e:5d19 ????????
    db   $e6, $03, $8b, $5f, $e6, $01, $8b, $e6        ;; 0e:5d21 ????????
    db   $03, $89, $5f, $e6, $02, $89, $e6, $03        ;; 0e:5d29 ????????
    db   $58, $d8, $a8, $af, $dc, $88, $e2, $f4        ;; 0e:5d31 ????????
    db   $5c, $dc, $86, $e6, $01, $ad, $af, $e6        ;; 0e:5d39 ????????
    db   $03, $86, $e6, $02, $ad, $af, $e6, $03        ;; 0e:5d41 ????????
    db   $8b, $e6, $01, $d8, $a6, $af, $e6, $03        ;; 0e:5d49 ????????
    db   $dc, $8b, $e6, $02, $d8, $a6, $af, $e6        ;; 0e:5d51 ????????
    db   $01, $54, $e6, $02, $53, $e6, $01, $52        ;; 0e:5d59 ????????
    db   $e6, $02, $51, $e6, $03, $dc, $19, $8e        ;; 0e:5d61 ????????
    db   $8f, $16, $8e, $8f, $e6, $01, $88, $5f        ;; 0e:5d69 ????????
    db   $e6, $03, $88, $5f, $e6, $02, $88, $0f        ;; 0e:5d71 ????????
    db   $8f, $e3, $02, $e6, $03, $89, $d8, $e6        ;; 0e:5d79 ????????
    db   $01, $a4, $af, $e6, $03, $dc, $89, $d8        ;; 0e:5d81 ????????
    db   $e6, $02, $a4, $af, $dc, $e6, $03, $89        ;; 0e:5d89 ????????
    db   $d8, $e6, $01, $a4, $af, $e6, $03, $dc        ;; 0e:5d91 ????????
    db   $89, $d8, $e6, $02, $a4, $af, $dc, $e6        ;; 0e:5d99 ????????
    db   $03, $89, $d8, $e6, $01, $a4, $af, $e6        ;; 0e:5da1 ????????
    db   $03, $dc, $89, $d8, $e6, $02, $a4, $af        ;; 0e:5da9 ????????
    db   $dc, $e6, $03, $89, $d8, $e6, $01, $a4        ;; 0e:5db1 ????????
    db   $af, $e6, $03, $dc, $89, $d8, $e6, $02        ;; 0e:5db9 ????????
    db   $a4, $af, $dc, $e6, $03, $88, $e6, $01        ;; 0e:5dc1 ????????
    db   $d8, $a3, $af, $e6, $03, $dc, $88, $e6        ;; 0e:5dc9 ????????
    db   $02, $d8, $a3, $af, $e6, $03, $dc, $88        ;; 0e:5dd1 ????????
    db   $e6, $01, $d8, $a3, $af, $e6, $03, $dc        ;; 0e:5dd9 ????????
    db   $88, $e6, $02, $d8, $a3, $af, $21, $e6        ;; 0e:5de1 ????????
    db   $01, $dc, $2b, $eb, $01, $23, $5e, $e6        ;; 0e:5de9 ????????
    db   $03, $86, $5f, $86, $5f, $a6, $af, $a6        ;; 0e:5df1 ????????
    db   $af, $5b, $59, $e6, $02, $68, $e6, $03        ;; 0e:5df9 ????????
    db   $69, $e6, $01, $6b, $e6, $03, $89, $5f        ;; 0e:5e01 ????????
    db   $89, $5f, $a9, $af, $a9, $af, $e6, $02        ;; 0e:5e09 ????????
    db   $5b, $e6, $01, $59, $e6, $03, $88, $d8        ;; 0e:5e11 ????????
    db   $a8, $af, $a3, $af, $dc, $a8, $af, $e2        ;; 0e:5e19 ????????
    db   $7c, $5d, $e6, $03, $56, $8f, $a6, $af        ;; 0e:5e21 ????????
    db   $58, $8f, $a8, $af, $59, $5b, $5d, $d8        ;; 0e:5e29 ????????
    db   $53, $e6, $02, $24, $e6, $01, $23, $e6        ;; 0e:5e31 ????????
    db   $03, $a8, $7f, $dc, $58, $8f, $e6, $02        ;; 0e:5e39 ????????
    db   $a8, $af, $e6, $03, $8a, $e6, $01, $ac        ;; 0e:5e41 ????????
    db   $af, $e1, $f2, $5c                            ;; 0e:5e49 ????

data_0e_5e4d:
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

data_0e_5fa3:
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

data_0e_61c7:
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
    db   $52, $54, $e1, $cf, $61                       ;; 0e:6357 ?????

data_0e_635c:
    db   $e7, $87, $e4, $fe, $79, $e6, $03, $e3        ;; 0e:635c ????????
    db   $02, $e0, $53, $7a, $e5, $00, $d2, $a7        ;; 0e:6364 ????????
    db   $ab, $a9, $ab, $a7, $ab, $a9, $ab, $a9        ;; 0e:636c ????????
    db   $ac, $ab, $ac, $a9, $ac, $ab, $ac, $ab        ;; 0e:6374 ????????
    db   $d8, $a2, $a0, $a2, $dc, $ab, $d8, $a2        ;; 0e:637c ????????
    db   $a0, $a2, $dc, $ab, $d8, $a2, $a0, $a2        ;; 0e:6384 ????????
    db   $dc, $ab, $d8, $a2, $a0, $a2, $a0, $a4        ;; 0e:638c ????????
    db   $a2, $a4, $a0, $a4, $a2, $a4, $dc, $a9        ;; 0e:6394 ????????
    db   $ac, $ab, $ac, $a9, $ac, $ab, $ac, $29        ;; 0e:639c ????????
    db   $8e, $d8, $e0, $31, $7a, $e5, $40, $e6        ;; 0e:63a4 ????????
    db   $02, $84, $e6, $03, $83, $dc, $e6, $01        ;; 0e:63ac ????????
    db   $8b, $d8, $e0, $57, $7a, $e6, $03, $44        ;; 0e:63b4 ????????
    db   $dc, $5b, $d8, $84, $86, $87, $89, $a7        ;; 0e:63bc ????????
    db   $a9, $87, $a6, $a7, $86, $a4, $a6, $84        ;; 0e:63c4 ????????
    db   $a2, $a4, $42, $a0, $dc, $ab, $29, $e0        ;; 0e:63cc ????????
    db   $36, $7a, $8f, $86, $87, $89, $87, $86        ;; 0e:63d4 ????????
    db   $84, $82, $a0, $a2, $a4, $a2, $a4, $a6        ;; 0e:63dc ????????
    db   $a7, $a6, $87, $d8, $84, $82, $dc, $8b        ;; 0e:63e4 ????????
    db   $a9, $ab, $ac, $ab, $a9, $a7, $a6, $a7        ;; 0e:63ec ????????
    db   $89, $a7, $a9, $8b, $a9, $ab, $eb, $01        ;; 0e:63f4 ????????
    db   $12, $64, $8c, $8b, $8c, $d8, $82, $84        ;; 0e:63fc ????????
    db   $87, $86, $84, $83, $81, $83, $84, $86        ;; 0e:6404 ????????
    db   $89, $87, $86, $e2, $b6, $63, $8c, $8b        ;; 0e:640c ????????
    db   $8c, $d8, $82, $84, $87, $86, $84, $53        ;; 0e:6414 ????????
    db   $dc, $5b, $d8, $8b, $89, $87, $86, $e0        ;; 0e:641c ????????
    db   $31, $7a, $e5, $40, $27, $8f, $a6, $a7        ;; 0e:6424 ????????
    db   $a9, $a7, $a6, $a4, $53, $a4, $a6, $a7        ;; 0e:642c ????????
    db   $a9, $2b, $e1, $63, $63                       ;; 0e:6434 ?????

data_0e_6439:
    db   $e4, $fe, $79, $e3, $02, $e0, $57, $7a        ;; 0e:6439 ????????
    db   $e5, $00, $e6, $03, $d2, $a4, $a7, $a6        ;; 0e:6441 ????????
    db   $a7, $e6, $02, $a4, $a7, $a6, $a7, $e6        ;; 0e:6449 ????????
    db   $03, $a6, $a9, $a7, $a9, $e6, $01, $a6        ;; 0e:6451 ????????
    db   $a9, $a7, $a9, $e6, $03, $a7, $ab, $a9        ;; 0e:6459 ????????
    db   $ab, $e6, $02, $a7, $ab, $a9, $ab, $e6        ;; 0e:6461 ????????
    db   $03, $a8, $ab, $a9, $ab, $e6, $01, $a8        ;; 0e:6469 ????????
    db   $ab, $a9, $ab, $e6, $03, $a9, $ac, $ab        ;; 0e:6471 ????????
    db   $ac, $e6, $02, $a9, $ac, $ab, $ac, $e6        ;; 0e:6479 ????????
    db   $03, $a6, $a9, $a7, $a9, $e6, $01, $a6        ;; 0e:6481 ????????
    db   $a9, $a7, $a9, $e0, $43, $7a, $e6, $03        ;; 0e:6489 ????????
    db   $26, $ae, $a7, $e6, $02, $a9, $ab, $e6        ;; 0e:6491 ????????
    db   $03, $a9, $a7, $e6, $01, $a6, $a3, $dc        ;; 0e:6499 ????????
    db   $e5, $40, $e6, $02, $a7, $a9, $a7, $a6        ;; 0e:64a1 ????????
    db   $a7, $af, $e6, $03, $a7, $a9, $a7, $a6        ;; 0e:64a9 ????????
    db   $a7, $af, $e6, $01, $a7, $a9, $a7, $a6        ;; 0e:64b1 ????????
    db   $e6, $02, $a7, $a9, $a7, $a6, $a7, $af        ;; 0e:64b9 ????????
    db   $e6, $03, $a7, $a9, $a7, $a6, $a7, $af        ;; 0e:64c1 ????????
    db   $e6, $01, $a7, $a9, $a7, $a6, $e6, $02        ;; 0e:64c9 ????????
    db   $5f, $a6, $a7, $a9, $a7, $e6, $01, $5f        ;; 0e:64d1 ????????
    db   $a6, $a7, $a9, $a7, $e6, $03, $8b, $89        ;; 0e:64d9 ????????
    db   $8b, $8c, $8b, $89, $87, $86, $e0, $31        ;; 0e:64e1 ????????
    db   $7a, $e6, $01, $e5, $00, $e6, $01, $a4        ;; 0e:64e9 ????????
    db   $a7, $a6, $a7, $e6, $02, $a4, $a7, $a6        ;; 0e:64f1 ????????
    db   $a7, $e6, $01, $a4, $a7, $a6, $a7, $e6        ;; 0e:64f9 ????????
    db   $02, $a4, $a7, $a6, $a7, $e6, $01, $a6        ;; 0e:6501 ????????
    db   $a9, $a7, $a9, $e6, $02, $a6, $a9, $a7        ;; 0e:6509 ????????
    db   $a9, $e6, $01, $a6, $a9, $a7, $a9, $e6        ;; 0e:6511 ????????
    db   $02, $a6, $a9, $a7, $a9, $eb, $01, $47        ;; 0e:6519 ????????
    db   $65, $e6, $01, $a7, $ab, $a9, $ab, $e6        ;; 0e:6521 ????????
    db   $02, $a7, $ab, $a9, $ab, $e6, $01, $a7        ;; 0e:6529 ????????
    db   $ab, $a9, $ab, $e6, $02, $a7, $ab, $a9        ;; 0e:6531 ????????
    db   $ab, $e6, $03, $8b, $89, $8b, $8d, $8b        ;; 0e:6539 ????????
    db   $8d, $8b, $89, $e2, $a1, $64, $e6, $01        ;; 0e:6541 ????????
    db   $e5, $40, $a7, $ab, $a9, $ab, $e6, $02        ;; 0e:6549 ????????
    db   $a7, $ab, $a9, $ab, $e6, $01, $a7, $ab        ;; 0e:6551 ????????
    db   $a9, $ab, $e6, $02, $a7, $ab, $a9, $ab        ;; 0e:6559 ????????
    db   $d8, $e6, $01, $a3, $dc, $ab, $d8, $a3        ;; 0e:6561 ????????
    db   $dc, $ab, $d8, $e6, $02, $a4, $dc, $ab        ;; 0e:6569 ????????
    db   $d8, $a4, $dc, $ab, $e6, $01, $d8, $a5        ;; 0e:6571 ????????
    db   $dc, $ab, $d8, $a5, $dc, $ab, $d8, $e6        ;; 0e:6579 ????????
    db   $02, $a6, $dc, $ab, $d8, $a6, $dc, $ab        ;; 0e:6581 ????????
    db   $d8, $e6, $01, $a4, $a6, $aa, $a4, $e6        ;; 0e:6589 ????????
    db   $02, $a6, $aa, $a4, $a6, $e6, $03, $2a        ;; 0e:6591 ????????
    db   $a6, $a9, $a7, $a6, $a9, $a6, $a7, $a9        ;; 0e:6599 ????????
    db   $ab, $ac, $ab, $a9, $a7, $a9, $a7, $a6        ;; 0e:65a1 ????????
    db   $e1, $3c, $64                                 ;; 0e:65a9 ???

data_0e_65ac:
    db   $e4, $fe, $79, $e8, $a5, $7a, $e0, $20        ;; 0e:65ac ????????
    db   $e3, $02, $e6, $01, $d1, $24, $e6, $02        ;; 0e:65b4 ????????
    db   $26, $e6, $01, $27, $e6, $02, $28, $e6        ;; 0e:65bc ????????
    db   $01, $29, $e6, $02, $26, $e6, $03, $5b        ;; 0e:65c4 ????????
    db   $d8, $5b, $56, $dc, $5b, $8c, $5f, $8c        ;; 0e:65cc ????????
    db   $5f, $8c, $8f, $8c, $5f, $8c, $5f, $8c        ;; 0e:65d4 ????????
    db   $8f, $ab, $af, $ab, $af, $5f, $ab, $af        ;; 0e:65dc ????????
    db   $ab, $af, $5f, $54, $d8, $54, $52, $dc        ;; 0e:65e4 ????????
    db   $5b, $a9, $af, $a9, $af, $e6, $01, $8f        ;; 0e:65ec ????????
    db   $89, $e6, $03, $8f, $89, $e6, $02, $8f        ;; 0e:65f4 ????????
    db   $89, $e6, $03, $ab, $af, $ab, $af, $e6        ;; 0e:65fc ????????
    db   $01, $8f, $8b, $e6, $03, $8f, $8b, $e6        ;; 0e:6604 ????????
    db   $02, $8f, $8b, $eb, $01, $32, $66, $e6        ;; 0e:660c ????????
    db   $03, $ac, $af, $ac, $af, $e6, $01, $8f        ;; 0e:6614 ????????
    db   $8c, $e6, $03, $8f, $8c, $e6, $02, $8f        ;; 0e:661c ????????
    db   $8c, $e6, $03, $7b, $af, $7b, $af, $5d        ;; 0e:6624 ????????
    db   $d8, $53, $dc, $e2, $d1, $65, $e3, $04        ;; 0e:662c ????????
    db   $e6, $03, $ac, $af, $e6, $01, $ac, $af        ;; 0e:6634 ????????
    db   $e6, $03, $ac, $af, $e6, $02, $ac, $af        ;; 0e:663c ????????
    db   $e6, $03, $ac, $af, $e6, $01, $ac, $af        ;; 0e:6644 ????????
    db   $e6, $03, $ac, $af, $e6, $02, $ac, $af        ;; 0e:664c ????????
    db   $e6, $03, $ab, $af, $e6, $01, $ab, $af        ;; 0e:6654 ????????
    db   $e6, $03, $ab, $af, $e6, $02, $ab, $af        ;; 0e:665c ????????
    db   $e6, $03, $ad, $af, $e6, $01, $ad, $af        ;; 0e:6664 ????????
    db   $e6, $03, $d8, $a3, $af, $e6, $02, $a3        ;; 0e:666c ????????
    db   $af, $e6, $03, $01, $e6, $01, $dc, $5b        ;; 0e:6674 ????????
    db   $e6, $02, $59, $e6, $01, $57, $e6, $02        ;; 0e:667c ????????
    db   $56, $e1, $b4, $65                            ;; 0e:6684 ????

data_0e_6688:
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

data_0e_674b:
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

data_0e_68b8:
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

data_0e_696e:
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
    db   $e1, $63, $6b                                 ;; 0e:6c7e ???

data_0e_6c81:
    db   $e4, $fe, $79, $e0, $57, $7a, $e5, $00        ;; 0e:6c81 ????????
    db   $e3, $02, $e6, $01, $d1, $a8, $aa, $8c        ;; 0e:6c89 ????????
    db   $a7, $a8, $8a, $a8, $aa, $8c, $a7, $a8        ;; 0e:6c91 ????????
    db   $aa, $ac, $d1, $a8, $aa, $8c, $a7, $a8        ;; 0e:6c99 ????????
    db   $8a, $a8, $aa, $8c, $a7, $a8, $aa, $ac        ;; 0e:6ca1 ????????
    db   $e6, $02, $d1, $a8, $aa, $8c, $a7, $a8        ;; 0e:6ca9 ????????
    db   $8a, $a8, $aa, $8c, $a7, $a8, $aa, $ac        ;; 0e:6cb1 ????????
    db   $a8, $aa, $8c, $a7, $a8, $8a, $a5, $a7        ;; 0e:6cb9 ????????
    db   $a8, $aa, $ac, $d8, $a2, $a3, $a5, $e2        ;; 0e:6cc1 ????????
    db   $8b, $6c, $dc, $e3, $02, $e6, $03, $e5        ;; 0e:6cc9 ????????
    db   $40, $a0, $af, $a0, $af, $e0, $65, $7a        ;; 0e:6cd1 ????????
    db   $e6, $02, $a0, $af, $e6, $01, $a0, $af        ;; 0e:6cd9 ????????
    db   $e6, $02, $a0, $af, $e6, $03, $e0, $57        ;; 0e:6ce1 ????????
    db   $7a, $42, $43, $45, $58, $a0, $af, $a0        ;; 0e:6ce9 ????????
    db   $af, $e0, $65, $7a, $e6, $02, $a0, $af        ;; 0e:6cf1 ????????
    db   $e6, $01, $a0, $af, $e6, $02, $a0, $af        ;; 0e:6cf9 ????????
    db   $e0, $57, $7a, $e6, $03, $42, $43, $45        ;; 0e:6d01 ????????
    db   $58, $eb, $01, $38, $6d, $a0, $af, $a0        ;; 0e:6d09 ????????
    db   $af, $4f, $dc, $47, $aa, $af, $aa, $af        ;; 0e:6d11 ????????
    db   $4f, $46, $a8, $af, $a8, $af, $4f, $4b        ;; 0e:6d19 ????????
    db   $aa, $af, $aa, $af, $5f, $e6, $02, $a3        ;; 0e:6d21 ????????
    db   $a4, $a5, $e6, $03, $a6, $a7, $a8, $e6        ;; 0e:6d29 ????????
    db   $01, $a9, $aa, $d8, $e2, $ce, $6c, $ea        ;; 0e:6d31 ????????
    db   $02, $e3, $0a, $e5, $00, $e0, $43, $7a        ;; 0e:6d39 ????????
    db   $e6, $02, $83, $85, $87, $e2, $3c, $6d        ;; 0e:6d41 ????????
    db   $83, $85, $e3, $0a, $82, $83, $85, $e2        ;; 0e:6d49 ????????
    db   $4d, $6d, $82, $83, $e9, $3a, $6d, $e5        ;; 0e:6d51 ????????
    db   $40, $e0, $57, $7a, $58, $55, $53, $8c        ;; 0e:6d59 ????????
    db   $5a, $8c, $88, $8a, $87, $88, $87, $85        ;; 0e:6d61 ????????
    db   $87, $8b, $87, $8b, $89, $8c, $8b, $d8        ;; 0e:6d69 ????????
    db   $82, $53, $52, $50, $dc, $8a, $59, $86        ;; 0e:6d71 ????????
    db   $83, $80, $dc, $89, $8c, $d8, $83, $86        ;; 0e:6d79 ????????
    db   $82, $86, $89, $8c, $80, $83, $86, $89        ;; 0e:6d81 ????????
    db   $8c, $c5, $cf, $c7, $cf, $82, $8c, $c5        ;; 0e:6d89 ????????
    db   $cf, $c7, $cf, $82, $ac, $a5, $a7, $a2        ;; 0e:6d91 ????????
    db   $8b, $c5, $cf, $c7, $cf, $82, $8b, $c5        ;; 0e:6d99 ????????
    db   $cf, $c7, $cf, $82, $ab, $a5, $a7, $a2        ;; 0e:6da1 ????????
    db   $e1, $38, $6d                                 ;; 0e:6da9 ???

data_0e_6dac:
    db   $e4, $fe, $79, $e8, $a5, $7a, $e0, $20        ;; 0e:6dac ????????
    db   $e6, $03, $e3, $02, $d1, $05, $04, $03        ;; 0e:6db4 ????????
    db   $22, $8e, $8a, $d8, $85, $82, $e2, $b8        ;; 0e:6dbc ????????
    db   $6d, $e3, $02, $dc, $a5, $af, $a5, $af        ;; 0e:6dc4 ????????
    db   $88, $87, $85, $8b, $8a, $88, $85, $8c        ;; 0e:6dcc ????????
    db   $8a, $d8, $82, $80, $83, $82, $85, $e2        ;; 0e:6dd4 ????????
    db   $c7, $6d, $a5, $af, $a5, $af, $4f, $40        ;; 0e:6ddc ????????
    db   $a3, $af, $a3, $af, $4f, $dc, $4b, $ad        ;; 0e:6de4 ????????
    db   $af, $ad, $af, $4f, $d8, $44, $a3, $af        ;; 0e:6dec ????????
    db   $a3, $af, $5f, $e6, $02, $dc, $a5, $a6        ;; 0e:6df4 ????????
    db   $e6, $03, $a7, $a8, $a9, $e6, $01, $aa        ;; 0e:6dfc ????????
    db   $ab, $ac, $d8, $e3, $02, $e6, $03, $dc        ;; 0e:6e04 ????????
    db   $a5, $af, $a5, $af, $88, $87, $85, $8b        ;; 0e:6e0c ????????
    db   $8a, $88, $85, $8c, $8a, $d8, $82, $80        ;; 0e:6e14 ????????
    db   $83, $eb, $01, $26, $6e, $82, $85, $e2        ;; 0e:6e1c ????????
    db   $09, $6e, $e8, $85, $7a, $c2, $c1, $c0        ;; 0e:6e24 ????????
    db   $dc, $cb, $ca, $c9, $c8, $c7, $d8, $ea        ;; 0e:6e2c ????????
    db   $02, $e3, $04, $e8, $a5, $7a, $dc, $88        ;; 0e:6e34 ????????
    db   $d8, $88, $87, $88, $8c, $88, $87, $88        ;; 0e:6e3c ????????
    db   $e2, $37, $6e, $e3, $04, $dc, $87, $d8        ;; 0e:6e44 ????????
    db   $87, $85, $87, $8b, $87, $85, $87, $e2        ;; 0e:6e4c ????????
    db   $49, $6e, $e9, $35, $6e, $e3, $04, $dc        ;; 0e:6e54 ????????
    db   $a5, $af, $d8, $85, $e2, $5b, $6e, $e3        ;; 0e:6e5c ????????
    db   $03, $dc, $aa, $af, $d8, $8a, $e2, $65        ;; 0e:6e64 ????????
    db   $6e, $dc, $a8, $af, $d8, $88, $e3, $04        ;; 0e:6e6c ????????
    db   $dc, $a7, $af, $d8, $87, $e2, $74, $6e        ;; 0e:6e74 ????????
    db   $a0, $af, $8c, $dc, $aa, $af, $d8, $8a        ;; 0e:6e7c ????????
    db   $dc, $a8, $af, $d8, $88, $dc, $a7, $af        ;; 0e:6e84 ????????
    db   $d8, $87, $e3, $04, $dc, $a6, $af, $d8        ;; 0e:6e8c ????????
    db   $86, $e2, $90, $6e, $e3, $04, $dc, $a2        ;; 0e:6e94 ????????
    db   $af, $d8, $82, $e2, $9a, $6e, $a7, $af        ;; 0e:6e9c ????????
    db   $dc, $a7, $af, $a7, $af, $d8, $a5, $af        ;; 0e:6ea4 ????????
    db   $dc, $a7, $af, $a7, $af, $d8, $a3, $af        ;; 0e:6eac ????????
    db   $dc, $a7, $af, $d8, $a2, $af, $dc, $a7        ;; 0e:6eb4 ????????
    db   $af, $a7, $af, $ac, $af, $a7, $af, $a7        ;; 0e:6ebc ????????
    db   $af, $ab, $af, $a7, $af, $d8, $e1, $33        ;; 0e:6ec4 ????????
    db   $6e                                           ;; 0e:6ecc ?

data_0e_6ecd:
    db   $e4, $fe, $79, $e0, $31, $7a, $e5, $80        ;; 0e:6ecd ????????
    db   $e6, $03, $e3, $02, $e7, $46, $d3, $84        ;; 0e:6ed5 ????????
    db   $83, $84, $dc, $8b, $2d, $8f, $d8, $86        ;; 0e:6edd ????????
    db   $84, $83, $84, $83, $84, $dc, $8b, $2d        ;; 0e:6ee5 ????????
    db   $59, $5b, $8c, $8b, $8c, $87, $29, $8f        ;; 0e:6eed ????????
    db   $d8, $82, $80, $dc, $8b, $8c, $8b, $8c        ;; 0e:6ef5 ????????
    db   $87, $29, $5b, $8c, $d8, $82, $e2, $d9        ;; 0e:6efd ????????
    db   $6e, $e3, $02, $82, $81, $82, $87, $86        ;; 0e:6f05 ????????
    db   $84, $dc, $8b, $8d, $d8, $82, $80, $dc        ;; 0e:6f0d ????????
    db   $87, $d8, $27, $8e, $eb, $01, $2b, $6f        ;; 0e:6f15 ????????
    db   $87, $85, $80, $83, $52, $83, $85, $52        ;; 0e:6f1d ????????
    db   $dc, $1a, $d8, $e2, $08, $6f, $82, $80        ;; 0e:6f25 ????????
    db   $dc, $87, $d8, $47, $55, $e7, $45, $87        ;; 0e:6f2d ????????
    db   $e7, $44, $8e, $e7, $42, $8e, $e7, $40        ;; 0e:6f35 ????????
    db   $8e, $e7, $3e, $8e, $e7, $3c, $8e, $e7        ;; 0e:6f3d ????????
    db   $3a, $8e, $e7, $38, $8e, $e1, $d7, $6e        ;; 0e:6f45 ????????

data_0e_6f4d:
    db   $e4, $0b, $7a, $e5, $40, $e6, $01, $ea        ;; 0e:6f4d ????????
    db   $02, $d2, $e3, $03, $e0, $65, $7a, $c4        ;; 0e:6f55 ????????
    db   $c6, $c4, $c6, $e0, $63, $7a, $c4, $c6        ;; 0e:6f5d ????????
    db   $c4, $c6, $e0, $61, $7a, $c4, $c6, $c4        ;; 0e:6f65 ????????
    db   $c6, $e0, $5f, $7a, $c4, $c6, $c4, $c6        ;; 0e:6f6d ????????
    db   $e0, $5d, $7a, $c4, $c6, $c4, $c6, $e0        ;; 0e:6f75 ????????
    db   $5b, $7a, $c4, $c6, $c4, $c6, $e0, $59        ;; 0e:6f7d ????????
    db   $7a, $c4, $c6, $c4, $c6, $e0, $57, $7a        ;; 0e:6f85 ????????
    db   $c4, $c6, $c4, $c6, $e2, $59, $6f, $e3        ;; 0e:6f8d ????????
    db   $03, $e0, $65, $7a, $c4, $c5, $c4, $c5        ;; 0e:6f95 ????????
    db   $e0, $63, $7a, $c4, $c5, $c4, $c5, $e0        ;; 0e:6f9d ????????
    db   $61, $7a, $c4, $c5, $c4, $c5, $e0, $5f        ;; 0e:6fa5 ????????
    db   $7a, $c4, $c5, $c4, $c5, $e0, $5d, $7a        ;; 0e:6fad ????????
    db   $c4, $c5, $c4, $c5, $e0, $5b, $7a, $c4        ;; 0e:6fb5 ????????
    db   $c5, $c4, $c5, $e0, $59, $7a, $c4, $c5        ;; 0e:6fbd ????????
    db   $c4, $c5, $e0, $57, $7a, $c4, $c5, $c4        ;; 0e:6fc5 ????????
    db   $c5, $e2, $96, $6f, $e9, $56, $6f, $e0        ;; 0e:6fcd ????????
    db   $65, $7a, $c2, $c4, $c2, $c4, $e0, $63        ;; 0e:6fd5 ????????
    db   $7a, $c2, $c4, $c2, $c4, $e0, $61, $7a        ;; 0e:6fdd ????????
    db   $c2, $c4, $c2, $c4, $e0, $5f, $7a, $c2        ;; 0e:6fe5 ????????
    db   $c4, $c2, $c4, $e0, $5d, $7a, $c2, $c4        ;; 0e:6fed ????????
    db   $c2, $c4, $e0, $5b, $7a, $c2, $c4, $c2        ;; 0e:6ff5 ????????
    db   $c4, $e0, $59, $7a, $c2, $c4, $c2, $c4        ;; 0e:6ffd ????????
    db   $e0, $57, $7a, $c2, $c4, $c2, $c4, $e0        ;; 0e:7005 ????????
    db   $65, $7a, $c3, $c5, $c3, $c5, $e0, $63        ;; 0e:700d ????????
    db   $7a, $c3, $c5, $c3, $c5, $e0, $61, $7a        ;; 0e:7015 ????????
    db   $c3, $c5, $c3, $c5, $e0, $5f, $7a, $c3        ;; 0e:701d ????????
    db   $c5, $c3, $c5, $e0, $5d, $7a, $c3, $c5        ;; 0e:7025 ????????
    db   $c3, $c5, $e0, $5b, $7a, $c3, $c5, $c3        ;; 0e:702d ????????
    db   $c5, $e0, $59, $7a, $c3, $c5, $c3, $c5        ;; 0e:7035 ????????
    db   $e0, $57, $7a, $c3, $c5, $c3, $c5, $e3        ;; 0e:703d ????????
    db   $02, $e0, $65, $7a, $c5, $c7, $c5, $c7        ;; 0e:7045 ????????
    db   $e0, $63, $7a, $c5, $c7, $c5, $c7, $e0        ;; 0e:704d ????????
    db   $61, $7a, $c5, $c7, $c5, $c7, $e0, $5f        ;; 0e:7055 ????????
    db   $7a, $c5, $c7, $c5, $c7, $e0, $5d, $7a        ;; 0e:705d ????????
    db   $c5, $c7, $c5, $c7, $e0, $5b, $7a, $c5        ;; 0e:7065 ????????
    db   $c7, $c5, $c7, $e0, $59, $7a, $c5, $c7        ;; 0e:706d ????????
    db   $c5, $c7, $e0, $57, $7a, $c5, $c7, $c5        ;; 0e:7075 ????????
    db   $c7, $e2, $46, $70, $e0, $65, $7a, $c2        ;; 0e:707d ????????
    db   $c4, $c2, $c4, $e0, $63, $7a, $c2, $c4        ;; 0e:7085 ????????
    db   $c2, $c4, $e0, $61, $7a, $c2, $c4, $c2        ;; 0e:708d ????????
    db   $c4, $e0, $5f, $7a, $c2, $c4, $c2, $c4        ;; 0e:7095 ????????
    db   $e0, $5d, $7a, $c2, $c4, $c2, $c4, $e0        ;; 0e:709d ????????
    db   $5b, $7a, $c2, $c4, $c2, $c4, $e0, $59        ;; 0e:70a5 ????????
    db   $7a, $c2, $c4, $c2, $c4, $e0, $57, $7a        ;; 0e:70ad ????????
    db   $c2, $c4, $c2, $c4, $e0, $65, $7a, $c3        ;; 0e:70b5 ????????
    db   $c5, $c3, $c5, $e0, $63, $7a, $c3, $c5        ;; 0e:70bd ????????
    db   $c3, $c5, $e0, $61, $7a, $c3, $c5, $c3        ;; 0e:70c5 ????????
    db   $c5, $e0, $5f, $7a, $c3, $c5, $c3, $c5        ;; 0e:70cd ????????
    db   $e0, $5d, $7a, $c3, $c5, $c3, $c5, $e0        ;; 0e:70d5 ????????
    db   $5b, $7a, $c3, $c5, $c3, $c5, $e0, $59        ;; 0e:70dd ????????
    db   $7a, $c3, $c5, $c3, $c5, $e0, $57, $7a        ;; 0e:70e5 ????????
    db   $c3, $c5, $c3, $c5, $e0, $65, $7a, $c2        ;; 0e:70ed ????????
    db   $c5, $c2, $c5, $e0, $63, $7a, $c2, $c5        ;; 0e:70f5 ????????
    db   $c2, $c5, $e0, $61, $7a, $c2, $c5, $c2        ;; 0e:70fd ????????
    db   $c5, $e0, $5f, $7a, $c2, $c5, $c2, $c5        ;; 0e:7105 ????????
    db   $e0, $5d, $7a, $c2, $c5, $c2, $c5, $e0        ;; 0e:710d ????????
    db   $5b, $7a, $c2, $c5, $c2, $c5, $e0, $59        ;; 0e:7115 ????????
    db   $7a, $c2, $c5, $c2, $c5, $e0, $57, $7a        ;; 0e:711d ????????
    db   $c2, $c5, $c2, $c5, $e0, $65, $7a, $c4        ;; 0e:7125 ????????
    db   $c5, $c4, $c5, $e0, $63, $7a, $c4, $c5        ;; 0e:712d ????????
    db   $c4, $c5, $e0, $61, $7a, $c4, $c5, $c4        ;; 0e:7135 ????????
    db   $c5, $e0, $5f, $7a, $c4, $c5, $c4, $c5        ;; 0e:713d ????????
    db   $e0, $5d, $7a, $c4, $c5, $c4, $c5, $e0        ;; 0e:7145 ????????
    db   $5b, $7a, $c4, $c5, $c4, $c5, $e0, $59        ;; 0e:714d ????????
    db   $7a, $c4, $c5, $c4, $c5, $e0, $57, $7a        ;; 0e:7155 ????????
    db   $c4, $c5, $c4, $c5, $e1, $54, $6f             ;; 0e:715d ???????

data_0e_7164:
    db   $e4, $fe, $79, $e8, $a5, $7a, $e0, $20        ;; 0e:7164 ????????
    db   $e6, $02, $ea, $02, $e3, $03, $d1, $89        ;; 0e:716c ????????
    db   $d8, $84, $89, $84, $8d, $89, $84, $89        ;; 0e:7174 ????????
    db   $e2, $72, $71, $e3, $03, $dc, $85, $8c        ;; 0e:717c ????????
    db   $d8, $85, $80, $89, $85, $80, $85, $e2        ;; 0e:7184 ????????
    db   $81, $71, $e9, $70, $71, $e3, $02, $dc        ;; 0e:718c ????????
    db   $87, $d8, $82, $87, $82, $8b, $87, $82        ;; 0e:7194 ????????
    db   $87, $dc, $88, $d8, $83, $88, $83, $8c        ;; 0e:719c ????????
    db   $88, $83, $88, $eb, $01, $c6, $71, $dc        ;; 0e:71a4 ????????
    db   $85, $8c, $d8, $85, $88, $dc, $8a, $d8        ;; 0e:71ac ????????
    db   $85, $8a, $85, $dc, $83, $8a, $d8, $83        ;; 0e:71b4 ????????
    db   $87, $8a, $87, $83, $dc, $8a, $d8, $e2        ;; 0e:71bc ????????
    db   $93, $71, $dc, $8a, $d8, $85, $8a, $85        ;; 0e:71c4 ????????
    db   $82, $85, $8a, $85, $dc, $80, $8c, $d8        ;; 0e:71cc ????????
    db   $84, $87, $8c, $87, $84, $80, $e1, $6e        ;; 0e:71d4 ????????
    db   $71                                           ;; 0e:71dc ?

data_0e_71dd:
    db   $e4, $fe, $79, $e0, $31, $7a, $e5, $40        ;; 0e:71dd ????????
    db   $e6, $03, $e7, $49, $d2, $8a, $e7, $46        ;; 0e:71e5 ????????
    db   $89, $e7, $44, $8a, $e7, $41, $8b, $e7        ;; 0e:71ed ????????
    db   $3c, $5c, $5b, $e3, $02, $e7, $4e, $e0        ;; 0e:71f5 ????????
    db   $6d, $7a, $4a, $ab, $ac, $4d, $d8, $a2        ;; 0e:71fd ????????
    db   $a3, $84, $b3, $b4, $b3, $41, $b0, $b1        ;; 0e:7205 ????????
    db   $b0, $dc, $8a, $88, $57, $be, $ba, $bc        ;; 0e:720d ????????
    db   $ba, $b7, $b5, $07, $eb, $01, $29, $72        ;; 0e:7215 ????????
    db   $ba, $b7, $ba, $bd, $ba, $bd, $d8, $54        ;; 0e:721d ????????
    db   $dc, $e2, $fa, $71, $8a, $a9, $a8, $57        ;; 0e:7225 ????????
    db   $e0, $31, $7a, $e6, $01, $b6, $b9, $b6        ;; 0e:722d ????????
    db   $bc, $b9, $bc, $d8, $53, $dc, $e6, $02        ;; 0e:7235 ????????
    db   $b5, $b8, $b5, $bb, $b8, $bb, $d8, $52        ;; 0e:723d ????????
    db   $dc, $e6, $03, $84, $85, $86, $87, $58        ;; 0e:7245 ????????
    db   $59, $e1, $e7, $71                            ;; 0e:724d ????

data_0e_7251:
    db   $e4, $fe, $79, $e0, $31, $7a, $e5, $00        ;; 0e:7251 ????????
    db   $e6, $03, $d2, $87, $86, $87, $88, $59        ;; 0e:7259 ????????
    db   $58, $e3, $02, $e0, $71, $7a, $e6, $01        ;; 0e:7261 ????????
    db   $47, $e6, $03, $a8, $a9, $e6, $02, $4a        ;; 0e:7269 ????????
    db   $e6, $03, $ab, $ac, $e6, $01, $8d, $e6        ;; 0e:7271 ????????
    db   $03, $bc, $bd, $bc, $e6, $02, $4a, $e6        ;; 0e:7279 ????????
    db   $03, $b9, $ba, $b9, $e6, $01, $87, $85        ;; 0e:7281 ????????
    db   $e6, $02, $a4, $a3, $e6, $03, $a2, $a1        ;; 0e:7289 ????????
    db   $e6, $01, $a4, $a3, $e6, $03, $a2, $a1        ;; 0e:7291 ????????
    db   $e6, $02, $a4, $a3, $e6, $03, $a2, $a1        ;; 0e:7299 ????????
    db   $e6, $01, $a4, $a3, $e6, $03, $a2, $a1        ;; 0e:72a1 ????????
    db   $eb, $01, $ce, $72, $e6, $02, $a4, $a3        ;; 0e:72a9 ????????
    db   $e6, $03, $a2, $a1, $e6, $01, $a4, $a3        ;; 0e:72b1 ????????
    db   $e6, $02, $a2, $a1, $e6, $03, $b7, $b4        ;; 0e:72b9 ????????
    db   $b7, $ba, $b7, $ba, $e6, $01, $a3, $a4        ;; 0e:72c1 ????????
    db   $a5, $a6, $e2, $64, $72, $e6, $02, $a4        ;; 0e:72c9 ????????
    db   $a3, $e6, $03, $a2, $a1, $e6, $01, $a4        ;; 0e:72d1 ????????
    db   $a3, $e6, $03, $a2, $a1, $e6, $02, $a4        ;; 0e:72d9 ????????
    db   $a3, $e6, $03, $a2, $a1, $e6, $01, $a4        ;; 0e:72e1 ????????
    db   $a3, $e6, $03, $a2, $a1, $e0, $31, $7a        ;; 0e:72e9 ????????
    db   $e6, $02, $23, $e6, $01, $22, $e6, $03        ;; 0e:72f1 ????????
    db   $81, $82, $83, $84, $55, $56, $e1, $5b        ;; 0e:72f9 ????????
    db   $72                                           ;; 0e:7301 ?

data_0e_7302:
    db   $e4, $fe, $79, $e8, $95, $7a, $e0, $20        ;; 0e:7302 ????????
    db   $e6, $03, $d2, $84, $83, $84, $85, $56        ;; 0e:730a ????????
    db   $55, $e3, $0e, $a4, $af, $e2, $15, $73        ;; 0e:7312 ????????
    db   $84, $a3, $a2, $e3, $0e, $a1, $af, $e2        ;; 0e:731a ????????
    db   $1f, $73, $81, $a2, $a3, $e3, $0e, $a4        ;; 0e:7322 ????????
    db   $af, $e2, $29, $73, $84, $a3, $a2, $e3        ;; 0e:732a ????????
    db   $10, $a1, $af, $e2, $33, $73, $20, $dc        ;; 0e:7332 ????????
    db   $2b, $8a, $8b, $8c, $8d, $d8, $52, $53        ;; 0e:733a ????????
    db   $e1, $0c, $73                                 ;; 0e:7342 ???

data_0e_7345:
    db   $e4, $fe, $79, $e6, $03, $e7, $42, $e0        ;; 0e:7345 ????????
    db   $31, $7a, $e5, $80, $d1, $8f, $8b, $d8        ;; 0e:734d ????????
    db   $86, $84, $5b, $88, $89, $8b, $89, $88        ;; 0e:7355 ????????
    db   $89, $54, $56, $dc, $8f, $8b, $d8, $86        ;; 0e:735d ????????
    db   $84, $5b, $88, $89, $8b, $89, $88, $89        ;; 0e:7365 ????????
    db   $54, $56, $d8, $e0, $6d, $7a, $e5, $40        ;; 0e:736d ????????
    db   $88, $86, $88, $89, $4b, $8d, $1b, $89        ;; 0e:7375 ????????
    db   $88, $59, $51, $54, $59, $18, $86, $84        ;; 0e:737d ????????
    db   $26, $88, $86, $84, $86, $24, $86, $84        ;; 0e:7385 ????????
    db   $83, $84, $81, $83, $84, $86, $53, $dc        ;; 0e:738d ????????
    db   $8b, $8d, $0d, $e0, $31, $7a, $e7, $3c        ;; 0e:7395 ????????
    db   $89, $88, $89, $8b, $e7, $35, $8c, $8b        ;; 0e:739d ????????
    db   $8c, $d8, $e7, $31, $82, $14, $e7, $7d        ;; 0e:73a5 ????????
    db   $5e, $e0, $57, $7a, $dc, $53, $93, $91        ;; 0e:73ad ????????
    db   $93, $54, $94, $93, $94, $55, $95, $94        ;; 0e:73b5 ????????
    db   $95, $96, $98, $99, $98, $96, $94, $53        ;; 0e:73bd ????????
    db   $93, $91, $93, $54, $94, $93, $94, $55        ;; 0e:73c5 ????????
    db   $95, $94, $95, $e5, $80, $a6, $a8, $a9        ;; 0e:73cd ????????
    db   $ab, $bd, $d8, $b3, $b4, $b6, $b8, $b9        ;; 0e:73d5 ????????
    db   $dc, $e0, $43, $7a, $e5, $40, $9b, $9b        ;; 0e:73dd ????????
    db   $9b, $9b, $96, $9b, $9d, $9d, $9d, $9d        ;; 0e:73e5 ????????
    db   $99, $9d, $d8, $e0, $57, $7a, $03, $dc        ;; 0e:73ed ????????
    db   $e3, $02, $e7, $7d, $28, $8e, $86, $88        ;; 0e:73f5 ????????
    db   $89, $56, $5b, $5d, $d8, $53, $22, $8e        ;; 0e:73fd ????????
    db   $82, $81, $dc, $8b, $eb, $01, $2c, $74        ;; 0e:7405 ????????
    db   $5b, $29, $89, $8b, $2c, $8e, $d8, $84        ;; 0e:740d ????????
    db   $82, $80, $dc, $5b, $57, $52, $56, $24        ;; 0e:7415 ????????
    db   $8e, $87, $86, $84, $44, $a3, $a1, $53        ;; 0e:741d ????????
    db   $e7, $76, $84, $86, $e2, $f7, $73, $5b        ;; 0e:7425 ????????
    db   $59, $ae, $a6, $a5, $a6, $a8, $a6, $a5        ;; 0e:742d ????????
    db   $a6, $d8, $23, $84, $83, $81, $83, $54        ;; 0e:7435 ????????
    db   $dc, $5b, $5d, $59, $38, $99, $98, $46        ;; 0e:743d ????????
    db   $84, $54, $e0, $31, $7a, $e5, $80, $e7        ;; 0e:7445 ????????
    db   $7a, $58, $59, $5b, $e0, $55, $7a, $e7        ;; 0e:744d ????????
    db   $7d, $99, $9d, $99, $d8, $94, $91, $94        ;; 0e:7455 ????????
    db   $e0, $6b, $7a, $28, $e0, $57, $7a, $e5        ;; 0e:745d ????????
    db   $40, $8f, $a3, $a1, $83, $84, $a6, $a8        ;; 0e:7465 ????????
    db   $a6, $a4, $a3, $a4, $a3, $a1, $e0, $55        ;; 0e:746d ????????
    db   $7a, $e5, $80, $dc, $98, $9b, $98, $d8        ;; 0e:7475 ????????
    db   $93, $dc, $9b, $d8, $93, $e0, $6b, $7a        ;; 0e:747d ????????
    db   $26, $e0, $57, $7a, $e5, $40, $8f, $a4        ;; 0e:7485 ????????
    db   $a3, $81, $83, $a4, $a6, $a4, $a3, $a1        ;; 0e:748d ????????
    db   $a3, $a1, $dc, $ab, $e0, $6d, $7a, $49        ;; 0e:7495 ????????
    db   $a8, $a9, $4b, $a9, $ab, $8d, $ab, $ad        ;; 0e:749d ????????
    db   $d8, $83, $a1, $a3, $84, $a3, $a4, $86        ;; 0e:74a5 ????????
    db   $a4, $a6, $48, $a4, $a6, $88, $86, $88        ;; 0e:74ad ????????
    db   $89, $46, $a8, $a9, $88, $86, $84, $83        ;; 0e:74b5 ????????
    db   $41, $dc, $ab, $ad, $d8, $43, $a1, $a3        ;; 0e:74bd ????????
    db   $a4, $a3, $a1, $a3, $e5, $00, $a4, $a3        ;; 0e:74c5 ????????
    db   $a4, $a6, $e5, $40, $a8, $a6, $a4, $a6        ;; 0e:74cd ????????
    db   $e5, $80, $a8, $a6, $a8, $a9, $e0, $31        ;; 0e:74d5 ????????
    db   $7a, $0b, $0e, $dc, $e0, $6d, $7a, $a6        ;; 0e:74dd ????????
    db   $a4, $a6, $a8, $a9, $a8, $a9, $ab, $ad        ;; 0e:74e5 ????????
    db   $ab, $ad, $d8, $a2, $a4, $a6, $a8, $a9        ;; 0e:74ed ????????
    db   $e7, $78, $a8, $a6, $a8, $a9, $e7, $6e        ;; 0e:74f5 ????????
    db   $e5, $40, $ab, $a9, $a8, $a6, $e7, $64        ;; 0e:74fd ????????
    db   $e5, $00, $a4, $a6, $e7, $50, $a4, $a2        ;; 0e:7505 ????????
    db   $e7, $44, $e5, $40, $a1, $a2, $a1, $dc        ;; 0e:750d ????????
    db   $ab, $e0, $31, $7a, $e5, $80, $e7, $4b        ;; 0e:7515 ????????
    db   $5d, $8b, $8d, $d8, $82, $81, $82, $86        ;; 0e:751d ????????
    db   $54, $86, $88, $86, $84, $82, $81, $22        ;; 0e:7525 ????????
    db   $dc, $59, $5b, $4d, $d8, $a2, $a1, $dc        ;; 0e:752d ????????
    db   $2b, $56, $5d, $5b, $8d, $d8, $82, $84        ;; 0e:7535 ????????
    db   $81, $82, $84, $56, $51, $dc, $2b, $56        ;; 0e:753d ????????
    db   $58, $19, $e0, $6d, $7a, $e5, $40, $e7        ;; 0e:7545 ????????
    db   $55, $b7, $b9, $bb, $d8, $b0, $b2, $b3        ;; 0e:754d ????????
    db   $e0, $6b, $7a, $e5, $80, $24, $8e, $82        ;; 0e:7555 ????????
    db   $84, $85, $27, $8e, $89, $84, $87, $25        ;; 0e:755d ????????
    db   $8e, $84, $85, $87, $25, $8e, $82, $84        ;; 0e:7565 ????????
    db   $85, $54, $dc, $4b, $d8, $82, $80, $dc        ;; 0e:756d ????????
    db   $8b, $5c, $d8, $54, $52, $dc, $89, $8b        ;; 0e:7575 ????????
    db   $2c, $8e, $8b, $8c, $d8, $84, $12, $50        ;; 0e:757d ????????
    db   $00, $0e, $ff                                 ;; 0e:7585 ???

data_0e_7588:
    db   $e4, $fe, $79, $e0, $71, $7a, $e5, $80        ;; 0e:7588 ????????
    db   $e6, $03, $d1, $0f, $0f, $0f, $0f, $8f        ;; 0e:7590 ????????
    db   $8b, $d8, $84, $86, $48, $89, $5b, $d8        ;; 0e:7598 ????????
    db   $53, $51, $dc, $5b, $8f, $81, $86, $88        ;; 0e:75a0 ????????
    db   $89, $8b, $5d, $1b, $89, $88, $89, $8b        ;; 0e:75a8 ????????
    db   $89, $88, $29, $88, $89, $88, $86, $28        ;; 0e:75b0 ????????
    db   $84, $86, $88, $89, $26, $56, $88, $86        ;; 0e:75b8 ????????
    db   $25, $e0, $31, $7a, $e5, $40, $86, $84        ;; 0e:75c0 ????????
    db   $86, $88, $89, $87, $89, $87, $09, $dc        ;; 0e:75c8 ????????
    db   $e0, $5b, $7a, $e5, $00, $5b, $9b, $99        ;; 0e:75d0 ????????
    db   $9b, $5d, $9d, $9b, $9d, $d8, $52, $92        ;; 0e:75d8 ????????
    db   $91, $92, $93, $94, $96, $94, $93, $91        ;; 0e:75e0 ????????
    db   $dc, $5b, $9b, $99, $9b, $5d, $9d, $9b        ;; 0e:75e8 ????????
    db   $9d, $d8, $52, $92, $91, $92, $e5, $80        ;; 0e:75f0 ????????
    db   $a3, $a4, $a6, $a8, $e6, $02, $b9, $bb        ;; 0e:75f8 ????????
    db   $e6, $03, $bd, $d8, $b3, $e6, $01, $b4        ;; 0e:7600 ????????
    db   $b6, $e0, $4b, $7a, $e5, $00, $e6, $03        ;; 0e:7608 ????????
    db   $dc, $93, $93, $93, $93, $dc, $9b, $d8        ;; 0e:7610 ????????
    db   $93, $94, $94, $94, $94, $91, $94, $e0        ;; 0e:7618 ????????
    db   $5b, $7a, $06, $dc, $e3, $02, $3b, $98        ;; 0e:7620 ????????
    db   $99, $8b, $d8, $83, $84, $86, $dc, $5b        ;; 0e:7628 ????????
    db   $d8, $23, $56, $36, $96, $98, $89, $86        ;; 0e:7630 ????????
    db   $84, $82, $eb, $01, $5c, $76, $92, $94        ;; 0e:7638 ????????
    db   $92, $21, $54, $37, $94, $96, $87, $8c        ;; 0e:7640 ????????
    db   $8b, $89, $22, $dc, $2b, $2c, $8e, $d8        ;; 0e:7648 ????????
    db   $84, $82, $80, $dc, $5b, $59, $5b, $89        ;; 0e:7650 ????????
    db   $8b, $e2, $26, $76, $92, $94, $92, $51        ;; 0e:7658 ????????
    db   $ae, $a3, $a1, $a3, $a4, $a3, $a1, $a3        ;; 0e:7660 ????????
    db   $46, $a9, $a8, $26, $24, $26, $dc, $3b        ;; 0e:7668 ????????
    db   $9d, $9b, $49, $86, $58, $d8, $e0, $31        ;; 0e:7670 ????????
    db   $7a, $e6, $02, $54, $53, $52, $e0, $6f        ;; 0e:7678 ????????
    db   $7a, $54, $e6, $01, $59, $e6, $03, $2d        ;; 0e:7680 ????????
    db   $e0, $5b, $7a, $8f, $ab, $a9, $8b, $d8        ;; 0e:7688 ????????
    db   $81, $e6, $02, $a3, $a4, $a3, $a1, $dc        ;; 0e:7690 ????????
    db   $e6, $01, $ab, $ad, $ab, $a9, $e0, $6f        ;; 0e:7698 ????????
    db   $7a, $53, $e6, $02, $58, $e6, $03, $2b        ;; 0e:76a0 ????????
    db   $e0, $5b, $7a, $8f, $d8, $a1, $dc, $ab        ;; 0e:76a8 ????????
    db   $88, $8b, $e6, $01, $ad, $d8, $a3, $a1        ;; 0e:76b0 ????????
    db   $dc, $ab, $e6, $02, $a9, $ab, $a9, $a8        ;; 0e:76b8 ????????
    db   $8f, $81, $83, $81, $e6, $01, $8f, $83        ;; 0e:76c0 ????????
    db   $84, $83, $e6, $03, $84, $a3, $a4, $86        ;; 0e:76c8 ????????
    db   $a4, $a6, $88, $a6, $a8, $89, $a8, $a9        ;; 0e:76d0 ????????
    db   $4b, $a8, $a9, $8b, $d8, $83, $84, $86        ;; 0e:76d8 ????????
    db   $43, $a3, $a1, $50, $81, $80, $dc, $e6        ;; 0e:76e0 ????????
    db   $02, $8f, $84, $86, $a3, $a4, $e6, $01        ;; 0e:76e8 ????????
    db   $8f, $86, $88, $a4, $a6, $e5, $40, $e6        ;; 0e:76f0 ????????
    db   $03, $a8, $a6, $a4, $a6, $e5, $00, $a8        ;; 0e:76f8 ????????
    db   $a6, $a8, $a9, $e5, $40, $ab, $a9, $a8        ;; 0e:7700 ????????
    db   $a9, $e5, $80, $ab, $a9, $ab, $ad, $e5        ;; 0e:7708 ????????
    db   $00, $a7, $a9, $a7, $a6, $e6, $01, $a7        ;; 0e:7710 ????????
    db   $a9, $a7, $a6, $e6, $03, $a7, $a9, $a7        ;; 0e:7718 ????????
    db   $a6, $e6, $02, $a7, $a9, $a7, $a6, $e6        ;; 0e:7720 ????????
    db   $03, $a4, $a6, $a7, $a6, $e6, $01, $a7        ;; 0e:7728 ????????
    db   $a9, $ab, $a9, $e6, $03, $a7, $a9, $a7        ;; 0e:7730 ????????
    db   $a6, $e6, $02, $a4, $a6, $a7, $a6, $e5        ;; 0e:7738 ????????
    db   $80, $e6, $03, $a2, $a1, $a2, $a4, $a6        ;; 0e:7740 ????????
    db   $a4, $a6, $a8, $a9, $a8, $a9, $ab, $ad        ;; 0e:7748 ????????
    db   $d8, $a2, $a4, $a6, $a4, $a2, $a4, $a6        ;; 0e:7750 ????????
    db   $e5, $40, $a8, $a6, $a4, $a2, $e5, $00        ;; 0e:7758 ????????
    db   $a1, $a2, $a1, $dc, $ab, $e5, $40, $a9        ;; 0e:7760 ????????
    db   $ab, $a9, $a8, $e0, $59, $7a, $e5, $00        ;; 0e:7768 ????????
    db   $e6, $03, $8f, $84, $86, $84, $56, $59        ;; 0e:7770 ????????
    db   $8f, $88, $89, $8b, $2a, $8f, $86, $88        ;; 0e:7778 ????????
    db   $86, $22, $8f, $84, $86, $84, $88, $86        ;; 0e:7780 ????????
    db   $84, $82, $52, $59, $88, $86, $84, $86        ;; 0e:7788 ????????
    db   $58, $5b, $2a, $8f, $82, $84, $86, $52        ;; 0e:7790 ????????
    db   $54, $42, $a1, $dc, $ab, $5d, $e0, $71        ;; 0e:7798 ????????
    db   $7a, $e6, $02, $bb, $d8, $b0, $e6, $03        ;; 0e:77a0 ????????
    db   $b2, $b4, $e6, $01, $b5, $b6, $e6, $03        ;; 0e:77a8 ????????
    db   $17, $87, $89, $5a, $d8, $52, $81, $84        ;; 0e:77b0 ????????
    db   $dc, $87, $8d, $29, $8e, $87, $89, $8b        ;; 0e:77b8 ????????
    db   $89, $8c, $8b, $89, $5b, $8c, $d8, $82        ;; 0e:77c0 ????????
    db   $dc, $58, $42, $88, $86, $84, $24, $59        ;; 0e:77c8 ????????
    db   $56, $84, $82, $84, $85, $27, $8b, $89        ;; 0e:77d0 ????????
    db   $87, $89, $57, $55, $24, $8e, $85, $84        ;; 0e:77d8 ????????
    db   $82, $04, $ff                                 ;; 0e:77e0 ???

data_0e_77e3:
    db   $e4, $fe, $79, $e8, $85, $7a, $e0, $40        ;; 0e:77e3 ????????
    db   $e6, $03, $d2, $04, $09, $04, $29, $2b        ;; 0e:77eb ????????
    db   $14, $8e, $86, $08, $06, $51, $58, $2d        ;; 0e:77f3 ????????
    db   $d8, $02, $11, $dc, $5b, $29, $28, $2d        ;; 0e:77fb ????????
    db   $8e, $8b, $89, $88, $46, $88, $49, $8b        ;; 0e:7803 ????????
    db   $1c, $cb, $c9, $c8, $c6, $c4, $c3, $c1        ;; 0e:780b ????????
    db   $c0, $dc, $e6, $02, $8b, $8f, $e6, $03        ;; 0e:7813 ????????
    db   $bb, $bf, $bb, $bf, $bb, $bf, $e6, $01        ;; 0e:781b ????????
    db   $8b, $8f, $e6, $03, $bb, $bf, $bb, $bf        ;; 0e:7823 ????????
    db   $bb, $bf, $e6, $02, $8b, $8f, $e6, $03        ;; 0e:782b ????????
    db   $bb, $bf, $bb, $bf, $bb, $bf, $e6, $01        ;; 0e:7833 ????????
    db   $9b, $9e, $9f, $d8, $e6, $03, $96, $9f        ;; 0e:783b ????????
    db   $96, $dc, $e6, $02, $8b, $8f, $e6, $03        ;; 0e:7843 ????????
    db   $bb, $bf, $bb, $bf, $bb, $bf, $e6, $01        ;; 0e:784b ????????
    db   $8b, $8f, $e6, $03, $bb, $bf, $bb, $bf        ;; 0e:7853 ????????
    db   $bb, $bf, $e6, $02, $8b, $8f, $e6, $03        ;; 0e:785b ????????
    db   $bb, $bf, $bb, $bf, $bb, $bf, $8b, $4f        ;; 0e:7863 ????????
    db   $d8, $2b, $29, $8b, $8f, $89, $8f, $88        ;; 0e:786b ????????
    db   $8f, $86, $8f, $e3, $02, $e6, $02, $84        ;; 0e:7873 ????????
    db   $8f, $e6, $01, $84, $8f, $e6, $02, $84        ;; 0e:787b ????????
    db   $8f, $e6, $01, $84, $8f, $e6, $02, $83        ;; 0e:7883 ????????
    db   $8f, $e6, $01, $83, $8f, $e6, $02, $83        ;; 0e:788b ????????
    db   $8f, $e6, $01, $83, $8f, $e6, $02, $82        ;; 0e:7893 ????????
    db   $8f, $e6, $01, $82, $8f, $e6, $02, $82        ;; 0e:789b ????????
    db   $8f, $e6, $01, $82, $8f, $dc, $eb, $01        ;; 0e:78a3 ????????
    db   $f8, $78, $e6, $02, $89, $8f, $e6, $01        ;; 0e:78ab ????????
    db   $89, $8f, $e6, $02, $89, $8f, $e6, $01        ;; 0e:78b3 ????????
    db   $89, $8f, $e6, $02, $8c, $8f, $e6, $01        ;; 0e:78bb ????????
    db   $8c, $8f, $e6, $02, $8c, $8f, $e6, $01        ;; 0e:78c3 ????????
    db   $8c, $8f, $e6, $02, $87, $8f, $e6, $01        ;; 0e:78cb ????????
    db   $87, $8f, $e6, $02, $87, $8f, $e6, $01        ;; 0e:78d3 ????????
    db   $87, $8f, $e6, $02, $8c, $8f, $e6, $01        ;; 0e:78db ????????
    db   $8c, $8f, $e6, $02, $8c, $8f, $e6, $01        ;; 0e:78e3 ????????
    db   $8c, $8f, $e6, $03, $2b, $8e, $8f, $8d        ;; 0e:78eb ????????
    db   $d8, $83, $e2, $78, $78, $e6, $02, $89        ;; 0e:78f3 ????????
    db   $8f, $e6, $01, $89, $8f, $e6, $02, $89        ;; 0e:78fb ????????
    db   $8f, $e6, $01, $89, $8f, $d8, $e6, $03        ;; 0e:7903 ????????
    db   $2b, $29, $28, $29, $e6, $02, $84, $8f        ;; 0e:790b ????????
    db   $e6, $01, $84, $8f, $dc, $e6, $02, $8b        ;; 0e:7913 ????????
    db   $8f, $e6, $01, $8b, $8f, $e6, $03, $d8        ;; 0e:791b ????????
    db   $84, $8f, $e6, $01, $54, $56, $58, $e6        ;; 0e:7923 ????????
    db   $03, $09, $8b, $8f, $1f, $08, $8d, $4f        ;; 0e:792b ????????
    db   $2b, $dc, $a6, $af, $a6, $7f, $86, $a8        ;; 0e:7933 ????????
    db   $af, $a8, $7f, $88, $e6, $02, $59, $e6        ;; 0e:793b ????????
    db   $01, $5b, $e6, $02, $5d, $d8, $e6, $01        ;; 0e:7943 ????????
    db   $53, $e6, $02, $54, $e6, $01, $5b, $d8        ;; 0e:794b ????????
    db   $e6, $03, $24, $dc, $e6, $02, $5b, $e6        ;; 0e:7953 ????????
    db   $01, $59, $e6, $03, $28, $dc, $a9, $af        ;; 0e:795b ????????
    db   $a9, $7f, $a9, $af, $ab, $af, $ab, $7f        ;; 0e:7963 ????????
    db   $ab, $af, $d8, $11, $5f, $a0, $af, $a0        ;; 0e:796b ????????
    db   $7f, $a0, $af, $a0, $af, $a0, $7f, $a0        ;; 0e:7973 ????????
    db   $af, $a0, $af, $a0, $7f, $a0, $af, $a0        ;; 0e:797b ????????
    db   $af, $a0, $7f, $a0, $af, $02, $e6, $02        ;; 0e:7983 ????????
    db   $54, $d8, $e6, $01, $52, $e6, $02, $51        ;; 0e:798b ????????
    db   $dc, $e6, $01, $5b, $e6, $03, $29, $2b        ;; 0e:7993 ????????
    db   $2d, $26, $2b, $54, $58, $29, $24, $22        ;; 0e:799b ????????
    db   $24, $4d, $88, $26, $dc, $2b, $d8, $24        ;; 0e:79a3 ????????
    db   $59, $54, $dc, $59, $57, $7c, $af, $7c        ;; 0e:79ab ????????
    db   $af, $7b, $af, $7b, $af, $7a, $af, $7a        ;; 0e:79b3 ????????
    db   $af, $79, $af, $79, $af, $d8, $72, $af        ;; 0e:79bb ????????
    db   $72, $af, $71, $af, $71, $af, $70, $af        ;; 0e:79c3 ????????
    db   $70, $af, $57, $89, $8b, $54, $48, $8b        ;; 0e:79cb ????????
    db   $89, $88, $59, $57, $26, $77, $af, $77        ;; 0e:79d3 ????????
    db   $af, $77, $af, $77, $af, $dc, $77, $af        ;; 0e:79db ????????
    db   $77, $af, $77, $af, $77, $af, $d8, $70        ;; 0e:79e3 ????????
    db   $af, $70, $af, $80, $e6, $02, $89, $e6        ;; 0e:79eb ????????
    db   $03, $87, $e6, $01, $85, $e6, $03, $20        ;; 0e:79f3 ????????
    db   $5e, $5f, $ff                                 ;; 0e:79fb ???

frequencyDeltaData:
    db   $0a, $00, $01, $01, $01, $02, $01, $01        ;; 0e:79fe .w.w.w.w
    db   $01, $00, $00, $00, $7a                       ;; 0e:7a06 .w...
.second:
    db   $02, $00, $02, $0a, $00, $0b, $7a             ;; 0e:7a0b ???????
.third:
    db   $04, $00, $01, $02, $01, $ff, $00, $14        ;; 0e:7a12 ????????
    db   $7a                                           ;; 0e:7a1a ?
.fourth:
    db   $05, $00, $02, $01, $02, $00, $00, $1d        ;; 0e:7a1b ????????
    db   $7a                                           ;; 0e:7a23 ?
.fifth:
    db   $0a, $00, $01, $02, $01, $04, $01, $02        ;; 0e:7a24 ????????
    db   $01, $00, $00, $26, $7a                       ;; 0e:7a2c ?????

;@data format=bb amount=34
volumeEnvelopeData:
    db   $0a, $8c                                      ;; 0e:7a31 .. $00
    db   $63, $f7                                      ;; 0e:7a33 .. $01
    db   $ff, $08                                      ;; 0e:7a35 ?? $02
    db   $8c, $63                                      ;; 0e:7a37 ?? $03
    db   $c7, $ff                                      ;; 0e:7a39 ?? $04
    db   $63, $c2                                      ;; 0e:7a3b ?? $05
    db   $63, $10                                      ;; 0e:7a3d ?? $06
    db   $63, $b2                                      ;; 0e:7a3f .. $07
    db   $63, $10                                      ;; 0e:7a41 ?? $08
    db   $63, $a2                                      ;; 0e:7a43 .. $09
    db   $63, $10                                      ;; 0e:7a45 ?? $0a
    db   $05, $92                                      ;; 0e:7a47 ?? $0b
    db   $63, $10                                      ;; 0e:7a49 ?? $0c
    db   $05, $82                                      ;; 0e:7a4b ?? $0d
    db   $63, $10                                      ;; 0e:7a4d ?? $0e
    db   $63, $62                                      ;; 0e:7a4f ?? $0f
    db   $63, $10                                      ;; 0e:7a51 ?? $10
    db   $63, $c4                                      ;; 0e:7a53 .. $11
    db   $63, $b4                                      ;; 0e:7a55 .. $12
    db   $63, $a4                                      ;; 0e:7a57 .. $13
    db   $63, $94                                      ;; 0e:7a59 ?? $14
    db   $63, $84                                      ;; 0e:7a5b .. $15
    db   $63, $74                                      ;; 0e:7a5d ?? $16
    db   $63, $64                                      ;; 0e:7a5f .. $17
    db   $63, $54                                      ;; 0e:7a61 .. $18
    db   $63, $44                                      ;; 0e:7a63 .. $19
    db   $63, $34                                      ;; 0e:7a65 .. $1a
    db   $63, $24                                      ;; 0e:7a67 .. $1b
    db   $63, $c7                                      ;; 0e:7a69 .. $1c
    db   $63, $b7                                      ;; 0e:7a6b .. $1d
    db   $63, $a7                                      ;; 0e:7a6d .. $1e
    db   $63, $97                                      ;; 0e:7a6f ?? $1f
    db   $63, $87                                      ;; 0e:7a71 ?? $20
    db   $63, $67                                      ;; 0e:7a73 ?? $21
; Wave table patterns.
; 7a75: 50% duty cycle
; 7a85: 25% duty cycle
; 7a95: 50% duty cycle lower volume
; 7aa5: 25% duty cycle lower volume
; 7ab5: Weird tone
;@data format=bbbbbbbbbbbbbbbb amount=5
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00 ;; 0e:7a75 ................ $00
    db   $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;; 0e:7a85 ???????????????? $01
    db   $bb, $bb, $bb, $bb, $bb, $bb, $bb, $bb, $00, $00, $00, $00, $00, $00, $00, $00 ;; 0e:7a95 ???????????????? $02
    db   $bb, $bb, $bb, $bb, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;; 0e:7aa5 ................ $03
    db   $ff, $cc, $99, $66, $99, $cc, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;; 0e:7ab5 ???????????????? $04

;@data format=p amount=57
soundEffectDataChannel1:
    dw   data_0e_7baa                                  ;; 0e:7ac5 ?? $00
    dw   data_0e_7bd9                                  ;; 0e:7ac7 ?? $01
    dw   data_0e_7bf5                                  ;; 0e:7ac9 ?? $02
    dw   soundEffectChannelUnused                      ;; 0e:7acb ?? $03
    dw   data_0e_7c0d                                  ;; 0e:7acd ?? $04
    dw   soundEffectChannelUnused                      ;; 0e:7acf ?? $05
    dw   soundEffectChannelUnused                      ;; 0e:7ad1 ?? $06
    dw   data_0e_7c2c                                  ;; 0e:7ad3 ?? $07
    dw   data_0e_7c39                                  ;; 0e:7ad5 ?? $08
    dw   data_0e_7c52                                  ;; 0e:7ad7 ?? $09
    dw   data_0e_7c65                                  ;; 0e:7ad9 ?? $0a
    dw   soundEffectChannelUnused                      ;; 0e:7adb ?? $0b
    dw   data_0e_7c7f                                  ;; 0e:7add ?? $0c
    dw   data_0e_7c97                                  ;; 0e:7adf ?? $0d
    dw   data_0e_7c9e                                  ;; 0e:7ae1 ?? $0e
    dw   soundEffectChannelUnused                      ;; 0e:7ae3 ?? $0f
    dw   data_0e_7cc8                                  ;; 0e:7ae5 ?? $10
    dw   soundEffectChannelUnused                      ;; 0e:7ae7 ?? $11
    dw   data_0e_7cee                                  ;; 0e:7ae9 .. $12
    dw   soundEffectChannelUnused                      ;; 0e:7aeb ?? $13
    dw   data_0e_7d06                                  ;; 0e:7aed ?? $14
    dw   soundEffectChannelUnused                      ;; 0e:7aef .. $15
    dw   soundEffectChannelUnused                      ;; 0e:7af1 ?? $16
    dw   soundEffectChannelUnused                      ;; 0e:7af3 ?? $17
    dw   data_0e_7d47                                  ;; 0e:7af5 ?? $18
    dw   data_0e_7d76                                  ;; 0e:7af7 ?? $19
    dw   soundEffectChannelUnused                      ;; 0e:7af9 ?? $1a
    dw   data_0e_7dc6                                  ;; 0e:7afb ?? $1b
    dw   data_0e_7dda                                  ;; 0e:7afd ?? $1c
    dw   data_0e_7dfd                                  ;; 0e:7aff ?? $1d
    dw   data_0e_7e16                                  ;; 0e:7b01 ?? $1e
    dw   data_0e_7e32                                  ;; 0e:7b03 .. $1f
    dw   data_0e_7e46                                  ;; 0e:7b05 ?? $20
    dw   data_0e_7e69                                  ;; 0e:7b07 .. $21
    dw   data_0e_7e76                                  ;; 0e:7b09 ?? $22
    dw   data_0e_7e84                                  ;; 0e:7b0b ?? $23
    dw   data_0e_7e98                                  ;; 0e:7b0d ?? $24
    dw   soundEffectChannelUnused                      ;; 0e:7b0f .. $25
    dw   data_0e_7eb0                                  ;; 0e:7b11 ?? $26
    dw   soundEffectChannelUnused                      ;; 0e:7b13 .. $27
    dw   soundEffectChannelUnused                      ;; 0e:7b15 .. $28
    dw   data_0e_7ee8                                  ;; 0e:7b17 ?? $29
    dw   data_0e_7eef                                  ;; 0e:7b19 ?? $2a
    dw   data_0e_7f03                                  ;; 0e:7b1b ?? $2b
    dw   data_0e_7f11                                  ;; 0e:7b1d ?? $2c
    dw   data_0e_7f30                                  ;; 0e:7b1f ?? $2d
    dw   soundEffectChannelUnused                      ;; 0e:7b21 ?? $2e
    dw   data_0e_7f51                                  ;; 0e:7b23 ?? $2f
    dw   data_0e_7f6a                                  ;; 0e:7b25 ?? $30
    dw   data_0e_7f77                                  ;; 0e:7b27 ?? $31
    dw   data_0e_7f90                                  ;; 0e:7b29 .. $32
    dw   data_0e_7f97                                  ;; 0e:7b2b ?? $33
    dw   soundEffectChannelUnused                      ;; 0e:7b2d ?? $34
    dw   soundEffectChannelUnused                      ;; 0e:7b2f ?? $35
    dw   data_0e_7fbf                                  ;; 0e:7b31 .. $36
    dw   soundEffectChannelUnused                      ;; 0e:7b33 .. $37
    dw   data_0e_7fe2                                  ;; 0e:7b35 ?? $38

;@data format=p amount=57
soundEffectDataChannel4:
    dw   data_0e_7bc9                                  ;; 0e:7b37 ?? $00
    dw   data_0e_7bea                                  ;; 0e:7b39 ?? $01
    dw   soundEffectChannelUnused                      ;; 0e:7b3b ?? $02
    dw   data_0e_7bfc                                  ;; 0e:7b3d ?? $03
    dw   data_0e_7c14                                  ;; 0e:7b3f ?? $04
    dw   data_0e_7c18                                  ;; 0e:7b41 ?? $05
    dw   data_0e_7c22                                  ;; 0e:7b43 ?? $06
    dw   soundEffectChannelUnused                      ;; 0e:7b45 ?? $07
    dw   data_0e_7c44                                  ;; 0e:7b47 ?? $08
    dw   data_0e_7c5d                                  ;; 0e:7b49 ?? $09
    dw   soundEffectChannelUnused                      ;; 0e:7b4b ?? $0a
    dw   data_0e_7c78                                  ;; 0e:7b4d ?? $0b
    dw   data_0e_7c90                                  ;; 0e:7b4f ?? $0c
    dw   soundEffectChannelUnused                      ;; 0e:7b51 ?? $0d
    dw   soundEffectChannelUnused                      ;; 0e:7b53 ?? $0e
    dw   data_0e_7cb7                                  ;; 0e:7b55 ?? $0f
    dw   data_0e_7cd9                                  ;; 0e:7b57 ?? $10
    dw   data_0e_7ce4                                  ;; 0e:7b59 ?? $11
    dw   soundEffectChannelUnused                      ;; 0e:7b5b .. $12
    dw   data_0e_7cff                                  ;; 0e:7b5d ?? $13
    dw   soundEffectChannelUnused                      ;; 0e:7b5f ?? $14
    dw   data_0e_7d0d                                  ;; 0e:7b61 .. $15
    dw   data_0e_7d11                                  ;; 0e:7b63 ?? $16
    dw   data_0e_7d31                                  ;; 0e:7b65 ?? $17
    dw   data_0e_7d66                                  ;; 0e:7b67 ?? $18
    dw   data_0e_7d8d                                  ;; 0e:7b69 ?? $19
    dw   data_0e_7d9b                                  ;; 0e:7b6b ?? $1a
    dw   data_0e_7dd3                                  ;; 0e:7b6d ?? $1b
    dw   data_0e_7df3                                  ;; 0e:7b6f ?? $1c
    dw   soundEffectChannelUnused                      ;; 0e:7b71 ?? $1d
    dw   data_0e_7e27                                  ;; 0e:7b73 ?? $1e
    dw   data_0e_7e3f                                  ;; 0e:7b75 .. $1f
    dw   data_0e_7e5f                                  ;; 0e:7b77 ?? $20
    dw   soundEffectChannelUnused                      ;; 0e:7b79 .. $21
    dw   data_0e_7e7d                                  ;; 0e:7b7b ?? $22
    dw   data_0e_7e91                                  ;; 0e:7b7d ?? $23
    dw   data_0e_7e9f                                  ;; 0e:7b7f ?? $24
    dw   data_0e_7ea6                                  ;; 0e:7b81 .. $25
    dw   data_0e_7ec3                                  ;; 0e:7b83 ?? $26
    dw   data_0e_7ed3                                  ;; 0e:7b85 .. $27
    dw   data_0e_7edd                                  ;; 0e:7b87 .. $28
    dw   soundEffectChannelUnused                      ;; 0e:7b89 ?? $29
    dw   data_0e_7efc                                  ;; 0e:7b8b ?? $2a
    dw   data_0e_7f0a                                  ;; 0e:7b8d ?? $2b
    dw   data_0e_7f22                                  ;; 0e:7b8f ?? $2c
    dw   data_0e_7f43                                  ;; 0e:7b91 ?? $2d
    dw   data_0e_7f4d                                  ;; 0e:7b93 ?? $2e
    dw   soundEffectChannelUnused                      ;; 0e:7b95 ?? $2f
    dw   soundEffectChannelUnused                      ;; 0e:7b97 ?? $30
    dw   soundEffectChannelUnused                      ;; 0e:7b99 ?? $31
    dw   soundEffectChannelUnused                      ;; 0e:7b9b .. $32
    dw   data_0e_7fa4                                  ;; 0e:7b9d ?? $33
    dw   data_0e_7fae                                  ;; 0e:7b9f ?? $34
    dw   data_0e_7fb8                                  ;; 0e:7ba1 ?? $35
    dw   soundEffectChannelUnused                      ;; 0e:7ba3 .. $36
    dw   data_0e_7fcc                                  ;; 0e:7ba5 .. $37
    dw   soundEffectChannelUnused                      ;; 0e:7ba7 ?? $38

soundEffectChannelUnused:
    db   $00                                           ;; 0e:7ba9 .

data_0e_7baa:
    db   $05, $44, $00, $f3, $ff, $85, $29, $2f        ;; 0e:7baa ????????
    db   $80, $f0, $ff, $87, $04, $00, $00, $f0        ;; 0e:7bb2 ????????
    db   $00, $80, $09, $2b, $80, $f3, $ff, $86        ;; 0e:7bba ????????
    db   $39, $2b, $00, $f3, $ff, $86, $00             ;; 0e:7bc2 ???????

data_0e_7bc9:
    db   $07, $da, $42, $21, $f3, $7b, $04, $ca        ;; 0e:7bc9 ????????
    db   $61, $09, $fc, $7c, $39, $f5, $35, $00        ;; 0e:7bd1 ????????

data_0e_7bd9:
    db   $f8, $02, $2a, $80, $f3, $ff, $85, $01        ;; 0e:7bd9 ????????
    db   $2f, $80, $f0, $ff, $87, $ef, $da, $7b        ;; 0e:7be1 ????????
    db   $00                                           ;; 0e:7be9 ?

data_0e_7bea:
    db   $f8, $02, $f1, $42, $01, $a0, $00, $ef        ;; 0e:7bea ????????
    db   $eb, $7b, $00                                 ;; 0e:7bf2 ???

data_0e_7bf5:
    db   $0f, $27, $80, $f7, $ee, $86, $00             ;; 0e:7bf5 ???????

data_0e_7bfc:
    db   $f2, $06, $89, $12, $06, $39, $36, $06        ;; 0e:7bfc ????????
    db   $89, $62, $06, $29, $26, $ef, $fd, $7b        ;; 0e:7c04 ????????
    db   $00                                           ;; 0e:7c0c ?

data_0e_7c0d:
    db   $60, $27, $00, $ff, $00, $82, $00             ;; 0e:7c0d ???????

data_0e_7c14:
    db   $60, $58, $41, $00                            ;; 0e:7c14 ????

data_0e_7c18:
    db   $03, $f1, $6c, $01, $32, $11, $27, $f2        ;; 0e:7c18 ????????
    db   $32, $00                                      ;; 0e:7c20 ??

data_0e_7c22:
    db   $02, $ca, $6a, $08, $fc, $7c, $30, $a7        ;; 0e:7c22 ????????
    db   $35, $00                                      ;; 0e:7c2a ??

data_0e_7c2c:
    db   $02, $00, $40, $fa, $a0, $87, $10, $00        ;; 0e:7c2c ????????
    db   $00, $a2, $e0, $87, $00                       ;; 0e:7c34 ?????

data_0e_7c39:
    db   $f3, $23, $4d, $00, $d1, $00, $85, $ef        ;; 0e:7c39 ????????
    db   $3a, $7c, $00                                 ;; 0e:7c41 ???

data_0e_7c44:
    db   $f3, $13, $91, $2b, $08, $91, $2a, $08        ;; 0e:7c44 ????????
    db   $91, $2a, $ef, $45, $7c, $00                  ;; 0e:7c4c ??????

data_0e_7c52:
    db   $f6, $21, $75, $80, $f8, $ff, $80, $ef        ;; 0e:7c52 ????????
    db   $53, $7c, $00                                 ;; 0e:7c5a ???

data_0e_7c5d:
    db   $f6, $21, $f1, $5d, $ef, $5e, $7c, $00        ;; 0e:7c5d ????????

data_0e_7c65:
    db   $16, $57, $80, $f7, $f7, $86, $16, $47        ;; 0e:7c65 ????????
    db   $80, $94, $f7, $86, $16, $37, $80, $55        ;; 0e:7c6d ????????
    db   $f7, $86, $00                                 ;; 0e:7c75 ???

data_0e_7c78:
    db   $1a, $f4, $37, $20, $f7, $10, $00             ;; 0e:7c78 ???????

data_0e_7c7f:
    db   $f4, $05, $2f, $80, $f8, $ff, $87, $04        ;; 0e:7c7f ????????
    db   $3f, $80, $f8, $ff, $87, $ef, $80, $7c        ;; 0e:7c87 ????????
    db   $00                                           ;; 0e:7c8f ?

data_0e_7c90:
    db   $05, $f8, $08, $22, $f3, $17, $00             ;; 0e:7c90 ???????

data_0e_7c97:
    db   $1a, $37, $80, $fd, $50, $87, $00             ;; 0e:7c97 ???????

data_0e_7c9e:
    db   $17, $37, $80, $ff, $20, $86, $17, $37        ;; 0e:7c9e ????????
    db   $80, $cf, $50, $86, $17, $37, $40, $9f        ;; 0e:7ca6 ????????
    db   $80, $86, $17, $37, $00, $6f, $b0, $86        ;; 0e:7cae ????????
    db   $00                                           ;; 0e:7cb6 ?

data_0e_7cb7:
    db   $f3, $03, $8f, $12, $05, $89, $31, $03        ;; 0e:7cb7 ????????
    db   $8f, $24, $05, $89, $31, $ef, $b8, $7c        ;; 0e:7cbf ????????
    db   $00                                           ;; 0e:7cc7 ?

data_0e_7cc8:
    db   $f4, $05, $4d, $80, $f1, $ff, $87, $08        ;; 0e:7cc8 ????????
    db   $00, $80, $91, $ff, $86, $ef, $c9, $7c        ;; 0e:7cd0 ????????
    db   $00                                           ;; 0e:7cd8 ?

data_0e_7cd9:
    db   $f4, $05, $91, $13, $08, $f7, $09, $ef        ;; 0e:7cd9 ????????
    db   $da, $7c, $00                                 ;; 0e:7ce1 ???

data_0e_7ce4:
    db   $04, $c1, $4b, $01, $01, $34, $04, $a1        ;; 0e:7ce4 ????????
    db   $34, $00                                      ;; 0e:7cec ??

data_0e_7cee:
    db   $f6, $01, $00, $40, $f0, $00, $86, $01        ;; 0e:7cee ........
    db   $00, $80, $f0, $00, $87, $ef, $ef, $7c        ;; 0e:7cf6 ........
    db   $00                                           ;; 0e:7cfe .

data_0e_7cff:
    db   $40, $2f, $32, $40, $f5, $32, $00             ;; 0e:7cff ???????

data_0e_7d06:
    db   $17, $7c, $80, $f3, $aa, $86, $00             ;; 0e:7d06 ???????

data_0e_7d0d:
    db   $20, $f2, $80, $00                            ;; 0e:7d0d ....

data_0e_7d11:
    db   $03, $f1, $31, $08, $05, $22, $04, $a1        ;; 0e:7d11 ????????
    db   $01, $04, $d1, $11, $04, $f1, $31, $f3        ;; 0e:7d19 ????????
    db   $02, $f1, $31, $08, $01, $44, $02, $f1        ;; 0e:7d21 ????????
    db   $31, $08, $01, $44, $ef, $21, $7d, $00        ;; 0e:7d29 ????????

data_0e_7d31:
    db   $03, $f1, $30, $01, $01, $33, $05, $f2        ;; 0e:7d31 ????????
    db   $33, $03, $81, $32, $03, $f1, $30, $01        ;; 0e:7d39 ????????
    db   $01, $43, $17, $f2, $33, $00                  ;; 0e:7d41 ??????

data_0e_7d47:
    db   $04, $08, $00, $f9, $aa, $85, $13, $23        ;; 0e:7d47 ????????
    db   $80, $f2, $aa, $82, $13, $23, $40, $c2        ;; 0e:7d4f ????????
    db   $aa, $82, $13, $23, $00, $82, $aa, $82        ;; 0e:7d57 ????????
    db   $13, $23, $80, $53, $aa, $82, $00             ;; 0e:7d5f ???????

data_0e_7d66:
    db   $04, $f1, $35, $13, $f2, $3b, $13, $c3        ;; 0e:7d66 ????????
    db   $3b, $13, $84, $3b, $13, $55, $3b, $00        ;; 0e:7d6e ????????

data_0e_7d76:
    db   $f2, $04, $2a, $80, $f1, $aa, $85, $01        ;; 0e:7d76 ????????
    db   $22, $80, $02, $aa, $82, $0a, $23, $40        ;; 0e:7d7e ????????
    db   $f2, $aa, $82, $ef, $77, $7d, $00             ;; 0e:7d86 ???????

data_0e_7d8d:
    db   $f2, $04, $f1, $3d, $01, $f2, $33, $0a        ;; 0e:7d8d ????????
    db   $f1, $43, $ef, $8e, $7d, $00                  ;; 0e:7d95 ??????

data_0e_7d9b:
    db   $06, $19, $25, $03, $09, $25, $06, $49        ;; 0e:7d9b ????????
    db   $25, $03, $09, $25, $06, $79, $25, $03        ;; 0e:7da3 ????????
    db   $09, $25, $06, $a9, $25, $03, $09, $25        ;; 0e:7dab ????????
    db   $06, $79, $25, $03, $09, $25, $06, $49        ;; 0e:7db3 ????????
    db   $25, $03, $09, $25, $06, $19, $25, $03        ;; 0e:7dbb ????????
    db   $09, $25, $00                                 ;; 0e:7dc3 ???

data_0e_7dc6:
    db   $03, $68, $00, $f0, $ca, $84, $20, $46        ;; 0e:7dc6 ????????
    db   $00, $0a, $ca, $84, $00                       ;; 0e:7dce ?????

data_0e_7dd3:
    db   $03, $f1, $34, $20, $0a, $33, $00             ;; 0e:7dd3 ???????

data_0e_7dda:
    db   $0a, $15, $00, $f0, $ca, $84, $0a, $15        ;; 0e:7dda ????????
    db   $00, $c0, $ca, $84, $0a, $15, $00, $90        ;; 0e:7de2 ????????
    db   $ca, $84, $0a, $15, $00, $60, $ca, $84        ;; 0e:7dea ????????
    db   $00                                           ;; 0e:7df2 ?

data_0e_7df3:
    db   $0c, $09, $35, $01, $03, $33, $21, $f3        ;; 0e:7df3 ????????
    db   $34, $00                                      ;; 0e:7dfb ??

data_0e_7dfd:
    db   $10, $26, $c0, $f4, $20, $83, $10, $26        ;; 0e:7dfd ????????
    db   $80, $f4, $50, $85, $10, $26, $40, $f4        ;; 0e:7e05 ????????
    db   $80, $84, $17, $26, $00, $f7, $b0, $85        ;; 0e:7e0d ????????
    db   $00                                           ;; 0e:7e15 ?

data_0e_7e16:
    db   $f4, $05, $13, $80, $f4, $20, $82, $05        ;; 0e:7e16 ????????
    db   $13, $00, $f4, $50, $82, $ef, $17, $7e        ;; 0e:7e1e ????????
    db   $00                                           ;; 0e:7e26 ?

data_0e_7e27:
    db   $f4, $05, $f1, $28, $05, $f1, $38, $ef        ;; 0e:7e27 ????????
    db   $28, $7e, $00                                 ;; 0e:7e2f ???

data_0e_7e32:
    db   $06, $13, $00, $f1, $5a, $84, $09, $15        ;; 0e:7e32 ........
    db   $40, $d1, $ff, $85, $00                       ;; 0e:7e3a .....

data_0e_7e3f:
    db   $03, $9a, $4e, $07, $f3, $24, $00             ;; 0e:7e3f .......

data_0e_7e46:
    db   $20, $47, $40, $b7, $20, $85, $20, $37        ;; 0e:7e46 ????????
    db   $40, $c5, $2a, $85, $20, $27, $40, $d5        ;; 0e:7e4e ????????
    db   $30, $85, $20, $36, $40, $f7, $3a, $85        ;; 0e:7e56 ????????
    db   $00                                           ;; 0e:7e5e ?

data_0e_7e5f:
    db   $90, $00, $00, $0e, $ff, $14, $25, $f0        ;; 0e:7e5f ????????
    db   $62, $00                                      ;; 0e:7e67 ??

data_0e_7e69:
    db   $02, $47, $80, $61, $0e, $87, $03, $44        ;; 0e:7e69 ........
    db   $80, $f1, $0e, $87, $00                       ;; 0e:7e71 .....

data_0e_7e76:
    db   $03, $1e, $c0, $f7, $99, $87, $00             ;; 0e:7e76 ???????

data_0e_7e7d:
    db   $04, $82, $07, $02, $91, $02, $00             ;; 0e:7e7d ???????

data_0e_7e84:
    db   $03, $15, $c0, $e7, $99, $87, $05, $26        ;; 0e:7e84 ????????
    db   $40, $b0, $0e, $87, $00                       ;; 0e:7e8c ?????

data_0e_7e91:
    db   $04, $72, $07, $08, $f1, $32, $00             ;; 0e:7e91 ???????

data_0e_7e98:
    db   $1e, $08, $40, $f6, $89, $87, $00             ;; 0e:7e98 ???????

data_0e_7e9f:
    db   $02, $81, $1f, $1c, $ff, $42, $00             ;; 0e:7e9f ???????

data_0e_7ea6:
    db   $05, $f2, $65, $01, $07, $53, $32, $f7        ;; 0e:7ea6 ........
    db   $54, $00                                      ;; 0e:7eae ..

data_0e_7eb0:
    db   $03, $00, $40, $91, $00, $80, $02, $00        ;; 0e:7eb0 ????????
    db   $00, $00, $00, $80, $47, $5b, $40, $97        ;; 0e:7eb8 ????????
    db   $00, $80, $00                                 ;; 0e:7ec0 ???

data_0e_7ec3:
    db   $03, $f4, $6e, $03, $f4, $7c, $02, $f4        ;; 0e:7ec3 ????????
    db   $6e, $08, $f4, $7c, $40, $f7, $65, $00        ;; 0e:7ecb ????????

data_0e_7ed3:
    db   $06, $fa, $5e, $02, $fc, $6f, $37, $f4        ;; 0e:7ed3 ........
    db   $62, $00                                      ;; 0e:7edb ..

data_0e_7edd:
    db   $f2, $06, $f8, $5c, $07, $f1, $27, $ef        ;; 0e:7edd ........
    db   $de, $7e, $00                                 ;; 0e:7ee5 ...

data_0e_7ee8:
    db   $17, $67, $80, $f2, $20, $87, $00             ;; 0e:7ee8 ???????

data_0e_7eef:
    db   $06, $43, $00, $f1, $5a, $84, $04, $25        ;; 0e:7eef ????????
    db   $00, $f0, $96, $86, $00                       ;; 0e:7ef7 ?????

data_0e_7efc:
    db   $06, $99, $4d, $06, $a3, $34, $00             ;; 0e:7efc ???????

data_0e_7f03:
    db   $0a, $34, $40, $d0, $96, $86, $00             ;; 0e:7f03 ???????

data_0e_7f0a:
    db   $06, $a9, $52, $02, $f0, $34, $00             ;; 0e:7f0a ???????

data_0e_7f11:
    db   $f2, $09, $4a, $80, $b0, $ff, $83, $05        ;; 0e:7f11 ????????
    db   $4a, $80, $00, $ff, $83, $ef, $12, $7f        ;; 0e:7f19 ????????
    db   $00                                           ;; 0e:7f21 ?

data_0e_7f22:
    db   $f2, $05, $f1, $37, $02, $f1, $6c, $07        ;; 0e:7f22 ????????
    db   $f1, $65, $ef, $23, $7f, $00                  ;; 0e:7f2a ??????

data_0e_7f30:
    db   $04, $00, $00, $c2, $da, $87, $06, $00        ;; 0e:7f30 ????????
    db   $00, $c2, $d0, $87, $12, $00, $00, $c2        ;; 0e:7f38 ????????
    db   $cc, $87, $00                                 ;; 0e:7f40 ???

data_0e_7f43:
    db   $04, $f2, $08, $06, $f2, $08, $12, $f2        ;; 0e:7f43 ????????
    db   $08, $00                                      ;; 0e:7f4b ??

data_0e_7f4d:
    db   $40, $f4, $4b, $00                            ;; 0e:7f4d ????

data_0e_7f51:
    db   $08, $7f, $80, $f0, $d0, $87, $08, $7f        ;; 0e:7f51 ????????
    db   $80, $d1, $d0, $87, $08, $7f, $80, $b1        ;; 0e:7f59 ????????
    db   $c0, $87, $08, $7f, $80, $92, $ba, $87        ;; 0e:7f61 ????????
    db   $00                                           ;; 0e:7f69 ?

data_0e_7f6a:
    db   $0c, $2f, $80, $d0, $00, $87, $11, $2f        ;; 0e:7f6a ????????
    db   $80, $a0, $75, $86, $00                       ;; 0e:7f72 ?????

data_0e_7f77:
    db   $07, $0f, $80, $f1, $ff, $86, $07, $0f        ;; 0e:7f77 ????????
    db   $80, $d1, $e8, $86, $07, $07, $80, $b1        ;; 0e:7f7f ????????
    db   $da, $86, $07, $07, $80, $91, $c6, $86        ;; 0e:7f87 ????????
    db   $00                                           ;; 0e:7f8f ?

data_0e_7f90:
    db   $1a, $37, $80, $fd, $50, $87, $00             ;; 0e:7f90 .......

data_0e_7f97:
    db   $06, $71, $00, $a7, $80, $83, $20, $17        ;; 0e:7f97 ????????
    db   $80, $c6, $ff, $84, $00                       ;; 0e:7f9f ?????

data_0e_7fa4:
    db   $1f, $8f, $5f, $0c, $c4, $54, $35, $f4        ;; 0e:7fa4 ????????
    db   $37, $00                                      ;; 0e:7fac ??

data_0e_7fae:
    db   $0a, $f7, $31, $20, $f7, $11, $0f, $f2        ;; 0e:7fae ????????
    db   $08, $00                                      ;; 0e:7fb6 ??

data_0e_7fb8:
    db   $02, $fc, $5c, $0c, $f4, $57, $00             ;; 0e:7fb8 ???????

data_0e_7fbf:
    db   $06, $00, $80, $a1, $ad, $87, $0f, $00        ;; 0e:7fbf ........
    db   $80, $f1, $31, $87, $00                       ;; 0e:7fc7 .....

data_0e_7fcc:
    db   $02, $f1, $27, $08, $04, $54, $02, $b1        ;; 0e:7fcc ........
    db   $27, $08, $04, $54, $02, $81, $27, $08        ;; 0e:7fd4 ........
    db   $04, $54, $02, $51, $27, $00                  ;; 0e:7fdc ......

data_0e_7fe2:
    db   $50, $77, $80, $0d, $ff, $85                  ;; 0e:7fe2 ??????
