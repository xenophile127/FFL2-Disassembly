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

;@music_pointers amount=19
; Music data table, 3 pointers per music:
; Channel 2, Channel 1, Channel 3
musicSongChannelPointers:
    dw   song00_channel2, song00_channel1, song00_channel3 ;; 0e:49f5 $68 $4a $b9 $4a $e5 $4a
    dw   song01_channel2, song01_channel1, song01_channel3 ;; 0e:49fb $55 $4b $2f $4c $ab $4d
    dw   song02_channel2, song02_channel1, song02_channel3 ;; 0e:4a01 $15 $4e $7a $4e $d6 $4e
    dw   song03_channel2, song03_channel1, song03_channel3 ;; 0e:4a07 $15 $4f $42 $4f $79 $4f
    dw   song04_channel2, song04_channel1, song04_channel3 ;; 0e:4a0d $a9 $4f $0d $50 $34 $51
    dw   song05_channel2, song05_channel1, song05_channel3 ;; 0e:4a13 $61 $53 $94 $53 $ca $53
    dw   song06_channel2, song06_channel1, song06_channel3 ;; 0e:4a19 $ff $53 $37 $54 $a6 $54
    dw   song07_channel2, song07_channel1, song07_channel3 ;; 0e:4a1f $14 $55 $c5 $55 $a8 $56
    dw   song08_channel2, song08_channel1, song08_channel3 ;; 0e:4a25 $0e $57 $79 $57 $26 $58
    dw   song09_channel2, song09_channel1, song09_channel3 ;; 0e:4a2b $e2 $58 $68 $59 $10 $5a
    dw   song0a_channel2, song0a_channel1, song0a_channel3 ;; 0e:4a31 $73 $5a $3a $5b $e9 $5c
    dw   song0b_channel2, song0b_channel1, song0b_channel3 ;; 0e:4a37 $88 $66 $4b $67 $b8 $68
    dw   song0c_channel2, song0c_channel1, song0c_channel3 ;; 0e:4a3d $cd $6e $4d $6f $64 $71
    dw   song0d_channel2, song0d_channel1, song0d_channel3 ;; 0e:4a43 $dd $71 $51 $72 $02 $73
    dw   song0e_channel2, song0e_channel1, song0e_channel3 ;; 0e:4a49 $45 $73 $88 $75 $e3 $77
    dw   song0f_channel2, song0f_channel1, song0f_channel3 ;; 0e:4a4f $48 $51 $bf $51 $80 $52
    dw   song10_channel2, song10_channel1, song10_channel3 ;; 0e:4a55 $4d $5e $a3 $5f $c7 $61
    dw   song11_channel2, song11_channel1, song11_channel3 ;; 0e:4a5b $5c $63 $39 $64 $ac $65
    dw   song12_channel2, song12_channel1, song12_channel3 ;; 0e:4a61 $6e $69 $81 $6c $ac $6d
    db   $ff                                           ;; 0e:4a67 ?

song00_channel2:
    mTEMPO $46                                         ;; 0e:4a68 $e7 $46
    mVIBRATO frequencyDeltaData                        ;; 0e:4a6a $e4 $fe $79
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:4a6d $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:4a70 $e5 $80
    mSTEREOPAN $03                                     ;; 0e:4a72 $e6 $03
    mOCTAVE_2                                          ;; 0e:4a74 $d2
    mE_8                                               ;; 0e:4a75 $84
    mE_8                                               ;; 0e:4a76 $84
    mB_2                                               ;; 0e:4a77 $2b
    mAis_10                                            ;; 0e:4a78 $aa
    mB_10                                              ;; 0e:4a79 $ab
    mCisPlus_8                                         ;; 0e:4a7a $8d
    mB_5                                               ;; 0e:4a7b $5b
    mOCTAVE_PLUS_1                                     ;; 0e:4a7c $d8
    mE_5                                               ;; 0e:4a7d $54
    mCis_8                                             ;; 0e:4a7e $81
    mOCTAVE_MINUS_1                                    ;; 0e:4a7f $dc
    mB_8                                               ;; 0e:4a80 $8b
    mA_5                                               ;; 0e:4a81 $59
    mWait_10                                           ;; 0e:4a82 $ae
    mRest_10                                           ;; 0e:4a83 $af
    mFis_8                                             ;; 0e:4a84 $86
    mGis_8                                             ;; 0e:4a85 $88
    mA_8                                               ;; 0e:4a86 $89
    mB_5                                               ;; 0e:4a87 $5b
    mGis_5                                             ;; 0e:4a88 $58
    mCisPlus_1                                         ;; 0e:4a89 $1d
    mCisPlus_8                                         ;; 0e:4a8a $8d
    mOCTAVE_PLUS_1                                     ;; 0e:4a8b $d8
    mDis_8                                             ;; 0e:4a8c $83
    mE_8                                               ;; 0e:4a8d $84
    mDis_8                                             ;; 0e:4a8e $83
    mE_8                                               ;; 0e:4a8f $84
    mFis_8                                             ;; 0e:4a90 $86
    mDis_5                                             ;; 0e:4a91 $53
    mDis_8                                             ;; 0e:4a92 $83
    mE_8                                               ;; 0e:4a93 $84
    mFis_8                                             ;; 0e:4a94 $86
    mE_8                                               ;; 0e:4a95 $84
    mFis_8                                             ;; 0e:4a96 $86
    mGis_8                                             ;; 0e:4a97 $88
    mE_5                                               ;; 0e:4a98 $54
    mDis_8                                             ;; 0e:4a99 $83
    mE_8                                               ;; 0e:4a9a $84
    mCis_8                                             ;; 0e:4a9b $81
    mOCTAVE_MINUS_1                                    ;; 0e:4a9c $dc
    mB_8                                               ;; 0e:4a9d $8b
    mA_8                                               ;; 0e:4a9e $89
    mB_8                                               ;; 0e:4a9f $8b
    mCisPlus_5                                         ;; 0e:4aa0 $5d
    mOCTAVE_PLUS_1                                     ;; 0e:4aa1 $d8
    mDis_5                                             ;; 0e:4aa2 $53
    mE_5                                               ;; 0e:4aa3 $54
    mDis_5                                             ;; 0e:4aa4 $53
    mE_5                                               ;; 0e:4aa5 $54
    mFis_5                                             ;; 0e:4aa6 $56
    mGis_2                                             ;; 0e:4aa7 $28
    mE_5                                               ;; 0e:4aa8 $54
    mFis_5                                             ;; 0e:4aa9 $56
    mGis_2                                             ;; 0e:4aaa $28
    mE_5                                               ;; 0e:4aab $54
    mFis_5                                             ;; 0e:4aac $56
    mGis_2                                             ;; 0e:4aad $28
    mOCTAVE_MINUS_1                                    ;; 0e:4aae $dc
    mTEMPO $37                                         ;; 0e:4aaf $e7 $37
    mE_5                                               ;; 0e:4ab1 $54
    mTEMPO $34                                         ;; 0e:4ab2 $e7 $34
    mFis_5                                             ;; 0e:4ab4 $56
    mTEMPO $32                                         ;; 0e:4ab5 $e7 $32
    mGis_0                                             ;; 0e:4ab7 $08
    mEND                                               ;; 0e:4ab8 $ff

song00_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:4ab9 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a6f                      ;; 0e:4abc $e0 $6f $7a
    mSTEREOPAN $03                                     ;; 0e:4abf $e6 $03
    mDUTYCYCLE $40                                     ;; 0e:4ac1 $e5 $40
    mOCTAVE_2                                          ;; 0e:4ac3 $d2
    mRest_0                                            ;; 0e:4ac4 $0f
    mRest_0                                            ;; 0e:4ac5 $0f
    mRest_0                                            ;; 0e:4ac6 $0f
    mRest_0                                            ;; 0e:4ac7 $0f
    mCisPlus_8                                         ;; 0e:4ac8 $8d
    mB_8                                               ;; 0e:4ac9 $8b
    mCisPlus_5                                         ;; 0e:4aca $5d
    mB_2                                               ;; 0e:4acb $2b
    mCPlus_2                                           ;; 0e:4acc $2c
    mGis_5                                             ;; 0e:4acd $58
    mFis_5                                             ;; 0e:4ace $56
    mA_8                                               ;; 0e:4acf $89
    mGis_8                                             ;; 0e:4ad0 $88
    mFis_8                                             ;; 0e:4ad1 $86
    mGis_8                                             ;; 0e:4ad2 $88
    mA_5                                               ;; 0e:4ad3 $59
    mB_5                                               ;; 0e:4ad4 $5b
    mA_0                                               ;; 0e:4ad5 $09
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:4ad6 $e0 $31 $7a
    mB_2                                               ;; 0e:4ad9 $2b
    mG_5                                               ;; 0e:4ada $57
    mA_5                                               ;; 0e:4adb $59
    mB_2                                               ;; 0e:4adc $2b
    mG_5                                               ;; 0e:4add $57
    mA_5                                               ;; 0e:4ade $59
    mB_2                                               ;; 0e:4adf $2b
    mOCTAVE_MINUS_1                                    ;; 0e:4ae0 $dc
    mG_5                                               ;; 0e:4ae1 $57
    mA_5                                               ;; 0e:4ae2 $59
    mB_0                                               ;; 0e:4ae3 $0b
    mEND                                               ;; 0e:4ae4 $ff

song00_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:4ae5 $e4 $fe $79
    mWAVETABLE data_0e_7a85                            ;; 0e:4ae8 $e8 $85 $7a
    mVOLUME $40                                        ;; 0e:4aeb $e0 $40
    mSTEREOPAN $03                                     ;; 0e:4aed $e6 $03
    mOCTAVE_2                                          ;; 0e:4aef $d2
    mE_2                                               ;; 0e:4af0 $24
    mDis_2                                             ;; 0e:4af1 $23
    mD_2                                               ;; 0e:4af2 $22
    mA_4                                               ;; 0e:4af3 $49
    mGis_8                                             ;; 0e:4af4 $88
    mFis_2                                             ;; 0e:4af5 $26
    mGis_5                                             ;; 0e:4af6 $58
    mOCTAVE_PLUS_1                                     ;; 0e:4af7 $d8
    mDis_5                                             ;; 0e:4af8 $53
    mCis_5                                             ;; 0e:4af9 $51
    mFis_5                                             ;; 0e:4afa $56
    mE_5                                               ;; 0e:4afb $54
    mOCTAVE_MINUS_1                                    ;; 0e:4afc $dc
    mB_5                                               ;; 0e:4afd $5b
    mA_2                                               ;; 0e:4afe $29
    mB_5                                               ;; 0e:4aff $5b
    mA_5                                               ;; 0e:4b00 $59
    mGis_2                                             ;; 0e:4b01 $28
    mCisPlus_5                                         ;; 0e:4b02 $5d
    mB_5                                               ;; 0e:4b03 $5b
    mFis_0                                             ;; 0e:4b04 $06
    mB_2                                               ;; 0e:4b05 $2b
    mCisPlus_5                                         ;; 0e:4b06 $5d
    mOCTAVE_PLUS_1                                     ;; 0e:4b07 $d8
    mDis_5                                             ;; 0e:4b08 $53
    mOCTAVE_MINUS_1                                    ;; 0e:4b09 $dc
    mSTEREOPAN $02                                     ;; 0e:4b0a $e6 $02
    mE_10                                              ;; 0e:4b0c $a4
    mRest_10                                           ;; 0e:4b0d $af
    mOCTAVE_MINUS_1                                    ;; 0e:4b0e $dc
    mSTEREOPAN $01                                     ;; 0e:4b0f $e6 $01
    mB_10                                              ;; 0e:4b11 $ab
    mRest_10                                           ;; 0e:4b12 $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b13 $d8
    mSTEREOPAN $02                                     ;; 0e:4b14 $e6 $02
    mE_10                                              ;; 0e:4b16 $a4
    mRest_10                                           ;; 0e:4b17 $af
    mOCTAVE_MINUS_1                                    ;; 0e:4b18 $dc
    mSTEREOPAN $01                                     ;; 0e:4b19 $e6 $01
    mB_10                                              ;; 0e:4b1b $ab
    mRest_10                                           ;; 0e:4b1c $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b1d $d8
    mSTEREOPAN $03                                     ;; 0e:4b1e $e6 $03
    mC_5                                               ;; 0e:4b20 $50
    mD_5                                               ;; 0e:4b21 $52
    mSTEREOPAN $02                                     ;; 0e:4b22 $e6 $02
    mE_10                                              ;; 0e:4b24 $a4
    mRest_10                                           ;; 0e:4b25 $af
    mOCTAVE_MINUS_1                                    ;; 0e:4b26 $dc
    mSTEREOPAN $01                                     ;; 0e:4b27 $e6 $01
    mB_10                                              ;; 0e:4b29 $ab
    mRest_10                                           ;; 0e:4b2a $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b2b $d8
    mSTEREOPAN $02                                     ;; 0e:4b2c $e6 $02
    mE_10                                              ;; 0e:4b2e $a4
    mRest_10                                           ;; 0e:4b2f $af
    mOCTAVE_MINUS_1                                    ;; 0e:4b30 $dc
    mSTEREOPAN $01                                     ;; 0e:4b31 $e6 $01
    mB_10                                              ;; 0e:4b33 $ab
    mRest_10                                           ;; 0e:4b34 $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b35 $d8
    mSTEREOPAN $03                                     ;; 0e:4b36 $e6 $03
    mC_5                                               ;; 0e:4b38 $50
    mD_5                                               ;; 0e:4b39 $52
    mSTEREOPAN $02                                     ;; 0e:4b3a $e6 $02
    mE_10                                              ;; 0e:4b3c $a4
    mRest_10                                           ;; 0e:4b3d $af
    mOCTAVE_MINUS_1                                    ;; 0e:4b3e $dc
    mSTEREOPAN $01                                     ;; 0e:4b3f $e6 $01
    mB_10                                              ;; 0e:4b41 $ab
    mRest_10                                           ;; 0e:4b42 $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b43 $d8
    mSTEREOPAN $02                                     ;; 0e:4b44 $e6 $02
    mE_10                                              ;; 0e:4b46 $a4
    mRest_10                                           ;; 0e:4b47 $af
    mOCTAVE_MINUS_1                                    ;; 0e:4b48 $dc
    mSTEREOPAN $01                                     ;; 0e:4b49 $e6 $01
    mB_10                                              ;; 0e:4b4b $ab
    mRest_10                                           ;; 0e:4b4c $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b4d $d8
    mSTEREOPAN $03                                     ;; 0e:4b4e $e6 $03
    mC_5                                               ;; 0e:4b50 $50
    mD_5                                               ;; 0e:4b51 $52
    mE_1                                               ;; 0e:4b52 $14
    mWait_8                                            ;; 0e:4b53 $8e
    mEND                                               ;; 0e:4b54 $ff

song01_channel2:
    mTEMPO $78                                         ;; 0e:4b55 $e7 $78
    mVOLUME_ENVELOPE data_0e_7a3f                      ;; 0e:4b57 $e0 $3f $7a
    mDUTYCYCLE $40                                     ;; 0e:4b5a $e5 $40
    mSTEREOPAN $03                                     ;; 0e:4b5c $e6 $03
    mCOUNTER $02                                       ;; 0e:4b5e $e3 $02
.data_0e_4b60:
    mCOUNTER_2 $02                                     ;; 0e:4b60 $ea $02
.data_0e_4b62:
    mOCTAVE_0                                          ;; 0e:4b62 $d0
    mA_10                                              ;; 0e:4b63 $a9
    mRest_10                                           ;; 0e:4b64 $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b65 $d8
    mE_10                                              ;; 0e:4b66 $a4
    mE_10                                              ;; 0e:4b67 $a4
    mOCTAVE_MINUS_1                                    ;; 0e:4b68 $dc
    mA_10                                              ;; 0e:4b69 $a9
    mRest_10                                           ;; 0e:4b6a $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b6b $d8
    mF_10                                              ;; 0e:4b6c $a5
    mF_10                                              ;; 0e:4b6d $a5
    mOCTAVE_MINUS_1                                    ;; 0e:4b6e $dc
    mA_10                                              ;; 0e:4b6f $a9
    mRest_10                                           ;; 0e:4b70 $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b71 $d8
    mFis_10                                            ;; 0e:4b72 $a6
    mFis_10                                            ;; 0e:4b73 $a6
    mOCTAVE_MINUS_1                                    ;; 0e:4b74 $dc
    mA_10                                              ;; 0e:4b75 $a9
    mRest_10                                           ;; 0e:4b76 $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b77 $d8
    mF_10                                              ;; 0e:4b78 $a5
    mF_10                                              ;; 0e:4b79 $a5
    mREPEAT_2 .data_0e_4b62                            ;; 0e:4b7a $e9 $62 $4b
    mCOUNTER_2 $02                                     ;; 0e:4b7d $ea $02
.data_0e_4b7f:
    mOCTAVE_MINUS_1                                    ;; 0e:4b7f $dc
    mB_10                                              ;; 0e:4b80 $ab
    mRest_10                                           ;; 0e:4b81 $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b82 $d8
    mFis_10                                            ;; 0e:4b83 $a6
    mFis_10                                            ;; 0e:4b84 $a6
    mOCTAVE_MINUS_1                                    ;; 0e:4b85 $dc
    mB_10                                              ;; 0e:4b86 $ab
    mRest_10                                           ;; 0e:4b87 $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b88 $d8
    mG_10                                              ;; 0e:4b89 $a7
    mG_10                                              ;; 0e:4b8a $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4b8b $dc
    mB_10                                              ;; 0e:4b8c $ab
    mRest_10                                           ;; 0e:4b8d $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b8e $d8
    mGis_10                                            ;; 0e:4b8f $a8
    mGis_10                                            ;; 0e:4b90 $a8
    mOCTAVE_MINUS_1                                    ;; 0e:4b91 $dc
    mB_10                                              ;; 0e:4b92 $ab
    mRest_10                                           ;; 0e:4b93 $af
    mOCTAVE_PLUS_1                                     ;; 0e:4b94 $d8
    mG_10                                              ;; 0e:4b95 $a7
    mG_10                                              ;; 0e:4b96 $a7
    mREPEAT_2 .data_0e_4b7f                            ;; 0e:4b97 $e9 $7f $4b
    mREPEAT .data_0e_4b60                              ;; 0e:4b9a $e2 $60 $4b
.data_0e_4b9d:
    mCOUNTER $02                                       ;; 0e:4b9d $e3 $02
.data_0e_4b9f:
    mOCTAVE_MINUS_1                                    ;; 0e:4b9f $dc
    mA_5                                               ;; 0e:4ba0 $59
    mA_5                                               ;; 0e:4ba1 $59
    mA_10                                              ;; 0e:4ba2 $a9
    mRest_10                                           ;; 0e:4ba3 $af
    mE_8                                               ;; 0e:4ba4 $84
    mA_10                                              ;; 0e:4ba5 $a9
    mRest_10                                           ;; 0e:4ba6 $af
    mE_8                                               ;; 0e:4ba7 $84
    mF_5                                               ;; 0e:4ba8 $55
    mF_5                                               ;; 0e:4ba9 $55
    mF_8                                               ;; 0e:4baa $85
    mCPlus_8                                           ;; 0e:4bab $8c
    mA_8                                               ;; 0e:4bac $89
    mF_8                                               ;; 0e:4bad $85
    mG_5                                               ;; 0e:4bae $57
    mG_5                                               ;; 0e:4baf $57
    mG_10                                              ;; 0e:4bb0 $a7
    mRest_10                                           ;; 0e:4bb1 $af
    mD_8                                               ;; 0e:4bb2 $82
    mG_10                                              ;; 0e:4bb3 $a7
    mRest_10                                           ;; 0e:4bb4 $af
    mD_8                                               ;; 0e:4bb5 $82
    mE_5                                               ;; 0e:4bb6 $54
    mE_5                                               ;; 0e:4bb7 $54
    mE_8                                               ;; 0e:4bb8 $84
    mB_5                                               ;; 0e:4bb9 $5b
    mB_8                                               ;; 0e:4bba $8b
    mF_5                                               ;; 0e:4bbb $55
    mF_5                                               ;; 0e:4bbc $55
    mF_8                                               ;; 0e:4bbd $85
    mCPlus_8                                           ;; 0e:4bbe $8c
    mA_8                                               ;; 0e:4bbf $89
    mF_8                                               ;; 0e:4bc0 $85
    mG_5                                               ;; 0e:4bc1 $57
    mG_5                                               ;; 0e:4bc2 $57
    mG_10                                              ;; 0e:4bc3 $a7
    mRest_10                                           ;; 0e:4bc4 $af
    mD_8                                               ;; 0e:4bc5 $82
    mG_10                                              ;; 0e:4bc6 $a7
    mRest_10                                           ;; 0e:4bc7 $af
    mD_8                                               ;; 0e:4bc8 $82
    mE_5                                               ;; 0e:4bc9 $54
    mE_5                                               ;; 0e:4bca $54
    mE_8                                               ;; 0e:4bcb $84
    mB_8                                               ;; 0e:4bcc $8b
    mE_8                                               ;; 0e:4bcd $84
    mB_8                                               ;; 0e:4bce $8b
    mE_5                                               ;; 0e:4bcf $54
    mE_5                                               ;; 0e:4bd0 $54
    mE_8                                               ;; 0e:4bd1 $84
    mB_8                                               ;; 0e:4bd2 $8b
    mGis_8                                             ;; 0e:4bd3 $88
    mA_8                                               ;; 0e:4bd4 $89
    mOCTAVE_PLUS_1                                     ;; 0e:4bd5 $d8
    mREPEAT .data_0e_4b9f                              ;; 0e:4bd6 $e2 $9f $4b
    mOCTAVE_MINUS_1                                    ;; 0e:4bd9 $dc
    mF_5                                               ;; 0e:4bda $55
    mF_5                                               ;; 0e:4bdb $55
    mF_10                                              ;; 0e:4bdc $a5
    mB_10                                              ;; 0e:4bdd $ab
    mCPlus_10                                          ;; 0e:4bde $ac
    mOCTAVE_PLUS_1                                     ;; 0e:4bdf $d8
    mF_10                                              ;; 0e:4be0 $a5
    mOCTAVE_MINUS_1                                    ;; 0e:4be1 $dc
    mF_5                                               ;; 0e:4be2 $55
    mF_5                                               ;; 0e:4be3 $55
    mF_5                                               ;; 0e:4be4 $55
    mF_10                                              ;; 0e:4be5 $a5
    mB_10                                              ;; 0e:4be6 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4be7 $d8
    mD_10                                              ;; 0e:4be8 $a2
    mG_10                                              ;; 0e:4be9 $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4bea $dc
    mF_5                                               ;; 0e:4beb $55
    mE_5                                               ;; 0e:4bec $54
    mE_5                                               ;; 0e:4bed $54
    mE_10                                              ;; 0e:4bee $a4
    mA_10                                              ;; 0e:4bef $a9
    mB_10                                              ;; 0e:4bf0 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4bf1 $d8
    mE_10                                              ;; 0e:4bf2 $a4
    mOCTAVE_MINUS_1                                    ;; 0e:4bf3 $dc
    mE_8                                               ;; 0e:4bf4 $84
    mOCTAVE_PLUS_1                                     ;; 0e:4bf5 $d8
    mE_8                                               ;; 0e:4bf6 $84
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:4bf7 $e0 $55 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:4bfa $dc
    mA_5                                               ;; 0e:4bfb $59
    mOCTAVE_PLUS_1                                     ;; 0e:4bfc $d8
    mA_5                                               ;; 0e:4bfd $59
    mG_5                                               ;; 0e:4bfe $57
    mOCTAVE_MINUS_1                                    ;; 0e:4bff $dc
    mG_8                                               ;; 0e:4c00 $87
    mF_5                                               ;; 0e:4c01 $55
    mVOLUME_ENVELOPE data_0e_7a3f                      ;; 0e:4c02 $e0 $3f $7a
    mF_8                                               ;; 0e:4c05 $85
    mB_8                                               ;; 0e:4c06 $8b
    mCPlus_8                                           ;; 0e:4c07 $8c
    mF_8                                               ;; 0e:4c08 $85
    mF_8                                               ;; 0e:4c09 $85
    mB_8                                               ;; 0e:4c0a $8b
    mCPlus_8                                           ;; 0e:4c0b $8c
    mFis_8                                             ;; 0e:4c0c $86
    mFis_8                                             ;; 0e:4c0d $86
    mA_8                                               ;; 0e:4c0e $89
    mCPlus_8                                           ;; 0e:4c0f $8c
    mFis_8                                             ;; 0e:4c10 $86
    mFis_8                                             ;; 0e:4c11 $86
    mA_8                                               ;; 0e:4c12 $89
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:4c13 $e0 $55 $7a
    mE_5                                               ;; 0e:4c16 $54
    mVOLUME_ENVELOPE data_0e_7a3f                      ;; 0e:4c17 $e0 $3f $7a
    mE_8                                               ;; 0e:4c1a $84
    mA_8                                               ;; 0e:4c1b $89
    mB_8                                               ;; 0e:4c1c $8b
    mE_8                                               ;; 0e:4c1d $84
    mE_8                                               ;; 0e:4c1e $84
    mA_8                                               ;; 0e:4c1f $89
    mB_8                                               ;; 0e:4c20 $8b
    mE_8                                               ;; 0e:4c21 $84
    mE_8                                               ;; 0e:4c22 $84
    mB_8                                               ;; 0e:4c23 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4c24 $d8
    mD_8                                               ;; 0e:4c25 $82
    mOCTAVE_MINUS_1                                    ;; 0e:4c26 $dc
    mE_8                                               ;; 0e:4c27 $84
    mE_8                                               ;; 0e:4c28 $84
    mB_8                                               ;; 0e:4c29 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4c2a $d8
    mD_8                                               ;; 0e:4c2b $82
    mJUMP .data_0e_4b9d                                ;; 0e:4c2c $e1 $9d $4b

song01_channel1:
    mVOLUME_ENVELOPE data_0e_7a43                      ;; 0e:4c2f $e0 $43 $7a
    mDUTYCYCLE $00                                     ;; 0e:4c32 $e5 $00
    mSTEREOPAN $03                                     ;; 0e:4c34 $e6 $03
    mCOUNTER $02                                       ;; 0e:4c36 $e3 $02
.data_0e_4c38:
    mCOUNTER_2 $02                                     ;; 0e:4c38 $ea $02
.data_0e_4c3a:
    mOCTAVE_1                                          ;; 0e:4c3a $d1
    mA_10                                              ;; 0e:4c3b $a9
    mA_10                                              ;; 0e:4c3c $a9
    mA_10                                              ;; 0e:4c3d $a9
    mA_10                                              ;; 0e:4c3e $a9
    mCPlus_10                                          ;; 0e:4c3f $ac
    mA_10                                              ;; 0e:4c40 $a9
    mA_10                                              ;; 0e:4c41 $a9
    mA_10                                              ;; 0e:4c42 $a9
    mOCTAVE_PLUS_1                                     ;; 0e:4c43 $d8
    mD_10                                              ;; 0e:4c44 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:4c45 $dc
    mA_10                                              ;; 0e:4c46 $a9
    mOCTAVE_PLUS_1                                     ;; 0e:4c47 $d8
    mDis_10                                            ;; 0e:4c48 $a3
    mOCTAVE_MINUS_1                                    ;; 0e:4c49 $dc
    mA_10                                              ;; 0e:4c4a $a9
    mOCTAVE_PLUS_1                                     ;; 0e:4c4b $d8
    mD_10                                              ;; 0e:4c4c $a2
    mC_8                                               ;; 0e:4c4d $80
    mC_10                                              ;; 0e:4c4e $a0
    mREPEAT_2 .data_0e_4c3a                            ;; 0e:4c4f $e9 $3a $4c
    mCOUNTER_2 $02                                     ;; 0e:4c52 $ea $02
.data_0e_4c54:
    mOCTAVE_MINUS_1                                    ;; 0e:4c54 $dc
    mB_10                                              ;; 0e:4c55 $ab
    mB_10                                              ;; 0e:4c56 $ab
    mB_10                                              ;; 0e:4c57 $ab
    mB_10                                              ;; 0e:4c58 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4c59 $d8
    mD_10                                              ;; 0e:4c5a $a2
    mOCTAVE_MINUS_1                                    ;; 0e:4c5b $dc
    mB_10                                              ;; 0e:4c5c $ab
    mB_10                                              ;; 0e:4c5d $ab
    mB_10                                              ;; 0e:4c5e $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4c5f $d8
    mE_10                                              ;; 0e:4c60 $a4
    mOCTAVE_MINUS_1                                    ;; 0e:4c61 $dc
    mB_10                                              ;; 0e:4c62 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4c63 $d8
    mF_10                                              ;; 0e:4c64 $a5
    mOCTAVE_MINUS_1                                    ;; 0e:4c65 $dc
    mB_10                                              ;; 0e:4c66 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4c67 $d8
    mE_10                                              ;; 0e:4c68 $a4
    mD_8                                               ;; 0e:4c69 $82
    mD_10                                              ;; 0e:4c6a $a2
    mREPEAT_2 .data_0e_4c54                            ;; 0e:4c6b $e9 $54 $4c
    mREPEAT .data_0e_4c38                              ;; 0e:4c6e $e2 $38 $4c
.data_0e_4c71:
    mCOUNTER $02                                       ;; 0e:4c71 $e3 $02
.data_0e_4c73:
    mSTEREOPAN $02                                     ;; 0e:4c73 $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:4c75 $dc
    mA_10                                              ;; 0e:4c76 $a9
    mA_10                                              ;; 0e:4c77 $a9
    mA_10                                              ;; 0e:4c78 $a9
    mA_10                                              ;; 0e:4c79 $a9
    mCPlus_10                                          ;; 0e:4c7a $ac
    mA_10                                              ;; 0e:4c7b $a9
    mA_10                                              ;; 0e:4c7c $a9
    mA_10                                              ;; 0e:4c7d $a9
    mOCTAVE_PLUS_1                                     ;; 0e:4c7e $d8
    mD_10                                              ;; 0e:4c7f $a2
    mOCTAVE_MINUS_1                                    ;; 0e:4c80 $dc
    mA_10                                              ;; 0e:4c81 $a9
    mOCTAVE_PLUS_1                                     ;; 0e:4c82 $d8
    mE_10                                              ;; 0e:4c83 $a4
    mOCTAVE_MINUS_1                                    ;; 0e:4c84 $dc
    mA_10                                              ;; 0e:4c85 $a9
    mOCTAVE_PLUS_1                                     ;; 0e:4c86 $d8
    mD_10                                              ;; 0e:4c87 $a2
    mC_8                                               ;; 0e:4c88 $80
    mC_10                                              ;; 0e:4c89 $a0
    mSTEREOPAN $01                                     ;; 0e:4c8a $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:4c8c $dc
    mF_10                                              ;; 0e:4c8d $a5
    mF_10                                              ;; 0e:4c8e $a5
    mF_10                                              ;; 0e:4c8f $a5
    mF_10                                              ;; 0e:4c90 $a5
    mA_10                                              ;; 0e:4c91 $a9
    mF_10                                              ;; 0e:4c92 $a5
    mF_10                                              ;; 0e:4c93 $a5
    mF_10                                              ;; 0e:4c94 $a5
    mB_10                                              ;; 0e:4c95 $ab
    mF_10                                              ;; 0e:4c96 $a5
    mCPlus_10                                          ;; 0e:4c97 $ac
    mF_10                                              ;; 0e:4c98 $a5
    mB_10                                              ;; 0e:4c99 $ab
    mA_8                                               ;; 0e:4c9a $89
    mA_10                                              ;; 0e:4c9b $a9
    mSTEREOPAN $02                                     ;; 0e:4c9c $e6 $02
    mG_10                                              ;; 0e:4c9e $a7
    mG_10                                              ;; 0e:4c9f $a7
    mG_10                                              ;; 0e:4ca0 $a7
    mG_10                                              ;; 0e:4ca1 $a7
    mB_10                                              ;; 0e:4ca2 $ab
    mG_10                                              ;; 0e:4ca3 $a7
    mG_10                                              ;; 0e:4ca4 $a7
    mG_10                                              ;; 0e:4ca5 $a7
    mCPlus_10                                          ;; 0e:4ca6 $ac
    mG_10                                              ;; 0e:4ca7 $a7
    mOCTAVE_PLUS_1                                     ;; 0e:4ca8 $d8
    mD_10                                              ;; 0e:4ca9 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:4caa $dc
    mG_10                                              ;; 0e:4cab $a7
    mCPlus_10                                          ;; 0e:4cac $ac
    mB_8                                               ;; 0e:4cad $8b
    mB_10                                              ;; 0e:4cae $ab
    mSTEREOPAN $01                                     ;; 0e:4caf $e6 $01
    mE_10                                              ;; 0e:4cb1 $a4
    mE_10                                              ;; 0e:4cb2 $a4
    mE_10                                              ;; 0e:4cb3 $a4
    mE_10                                              ;; 0e:4cb4 $a4
    mGis_10                                            ;; 0e:4cb5 $a8
    mE_10                                              ;; 0e:4cb6 $a4
    mE_10                                              ;; 0e:4cb7 $a4
    mE_10                                              ;; 0e:4cb8 $a4
    mA_10                                              ;; 0e:4cb9 $a9
    mE_10                                              ;; 0e:4cba $a4
    mB_10                                              ;; 0e:4cbb $ab
    mE_10                                              ;; 0e:4cbc $a4
    mA_10                                              ;; 0e:4cbd $a9
    mGis_8                                             ;; 0e:4cbe $88
    mGis_10                                            ;; 0e:4cbf $a8
    mSTEREOPAN $02                                     ;; 0e:4cc0 $e6 $02
    mF_10                                              ;; 0e:4cc2 $a5
    mF_10                                              ;; 0e:4cc3 $a5
    mF_10                                              ;; 0e:4cc4 $a5
    mF_10                                              ;; 0e:4cc5 $a5
    mA_10                                              ;; 0e:4cc6 $a9
    mF_10                                              ;; 0e:4cc7 $a5
    mF_10                                              ;; 0e:4cc8 $a5
    mF_10                                              ;; 0e:4cc9 $a5
    mB_10                                              ;; 0e:4cca $ab
    mF_10                                              ;; 0e:4ccb $a5
    mCPlus_10                                          ;; 0e:4ccc $ac
    mF_10                                              ;; 0e:4ccd $a5
    mB_10                                              ;; 0e:4cce $ab
    mA_8                                               ;; 0e:4ccf $89
    mA_10                                              ;; 0e:4cd0 $a9
    mSTEREOPAN $01                                     ;; 0e:4cd1 $e6 $01
    mG_10                                              ;; 0e:4cd3 $a7
    mG_10                                              ;; 0e:4cd4 $a7
    mG_10                                              ;; 0e:4cd5 $a7
    mG_10                                              ;; 0e:4cd6 $a7
    mB_10                                              ;; 0e:4cd7 $ab
    mG_10                                              ;; 0e:4cd8 $a7
    mG_10                                              ;; 0e:4cd9 $a7
    mG_10                                              ;; 0e:4cda $a7
    mCPlus_10                                          ;; 0e:4cdb $ac
    mG_10                                              ;; 0e:4cdc $a7
    mOCTAVE_PLUS_1                                     ;; 0e:4cdd $d8
    mD_10                                              ;; 0e:4cde $a2
    mOCTAVE_MINUS_1                                    ;; 0e:4cdf $dc
    mG_10                                              ;; 0e:4ce0 $a7
    mCPlus_10                                          ;; 0e:4ce1 $ac
    mB_8                                               ;; 0e:4ce2 $8b
    mB_10                                              ;; 0e:4ce3 $ab
    mSTEREOPAN $02                                     ;; 0e:4ce4 $e6 $02
    mE_10                                              ;; 0e:4ce6 $a4
    mE_10                                              ;; 0e:4ce7 $a4
    mE_10                                              ;; 0e:4ce8 $a4
    mE_10                                              ;; 0e:4ce9 $a4
    mA_10                                              ;; 0e:4cea $a9
    mE_10                                              ;; 0e:4ceb $a4
    mE_10                                              ;; 0e:4cec $a4
    mE_10                                              ;; 0e:4ced $a4
    mB_10                                              ;; 0e:4cee $ab
    mE_10                                              ;; 0e:4cef $a4
    mCPlus_10                                          ;; 0e:4cf0 $ac
    mE_10                                              ;; 0e:4cf1 $a4
    mB_10                                              ;; 0e:4cf2 $ab
    mA_8                                               ;; 0e:4cf3 $89
    mA_10                                              ;; 0e:4cf4 $a9
    mSTEREOPAN $01                                     ;; 0e:4cf5 $e6 $01
    mE_10                                              ;; 0e:4cf7 $a4
    mE_10                                              ;; 0e:4cf8 $a4
    mE_10                                              ;; 0e:4cf9 $a4
    mE_10                                              ;; 0e:4cfa $a4
    mOCTAVE_PLUS_1                                     ;; 0e:4cfb $d8
    mE_10                                              ;; 0e:4cfc $a4
    mOCTAVE_MINUS_1                                    ;; 0e:4cfd $dc
    mE_10                                              ;; 0e:4cfe $a4
    mE_10                                              ;; 0e:4cff $a4
    mE_10                                              ;; 0e:4d00 $a4
    mOCTAVE_PLUS_1                                     ;; 0e:4d01 $d8
    mD_10                                              ;; 0e:4d02 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:4d03 $dc
    mE_10                                              ;; 0e:4d04 $a4
    mCPlus_10                                          ;; 0e:4d05 $ac
    mE_10                                              ;; 0e:4d06 $a4
    mB_10                                              ;; 0e:4d07 $ab
    mA_10                                              ;; 0e:4d08 $a9
    mGis_10                                            ;; 0e:4d09 $a8
    mB_10                                              ;; 0e:4d0a $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4d0b $d8
    mREPEAT .data_0e_4c73                              ;; 0e:4d0c $e2 $73 $4c
    mSTEREOPAN $02                                     ;; 0e:4d0f $e6 $02
    mC_8                                               ;; 0e:4d11 $80
    mE_10                                              ;; 0e:4d12 $a4
    mF_10                                              ;; 0e:4d13 $a5
    mC_8                                               ;; 0e:4d14 $80
    mE_10                                              ;; 0e:4d15 $a4
    mF_10                                              ;; 0e:4d16 $a5
    mC_8                                               ;; 0e:4d17 $80
    mE_10                                              ;; 0e:4d18 $a4
    mF_10                                              ;; 0e:4d19 $a5
    mC_8                                               ;; 0e:4d1a $80
    mE_10                                              ;; 0e:4d1b $a4
    mF_10                                              ;; 0e:4d1c $a5
    mSTEREOPAN $01                                     ;; 0e:4d1d $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:4d1f $dc
    mB_8                                               ;; 0e:4d20 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4d21 $d8
    mD_10                                              ;; 0e:4d22 $a2
    mG_10                                              ;; 0e:4d23 $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4d24 $dc
    mB_8                                               ;; 0e:4d25 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4d26 $d8
    mD_10                                              ;; 0e:4d27 $a2
    mG_10                                              ;; 0e:4d28 $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4d29 $dc
    mB_8                                               ;; 0e:4d2a $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4d2b $d8
    mD_10                                              ;; 0e:4d2c $a2
    mG_10                                              ;; 0e:4d2d $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4d2e $dc
    mB_8                                               ;; 0e:4d2f $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4d30 $d8
    mD_10                                              ;; 0e:4d31 $a2
    mG_10                                              ;; 0e:4d32 $a7
    mSTEREOPAN $02                                     ;; 0e:4d33 $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:4d35 $dc
    mB_8                                               ;; 0e:4d36 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4d37 $d8
    mD_10                                              ;; 0e:4d38 $a2
    mG_10                                              ;; 0e:4d39 $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4d3a $dc
    mB_8                                               ;; 0e:4d3b $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4d3c $d8
    mD_10                                              ;; 0e:4d3d $a2
    mG_10                                              ;; 0e:4d3e $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4d3f $dc
    mB_8                                               ;; 0e:4d40 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4d41 $d8
    mD_10                                              ;; 0e:4d42 $a2
    mG_10                                              ;; 0e:4d43 $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4d44 $dc
    mB_8                                               ;; 0e:4d45 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4d46 $d8
    mD_10                                              ;; 0e:4d47 $a2
    mG_10                                              ;; 0e:4d48 $a7
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:4d49 $e0 $57 $7a
    mSTEREOPAN $03                                     ;; 0e:4d4c $e6 $03
    mA_8                                               ;; 0e:4d4e $89
    mE_8                                               ;; 0e:4d4f $84
    mC_8                                               ;; 0e:4d50 $80
    mA_8                                               ;; 0e:4d51 $89
    mG_8                                               ;; 0e:4d52 $87
    mD_8                                               ;; 0e:4d53 $82
    mOCTAVE_MINUS_1                                    ;; 0e:4d54 $dc
    mB_8                                               ;; 0e:4d55 $8b
    mSTEREOPAN $02                                     ;; 0e:4d56 $e6 $02
    mCPlus_5                                           ;; 0e:4d58 $5c
    mVOLUME_ENVELOPE data_0e_7a43                      ;; 0e:4d59 $e0 $43 $7a
    mCPlus_10                                          ;; 0e:4d5c $ac
    mCPlus_10                                          ;; 0e:4d5d $ac
    mOCTAVE_PLUS_1                                     ;; 0e:4d5e $d8
    mF_8                                               ;; 0e:4d5f $85
    mF_10                                              ;; 0e:4d60 $a5
    mF_10                                              ;; 0e:4d61 $a5
    mE_8                                               ;; 0e:4d62 $84
    mE_10                                              ;; 0e:4d63 $a4
    mE_10                                              ;; 0e:4d64 $a4
    mD_8                                               ;; 0e:4d65 $82
    mC_10                                              ;; 0e:4d66 $a0
    mC_10                                              ;; 0e:4d67 $a0
    mSTEREOPAN $01                                     ;; 0e:4d68 $e6 $01
    mC_8                                               ;; 0e:4d6a $80
    mC_10                                              ;; 0e:4d6b $a0
    mC_10                                              ;; 0e:4d6c $a0
    mE_8                                               ;; 0e:4d6d $84
    mE_10                                              ;; 0e:4d6e $a4
    mE_10                                              ;; 0e:4d6f $a4
    mD_8                                               ;; 0e:4d70 $82
    mD_10                                              ;; 0e:4d71 $a2
    mD_10                                              ;; 0e:4d72 $a2
    mC_8                                               ;; 0e:4d73 $80
    mC_10                                              ;; 0e:4d74 $a0
    mC_10                                              ;; 0e:4d75 $a0
    mSTEREOPAN $03                                     ;; 0e:4d76 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:4d78 $dc
    mB_10                                              ;; 0e:4d79 $ab
    mB_10                                              ;; 0e:4d7a $ab
    mB_10                                              ;; 0e:4d7b $ab
    mB_10                                              ;; 0e:4d7c $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4d7d $d8
    mD_10                                              ;; 0e:4d7e $a2
    mOCTAVE_MINUS_1                                    ;; 0e:4d7f $dc
    mB_10                                              ;; 0e:4d80 $ab
    mB_10                                              ;; 0e:4d81 $ab
    mB_10                                              ;; 0e:4d82 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4d83 $d8
    mE_10                                              ;; 0e:4d84 $a4
    mOCTAVE_MINUS_1                                    ;; 0e:4d85 $dc
    mB_10                                              ;; 0e:4d86 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4d87 $d8
    mF_10                                              ;; 0e:4d88 $a5
    mOCTAVE_MINUS_1                                    ;; 0e:4d89 $dc
    mB_10                                              ;; 0e:4d8a $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4d8b $d8
    mE_10                                              ;; 0e:4d8c $a4
    mD_8                                               ;; 0e:4d8d $82
    mD_10                                              ;; 0e:4d8e $a2
    mSTEREOPAN $02                                     ;; 0e:4d8f $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:4d91 $dc
    mE_10                                              ;; 0e:4d92 $a4
    mE_10                                              ;; 0e:4d93 $a4
    mE_10                                              ;; 0e:4d94 $a4
    mE_10                                              ;; 0e:4d95 $a4
    mSTEREOPAN $03                                     ;; 0e:4d96 $e6 $03
    mGis_10                                            ;; 0e:4d98 $a8
    mE_10                                              ;; 0e:4d99 $a4
    mE_10                                              ;; 0e:4d9a $a4
    mE_10                                              ;; 0e:4d9b $a4
    mSTEREOPAN $01                                     ;; 0e:4d9c $e6 $01
    mA_10                                              ;; 0e:4d9e $a9
    mE_10                                              ;; 0e:4d9f $a4
    mB_10                                              ;; 0e:4da0 $ab
    mE_10                                              ;; 0e:4da1 $a4
    mSTEREOPAN $03                                     ;; 0e:4da2 $e6 $03
    mA_10                                              ;; 0e:4da4 $a9
    mGis_8                                             ;; 0e:4da5 $88
    mGis_10                                            ;; 0e:4da6 $a8
    mOCTAVE_PLUS_1                                     ;; 0e:4da7 $d8
    mJUMP .data_0e_4c71                                ;; 0e:4da8 $e1 $71 $4c

song01_channel3:
    mVIBRATO frequencyDeltaData.fourth                 ;; 0e:4dab $e4 $1b $7a
    mWAVETABLE data_0e_7ab5                            ;; 0e:4dae $e8 $b5 $7a
    mVOLUME $20                                        ;; 0e:4db1 $e0 $20
    mSTEREOPAN $03                                     ;; 0e:4db3 $e6 $03
    mRest_0                                            ;; 0e:4db5 $0f
    mRest_0                                            ;; 0e:4db6 $0f
    mRest_0                                            ;; 0e:4db7 $0f
    mRest_0                                            ;; 0e:4db8 $0f
    mRest_0                                            ;; 0e:4db9 $0f
    mRest_0                                            ;; 0e:4dba $0f
    mRest_0                                            ;; 0e:4dbb $0f
    mRest_0                                            ;; 0e:4dbc $0f
.data_0e_4dbd:
    mCOUNTER $02                                       ;; 0e:4dbd $e3 $02
.data_0e_4dbf:
    mOCTAVE_4                                          ;; 0e:4dbf $d4
    mE_2                                               ;; 0e:4dc0 $24
    mWait_8                                            ;; 0e:4dc1 $8e
    mOCTAVE_MINUS_1                                    ;; 0e:4dc2 $dc
    mA_8                                               ;; 0e:4dc3 $89
    mCPlus_8                                           ;; 0e:4dc4 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:4dc5 $d8
    mE_8                                               ;; 0e:4dc6 $84
    mF_7                                               ;; 0e:4dc7 $75
    mWait_12                                           ;; 0e:4dc8 $ce
    mRest_12                                           ;; 0e:4dc9 $cf
    mF_8                                               ;; 0e:4dca $85
    mE_5                                               ;; 0e:4dcb $54
    mD_8                                               ;; 0e:4dcc $82
    mC_5                                               ;; 0e:4dcd $50
    mD_2                                               ;; 0e:4dce $22
    mWait_8                                            ;; 0e:4dcf $8e
    mOCTAVE_MINUS_1                                    ;; 0e:4dd0 $dc
    mG_8                                               ;; 0e:4dd1 $87
    mB_8                                               ;; 0e:4dd2 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:4dd3 $d8
    mD_8                                               ;; 0e:4dd4 $82
    mE_7                                               ;; 0e:4dd5 $74
    mWait_12                                           ;; 0e:4dd6 $ce
    mRest_12                                           ;; 0e:4dd7 $cf
    mE_8                                               ;; 0e:4dd8 $84
    mD_4                                               ;; 0e:4dd9 $42
    mE_5                                               ;; 0e:4dda $54
    mC_2                                               ;; 0e:4ddb $20
    mWait_8                                            ;; 0e:4ddc $8e
    mOCTAVE_MINUS_1                                    ;; 0e:4ddd $dc
    mF_8                                               ;; 0e:4dde $85
    mA_8                                               ;; 0e:4ddf $89
    mCPlus_8                                           ;; 0e:4de0 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:4de1 $d8
    mD_7                                               ;; 0e:4de2 $72
    mWait_12                                           ;; 0e:4de3 $ce
    mRest_12                                           ;; 0e:4de4 $cf
    mD_8                                               ;; 0e:4de5 $82
    mC_4                                               ;; 0e:4de6 $40
    mD_5                                               ;; 0e:4de7 $52
    mOCTAVE_MINUS_1                                    ;; 0e:4de8 $dc
    mB_0                                               ;; 0e:4de9 $0b
    mWait_5                                            ;; 0e:4dea $5e
    mRest_1                                            ;; 0e:4deb $1f
    mREPEAT .data_0e_4dbf                              ;; 0e:4dec $e2 $bf $4d
    mCPlus_4                                           ;; 0e:4def $4c
    mA_4                                               ;; 0e:4df0 $49
    mCPlus_5                                           ;; 0e:4df1 $5c
    mOCTAVE_PLUS_1                                     ;; 0e:4df2 $d8
    mD_4                                               ;; 0e:4df3 $42
    mOCTAVE_MINUS_1                                    ;; 0e:4df4 $dc
    mB_2                                               ;; 0e:4df5 $2b
    mWait_8                                            ;; 0e:4df6 $8e
    mOCTAVE_PLUS_1                                     ;; 0e:4df7 $d8
    mD_4                                               ;; 0e:4df8 $42
    mOCTAVE_MINUS_1                                    ;; 0e:4df9 $dc
    mB_4                                               ;; 0e:4dfa $4b
    mOCTAVE_PLUS_1                                     ;; 0e:4dfb $d8
    mD_5                                               ;; 0e:4dfc $52
    mE_5                                               ;; 0e:4dfd $54
    mF_8                                               ;; 0e:4dfe $85
    mE_8                                               ;; 0e:4dff $84
    mD_8                                               ;; 0e:4e00 $82
    mE_8                                               ;; 0e:4e01 $84
    mD_8                                               ;; 0e:4e02 $82
    mC_0                                               ;; 0e:4e03 $00
    mOCTAVE_MINUS_1                                    ;; 0e:4e04 $dc
    mB_10                                              ;; 0e:4e05 $ab
    mCPlus_10                                          ;; 0e:4e06 $ac
    mOCTAVE_PLUS_1                                     ;; 0e:4e07 $d8
    mD_5                                               ;; 0e:4e08 $52
    mC_5                                               ;; 0e:4e09 $50
    mOCTAVE_MINUS_1                                    ;; 0e:4e0a $dc
    mB_8                                               ;; 0e:4e0b $8b
    mA_8                                               ;; 0e:4e0c $89
    mCPlus_8                                           ;; 0e:4e0d $8c
    mB_0                                               ;; 0e:4e0e $0b
    mWait_8                                            ;; 0e:4e0f $8e
    mWait_5                                            ;; 0e:4e10 $5e
    mRest_1                                            ;; 0e:4e11 $1f
    mJUMP .data_0e_4dbd                                ;; 0e:4e12 $e1 $bd $4d

song02_channel2:
    mTEMPO $7d                                         ;; 0e:4e15 $e7 $7d
    mVIBRATO frequencyDeltaData                        ;; 0e:4e17 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:4e1a $e0 $55 $7a
    mDUTYCYCLE $40                                     ;; 0e:4e1d $e5 $40
    mSTEREOPAN $03                                     ;; 0e:4e1f $e6 $03
    mOCTAVE_3                                          ;; 0e:4e21 $d3
    mG_11                                              ;; 0e:4e22 $b7
    mGis_11                                            ;; 0e:4e23 $b8
    mA_11                                              ;; 0e:4e24 $b9
    mTEMPO $78                                         ;; 0e:4e25 $e7 $78
    mAis_5                                             ;; 0e:4e27 $5a
    mTEMPO $73                                         ;; 0e:4e28 $e7 $73
    mVOLUME_ENVELOPE data_0e_7a3f                      ;; 0e:4e2a $e0 $3f $7a
    mAis_9                                             ;; 0e:4e2d $9a
    mAis_9                                             ;; 0e:4e2e $9a
    mAis_9                                             ;; 0e:4e2f $9a
    mTEMPO $6e                                         ;; 0e:4e30 $e7 $6e
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:4e32 $e0 $55 $7a
    mA_8                                               ;; 0e:4e35 $89
    mG_8                                               ;; 0e:4e36 $87
    mTEMPO $69                                         ;; 0e:4e37 $e7 $69
    mF_8                                               ;; 0e:4e39 $85
    mA_8                                               ;; 0e:4e3a $89
    mVOLUME_ENVELOPE data_0e_7a6b                      ;; 0e:4e3b $e0 $6b $7a
    mG_1                                               ;; 0e:4e3e $17
    mTEMPO $7d                                         ;; 0e:4e3f $e7 $7d
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:4e41 $e0 $55 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:4e44 $dc
    mFis_11                                            ;; 0e:4e45 $b6
    mG_11                                              ;; 0e:4e46 $b7
    mA_11                                              ;; 0e:4e47 $b9
    mB_11                                              ;; 0e:4e48 $bb
    mOCTAVE_PLUS_1                                     ;; 0e:4e49 $d8
    mC_11                                              ;; 0e:4e4a $b0
    mD_11                                              ;; 0e:4e4b $b2
.data_0e_4e4c:
    mE_5                                               ;; 0e:4e4c $54
    mE_5                                               ;; 0e:4e4d $54
    mD_8                                               ;; 0e:4e4e $82
    mE_5                                               ;; 0e:4e4f $54
    mE_8                                               ;; 0e:4e50 $84
    mD_8                                               ;; 0e:4e51 $82
    mE_5                                               ;; 0e:4e52 $54
    mF_8                                               ;; 0e:4e53 $85
    mE_5                                               ;; 0e:4e54 $54
    mD_5                                               ;; 0e:4e55 $52
    mE_5                                               ;; 0e:4e56 $54
    mE_5                                               ;; 0e:4e57 $54
    mD_8                                               ;; 0e:4e58 $82
    mE_5                                               ;; 0e:4e59 $54
    mE_8                                               ;; 0e:4e5a $84
    mD_8                                               ;; 0e:4e5b $82
    mE_5                                               ;; 0e:4e5c $54
    mF_8                                               ;; 0e:4e5d $85
    mE_5                                               ;; 0e:4e5e $54
    mD_5                                               ;; 0e:4e5f $52
    mG_8                                               ;; 0e:4e60 $87
    mF_8                                               ;; 0e:4e61 $85
    mDis_8                                             ;; 0e:4e62 $83
    mF_5                                               ;; 0e:4e63 $55
    mF_8                                               ;; 0e:4e64 $85
    mDis_8                                             ;; 0e:4e65 $83
    mF_8                                               ;; 0e:4e66 $85
    mG_5                                               ;; 0e:4e67 $57
    mF_5                                               ;; 0e:4e68 $55
    mDis_5                                             ;; 0e:4e69 $53
    mF_5                                               ;; 0e:4e6a $55
    mG_8                                               ;; 0e:4e6b $87
    mF_8                                               ;; 0e:4e6c $85
    mDis_8                                             ;; 0e:4e6d $83
    mF_5                                               ;; 0e:4e6e $55
    mF_8                                               ;; 0e:4e6f $85
    mDis_8                                             ;; 0e:4e70 $83
    mF_8                                               ;; 0e:4e71 $85
    mG_5                                               ;; 0e:4e72 $57
    mF_5                                               ;; 0e:4e73 $55
    mDis_8                                             ;; 0e:4e74 $83
    mF_5                                               ;; 0e:4e75 $55
    mF_8                                               ;; 0e:4e76 $85
    mJUMP .data_0e_4e4c                                ;; 0e:4e77 $e1 $4c $4e

song02_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:4e7a $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:4e7d $e0 $57 $7a
    mDUTYCYCLE $40                                     ;; 0e:4e80 $e5 $40
    mSTEREOPAN $03                                     ;; 0e:4e82 $e6 $03
    mOCTAVE_3                                          ;; 0e:4e84 $d3
    mE_11                                              ;; 0e:4e85 $b4
    mF_11                                              ;; 0e:4e86 $b5
    mFis_11                                            ;; 0e:4e87 $b6
    mG_5                                               ;; 0e:4e88 $57
    mVOLUME_ENVELOPE data_0e_7a43                      ;; 0e:4e89 $e0 $43 $7a
    mG_9                                               ;; 0e:4e8c $97
    mF_9                                               ;; 0e:4e8d $95
    mDis_9                                             ;; 0e:4e8e $93
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:4e8f $e0 $57 $7a
    mC_5                                               ;; 0e:4e92 $50
    mOCTAVE_MINUS_1                                    ;; 0e:4e93 $dc
    mA_5                                               ;; 0e:4e94 $59
    mVOLUME_ENVELOPE data_0e_7a6d                      ;; 0e:4e95 $e0 $6d $7a
    mB_1                                               ;; 0e:4e98 $1b
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:4e99 $e0 $57 $7a
    mD_11                                              ;; 0e:4e9c $b2
    mE_11                                              ;; 0e:4e9d $b4
    mFis_11                                            ;; 0e:4e9e $b6
    mG_11                                              ;; 0e:4e9f $b7
    mA_11                                              ;; 0e:4ea0 $b9
    mB_11                                              ;; 0e:4ea1 $bb
.data_0e_4ea2:
    mCPlus_5                                           ;; 0e:4ea2 $5c
    mCPlus_5                                           ;; 0e:4ea3 $5c
    mB_8                                               ;; 0e:4ea4 $8b
    mCPlus_5                                           ;; 0e:4ea5 $5c
    mCPlus_8                                           ;; 0e:4ea6 $8c
    mB_8                                               ;; 0e:4ea7 $8b
    mCPlus_5                                           ;; 0e:4ea8 $5c
    mOCTAVE_PLUS_1                                     ;; 0e:4ea9 $d8
    mD_8                                               ;; 0e:4eaa $82
    mC_5                                               ;; 0e:4eab $50
    mOCTAVE_MINUS_1                                    ;; 0e:4eac $dc
    mB_5                                               ;; 0e:4ead $5b
    mCPlus_5                                           ;; 0e:4eae $5c
    mCPlus_5                                           ;; 0e:4eaf $5c
    mB_8                                               ;; 0e:4eb0 $8b
    mCPlus_5                                           ;; 0e:4eb1 $5c
    mCPlus_8                                           ;; 0e:4eb2 $8c
    mB_8                                               ;; 0e:4eb3 $8b
    mCPlus_5                                           ;; 0e:4eb4 $5c
    mOCTAVE_PLUS_1                                     ;; 0e:4eb5 $d8
    mD_8                                               ;; 0e:4eb6 $82
    mC_5                                               ;; 0e:4eb7 $50
    mOCTAVE_MINUS_1                                    ;; 0e:4eb8 $dc
    mB_5                                               ;; 0e:4eb9 $5b
    mOCTAVE_PLUS_1                                     ;; 0e:4eba $d8
    mDis_8                                             ;; 0e:4ebb $83
    mCis_8                                             ;; 0e:4ebc $81
    mC_8                                               ;; 0e:4ebd $80
    mCis_5                                             ;; 0e:4ebe $51
    mCis_8                                             ;; 0e:4ebf $81
    mC_8                                               ;; 0e:4ec0 $80
    mCis_8                                             ;; 0e:4ec1 $81
    mDis_5                                             ;; 0e:4ec2 $53
    mCis_5                                             ;; 0e:4ec3 $51
    mC_5                                               ;; 0e:4ec4 $50
    mCis_5                                             ;; 0e:4ec5 $51
    mDis_8                                             ;; 0e:4ec6 $83
    mCis_8                                             ;; 0e:4ec7 $81
    mC_8                                               ;; 0e:4ec8 $80
    mCis_5                                             ;; 0e:4ec9 $51
    mCis_8                                             ;; 0e:4eca $81
    mC_8                                               ;; 0e:4ecb $80
    mCis_8                                             ;; 0e:4ecc $81
    mDis_5                                             ;; 0e:4ecd $53
    mCis_5                                             ;; 0e:4ece $51
    mC_8                                               ;; 0e:4ecf $80
    mCis_5                                             ;; 0e:4ed0 $51
    mOCTAVE_MINUS_1                                    ;; 0e:4ed1 $dc
    mCis_8                                             ;; 0e:4ed2 $81
    mJUMP .data_0e_4ea2                                ;; 0e:4ed3 $e1 $a2 $4e

song02_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:4ed6 $e4 $fe $79
    mWAVETABLE data_0e_7aa5                            ;; 0e:4ed9 $e8 $a5 $7a
    mVOLUME $20                                        ;; 0e:4edc $e0 $20
    mSTEREOPAN $03                                     ;; 0e:4ede $e6 $03
    mOCTAVE_2                                          ;; 0e:4ee0 $d2
    mRest_8                                            ;; 0e:4ee1 $8f
    mDis_5                                             ;; 0e:4ee2 $53
    mOCTAVE_PLUS_1                                     ;; 0e:4ee3 $d8
    mDis_9                                             ;; 0e:4ee4 $93
    mOCTAVE_MINUS_1                                    ;; 0e:4ee5 $dc
    mAis_9                                             ;; 0e:4ee6 $9a
    mG_9                                               ;; 0e:4ee7 $97
    mF_5                                               ;; 0e:4ee8 $55
    mOCTAVE_MINUS_1                                    ;; 0e:4ee9 $dc
    mF_5                                               ;; 0e:4eea $55
    mG_1                                               ;; 0e:4eeb $17
    mRest_5                                            ;; 0e:4eec $5f
    mOCTAVE_PLUS_1                                     ;; 0e:4eed $d8
.data_0e_4eee:
    mCOUNTER $08                                       ;; 0e:4eee $e3 $08
.data_0e_4ef0:
    mSTEREOPAN $03                                     ;; 0e:4ef0 $e6 $03
    mC_8                                               ;; 0e:4ef2 $80
    mSTEREOPAN $01                                     ;; 0e:4ef3 $e6 $01
    mB_10                                              ;; 0e:4ef5 $ab
    mCPlus_10                                          ;; 0e:4ef6 $ac
    mSTEREOPAN $03                                     ;; 0e:4ef7 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:4ef9 $dc
    mG_8                                               ;; 0e:4efa $87
    mSTEREOPAN $02                                     ;; 0e:4efb $e6 $02
    mOCTAVE_PLUS_1                                     ;; 0e:4efd $d8
    mB_10                                              ;; 0e:4efe $ab
    mOCTAVE_PLUS_1                                     ;; 0e:4eff $d8
    mD_10                                              ;; 0e:4f00 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:4f01 $dc
    mREPEAT .data_0e_4ef0                              ;; 0e:4f02 $e2 $f0 $4e
    mCOUNTER $08                                       ;; 0e:4f05 $e3 $08
.data_0e_4f07:
    mSTEREOPAN $03                                     ;; 0e:4f07 $e6 $03
    mCis_8                                             ;; 0e:4f09 $81
    mCisPlus_10                                        ;; 0e:4f0a $ad
    mRest_10                                           ;; 0e:4f0b $af
    mG_10                                              ;; 0e:4f0c $a7
    mGis_10                                            ;; 0e:4f0d $a8
    mCisPlus_8                                         ;; 0e:4f0e $8d
    mREPEAT .data_0e_4f07                              ;; 0e:4f0f $e2 $07 $4f
    mJUMP .data_0e_4eee                                ;; 0e:4f12 $e1 $ee $4e

song03_channel2:
    mTEMPO $96                                         ;; 0e:4f15 $e7 $96
    mVIBRATO frequencyDeltaData                        ;; 0e:4f17 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:4f1a $e0 $53 $7a
    mDUTYCYCLE $40                                     ;; 0e:4f1d $e5 $40
    mSTEREOPAN $03                                     ;; 0e:4f1f $e6 $03
.data_0e_4f21:
    mCOUNTER $04                                       ;; 0e:4f21 $e3 $04
.data_0e_4f23:
    mOCTAVE_3                                          ;; 0e:4f23 $d3
    mB_10                                              ;; 0e:4f24 $ab
    mCPlus_10                                          ;; 0e:4f25 $ac
    mFis_10                                            ;; 0e:4f26 $a6
    mG_10                                              ;; 0e:4f27 $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4f28 $dc
    mB_10                                              ;; 0e:4f29 $ab
    mCPlus_10                                          ;; 0e:4f2a $ac
    mFis_10                                            ;; 0e:4f2b $a6
    mG_10                                              ;; 0e:4f2c $a7
    mREPEAT .data_0e_4f23                              ;; 0e:4f2d $e2 $23 $4f
    mCOUNTER $04                                       ;; 0e:4f30 $e3 $04
.data_0e_4f32:
    mF_10                                              ;; 0e:4f32 $a5
    mE_10                                              ;; 0e:4f33 $a4
    mAis_10                                            ;; 0e:4f34 $aa
    mA_10                                              ;; 0e:4f35 $a9
    mOCTAVE_PLUS_1                                     ;; 0e:4f36 $d8
    mDis_10                                            ;; 0e:4f37 $a3
    mD_10                                              ;; 0e:4f38 $a2
    mGis_10                                            ;; 0e:4f39 $a8
    mG_10                                              ;; 0e:4f3a $a7
    mOCTAVE_MINUS_1                                    ;; 0e:4f3b $dc
    mREPEAT .data_0e_4f32                              ;; 0e:4f3c $e2 $32 $4f
    mJUMP .data_0e_4f21                                ;; 0e:4f3f $e1 $21 $4f

song03_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:4f42 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:4f45 $e0 $57 $7a
    mDUTYCYCLE $40                                     ;; 0e:4f48 $e5 $40
.data_0e_4f4a:
    mCOUNTER $04                                       ;; 0e:4f4a $e3 $04
.data_0e_4f4c:
    mSTEREOPAN $02                                     ;; 0e:4f4c $e6 $02
    mOCTAVE_1                                          ;; 0e:4f4e $d1
    mC_10                                              ;; 0e:4f4f $a0
    mRest_10                                           ;; 0e:4f50 $af
    mSTEREOPAN $03                                     ;; 0e:4f51 $e6 $03
    mC_10                                              ;; 0e:4f53 $a0
    mRest_10                                           ;; 0e:4f54 $af
    mSTEREOPAN $01                                     ;; 0e:4f55 $e6 $01
    mC_10                                              ;; 0e:4f57 $a0
    mRest_10                                           ;; 0e:4f58 $af
    mSTEREOPAN $03                                     ;; 0e:4f59 $e6 $03
    mC_10                                              ;; 0e:4f5b $a0
    mRest_10                                           ;; 0e:4f5c $af
    mREPEAT .data_0e_4f4c                              ;; 0e:4f5d $e2 $4c $4f
    mOCTAVE_MINUS_1                                    ;; 0e:4f60 $dc
    mCOUNTER $04                                       ;; 0e:4f61 $e3 $04
.data_0e_4f63:
    mSTEREOPAN $01                                     ;; 0e:4f63 $e6 $01
    mAis_10                                            ;; 0e:4f65 $aa
    mRest_10                                           ;; 0e:4f66 $af
    mSTEREOPAN $03                                     ;; 0e:4f67 $e6 $03
    mAis_10                                            ;; 0e:4f69 $aa
    mRest_10                                           ;; 0e:4f6a $af
    mSTEREOPAN $02                                     ;; 0e:4f6b $e6 $02
    mAis_10                                            ;; 0e:4f6d $aa
    mRest_10                                           ;; 0e:4f6e $af
    mSTEREOPAN $03                                     ;; 0e:4f6f $e6 $03
    mAis_10                                            ;; 0e:4f71 $aa
    mRest_10                                           ;; 0e:4f72 $af
    mREPEAT .data_0e_4f63                              ;; 0e:4f73 $e2 $63 $4f
    mJUMP .data_0e_4f4a                                ;; 0e:4f76 $e1 $4a $4f

song03_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:4f79 $e4 $fe $79
    mWAVETABLE data_0e_7a85                            ;; 0e:4f7c $e8 $85 $7a
    mVOLUME $40                                        ;; 0e:4f7f $e0 $40
    mSTEREOPAN $03                                     ;; 0e:4f81 $e6 $03
.data_0e_4f83:
    mCOUNTER $04                                       ;; 0e:4f83 $e3 $04
.data_0e_4f85:
    mOCTAVE_2                                          ;; 0e:4f85 $d2
    mC_10                                              ;; 0e:4f86 $a0
    mCPlus_10                                          ;; 0e:4f87 $ac
    mDis_10                                            ;; 0e:4f88 $a3
    mOCTAVE_PLUS_1                                     ;; 0e:4f89 $d8
    mDis_10                                            ;; 0e:4f8a $a3
    mOCTAVE_MINUS_1                                    ;; 0e:4f8b $dc
    mFis_10                                            ;; 0e:4f8c $a6
    mOCTAVE_PLUS_1                                     ;; 0e:4f8d $d8
    mFis_10                                            ;; 0e:4f8e $a6
    mOCTAVE_MINUS_1                                    ;; 0e:4f8f $dc
    mDis_10                                            ;; 0e:4f90 $a3
    mOCTAVE_PLUS_1                                     ;; 0e:4f91 $d8
    mDis_10                                            ;; 0e:4f92 $a3
    mREPEAT .data_0e_4f85                              ;; 0e:4f93 $e2 $85 $4f
    mCOUNTER $04                                       ;; 0e:4f96 $e3 $04
.data_0e_4f98:
    mOCTAVE_MINUS_2                                    ;; 0e:4f98 $dd
    mAis_10                                            ;; 0e:4f99 $aa
    mOCTAVE_PLUS_1                                     ;; 0e:4f9a $d8
    mAis_10                                            ;; 0e:4f9b $aa
    mCis_10                                            ;; 0e:4f9c $a1
    mCisPlus_10                                        ;; 0e:4f9d $ad
    mC_10                                              ;; 0e:4f9e $a0
    mCPlus_10                                          ;; 0e:4f9f $ac
    mDis_10                                            ;; 0e:4fa0 $a3
    mOCTAVE_PLUS_1                                     ;; 0e:4fa1 $d8
    mDis_10                                            ;; 0e:4fa2 $a3
    mREPEAT .data_0e_4f98                              ;; 0e:4fa3 $e2 $98 $4f
    mJUMP .data_0e_4f83                                ;; 0e:4fa6 $e1 $83 $4f

song04_channel2:
    mTEMPO $4b                                         ;; 0e:4fa9 $e7 $4b
    mVIBRATO frequencyDeltaData                        ;; 0e:4fab $e4 $fe $79
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:4fae $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:4fb1 $e5 $80
    mSTEREOPAN $02                                     ;; 0e:4fb3 $e6 $02
    mOCTAVE_1                                          ;; 0e:4fb5 $d1
    mOCTAVE_PLUS_1                                     ;; 0e:4fb6 $d8
    mD_8                                               ;; 0e:4fb7 $82
    mD_8                                               ;; 0e:4fb8 $82
    mA_2                                               ;; 0e:4fb9 $29
    mGis_10                                            ;; 0e:4fba $a8
    mA_10                                              ;; 0e:4fbb $a9
    mB_8                                               ;; 0e:4fbc $8b
    mA_0                                               ;; 0e:4fbd $09
    mSTEREOPAN $03                                     ;; 0e:4fbe $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:4fc0 $d8
    mD_8                                               ;; 0e:4fc1 $82
    mD_8                                               ;; 0e:4fc2 $82
    mA_2                                               ;; 0e:4fc3 $29
    mGis_10                                            ;; 0e:4fc4 $a8
    mA_10                                              ;; 0e:4fc5 $a9
    mB_8                                               ;; 0e:4fc6 $8b
    mA_0                                               ;; 0e:4fc7 $09
.data_0e_4fc8:
    mFis_4                                             ;; 0e:4fc8 $46
    mFis_8                                             ;; 0e:4fc9 $86
    mG_8                                               ;; 0e:4fca $87
    mFis_8                                             ;; 0e:4fcb $86
    mE_8                                               ;; 0e:4fcc $84
    mG_8                                               ;; 0e:4fcd $87
    mFis_5                                             ;; 0e:4fce $56
    mD_2                                               ;; 0e:4fcf $22
    mOCTAVE_MINUS_1                                    ;; 0e:4fd0 $dc
    mA_5                                               ;; 0e:4fd1 $59
    mAis_5                                             ;; 0e:4fd2 $5a
    mOCTAVE_PLUS_1                                     ;; 0e:4fd3 $d8
    mD_5                                               ;; 0e:4fd4 $52
    mE_5                                               ;; 0e:4fd5 $54
    mD_5                                               ;; 0e:4fd6 $52
    mD_2                                               ;; 0e:4fd7 $22
    mCis_2                                             ;; 0e:4fd8 $21
    mFis_4                                             ;; 0e:4fd9 $46
    mFis_8                                             ;; 0e:4fda $86
    mG_8                                               ;; 0e:4fdb $87
    mFis_8                                             ;; 0e:4fdc $86
    mE_8                                               ;; 0e:4fdd $84
    mG_8                                               ;; 0e:4fde $87
    mFis_5                                             ;; 0e:4fdf $56
    mD_2                                               ;; 0e:4fe0 $22
    mOCTAVE_MINUS_1                                    ;; 0e:4fe1 $dc
    mA_5                                               ;; 0e:4fe2 $59
    mAis_5                                             ;; 0e:4fe3 $5a
    mOCTAVE_PLUS_1                                     ;; 0e:4fe4 $d8
    mD_5                                               ;; 0e:4fe5 $52
    mE_5                                               ;; 0e:4fe6 $54
    mD_5                                               ;; 0e:4fe7 $52
    mA_1                                               ;; 0e:4fe8 $19
    mRest_5                                            ;; 0e:4fe9 $5f
    mD_8                                               ;; 0e:4fea $82
    mD_8                                               ;; 0e:4feb $82
    mA_2                                               ;; 0e:4fec $29
    mGis_10                                            ;; 0e:4fed $a8
    mA_10                                              ;; 0e:4fee $a9
    mB_8                                               ;; 0e:4fef $8b
    mA_5                                               ;; 0e:4ff0 $59
    mD_2                                               ;; 0e:4ff1 $22
    mD_5                                               ;; 0e:4ff2 $52
    mAis_4                                             ;; 0e:4ff3 $4a
    mAis_8                                             ;; 0e:4ff4 $8a
    mCPlus_5                                           ;; 0e:4ff5 $5c
    mAis_5                                             ;; 0e:4ff6 $5a
    mA_1                                               ;; 0e:4ff7 $19
    mRest_5                                            ;; 0e:4ff8 $5f
    mD_8                                               ;; 0e:4ff9 $82
    mD_8                                               ;; 0e:4ffa $82
    mA_2                                               ;; 0e:4ffb $29
    mGis_10                                            ;; 0e:4ffc $a8
    mA_10                                              ;; 0e:4ffd $a9
    mB_8                                               ;; 0e:4ffe $8b
    mA_5                                               ;; 0e:4fff $59
    mD_2                                               ;; 0e:5000 $22
    mD_5                                               ;; 0e:5001 $52
    mOCTAVE_PLUS_1                                     ;; 0e:5002 $d8
    mD_4                                               ;; 0e:5003 $42
    mD_8                                               ;; 0e:5004 $82
    mC_5                                               ;; 0e:5005 $50
    mOCTAVE_MINUS_1                                    ;; 0e:5006 $dc
    mAis_5                                             ;; 0e:5007 $5a
    mA_1                                               ;; 0e:5008 $19
    mRest_5                                            ;; 0e:5009 $5f
    mJUMP .data_0e_4fc8                                ;; 0e:500a $e1 $c8 $4f

song04_channel1:
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:500d $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:5010 $e5 $80
    mSTEREOPAN $01                                     ;; 0e:5012 $e6 $01
    mRest_0                                            ;; 0e:5014 $0f
    mOCTAVE_2                                          ;; 0e:5015 $d2
    mD_8                                               ;; 0e:5016 $82
    mD_8                                               ;; 0e:5017 $82
    mA_2                                               ;; 0e:5018 $29
    mGis_10                                            ;; 0e:5019 $a8
    mA_10                                              ;; 0e:501a $a9
    mB_8                                               ;; 0e:501b $8b
    mA_0                                               ;; 0e:501c $09
    mSTEREOPAN $02                                     ;; 0e:501d $e6 $02
    mOCTAVE_PLUS_1                                     ;; 0e:501f $d8
    mD_8                                               ;; 0e:5020 $82
    mD_8                                               ;; 0e:5021 $82
    mA_2                                               ;; 0e:5022 $29
    mGis_10                                            ;; 0e:5023 $a8
    mA_10                                              ;; 0e:5024 $a9
    mB_8                                               ;; 0e:5025 $8b
    mOCTAVE_MINUS_1                                    ;; 0e:5026 $dc
    mDUTYCYCLE $40                                     ;; 0e:5027 $e5 $40
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:5029 $e0 $5b $7a
.data_0e_502c:
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:502c $e0 $5b $7a
    mA_10                                              ;; 0e:502f $a9
    mE_10                                              ;; 0e:5030 $a4
    mFis_10                                            ;; 0e:5031 $a6
    mD_10                                              ;; 0e:5032 $a2
    mSTEREOPAN $03                                     ;; 0e:5033 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:5035 $e0 $5f $7a
    mA_10                                              ;; 0e:5038 $a9
    mE_10                                              ;; 0e:5039 $a4
    mFis_10                                            ;; 0e:503a $a6
    mD_10                                              ;; 0e:503b $a2
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:503c $e0 $63 $7a
    mA_10                                              ;; 0e:503f $a9
    mE_10                                              ;; 0e:5040 $a4
    mFis_10                                            ;; 0e:5041 $a6
    mD_10                                              ;; 0e:5042 $a2
    mSTEREOPAN $01                                     ;; 0e:5043 $e6 $01
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:5045 $e0 $67 $7a
    mA_10                                              ;; 0e:5048 $a9
    mE_10                                              ;; 0e:5049 $a4
    mFis_10                                            ;; 0e:504a $a6
    mD_10                                              ;; 0e:504b $a2
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:504c $e0 $5b $7a
    mA_10                                              ;; 0e:504f $a9
    mE_10                                              ;; 0e:5050 $a4
    mFis_10                                            ;; 0e:5051 $a6
    mD_10                                              ;; 0e:5052 $a2
    mSTEREOPAN $03                                     ;; 0e:5053 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:5055 $e0 $5f $7a
    mA_10                                              ;; 0e:5058 $a9
    mE_10                                              ;; 0e:5059 $a4
    mFis_10                                            ;; 0e:505a $a6
    mD_10                                              ;; 0e:505b $a2
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:505c $e0 $63 $7a
    mA_10                                              ;; 0e:505f $a9
    mE_10                                              ;; 0e:5060 $a4
    mFis_10                                            ;; 0e:5061 $a6
    mD_10                                              ;; 0e:5062 $a2
    mSTEREOPAN $02                                     ;; 0e:5063 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:5065 $e0 $67 $7a
    mA_10                                              ;; 0e:5068 $a9
    mE_10                                              ;; 0e:5069 $a4
    mFis_10                                            ;; 0e:506a $a6
    mD_10                                              ;; 0e:506b $a2
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:506c $e0 $5b $7a
    mAis_10                                            ;; 0e:506f $aa
    mE_10                                              ;; 0e:5070 $a4
    mF_10                                              ;; 0e:5071 $a5
    mD_10                                              ;; 0e:5072 $a2
    mSTEREOPAN $03                                     ;; 0e:5073 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:5075 $e0 $5f $7a
    mAis_10                                            ;; 0e:5078 $aa
    mE_10                                              ;; 0e:5079 $a4
    mF_10                                              ;; 0e:507a $a5
    mD_10                                              ;; 0e:507b $a2
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:507c $e0 $63 $7a
    mAis_10                                            ;; 0e:507f $aa
    mE_10                                              ;; 0e:5080 $a4
    mF_10                                              ;; 0e:5081 $a5
    mD_10                                              ;; 0e:5082 $a2
    mSTEREOPAN $01                                     ;; 0e:5083 $e6 $01
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:5085 $e0 $67 $7a
    mAis_10                                            ;; 0e:5088 $aa
    mE_10                                              ;; 0e:5089 $a4
    mF_10                                              ;; 0e:508a $a5
    mD_10                                              ;; 0e:508b $a2
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:508c $e0 $5b $7a
    mA_10                                              ;; 0e:508f $a9
    mD_10                                              ;; 0e:5090 $a2
    mE_10                                              ;; 0e:5091 $a4
    mD_10                                              ;; 0e:5092 $a2
    mSTEREOPAN $03                                     ;; 0e:5093 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:5095 $e0 $5f $7a
    mA_10                                              ;; 0e:5098 $a9
    mD_10                                              ;; 0e:5099 $a2
    mE_10                                              ;; 0e:509a $a4
    mD_10                                              ;; 0e:509b $a2
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:509c $e0 $63 $7a
    mA_10                                              ;; 0e:509f $a9
    mCis_10                                            ;; 0e:50a0 $a1
    mE_10                                              ;; 0e:50a1 $a4
    mCis_10                                            ;; 0e:50a2 $a1
    mSTEREOPAN $02                                     ;; 0e:50a3 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:50a5 $e0 $67 $7a
    mA_10                                              ;; 0e:50a8 $a9
    mCis_10                                            ;; 0e:50a9 $a1
    mE_10                                              ;; 0e:50aa $a4
    mCis_10                                            ;; 0e:50ab $a1
    mCOUNTER $03                                       ;; 0e:50ac $e3 $03
.data_0e_50ae:
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:50ae $e0 $5b $7a
    mA_10                                              ;; 0e:50b1 $a9
    mE_10                                              ;; 0e:50b2 $a4
    mFis_10                                            ;; 0e:50b3 $a6
    mD_10                                              ;; 0e:50b4 $a2
    mSTEREOPAN $03                                     ;; 0e:50b5 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:50b7 $e0 $5f $7a
    mA_10                                              ;; 0e:50ba $a9
    mE_10                                              ;; 0e:50bb $a4
    mFis_10                                            ;; 0e:50bc $a6
    mD_10                                              ;; 0e:50bd $a2
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:50be $e0 $63 $7a
    mA_10                                              ;; 0e:50c1 $a9
    mE_10                                              ;; 0e:50c2 $a4
    mFis_10                                            ;; 0e:50c3 $a6
    mD_10                                              ;; 0e:50c4 $a2
    mSTEREOPAN $01                                     ;; 0e:50c5 $e6 $01
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:50c7 $e0 $67 $7a
    mA_10                                              ;; 0e:50ca $a9
    mE_10                                              ;; 0e:50cb $a4
    mFis_10                                            ;; 0e:50cc $a6
    mD_10                                              ;; 0e:50cd $a2
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:50ce $e0 $5b $7a
    mA_10                                              ;; 0e:50d1 $a9
    mE_10                                              ;; 0e:50d2 $a4
    mFis_10                                            ;; 0e:50d3 $a6
    mD_10                                              ;; 0e:50d4 $a2
    mSTEREOPAN $03                                     ;; 0e:50d5 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:50d7 $e0 $5f $7a
    mA_10                                              ;; 0e:50da $a9
    mE_10                                              ;; 0e:50db $a4
    mFis_10                                            ;; 0e:50dc $a6
    mD_10                                              ;; 0e:50dd $a2
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:50de $e0 $63 $7a
    mA_10                                              ;; 0e:50e1 $a9
    mE_10                                              ;; 0e:50e2 $a4
    mFis_10                                            ;; 0e:50e3 $a6
    mD_10                                              ;; 0e:50e4 $a2
    mSTEREOPAN $02                                     ;; 0e:50e5 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:50e7 $e0 $67 $7a
    mA_10                                              ;; 0e:50ea $a9
    mE_10                                              ;; 0e:50eb $a4
    mFis_10                                            ;; 0e:50ec $a6
    mD_10                                              ;; 0e:50ed $a2
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:50ee $e0 $5b $7a
    mAis_10                                            ;; 0e:50f1 $aa
    mE_10                                              ;; 0e:50f2 $a4
    mF_10                                              ;; 0e:50f3 $a5
    mD_10                                              ;; 0e:50f4 $a2
    mSTEREOPAN $03                                     ;; 0e:50f5 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:50f7 $e0 $5f $7a
    mAis_10                                            ;; 0e:50fa $aa
    mE_10                                              ;; 0e:50fb $a4
    mF_10                                              ;; 0e:50fc $a5
    mD_10                                              ;; 0e:50fd $a2
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:50fe $e0 $63 $7a
    mAis_10                                            ;; 0e:5101 $aa
    mE_10                                              ;; 0e:5102 $a4
    mF_10                                              ;; 0e:5103 $a5
    mD_10                                              ;; 0e:5104 $a2
    mSTEREOPAN $01                                     ;; 0e:5105 $e6 $01
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:5107 $e0 $67 $7a
    mAis_10                                            ;; 0e:510a $aa
    mE_10                                              ;; 0e:510b $a4
    mF_10                                              ;; 0e:510c $a5
    mD_10                                              ;; 0e:510d $a2
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:510e $e0 $5b $7a
    mA_10                                              ;; 0e:5111 $a9
    mD_10                                              ;; 0e:5112 $a2
    mE_10                                              ;; 0e:5113 $a4
    mCis_10                                            ;; 0e:5114 $a1
    mSTEREOPAN $03                                     ;; 0e:5115 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:5117 $e0 $5f $7a
    mA_10                                              ;; 0e:511a $a9
    mD_10                                              ;; 0e:511b $a2
    mE_10                                              ;; 0e:511c $a4
    mCis_10                                            ;; 0e:511d $a1
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:511e $e0 $63 $7a
    mA_10                                              ;; 0e:5121 $a9
    mD_10                                              ;; 0e:5122 $a2
    mE_10                                              ;; 0e:5123 $a4
    mCis_10                                            ;; 0e:5124 $a1
    mSTEREOPAN $02                                     ;; 0e:5125 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:5127 $e0 $67 $7a
    mA_10                                              ;; 0e:512a $a9
    mD_10                                              ;; 0e:512b $a2
    mE_10                                              ;; 0e:512c $a4
    mCis_10                                            ;; 0e:512d $a1
    mREPEAT .data_0e_50ae                              ;; 0e:512e $e2 $ae $50
    mJUMP .data_0e_502c                                ;; 0e:5131 $e1 $2c $50

song04_channel3:
    mWAVETABLE data_0e_7a75                            ;; 0e:5134 $e8 $75 $7a
    mVOLUME $40                                        ;; 0e:5137 $e0 $40
    mSTEREOPAN $03                                     ;; 0e:5139 $e6 $03
    mRest_0                                            ;; 0e:513b $0f
    mRest_0                                            ;; 0e:513c $0f
    mRest_0                                            ;; 0e:513d $0f
    mRest_0                                            ;; 0e:513e $0f
.data_0e_513f:
    mOCTAVE_2                                          ;; 0e:513f $d2
    mD_0                                               ;; 0e:5140 $02
    mC_0                                               ;; 0e:5141 $00
    mOCTAVE_MINUS_1                                    ;; 0e:5142 $dc
    mAis_0                                             ;; 0e:5143 $0a
    mA_0                                               ;; 0e:5144 $09
    mJUMP .data_0e_513f                                ;; 0e:5145 $e1 $3f $51

song0f_channel2:
    mVIBRATO frequencyDeltaData                        ;; 0e:5148 $e4 $fe $79
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:514b $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:514e $e5 $80
.data_0e_5150:
    mTEMPO $4c                                         ;; 0e:5150 $e7 $4c
    mSTEREOPAN $03                                     ;; 0e:5152 $e6 $03
    mCOUNTER $02                                       ;; 0e:5154 $e3 $02
.data_0e_5156:
    mOCTAVE_2                                          ;; 0e:5156 $d2
    mB_8                                               ;; 0e:5157 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5158 $d8
    mFis_8                                             ;; 0e:5159 $86
    mG_8                                               ;; 0e:515a $87
    mA_8                                               ;; 0e:515b $89
    mB_0                                               ;; 0e:515c $0b
    mB_8                                               ;; 0e:515d $8b
    mA_8                                               ;; 0e:515e $89
    mOCTAVE_PLUS_1                                     ;; 0e:515f $d8
    mD_8                                               ;; 0e:5160 $82
    mOCTAVE_MINUS_1                                    ;; 0e:5161 $dc
    mB_8                                               ;; 0e:5162 $8b
    mG_0                                               ;; 0e:5163 $07
    mRest_2                                            ;; 0e:5164 $2f
    mFis_8                                             ;; 0e:5165 $86
    mE_8                                               ;; 0e:5166 $84
    mA_8                                               ;; 0e:5167 $89
    mD_8                                               ;; 0e:5168 $82
    mJUMPIF $01, .data_0e_517f                         ;; 0e:5169 $eb $01 $7f $51
    mC_1                                               ;; 0e:516d $10
    mC_8                                               ;; 0e:516e $80
    mD_8                                               ;; 0e:516f $82
    mE_4                                               ;; 0e:5170 $44
    mE_8                                               ;; 0e:5171 $84
    mD_5                                               ;; 0e:5172 $52
    mC_5                                               ;; 0e:5173 $50
    mOCTAVE_MINUS_1                                    ;; 0e:5174 $dc
    mB_4                                               ;; 0e:5175 $4b
    mB_8                                               ;; 0e:5176 $8b
    mAis_5                                             ;; 0e:5177 $5a
    mCisPlus_5                                         ;; 0e:5178 $5d
    mOCTAVE_PLUS_1                                     ;; 0e:5179 $d8
    mE_2                                               ;; 0e:517a $24
    mDis_2                                             ;; 0e:517b $23
    mREPEAT .data_0e_5156                              ;; 0e:517c $e2 $56 $51
.data_0e_517f:
    mC_2                                               ;; 0e:517f $20
    mWait_8                                            ;; 0e:5180 $8e
    mOCTAVE_MINUS_1                                    ;; 0e:5181 $dc
    mB_8                                               ;; 0e:5182 $8b
    mCPlus_8                                           ;; 0e:5183 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:5184 $d8
    mG_8                                               ;; 0e:5185 $87
    mFis_5                                             ;; 0e:5186 $56
    mE_5                                               ;; 0e:5187 $54
    mD_5                                               ;; 0e:5188 $52
    mFis_5                                             ;; 0e:5189 $56
    mE_0                                               ;; 0e:518a $04
    mWait_0                                            ;; 0e:518b $0e
    mCOUNTER $02                                       ;; 0e:518c $e3 $02
.data_0e_518e:
    mD_8                                               ;; 0e:518e $82
    mE_8                                               ;; 0e:518f $84
    mF_8                                               ;; 0e:5190 $85
    mA_8                                               ;; 0e:5191 $89
    mCPlus_5                                           ;; 0e:5192 $5c
    mB_8                                               ;; 0e:5193 $8b
    mA_8                                               ;; 0e:5194 $89
    mB_5                                               ;; 0e:5195 $5b
    mG_1                                               ;; 0e:5196 $17
    mE_8                                               ;; 0e:5197 $84
    mF_8                                               ;; 0e:5198 $85
    mA_8                                               ;; 0e:5199 $89
    mCPlus_8                                           ;; 0e:519a $8c
    mOCTAVE_PLUS_1                                     ;; 0e:519b $d8
    mE_5                                               ;; 0e:519c $54
    mD_8                                               ;; 0e:519d $82
    mC_8                                               ;; 0e:519e $80
    mJUMPIF $01, .data_0e_51a8                         ;; 0e:519f $eb $01 $a8 $51
    mD_0                                               ;; 0e:51a3 $02
    mOCTAVE_MINUS_1                                    ;; 0e:51a4 $dc
    mREPEAT .data_0e_518e                              ;; 0e:51a5 $e2 $8e $51
.data_0e_51a8:
    mOCTAVE_MINUS_1                                    ;; 0e:51a8 $dc
    mB_5                                               ;; 0e:51a9 $5b
    mTEMPO $4a                                         ;; 0e:51aa $e7 $4a
    mWait_8                                            ;; 0e:51ac $8e
    mTEMPO $48                                         ;; 0e:51ad $e7 $48
    mWait_8                                            ;; 0e:51af $8e
    mTEMPO $46                                         ;; 0e:51b0 $e7 $46
    mWait_8                                            ;; 0e:51b2 $8e
    mTEMPO $43                                         ;; 0e:51b3 $e7 $43
    mWait_8                                            ;; 0e:51b5 $8e
    mTEMPO $3f                                         ;; 0e:51b6 $e7 $3f
    mWait_8                                            ;; 0e:51b8 $8e
    mTEMPO $37                                         ;; 0e:51b9 $e7 $37
    mWait_8                                            ;; 0e:51bb $8e
    mJUMP .data_0e_5150                                ;; 0e:51bc $e1 $50 $51

song0f_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:51bf $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a4b                      ;; 0e:51c2 $e0 $4b $7a
    mDUTYCYCLE $40                                     ;; 0e:51c5 $e5 $40
    mSTEREOPAN $03                                     ;; 0e:51c7 $e6 $03
    mCOUNTER $02                                       ;; 0e:51c9 $e3 $02
.data_0e_51cb:
    mOCTAVE_2                                          ;; 0e:51cb $d2
    mE_8                                               ;; 0e:51cc $84
    mG_8                                               ;; 0e:51cd $87
    mE_8                                               ;; 0e:51ce $84
    mG_8                                               ;; 0e:51cf $87
    mE_8                                               ;; 0e:51d0 $84
    mG_8                                               ;; 0e:51d1 $87
    mE_8                                               ;; 0e:51d2 $84
    mG_8                                               ;; 0e:51d3 $87
    mFis_8                                             ;; 0e:51d4 $86
    mA_8                                               ;; 0e:51d5 $89
    mFis_8                                             ;; 0e:51d6 $86
    mA_8                                               ;; 0e:51d7 $89
    mFis_8                                             ;; 0e:51d8 $86
    mA_8                                               ;; 0e:51d9 $89
    mFis_8                                             ;; 0e:51da $86
    mA_8                                               ;; 0e:51db $89
    mE_8                                               ;; 0e:51dc $84
    mB_8                                               ;; 0e:51dd $8b
    mE_8                                               ;; 0e:51de $84
    mB_8                                               ;; 0e:51df $8b
    mE_8                                               ;; 0e:51e0 $84
    mB_8                                               ;; 0e:51e1 $8b
    mE_8                                               ;; 0e:51e2 $84
    mB_8                                               ;; 0e:51e3 $8b
    mFis_8                                             ;; 0e:51e4 $86
    mA_8                                               ;; 0e:51e5 $89
    mFis_8                                             ;; 0e:51e6 $86
    mA_8                                               ;; 0e:51e7 $89
    mFis_8                                             ;; 0e:51e8 $86
    mA_8                                               ;; 0e:51e9 $89
    mFis_8                                             ;; 0e:51ea $86
    mA_8                                               ;; 0e:51eb $89
    mE_8                                               ;; 0e:51ec $84
    mG_8                                               ;; 0e:51ed $87
    mE_8                                               ;; 0e:51ee $84
    mG_8                                               ;; 0e:51ef $87
    mE_8                                               ;; 0e:51f0 $84
    mG_8                                               ;; 0e:51f1 $87
    mE_8                                               ;; 0e:51f2 $84
    mG_8                                               ;; 0e:51f3 $87
    mFis_8                                             ;; 0e:51f4 $86
    mA_8                                               ;; 0e:51f5 $89
    mFis_8                                             ;; 0e:51f6 $86
    mA_8                                               ;; 0e:51f7 $89
    mFis_8                                             ;; 0e:51f8 $86
    mA_8                                               ;; 0e:51f9 $89
    mFis_8                                             ;; 0e:51fa $86
    mA_8                                               ;; 0e:51fb $89
    mJUMPIF $01, .data_0e_5213                         ;; 0e:51fc $eb $01 $13 $52
    mE_8                                               ;; 0e:5200 $84
    mFis_8                                             ;; 0e:5201 $86
    mE_8                                               ;; 0e:5202 $84
    mFis_8                                             ;; 0e:5203 $86
    mE_8                                               ;; 0e:5204 $84
    mFis_8                                             ;; 0e:5205 $86
    mE_8                                               ;; 0e:5206 $84
    mFis_8                                             ;; 0e:5207 $86
    mE_8                                               ;; 0e:5208 $84
    mFis_8                                             ;; 0e:5209 $86
    mE_8                                               ;; 0e:520a $84
    mFis_8                                             ;; 0e:520b $86
    mDis_8                                             ;; 0e:520c $83
    mFis_8                                             ;; 0e:520d $86
    mDis_8                                             ;; 0e:520e $83
    mA_8                                               ;; 0e:520f $89
    mREPEAT .data_0e_51cb                              ;; 0e:5210 $e2 $cb $51
.data_0e_5213:
    mE_8                                               ;; 0e:5213 $84
    mG_8                                               ;; 0e:5214 $87
    mE_8                                               ;; 0e:5215 $84
    mG_8                                               ;; 0e:5216 $87
    mE_8                                               ;; 0e:5217 $84
    mG_8                                               ;; 0e:5218 $87
    mE_8                                               ;; 0e:5219 $84
    mG_8                                               ;; 0e:521a $87
    mE_8                                               ;; 0e:521b $84
    mG_8                                               ;; 0e:521c $87
    mE_8                                               ;; 0e:521d $84
    mG_8                                               ;; 0e:521e $87
    mE_8                                               ;; 0e:521f $84
    mG_8                                               ;; 0e:5220 $87
    mE_8                                               ;; 0e:5221 $84
    mG_8                                               ;; 0e:5222 $87
    mVOLUME_ENVELOPE data_0e_7a36                      ;; 0e:5223 $e0 $36 $7a
    mDUTYCYCLE $40                                     ;; 0e:5226 $e5 $40
    mSTEREOPAN $02                                     ;; 0e:5228 $e6 $02
    mF_2                                               ;; 0e:522a $25
    mDUTYCYCLE $80                                     ;; 0e:522b $e5 $80
    mSTEREOPAN $01                                     ;; 0e:522d $e6 $01
    mF_8                                               ;; 0e:522f $85
    mG_8                                               ;; 0e:5230 $87
    mA_8                                               ;; 0e:5231 $89
    mCPlus_8                                           ;; 0e:5232 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:5233 $d8
    mD_5                                               ;; 0e:5234 $52
    mDUTYCYCLE $40                                     ;; 0e:5235 $e5 $40
    mSTEREOPAN $02                                     ;; 0e:5237 $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:5239 $dc
    mD_8                                               ;; 0e:523a $82
    mE_8                                               ;; 0e:523b $84
    mF_8                                               ;; 0e:523c $85
    mG_8                                               ;; 0e:523d $87
    mA_8                                               ;; 0e:523e $89
    mB_8                                               ;; 0e:523f $8b
    mA_2                                               ;; 0e:5240 $29
    mDUTYCYCLE $00                                     ;; 0e:5241 $e5 $00
    mSTEREOPAN $01                                     ;; 0e:5243 $e6 $01
    mF_8                                               ;; 0e:5245 $85
    mG_8                                               ;; 0e:5246 $87
    mA_8                                               ;; 0e:5247 $89
    mCPlus_8                                           ;; 0e:5248 $8c
    mB_5                                               ;; 0e:5249 $5b
    mDUTYCYCLE $40                                     ;; 0e:524a $e5 $40
    mSTEREOPAN $02                                     ;; 0e:524c $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:524e $dc
    mB_8                                               ;; 0e:524f $8b
    mCPlus_8                                           ;; 0e:5250 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:5251 $d8
    mD_8                                               ;; 0e:5252 $82
    mE_8                                               ;; 0e:5253 $84
    mF_8                                               ;; 0e:5254 $85
    mG_8                                               ;; 0e:5255 $87
    mF_2                                               ;; 0e:5256 $25
    mDUTYCYCLE $80                                     ;; 0e:5257 $e5 $80
    mSTEREOPAN $01                                     ;; 0e:5259 $e6 $01
    mF_8                                               ;; 0e:525b $85
    mG_8                                               ;; 0e:525c $87
    mA_8                                               ;; 0e:525d $89
    mCPlus_8                                           ;; 0e:525e $8c
    mOCTAVE_PLUS_1                                     ;; 0e:525f $d8
    mD_5                                               ;; 0e:5260 $52
    mDUTYCYCLE $40                                     ;; 0e:5261 $e5 $40
    mSTEREOPAN $02                                     ;; 0e:5263 $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:5265 $dc
    mD_8                                               ;; 0e:5266 $82
    mE_8                                               ;; 0e:5267 $84
    mF_8                                               ;; 0e:5268 $85
    mG_8                                               ;; 0e:5269 $87
    mA_8                                               ;; 0e:526a $89
    mB_8                                               ;; 0e:526b $8b
    mA_2                                               ;; 0e:526c $29
    mDUTYCYCLE $00                                     ;; 0e:526d $e5 $00
    mSTEREOPAN $03                                     ;; 0e:526f $e6 $03
    mF_8                                               ;; 0e:5271 $85
    mG_8                                               ;; 0e:5272 $87
    mA_8                                               ;; 0e:5273 $89
    mCPlus_8                                           ;; 0e:5274 $8c
    mB_8                                               ;; 0e:5275 $8b
    mFis_8                                             ;; 0e:5276 $86
    mE_8                                               ;; 0e:5277 $84
    mFis_8                                             ;; 0e:5278 $86
    mDis_8                                             ;; 0e:5279 $83
    mA_8                                               ;; 0e:527a $89
    mG_8                                               ;; 0e:527b $87
    mFis_8                                             ;; 0e:527c $86
    mJUMP song0f_channel1                              ;; 0e:527d $e1 $bf $51

song0f_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:5280 $e4 $fe $79
    mWAVETABLE data_0e_7a75                            ;; 0e:5283 $e8 $75 $7a
    mVOLUME $40                                        ;; 0e:5286 $e0 $40
    mSTEREOPAN $03                                     ;; 0e:5288 $e6 $03
.data_0e_528a:
    mOCTAVE_2                                          ;; 0e:528a $d2
    mE_1                                               ;; 0e:528b $14
    mWait_10                                           ;; 0e:528c $ae
    mRest_10                                           ;; 0e:528d $af
    mE_8                                               ;; 0e:528e $84
    mD_0                                               ;; 0e:528f $02
    mC_1                                               ;; 0e:5290 $10
    mWait_10                                           ;; 0e:5291 $ae
    mRest_10                                           ;; 0e:5292 $af
    mC_8                                               ;; 0e:5293 $80
    mOCTAVE_MINUS_1                                    ;; 0e:5294 $dc
    mB_0                                               ;; 0e:5295 $0b
    mA_1                                               ;; 0e:5296 $19
    mWait_10                                           ;; 0e:5297 $ae
    mRest_10                                           ;; 0e:5298 $af
    mA_8                                               ;; 0e:5299 $89
    mOCTAVE_PLUS_1                                     ;; 0e:529a $d8
    mD_0                                               ;; 0e:529b $02
    mFis_2                                             ;; 0e:529c $26
    mCis_2                                             ;; 0e:529d $21
    mOCTAVE_MINUS_1                                    ;; 0e:529e $dc
    mB_0                                               ;; 0e:529f $0b
    mOCTAVE_PLUS_1                                     ;; 0e:52a0 $d8
    mE_1                                               ;; 0e:52a1 $14
    mWait_10                                           ;; 0e:52a2 $ae
    mRest_10                                           ;; 0e:52a3 $af
    mE_8                                               ;; 0e:52a4 $84
    mD_0                                               ;; 0e:52a5 $02
    mC_1                                               ;; 0e:52a6 $10
    mWait_10                                           ;; 0e:52a7 $ae
    mRest_10                                           ;; 0e:52a8 $af
    mC_8                                               ;; 0e:52a9 $80
    mOCTAVE_MINUS_1                                    ;; 0e:52aa $dc
    mB_0                                               ;; 0e:52ab $0b
    mA_1                                               ;; 0e:52ac $19
    mWait_10                                           ;; 0e:52ad $ae
    mRest_10                                           ;; 0e:52ae $af
    mA_8                                               ;; 0e:52af $89
    mB_0                                               ;; 0e:52b0 $0b
    mCPlus_1                                           ;; 0e:52b1 $1c
    mWait_10                                           ;; 0e:52b2 $ae
    mRest_10                                           ;; 0e:52b3 $af
    mCPlus_8                                           ;; 0e:52b4 $8c
    mCisPlus_0                                         ;; 0e:52b5 $0d
    mOCTAVE_PLUS_1                                     ;; 0e:52b6 $d8
    mD_8                                               ;; 0e:52b7 $82
    mRest_8                                            ;; 0e:52b8 $8f
    mVOLUME $40                                        ;; 0e:52b9 $e0 $40
    mSTEREOPAN $01                                     ;; 0e:52bb $e6 $01
    mD_8                                               ;; 0e:52bd $82
    mRest_8                                            ;; 0e:52be $8f
    mVOLUME $40                                        ;; 0e:52bf $e0 $40
    mSTEREOPAN $02                                     ;; 0e:52c1 $e6 $02
    mA_8                                               ;; 0e:52c3 $89
    mRest_8                                            ;; 0e:52c4 $8f
    mVOLUME $60                                        ;; 0e:52c5 $e0 $60
    mSTEREOPAN $03                                     ;; 0e:52c7 $e6 $03
    mA_8                                               ;; 0e:52c9 $89
    mRest_8                                            ;; 0e:52ca $8f
    mVOLUME $40                                        ;; 0e:52cb $e0 $40
    mSTEREOPAN $01                                     ;; 0e:52cd $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:52cf $dc
    mG_8                                               ;; 0e:52d0 $87
    mRest_8                                            ;; 0e:52d1 $8f
    mVOLUME $60                                        ;; 0e:52d2 $e0 $60
    mSTEREOPAN $03                                     ;; 0e:52d4 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:52d6 $d8
    mG_8                                               ;; 0e:52d7 $87
    mRest_8                                            ;; 0e:52d8 $8f
    mVOLUME $40                                        ;; 0e:52d9 $e0 $40
    mSTEREOPAN $02                                     ;; 0e:52db $e6 $02
    mD_8                                               ;; 0e:52dd $82
    mRest_8                                            ;; 0e:52de $8f
    mVOLUME $60                                        ;; 0e:52df $e0 $60
    mSTEREOPAN $03                                     ;; 0e:52e1 $e6 $03
    mG_8                                               ;; 0e:52e3 $87
    mRest_8                                            ;; 0e:52e4 $8f
    mVOLUME $40                                        ;; 0e:52e5 $e0 $40
    mF_8                                               ;; 0e:52e7 $85
    mRest_8                                            ;; 0e:52e8 $8f
    mVOLUME $60                                        ;; 0e:52e9 $e0 $60
    mSTEREOPAN $02                                     ;; 0e:52eb $e6 $02
    mF_8                                               ;; 0e:52ed $85
    mRest_8                                            ;; 0e:52ee $8f
    mVOLUME $40                                        ;; 0e:52ef $e0 $40
    mSTEREOPAN $01                                     ;; 0e:52f1 $e6 $01
    mCPlus_8                                           ;; 0e:52f3 $8c
    mRest_8                                            ;; 0e:52f4 $8f
    mVOLUME $60                                        ;; 0e:52f5 $e0 $60
    mSTEREOPAN $03                                     ;; 0e:52f7 $e6 $03
    mCPlus_8                                           ;; 0e:52f9 $8c
    mRest_8                                            ;; 0e:52fa $8f
    mVOLUME $40                                        ;; 0e:52fb $e0 $40
    mSTEREOPAN $02                                     ;; 0e:52fd $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:52ff $dc
    mG_8                                               ;; 0e:5300 $87
    mRest_8                                            ;; 0e:5301 $8f
    mVOLUME $60                                        ;; 0e:5302 $e0 $60
    mSTEREOPAN $03                                     ;; 0e:5304 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:5306 $d8
    mG_8                                               ;; 0e:5307 $87
    mRest_8                                            ;; 0e:5308 $8f
    mVOLUME $40                                        ;; 0e:5309 $e0 $40
    mSTEREOPAN $01                                     ;; 0e:530b $e6 $01
    mD_8                                               ;; 0e:530d $82
    mRest_8                                            ;; 0e:530e $8f
    mVOLUME $60                                        ;; 0e:530f $e0 $60
    mSTEREOPAN $03                                     ;; 0e:5311 $e6 $03
    mG_8                                               ;; 0e:5313 $87
    mRest_8                                            ;; 0e:5314 $8f
    mVOLUME $40                                        ;; 0e:5315 $e0 $40
    mD_8                                               ;; 0e:5317 $82
    mRest_8                                            ;; 0e:5318 $8f
    mVOLUME $60                                        ;; 0e:5319 $e0 $60
    mSTEREOPAN $01                                     ;; 0e:531b $e6 $01
    mD_8                                               ;; 0e:531d $82
    mRest_8                                            ;; 0e:531e $8f
    mVOLUME $40                                        ;; 0e:531f $e0 $40
    mSTEREOPAN $02                                     ;; 0e:5321 $e6 $02
    mA_8                                               ;; 0e:5323 $89
    mRest_8                                            ;; 0e:5324 $8f
    mVOLUME $60                                        ;; 0e:5325 $e0 $60
    mSTEREOPAN $03                                     ;; 0e:5327 $e6 $03
    mA_8                                               ;; 0e:5329 $89
    mRest_8                                            ;; 0e:532a $8f
    mVOLUME $40                                        ;; 0e:532b $e0 $40
    mSTEREOPAN $01                                     ;; 0e:532d $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:532f $dc
    mG_8                                               ;; 0e:5330 $87
    mRest_8                                            ;; 0e:5331 $8f
    mVOLUME $60                                        ;; 0e:5332 $e0 $60
    mSTEREOPAN $03                                     ;; 0e:5334 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:5336 $d8
    mG_8                                               ;; 0e:5337 $87
    mRest_8                                            ;; 0e:5338 $8f
    mVOLUME $40                                        ;; 0e:5339 $e0 $40
    mSTEREOPAN $02                                     ;; 0e:533b $e6 $02
    mD_8                                               ;; 0e:533d $82
    mRest_8                                            ;; 0e:533e $8f
    mVOLUME $60                                        ;; 0e:533f $e0 $60
    mSTEREOPAN $03                                     ;; 0e:5341 $e6 $03
    mG_8                                               ;; 0e:5343 $87
    mRest_8                                            ;; 0e:5344 $8f
    mVOLUME $40                                        ;; 0e:5345 $e0 $40
    mF_8                                               ;; 0e:5347 $85
    mRest_8                                            ;; 0e:5348 $8f
    mVOLUME $60                                        ;; 0e:5349 $e0 $60
    mSTEREOPAN $02                                     ;; 0e:534b $e6 $02
    mF_8                                               ;; 0e:534d $85
    mRest_8                                            ;; 0e:534e $8f
    mVOLUME $40                                        ;; 0e:534f $e0 $40
    mSTEREOPAN $01                                     ;; 0e:5351 $e6 $01
    mCPlus_8                                           ;; 0e:5353 $8c
    mRest_8                                            ;; 0e:5354 $8f
    mVOLUME $40                                        ;; 0e:5355 $e0 $40
    mSTEREOPAN $03                                     ;; 0e:5357 $e6 $03
    mCPlus_8                                           ;; 0e:5359 $8c
    mRest_8                                            ;; 0e:535a $8f
    mB_2                                               ;; 0e:535b $2b
    mOCTAVE_MINUS_1                                    ;; 0e:535c $dc
    mB_2                                               ;; 0e:535d $2b
    mJUMP .data_0e_528a                                ;; 0e:535e $e1 $8a $52

song05_channel2:
    mTEMPO $78                                         ;; 0e:5361 $e7 $78
    mVIBRATO frequencyDeltaData.fifth                  ;; 0e:5363 $e4 $24 $7a
    mDUTYCYCLE $00                                     ;; 0e:5366 $e5 $00
.data_0e_5368:
    mVOLUME_ENVELOPE data_0e_7a69                      ;; 0e:5368 $e0 $69 $7a
    mSTEREOPAN $03                                     ;; 0e:536b $e6 $03
    mRest_0                                            ;; 0e:536d $0f
    mRest_0                                            ;; 0e:536e $0f
    mRest_0                                            ;; 0e:536f $0f
    mRest_0                                            ;; 0e:5370 $0f
    mRest_0                                            ;; 0e:5371 $0f
    mRest_0                                            ;; 0e:5372 $0f
    mOCTAVE_4                                          ;; 0e:5373 $d4
    mC_1                                               ;; 0e:5374 $10
    mOCTAVE_MINUS_1                                    ;; 0e:5375 $dc
    mG_0                                               ;; 0e:5376 $07
    mWait_2                                            ;; 0e:5377 $2e
    mG_5                                               ;; 0e:5378 $57
    mF_5                                               ;; 0e:5379 $55
    mG_5                                               ;; 0e:537a $57
    mAis_1                                             ;; 0e:537b $1a
    mF_0                                               ;; 0e:537c $05
    mWait_2                                            ;; 0e:537d $2e
    mRest_1                                            ;; 0e:537e $1f
    mCPlus_1                                           ;; 0e:537f $1c
    mG_0                                               ;; 0e:5380 $07
    mWait_2                                            ;; 0e:5381 $2e
    mG_5                                               ;; 0e:5382 $57
    mF_5                                               ;; 0e:5383 $55
    mG_5                                               ;; 0e:5384 $57
    mGis_2                                             ;; 0e:5385 $28
    mDis_5                                             ;; 0e:5386 $53
    mCisPlus_1                                         ;; 0e:5387 $1d
    mSTEREOPAN $02                                     ;; 0e:5388 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a6f                      ;; 0e:538a $e0 $6f $7a
    mOCTAVE_PLUS_1                                     ;; 0e:538d $d8
    mGis_2                                             ;; 0e:538e $28
    mDis_5                                             ;; 0e:538f $53
    mCisPlus_1                                         ;; 0e:5390 $1d
    mJUMP .data_0e_5368                                ;; 0e:5391 $e1 $68 $53

song05_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:5394 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a73                      ;; 0e:5397 $e0 $73 $7a
    mDUTYCYCLE $80                                     ;; 0e:539a $e5 $80
    mSTEREOPAN $02                                     ;; 0e:539c $e6 $02
    mRest_10                                           ;; 0e:539e $af
.data_0e_539f:
    mCOUNTER $02                                       ;; 0e:539f $e3 $02
.data_0e_53a1:
    mOCTAVE_2                                          ;; 0e:53a1 $d2
    mC_8                                               ;; 0e:53a2 $80
    mD_8                                               ;; 0e:53a3 $82
    mF_8                                               ;; 0e:53a4 $85
    mG_8                                               ;; 0e:53a5 $87
    mA_8                                               ;; 0e:53a6 $89
    mCPlus_8                                           ;; 0e:53a7 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:53a8 $d8
    mD_8                                               ;; 0e:53a9 $82
    mF_8                                               ;; 0e:53aa $85
    mG_8                                               ;; 0e:53ab $87
    mA_8                                               ;; 0e:53ac $89
    mCPlus_8                                           ;; 0e:53ad $8c
    mOCTAVE_PLUS_1                                     ;; 0e:53ae $d8
    mD_8                                               ;; 0e:53af $82
    mREPEAT .data_0e_53a1                              ;; 0e:53b0 $e2 $a1 $53
    mCOUNTER $02                                       ;; 0e:53b3 $e3 $02
.data_0e_53b5:
    mOCTAVE_MINUS_2                                    ;; 0e:53b5 $dd
    mCis_8                                             ;; 0e:53b6 $81
    mDis_8                                             ;; 0e:53b7 $83
    mFis_8                                             ;; 0e:53b8 $86
    mGis_8                                             ;; 0e:53b9 $88
    mAis_8                                             ;; 0e:53ba $8a
    mCisPlus_8                                         ;; 0e:53bb $8d
    mOCTAVE_PLUS_1                                     ;; 0e:53bc $d8
    mDis_8                                             ;; 0e:53bd $83
    mFis_8                                             ;; 0e:53be $86
    mGis_8                                             ;; 0e:53bf $88
    mAis_8                                             ;; 0e:53c0 $8a
    mCisPlus_8                                         ;; 0e:53c1 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:53c2 $d8
    mDis_8                                             ;; 0e:53c3 $83
    mREPEAT .data_0e_53b5                              ;; 0e:53c4 $e2 $b5 $53
    mJUMP .data_0e_539f                                ;; 0e:53c7 $e1 $9f $53

song05_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:53ca $e4 $fe $79
    mWAVETABLE data_0e_7a75                            ;; 0e:53cd $e8 $75 $7a
    mVOLUME $40                                        ;; 0e:53d0 $e0 $40
    mSTEREOPAN $01                                     ;; 0e:53d2 $e6 $01
.data_0e_53d4:
    mCOUNTER $02                                       ;; 0e:53d4 $e3 $02
.data_0e_53d6:
    mOCTAVE_3                                          ;; 0e:53d6 $d3
    mC_8                                               ;; 0e:53d7 $80
    mD_8                                               ;; 0e:53d8 $82
    mF_8                                               ;; 0e:53d9 $85
    mG_8                                               ;; 0e:53da $87
    mA_8                                               ;; 0e:53db $89
    mCPlus_8                                           ;; 0e:53dc $8c
    mOCTAVE_PLUS_1                                     ;; 0e:53dd $d8
    mD_8                                               ;; 0e:53de $82
    mF_8                                               ;; 0e:53df $85
    mG_8                                               ;; 0e:53e0 $87
    mA_8                                               ;; 0e:53e1 $89
    mCPlus_8                                           ;; 0e:53e2 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:53e3 $d8
    mD_8                                               ;; 0e:53e4 $82
    mREPEAT .data_0e_53d6                              ;; 0e:53e5 $e2 $d6 $53
    mCOUNTER $02                                       ;; 0e:53e8 $e3 $02
.data_0e_53ea:
    mOCTAVE_MINUS_2                                    ;; 0e:53ea $dd
    mCis_8                                             ;; 0e:53eb $81
    mDis_8                                             ;; 0e:53ec $83
    mFis_8                                             ;; 0e:53ed $86
    mGis_8                                             ;; 0e:53ee $88
    mAis_8                                             ;; 0e:53ef $8a
    mCisPlus_8                                         ;; 0e:53f0 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:53f1 $d8
    mDis_8                                             ;; 0e:53f2 $83
    mFis_8                                             ;; 0e:53f3 $86
    mGis_8                                             ;; 0e:53f4 $88
    mAis_8                                             ;; 0e:53f5 $8a
    mCisPlus_8                                         ;; 0e:53f6 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:53f7 $d8
    mDis_8                                             ;; 0e:53f8 $83
    mREPEAT .data_0e_53ea                              ;; 0e:53f9 $e2 $ea $53
    mJUMP .data_0e_53d4                                ;; 0e:53fc $e1 $d4 $53

song06_channel2:
    mTEMPO $46                                         ;; 0e:53ff $e7 $46
    mVIBRATO frequencyDeltaData                        ;; 0e:5401 $e4 $fe $79
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:5404 $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:5407 $e5 $80
    mSTEREOPAN $03                                     ;; 0e:5409 $e6 $03
.data_0e_540b:
    mOCTAVE_3                                          ;; 0e:540b $d3
    mG_5                                               ;; 0e:540c $57
    mF_8                                               ;; 0e:540d $85
    mE_8                                               ;; 0e:540e $84
    mF_4                                               ;; 0e:540f $45
    mF_8                                               ;; 0e:5410 $85
    mDis_8                                             ;; 0e:5411 $83
    mOCTAVE_MINUS_1                                    ;; 0e:5412 $dc
    mAis_8                                             ;; 0e:5413 $8a
    mCPlus_8                                           ;; 0e:5414 $8c
    mCisPlus_8                                         ;; 0e:5415 $8d
    mCPlus_5                                           ;; 0e:5416 $5c
    mAis_5                                             ;; 0e:5417 $5a
    mGis_8                                             ;; 0e:5418 $88
    mCPlus_8                                           ;; 0e:5419 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:541a $d8
    mF_8                                               ;; 0e:541b $85
    mGis_8                                             ;; 0e:541c $88
    mG_8                                               ;; 0e:541d $87
    mD_8                                               ;; 0e:541e $82
    mF_8                                               ;; 0e:541f $85
    mE_8                                               ;; 0e:5420 $84
    mG_0                                               ;; 0e:5421 $07
    mE_5                                               ;; 0e:5422 $54
    mD_8                                               ;; 0e:5423 $82
    mCis_8                                             ;; 0e:5424 $81
    mD_4                                               ;; 0e:5425 $42
    mD_8                                               ;; 0e:5426 $82
    mCis_8                                             ;; 0e:5427 $81
    mOCTAVE_MINUS_1                                    ;; 0e:5428 $dc
    mGis_8                                             ;; 0e:5429 $88
    mB_8                                               ;; 0e:542a $8b
    mA_8                                               ;; 0e:542b $89
    mCisPlus_5                                         ;; 0e:542c $5d
    mB_5                                               ;; 0e:542d $5b
    mA_4                                               ;; 0e:542e $49
    mA_8                                               ;; 0e:542f $89
    mGis_5                                             ;; 0e:5430 $58
    mGis_8                                             ;; 0e:5431 $88
    mA_8                                               ;; 0e:5432 $89
    mA_0                                               ;; 0e:5433 $09
    mJUMP .data_0e_540b                                ;; 0e:5434 $e1 $0b $54

song06_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:5437 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a73                      ;; 0e:543a $e0 $73 $7a
    mDUTYCYCLE $80                                     ;; 0e:543d $e5 $80
    mSTEREOPAN $02                                     ;; 0e:543f $e6 $02
    mRest_10                                           ;; 0e:5441 $af
.data_0e_5442:
    mOCTAVE_2                                          ;; 0e:5442 $d2
    mC_8                                               ;; 0e:5443 $80
    mG_8                                               ;; 0e:5444 $87
    mCPlus_8                                           ;; 0e:5445 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:5446 $d8
    mE_8                                               ;; 0e:5447 $84
    mOCTAVE_MINUS_1                                    ;; 0e:5448 $dc
    mCis_8                                             ;; 0e:5449 $81
    mGis_8                                             ;; 0e:544a $88
    mCisPlus_8                                         ;; 0e:544b $8d
    mOCTAVE_PLUS_1                                     ;; 0e:544c $d8
    mF_8                                               ;; 0e:544d $85
    mOCTAVE_MINUS_1                                    ;; 0e:544e $dc
    mDis_8                                             ;; 0e:544f $83
    mAis_8                                             ;; 0e:5450 $8a
    mOCTAVE_PLUS_1                                     ;; 0e:5451 $d8
    mDis_8                                             ;; 0e:5452 $83
    mG_8                                               ;; 0e:5453 $87
    mOCTAVE_MINUS_1                                    ;; 0e:5454 $dc
    mGis_8                                             ;; 0e:5455 $88
    mCPlus_8                                           ;; 0e:5456 $8c
    mG_8                                               ;; 0e:5457 $87
    mOCTAVE_PLUS_1                                     ;; 0e:5458 $d8
    mDis_8                                             ;; 0e:5459 $83
    mOCTAVE_MINUS_1                                    ;; 0e:545a $dc
    mF_8                                               ;; 0e:545b $85
    mGis_8                                             ;; 0e:545c $88
    mCPlus_8                                           ;; 0e:545d $8c
    mOCTAVE_PLUS_1                                     ;; 0e:545e $d8
    mF_8                                               ;; 0e:545f $85
    mOCTAVE_MINUS_1                                    ;; 0e:5460 $dc
    mG_8                                               ;; 0e:5461 $87
    mOCTAVE_PLUS_1                                     ;; 0e:5462 $d8
    mD_8                                               ;; 0e:5463 $82
    mG_8                                               ;; 0e:5464 $87
    mB_8                                               ;; 0e:5465 $8b
    mOCTAVE_MINUS_1                                    ;; 0e:5466 $dc
    mC_8                                               ;; 0e:5467 $80
    mG_8                                               ;; 0e:5468 $87
    mCPlus_8                                           ;; 0e:5469 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:546a $d8
    mE_8                                               ;; 0e:546b $84
    mOCTAVE_MINUS_1                                    ;; 0e:546c $dc
    mCis_8                                             ;; 0e:546d $81
    mG_8                                               ;; 0e:546e $87
    mCisPlus_8                                         ;; 0e:546f $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5470 $d8
    mF_8                                               ;; 0e:5471 $85
    mOCTAVE_MINUS_2                                    ;; 0e:5472 $dd
    mA_8                                               ;; 0e:5473 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5474 $d8
    mE_8                                               ;; 0e:5475 $84
    mA_8                                               ;; 0e:5476 $89
    mCisPlus_8                                         ;; 0e:5477 $8d
    mOCTAVE_MINUS_1                                    ;; 0e:5478 $dc
    mB_8                                               ;; 0e:5479 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:547a $d8
    mFis_8                                             ;; 0e:547b $86
    mB_8                                               ;; 0e:547c $8b
    mOCTAVE_PLUS_1                                     ;; 0e:547d $d8
    mD_8                                               ;; 0e:547e $82
    mOCTAVE_MINUS_1                                    ;; 0e:547f $dc
    mCis_8                                             ;; 0e:5480 $81
    mGis_8                                             ;; 0e:5481 $88
    mCisPlus_8                                         ;; 0e:5482 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5483 $d8
    mF_8                                               ;; 0e:5484 $85
    mOCTAVE_MINUS_1                                    ;; 0e:5485 $dc
    mFis_8                                             ;; 0e:5486 $86
    mA_8                                               ;; 0e:5487 $89
    mE_8                                               ;; 0e:5488 $84
    mB_8                                               ;; 0e:5489 $8b
    mD_8                                               ;; 0e:548a $82
    mA_8                                               ;; 0e:548b $89
    mOCTAVE_PLUS_1                                     ;; 0e:548c $d8
    mD_8                                               ;; 0e:548d $82
    mFis_8                                             ;; 0e:548e $86
    mOCTAVE_MINUS_1                                    ;; 0e:548f $dc
    mE_8                                               ;; 0e:5490 $84
    mGis_8                                             ;; 0e:5491 $88
    mB_8                                               ;; 0e:5492 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5493 $d8
    mE_8                                               ;; 0e:5494 $84
    mOCTAVE_MINUS_2                                    ;; 0e:5495 $dd
    mF_8                                               ;; 0e:5496 $85
    mCPlus_8                                           ;; 0e:5497 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:5498 $d8
    mA_8                                               ;; 0e:5499 $89
    mOCTAVE_PLUS_1                                     ;; 0e:549a $d8
    mF_8                                               ;; 0e:549b $85
    mOCTAVE_MINUS_2                                    ;; 0e:549c $dd
    mG_8                                               ;; 0e:549d $87
    mOCTAVE_PLUS_1                                     ;; 0e:549e $d8
    mD_8                                               ;; 0e:549f $82
    mB_8                                               ;; 0e:54a0 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:54a1 $d8
    mG_8                                               ;; 0e:54a2 $87
    mJUMP .data_0e_5442                                ;; 0e:54a3 $e1 $42 $54

song06_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:54a6 $e4 $fe $79
    mWAVETABLE data_0e_7a75                            ;; 0e:54a9 $e8 $75 $7a
    mVOLUME $40                                        ;; 0e:54ac $e0 $40
    mSTEREOPAN $01                                     ;; 0e:54ae $e6 $01
.data_0e_54b0:
    mOCTAVE_3                                          ;; 0e:54b0 $d3
    mC_8                                               ;; 0e:54b1 $80
    mG_8                                               ;; 0e:54b2 $87
    mCPlus_8                                           ;; 0e:54b3 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:54b4 $d8
    mE_8                                               ;; 0e:54b5 $84
    mOCTAVE_MINUS_1                                    ;; 0e:54b6 $dc
    mCis_8                                             ;; 0e:54b7 $81
    mGis_8                                             ;; 0e:54b8 $88
    mCisPlus_8                                         ;; 0e:54b9 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:54ba $d8
    mF_8                                               ;; 0e:54bb $85
    mOCTAVE_MINUS_1                                    ;; 0e:54bc $dc
    mDis_8                                             ;; 0e:54bd $83
    mAis_8                                             ;; 0e:54be $8a
    mOCTAVE_PLUS_1                                     ;; 0e:54bf $d8
    mDis_8                                             ;; 0e:54c0 $83
    mG_8                                               ;; 0e:54c1 $87
    mOCTAVE_MINUS_1                                    ;; 0e:54c2 $dc
    mGis_8                                             ;; 0e:54c3 $88
    mCPlus_8                                           ;; 0e:54c4 $8c
    mG_8                                               ;; 0e:54c5 $87
    mOCTAVE_PLUS_1                                     ;; 0e:54c6 $d8
    mDis_8                                             ;; 0e:54c7 $83
    mOCTAVE_MINUS_1                                    ;; 0e:54c8 $dc
    mF_8                                               ;; 0e:54c9 $85
    mGis_8                                             ;; 0e:54ca $88
    mCPlus_8                                           ;; 0e:54cb $8c
    mOCTAVE_PLUS_1                                     ;; 0e:54cc $d8
    mF_8                                               ;; 0e:54cd $85
    mOCTAVE_MINUS_1                                    ;; 0e:54ce $dc
    mG_8                                               ;; 0e:54cf $87
    mOCTAVE_PLUS_1                                     ;; 0e:54d0 $d8
    mD_8                                               ;; 0e:54d1 $82
    mG_8                                               ;; 0e:54d2 $87
    mB_8                                               ;; 0e:54d3 $8b
    mOCTAVE_MINUS_1                                    ;; 0e:54d4 $dc
    mC_8                                               ;; 0e:54d5 $80
    mG_8                                               ;; 0e:54d6 $87
    mCPlus_8                                           ;; 0e:54d7 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:54d8 $d8
    mE_8                                               ;; 0e:54d9 $84
    mOCTAVE_MINUS_1                                    ;; 0e:54da $dc
    mCis_8                                             ;; 0e:54db $81
    mG_8                                               ;; 0e:54dc $87
    mCisPlus_8                                         ;; 0e:54dd $8d
    mOCTAVE_PLUS_1                                     ;; 0e:54de $d8
    mF_8                                               ;; 0e:54df $85
    mOCTAVE_MINUS_2                                    ;; 0e:54e0 $dd
    mA_8                                               ;; 0e:54e1 $89
    mOCTAVE_PLUS_1                                     ;; 0e:54e2 $d8
    mE_8                                               ;; 0e:54e3 $84
    mA_8                                               ;; 0e:54e4 $89
    mCisPlus_8                                         ;; 0e:54e5 $8d
    mOCTAVE_MINUS_1                                    ;; 0e:54e6 $dc
    mB_8                                               ;; 0e:54e7 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:54e8 $d8
    mFis_8                                             ;; 0e:54e9 $86
    mB_8                                               ;; 0e:54ea $8b
    mOCTAVE_PLUS_1                                     ;; 0e:54eb $d8
    mD_8                                               ;; 0e:54ec $82
    mOCTAVE_MINUS_1                                    ;; 0e:54ed $dc
    mCis_8                                             ;; 0e:54ee $81
    mGis_8                                             ;; 0e:54ef $88
    mCisPlus_8                                         ;; 0e:54f0 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:54f1 $d8
    mF_8                                               ;; 0e:54f2 $85
    mOCTAVE_MINUS_1                                    ;; 0e:54f3 $dc
    mFis_8                                             ;; 0e:54f4 $86
    mA_8                                               ;; 0e:54f5 $89
    mE_8                                               ;; 0e:54f6 $84
    mB_8                                               ;; 0e:54f7 $8b
    mD_8                                               ;; 0e:54f8 $82
    mA_8                                               ;; 0e:54f9 $89
    mOCTAVE_PLUS_1                                     ;; 0e:54fa $d8
    mD_8                                               ;; 0e:54fb $82
    mFis_8                                             ;; 0e:54fc $86
    mOCTAVE_MINUS_1                                    ;; 0e:54fd $dc
    mE_8                                               ;; 0e:54fe $84
    mGis_8                                             ;; 0e:54ff $88
    mB_8                                               ;; 0e:5500 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5501 $d8
    mE_8                                               ;; 0e:5502 $84
    mOCTAVE_MINUS_2                                    ;; 0e:5503 $dd
    mF_8                                               ;; 0e:5504 $85
    mCPlus_8                                           ;; 0e:5505 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:5506 $d8
    mA_8                                               ;; 0e:5507 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5508 $d8
    mF_8                                               ;; 0e:5509 $85
    mOCTAVE_MINUS_2                                    ;; 0e:550a $dd
    mG_8                                               ;; 0e:550b $87
    mOCTAVE_PLUS_1                                     ;; 0e:550c $d8
    mD_8                                               ;; 0e:550d $82
    mB_8                                               ;; 0e:550e $8b
    mOCTAVE_PLUS_1                                     ;; 0e:550f $d8
    mG_8                                               ;; 0e:5510 $87
    mJUMP .data_0e_54b0                                ;; 0e:5511 $e1 $b0 $54

song07_channel2:
    mTEMPO $55                                         ;; 0e:5514 $e7 $55
    mVIBRATO frequencyDeltaData                        ;; 0e:5516 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a36                      ;; 0e:5519 $e0 $36 $7a
    mSTEREOPAN $03                                     ;; 0e:551c $e6 $03
.data_0e_551e:
    mCOUNTER $02                                       ;; 0e:551e $e3 $02
.data_0e_5520:
    mDUTYCYCLE $80                                     ;; 0e:5520 $e5 $80
    mOCTAVE_2                                          ;; 0e:5522 $d2
    mGis_10                                            ;; 0e:5523 $a8
    mAis_10                                            ;; 0e:5524 $aa
    mB_10                                              ;; 0e:5525 $ab
    mAis_10                                            ;; 0e:5526 $aa
    mB_10                                              ;; 0e:5527 $ab
    mCisPlus_10                                        ;; 0e:5528 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5529 $d8
    mDis_10                                            ;; 0e:552a $a3
    mCis_10                                            ;; 0e:552b $a1
    mOCTAVE_MINUS_1                                    ;; 0e:552c $dc
    mB_10                                              ;; 0e:552d $ab
    mCisPlus_10                                        ;; 0e:552e $ad
    mB_10                                              ;; 0e:552f $ab
    mAis_10                                            ;; 0e:5530 $aa
    mGis_10                                            ;; 0e:5531 $a8
    mAis_10                                            ;; 0e:5532 $aa
    mGis_10                                            ;; 0e:5533 $a8
    mFis_10                                            ;; 0e:5534 $a6
    mDUTYCYCLE $40                                     ;; 0e:5535 $e5 $40
    mGis_10                                            ;; 0e:5537 $a8
    mAis_10                                            ;; 0e:5538 $aa
    mB_10                                              ;; 0e:5539 $ab
    mAis_10                                            ;; 0e:553a $aa
    mB_10                                              ;; 0e:553b $ab
    mCisPlus_10                                        ;; 0e:553c $ad
    mOCTAVE_PLUS_1                                     ;; 0e:553d $d8
    mDis_10                                            ;; 0e:553e $a3
    mCis_10                                            ;; 0e:553f $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5540 $dc
    mB_10                                              ;; 0e:5541 $ab
    mCisPlus_10                                        ;; 0e:5542 $ad
    mB_10                                              ;; 0e:5543 $ab
    mAis_10                                            ;; 0e:5544 $aa
    mGis_10                                            ;; 0e:5545 $a8
    mAis_10                                            ;; 0e:5546 $aa
    mGis_10                                            ;; 0e:5547 $a8
    mFis_10                                            ;; 0e:5548 $a6
    mDUTYCYCLE $80                                     ;; 0e:5549 $e5 $80
    mE_10                                              ;; 0e:554b $a4
    mFis_10                                            ;; 0e:554c $a6
    mG_10                                              ;; 0e:554d $a7
    mFis_10                                            ;; 0e:554e $a6
    mG_10                                              ;; 0e:554f $a7
    mA_10                                              ;; 0e:5550 $a9
    mB_10                                              ;; 0e:5551 $ab
    mA_10                                              ;; 0e:5552 $a9
    mG_10                                              ;; 0e:5553 $a7
    mA_10                                              ;; 0e:5554 $a9
    mG_10                                              ;; 0e:5555 $a7
    mFis_10                                            ;; 0e:5556 $a6
    mE_10                                              ;; 0e:5557 $a4
    mFis_10                                            ;; 0e:5558 $a6
    mE_10                                              ;; 0e:5559 $a4
    mD_10                                              ;; 0e:555a $a2
    mJUMPIF $01, .data_0e_5574                         ;; 0e:555b $eb $01 $74 $55
    mDUTYCYCLE $40                                     ;; 0e:555f $e5 $40
    mE_10                                              ;; 0e:5561 $a4
    mFis_10                                            ;; 0e:5562 $a6
    mG_10                                              ;; 0e:5563 $a7
    mFis_10                                            ;; 0e:5564 $a6
    mG_10                                              ;; 0e:5565 $a7
    mA_10                                              ;; 0e:5566 $a9
    mB_10                                              ;; 0e:5567 $ab
    mA_10                                              ;; 0e:5568 $a9
    mG_10                                              ;; 0e:5569 $a7
    mA_10                                              ;; 0e:556a $a9
    mG_10                                              ;; 0e:556b $a7
    mFis_10                                            ;; 0e:556c $a6
    mE_10                                              ;; 0e:556d $a4
    mFis_10                                            ;; 0e:556e $a6
    mG_10                                              ;; 0e:556f $a7
    mA_10                                              ;; 0e:5570 $a9
    mREPEAT .data_0e_5520                              ;; 0e:5571 $e2 $20 $55
.data_0e_5574:
    mDUTYCYCLE $40                                     ;; 0e:5574 $e5 $40
    mE_10                                              ;; 0e:5576 $a4
    mFis_10                                            ;; 0e:5577 $a6
    mG_10                                              ;; 0e:5578 $a7
    mFis_10                                            ;; 0e:5579 $a6
    mG_10                                              ;; 0e:557a $a7
    mA_10                                              ;; 0e:557b $a9
    mB_10                                              ;; 0e:557c $ab
    mA_10                                              ;; 0e:557d $a9
    mG_10                                              ;; 0e:557e $a7
    mA_10                                              ;; 0e:557f $a9
    mG_10                                              ;; 0e:5580 $a7
    mFis_10                                            ;; 0e:5581 $a6
    mE_10                                              ;; 0e:5582 $a4
    mFis_10                                            ;; 0e:5583 $a6
    mE_10                                              ;; 0e:5584 $a4
    mD_10                                              ;; 0e:5585 $a2
    mCOUNTER $06                                       ;; 0e:5586 $e3 $06
.data_0e_5588:
    mDUTYCYCLE $00                                     ;; 0e:5588 $e5 $00
    mCis_10                                            ;; 0e:558a $a1
    mRest_10                                           ;; 0e:558b $af
    mCis_12                                            ;; 0e:558c $c1
    mRest_12                                           ;; 0e:558d $cf
    mCis_12                                            ;; 0e:558e $c1
    mRest_12                                           ;; 0e:558f $cf
    mREPEAT .data_0e_5588                              ;; 0e:5590 $e2 $88 $55
    mCis_8                                             ;; 0e:5593 $81
    mD_10                                              ;; 0e:5594 $a2
    mRest_10                                           ;; 0e:5595 $af
    mCis_8                                             ;; 0e:5596 $81
    mD_10                                              ;; 0e:5597 $a2
    mRest_10                                           ;; 0e:5598 $af
    mCOUNTER $06                                       ;; 0e:5599 $e3 $06
.data_0e_559b:
    mDis_10                                            ;; 0e:559b $a3
    mRest_10                                           ;; 0e:559c $af
    mDis_12                                            ;; 0e:559d $c3
    mRest_12                                           ;; 0e:559e $cf
    mDis_12                                            ;; 0e:559f $c3
    mRest_12                                           ;; 0e:55a0 $cf
    mREPEAT .data_0e_559b                              ;; 0e:55a1 $e2 $9b $55
    mDis_8                                             ;; 0e:55a4 $83
    mE_10                                              ;; 0e:55a5 $a4
    mRest_10                                           ;; 0e:55a6 $af
    mDis_8                                             ;; 0e:55a7 $83
    mE_10                                              ;; 0e:55a8 $a4
    mRest_10                                           ;; 0e:55a9 $af
    mDUTYCYCLE $40                                     ;; 0e:55aa $e5 $40
    mF_4                                               ;; 0e:55ac $45
    mE_10                                              ;; 0e:55ad $a4
    mF_10                                              ;; 0e:55ae $a5
    mFis_4                                             ;; 0e:55af $46
    mF_10                                              ;; 0e:55b0 $a5
    mFis_10                                            ;; 0e:55b1 $a6
    mG_10                                              ;; 0e:55b2 $a7
    mF_10                                              ;; 0e:55b3 $a5
    mG_10                                              ;; 0e:55b4 $a7
    mA_10                                              ;; 0e:55b5 $a9
    mAis_10                                            ;; 0e:55b6 $aa
    mA_10                                              ;; 0e:55b7 $a9
    mAis_10                                            ;; 0e:55b8 $aa
    mCPlus_10                                          ;; 0e:55b9 $ac
    mOCTAVE_PLUS_1                                     ;; 0e:55ba $d8
    mD_8                                               ;; 0e:55bb $82
    mC_10                                              ;; 0e:55bc $a0
    mOCTAVE_MINUS_1                                    ;; 0e:55bd $dc
    mAis_10                                            ;; 0e:55be $aa
    mA_8                                               ;; 0e:55bf $89
    mF_8                                               ;; 0e:55c0 $85
    mG_0                                               ;; 0e:55c1 $07
    mJUMP .data_0e_551e                                ;; 0e:55c2 $e1 $1e $55

song07_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:55c5 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a36                      ;; 0e:55c8 $e0 $36 $7a
    mDUTYCYCLE $80                                     ;; 0e:55cb $e5 $80
.data_0e_55cd:
    mCOUNTER $02                                       ;; 0e:55cd $e3 $02
.data_0e_55cf:
    mSTEREOPAN $01                                     ;; 0e:55cf $e6 $01
    mOCTAVE_2                                          ;; 0e:55d1 $d2
    mCis_10                                            ;; 0e:55d2 $a1
    mDis_10                                            ;; 0e:55d3 $a3
    mE_10                                              ;; 0e:55d4 $a4
    mDis_10                                            ;; 0e:55d5 $a3
    mCis_10                                            ;; 0e:55d6 $a1
    mRest_10                                           ;; 0e:55d7 $af
    mE_10                                              ;; 0e:55d8 $a4
    mDis_10                                            ;; 0e:55d9 $a3
    mCis_10                                            ;; 0e:55da $a1
    mRest_10                                           ;; 0e:55db $af
    mE_10                                              ;; 0e:55dc $a4
    mDis_10                                            ;; 0e:55dd $a3
    mCis_10                                            ;; 0e:55de $a1
    mRest_10                                           ;; 0e:55df $af
    mE_10                                              ;; 0e:55e0 $a4
    mDis_10                                            ;; 0e:55e1 $a3
    mSTEREOPAN $03                                     ;; 0e:55e2 $e6 $03
    mDUTYCYCLE $40                                     ;; 0e:55e4 $e5 $40
    mCis_10                                            ;; 0e:55e6 $a1
    mDis_10                                            ;; 0e:55e7 $a3
    mE_10                                              ;; 0e:55e8 $a4
    mDis_10                                            ;; 0e:55e9 $a3
    mCis_10                                            ;; 0e:55ea $a1
    mRest_10                                           ;; 0e:55eb $af
    mE_10                                              ;; 0e:55ec $a4
    mDis_10                                            ;; 0e:55ed $a3
    mCis_10                                            ;; 0e:55ee $a1
    mRest_10                                           ;; 0e:55ef $af
    mE_10                                              ;; 0e:55f0 $a4
    mDis_10                                            ;; 0e:55f1 $a3
    mCis_10                                            ;; 0e:55f2 $a1
    mRest_10                                           ;; 0e:55f3 $af
    mCis_10                                            ;; 0e:55f4 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:55f5 $dc
    mB_10                                              ;; 0e:55f6 $ab
    mSTEREOPAN $02                                     ;; 0e:55f7 $e6 $02
    mDUTYCYCLE $80                                     ;; 0e:55f9 $e5 $80
    mA_10                                              ;; 0e:55fb $a9
    mB_10                                              ;; 0e:55fc $ab
    mCPlus_10                                          ;; 0e:55fd $ac
    mB_10                                              ;; 0e:55fe $ab
    mA_10                                              ;; 0e:55ff $a9
    mRest_10                                           ;; 0e:5600 $af
    mCPlus_10                                          ;; 0e:5601 $ac
    mB_10                                              ;; 0e:5602 $ab
    mA_10                                              ;; 0e:5603 $a9
    mRest_10                                           ;; 0e:5604 $af
    mCPlus_10                                          ;; 0e:5605 $ac
    mB_10                                              ;; 0e:5606 $ab
    mA_10                                              ;; 0e:5607 $a9
    mRest_10                                           ;; 0e:5608 $af
    mCPlus_10                                          ;; 0e:5609 $ac
    mB_10                                              ;; 0e:560a $ab
    mJUMPIF $01, .data_0e_5626                         ;; 0e:560b $eb $01 $26 $56
    mSTEREOPAN $03                                     ;; 0e:560f $e6 $03
    mDUTYCYCLE $40                                     ;; 0e:5611 $e5 $40
    mA_10                                              ;; 0e:5613 $a9
    mB_10                                              ;; 0e:5614 $ab
    mCPlus_10                                          ;; 0e:5615 $ac
    mB_10                                              ;; 0e:5616 $ab
    mA_10                                              ;; 0e:5617 $a9
    mRest_10                                           ;; 0e:5618 $af
    mCPlus_10                                          ;; 0e:5619 $ac
    mB_10                                              ;; 0e:561a $ab
    mA_10                                              ;; 0e:561b $a9
    mRest_10                                           ;; 0e:561c $af
    mCPlus_10                                          ;; 0e:561d $ac
    mB_10                                              ;; 0e:561e $ab
    mA_10                                              ;; 0e:561f $a9
    mB_10                                              ;; 0e:5620 $ab
    mCPlus_10                                          ;; 0e:5621 $ac
    mB_10                                              ;; 0e:5622 $ab
    mREPEAT .data_0e_55cf                              ;; 0e:5623 $e2 $cf $55
.data_0e_5626:
    mSTEREOPAN $03                                     ;; 0e:5626 $e6 $03
    mDUTYCYCLE $40                                     ;; 0e:5628 $e5 $40
    mA_10                                              ;; 0e:562a $a9
    mB_10                                              ;; 0e:562b $ab
    mCPlus_10                                          ;; 0e:562c $ac
    mB_10                                              ;; 0e:562d $ab
    mA_10                                              ;; 0e:562e $a9
    mRest_10                                           ;; 0e:562f $af
    mCPlus_10                                          ;; 0e:5630 $ac
    mB_10                                              ;; 0e:5631 $ab
    mA_10                                              ;; 0e:5632 $a9
    mRest_10                                           ;; 0e:5633 $af
    mCPlus_10                                          ;; 0e:5634 $ac
    mB_10                                              ;; 0e:5635 $ab
    mA_10                                              ;; 0e:5636 $a9
    mRest_10                                           ;; 0e:5637 $af
    mCPlus_10                                          ;; 0e:5638 $ac
    mB_10                                              ;; 0e:5639 $ab
    mCOUNTER $02                                       ;; 0e:563a $e3 $02
.data_0e_563c:
    mSTEREOPAN $02                                     ;; 0e:563c $e6 $02
    mDUTYCYCLE $80                                     ;; 0e:563e $e5 $80
    mA_10                                              ;; 0e:5640 $a9
    mB_10                                              ;; 0e:5641 $ab
    mSTEREOPAN $03                                     ;; 0e:5642 $e6 $03
    mA_10                                              ;; 0e:5644 $a9
    mGis_10                                            ;; 0e:5645 $a8
    mSTEREOPAN $01                                     ;; 0e:5646 $e6 $01
    mA_10                                              ;; 0e:5648 $a9
    mB_10                                              ;; 0e:5649 $ab
    mSTEREOPAN $03                                     ;; 0e:564a $e6 $03
    mA_10                                              ;; 0e:564c $a9
    mGis_10                                            ;; 0e:564d $a8
    mREPEAT .data_0e_563c                              ;; 0e:564e $e2 $3c $56
    mSTEREOPAN $02                                     ;; 0e:5651 $e6 $02
    mA_10                                              ;; 0e:5653 $a9
    mB_10                                              ;; 0e:5654 $ab
    mSTEREOPAN $03                                     ;; 0e:5655 $e6 $03
    mA_10                                              ;; 0e:5657 $a9
    mGis_10                                            ;; 0e:5658 $a8
    mSTEREOPAN $01                                     ;; 0e:5659 $e6 $01
    mA_10                                              ;; 0e:565b $a9
    mB_10                                              ;; 0e:565c $ab
    mSTEREOPAN $02                                     ;; 0e:565d $e6 $02
    mA_10                                              ;; 0e:565f $a9
    mGis_10                                            ;; 0e:5660 $a8
    mSTEREOPAN $03                                     ;; 0e:5661 $e6 $03
    mA_8                                               ;; 0e:5663 $89
    mAis_10                                            ;; 0e:5664 $aa
    mRest_10                                           ;; 0e:5665 $af
    mA_8                                               ;; 0e:5666 $89
    mAis_10                                            ;; 0e:5667 $aa
    mRest_10                                           ;; 0e:5668 $af
    mCOUNTER $02                                       ;; 0e:5669 $e3 $02
.data_0e_566b:
    mSTEREOPAN $02                                     ;; 0e:566b $e6 $02
    mB_10                                              ;; 0e:566d $ab
    mCisPlus_10                                        ;; 0e:566e $ad
    mSTEREOPAN $03                                     ;; 0e:566f $e6 $03
    mB_10                                              ;; 0e:5671 $ab
    mAis_10                                            ;; 0e:5672 $aa
    mSTEREOPAN $01                                     ;; 0e:5673 $e6 $01
    mB_10                                              ;; 0e:5675 $ab
    mCisPlus_10                                        ;; 0e:5676 $ad
    mSTEREOPAN $03                                     ;; 0e:5677 $e6 $03
    mB_10                                              ;; 0e:5679 $ab
    mAis_10                                            ;; 0e:567a $aa
    mREPEAT .data_0e_566b                              ;; 0e:567b $e2 $6b $56
    mSTEREOPAN $02                                     ;; 0e:567e $e6 $02
    mB_10                                              ;; 0e:5680 $ab
    mCisPlus_10                                        ;; 0e:5681 $ad
    mSTEREOPAN $03                                     ;; 0e:5682 $e6 $03
    mB_10                                              ;; 0e:5684 $ab
    mAis_10                                            ;; 0e:5685 $aa
    mSTEREOPAN $01                                     ;; 0e:5686 $e6 $01
    mB_10                                              ;; 0e:5688 $ab
    mCisPlus_10                                        ;; 0e:5689 $ad
    mSTEREOPAN $02                                     ;; 0e:568a $e6 $02
    mB_10                                              ;; 0e:568c $ab
    mAis_10                                            ;; 0e:568d $aa
    mSTEREOPAN $03                                     ;; 0e:568e $e6 $03
    mDUTYCYCLE $00                                     ;; 0e:5690 $e5 $00
    mB_8                                               ;; 0e:5692 $8b
    mCPlus_10                                          ;; 0e:5693 $ac
    mRest_10                                           ;; 0e:5694 $af
    mB_8                                               ;; 0e:5695 $8b
    mCPlus_10                                          ;; 0e:5696 $ac
    mRest_10                                           ;; 0e:5697 $af
    mOCTAVE_PLUS_1                                     ;; 0e:5698 $d8
    mD_5                                               ;; 0e:5699 $52
    mCis_5                                             ;; 0e:569a $51
    mDis_5                                             ;; 0e:569b $53
    mD_5                                               ;; 0e:569c $52
    mDis_2                                             ;; 0e:569d $23
    mF_5                                               ;; 0e:569e $55
    mDis_8                                             ;; 0e:569f $83
    mD_8                                               ;; 0e:56a0 $82
    mC_5                                               ;; 0e:56a1 $50
    mCis_5                                             ;; 0e:56a2 $51
    mD_5                                               ;; 0e:56a3 $52
    mCis_5                                             ;; 0e:56a4 $51
    mJUMP .data_0e_55cd                                ;; 0e:56a5 $e1 $cd $55

song07_channel3:
    mVIBRATO frequencyDeltaData.third                  ;; 0e:56a8 $e4 $12 $7a
    mWAVETABLE data_0e_7aa5                            ;; 0e:56ab $e8 $a5 $7a
    mVOLUME $20                                        ;; 0e:56ae $e0 $20
.data_0e_56b0:
    mCOUNTER $02                                       ;; 0e:56b0 $e3 $02
.data_0e_56b2:
    mSTEREOPAN $02                                     ;; 0e:56b2 $e6 $02
    mOCTAVE_2                                          ;; 0e:56b4 $d2
    mCis_4                                             ;; 0e:56b5 $41
    mGis_4                                             ;; 0e:56b6 $48
    mCis_8                                             ;; 0e:56b7 $81
    mOCTAVE_MINUS_1                                    ;; 0e:56b8 $dc
    mGis_8                                             ;; 0e:56b9 $88
    mSTEREOPAN $03                                     ;; 0e:56ba $e6 $03
    mCisPlus_4                                         ;; 0e:56bc $4d
    mOCTAVE_PLUS_1                                     ;; 0e:56bd $d8
    mGis_4                                             ;; 0e:56be $48
    mCis_8                                             ;; 0e:56bf $81
    mOCTAVE_MINUS_1                                    ;; 0e:56c0 $dc
    mGis_8                                             ;; 0e:56c1 $88
    mSTEREOPAN $01                                     ;; 0e:56c2 $e6 $01
    mA_4                                               ;; 0e:56c4 $49
    mOCTAVE_PLUS_1                                     ;; 0e:56c5 $d8
    mE_4                                               ;; 0e:56c6 $44
    mOCTAVE_MINUS_1                                    ;; 0e:56c7 $dc
    mA_8                                               ;; 0e:56c8 $89
    mE_8                                               ;; 0e:56c9 $84
    mJUMPIF $01, .data_0e_56d9                         ;; 0e:56ca $eb $01 $d9 $56
    mSTEREOPAN $03                                     ;; 0e:56ce $e6 $03
    mA_4                                               ;; 0e:56d0 $49
    mOCTAVE_PLUS_1                                     ;; 0e:56d1 $d8
    mE_4                                               ;; 0e:56d2 $44
    mOCTAVE_MINUS_1                                    ;; 0e:56d3 $dc
    mA_8                                               ;; 0e:56d4 $89
    mB_8                                               ;; 0e:56d5 $8b
    mREPEAT .data_0e_56b2                              ;; 0e:56d6 $e2 $b2 $56
.data_0e_56d9:
    mSTEREOPAN $03                                     ;; 0e:56d9 $e6 $03
    mA_4                                               ;; 0e:56db $49
    mOCTAVE_PLUS_1                                     ;; 0e:56dc $d8
    mE_4                                               ;; 0e:56dd $44
    mOCTAVE_MINUS_1                                    ;; 0e:56de $dc
    mA_8                                               ;; 0e:56df $89
    mGis_8                                             ;; 0e:56e0 $88
    mCOUNTER $06                                       ;; 0e:56e1 $e3 $06
.data_0e_56e3:
    mFis_10                                            ;; 0e:56e3 $a6
    mRest_10                                           ;; 0e:56e4 $af
    mFis_10                                            ;; 0e:56e5 $a6
    mRest_10                                           ;; 0e:56e6 $af
    mREPEAT .data_0e_56e3                              ;; 0e:56e7 $e2 $e3 $56
    mFis_8                                             ;; 0e:56ea $86
    mG_10                                              ;; 0e:56eb $a7
    mRest_10                                           ;; 0e:56ec $af
    mFis_8                                             ;; 0e:56ed $86
    mG_10                                              ;; 0e:56ee $a7
    mRest_10                                           ;; 0e:56ef $af
    mCOUNTER $06                                       ;; 0e:56f0 $e3 $06
.data_0e_56f2:
    mGis_10                                            ;; 0e:56f2 $a8
    mRest_10                                           ;; 0e:56f3 $af
    mGis_10                                            ;; 0e:56f4 $a8
    mRest_10                                           ;; 0e:56f5 $af
    mREPEAT .data_0e_56f2                              ;; 0e:56f6 $e2 $f2 $56
    mGis_8                                             ;; 0e:56f9 $88
    mA_10                                              ;; 0e:56fa $a9
    mRest_10                                           ;; 0e:56fb $af
    mGis_8                                             ;; 0e:56fc $88
    mA_10                                              ;; 0e:56fd $a9
    mRest_10                                           ;; 0e:56fe $af
    mAis_2                                             ;; 0e:56ff $2a
    mB_2                                               ;; 0e:5700 $2b
    mCPlus_0                                           ;; 0e:5701 $0c
    mWait_2                                            ;; 0e:5702 $2e
    mWait_8                                            ;; 0e:5703 $8e
    mOCTAVE_PLUS_1                                     ;; 0e:5704 $d8
    mG_10                                              ;; 0e:5705 $a7
    mFis_10                                            ;; 0e:5706 $a6
    mF_10                                              ;; 0e:5707 $a5
    mE_10                                              ;; 0e:5708 $a4
    mDis_10                                            ;; 0e:5709 $a3
    mD_10                                              ;; 0e:570a $a2
    mJUMP .data_0e_56b0                                ;; 0e:570b $e1 $b0 $56

song08_channel2:
    mTEMPO $6b                                         ;; 0e:570e $e7 $6b
    mVIBRATO frequencyDeltaData                        ;; 0e:5710 $e4 $fe $79
    mDUTYCYCLE $40                                     ;; 0e:5713 $e5 $40
.data_0e_5715:
    mVOLUME_ENVELOPE data_0e_7a6b                      ;; 0e:5715 $e0 $6b $7a
    mSTEREOPAN $03                                     ;; 0e:5718 $e6 $03
    mCOUNTER $02                                       ;; 0e:571a $e3 $02
.data_0e_571c:
    mOCTAVE_2                                          ;; 0e:571c $d2
    mE_3                                               ;; 0e:571d $34
    mD_9                                               ;; 0e:571e $92
    mE_9                                               ;; 0e:571f $94
    mG_9                                               ;; 0e:5720 $97
    mRest_9                                            ;; 0e:5721 $9f
    mFis_9                                             ;; 0e:5722 $96
    mRest_9                                            ;; 0e:5723 $9f
    mD_9                                               ;; 0e:5724 $92
    mRest_9                                            ;; 0e:5725 $9f
    mE_3                                               ;; 0e:5726 $34
    mD_9                                               ;; 0e:5727 $92
    mE_9                                               ;; 0e:5728 $94
    mG_9                                               ;; 0e:5729 $97
    mRest_9                                            ;; 0e:572a $9f
    mFis_9                                             ;; 0e:572b $96
    mRest_9                                            ;; 0e:572c $9f
    mD_9                                               ;; 0e:572d $92
    mRest_9                                            ;; 0e:572e $9f
    mFis_9                                             ;; 0e:572f $96
    mD_9                                               ;; 0e:5730 $92
    mFis_9                                             ;; 0e:5731 $96
    mA_3                                               ;; 0e:5732 $39
    mRest_9                                            ;; 0e:5733 $9f
    mCPlus_9                                           ;; 0e:5734 $9c
    mB_9                                               ;; 0e:5735 $9b
    mA_9                                               ;; 0e:5736 $99
    mG_9                                               ;; 0e:5737 $97
    mJUMPIF $01, .data_0e_5747                         ;; 0e:5738 $eb $01 $47 $57
    mFis_3                                             ;; 0e:573c $36
    mG_9                                               ;; 0e:573d $97
    mGis_9                                             ;; 0e:573e $98
    mA_2                                               ;; 0e:573f $29
    mREPEAT .data_0e_571c                              ;; 0e:5740 $e2 $1c $57
    mE_3                                               ;; 0e:5743 $34
    mD_9                                               ;; 0e:5744 $92
    mE_9                                               ;; 0e:5745 $94
    mG_9                                               ;; 0e:5746 $97
.data_0e_5747:
    mFis_2                                             ;; 0e:5747 $26
    mRest_2                                            ;; 0e:5748 $2f
    mGis_9                                             ;; 0e:5749 $98
    mFis_9                                             ;; 0e:574a $96
    mE_9                                               ;; 0e:574b $94
    mB_2                                               ;; 0e:574c $2b
    mCisPlus_9                                         ;; 0e:574d $9d
    mGis_9                                             ;; 0e:574e $98
    mB_9                                               ;; 0e:574f $9b
    mA_9                                               ;; 0e:5750 $99
    mGis_9                                             ;; 0e:5751 $98
    mFis_9                                             ;; 0e:5752 $96
    mA_2                                               ;; 0e:5753 $29
    mB_9                                               ;; 0e:5754 $9b
    mFis_9                                             ;; 0e:5755 $96
    mA_9                                               ;; 0e:5756 $99
    mGis_9                                             ;; 0e:5757 $98
    mFis_9                                             ;; 0e:5758 $96
    mE_9                                               ;; 0e:5759 $94
    mB_2                                               ;; 0e:575a $2b
    mCisPlus_9                                         ;; 0e:575b $9d
    mGis_9                                             ;; 0e:575c $98
    mB_9                                               ;; 0e:575d $9b
    mA_3                                               ;; 0e:575e $39
    mGis_9                                             ;; 0e:575f $98
    mFis_9                                             ;; 0e:5760 $96
    mE_5                                               ;; 0e:5761 $54
    mGis_5                                             ;; 0e:5762 $58
    mFis_3                                             ;; 0e:5763 $36
    mFis_9                                             ;; 0e:5764 $96
    mFis_9                                             ;; 0e:5765 $96
    mFis_3                                             ;; 0e:5766 $36
    mFis_9                                             ;; 0e:5767 $96
    mFis_9                                             ;; 0e:5768 $96
    mVOLUME_ENVELOPE data_0e_7a3f                      ;; 0e:5769 $e0 $3f $7a
    mFis_9                                             ;; 0e:576c $96
    mFis_9                                             ;; 0e:576d $96
    mFis_9                                             ;; 0e:576e $96
    mFis_9                                             ;; 0e:576f $96
    mFis_9                                             ;; 0e:5770 $96
    mFis_9                                             ;; 0e:5771 $96
    mFis_9                                             ;; 0e:5772 $96
    mRest_9                                            ;; 0e:5773 $9f
    mRest_9                                            ;; 0e:5774 $9f
    mRest_5                                            ;; 0e:5775 $5f
    mJUMP .data_0e_5715                                ;; 0e:5776 $e1 $15 $57

song08_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:5779 $e4 $fe $79
    mDUTYCYCLE $00                                     ;; 0e:577c $e5 $00
.data_0e_577e:
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:577e $e0 $59 $7a
    mCOUNTER $02                                       ;; 0e:5781 $e3 $02
.data_0e_5783:
    mSTEREOPAN $03                                     ;; 0e:5783 $e6 $03
    mOCTAVE_2                                          ;; 0e:5785 $d2
    mC_5                                               ;; 0e:5786 $50
    mSTEREOPAN $01                                     ;; 0e:5787 $e6 $01
    mC_9                                               ;; 0e:5789 $90
    mOCTAVE_MINUS_1                                    ;; 0e:578a $dc
    mB_9                                               ;; 0e:578b $9b
    mAis_9                                             ;; 0e:578c $9a
    mSTEREOPAN $03                                     ;; 0e:578d $e6 $03
    mA_5                                               ;; 0e:578f $59
    mSTEREOPAN $02                                     ;; 0e:5790 $e6 $02
    mA_9                                               ;; 0e:5792 $99
    mAis_9                                             ;; 0e:5793 $9a
    mB_9                                               ;; 0e:5794 $9b
    mSTEREOPAN $03                                     ;; 0e:5795 $e6 $03
    mCPlus_5                                           ;; 0e:5797 $5c
    mSTEREOPAN $01                                     ;; 0e:5798 $e6 $01
    mCPlus_9                                           ;; 0e:579a $9c
    mB_9                                               ;; 0e:579b $9b
    mAis_9                                             ;; 0e:579c $9a
    mSTEREOPAN $03                                     ;; 0e:579d $e6 $03
    mA_5                                               ;; 0e:579f $59
    mSTEREOPAN $02                                     ;; 0e:57a0 $e6 $02
    mA_9                                               ;; 0e:57a2 $99
    mAis_9                                             ;; 0e:57a3 $9a
    mB_9                                               ;; 0e:57a4 $9b
    mSTEREOPAN $03                                     ;; 0e:57a5 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:57a7 $d8
    mD_9                                               ;; 0e:57a8 $92
    mOCTAVE_MINUS_1                                    ;; 0e:57a9 $dc
    mA_9                                               ;; 0e:57aa $99
    mOCTAVE_PLUS_1                                     ;; 0e:57ab $d8
    mD_9                                               ;; 0e:57ac $92
    mSTEREOPAN $01                                     ;; 0e:57ad $e6 $01
    mFis_5                                             ;; 0e:57af $56
    mSTEREOPAN $02                                     ;; 0e:57b0 $e6 $02
    mE_5                                               ;; 0e:57b2 $54
    mSTEREOPAN $03                                     ;; 0e:57b3 $e6 $03
    mD_6                                               ;; 0e:57b5 $62
    mOCTAVE_MINUS_1                                    ;; 0e:57b6 $dc
    mA_9                                               ;; 0e:57b7 $99
    mJUMPIF $01, .data_0e_57cf                         ;; 0e:57b8 $eb $01 $cf $57
    mSTEREOPAN $01                                     ;; 0e:57bc $e6 $01
    mOCTAVE_PLUS_1                                     ;; 0e:57be $d8
    mD_5                                               ;; 0e:57bf $52
    mSTEREOPAN $02                                     ;; 0e:57c0 $e6 $02
    mD_9                                               ;; 0e:57c2 $92
    mE_9                                               ;; 0e:57c3 $94
    mF_9                                               ;; 0e:57c4 $95
    mFis_6                                             ;; 0e:57c5 $66
    mSTEREOPAN $03                                     ;; 0e:57c6 $e6 $03
    mE_6                                               ;; 0e:57c8 $64
    mSTEREOPAN $01                                     ;; 0e:57c9 $e6 $01
    mD_6                                               ;; 0e:57cb $62
    mREPEAT .data_0e_5783                              ;; 0e:57cc $e2 $83 $57
.data_0e_57cf:
    mVOLUME_ENVELOPE data_0e_7a47                      ;; 0e:57cf $e0 $47 $7a
    mSTEREOPAN $03                                     ;; 0e:57d2 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:57d4 $d8
    mD_9                                               ;; 0e:57d5 $92
    mE_9                                               ;; 0e:57d6 $94
    mD_9                                               ;; 0e:57d7 $92
    mC_9                                               ;; 0e:57d8 $90
    mD_9                                               ;; 0e:57d9 $92
    mC_9                                               ;; 0e:57da $90
    mOCTAVE_MINUS_1                                    ;; 0e:57db $dc
    mB_9                                               ;; 0e:57dc $9b
    mCPlus_9                                           ;; 0e:57dd $9c
    mB_9                                               ;; 0e:57de $9b
    mA_9                                               ;; 0e:57df $99
    mB_9                                               ;; 0e:57e0 $9b
    mA_9                                               ;; 0e:57e1 $99
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:57e2 $e0 $59 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:57e5 $d8
    mE_9                                               ;; 0e:57e6 $94
    mDis_9                                             ;; 0e:57e7 $93
    mOCTAVE_MINUS_1                                    ;; 0e:57e8 $dc
    mGis_9                                             ;; 0e:57e9 $98
    mOCTAVE_PLUS_1                                     ;; 0e:57ea $d8
    mGis_4                                             ;; 0e:57eb $48
    mWait_11                                           ;; 0e:57ec $be
    mFis_9                                             ;; 0e:57ed $96
    mE_5                                               ;; 0e:57ee $54
    mFis_9                                             ;; 0e:57ef $96
    mD_9                                               ;; 0e:57f0 $92
    mOCTAVE_MINUS_1                                    ;; 0e:57f1 $dc
    mA_9                                               ;; 0e:57f2 $99
    mOCTAVE_PLUS_1                                     ;; 0e:57f3 $d8
    mFis_1                                             ;; 0e:57f4 $16
    mE_9                                               ;; 0e:57f5 $94
    mDis_9                                             ;; 0e:57f6 $93
    mOCTAVE_MINUS_1                                    ;; 0e:57f7 $dc
    mGis_9                                             ;; 0e:57f8 $98
    mOCTAVE_PLUS_1                                     ;; 0e:57f9 $d8
    mGis_4                                             ;; 0e:57fa $48
    mWait_11                                           ;; 0e:57fb $be
    mFis_9                                             ;; 0e:57fc $96
    mE_5                                               ;; 0e:57fd $54
    mD_5                                               ;; 0e:57fe $52
    mFis_9                                             ;; 0e:57ff $96
    mE_9                                               ;; 0e:5800 $94
    mD_9                                               ;; 0e:5801 $92
    mOCTAVE_MINUS_1                                    ;; 0e:5802 $dc
    mB_3                                               ;; 0e:5803 $3b
    mCisPlus_9                                         ;; 0e:5804 $9d
    mB_9                                               ;; 0e:5805 $9b
    mSTEREOPAN $01                                     ;; 0e:5806 $e6 $01
    mB_3                                               ;; 0e:5808 $3b
    mSTEREOPAN $02                                     ;; 0e:5809 $e6 $02
    mB_9                                               ;; 0e:580b $9b
    mB_9                                               ;; 0e:580c $9b
    mSTEREOPAN $01                                     ;; 0e:580d $e6 $01
    mB_3                                               ;; 0e:580f $3b
    mSTEREOPAN $02                                     ;; 0e:5810 $e6 $02
    mB_9                                               ;; 0e:5812 $9b
    mB_9                                               ;; 0e:5813 $9b
    mVOLUME_ENVELOPE data_0e_7a47                      ;; 0e:5814 $e0 $47 $7a
    mSTEREOPAN $03                                     ;; 0e:5817 $e6 $03
    mAis_9                                             ;; 0e:5819 $9a
    mAis_9                                             ;; 0e:581a $9a
    mAis_9                                             ;; 0e:581b $9a
    mAis_9                                             ;; 0e:581c $9a
    mAis_9                                             ;; 0e:581d $9a
    mAis_9                                             ;; 0e:581e $9a
    mAis_9                                             ;; 0e:581f $9a
    mRest_9                                            ;; 0e:5820 $9f
    mRest_9                                            ;; 0e:5821 $9f
    mRest_5                                            ;; 0e:5822 $5f
    mJUMP .data_0e_577e                                ;; 0e:5823 $e1 $7e $57

song08_channel3:
    mWAVETABLE data_0e_7a85                            ;; 0e:5826 $e8 $85 $7a
    mVOLUME $40                                        ;; 0e:5829 $e0 $40
.data_0e_582b:
    mCOUNTER $02                                       ;; 0e:582b $e3 $02
.data_0e_582d:
    mSTEREOPAN $03                                     ;; 0e:582d $e6 $03
    mOCTAVE_1                                          ;; 0e:582f $d1
    mA_8                                               ;; 0e:5830 $89
    mRest_8                                            ;; 0e:5831 $8f
    mSTEREOPAN $02                                     ;; 0e:5832 $e6 $02
    mA_8                                               ;; 0e:5834 $89
    mRest_8                                            ;; 0e:5835 $8f
    mSTEREOPAN $03                                     ;; 0e:5836 $e6 $03
    mA_8                                               ;; 0e:5838 $89
    mRest_8                                            ;; 0e:5839 $8f
    mSTEREOPAN $01                                     ;; 0e:583a $e6 $01
    mA_6                                               ;; 0e:583c $69
    mOCTAVE_PLUS_1                                     ;; 0e:583d $d8
    mE_9                                               ;; 0e:583e $94
    mSTEREOPAN $03                                     ;; 0e:583f $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5841 $dc
    mA_8                                               ;; 0e:5842 $89
    mRest_8                                            ;; 0e:5843 $8f
    mSTEREOPAN $02                                     ;; 0e:5844 $e6 $02
    mA_8                                               ;; 0e:5846 $89
    mRest_8                                            ;; 0e:5847 $8f
    mSTEREOPAN $03                                     ;; 0e:5848 $e6 $03
    mA_8                                               ;; 0e:584a $89
    mRest_8                                            ;; 0e:584b $8f
    mSTEREOPAN $01                                     ;; 0e:584c $e6 $01
    mA_6                                               ;; 0e:584e $69
    mOCTAVE_PLUS_1                                     ;; 0e:584f $d8
    mE_9                                               ;; 0e:5850 $94
    mSTEREOPAN $03                                     ;; 0e:5851 $e6 $03
    mD_8                                               ;; 0e:5853 $82
    mRest_8                                            ;; 0e:5854 $8f
    mSTEREOPAN $02                                     ;; 0e:5855 $e6 $02
    mD_8                                               ;; 0e:5857 $82
    mRest_8                                            ;; 0e:5858 $8f
    mSTEREOPAN $03                                     ;; 0e:5859 $e6 $03
    mD_8                                               ;; 0e:585b $82
    mRest_8                                            ;; 0e:585c $8f
    mSTEREOPAN $01                                     ;; 0e:585d $e6 $01
    mD_6                                               ;; 0e:585f $62
    mOCTAVE_MINUS_1                                    ;; 0e:5860 $dc
    mA_9                                               ;; 0e:5861 $99
    mJUMPIF $01, .data_0e_587a                         ;; 0e:5862 $eb $01 $7a $58
    mSTEREOPAN $03                                     ;; 0e:5866 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:5868 $d8
    mD_8                                               ;; 0e:5869 $82
    mRest_8                                            ;; 0e:586a $8f
    mD_8                                               ;; 0e:586b $82
    mRest_8                                            ;; 0e:586c $8f
    mSTEREOPAN $02                                     ;; 0e:586d $e6 $02
    mD_6                                               ;; 0e:586f $62
    mSTEREOPAN $03                                     ;; 0e:5870 $e6 $03
    mC_6                                               ;; 0e:5872 $60
    mSTEREOPAN $01                                     ;; 0e:5873 $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:5875 $dc
    mB_6                                               ;; 0e:5876 $6b
    mREPEAT .data_0e_582d                              ;; 0e:5877 $e2 $2d $58
.data_0e_587a:
    mSTEREOPAN $03                                     ;; 0e:587a $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:587c $d8
    mD_2                                               ;; 0e:587d $22
    mWait_9                                            ;; 0e:587e $9e
    mE_9                                               ;; 0e:587f $94
    mD_9                                               ;; 0e:5880 $92
    mC_9                                               ;; 0e:5881 $90
    mD_9                                               ;; 0e:5882 $92
    mC_9                                               ;; 0e:5883 $90
    mSTEREOPAN $02                                     ;; 0e:5884 $e6 $02
    mCis_8                                             ;; 0e:5886 $81
    mRest_8                                            ;; 0e:5887 $8f
    mSTEREOPAN $01                                     ;; 0e:5888 $e6 $01
    mCis_8                                             ;; 0e:588a $81
    mRest_8                                            ;; 0e:588b $8f
    mSTEREOPAN $02                                     ;; 0e:588c $e6 $02
    mCis_8                                             ;; 0e:588e $81
    mRest_8                                            ;; 0e:588f $8f
    mSTEREOPAN $03                                     ;; 0e:5890 $e6 $03
    mCis_9                                             ;; 0e:5892 $91
    mE_9                                               ;; 0e:5893 $94
    mCis_9                                             ;; 0e:5894 $91
    mSTEREOPAN $01                                     ;; 0e:5895 $e6 $01
    mD_8                                               ;; 0e:5897 $82
    mRest_8                                            ;; 0e:5898 $8f
    mSTEREOPAN $02                                     ;; 0e:5899 $e6 $02
    mD_8                                               ;; 0e:589b $82
    mRest_8                                            ;; 0e:589c $8f
    mSTEREOPAN $01                                     ;; 0e:589d $e6 $01
    mD_8                                               ;; 0e:589f $82
    mRest_8                                            ;; 0e:58a0 $8f
    mSTEREOPAN $03                                     ;; 0e:58a1 $e6 $03
    mD_9                                               ;; 0e:58a3 $92
    mFis_9                                             ;; 0e:58a4 $96
    mD_9                                               ;; 0e:58a5 $92
    mSTEREOPAN $02                                     ;; 0e:58a6 $e6 $02
    mCis_8                                             ;; 0e:58a8 $81
    mRest_8                                            ;; 0e:58a9 $8f
    mSTEREOPAN $01                                     ;; 0e:58aa $e6 $01
    mCis_8                                             ;; 0e:58ac $81
    mRest_8                                            ;; 0e:58ad $8f
    mSTEREOPAN $02                                     ;; 0e:58ae $e6 $02
    mCis_8                                             ;; 0e:58b0 $81
    mRest_8                                            ;; 0e:58b1 $8f
    mSTEREOPAN $03                                     ;; 0e:58b2 $e6 $03
    mCis_9                                             ;; 0e:58b4 $91
    mE_9                                               ;; 0e:58b5 $94
    mCis_9                                             ;; 0e:58b6 $91
    mSTEREOPAN $02                                     ;; 0e:58b7 $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:58b9 $dc
    mB_2                                               ;; 0e:58ba $2b
    mSTEREOPAN $01                                     ;; 0e:58bb $e6 $01
    mCisPlus_2                                         ;; 0e:58bd $2d
    mSTEREOPAN $03                                     ;; 0e:58be $e6 $03
    mFis_8                                             ;; 0e:58c0 $86
    mRest_8                                            ;; 0e:58c1 $8f
    mFis_8                                             ;; 0e:58c2 $86
    mRest_8                                            ;; 0e:58c3 $8f
    mFis_8                                             ;; 0e:58c4 $86
    mRest_8                                            ;; 0e:58c5 $8f
    mFis_9                                             ;; 0e:58c6 $96
    mOCTAVE_PLUS_1                                     ;; 0e:58c7 $d8
    mFis_9                                             ;; 0e:58c8 $96
    mCis_9                                             ;; 0e:58c9 $91
    mOCTAVE_MINUS_1                                    ;; 0e:58ca $dc
    mFis_11                                            ;; 0e:58cb $b6
    mRest_11                                           ;; 0e:58cc $bf
    mFis_11                                            ;; 0e:58cd $b6
    mRest_11                                           ;; 0e:58ce $bf
    mFis_11                                            ;; 0e:58cf $b6
    mRest_11                                           ;; 0e:58d0 $bf
    mFis_11                                            ;; 0e:58d1 $b6
    mRest_11                                           ;; 0e:58d2 $bf
    mFis_11                                            ;; 0e:58d3 $b6
    mRest_11                                           ;; 0e:58d4 $bf
    mFis_11                                            ;; 0e:58d5 $b6
    mRest_11                                           ;; 0e:58d6 $bf
    mFis_9                                             ;; 0e:58d7 $96
    mRest_9                                            ;; 0e:58d8 $9f
    mOCTAVE_PLUS_1                                     ;; 0e:58d9 $d8
    mE_9                                               ;; 0e:58da $94
    mD_9                                               ;; 0e:58db $92
    mC_9                                               ;; 0e:58dc $90
    mOCTAVE_MINUS_1                                    ;; 0e:58dd $dc
    mB_9                                               ;; 0e:58de $9b
    mJUMP .data_0e_582b                                ;; 0e:58df $e1 $2b $58

song09_channel2:
    mTEMPO $49                                         ;; 0e:58e2 $e7 $49
    mVIBRATO frequencyDeltaData                        ;; 0e:58e4 $e4 $fe $79
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:58e7 $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:58ea $e5 $80
    mSTEREOPAN $03                                     ;; 0e:58ec $e6 $03
.data_0e_58ee:
    mCOUNTER $02                                       ;; 0e:58ee $e3 $02
.data_0e_58f0:
    mOCTAVE_3                                          ;; 0e:58f0 $d3
    mCis_5                                             ;; 0e:58f1 $51
    mOCTAVE_MINUS_1                                    ;; 0e:58f2 $dc
    mB_8                                               ;; 0e:58f3 $8b
    mCisPlus_8                                         ;; 0e:58f4 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:58f5 $d8
    mD_8                                               ;; 0e:58f6 $82
    mCis_8                                             ;; 0e:58f7 $81
    mOCTAVE_MINUS_1                                    ;; 0e:58f8 $dc
    mB_8                                               ;; 0e:58f9 $8b
    mA_8                                               ;; 0e:58fa $89
    mB_5                                               ;; 0e:58fb $5b
    mOCTAVE_PLUS_1                                     ;; 0e:58fc $d8
    mFis_5                                             ;; 0e:58fd $56
    mE_5                                               ;; 0e:58fe $54
    mFis_8                                             ;; 0e:58ff $86
    mGis_8                                             ;; 0e:5900 $88
    mA_4                                               ;; 0e:5901 $49
    mA_8                                               ;; 0e:5902 $89
    mGis_8                                             ;; 0e:5903 $88
    mFis_8                                             ;; 0e:5904 $86
    mE_8                                               ;; 0e:5905 $84
    mDis_8                                             ;; 0e:5906 $83
    mE_1                                               ;; 0e:5907 $14
    mE_8                                               ;; 0e:5908 $84
    mFis_8                                             ;; 0e:5909 $86
    mG_2                                               ;; 0e:590a $27
    mRest_8                                            ;; 0e:590b $8f
    mCis_8                                             ;; 0e:590c $81
    mFis_8                                             ;; 0e:590d $86
    mE_8                                               ;; 0e:590e $84
    mD_8                                               ;; 0e:590f $82
    mCis_8                                             ;; 0e:5910 $81
    mD_8                                               ;; 0e:5911 $82
    mFis_8                                             ;; 0e:5912 $86
    mOCTAVE_MINUS_1                                    ;; 0e:5913 $dc
    mA_5                                               ;; 0e:5914 $59
    mB_5                                               ;; 0e:5915 $5b
    mJUMPIF $01, .data_0e_592c                         ;; 0e:5916 $eb $01 $2c $59
    mCisPlus_5                                         ;; 0e:591a $5d
    mOCTAVE_PLUS_1                                     ;; 0e:591b $d8
    mD_8                                               ;; 0e:591c $82
    mCis_8                                             ;; 0e:591d $81
    mOCTAVE_MINUS_1                                    ;; 0e:591e $dc
    mB_8                                               ;; 0e:591f $8b
    mA_8                                               ;; 0e:5920 $89
    mGis_8                                             ;; 0e:5921 $88
    mA_8                                               ;; 0e:5922 $89
    mCisPlus_5                                         ;; 0e:5923 $5d
    mB_5                                               ;; 0e:5924 $5b
    mRest_8                                            ;; 0e:5925 $8f
    mE_8                                               ;; 0e:5926 $84
    mFis_8                                             ;; 0e:5927 $86
    mE_8                                               ;; 0e:5928 $84
    mREPEAT .data_0e_58f0                              ;; 0e:5929 $e2 $f0 $58
.data_0e_592c:
    mCisPlus_5                                         ;; 0e:592c $5d
    mB_8                                               ;; 0e:592d $8b
    mA_8                                               ;; 0e:592e $89
    mFis_5                                             ;; 0e:592f $56
    mGis_5                                             ;; 0e:5930 $58
    mA_0                                               ;; 0e:5931 $09
    mGis_8                                             ;; 0e:5932 $88
    mFis_8                                             ;; 0e:5933 $86
    mGis_8                                             ;; 0e:5934 $88
    mCisPlus_5                                         ;; 0e:5935 $5d
    mOCTAVE_PLUS_1                                     ;; 0e:5936 $d8
    mD_8                                               ;; 0e:5937 $82
    mCis_8                                             ;; 0e:5938 $81
    mOCTAVE_MINUS_1                                    ;; 0e:5939 $dc
    mB_8                                               ;; 0e:593a $8b
    mA_8                                               ;; 0e:593b $89
    mGis_8                                             ;; 0e:593c $88
    mFis_8                                             ;; 0e:593d $86
    mGis_8                                             ;; 0e:593e $88
    mA_2                                               ;; 0e:593f $29
    mGis_8                                             ;; 0e:5940 $88
    mFis_8                                             ;; 0e:5941 $86
    mGis_8                                             ;; 0e:5942 $88
    mCisPlus_5                                         ;; 0e:5943 $5d
    mGis_8                                             ;; 0e:5944 $88
    mA_8                                               ;; 0e:5945 $89
    mB_8                                               ;; 0e:5946 $8b
    mB_5                                               ;; 0e:5947 $5b
    mA_5                                               ;; 0e:5948 $59
    mRest_8                                            ;; 0e:5949 $8f
    mA_8                                               ;; 0e:594a $89
    mB_8                                               ;; 0e:594b $8b
    mCisPlus_8                                         ;; 0e:594c $8d
    mOCTAVE_PLUS_1                                     ;; 0e:594d $d8
    mD_5                                               ;; 0e:594e $52
    mCis_8                                             ;; 0e:594f $81
    mD_8                                               ;; 0e:5950 $82
    mE_5                                               ;; 0e:5951 $54
    mCis_5                                             ;; 0e:5952 $51
    mFis_8                                             ;; 0e:5953 $86
    mGis_8                                             ;; 0e:5954 $88
    mA_4                                               ;; 0e:5955 $49
    mOCTAVE_MINUS_1                                    ;; 0e:5956 $dc
    mA_8                                               ;; 0e:5957 $89
    mB_8                                               ;; 0e:5958 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5959 $d8
    mD_8                                               ;; 0e:595a $82
    mCis_5                                             ;; 0e:595b $51
    mE_5                                               ;; 0e:595c $54
    mDis_4                                             ;; 0e:595d $43
    mE_8                                               ;; 0e:595e $84
    mE_2                                               ;; 0e:595f $24
    mWait_8                                            ;; 0e:5960 $8e
    mOCTAVE_MINUS_1                                    ;; 0e:5961 $dc
    mGis_8                                             ;; 0e:5962 $88
    mA_8                                               ;; 0e:5963 $89
    mB_8                                               ;; 0e:5964 $8b
    mJUMP .data_0e_58ee                                ;; 0e:5965 $e1 $ee $58

song09_channel1:
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:5968 $e0 $5b $7a
    mDUTYCYCLE $40                                     ;; 0e:596b $e5 $40
.data_0e_596d:
    mCOUNTER $02                                       ;; 0e:596d $e3 $02
.data_0e_596f:
    mSTEREOPAN $02                                     ;; 0e:596f $e6 $02
    mRest_8                                            ;; 0e:5971 $8f
    mOCTAVE_2                                          ;; 0e:5972 $d2
    mE_8                                               ;; 0e:5973 $84
    mFis_8                                             ;; 0e:5974 $86
    mE_8                                               ;; 0e:5975 $84
    mSTEREOPAN $01                                     ;; 0e:5976 $e6 $01
    mRest_8                                            ;; 0e:5978 $8f
    mFis_8                                             ;; 0e:5979 $86
    mGis_8                                             ;; 0e:597a $88
    mFis_8                                             ;; 0e:597b $86
    mSTEREOPAN $03                                     ;; 0e:597c $e6 $03
    mGis_5                                             ;; 0e:597e $58
    mA_5                                               ;; 0e:597f $59
    mGis_8                                             ;; 0e:5980 $88
    mB_8                                               ;; 0e:5981 $8b
    mA_8                                               ;; 0e:5982 $89
    mB_8                                               ;; 0e:5983 $8b
    mSTEREOPAN $02                                     ;; 0e:5984 $e6 $02
    mRest_8                                            ;; 0e:5986 $8f
    mCisPlus_8                                         ;; 0e:5987 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5988 $d8
    mD_8                                               ;; 0e:5989 $82
    mCis_8                                             ;; 0e:598a $81
    mSTEREOPAN $01                                     ;; 0e:598b $e6 $01
    mRest_8                                            ;; 0e:598d $8f
    mC_8                                               ;; 0e:598e $80
    mOCTAVE_MINUS_1                                    ;; 0e:598f $dc
    mGis_8                                             ;; 0e:5990 $88
    mFis_8                                             ;; 0e:5991 $86
    mSTEREOPAN $03                                     ;; 0e:5992 $e6 $03
    mGis_8                                             ;; 0e:5994 $88
    mA_8                                               ;; 0e:5995 $89
    mGis_8                                             ;; 0e:5996 $88
    mFis_8                                             ;; 0e:5997 $86
    mGis_5                                             ;; 0e:5998 $58
    mGis_8                                             ;; 0e:5999 $88
    mA_8                                               ;; 0e:599a $89
    mSTEREOPAN $02                                     ;; 0e:599b $e6 $02
    mB_8                                               ;; 0e:599d $8b
    mA_8                                               ;; 0e:599e $89
    mG_8                                               ;; 0e:599f $87
    mB_8                                               ;; 0e:59a0 $8b
    mAis_5                                             ;; 0e:59a1 $5a
    mFis_8                                             ;; 0e:59a2 $86
    mGis_8                                             ;; 0e:59a3 $88
    mSTEREOPAN $01                                     ;; 0e:59a4 $e6 $01
    mFis_8                                             ;; 0e:59a6 $86
    mE_8                                               ;; 0e:59a7 $84
    mFis_8                                             ;; 0e:59a8 $86
    mD_8                                               ;; 0e:59a9 $82
    mCis_5                                             ;; 0e:59aa $51
    mFis_5                                             ;; 0e:59ab $56
    mJUMPIF $01, .data_0e_59c6                         ;; 0e:59ac $eb $01 $c6 $59
    mSTEREOPAN $02                                     ;; 0e:59b0 $e6 $02
    mRest_8                                            ;; 0e:59b2 $8f
    mE_8                                               ;; 0e:59b3 $84
    mFis_8                                             ;; 0e:59b4 $86
    mE_8                                               ;; 0e:59b5 $84
    mSTEREOPAN $01                                     ;; 0e:59b6 $e6 $01
    mDis_5                                             ;; 0e:59b8 $53
    mE_8                                               ;; 0e:59b9 $84
    mFis_8                                             ;; 0e:59ba $86
    mSTEREOPAN $03                                     ;; 0e:59bb $e6 $03
    mGis_2                                             ;; 0e:59bd $28
    mRest_8                                            ;; 0e:59be $8f
    mOCTAVE_MINUS_1                                    ;; 0e:59bf $dc
    mGis_8                                             ;; 0e:59c0 $88
    mA_8                                               ;; 0e:59c1 $89
    mGis_8                                             ;; 0e:59c2 $88
    mREPEAT .data_0e_596f                              ;; 0e:59c3 $e2 $6f $59
.data_0e_59c6:
    mSTEREOPAN $03                                     ;; 0e:59c6 $e6 $03
    mE_2                                               ;; 0e:59c8 $24
    mD_5                                               ;; 0e:59c9 $52
    mCis_8                                             ;; 0e:59ca $81
    mOCTAVE_MINUS_1                                    ;; 0e:59cb $dc
    mB_8                                               ;; 0e:59cc $8b
    mCisPlus_8                                         ;; 0e:59cd $8d
    mOCTAVE_PLUS_1                                     ;; 0e:59ce $d8
    mE_8                                               ;; 0e:59cf $84
    mD_8                                               ;; 0e:59d0 $82
    mOCTAVE_MINUS_1                                    ;; 0e:59d1 $dc
    mB_8                                               ;; 0e:59d2 $8b
    mCisPlus_2                                         ;; 0e:59d3 $2d
    mSTEREOPAN $02                                     ;; 0e:59d4 $e6 $02
    mRest_5                                            ;; 0e:59d6 $5f
    mOCTAVE_PLUS_1                                     ;; 0e:59d7 $d8
    mE_8                                               ;; 0e:59d8 $84
    mFis_8                                             ;; 0e:59d9 $86
    mE_5                                               ;; 0e:59da $54
    mGis_5                                             ;; 0e:59db $58
    mSTEREOPAN $01                                     ;; 0e:59dc $e6 $01
    mFis_8                                             ;; 0e:59de $86
    mE_8                                               ;; 0e:59df $84
    mD_8                                               ;; 0e:59e0 $82
    mE_8                                               ;; 0e:59e1 $84
    mD_2                                               ;; 0e:59e2 $22
    mSTEREOPAN $02                                     ;; 0e:59e3 $e6 $02
    mRest_5                                            ;; 0e:59e5 $5f
    mE_8                                               ;; 0e:59e6 $84
    mFis_8                                             ;; 0e:59e7 $86
    mSTEREOPAN $01                                     ;; 0e:59e8 $e6 $01
    mE_5                                               ;; 0e:59ea $54
    mFis_8                                             ;; 0e:59eb $86
    mE_8                                               ;; 0e:59ec $84
    mSTEREOPAN $03                                     ;; 0e:59ed $e6 $03
    mCis_2                                             ;; 0e:59ef $21
    mRest_5                                            ;; 0e:59f0 $5f
    mFis_8                                             ;; 0e:59f1 $86
    mE_8                                               ;; 0e:59f2 $84
    mSTEREOPAN $02                                     ;; 0e:59f3 $e6 $02
    mFis_5                                             ;; 0e:59f5 $56
    mE_8                                               ;; 0e:59f6 $84
    mFis_8                                             ;; 0e:59f7 $86
    mGis_8                                             ;; 0e:59f8 $88
    mFis_8                                             ;; 0e:59f9 $86
    mE_8                                               ;; 0e:59fa $84
    mGis_8                                             ;; 0e:59fb $88
    mSTEREOPAN $01                                     ;; 0e:59fc $e6 $01
    mD_8                                               ;; 0e:59fe $82
    mE_8                                               ;; 0e:59ff $84
    mFis_5                                             ;; 0e:5a00 $56
    mRest_5                                            ;; 0e:5a01 $5f
    mSTEREOPAN $03                                     ;; 0e:5a02 $e6 $03
    mF_5                                               ;; 0e:5a04 $55
    mA_2                                               ;; 0e:5a05 $29
    mB_5                                               ;; 0e:5a06 $5b
    mA_5                                               ;; 0e:5a07 $59
    mA_5                                               ;; 0e:5a08 $59
    mGis_8                                             ;; 0e:5a09 $88
    mFis_8                                             ;; 0e:5a0a $86
    mE_4                                               ;; 0e:5a0b $44
    mD_8                                               ;; 0e:5a0c $82
    mJUMP .data_0e_596d                                ;; 0e:5a0d $e1 $6d $59

song09_channel3:
    mWAVETABLE data_0e_7a75                            ;; 0e:5a10 $e8 $75 $7a
    mVOLUME $40                                        ;; 0e:5a13 $e0 $40
    mSTEREOPAN $03                                     ;; 0e:5a15 $e6 $03
.data_0e_5a17:
    mCOUNTER $02                                       ;; 0e:5a17 $e3 $02
.data_0e_5a19:
    mOCTAVE_1                                          ;; 0e:5a19 $d1
    mA_2                                               ;; 0e:5a1a $29
    mOCTAVE_PLUS_1                                     ;; 0e:5a1b $d8
    mD_2                                               ;; 0e:5a1c $22
    mE_5                                               ;; 0e:5a1d $54
    mD_5                                               ;; 0e:5a1e $52
    mCis_2                                             ;; 0e:5a1f $21
    mFis_2                                             ;; 0e:5a20 $26
    mGis_5                                             ;; 0e:5a21 $58
    mOCTAVE_MINUS_1                                    ;; 0e:5a22 $dc
    mGis_5                                             ;; 0e:5a23 $58
    mCisPlus_2                                         ;; 0e:5a24 $2d
    mWait_8                                            ;; 0e:5a25 $8e
    mRest_8                                            ;; 0e:5a26 $8f
    mCisPlus_8                                         ;; 0e:5a27 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5a28 $d8
    mD_8                                               ;; 0e:5a29 $82
    mE_2                                               ;; 0e:5a2a $24
    mFis_5                                             ;; 0e:5a2b $56
    mOCTAVE_MINUS_1                                    ;; 0e:5a2c $dc
    mFis_5                                             ;; 0e:5a2d $56
    mB_2                                               ;; 0e:5a2e $2b
    mOCTAVE_PLUS_1                                     ;; 0e:5a2f $d8
    mE_5                                               ;; 0e:5a30 $54
    mD_5                                               ;; 0e:5a31 $52
    mOCTAVE_MINUS_1                                    ;; 0e:5a32 $dc
    mJUMPIF $01, .data_0e_5a43                         ;; 0e:5a33 $eb $01 $43 $5a
    mA_2                                               ;; 0e:5a37 $29
    mB_4                                               ;; 0e:5a38 $4b
    mOCTAVE_PLUS_1                                     ;; 0e:5a39 $d8
    mDis_8                                             ;; 0e:5a3a $83
    mE_2                                               ;; 0e:5a3b $24
    mWait_10                                           ;; 0e:5a3c $ae
    mRest_5                                            ;; 0e:5a3d $5f
    mRest_8                                            ;; 0e:5a3e $8f
    mRest_10                                           ;; 0e:5a3f $af
    mREPEAT .data_0e_5a19                              ;; 0e:5a40 $e2 $19 $5a
.data_0e_5a43:
    mA_2                                               ;; 0e:5a43 $29
    mB_5                                               ;; 0e:5a44 $5b
    mOCTAVE_PLUS_1                                     ;; 0e:5a45 $d8
    mE_5                                               ;; 0e:5a46 $54
    mOCTAVE_MINUS_1                                    ;; 0e:5a47 $dc
    mA_5                                               ;; 0e:5a48 $59
    mOCTAVE_PLUS_1                                     ;; 0e:5a49 $d8
    mFis_8                                             ;; 0e:5a4a $86
    mD_8                                               ;; 0e:5a4b $82
    mOCTAVE_MINUS_1                                    ;; 0e:5a4c $dc
    mA_4                                               ;; 0e:5a4d $49
    mRest_8                                            ;; 0e:5a4e $8f
    mCisPlus_2                                         ;; 0e:5a4f $2d
    mOCTAVE_PLUS_1                                     ;; 0e:5a50 $d8
    mGis_5                                             ;; 0e:5a51 $58
    mCis_5                                             ;; 0e:5a52 $51
    mD_2                                               ;; 0e:5a53 $22
    mRest_8                                            ;; 0e:5a54 $8f
    mFis_8                                             ;; 0e:5a55 $86
    mE_8                                               ;; 0e:5a56 $84
    mD_8                                               ;; 0e:5a57 $82
    mCis_2                                             ;; 0e:5a58 $21
    mGis_5                                             ;; 0e:5a59 $58
    mCis_5                                             ;; 0e:5a5a $51
    mFis_2                                             ;; 0e:5a5b $26
    mWait_8                                            ;; 0e:5a5c $8e
    mE_8                                               ;; 0e:5a5d $84
    mD_8                                               ;; 0e:5a5e $82
    mCis_8                                             ;; 0e:5a5f $81
    mOCTAVE_MINUS_1                                    ;; 0e:5a60 $dc
    mB_2                                               ;; 0e:5a61 $2b
    mCisPlus_2                                         ;; 0e:5a62 $2d
    mOCTAVE_PLUS_1                                     ;; 0e:5a63 $d8
    mD_2                                               ;; 0e:5a64 $22
    mRest_2                                            ;; 0e:5a65 $2f
    mOCTAVE_PLUS_1                                     ;; 0e:5a66 $d8
    mE_2                                               ;; 0e:5a67 $24
    mFis_2                                             ;; 0e:5a68 $26
    mE_5                                               ;; 0e:5a69 $54
    mOCTAVE_MINUS_1                                    ;; 0e:5a6a $dc
    mE_5                                               ;; 0e:5a6b $54
    mD_5                                               ;; 0e:5a6c $52
    mCis_8                                             ;; 0e:5a6d $81
    mOCTAVE_MINUS_1                                    ;; 0e:5a6e $dc
    mB_8                                               ;; 0e:5a6f $8b
    mJUMP .data_0e_5a17                                ;; 0e:5a70 $e1 $17 $5a

song0a_channel2:
    mTEMPO $8e                                         ;; 0e:5a73 $e7 $8e
    mVIBRATO frequencyDeltaData                        ;; 0e:5a75 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:5a78 $e0 $55 $7a
    mDUTYCYCLE $40                                     ;; 0e:5a7b $e5 $40
    mSTEREOPAN $03                                     ;; 0e:5a7d $e6 $03
    mOCTAVE_2                                          ;; 0e:5a7f $d2
    mG_10                                              ;; 0e:5a80 $a7
    mGis_10                                            ;; 0e:5a81 $a8
.data_0e_5a82:
    mCOUNTER $02                                       ;; 0e:5a82 $e3 $02
.data_0e_5a84:
    mOCTAVE_PLUS_1                                     ;; 0e:5a84 $d8
    mE_4                                               ;; 0e:5a85 $44
    mOCTAVE_MINUS_1                                    ;; 0e:5a86 $dc
    mGis_8                                             ;; 0e:5a87 $88
    mOCTAVE_PLUS_1                                     ;; 0e:5a88 $d8
    mFis_8                                             ;; 0e:5a89 $86
    mE_8                                               ;; 0e:5a8a $84
    mDis_8                                             ;; 0e:5a8b $83
    mOCTAVE_MINUS_1                                    ;; 0e:5a8c $dc
    mB_8                                               ;; 0e:5a8d $8b
    mCisPlus_5                                         ;; 0e:5a8e $5d
    mOCTAVE_PLUS_1                                     ;; 0e:5a8f $d8
    mDis_8                                             ;; 0e:5a90 $83
    mE_8                                               ;; 0e:5a91 $84
    mDis_8                                             ;; 0e:5a92 $83
    mE_8                                               ;; 0e:5a93 $84
    mDis_8                                             ;; 0e:5a94 $83
    mOCTAVE_MINUS_1                                    ;; 0e:5a95 $dc
    mB_8                                               ;; 0e:5a96 $8b
    mJUMPIF $01, .data_0e_5aa4                         ;; 0e:5a97 $eb $01 $a4 $5a
    mCisPlus_5                                         ;; 0e:5a9b $5d
    mGis_1                                             ;; 0e:5a9c $18
    mRest_1                                            ;; 0e:5a9d $1f
    mRest_8                                            ;; 0e:5a9e $8f
    mG_10                                              ;; 0e:5a9f $a7
    mGis_10                                            ;; 0e:5aa0 $a8
    mREPEAT .data_0e_5a84                              ;; 0e:5aa1 $e2 $84 $5a
.data_0e_5aa4:
    mCisPlus_5                                         ;; 0e:5aa4 $5d
    mCPlus_8                                           ;; 0e:5aa5 $8c
    mCisPlus_8                                         ;; 0e:5aa6 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5aa7 $d8
    mDis_5                                             ;; 0e:5aa8 $53
    mE_5                                               ;; 0e:5aa9 $54
    mOCTAVE_MINUS_1                                    ;; 0e:5aaa $dc
    mB_0                                               ;; 0e:5aab $0b
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:5aac $e0 $31 $7a
    mA_5                                               ;; 0e:5aaf $59
    mB_5                                               ;; 0e:5ab0 $5b
    mCisPlus_8                                         ;; 0e:5ab1 $8d
    mB_8                                               ;; 0e:5ab2 $8b
    mA_8                                               ;; 0e:5ab3 $89
    mB_8                                               ;; 0e:5ab4 $8b
    mCisPlus_5                                         ;; 0e:5ab5 $5d
    mOCTAVE_PLUS_1                                     ;; 0e:5ab6 $d8
    mDis_5                                             ;; 0e:5ab7 $53
    mE_8                                               ;; 0e:5ab8 $84
    mFis_8                                             ;; 0e:5ab9 $86
    mE_8                                               ;; 0e:5aba $84
    mA_8                                               ;; 0e:5abb $89
    mGis_0                                             ;; 0e:5abc $08
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:5abd $e0 $57 $7a
    mDUTYCYCLE $80                                     ;; 0e:5ac0 $e5 $80
    mRest_10                                           ;; 0e:5ac2 $af
    mOCTAVE_MINUS_1                                    ;; 0e:5ac3 $dc
    mA_10                                              ;; 0e:5ac4 $a9
    mGis_10                                            ;; 0e:5ac5 $a8
    mFis_10                                            ;; 0e:5ac6 $a6
    mGis_10                                            ;; 0e:5ac7 $a8
    mA_10                                              ;; 0e:5ac8 $a9
    mGis_10                                            ;; 0e:5ac9 $a8
    mFis_10                                            ;; 0e:5aca $a6
    mGis_10                                            ;; 0e:5acb $a8
    mAis_10                                            ;; 0e:5acc $aa
    mCPlus_10                                          ;; 0e:5acd $ac
    mCisPlus_10                                        ;; 0e:5ace $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5acf $d8
    mDis_10                                            ;; 0e:5ad0 $a3
    mE_10                                              ;; 0e:5ad1 $a4
    mFis_10                                            ;; 0e:5ad2 $a6
    mGis_10                                            ;; 0e:5ad3 $a8
    mOCTAVE_MINUS_1                                    ;; 0e:5ad4 $dc
    mCOUNTER $02                                       ;; 0e:5ad5 $e3 $02
.data_0e_5ad7:
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:5ad7 $e0 $55 $7a
    mDUTYCYCLE $40                                     ;; 0e:5ada $e5 $40
    mB_8                                               ;; 0e:5adc $8b
    mA_8                                               ;; 0e:5add $89
    mGis_8                                             ;; 0e:5ade $88
    mA_8                                               ;; 0e:5adf $89
    mOCTAVE_PLUS_1                                     ;; 0e:5ae0 $d8
    mE_4                                               ;; 0e:5ae1 $44
    mOCTAVE_MINUS_1                                    ;; 0e:5ae2 $dc
    mA_8                                               ;; 0e:5ae3 $89
    mGis_8                                             ;; 0e:5ae4 $88
    mA_8                                               ;; 0e:5ae5 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5ae6 $d8
    mE_5                                               ;; 0e:5ae7 $54
    mFis_8                                             ;; 0e:5ae8 $86
    mE_8                                               ;; 0e:5ae9 $84
    mDis_8                                             ;; 0e:5aea $83
    mCis_8                                             ;; 0e:5aeb $81
    mDis_4                                             ;; 0e:5aec $43
    mOCTAVE_MINUS_1                                    ;; 0e:5aed $dc
    mB_5                                               ;; 0e:5aee $5b
    mB_8                                               ;; 0e:5aef $8b
    mCisPlus_8                                         ;; 0e:5af0 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5af1 $d8
    mDis_8                                             ;; 0e:5af2 $83
    mE_5                                               ;; 0e:5af3 $54
    mDis_5                                             ;; 0e:5af4 $53
    mCis_8                                             ;; 0e:5af5 $81
    mOCTAVE_MINUS_1                                    ;; 0e:5af6 $dc
    mGis_8                                             ;; 0e:5af7 $88
    mA_8                                               ;; 0e:5af8 $89
    mB_8                                               ;; 0e:5af9 $8b
    mJUMPIF $01, .data_0e_5b18                         ;; 0e:5afa $eb $01 $18 $5b
    mB_4                                               ;; 0e:5afe $4b
    mA_5                                               ;; 0e:5aff $59
    mA_8                                               ;; 0e:5b00 $89
    mB_8                                               ;; 0e:5b01 $8b
    mCisPlus_8                                         ;; 0e:5b02 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5b03 $d8
    mDis_5                                             ;; 0e:5b04 $53
    mCis_5                                             ;; 0e:5b05 $51
    mOCTAVE_MINUS_1                                    ;; 0e:5b06 $dc
    mB_6                                               ;; 0e:5b07 $6b
    mCisPlus_6                                         ;; 0e:5b08 $6d
    mOCTAVE_PLUS_1                                     ;; 0e:5b09 $d8
    mDis_6                                             ;; 0e:5b0a $63
    mE_4                                               ;; 0e:5b0b $44
    mCis_5                                             ;; 0e:5b0c $51
    mCis_8                                             ;; 0e:5b0d $81
    mDis_8                                             ;; 0e:5b0e $83
    mE_8                                               ;; 0e:5b0f $84
    mDis_5                                             ;; 0e:5b10 $53
    mCis_5                                             ;; 0e:5b11 $51
    mOCTAVE_MINUS_1                                    ;; 0e:5b12 $dc
    mB_4                                               ;; 0e:5b13 $4b
    mRest_8                                            ;; 0e:5b14 $8f
    mREPEAT .data_0e_5ad7                              ;; 0e:5b15 $e2 $d7 $5a
.data_0e_5b18:
    mA_4                                               ;; 0e:5b18 $49
    mGis_10                                            ;; 0e:5b19 $a8
    mA_10                                              ;; 0e:5b1a $a9
    mB_4                                               ;; 0e:5b1b $4b
    mA_10                                              ;; 0e:5b1c $a9
    mB_10                                              ;; 0e:5b1d $ab
    mCisPlus_8                                         ;; 0e:5b1e $8d
    mB_10                                              ;; 0e:5b1f $ab
    mCisPlus_10                                        ;; 0e:5b20 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5b21 $d8
    mDis_8                                             ;; 0e:5b22 $83
    mCis_10                                            ;; 0e:5b23 $a1
    mDis_10                                            ;; 0e:5b24 $a3
    mE_8                                               ;; 0e:5b25 $84
    mDis_10                                            ;; 0e:5b26 $a3
    mE_10                                              ;; 0e:5b27 $a4
    mFis_8                                             ;; 0e:5b28 $86
    mE_10                                              ;; 0e:5b29 $a4
    mFis_10                                            ;; 0e:5b2a $a6
    mGis_4                                             ;; 0e:5b2b $48
    mAis_10                                            ;; 0e:5b2c $aa
    mGis_10                                            ;; 0e:5b2d $a8
    mG_5                                               ;; 0e:5b2e $57
    mDis_8                                             ;; 0e:5b2f $83
    mF_10                                              ;; 0e:5b30 $a5
    mG_10                                              ;; 0e:5b31 $a7
    mGis_1                                             ;; 0e:5b32 $18
    mRest_8                                            ;; 0e:5b33 $8f
    mOCTAVE_MINUS_1                                    ;; 0e:5b34 $dc
    mG_10                                              ;; 0e:5b35 $a7
    mGis_10                                            ;; 0e:5b36 $a8
    mJUMP .data_0e_5a82                                ;; 0e:5b37 $e1 $82 $5a

song0a_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:5b3a $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:5b3d $e0 $59 $7a
    mDUTYCYCLE $40                                     ;; 0e:5b40 $e5 $40
    mRest_8                                            ;; 0e:5b42 $8f
.data_0e_5b43:
    mCOUNTER $02                                       ;; 0e:5b43 $e3 $02
.data_0e_5b45:
    mSTEREOPAN $01                                     ;; 0e:5b45 $e6 $01
    mOCTAVE_2                                          ;; 0e:5b47 $d2
    mE_10                                              ;; 0e:5b48 $a4
    mRest_10                                           ;; 0e:5b49 $af
    mE_10                                              ;; 0e:5b4a $a4
    mDis_10                                            ;; 0e:5b4b $a3
    mSTEREOPAN $02                                     ;; 0e:5b4c $e6 $02
    mE_10                                              ;; 0e:5b4e $a4
    mRest_10                                           ;; 0e:5b4f $af
    mE_10                                              ;; 0e:5b50 $a4
    mDis_10                                            ;; 0e:5b51 $a3
    mSTEREOPAN $01                                     ;; 0e:5b52 $e6 $01
    mE_10                                              ;; 0e:5b54 $a4
    mRest_10                                           ;; 0e:5b55 $af
    mE_10                                              ;; 0e:5b56 $a4
    mDis_10                                            ;; 0e:5b57 $a3
    mSTEREOPAN $02                                     ;; 0e:5b58 $e6 $02
    mE_10                                              ;; 0e:5b5a $a4
    mRest_10                                           ;; 0e:5b5b $af
    mE_10                                              ;; 0e:5b5c $a4
    mDis_10                                            ;; 0e:5b5d $a3
    mSTEREOPAN $01                                     ;; 0e:5b5e $e6 $01
    mCis_10                                            ;; 0e:5b60 $a1
    mRest_10                                           ;; 0e:5b61 $af
    mCis_10                                            ;; 0e:5b62 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5b63 $dc
    mB_10                                              ;; 0e:5b64 $ab
    mSTEREOPAN $02                                     ;; 0e:5b65 $e6 $02
    mCisPlus_10                                        ;; 0e:5b67 $ad
    mRest_10                                           ;; 0e:5b68 $af
    mCisPlus_10                                        ;; 0e:5b69 $ad
    mB_10                                              ;; 0e:5b6a $ab
    mSTEREOPAN $01                                     ;; 0e:5b6b $e6 $01
    mOCTAVE_PLUS_1                                     ;; 0e:5b6d $d8
    mDis_10                                            ;; 0e:5b6e $a3
    mRest_10                                           ;; 0e:5b6f $af
    mDis_10                                            ;; 0e:5b70 $a3
    mCis_10                                            ;; 0e:5b71 $a1
    mSTEREOPAN $02                                     ;; 0e:5b72 $e6 $02
    mDis_10                                            ;; 0e:5b74 $a3
    mE_10                                              ;; 0e:5b75 $a4
    mFis_10                                            ;; 0e:5b76 $a6
    mDis_10                                            ;; 0e:5b77 $a3
    mJUMPIF $01, .data_0e_5b9b                         ;; 0e:5b78 $eb $01 $9b $5b
    mSTEREOPAN $01                                     ;; 0e:5b7c $e6 $01
    mRest_8                                            ;; 0e:5b7e $8f
    mCis_8                                             ;; 0e:5b7f $81
    mE_8                                               ;; 0e:5b80 $84
    mDis_8                                             ;; 0e:5b81 $83
    mSTEREOPAN $02                                     ;; 0e:5b82 $e6 $02
    mE_8                                               ;; 0e:5b84 $84
    mFis_8                                             ;; 0e:5b85 $86
    mE_8                                               ;; 0e:5b86 $84
    mCis_8                                             ;; 0e:5b87 $81
    mSTEREOPAN $01                                     ;; 0e:5b88 $e6 $01
    mRest_8                                            ;; 0e:5b8a $8f
    mOCTAVE_MINUS_1                                    ;; 0e:5b8b $dc
    mA_8                                               ;; 0e:5b8c $89
    mOCTAVE_PLUS_1                                     ;; 0e:5b8d $d8
    mE_8                                               ;; 0e:5b8e $84
    mCis_8                                             ;; 0e:5b8f $81
    mSTEREOPAN $02                                     ;; 0e:5b90 $e6 $02
    mDis_8                                             ;; 0e:5b92 $83
    mFis_8                                             ;; 0e:5b93 $86
    mDis_8                                             ;; 0e:5b94 $83
    mOCTAVE_MINUS_1                                    ;; 0e:5b95 $dc
    mB_8                                               ;; 0e:5b96 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5b97 $d8
    mREPEAT .data_0e_5b45                              ;; 0e:5b98 $e2 $45 $5b
.data_0e_5b9b:
    mSTEREOPAN $01                                     ;; 0e:5b9b $e6 $01
    mE_10                                              ;; 0e:5b9d $a4
    mFis_10                                            ;; 0e:5b9e $a6
    mE_10                                              ;; 0e:5b9f $a4
    mDis_10                                            ;; 0e:5ba0 $a3
    mSTEREOPAN $02                                     ;; 0e:5ba1 $e6 $02
    mE_10                                              ;; 0e:5ba3 $a4
    mFis_10                                            ;; 0e:5ba4 $a6
    mE_10                                              ;; 0e:5ba5 $a4
    mDis_10                                            ;; 0e:5ba6 $a3
    mSTEREOPAN $01                                     ;; 0e:5ba7 $e6 $01
    mFis_10                                            ;; 0e:5ba9 $a6
    mGis_10                                            ;; 0e:5baa $a8
    mFis_10                                            ;; 0e:5bab $a6
    mE_10                                              ;; 0e:5bac $a4
    mSTEREOPAN $02                                     ;; 0e:5bad $e6 $02
    mFis_10                                            ;; 0e:5baf $a6
    mGis_10                                            ;; 0e:5bb0 $a8
    mFis_10                                            ;; 0e:5bb1 $a6
    mE_10                                              ;; 0e:5bb2 $a4
    mSTEREOPAN $03                                     ;; 0e:5bb3 $e6 $03
    mRest_8                                            ;; 0e:5bb5 $8f
    mFis_8                                             ;; 0e:5bb6 $86
    mGis_8                                             ;; 0e:5bb7 $88
    mA_8                                               ;; 0e:5bb8 $89
    mGis_8                                             ;; 0e:5bb9 $88
    mFis_8                                             ;; 0e:5bba $86
    mE_8                                               ;; 0e:5bbb $84
    mDis_8                                             ;; 0e:5bbc $83
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:5bbd $e0 $31 $7a
    mSTEREOPAN $01                                     ;; 0e:5bc0 $e6 $01
    mE_2                                               ;; 0e:5bc2 $24
    mCis_5                                             ;; 0e:5bc3 $51
    mE_5                                               ;; 0e:5bc4 $54
    mSTEREOPAN $02                                     ;; 0e:5bc5 $e6 $02
    mA_5                                               ;; 0e:5bc7 $59
    mB_5                                               ;; 0e:5bc8 $5b
    mCisPlus_8                                         ;; 0e:5bc9 $8d
    mA_8                                               ;; 0e:5bca $89
    mB_8                                               ;; 0e:5bcb $8b
    mCisPlus_8                                         ;; 0e:5bcc $8d
    mSTEREOPAN $01                                     ;; 0e:5bcd $e6 $01
    mCPlus_10                                          ;; 0e:5bcf $ac
    mCisPlus_10                                        ;; 0e:5bd0 $ad
    mCPlus_10                                          ;; 0e:5bd1 $ac
    mAis_10                                            ;; 0e:5bd2 $aa
    mCPlus_10                                          ;; 0e:5bd3 $ac
    mRest_10                                           ;; 0e:5bd4 $af
    mSTEREOPAN $03                                     ;; 0e:5bd5 $e6 $03
    mCPlus_10                                          ;; 0e:5bd7 $ac
    mCisPlus_10                                        ;; 0e:5bd8 $ad
    mCPlus_10                                          ;; 0e:5bd9 $ac
    mAis_10                                            ;; 0e:5bda $aa
    mCPlus_10                                          ;; 0e:5bdb $ac
    mRest_10                                           ;; 0e:5bdc $af
    mSTEREOPAN $02                                     ;; 0e:5bdd $e6 $02
    mCPlus_10                                          ;; 0e:5bdf $ac
    mCisPlus_10                                        ;; 0e:5be0 $ad
    mCPlus_10                                          ;; 0e:5be1 $ac
    mAis_10                                            ;; 0e:5be2 $aa
    mCPlus_10                                          ;; 0e:5be3 $ac
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:5be4 $e0 $5b $7a
    mDUTYCYCLE $80                                     ;; 0e:5be7 $e5 $80
    mSTEREOPAN $03                                     ;; 0e:5be9 $e6 $03
    mCis_10                                            ;; 0e:5beb $a1
    mC_10                                              ;; 0e:5bec $a0
    mOCTAVE_MINUS_1                                    ;; 0e:5bed $dc
    mA_10                                              ;; 0e:5bee $a9
    mCPlus_10                                          ;; 0e:5bef $ac
    mCisPlus_10                                        ;; 0e:5bf0 $ad
    mCPlus_10                                          ;; 0e:5bf1 $ac
    mA_10                                              ;; 0e:5bf2 $a9
    mCPlus_10                                          ;; 0e:5bf3 $ac
    mCisPlus_10                                        ;; 0e:5bf4 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5bf5 $d8
    mDis_10                                            ;; 0e:5bf6 $a3
    mE_10                                              ;; 0e:5bf7 $a4
    mFis_10                                            ;; 0e:5bf8 $a6
    mGis_10                                            ;; 0e:5bf9 $a8
    mA_10                                              ;; 0e:5bfa $a9
    mB_10                                              ;; 0e:5bfb $ab
    mCOUNTER $02                                       ;; 0e:5bfc $e3 $02
.data_0e_5bfe:
    mSTEREOPAN $01                                     ;; 0e:5bfe $e6 $01
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:5c00 $e0 $59 $7a
    mDUTYCYCLE $40                                     ;; 0e:5c03 $e5 $40
    mCis_10                                            ;; 0e:5c05 $a1
    mRest_10                                           ;; 0e:5c06 $af
    mCis_10                                            ;; 0e:5c07 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5c08 $dc
    mB_10                                              ;; 0e:5c09 $ab
    mSTEREOPAN $02                                     ;; 0e:5c0a $e6 $02
    mCisPlus_10                                        ;; 0e:5c0c $ad
    mRest_10                                           ;; 0e:5c0d $af
    mCisPlus_10                                        ;; 0e:5c0e $ad
    mB_10                                              ;; 0e:5c0f $ab
    mSTEREOPAN $01                                     ;; 0e:5c10 $e6 $01
    mCisPlus_10                                        ;; 0e:5c12 $ad
    mRest_10                                           ;; 0e:5c13 $af
    mCisPlus_10                                        ;; 0e:5c14 $ad
    mB_10                                              ;; 0e:5c15 $ab
    mSTEREOPAN $02                                     ;; 0e:5c16 $e6 $02
    mCisPlus_10                                        ;; 0e:5c18 $ad
    mRest_10                                           ;; 0e:5c19 $af
    mCisPlus_10                                        ;; 0e:5c1a $ad
    mB_10                                              ;; 0e:5c1b $ab
    mSTEREOPAN $01                                     ;; 0e:5c1c $e6 $01
    mCisPlus_10                                        ;; 0e:5c1e $ad
    mRest_10                                           ;; 0e:5c1f $af
    mCisPlus_10                                        ;; 0e:5c20 $ad
    mB_10                                              ;; 0e:5c21 $ab
    mSTEREOPAN $02                                     ;; 0e:5c22 $e6 $02
    mCisPlus_10                                        ;; 0e:5c24 $ad
    mRest_10                                           ;; 0e:5c25 $af
    mCisPlus_10                                        ;; 0e:5c26 $ad
    mB_10                                              ;; 0e:5c27 $ab
    mSTEREOPAN $01                                     ;; 0e:5c28 $e6 $01
    mCisPlus_10                                        ;; 0e:5c2a $ad
    mRest_10                                           ;; 0e:5c2b $af
    mCisPlus_10                                        ;; 0e:5c2c $ad
    mB_10                                              ;; 0e:5c2d $ab
    mSTEREOPAN $02                                     ;; 0e:5c2e $e6 $02
    mCisPlus_10                                        ;; 0e:5c30 $ad
    mRest_10                                           ;; 0e:5c31 $af
    mCisPlus_10                                        ;; 0e:5c32 $ad
    mB_10                                              ;; 0e:5c33 $ab
    mSTEREOPAN $01                                     ;; 0e:5c34 $e6 $01
    mB_10                                              ;; 0e:5c36 $ab
    mRest_10                                           ;; 0e:5c37 $af
    mB_10                                              ;; 0e:5c38 $ab
    mCisPlus_10                                        ;; 0e:5c39 $ad
    mSTEREOPAN $02                                     ;; 0e:5c3a $e6 $02
    mB_10                                              ;; 0e:5c3c $ab
    mRest_10                                           ;; 0e:5c3d $af
    mB_10                                              ;; 0e:5c3e $ab
    mCisPlus_10                                        ;; 0e:5c3f $ad
    mSTEREOPAN $01                                     ;; 0e:5c40 $e6 $01
    mB_10                                              ;; 0e:5c42 $ab
    mRest_10                                           ;; 0e:5c43 $af
    mB_10                                              ;; 0e:5c44 $ab
    mCisPlus_10                                        ;; 0e:5c45 $ad
    mSTEREOPAN $02                                     ;; 0e:5c46 $e6 $02
    mB_10                                              ;; 0e:5c48 $ab
    mRest_10                                           ;; 0e:5c49 $af
    mB_10                                              ;; 0e:5c4a $ab
    mCisPlus_10                                        ;; 0e:5c4b $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5c4c $d8
    mSTEREOPAN $03                                     ;; 0e:5c4d $e6 $03
    mGis_5                                             ;; 0e:5c4f $58
    mFis_5                                             ;; 0e:5c50 $56
    mE_8                                               ;; 0e:5c51 $84
    mCis_8                                             ;; 0e:5c52 $81
    mFis_8                                             ;; 0e:5c53 $86
    mGis_8                                             ;; 0e:5c54 $88
    mJUMPIF $01, .data_0e_5cb5                         ;; 0e:5c55 $eb $01 $b5 $5c
    mSTEREOPAN $02                                     ;; 0e:5c59 $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:5c5b $dc
    mA_10                                              ;; 0e:5c5c $a9
    mB_10                                              ;; 0e:5c5d $ab
    mA_10                                              ;; 0e:5c5e $a9
    mGis_10                                            ;; 0e:5c5f $a8
    mA_10                                              ;; 0e:5c60 $a9
    mSTEREOPAN $03                                     ;; 0e:5c61 $e6 $03
    mRest_10                                           ;; 0e:5c63 $af
    mA_10                                              ;; 0e:5c64 $a9
    mB_10                                              ;; 0e:5c65 $ab
    mA_10                                              ;; 0e:5c66 $a9
    mGis_10                                            ;; 0e:5c67 $a8
    mA_10                                              ;; 0e:5c68 $a9
    mSTEREOPAN $01                                     ;; 0e:5c69 $e6 $01
    mRest_10                                           ;; 0e:5c6b $af
    mA_10                                              ;; 0e:5c6c $a9
    mB_10                                              ;; 0e:5c6d $ab
    mA_10                                              ;; 0e:5c6e $a9
    mGis_10                                            ;; 0e:5c6f $a8
    mSTEREOPAN $03                                     ;; 0e:5c70 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:5c72 $d8
    mDis_10                                            ;; 0e:5c73 $a3
    mE_10                                              ;; 0e:5c74 $a4
    mDis_10                                            ;; 0e:5c75 $a3
    mCis_10                                            ;; 0e:5c76 $a1
    mCis_10                                            ;; 0e:5c77 $a1
    mDis_10                                            ;; 0e:5c78 $a3
    mCis_10                                            ;; 0e:5c79 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5c7a $dc
    mB_10                                              ;; 0e:5c7b $ab
    mSTEREOPAN $02                                     ;; 0e:5c7c $e6 $02
    mOCTAVE_PLUS_1                                     ;; 0e:5c7e $d8
    mDis_6                                             ;; 0e:5c7f $63
    mSTEREOPAN $03                                     ;; 0e:5c80 $e6 $03
    mE_6                                               ;; 0e:5c82 $64
    mSTEREOPAN $01                                     ;; 0e:5c83 $e6 $01
    mFis_6                                             ;; 0e:5c85 $66
    mSTEREOPAN $02                                     ;; 0e:5c86 $e6 $02
    mCis_10                                            ;; 0e:5c88 $a1
    mDis_10                                            ;; 0e:5c89 $a3
    mCis_10                                            ;; 0e:5c8a $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5c8b $dc
    mB_10                                              ;; 0e:5c8c $ab
    mCisPlus_10                                        ;; 0e:5c8d $ad
    mSTEREOPAN $03                                     ;; 0e:5c8e $e6 $03
    mRest_10                                           ;; 0e:5c90 $af
    mCisPlus_10                                        ;; 0e:5c91 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5c92 $d8
    mDis_10                                            ;; 0e:5c93 $a3
    mCis_10                                            ;; 0e:5c94 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5c95 $dc
    mB_10                                              ;; 0e:5c96 $ab
    mCisPlus_10                                        ;; 0e:5c97 $ad
    mSTEREOPAN $01                                     ;; 0e:5c98 $e6 $01
    mRest_10                                           ;; 0e:5c9a $af
    mCisPlus_10                                        ;; 0e:5c9b $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5c9c $d8
    mDis_10                                            ;; 0e:5c9d $a3
    mCis_10                                            ;; 0e:5c9e $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5c9f $dc
    mB_10                                              ;; 0e:5ca0 $ab
    mSTEREOPAN $03                                     ;; 0e:5ca1 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:5ca3 $d8
    mFis_5                                             ;; 0e:5ca4 $56
    mE_5                                               ;; 0e:5ca5 $54
    mSTEREOPAN $02                                     ;; 0e:5ca6 $e6 $02
    mDis_8                                             ;; 0e:5ca8 $83
    mOCTAVE_MINUS_1                                    ;; 0e:5ca9 $dc
    mB_8                                               ;; 0e:5caa $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5cab $d8
    mSTEREOPAN $01                                     ;; 0e:5cac $e6 $01
    mFis_8                                             ;; 0e:5cae $86
    mOCTAVE_MINUS_1                                    ;; 0e:5caf $dc
    mB_8                                               ;; 0e:5cb0 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5cb1 $d8
    mREPEAT .data_0e_5bfe                              ;; 0e:5cb2 $e2 $fe $5b
.data_0e_5cb5:
    mSTEREOPAN $01                                     ;; 0e:5cb5 $e6 $01
    mRest_8                                            ;; 0e:5cb7 $8f
    mCis_8                                             ;; 0e:5cb8 $81
    mDis_8                                             ;; 0e:5cb9 $83
    mCis_8                                             ;; 0e:5cba $81
    mSTEREOPAN $02                                     ;; 0e:5cbb $e6 $02
    mRest_8                                            ;; 0e:5cbd $8f
    mDis_8                                             ;; 0e:5cbe $83
    mE_8                                               ;; 0e:5cbf $84
    mDis_8                                             ;; 0e:5cc0 $83
    mSTEREOPAN $01                                     ;; 0e:5cc1 $e6 $01
    mE_8                                               ;; 0e:5cc3 $84
    mDis_10                                            ;; 0e:5cc4 $a3
    mE_10                                              ;; 0e:5cc5 $a4
    mSTEREOPAN $03                                     ;; 0e:5cc6 $e6 $03
    mFis_8                                             ;; 0e:5cc8 $86
    mE_10                                              ;; 0e:5cc9 $a4
    mFis_10                                            ;; 0e:5cca $a6
    mSTEREOPAN $02                                     ;; 0e:5ccb $e6 $02
    mGis_8                                             ;; 0e:5ccd $88
    mFis_10                                            ;; 0e:5cce $a6
    mGis_10                                            ;; 0e:5ccf $a8
    mSTEREOPAN $03                                     ;; 0e:5cd0 $e6 $03
    mA_8                                               ;; 0e:5cd2 $89
    mGis_10                                            ;; 0e:5cd3 $a8
    mA_10                                              ;; 0e:5cd4 $a9
    mB_2                                               ;; 0e:5cd5 $2b
    mAis_5                                             ;; 0e:5cd6 $5a
    mG_8                                               ;; 0e:5cd7 $87
    mGis_10                                            ;; 0e:5cd8 $a8
    mAis_10                                            ;; 0e:5cd9 $aa
    mCPlus_8                                           ;; 0e:5cda $8c
    mRest_8                                            ;; 0e:5cdb $8f
    mC_4                                               ;; 0e:5cdc $40
    mSTEREOPAN $02                                     ;; 0e:5cdd $e6 $02
    mC_8                                               ;; 0e:5cdf $80
    mSTEREOPAN $03                                     ;; 0e:5ce0 $e6 $03
    mCis_8                                             ;; 0e:5ce2 $81
    mSTEREOPAN $01                                     ;; 0e:5ce3 $e6 $01
    mDis_8                                             ;; 0e:5ce5 $83
    mJUMP .data_0e_5b43                                ;; 0e:5ce6 $e1 $43 $5b

song0a_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:5ce9 $e4 $fe $79
    mWAVETABLE data_0e_7a95                            ;; 0e:5cec $e8 $95 $7a
    mVOLUME $20                                        ;; 0e:5cef $e0 $20
    mRest_8                                            ;; 0e:5cf1 $8f
.data_0e_5cf2:
    mCOUNTER $02                                       ;; 0e:5cf2 $e3 $02
.data_0e_5cf4:
    mSTEREOPAN $03                                     ;; 0e:5cf4 $e6 $03
    mOCTAVE_2                                          ;; 0e:5cf6 $d2
    mCis_8                                             ;; 0e:5cf7 $81
    mGis_10                                            ;; 0e:5cf8 $a8
    mRest_10                                           ;; 0e:5cf9 $af
    mCis_8                                             ;; 0e:5cfa $81
    mGis_10                                            ;; 0e:5cfb $a8
    mRest_10                                           ;; 0e:5cfc $af
    mCis_8                                             ;; 0e:5cfd $81
    mGis_10                                            ;; 0e:5cfe $a8
    mRest_10                                           ;; 0e:5cff $af
    mCis_8                                             ;; 0e:5d00 $81
    mGis_10                                            ;; 0e:5d01 $a8
    mRest_10                                           ;; 0e:5d02 $af
    mOCTAVE_MINUS_1                                    ;; 0e:5d03 $dc
    mA_8                                               ;; 0e:5d04 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5d05 $d8
    mE_10                                              ;; 0e:5d06 $a4
    mRest_10                                           ;; 0e:5d07 $af
    mOCTAVE_MINUS_1                                    ;; 0e:5d08 $dc
    mA_8                                               ;; 0e:5d09 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5d0a $d8
    mE_10                                              ;; 0e:5d0b $a4
    mRest_10                                           ;; 0e:5d0c $af
    mOCTAVE_MINUS_1                                    ;; 0e:5d0d $dc
    mB_8                                               ;; 0e:5d0e $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5d0f $d8
    mFis_10                                            ;; 0e:5d10 $a6
    mRest_10                                           ;; 0e:5d11 $af
    mOCTAVE_MINUS_1                                    ;; 0e:5d12 $dc
    mB_8                                               ;; 0e:5d13 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5d14 $d8
    mFis_10                                            ;; 0e:5d15 $a6
    mRest_10                                           ;; 0e:5d16 $af
    mJUMPIF $01, .data_0e_5d3a                         ;; 0e:5d17 $eb $01 $3a $5d
    mCis_8                                             ;; 0e:5d1b $81
    mRest_5                                            ;; 0e:5d1c $5f
    mSTEREOPAN $02                                     ;; 0e:5d1d $e6 $02
    mCis_8                                             ;; 0e:5d1f $81
    mOCTAVE_MINUS_1                                    ;; 0e:5d20 $dc
    mSTEREOPAN $03                                     ;; 0e:5d21 $e6 $03
    mB_8                                               ;; 0e:5d23 $8b
    mRest_5                                            ;; 0e:5d24 $5f
    mSTEREOPAN $01                                     ;; 0e:5d25 $e6 $01
    mB_8                                               ;; 0e:5d27 $8b
    mSTEREOPAN $03                                     ;; 0e:5d28 $e6 $03
    mA_8                                               ;; 0e:5d2a $89
    mRest_5                                            ;; 0e:5d2b $5f
    mSTEREOPAN $02                                     ;; 0e:5d2c $e6 $02
    mA_8                                               ;; 0e:5d2e $89
    mSTEREOPAN $03                                     ;; 0e:5d2f $e6 $03
    mGis_5                                             ;; 0e:5d31 $58
    mOCTAVE_PLUS_1                                     ;; 0e:5d32 $d8
    mGis_10                                            ;; 0e:5d33 $a8
    mRest_10                                           ;; 0e:5d34 $af
    mOCTAVE_MINUS_1                                    ;; 0e:5d35 $dc
    mGis_8                                             ;; 0e:5d36 $88
    mREPEAT .data_0e_5cf4                              ;; 0e:5d37 $e2 $f4 $5c
.data_0e_5d3a:
    mOCTAVE_MINUS_1                                    ;; 0e:5d3a $dc
    mFis_8                                             ;; 0e:5d3b $86
    mSTEREOPAN $01                                     ;; 0e:5d3c $e6 $01
    mCisPlus_10                                        ;; 0e:5d3e $ad
    mRest_10                                           ;; 0e:5d3f $af
    mSTEREOPAN $03                                     ;; 0e:5d40 $e6 $03
    mFis_8                                             ;; 0e:5d42 $86
    mSTEREOPAN $02                                     ;; 0e:5d43 $e6 $02
    mCisPlus_10                                        ;; 0e:5d45 $ad
    mRest_10                                           ;; 0e:5d46 $af
    mSTEREOPAN $03                                     ;; 0e:5d47 $e6 $03
    mB_8                                               ;; 0e:5d49 $8b
    mSTEREOPAN $01                                     ;; 0e:5d4a $e6 $01
    mOCTAVE_PLUS_1                                     ;; 0e:5d4c $d8
    mFis_10                                            ;; 0e:5d4d $a6
    mRest_10                                           ;; 0e:5d4e $af
    mSTEREOPAN $03                                     ;; 0e:5d4f $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5d51 $dc
    mB_8                                               ;; 0e:5d52 $8b
    mSTEREOPAN $02                                     ;; 0e:5d53 $e6 $02
    mOCTAVE_PLUS_1                                     ;; 0e:5d55 $d8
    mFis_10                                            ;; 0e:5d56 $a6
    mRest_10                                           ;; 0e:5d57 $af
    mSTEREOPAN $01                                     ;; 0e:5d58 $e6 $01
    mE_5                                               ;; 0e:5d5a $54
    mSTEREOPAN $02                                     ;; 0e:5d5b $e6 $02
    mDis_5                                             ;; 0e:5d5d $53
    mSTEREOPAN $01                                     ;; 0e:5d5e $e6 $01
    mD_5                                               ;; 0e:5d60 $52
    mSTEREOPAN $02                                     ;; 0e:5d61 $e6 $02
    mCis_5                                             ;; 0e:5d63 $51
    mSTEREOPAN $03                                     ;; 0e:5d64 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5d66 $dc
    mA_1                                               ;; 0e:5d67 $19
    mWait_8                                            ;; 0e:5d68 $8e
    mRest_8                                            ;; 0e:5d69 $8f
    mFis_1                                             ;; 0e:5d6a $16
    mWait_8                                            ;; 0e:5d6b $8e
    mRest_8                                            ;; 0e:5d6c $8f
    mSTEREOPAN $01                                     ;; 0e:5d6d $e6 $01
    mGis_8                                             ;; 0e:5d6f $88
    mRest_5                                            ;; 0e:5d70 $5f
    mSTEREOPAN $03                                     ;; 0e:5d71 $e6 $03
    mGis_8                                             ;; 0e:5d73 $88
    mRest_5                                            ;; 0e:5d74 $5f
    mSTEREOPAN $02                                     ;; 0e:5d75 $e6 $02
    mGis_8                                             ;; 0e:5d77 $88
    mRest_0                                            ;; 0e:5d78 $0f
    mRest_8                                            ;; 0e:5d79 $8f
    mCOUNTER $02                                       ;; 0e:5d7a $e3 $02
.data_0e_5d7c:
    mSTEREOPAN $03                                     ;; 0e:5d7c $e6 $03
    mA_8                                               ;; 0e:5d7e $89
    mOCTAVE_PLUS_1                                     ;; 0e:5d7f $d8
    mSTEREOPAN $01                                     ;; 0e:5d80 $e6 $01
    mE_10                                              ;; 0e:5d82 $a4
    mRest_10                                           ;; 0e:5d83 $af
    mSTEREOPAN $03                                     ;; 0e:5d84 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5d86 $dc
    mA_8                                               ;; 0e:5d87 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5d88 $d8
    mSTEREOPAN $02                                     ;; 0e:5d89 $e6 $02
    mE_10                                              ;; 0e:5d8b $a4
    mRest_10                                           ;; 0e:5d8c $af
    mOCTAVE_MINUS_1                                    ;; 0e:5d8d $dc
    mSTEREOPAN $03                                     ;; 0e:5d8e $e6 $03
    mA_8                                               ;; 0e:5d90 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5d91 $d8
    mSTEREOPAN $01                                     ;; 0e:5d92 $e6 $01
    mE_10                                              ;; 0e:5d94 $a4
    mRest_10                                           ;; 0e:5d95 $af
    mSTEREOPAN $03                                     ;; 0e:5d96 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5d98 $dc
    mA_8                                               ;; 0e:5d99 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5d9a $d8
    mSTEREOPAN $02                                     ;; 0e:5d9b $e6 $02
    mE_10                                              ;; 0e:5d9d $a4
    mRest_10                                           ;; 0e:5d9e $af
    mOCTAVE_MINUS_1                                    ;; 0e:5d9f $dc
    mSTEREOPAN $03                                     ;; 0e:5da0 $e6 $03
    mA_8                                               ;; 0e:5da2 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5da3 $d8
    mSTEREOPAN $01                                     ;; 0e:5da4 $e6 $01
    mE_10                                              ;; 0e:5da6 $a4
    mRest_10                                           ;; 0e:5da7 $af
    mSTEREOPAN $03                                     ;; 0e:5da8 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5daa $dc
    mA_8                                               ;; 0e:5dab $89
    mOCTAVE_PLUS_1                                     ;; 0e:5dac $d8
    mSTEREOPAN $02                                     ;; 0e:5dad $e6 $02
    mE_10                                              ;; 0e:5daf $a4
    mRest_10                                           ;; 0e:5db0 $af
    mOCTAVE_MINUS_1                                    ;; 0e:5db1 $dc
    mSTEREOPAN $03                                     ;; 0e:5db2 $e6 $03
    mA_8                                               ;; 0e:5db4 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5db5 $d8
    mSTEREOPAN $01                                     ;; 0e:5db6 $e6 $01
    mE_10                                              ;; 0e:5db8 $a4
    mRest_10                                           ;; 0e:5db9 $af
    mSTEREOPAN $03                                     ;; 0e:5dba $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5dbc $dc
    mA_8                                               ;; 0e:5dbd $89
    mOCTAVE_PLUS_1                                     ;; 0e:5dbe $d8
    mSTEREOPAN $02                                     ;; 0e:5dbf $e6 $02
    mE_10                                              ;; 0e:5dc1 $a4
    mRest_10                                           ;; 0e:5dc2 $af
    mOCTAVE_MINUS_1                                    ;; 0e:5dc3 $dc
    mSTEREOPAN $03                                     ;; 0e:5dc4 $e6 $03
    mGis_8                                             ;; 0e:5dc6 $88
    mSTEREOPAN $01                                     ;; 0e:5dc7 $e6 $01
    mOCTAVE_PLUS_1                                     ;; 0e:5dc9 $d8
    mDis_10                                            ;; 0e:5dca $a3
    mRest_10                                           ;; 0e:5dcb $af
    mSTEREOPAN $03                                     ;; 0e:5dcc $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5dce $dc
    mGis_8                                             ;; 0e:5dcf $88
    mSTEREOPAN $02                                     ;; 0e:5dd0 $e6 $02
    mOCTAVE_PLUS_1                                     ;; 0e:5dd2 $d8
    mDis_10                                            ;; 0e:5dd3 $a3
    mRest_10                                           ;; 0e:5dd4 $af
    mSTEREOPAN $03                                     ;; 0e:5dd5 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5dd7 $dc
    mGis_8                                             ;; 0e:5dd8 $88
    mSTEREOPAN $01                                     ;; 0e:5dd9 $e6 $01
    mOCTAVE_PLUS_1                                     ;; 0e:5ddb $d8
    mDis_10                                            ;; 0e:5ddc $a3
    mRest_10                                           ;; 0e:5ddd $af
    mSTEREOPAN $03                                     ;; 0e:5dde $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:5de0 $dc
    mGis_8                                             ;; 0e:5de1 $88
    mSTEREOPAN $02                                     ;; 0e:5de2 $e6 $02
    mOCTAVE_PLUS_1                                     ;; 0e:5de4 $d8
    mDis_10                                            ;; 0e:5de5 $a3
    mRest_10                                           ;; 0e:5de6 $af
    mCis_2                                             ;; 0e:5de7 $21
    mSTEREOPAN $01                                     ;; 0e:5de8 $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:5dea $dc
    mB_2                                               ;; 0e:5deb $2b
    mJUMPIF $01, .data_0e_5e23                         ;; 0e:5dec $eb $01 $23 $5e
    mSTEREOPAN $03                                     ;; 0e:5df0 $e6 $03
    mFis_8                                             ;; 0e:5df2 $86
    mRest_5                                            ;; 0e:5df3 $5f
    mFis_8                                             ;; 0e:5df4 $86
    mRest_5                                            ;; 0e:5df5 $5f
    mFis_10                                            ;; 0e:5df6 $a6
    mRest_10                                           ;; 0e:5df7 $af
    mFis_10                                            ;; 0e:5df8 $a6
    mRest_10                                           ;; 0e:5df9 $af
    mB_5                                               ;; 0e:5dfa $5b
    mA_5                                               ;; 0e:5dfb $59
    mSTEREOPAN $02                                     ;; 0e:5dfc $e6 $02
    mGis_6                                             ;; 0e:5dfe $68
    mSTEREOPAN $03                                     ;; 0e:5dff $e6 $03
    mA_6                                               ;; 0e:5e01 $69
    mSTEREOPAN $01                                     ;; 0e:5e02 $e6 $01
    mB_6                                               ;; 0e:5e04 $6b
    mSTEREOPAN $03                                     ;; 0e:5e05 $e6 $03
    mA_8                                               ;; 0e:5e07 $89
    mRest_5                                            ;; 0e:5e08 $5f
    mA_8                                               ;; 0e:5e09 $89
    mRest_5                                            ;; 0e:5e0a $5f
    mA_10                                              ;; 0e:5e0b $a9
    mRest_10                                           ;; 0e:5e0c $af
    mA_10                                              ;; 0e:5e0d $a9
    mRest_10                                           ;; 0e:5e0e $af
    mSTEREOPAN $02                                     ;; 0e:5e0f $e6 $02
    mB_5                                               ;; 0e:5e11 $5b
    mSTEREOPAN $01                                     ;; 0e:5e12 $e6 $01
    mA_5                                               ;; 0e:5e14 $59
    mSTEREOPAN $03                                     ;; 0e:5e15 $e6 $03
    mGis_8                                             ;; 0e:5e17 $88
    mOCTAVE_PLUS_1                                     ;; 0e:5e18 $d8
    mGis_10                                            ;; 0e:5e19 $a8
    mRest_10                                           ;; 0e:5e1a $af
    mDis_10                                            ;; 0e:5e1b $a3
    mRest_10                                           ;; 0e:5e1c $af
    mOCTAVE_MINUS_1                                    ;; 0e:5e1d $dc
    mGis_10                                            ;; 0e:5e1e $a8
    mRest_10                                           ;; 0e:5e1f $af
    mREPEAT .data_0e_5d7c                              ;; 0e:5e20 $e2 $7c $5d
.data_0e_5e23:
    mSTEREOPAN $03                                     ;; 0e:5e23 $e6 $03
    mFis_5                                             ;; 0e:5e25 $56
    mRest_8                                            ;; 0e:5e26 $8f
    mFis_10                                            ;; 0e:5e27 $a6
    mRest_10                                           ;; 0e:5e28 $af
    mGis_5                                             ;; 0e:5e29 $58
    mRest_8                                            ;; 0e:5e2a $8f
    mGis_10                                            ;; 0e:5e2b $a8
    mRest_10                                           ;; 0e:5e2c $af
    mA_5                                               ;; 0e:5e2d $59
    mB_5                                               ;; 0e:5e2e $5b
    mCisPlus_5                                         ;; 0e:5e2f $5d
    mOCTAVE_PLUS_1                                     ;; 0e:5e30 $d8
    mDis_5                                             ;; 0e:5e31 $53
    mSTEREOPAN $02                                     ;; 0e:5e32 $e6 $02
    mE_2                                               ;; 0e:5e34 $24
    mSTEREOPAN $01                                     ;; 0e:5e35 $e6 $01
    mDis_2                                             ;; 0e:5e37 $23
    mSTEREOPAN $03                                     ;; 0e:5e38 $e6 $03
    mGis_10                                            ;; 0e:5e3a $a8
    mRest_7                                            ;; 0e:5e3b $7f
    mOCTAVE_MINUS_1                                    ;; 0e:5e3c $dc
    mGis_5                                             ;; 0e:5e3d $58
    mRest_8                                            ;; 0e:5e3e $8f
    mSTEREOPAN $02                                     ;; 0e:5e3f $e6 $02
    mGis_10                                            ;; 0e:5e41 $a8
    mRest_10                                           ;; 0e:5e42 $af
    mSTEREOPAN $03                                     ;; 0e:5e43 $e6 $03
    mAis_8                                             ;; 0e:5e45 $8a
    mSTEREOPAN $01                                     ;; 0e:5e46 $e6 $01
    mCPlus_10                                          ;; 0e:5e48 $ac
    mRest_10                                           ;; 0e:5e49 $af
    mJUMP .data_0e_5cf2                                ;; 0e:5e4a $e1 $f2 $5c

song10_channel2:
    mTEMPO $91                                         ;; 0e:5e4d $e7 $91
    mVIBRATO frequencyDeltaData                        ;; 0e:5e4f $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:5e52 $e0 $53 $7a
.data_0e_5e55:
    mTEMPO $91                                         ;; 0e:5e55 $e7 $91
    mDUTYCYCLE $40                                     ;; 0e:5e57 $e5 $40
    mSTEREOPAN $03                                     ;; 0e:5e59 $e6 $03
    mOCTAVE_2                                          ;; 0e:5e5b $d2
    mCis_8                                             ;; 0e:5e5c $81
    mOCTAVE_MINUS_1                                    ;; 0e:5e5d $dc
    mFis_8                                             ;; 0e:5e5e $86
    mA_8                                               ;; 0e:5e5f $89
    mOCTAVE_PLUS_1                                     ;; 0e:5e60 $d8
    mE_8                                               ;; 0e:5e61 $84
    mDis_8                                             ;; 0e:5e62 $83
    mOCTAVE_MINUS_1                                    ;; 0e:5e63 $dc
    mB_8                                               ;; 0e:5e64 $8b
    mRest_8                                            ;; 0e:5e65 $8f
    mB_8                                               ;; 0e:5e66 $8b
    mCisPlus_8                                         ;; 0e:5e67 $8d
    mFis_8                                             ;; 0e:5e68 $86
    mOCTAVE_PLUS_1                                     ;; 0e:5e69 $d8
    mE_8                                               ;; 0e:5e6a $84
    mDis_8                                             ;; 0e:5e6b $83
    mRest_8                                            ;; 0e:5e6c $8f
    mDUTYCYCLE $80                                     ;; 0e:5e6d $e5 $80
    mCisPlus_10                                        ;; 0e:5e6f $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5e70 $d8
    mD_10                                              ;; 0e:5e71 $a2
    mCis_10                                            ;; 0e:5e72 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5e73 $dc
    mB_10                                              ;; 0e:5e74 $ab
    mA_10                                              ;; 0e:5e75 $a9
    mGis_10                                            ;; 0e:5e76 $a8
    mDUTYCYCLE $40                                     ;; 0e:5e77 $e5 $40
    mCis_8                                             ;; 0e:5e79 $81
    mOCTAVE_MINUS_1                                    ;; 0e:5e7a $dc
    mFis_8                                             ;; 0e:5e7b $86
    mA_8                                               ;; 0e:5e7c $89
    mOCTAVE_PLUS_1                                     ;; 0e:5e7d $d8
    mE_8                                               ;; 0e:5e7e $84
    mDis_8                                             ;; 0e:5e7f $83
    mOCTAVE_MINUS_1                                    ;; 0e:5e80 $dc
    mB_8                                               ;; 0e:5e81 $8b
    mRest_8                                            ;; 0e:5e82 $8f
    mB_8                                               ;; 0e:5e83 $8b
    mCisPlus_8                                         ;; 0e:5e84 $8d
    mFis_8                                             ;; 0e:5e85 $86
    mOCTAVE_PLUS_1                                     ;; 0e:5e86 $d8
    mE_8                                               ;; 0e:5e87 $84
    mDis_8                                             ;; 0e:5e88 $83
    mRest_8                                            ;; 0e:5e89 $8f
    mDUTYCYCLE $80                                     ;; 0e:5e8a $e5 $80
    mOCTAVE_MINUS_1                                    ;; 0e:5e8c $dc
    mGis_10                                            ;; 0e:5e8d $a8
    mA_10                                              ;; 0e:5e8e $a9
    mB_10                                              ;; 0e:5e8f $ab
    mCisPlus_10                                        ;; 0e:5e90 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5e91 $d8
    mD_10                                              ;; 0e:5e92 $a2
    mE_10                                              ;; 0e:5e93 $a4
    mVOLUME_ENVELOPE data_0e_7a69                      ;; 0e:5e94 $e0 $69 $7a
    mDUTYCYCLE $00                                     ;; 0e:5e97 $e5 $00
    mFis_4                                             ;; 0e:5e99 $46
    mE_10                                              ;; 0e:5e9a $a4
    mFis_10                                            ;; 0e:5e9b $a6
    mGis_4                                             ;; 0e:5e9c $48
    mFis_10                                            ;; 0e:5e9d $a6
    mGis_10                                            ;; 0e:5e9e $a8
    mA_4                                               ;; 0e:5e9f $49
    mGis_10                                            ;; 0e:5ea0 $a8
    mFis_10                                            ;; 0e:5ea1 $a6
    mGis_5                                             ;; 0e:5ea2 $58
    mE_5                                               ;; 0e:5ea3 $54
    mDUTYCYCLE $40                                     ;; 0e:5ea4 $e5 $40
    mA_8                                               ;; 0e:5ea6 $89
    mGis_8                                             ;; 0e:5ea7 $88
    mFis_8                                             ;; 0e:5ea8 $86
    mGis_8                                             ;; 0e:5ea9 $88
    mA_10                                              ;; 0e:5eaa $a9
    mRest_7                                            ;; 0e:5eab $7f
    mCisPlus_5                                         ;; 0e:5eac $5d
    mB_8                                               ;; 0e:5ead $8b
    mCisPlus_8                                         ;; 0e:5eae $8d
    mB_8                                               ;; 0e:5eaf $8b
    mA_8                                               ;; 0e:5eb0 $89
    mGis_10                                            ;; 0e:5eb1 $a8
    mRest_7                                            ;; 0e:5eb2 $7f
    mE_5                                               ;; 0e:5eb3 $54
    mA_8                                               ;; 0e:5eb4 $89
    mGis_8                                             ;; 0e:5eb5 $88
    mFis_1                                             ;; 0e:5eb6 $16
    mRest_10                                           ;; 0e:5eb7 $af
    mDUTYCYCLE $80                                     ;; 0e:5eb8 $e5 $80
    mB_10                                              ;; 0e:5eba $ab
    mA_10                                              ;; 0e:5ebb $a9
    mGis_10                                            ;; 0e:5ebc $a8
    mFis_10                                            ;; 0e:5ebd $a6
    mGis_10                                            ;; 0e:5ebe $a8
    mFis_10                                            ;; 0e:5ebf $a6
    mD_10                                              ;; 0e:5ec0 $a2
    mE_10                                              ;; 0e:5ec1 $a4
    mFis_10                                            ;; 0e:5ec2 $a6
    mGis_10                                            ;; 0e:5ec3 $a8
    mA_10                                              ;; 0e:5ec4 $a9
    mB_10                                              ;; 0e:5ec5 $ab
    mCisPlus_10                                        ;; 0e:5ec6 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5ec7 $d8
    mD_10                                              ;; 0e:5ec8 $a2
    mE_10                                              ;; 0e:5ec9 $a4
    mOCTAVE_MINUS_1                                    ;; 0e:5eca $dc
    mDUTYCYCLE $40                                     ;; 0e:5ecb $e5 $40
    mA_8                                               ;; 0e:5ecd $89
    mGis_8                                             ;; 0e:5ece $88
    mFis_8                                             ;; 0e:5ecf $86
    mGis_8                                             ;; 0e:5ed0 $88
    mA_10                                              ;; 0e:5ed1 $a9
    mRest_7                                            ;; 0e:5ed2 $7f
    mCisPlus_5                                         ;; 0e:5ed3 $5d
    mCPlus_5                                           ;; 0e:5ed4 $5c
    mCPlus_8                                           ;; 0e:5ed5 $8c
    mCisPlus_8                                         ;; 0e:5ed6 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5ed7 $d8
    mDis_10                                            ;; 0e:5ed8 $a3
    mRest_7                                            ;; 0e:5ed9 $7f
    mFis_5                                             ;; 0e:5eda $56
    mE_8                                               ;; 0e:5edb $84
    mDis_8                                             ;; 0e:5edc $83
    mE_1                                               ;; 0e:5edd $14
    mRest_10                                           ;; 0e:5ede $af
    mDUTYCYCLE $80                                     ;; 0e:5edf $e5 $80
    mOCTAVE_MINUS_1                                    ;; 0e:5ee1 $dc
    mFis_10                                            ;; 0e:5ee2 $a6
    mE_10                                              ;; 0e:5ee3 $a4
    mD_10                                              ;; 0e:5ee4 $a2
    mE_10                                              ;; 0e:5ee5 $a4
    mFis_10                                            ;; 0e:5ee6 $a6
    mE_10                                              ;; 0e:5ee7 $a4
    mD_10                                              ;; 0e:5ee8 $a2
    mCis_10                                            ;; 0e:5ee9 $a1
    mD_10                                              ;; 0e:5eea $a2
    mE_10                                              ;; 0e:5eeb $a4
    mFis_10                                            ;; 0e:5eec $a6
    mGis_10                                            ;; 0e:5eed $a8
    mA_10                                              ;; 0e:5eee $a9
    mB_10                                              ;; 0e:5eef $ab
    mCisPlus_10                                        ;; 0e:5ef0 $ad
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:5ef1 $e0 $53 $7a
    mDUTYCYCLE $40                                     ;; 0e:5ef4 $e5 $40
    mOCTAVE_PLUS_1                                     ;; 0e:5ef6 $d8
    mFis_5                                             ;; 0e:5ef7 $56
    mVOLUME_ENVELOPE data_0e_7a69                      ;; 0e:5ef8 $e0 $69 $7a
    mFis_8                                             ;; 0e:5efb $86
    mG_8                                               ;; 0e:5efc $87
    mFis_10                                            ;; 0e:5efd $a6
    mRest_7                                            ;; 0e:5efe $7f
    mE_5                                               ;; 0e:5eff $54
    mD_8                                               ;; 0e:5f00 $82
    mCis_8                                             ;; 0e:5f01 $81
    mD_5                                               ;; 0e:5f02 $52
    mOCTAVE_MINUS_1                                    ;; 0e:5f03 $dc
    mB_8                                               ;; 0e:5f04 $8b
    mCisPlus_8                                         ;; 0e:5f05 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5f06 $d8
    mD_8                                               ;; 0e:5f07 $82
    mFis_8                                             ;; 0e:5f08 $86
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:5f09 $e0 $53 $7a
    mE_5                                               ;; 0e:5f0c $54
    mVOLUME_ENVELOPE data_0e_7a69                      ;; 0e:5f0d $e0 $69 $7a
    mE_8                                               ;; 0e:5f10 $84
    mFis_8                                             ;; 0e:5f11 $86
    mE_10                                              ;; 0e:5f12 $a4
    mRest_7                                            ;; 0e:5f13 $7f
    mD_5                                               ;; 0e:5f14 $52
    mCis_8                                             ;; 0e:5f15 $81
    mOCTAVE_MINUS_1                                    ;; 0e:5f16 $dc
    mB_8                                               ;; 0e:5f17 $8b
    mCisPlus_5                                         ;; 0e:5f18 $5d
    mA_8                                               ;; 0e:5f19 $89
    mB_8                                               ;; 0e:5f1a $8b
    mCisPlus_8                                         ;; 0e:5f1b $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5f1c $d8
    mE_8                                               ;; 0e:5f1d $84
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:5f1e $e0 $53 $7a
    mD_5                                               ;; 0e:5f21 $52
    mVOLUME_ENVELOPE data_0e_7a69                      ;; 0e:5f22 $e0 $69 $7a
    mD_8                                               ;; 0e:5f25 $82
    mCis_8                                             ;; 0e:5f26 $81
    mOCTAVE_MINUS_1                                    ;; 0e:5f27 $dc
    mB_10                                              ;; 0e:5f28 $ab
    mRest_7                                            ;; 0e:5f29 $7f
    mA_5                                               ;; 0e:5f2a $59
    mTEMPO $90                                         ;; 0e:5f2b $e7 $90
    mGis_5                                             ;; 0e:5f2d $58
    mA_5                                               ;; 0e:5f2e $59
    mB_5                                               ;; 0e:5f2f $5b
    mGis_5                                             ;; 0e:5f30 $58
    mTEMPO $8f                                         ;; 0e:5f31 $e7 $8f
    mCisPlus_10                                        ;; 0e:5f33 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5f34 $d8
    mD_10                                              ;; 0e:5f35 $a2
    mE_10                                              ;; 0e:5f36 $a4
    mD_10                                              ;; 0e:5f37 $a2
    mCis_10                                            ;; 0e:5f38 $a1
    mRest_10                                           ;; 0e:5f39 $af
    mCis_10                                            ;; 0e:5f3a $a1
    mD_10                                              ;; 0e:5f3b $a2
    mE_10                                              ;; 0e:5f3c $a4
    mD_10                                              ;; 0e:5f3d $a2
    mCis_10                                            ;; 0e:5f3e $a1
    mRest_10                                           ;; 0e:5f3f $af
    mTEMPO $8c                                         ;; 0e:5f40 $e7 $8c
    mCis_10                                            ;; 0e:5f42 $a1
    mD_10                                              ;; 0e:5f43 $a2
    mE_10                                              ;; 0e:5f44 $a4
    mD_10                                              ;; 0e:5f45 $a2
    mCis_0                                             ;; 0e:5f46 $01
    mCOUNTER $02                                       ;; 0e:5f47 $e3 $02
.data_0e_5f49:
    mTEMPO $91                                         ;; 0e:5f49 $e7 $91
    mDUTYCYCLE $80                                     ;; 0e:5f4b $e5 $80
    mFis_10                                            ;; 0e:5f4d $a6
    mGis_10                                            ;; 0e:5f4e $a8
    mFis_10                                            ;; 0e:5f4f $a6
    mE_10                                              ;; 0e:5f50 $a4
    mD_10                                              ;; 0e:5f51 $a2
    mE_10                                              ;; 0e:5f52 $a4
    mD_10                                              ;; 0e:5f53 $a2
    mCis_10                                            ;; 0e:5f54 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5f55 $dc
    mB_10                                              ;; 0e:5f56 $ab
    mCisPlus_10                                        ;; 0e:5f57 $ad
    mB_10                                              ;; 0e:5f58 $ab
    mA_10                                              ;; 0e:5f59 $a9
    mB_10                                              ;; 0e:5f5a $ab
    mCisPlus_10                                        ;; 0e:5f5b $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5f5c $d8
    mD_10                                              ;; 0e:5f5d $a2
    mFis_10                                            ;; 0e:5f5e $a6
    mE_10                                              ;; 0e:5f5f $a4
    mFis_10                                            ;; 0e:5f60 $a6
    mE_10                                              ;; 0e:5f61 $a4
    mD_10                                              ;; 0e:5f62 $a2
    mCis_10                                            ;; 0e:5f63 $a1
    mD_10                                              ;; 0e:5f64 $a2
    mCis_10                                            ;; 0e:5f65 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:5f66 $dc
    mB_10                                              ;; 0e:5f67 $ab
    mA_10                                              ;; 0e:5f68 $a9
    mB_10                                              ;; 0e:5f69 $ab
    mA_10                                              ;; 0e:5f6a $a9
    mGis_10                                            ;; 0e:5f6b $a8
    mA_10                                              ;; 0e:5f6c $a9
    mB_10                                              ;; 0e:5f6d $ab
    mCisPlus_10                                        ;; 0e:5f6e $ad
    mA_10                                              ;; 0e:5f6f $a9
    mJUMPIF $01, .data_0e_5f89                         ;; 0e:5f70 $eb $01 $89 $5f
    mDUTYCYCLE $40                                     ;; 0e:5f74 $e5 $40
    mB_8                                               ;; 0e:5f76 $8b
    mCisPlus_8                                         ;; 0e:5f77 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:5f78 $d8
    mD_8                                               ;; 0e:5f79 $82
    mOCTAVE_MINUS_1                                    ;; 0e:5f7a $dc
    mB_8                                               ;; 0e:5f7b $8b
    mCisPlus_10                                        ;; 0e:5f7c $ad
    mRest_7                                            ;; 0e:5f7d $7f
    mOCTAVE_PLUS_1                                     ;; 0e:5f7e $d8
    mE_5                                               ;; 0e:5f7f $54
    mFis_4                                             ;; 0e:5f80 $46
    mGis_10                                            ;; 0e:5f81 $a8
    mFis_10                                            ;; 0e:5f82 $a6
    mF_10                                              ;; 0e:5f83 $a5
    mRest_7                                            ;; 0e:5f84 $7f
    mCis_5                                             ;; 0e:5f85 $51
    mREPEAT .data_0e_5f49                              ;; 0e:5f86 $e2 $49 $5f
.data_0e_5f89:
    mTEMPO $8e                                         ;; 0e:5f89 $e7 $8e
    mB_10                                              ;; 0e:5f8b $ab
    mCisPlus_10                                        ;; 0e:5f8c $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5f8d $d8
    mD_10                                              ;; 0e:5f8e $a2
    mOCTAVE_MINUS_1                                    ;; 0e:5f8f $dc
    mB_10                                              ;; 0e:5f90 $ab
    mCisPlus_10                                        ;; 0e:5f91 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5f92 $d8
    mD_10                                              ;; 0e:5f93 $a2
    mE_10                                              ;; 0e:5f94 $a4
    mCis_10                                            ;; 0e:5f95 $a1
    mD_10                                              ;; 0e:5f96 $a2
    mE_10                                              ;; 0e:5f97 $a4
    mFis_10                                            ;; 0e:5f98 $a6
    mD_10                                              ;; 0e:5f99 $a2
    mE_11                                              ;; 0e:5f9a $b4
    mFis_11                                            ;; 0e:5f9b $b6
    mGis_11                                            ;; 0e:5f9c $b8
    mA_11                                              ;; 0e:5f9d $b9
    mB_11                                              ;; 0e:5f9e $bb
    mCisPlus_11                                        ;; 0e:5f9f $bd
    mJUMP .data_0e_5e55                                ;; 0e:5fa0 $e1 $55 $5e

song10_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:5fa3 $e4 $fe $79
.data_0e_5fa6:
    mVOLUME_ENVELOPE data_0e_7a3f                      ;; 0e:5fa6 $e0 $3f $7a
    mDUTYCYCLE $40                                     ;; 0e:5fa9 $e5 $40
    mSTEREOPAN $03                                     ;; 0e:5fab $e6 $03
    mOCTAVE_2                                          ;; 0e:5fad $d2
    mRest_10                                           ;; 0e:5fae $af
    mCis_8                                             ;; 0e:5faf $81
    mOCTAVE_MINUS_1                                    ;; 0e:5fb0 $dc
    mFis_8                                             ;; 0e:5fb1 $86
    mA_8                                               ;; 0e:5fb2 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5fb3 $d8
    mE_8                                               ;; 0e:5fb4 $84
    mDis_8                                             ;; 0e:5fb5 $83
    mOCTAVE_MINUS_1                                    ;; 0e:5fb6 $dc
    mB_8                                               ;; 0e:5fb7 $8b
    mRest_8                                            ;; 0e:5fb8 $8f
    mB_8                                               ;; 0e:5fb9 $8b
    mCisPlus_8                                         ;; 0e:5fba $8d
    mFis_8                                             ;; 0e:5fbb $86
    mOCTAVE_PLUS_1                                     ;; 0e:5fbc $d8
    mE_8                                               ;; 0e:5fbd $84
    mDis_8                                             ;; 0e:5fbe $83
    mRest_10                                           ;; 0e:5fbf $af
    mDUTYCYCLE $00                                     ;; 0e:5fc0 $e5 $00
    mOCTAVE_2                                          ;; 0e:5fc2 $d2
    mA_10                                              ;; 0e:5fc3 $a9
    mB_10                                              ;; 0e:5fc4 $ab
    mA_10                                              ;; 0e:5fc5 $a9
    mGis_10                                            ;; 0e:5fc6 $a8
    mFis_10                                            ;; 0e:5fc7 $a6
    mE_10                                              ;; 0e:5fc8 $a4
    mDUTYCYCLE $40                                     ;; 0e:5fc9 $e5 $40
    mOCTAVE_2                                          ;; 0e:5fcb $d2
    mRest_10                                           ;; 0e:5fcc $af
    mCis_8                                             ;; 0e:5fcd $81
    mOCTAVE_MINUS_1                                    ;; 0e:5fce $dc
    mFis_8                                             ;; 0e:5fcf $86
    mA_8                                               ;; 0e:5fd0 $89
    mOCTAVE_PLUS_1                                     ;; 0e:5fd1 $d8
    mE_8                                               ;; 0e:5fd2 $84
    mDis_8                                             ;; 0e:5fd3 $83
    mOCTAVE_MINUS_1                                    ;; 0e:5fd4 $dc
    mB_8                                               ;; 0e:5fd5 $8b
    mRest_8                                            ;; 0e:5fd6 $8f
    mB_8                                               ;; 0e:5fd7 $8b
    mCisPlus_8                                         ;; 0e:5fd8 $8d
    mFis_8                                             ;; 0e:5fd9 $86
    mOCTAVE_PLUS_1                                     ;; 0e:5fda $d8
    mE_8                                               ;; 0e:5fdb $84
    mDis_8                                             ;; 0e:5fdc $83
    mRest_10                                           ;; 0e:5fdd $af
    mDUTYCYCLE $00                                     ;; 0e:5fde $e5 $00
    mOCTAVE_MINUS_1                                    ;; 0e:5fe0 $dc
    mE_10                                              ;; 0e:5fe1 $a4
    mFis_10                                            ;; 0e:5fe2 $a6
    mGis_10                                            ;; 0e:5fe3 $a8
    mA_10                                              ;; 0e:5fe4 $a9
    mB_10                                              ;; 0e:5fe5 $ab
    mCisPlus_10                                        ;; 0e:5fe6 $ad
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:5fe7 $e0 $57 $7a
    mSTEREOPAN $02                                     ;; 0e:5fea $e6 $02
    mRest_8                                            ;; 0e:5fec $8f
    mOCTAVE_PLUS_1                                     ;; 0e:5fed $d8
    mD_8                                               ;; 0e:5fee $82
    mOCTAVE_MINUS_1                                    ;; 0e:5fef $dc
    mA_8                                               ;; 0e:5ff0 $89
    mCisPlus_10                                        ;; 0e:5ff1 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:5ff2 $d8
    mD_10                                              ;; 0e:5ff3 $a2
    mSTEREOPAN $01                                     ;; 0e:5ff4 $e6 $01
    mRest_8                                            ;; 0e:5ff6 $8f
    mE_8                                               ;; 0e:5ff7 $84
    mOCTAVE_MINUS_1                                    ;; 0e:5ff8 $dc
    mB_8                                               ;; 0e:5ff9 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:5ffa $d8
    mD_10                                              ;; 0e:5ffb $a2
    mE_10                                              ;; 0e:5ffc $a4
    mSTEREOPAN $02                                     ;; 0e:5ffd $e6 $02
    mRest_8                                            ;; 0e:5fff $8f
    mFis_8                                             ;; 0e:6000 $86
    mD_8                                               ;; 0e:6001 $82
    mE_10                                              ;; 0e:6002 $a4
    mD_10                                              ;; 0e:6003 $a2
    mSTEREOPAN $01                                     ;; 0e:6004 $e6 $01
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:6006 $e0 $57 $7a
    mDUTYCYCLE $80                                     ;; 0e:6009 $e5 $80
    mE_10                                              ;; 0e:600b $a4
    mFis_10                                            ;; 0e:600c $a6
    mSTEREOPAN $02                                     ;; 0e:600d $e6 $02
    mE_10                                              ;; 0e:600f $a4
    mD_10                                              ;; 0e:6010 $a2
    mSTEREOPAN $01                                     ;; 0e:6011 $e6 $01
    mCis_10                                            ;; 0e:6013 $a1
    mD_10                                              ;; 0e:6014 $a2
    mSTEREOPAN $02                                     ;; 0e:6015 $e6 $02
    mCis_10                                            ;; 0e:6017 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:6018 $dc
    mB_10                                              ;; 0e:6019 $ab
    mVOLUME_ENVELOPE data_0e_7a43                      ;; 0e:601a $e0 $43 $7a
    mDUTYCYCLE $40                                     ;; 0e:601d $e5 $40
    mA_10                                              ;; 0e:601f $a9
    mRest_10                                           ;; 0e:6020 $af
    mA_10                                              ;; 0e:6021 $a9
    mGis_10                                            ;; 0e:6022 $a8
    mSTEREOPAN $01                                     ;; 0e:6023 $e6 $01
    mA_10                                              ;; 0e:6025 $a9
    mRest_10                                           ;; 0e:6026 $af
    mA_10                                              ;; 0e:6027 $a9
    mGis_10                                            ;; 0e:6028 $a8
    mSTEREOPAN $02                                     ;; 0e:6029 $e6 $02
    mA_10                                              ;; 0e:602b $a9
    mRest_10                                           ;; 0e:602c $af
    mA_10                                              ;; 0e:602d $a9
    mGis_10                                            ;; 0e:602e $a8
    mSTEREOPAN $01                                     ;; 0e:602f $e6 $01
    mA_10                                              ;; 0e:6031 $a9
    mRest_10                                           ;; 0e:6032 $af
    mA_10                                              ;; 0e:6033 $a9
    mGis_10                                            ;; 0e:6034 $a8
    mSTEREOPAN $02                                     ;; 0e:6035 $e6 $02
    mFis_10                                            ;; 0e:6037 $a6
    mRest_10                                           ;; 0e:6038 $af
    mFis_10                                            ;; 0e:6039 $a6
    mE_10                                              ;; 0e:603a $a4
    mSTEREOPAN $01                                     ;; 0e:603b $e6 $01
    mFis_10                                            ;; 0e:603d $a6
    mRest_10                                           ;; 0e:603e $af
    mFis_10                                            ;; 0e:603f $a6
    mE_10                                              ;; 0e:6040 $a4
    mSTEREOPAN $02                                     ;; 0e:6041 $e6 $02
    mGis_10                                            ;; 0e:6043 $a8
    mRest_10                                           ;; 0e:6044 $af
    mGis_10                                            ;; 0e:6045 $a8
    mFis_10                                            ;; 0e:6046 $a6
    mSTEREOPAN $01                                     ;; 0e:6047 $e6 $01
    mGis_10                                            ;; 0e:6049 $a8
    mRest_10                                           ;; 0e:604a $af
    mGis_10                                            ;; 0e:604b $a8
    mFis_10                                            ;; 0e:604c $a6
    mSTEREOPAN $03                                     ;; 0e:604d $e6 $03
    mCisPlus_10                                        ;; 0e:604f $ad
    mOCTAVE_PLUS_1                                     ;; 0e:6050 $d8
    mD_10                                              ;; 0e:6051 $a2
    mCis_10                                            ;; 0e:6052 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:6053 $dc
    mB_10                                              ;; 0e:6054 $ab
    mCisPlus_10                                        ;; 0e:6055 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:6056 $d8
    mD_10                                              ;; 0e:6057 $a2
    mCis_10                                            ;; 0e:6058 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:6059 $dc
    mB_10                                              ;; 0e:605a $ab
    mCisPlus_10                                        ;; 0e:605b $ad
    mOCTAVE_PLUS_1                                     ;; 0e:605c $d8
    mD_10                                              ;; 0e:605d $a2
    mCis_10                                            ;; 0e:605e $a1
    mOCTAVE_MINUS_1                                    ;; 0e:605f $dc
    mB_10                                              ;; 0e:6060 $ab
    mCisPlus_10                                        ;; 0e:6061 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:6062 $d8
    mD_10                                              ;; 0e:6063 $a2
    mCis_10                                            ;; 0e:6064 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:6065 $dc
    mB_10                                              ;; 0e:6066 $ab
    mCisPlus_10                                        ;; 0e:6067 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:6068 $d8
    mD_10                                              ;; 0e:6069 $a2
    mCis_10                                            ;; 0e:606a $a1
    mOCTAVE_MINUS_1                                    ;; 0e:606b $dc
    mB_10                                              ;; 0e:606c $ab
    mA_10                                              ;; 0e:606d $a9
    mB_10                                              ;; 0e:606e $ab
    mA_10                                              ;; 0e:606f $a9
    mFis_10                                            ;; 0e:6070 $a6
    mGis_10                                            ;; 0e:6071 $a8
    mA_10                                              ;; 0e:6072 $a9
    mB_10                                              ;; 0e:6073 $ab
    mCisPlus_10                                        ;; 0e:6074 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:6075 $d8
    mD_10                                              ;; 0e:6076 $a2
    mE_10                                              ;; 0e:6077 $a4
    mFis_10                                            ;; 0e:6078 $a6
    mGis_10                                            ;; 0e:6079 $a8
    mOCTAVE_MINUS_1                                    ;; 0e:607a $dc
    mSTEREOPAN $02                                     ;; 0e:607b $e6 $02
    mA_10                                              ;; 0e:607d $a9
    mRest_10                                           ;; 0e:607e $af
    mA_10                                              ;; 0e:607f $a9
    mGis_10                                            ;; 0e:6080 $a8
    mSTEREOPAN $01                                     ;; 0e:6081 $e6 $01
    mA_10                                              ;; 0e:6083 $a9
    mRest_10                                           ;; 0e:6084 $af
    mA_10                                              ;; 0e:6085 $a9
    mGis_10                                            ;; 0e:6086 $a8
    mSTEREOPAN $02                                     ;; 0e:6087 $e6 $02
    mA_10                                              ;; 0e:6089 $a9
    mRest_10                                           ;; 0e:608a $af
    mA_10                                              ;; 0e:608b $a9
    mGis_10                                            ;; 0e:608c $a8
    mSTEREOPAN $01                                     ;; 0e:608d $e6 $01
    mA_10                                              ;; 0e:608f $a9
    mRest_10                                           ;; 0e:6090 $af
    mA_10                                              ;; 0e:6091 $a9
    mGis_10                                            ;; 0e:6092 $a8
    mSTEREOPAN $02                                     ;; 0e:6093 $e6 $02
    mCPlus_10                                          ;; 0e:6095 $ac
    mRest_10                                           ;; 0e:6096 $af
    mCPlus_10                                          ;; 0e:6097 $ac
    mAis_10                                            ;; 0e:6098 $aa
    mSTEREOPAN $01                                     ;; 0e:6099 $e6 $01
    mCPlus_10                                          ;; 0e:609b $ac
    mRest_10                                           ;; 0e:609c $af
    mCPlus_10                                          ;; 0e:609d $ac
    mAis_10                                            ;; 0e:609e $aa
    mSTEREOPAN $02                                     ;; 0e:609f $e6 $02
    mCPlus_10                                          ;; 0e:60a1 $ac
    mRest_10                                           ;; 0e:60a2 $af
    mCPlus_10                                          ;; 0e:60a3 $ac
    mAis_10                                            ;; 0e:60a4 $aa
    mSTEREOPAN $01                                     ;; 0e:60a5 $e6 $01
    mCPlus_10                                          ;; 0e:60a7 $ac
    mRest_10                                           ;; 0e:60a8 $af
    mCPlus_10                                          ;; 0e:60a9 $ac
    mAis_10                                            ;; 0e:60aa $aa
    mOCTAVE_PLUS_1                                     ;; 0e:60ab $d8
    mSTEREOPAN $03                                     ;; 0e:60ac $e6 $03
    mGis_10                                            ;; 0e:60ae $a8
    mA_10                                              ;; 0e:60af $a9
    mGis_10                                            ;; 0e:60b0 $a8
    mFis_10                                            ;; 0e:60b1 $a6
    mGis_10                                            ;; 0e:60b2 $a8
    mA_10                                              ;; 0e:60b3 $a9
    mGis_10                                            ;; 0e:60b4 $a8
    mFis_10                                            ;; 0e:60b5 $a6
    mGis_10                                            ;; 0e:60b6 $a8
    mA_10                                              ;; 0e:60b7 $a9
    mGis_10                                            ;; 0e:60b8 $a8
    mFis_10                                            ;; 0e:60b9 $a6
    mGis_10                                            ;; 0e:60ba $a8
    mA_10                                              ;; 0e:60bb $a9
    mGis_10                                            ;; 0e:60bc $a8
    mFis_10                                            ;; 0e:60bd $a6
    mGis_10                                            ;; 0e:60be $a8
    mA_10                                              ;; 0e:60bf $a9
    mGis_10                                            ;; 0e:60c0 $a8
    mFis_10                                            ;; 0e:60c1 $a6
    mGis_10                                            ;; 0e:60c2 $a8
    mA_10                                              ;; 0e:60c3 $a9
    mGis_10                                            ;; 0e:60c4 $a8
    mFis_10                                            ;; 0e:60c5 $a6
    mE_10                                              ;; 0e:60c6 $a4
    mFis_10                                            ;; 0e:60c7 $a6
    mGis_10                                            ;; 0e:60c8 $a8
    mA_10                                              ;; 0e:60c9 $a9
    mB_10                                              ;; 0e:60ca $ab
    mCisPlus_10                                        ;; 0e:60cb $ad
    mOCTAVE_PLUS_1                                     ;; 0e:60cc $d8
    mD_10                                              ;; 0e:60cd $a2
    mE_10                                              ;; 0e:60ce $a4
    mOCTAVE_MINUS_1                                    ;; 0e:60cf $dc
    mSTEREOPAN $02                                     ;; 0e:60d0 $e6 $02
    mCis_10                                            ;; 0e:60d2 $a1
    mRest_10                                           ;; 0e:60d3 $af
    mCis_10                                            ;; 0e:60d4 $a1
    mD_10                                              ;; 0e:60d5 $a2
    mSTEREOPAN $01                                     ;; 0e:60d6 $e6 $01
    mCis_10                                            ;; 0e:60d8 $a1
    mRest_10                                           ;; 0e:60d9 $af
    mCis_10                                            ;; 0e:60da $a1
    mD_10                                              ;; 0e:60db $a2
    mSTEREOPAN $02                                     ;; 0e:60dc $e6 $02
    mCis_10                                            ;; 0e:60de $a1
    mRest_10                                           ;; 0e:60df $af
    mCis_10                                            ;; 0e:60e0 $a1
    mD_10                                              ;; 0e:60e1 $a2
    mSTEREOPAN $01                                     ;; 0e:60e2 $e6 $01
    mE_10                                              ;; 0e:60e4 $a4
    mD_10                                              ;; 0e:60e5 $a2
    mCis_10                                            ;; 0e:60e6 $a1
    mE_10                                              ;; 0e:60e7 $a4
    mSTEREOPAN $02                                     ;; 0e:60e8 $e6 $02
    mFis_10                                            ;; 0e:60ea $a6
    mRest_10                                           ;; 0e:60eb $af
    mFis_10                                            ;; 0e:60ec $a6
    mE_10                                              ;; 0e:60ed $a4
    mSTEREOPAN $01                                     ;; 0e:60ee $e6 $01
    mFis_10                                            ;; 0e:60f0 $a6
    mRest_10                                           ;; 0e:60f1 $af
    mFis_10                                            ;; 0e:60f2 $a6
    mE_10                                              ;; 0e:60f3 $a4
    mSTEREOPAN $02                                     ;; 0e:60f4 $e6 $02
    mFis_10                                            ;; 0e:60f6 $a6
    mRest_10                                           ;; 0e:60f7 $af
    mFis_10                                            ;; 0e:60f8 $a6
    mE_10                                              ;; 0e:60f9 $a4
    mSTEREOPAN $01                                     ;; 0e:60fa $e6 $01
    mFis_10                                            ;; 0e:60fc $a6
    mGis_10                                            ;; 0e:60fd $a8
    mA_10                                              ;; 0e:60fe $a9
    mD_10                                              ;; 0e:60ff $a2
    mSTEREOPAN $02                                     ;; 0e:6100 $e6 $02
    mGis_10                                            ;; 0e:6102 $a8
    mRest_10                                           ;; 0e:6103 $af
    mGis_10                                            ;; 0e:6104 $a8
    mFis_10                                            ;; 0e:6105 $a6
    mSTEREOPAN $01                                     ;; 0e:6106 $e6 $01
    mGis_10                                            ;; 0e:6108 $a8
    mRest_10                                           ;; 0e:6109 $af
    mGis_10                                            ;; 0e:610a $a8
    mFis_10                                            ;; 0e:610b $a6
    mSTEREOPAN $02                                     ;; 0e:610c $e6 $02
    mGis_10                                            ;; 0e:610e $a8
    mRest_10                                           ;; 0e:610f $af
    mGis_10                                            ;; 0e:6110 $a8
    mFis_10                                            ;; 0e:6111 $a6
    mSTEREOPAN $01                                     ;; 0e:6112 $e6 $01
    mGis_10                                            ;; 0e:6114 $a8
    mA_10                                              ;; 0e:6115 $a9
    mGis_10                                            ;; 0e:6116 $a8
    mFis_10                                            ;; 0e:6117 $a6
    mSTEREOPAN $02                                     ;; 0e:6118 $e6 $02
    mE_10                                              ;; 0e:611a $a4
    mRest_10                                           ;; 0e:611b $af
    mE_10                                              ;; 0e:611c $a4
    mD_10                                              ;; 0e:611d $a2
    mSTEREOPAN $01                                     ;; 0e:611e $e6 $01
    mE_10                                              ;; 0e:6120 $a4
    mRest_10                                           ;; 0e:6121 $af
    mE_10                                              ;; 0e:6122 $a4
    mD_10                                              ;; 0e:6123 $a2
    mSTEREOPAN $02                                     ;; 0e:6124 $e6 $02
    mE_10                                              ;; 0e:6126 $a4
    mRest_10                                           ;; 0e:6127 $af
    mE_10                                              ;; 0e:6128 $a4
    mD_10                                              ;; 0e:6129 $a2
    mSTEREOPAN $01                                     ;; 0e:612a $e6 $01
    mE_10                                              ;; 0e:612c $a4
    mGis_10                                            ;; 0e:612d $a8
    mA_10                                              ;; 0e:612e $a9
    mCis_10                                            ;; 0e:612f $a1
    mSTEREOPAN $03                                     ;; 0e:6130 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a6f                      ;; 0e:6132 $e0 $6f $7a
    mFis_10                                            ;; 0e:6135 $a6
    mGis_10                                            ;; 0e:6136 $a8
    mA_10                                              ;; 0e:6137 $a9
    mGis_10                                            ;; 0e:6138 $a8
    mFis_10                                            ;; 0e:6139 $a6
    mRest_10                                           ;; 0e:613a $af
    mA_4                                               ;; 0e:613b $49
    mFis_5                                             ;; 0e:613c $56
    mD_10                                              ;; 0e:613d $a2
    mE_10                                              ;; 0e:613e $a4
    mFis_10                                            ;; 0e:613f $a6
    mE_10                                              ;; 0e:6140 $a4
    mD_10                                              ;; 0e:6141 $a2
    mRest_10                                           ;; 0e:6142 $af
    mFis_4                                             ;; 0e:6143 $46
    mD_5                                               ;; 0e:6144 $52
    mGis_10                                            ;; 0e:6145 $a8
    mFis_10                                            ;; 0e:6146 $a6
    mGis_10                                            ;; 0e:6147 $a8
    mA_10                                              ;; 0e:6148 $a9
    mGis_10                                            ;; 0e:6149 $a8
    mRest_10                                           ;; 0e:614a $af
    mGis_10                                            ;; 0e:614b $a8
    mFis_10                                            ;; 0e:614c $a6
    mGis_10                                            ;; 0e:614d $a8
    mA_10                                              ;; 0e:614e $a9
    mGis_10                                            ;; 0e:614f $a8
    mRest_10                                           ;; 0e:6150 $af
    mGis_10                                            ;; 0e:6151 $a8
    mFis_10                                            ;; 0e:6152 $a6
    mGis_10                                            ;; 0e:6153 $a8
    mA_10                                              ;; 0e:6154 $a9
    mFis_5                                             ;; 0e:6155 $56
    mF_5                                               ;; 0e:6156 $55
    mFis_5                                             ;; 0e:6157 $56
    mGis_5                                             ;; 0e:6158 $58
    mOCTAVE_PLUS_1                                     ;; 0e:6159 $d8
    mCOUNTER $02                                       ;; 0e:615a $e3 $02
.data_0e_615c:
    mVOLUME_ENVELOPE data_0e_7a43                      ;; 0e:615c $e0 $43 $7a
    mSTEREOPAN $03                                     ;; 0e:615f $e6 $03
    mD_10                                              ;; 0e:6161 $a2
    mE_10                                              ;; 0e:6162 $a4
    mD_10                                              ;; 0e:6163 $a2
    mCis_10                                            ;; 0e:6164 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:6165 $dc
    mB_10                                              ;; 0e:6166 $ab
    mCisPlus_10                                        ;; 0e:6167 $ad
    mB_10                                              ;; 0e:6168 $ab
    mA_10                                              ;; 0e:6169 $a9
    mGis_10                                            ;; 0e:616a $a8
    mA_10                                              ;; 0e:616b $a9
    mGis_10                                            ;; 0e:616c $a8
    mFis_10                                            ;; 0e:616d $a6
    mGis_10                                            ;; 0e:616e $a8
    mA_10                                              ;; 0e:616f $a9
    mB_10                                              ;; 0e:6170 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6171 $d8
    mD_10                                              ;; 0e:6172 $a2
    mCis_10                                            ;; 0e:6173 $a1
    mD_10                                              ;; 0e:6174 $a2
    mCis_10                                            ;; 0e:6175 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:6176 $dc
    mB_10                                              ;; 0e:6177 $ab
    mA_10                                              ;; 0e:6178 $a9
    mB_10                                              ;; 0e:6179 $ab
    mA_10                                              ;; 0e:617a $a9
    mGis_10                                            ;; 0e:617b $a8
    mFis_10                                            ;; 0e:617c $a6
    mGis_10                                            ;; 0e:617d $a8
    mFis_10                                            ;; 0e:617e $a6
    mE_10                                              ;; 0e:617f $a4
    mFis_10                                            ;; 0e:6180 $a6
    mGis_10                                            ;; 0e:6181 $a8
    mA_10                                              ;; 0e:6182 $a9
    mFis_10                                            ;; 0e:6183 $a6
    mJUMPIF $01, .data_0e_61a6                         ;; 0e:6184 $eb $01 $a6 $61
    mSTEREOPAN $02                                     ;; 0e:6188 $e6 $02
    mRest_8                                            ;; 0e:618a $8f
    mFis_10                                            ;; 0e:618b $a6
    mE_10                                              ;; 0e:618c $a4
    mD_10                                              ;; 0e:618d $a2
    mRest_7                                            ;; 0e:618e $7f
    mSTEREOPAN $01                                     ;; 0e:618f $e6 $01
    mGis_8                                             ;; 0e:6191 $88
    mFis_8                                             ;; 0e:6192 $86
    mGis_8                                             ;; 0e:6193 $88
    mB_8                                               ;; 0e:6194 $8b
    mSTEREOPAN $02                                     ;; 0e:6195 $e6 $02
    mRest_8                                            ;; 0e:6197 $8f
    mA_10                                              ;; 0e:6198 $a9
    mGis_10                                            ;; 0e:6199 $a8
    mFis_10                                            ;; 0e:619a $a6
    mRest_7                                            ;; 0e:619b $7f
    mSTEREOPAN $01                                     ;; 0e:619c $e6 $01
    mGis_8                                             ;; 0e:619e $88
    mB_8                                               ;; 0e:619f $8b
    mF_8                                               ;; 0e:61a0 $85
    mGis_8                                             ;; 0e:61a1 $88
    mOCTAVE_PLUS_1                                     ;; 0e:61a2 $d8
    mREPEAT .data_0e_615c                              ;; 0e:61a3 $e2 $5c $61
.data_0e_61a6:
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:61a6 $e0 $5b $7a
    mDUTYCYCLE $80                                     ;; 0e:61a9 $e5 $80
    mFis_10                                            ;; 0e:61ab $a6
    mE_10                                              ;; 0e:61ac $a4
    mD_10                                              ;; 0e:61ad $a2
    mFis_10                                            ;; 0e:61ae $a6
    mGis_10                                            ;; 0e:61af $a8
    mFis_10                                            ;; 0e:61b0 $a6
    mE_10                                              ;; 0e:61b1 $a4
    mGis_10                                            ;; 0e:61b2 $a8
    mA_10                                              ;; 0e:61b3 $a9
    mGis_10                                            ;; 0e:61b4 $a8
    mFis_10                                            ;; 0e:61b5 $a6
    mA_10                                              ;; 0e:61b6 $a9
    mSTEREOPAN $02                                     ;; 0e:61b7 $e6 $02
    mB_11                                              ;; 0e:61b9 $bb
    mCisPlus_11                                        ;; 0e:61ba $bd
    mOCTAVE_PLUS_1                                     ;; 0e:61bb $d8
    mSTEREOPAN $03                                     ;; 0e:61bc $e6 $03
    mD_11                                              ;; 0e:61be $b2
    mE_11                                              ;; 0e:61bf $b4
    mSTEREOPAN $01                                     ;; 0e:61c0 $e6 $01
    mFis_11                                            ;; 0e:61c2 $b6
    mGis_11                                            ;; 0e:61c3 $b8
    mJUMP .data_0e_5fa6                                ;; 0e:61c4 $e1 $a6 $5f

song10_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:61c7 $e4 $fe $79
    mWAVETABLE data_0e_7aa5                            ;; 0e:61ca $e8 $a5 $7a
    mVOLUME $20                                        ;; 0e:61cd $e0 $20
.data_0e_61cf:
    mSTEREOPAN $02                                     ;; 0e:61cf $e6 $02
    mOCTAVE_1                                          ;; 0e:61d1 $d1
    mFis_10                                            ;; 0e:61d2 $a6
    mRest_10                                           ;; 0e:61d3 $af
    mFis_10                                            ;; 0e:61d4 $a6
    mRest_10                                           ;; 0e:61d5 $af
    mFis_10                                            ;; 0e:61d6 $a6
    mRest_10                                           ;; 0e:61d7 $af
    mFis_10                                            ;; 0e:61d8 $a6
    mRest_10                                           ;; 0e:61d9 $af
    mSTEREOPAN $01                                     ;; 0e:61da $e6 $01
    mB_10                                              ;; 0e:61dc $ab
    mRest_10                                           ;; 0e:61dd $af
    mB_10                                              ;; 0e:61de $ab
    mRest_10                                           ;; 0e:61df $af
    mB_10                                              ;; 0e:61e0 $ab
    mRest_10                                           ;; 0e:61e1 $af
    mB_10                                              ;; 0e:61e2 $ab
    mRest_10                                           ;; 0e:61e3 $af
    mSTEREOPAN $02                                     ;; 0e:61e4 $e6 $02
    mFis_10                                            ;; 0e:61e6 $a6
    mRest_10                                           ;; 0e:61e7 $af
    mFis_10                                            ;; 0e:61e8 $a6
    mRest_10                                           ;; 0e:61e9 $af
    mFis_10                                            ;; 0e:61ea $a6
    mRest_10                                           ;; 0e:61eb $af
    mB_10                                              ;; 0e:61ec $ab
    mRest_10                                           ;; 0e:61ed $af
    mRest_2                                            ;; 0e:61ee $2f
    mSTEREOPAN $01                                     ;; 0e:61ef $e6 $01
    mFis_10                                            ;; 0e:61f1 $a6
    mRest_10                                           ;; 0e:61f2 $af
    mFis_10                                            ;; 0e:61f3 $a6
    mRest_10                                           ;; 0e:61f4 $af
    mFis_10                                            ;; 0e:61f5 $a6
    mRest_10                                           ;; 0e:61f6 $af
    mFis_10                                            ;; 0e:61f7 $a6
    mRest_10                                           ;; 0e:61f8 $af
    mSTEREOPAN $02                                     ;; 0e:61f9 $e6 $02
    mB_10                                              ;; 0e:61fb $ab
    mRest_10                                           ;; 0e:61fc $af
    mB_10                                              ;; 0e:61fd $ab
    mRest_10                                           ;; 0e:61fe $af
    mB_10                                              ;; 0e:61ff $ab
    mRest_10                                           ;; 0e:6200 $af
    mB_10                                              ;; 0e:6201 $ab
    mRest_10                                           ;; 0e:6202 $af
    mSTEREOPAN $01                                     ;; 0e:6203 $e6 $01
    mFis_10                                            ;; 0e:6205 $a6
    mRest_10                                           ;; 0e:6206 $af
    mFis_10                                            ;; 0e:6207 $a6
    mRest_10                                           ;; 0e:6208 $af
    mFis_10                                            ;; 0e:6209 $a6
    mRest_10                                           ;; 0e:620a $af
    mB_10                                              ;; 0e:620b $ab
    mRest_10                                           ;; 0e:620c $af
    mRest_2                                            ;; 0e:620d $2f
    mOCTAVE_PLUS_1                                     ;; 0e:620e $d8
    mSTEREOPAN $03                                     ;; 0e:620f $e6 $03
    mD_2                                               ;; 0e:6211 $22
    mCis_2                                             ;; 0e:6212 $21
    mOCTAVE_MINUS_1                                    ;; 0e:6213 $dc
    mB_2                                               ;; 0e:6214 $2b
    mSTEREOPAN $01                                     ;; 0e:6215 $e6 $01
    mCisPlus_8                                         ;; 0e:6217 $8d
    mSTEREOPAN $02                                     ;; 0e:6218 $e6 $02
    mB_8                                               ;; 0e:621a $8b
    mSTEREOPAN $01                                     ;; 0e:621b $e6 $01
    mA_8                                               ;; 0e:621d $89
    mSTEREOPAN $02                                     ;; 0e:621e $e6 $02
    mGis_8                                             ;; 0e:6220 $88
    mSTEREOPAN $03                                     ;; 0e:6221 $e6 $03
    mFis_8                                             ;; 0e:6223 $86
    mOCTAVE_PLUS_1                                     ;; 0e:6224 $d8
    mFis_10                                            ;; 0e:6225 $a6
    mRest_10                                           ;; 0e:6226 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6227 $dc
    mFis_8                                             ;; 0e:6228 $86
    mOCTAVE_PLUS_1                                     ;; 0e:6229 $d8
    mFis_10                                            ;; 0e:622a $a6
    mRest_10                                           ;; 0e:622b $af
    mOCTAVE_MINUS_1                                    ;; 0e:622c $dc
    mFis_8                                             ;; 0e:622d $86
    mOCTAVE_PLUS_1                                     ;; 0e:622e $d8
    mFis_10                                            ;; 0e:622f $a6
    mRest_10                                           ;; 0e:6230 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6231 $dc
    mFis_8                                             ;; 0e:6232 $86
    mOCTAVE_PLUS_1                                     ;; 0e:6233 $d8
    mFis_10                                            ;; 0e:6234 $a6
    mRest_10                                           ;; 0e:6235 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6236 $dc
    mD_8                                               ;; 0e:6237 $82
    mOCTAVE_PLUS_1                                     ;; 0e:6238 $d8
    mD_10                                              ;; 0e:6239 $a2
    mRest_10                                           ;; 0e:623a $af
    mOCTAVE_MINUS_1                                    ;; 0e:623b $dc
    mD_8                                               ;; 0e:623c $82
    mOCTAVE_PLUS_1                                     ;; 0e:623d $d8
    mD_10                                              ;; 0e:623e $a2
    mRest_10                                           ;; 0e:623f $af
    mOCTAVE_MINUS_1                                    ;; 0e:6240 $dc
    mE_8                                               ;; 0e:6241 $84
    mOCTAVE_PLUS_1                                     ;; 0e:6242 $d8
    mE_10                                              ;; 0e:6243 $a4
    mRest_10                                           ;; 0e:6244 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6245 $dc
    mE_8                                               ;; 0e:6246 $84
    mOCTAVE_PLUS_1                                     ;; 0e:6247 $d8
    mE_10                                              ;; 0e:6248 $a4
    mRest_10                                           ;; 0e:6249 $af
    mOCTAVE_MINUS_1                                    ;; 0e:624a $dc
    mSTEREOPAN $02                                     ;; 0e:624b $e6 $02
    mFis_8                                             ;; 0e:624d $86
    mRest_5                                            ;; 0e:624e $5f
    mSTEREOPAN $01                                     ;; 0e:624f $e6 $01
    mFis_8                                             ;; 0e:6251 $86
    mSTEREOPAN $02                                     ;; 0e:6252 $e6 $02
    mE_8                                               ;; 0e:6254 $84
    mRest_5                                            ;; 0e:6255 $5f
    mSTEREOPAN $01                                     ;; 0e:6256 $e6 $01
    mE_8                                               ;; 0e:6258 $84
    mSTEREOPAN $02                                     ;; 0e:6259 $e6 $02
    mD_8                                               ;; 0e:625b $82
    mRest_5                                            ;; 0e:625c $5f
    mSTEREOPAN $01                                     ;; 0e:625d $e6 $01
    mD_8                                               ;; 0e:625f $82
    mSTEREOPAN $02                                     ;; 0e:6260 $e6 $02
    mE_8                                               ;; 0e:6262 $84
    mRest_5                                            ;; 0e:6263 $5f
    mSTEREOPAN $01                                     ;; 0e:6264 $e6 $01
    mE_8                                               ;; 0e:6266 $84
    mSTEREOPAN $03                                     ;; 0e:6267 $e6 $03
    mFis_8                                             ;; 0e:6269 $86
    mOCTAVE_PLUS_1                                     ;; 0e:626a $d8
    mFis_10                                            ;; 0e:626b $a6
    mRest_10                                           ;; 0e:626c $af
    mOCTAVE_MINUS_1                                    ;; 0e:626d $dc
    mFis_8                                             ;; 0e:626e $86
    mOCTAVE_PLUS_1                                     ;; 0e:626f $d8
    mFis_10                                            ;; 0e:6270 $a6
    mRest_10                                           ;; 0e:6271 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6272 $dc
    mFis_8                                             ;; 0e:6273 $86
    mOCTAVE_PLUS_1                                     ;; 0e:6274 $d8
    mFis_10                                            ;; 0e:6275 $a6
    mRest_10                                           ;; 0e:6276 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6277 $dc
    mFis_8                                             ;; 0e:6278 $86
    mOCTAVE_PLUS_1                                     ;; 0e:6279 $d8
    mFis_10                                            ;; 0e:627a $a6
    mRest_10                                           ;; 0e:627b $af
    mOCTAVE_MINUS_1                                    ;; 0e:627c $dc
    mGis_8                                             ;; 0e:627d $88
    mOCTAVE_PLUS_1                                     ;; 0e:627e $d8
    mGis_10                                            ;; 0e:627f $a8
    mRest_10                                           ;; 0e:6280 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6281 $dc
    mGis_8                                             ;; 0e:6282 $88
    mOCTAVE_PLUS_1                                     ;; 0e:6283 $d8
    mGis_10                                            ;; 0e:6284 $a8
    mRest_10                                           ;; 0e:6285 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6286 $dc
    mAis_8                                             ;; 0e:6287 $8a
    mOCTAVE_PLUS_1                                     ;; 0e:6288 $d8
    mAis_10                                            ;; 0e:6289 $aa
    mRest_10                                           ;; 0e:628a $af
    mC_8                                               ;; 0e:628b $80
    mCPlus_10                                          ;; 0e:628c $ac
    mRest_10                                           ;; 0e:628d $af
    mSTEREOPAN $02                                     ;; 0e:628e $e6 $02
    mCis_8                                             ;; 0e:6290 $81
    mRest_5                                            ;; 0e:6291 $5f
    mSTEREOPAN $01                                     ;; 0e:6292 $e6 $01
    mCis_8                                             ;; 0e:6294 $81
    mSTEREOPAN $02                                     ;; 0e:6295 $e6 $02
    mC_8                                               ;; 0e:6297 $80
    mRest_5                                            ;; 0e:6298 $5f
    mSTEREOPAN $01                                     ;; 0e:6299 $e6 $01
    mC_8                                               ;; 0e:629b $80
    mOCTAVE_MINUS_1                                    ;; 0e:629c $dc
    mSTEREOPAN $02                                     ;; 0e:629d $e6 $02
    mB_8                                               ;; 0e:629f $8b
    mRest_5                                            ;; 0e:62a0 $5f
    mSTEREOPAN $01                                     ;; 0e:62a1 $e6 $01
    mB_8                                               ;; 0e:62a3 $8b
    mSTEREOPAN $02                                     ;; 0e:62a4 $e6 $02
    mAis_8                                             ;; 0e:62a6 $8a
    mRest_5                                            ;; 0e:62a7 $5f
    mSTEREOPAN $01                                     ;; 0e:62a8 $e6 $01
    mAis_8                                             ;; 0e:62aa $8a
    mSTEREOPAN $03                                     ;; 0e:62ab $e6 $03
    mFis_8                                             ;; 0e:62ad $86
    mOCTAVE_PLUS_1                                     ;; 0e:62ae $d8
    mFis_10                                            ;; 0e:62af $a6
    mRest_10                                           ;; 0e:62b0 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62b1 $dc
    mFis_8                                             ;; 0e:62b2 $86
    mOCTAVE_PLUS_1                                     ;; 0e:62b3 $d8
    mFis_10                                            ;; 0e:62b4 $a6
    mRest_10                                           ;; 0e:62b5 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62b6 $dc
    mGis_8                                             ;; 0e:62b7 $88
    mOCTAVE_PLUS_1                                     ;; 0e:62b8 $d8
    mGis_10                                            ;; 0e:62b9 $a8
    mRest_10                                           ;; 0e:62ba $af
    mOCTAVE_MINUS_1                                    ;; 0e:62bb $dc
    mAis_8                                             ;; 0e:62bc $8a
    mOCTAVE_PLUS_1                                     ;; 0e:62bd $d8
    mAis_10                                            ;; 0e:62be $aa
    mRest_10                                           ;; 0e:62bf $af
    mOCTAVE_MINUS_1                                    ;; 0e:62c0 $dc
    mB_8                                               ;; 0e:62c1 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:62c2 $d8
    mB_10                                              ;; 0e:62c3 $ab
    mRest_10                                           ;; 0e:62c4 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62c5 $dc
    mB_8                                               ;; 0e:62c6 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:62c7 $d8
    mB_10                                              ;; 0e:62c8 $ab
    mRest_10                                           ;; 0e:62c9 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62ca $dc
    mB_8                                               ;; 0e:62cb $8b
    mOCTAVE_PLUS_1                                     ;; 0e:62cc $d8
    mB_10                                              ;; 0e:62cd $ab
    mRest_10                                           ;; 0e:62ce $af
    mOCTAVE_MINUS_1                                    ;; 0e:62cf $dc
    mB_8                                               ;; 0e:62d0 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:62d1 $d8
    mB_10                                              ;; 0e:62d2 $ab
    mRest_10                                           ;; 0e:62d3 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62d4 $dc
    mE_8                                               ;; 0e:62d5 $84
    mOCTAVE_PLUS_1                                     ;; 0e:62d6 $d8
    mE_10                                              ;; 0e:62d7 $a4
    mRest_10                                           ;; 0e:62d8 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62d9 $dc
    mE_8                                               ;; 0e:62da $84
    mOCTAVE_PLUS_1                                     ;; 0e:62db $d8
    mE_10                                              ;; 0e:62dc $a4
    mRest_10                                           ;; 0e:62dd $af
    mOCTAVE_MINUS_1                                    ;; 0e:62de $dc
    mFis_8                                             ;; 0e:62df $86
    mOCTAVE_PLUS_1                                     ;; 0e:62e0 $d8
    mFis_10                                            ;; 0e:62e1 $a6
    mRest_10                                           ;; 0e:62e2 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62e3 $dc
    mGis_8                                             ;; 0e:62e4 $88
    mOCTAVE_PLUS_1                                     ;; 0e:62e5 $d8
    mGis_10                                            ;; 0e:62e6 $a8
    mRest_10                                           ;; 0e:62e7 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62e8 $dc
    mA_8                                               ;; 0e:62e9 $89
    mOCTAVE_PLUS_1                                     ;; 0e:62ea $d8
    mA_10                                              ;; 0e:62eb $a9
    mRest_10                                           ;; 0e:62ec $af
    mOCTAVE_MINUS_1                                    ;; 0e:62ed $dc
    mA_8                                               ;; 0e:62ee $89
    mOCTAVE_PLUS_1                                     ;; 0e:62ef $d8
    mA_10                                              ;; 0e:62f0 $a9
    mRest_10                                           ;; 0e:62f1 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62f2 $dc
    mA_8                                               ;; 0e:62f3 $89
    mOCTAVE_PLUS_1                                     ;; 0e:62f4 $d8
    mA_10                                              ;; 0e:62f5 $a9
    mRest_10                                           ;; 0e:62f6 $af
    mOCTAVE_MINUS_1                                    ;; 0e:62f7 $dc
    mA_8                                               ;; 0e:62f8 $89
    mOCTAVE_PLUS_1                                     ;; 0e:62f9 $d8
    mA_10                                              ;; 0e:62fa $a9
    mRest_10                                           ;; 0e:62fb $af
    mOCTAVE_MINUS_1                                    ;; 0e:62fc $dc
    mSTEREOPAN $01                                     ;; 0e:62fd $e6 $01
    mD_4                                               ;; 0e:62ff $42
    mSTEREOPAN $02                                     ;; 0e:6300 $e6 $02
    mA_4                                               ;; 0e:6302 $49
    mSTEREOPAN $01                                     ;; 0e:6303 $e6 $01
    mD_5                                               ;; 0e:6305 $52
    mOCTAVE_MINUS_1                                    ;; 0e:6306 $dc
    mSTEREOPAN $02                                     ;; 0e:6307 $e6 $02
    mB_4                                               ;; 0e:6309 $4b
    mOCTAVE_PLUS_1                                     ;; 0e:630a $d8
    mSTEREOPAN $01                                     ;; 0e:630b $e6 $01
    mFis_4                                             ;; 0e:630d $46
    mOCTAVE_MINUS_1                                    ;; 0e:630e $dc
    mSTEREOPAN $02                                     ;; 0e:630f $e6 $02
    mB_5                                               ;; 0e:6311 $5b
    mSTEREOPAN $01                                     ;; 0e:6312 $e6 $01
    mCisPlus_8                                         ;; 0e:6314 $8d
    mRest_5                                            ;; 0e:6315 $5f
    mSTEREOPAN $03                                     ;; 0e:6316 $e6 $03
    mCisPlus_8                                         ;; 0e:6318 $8d
    mRest_5                                            ;; 0e:6319 $5f
    mSTEREOPAN $02                                     ;; 0e:631a $e6 $02
    mCisPlus_8                                         ;; 0e:631c $8d
    mOCTAVE_PLUS_1                                     ;; 0e:631d $d8
    mGis_8                                             ;; 0e:631e $88
    mSTEREOPAN $01                                     ;; 0e:631f $e6 $01
    mCisPlus_5                                         ;; 0e:6321 $5d
    mSTEREOPAN $02                                     ;; 0e:6322 $e6 $02
    mB_5                                               ;; 0e:6324 $5b
    mSTEREOPAN $01                                     ;; 0e:6325 $e6 $01
    mA_5                                               ;; 0e:6327 $59
    mSTEREOPAN $02                                     ;; 0e:6328 $e6 $02
    mGis_5                                             ;; 0e:632a $58
    mOCTAVE_PLUS_1                                     ;; 0e:632b $d8
    mCOUNTER $02                                       ;; 0e:632c $e3 $02
.data_0e_632e:
    mSTEREOPAN $01                                     ;; 0e:632e $e6 $01
    mD_2                                               ;; 0e:6330 $22
    mSTEREOPAN $02                                     ;; 0e:6331 $e6 $02
    mE_2                                               ;; 0e:6333 $24
    mSTEREOPAN $01                                     ;; 0e:6334 $e6 $01
    mA_2                                               ;; 0e:6336 $29
    mSTEREOPAN $02                                     ;; 0e:6337 $e6 $02
    mD_2                                               ;; 0e:6339 $22
    mJUMPIF $01, .data_0e_6351                         ;; 0e:633a $eb $01 $51 $63
    mSTEREOPAN $03                                     ;; 0e:633e $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:6340 $dc
    mB_8                                               ;; 0e:6341 $8b
    mB_8                                               ;; 0e:6342 $8b
    mRest_8                                            ;; 0e:6343 $8f
    mB_8                                               ;; 0e:6344 $8b
    mCisPlus_5                                         ;; 0e:6345 $5d
    mCisPlus_5                                         ;; 0e:6346 $5d
    mOCTAVE_PLUS_1                                     ;; 0e:6347 $d8
    mD_8                                               ;; 0e:6348 $82
    mD_8                                               ;; 0e:6349 $82
    mRest_8                                            ;; 0e:634a $8f
    mD_8                                               ;; 0e:634b $82
    mCis_5                                             ;; 0e:634c $51
    mCis_5                                             ;; 0e:634d $51
    mREPEAT .data_0e_632e                              ;; 0e:634e $e2 $2e $63
.data_0e_6351:
    mSTEREOPAN $03                                     ;; 0e:6351 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:6353 $dc
    mB_5                                               ;; 0e:6354 $5b
    mCisPlus_5                                         ;; 0e:6355 $5d
    mOCTAVE_PLUS_1                                     ;; 0e:6356 $d8
    mD_5                                               ;; 0e:6357 $52
    mE_5                                               ;; 0e:6358 $54
    mJUMP .data_0e_61cf                                ;; 0e:6359 $e1 $cf $61

song11_channel2:
    mTEMPO $87                                         ;; 0e:635c $e7 $87
    mVIBRATO frequencyDeltaData                        ;; 0e:635e $e4 $fe $79
    mSTEREOPAN $03                                     ;; 0e:6361 $e6 $03
.data_0e_6363:
    mCOUNTER $02                                       ;; 0e:6363 $e3 $02
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6365 $e0 $53 $7a
    mDUTYCYCLE $00                                     ;; 0e:6368 $e5 $00
    mOCTAVE_2                                          ;; 0e:636a $d2
    mG_10                                              ;; 0e:636b $a7
    mB_10                                              ;; 0e:636c $ab
    mA_10                                              ;; 0e:636d $a9
    mB_10                                              ;; 0e:636e $ab
    mG_10                                              ;; 0e:636f $a7
    mB_10                                              ;; 0e:6370 $ab
    mA_10                                              ;; 0e:6371 $a9
    mB_10                                              ;; 0e:6372 $ab
    mA_10                                              ;; 0e:6373 $a9
    mCPlus_10                                          ;; 0e:6374 $ac
    mB_10                                              ;; 0e:6375 $ab
    mCPlus_10                                          ;; 0e:6376 $ac
    mA_10                                              ;; 0e:6377 $a9
    mCPlus_10                                          ;; 0e:6378 $ac
    mB_10                                              ;; 0e:6379 $ab
    mCPlus_10                                          ;; 0e:637a $ac
    mB_10                                              ;; 0e:637b $ab
    mOCTAVE_PLUS_1                                     ;; 0e:637c $d8
    mD_10                                              ;; 0e:637d $a2
    mC_10                                              ;; 0e:637e $a0
    mD_10                                              ;; 0e:637f $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6380 $dc
    mB_10                                              ;; 0e:6381 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6382 $d8
    mD_10                                              ;; 0e:6383 $a2
    mC_10                                              ;; 0e:6384 $a0
    mD_10                                              ;; 0e:6385 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6386 $dc
    mB_10                                              ;; 0e:6387 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6388 $d8
    mD_10                                              ;; 0e:6389 $a2
    mC_10                                              ;; 0e:638a $a0
    mD_10                                              ;; 0e:638b $a2
    mOCTAVE_MINUS_1                                    ;; 0e:638c $dc
    mB_10                                              ;; 0e:638d $ab
    mOCTAVE_PLUS_1                                     ;; 0e:638e $d8
    mD_10                                              ;; 0e:638f $a2
    mC_10                                              ;; 0e:6390 $a0
    mD_10                                              ;; 0e:6391 $a2
    mC_10                                              ;; 0e:6392 $a0
    mE_10                                              ;; 0e:6393 $a4
    mD_10                                              ;; 0e:6394 $a2
    mE_10                                              ;; 0e:6395 $a4
    mC_10                                              ;; 0e:6396 $a0
    mE_10                                              ;; 0e:6397 $a4
    mD_10                                              ;; 0e:6398 $a2
    mE_10                                              ;; 0e:6399 $a4
    mOCTAVE_MINUS_1                                    ;; 0e:639a $dc
    mA_10                                              ;; 0e:639b $a9
    mCPlus_10                                          ;; 0e:639c $ac
    mB_10                                              ;; 0e:639d $ab
    mCPlus_10                                          ;; 0e:639e $ac
    mA_10                                              ;; 0e:639f $a9
    mCPlus_10                                          ;; 0e:63a0 $ac
    mB_10                                              ;; 0e:63a1 $ab
    mCPlus_10                                          ;; 0e:63a2 $ac
    mA_2                                               ;; 0e:63a3 $29
    mWait_8                                            ;; 0e:63a4 $8e
    mOCTAVE_PLUS_1                                     ;; 0e:63a5 $d8
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:63a6 $e0 $31 $7a
    mDUTYCYCLE $40                                     ;; 0e:63a9 $e5 $40
    mSTEREOPAN $02                                     ;; 0e:63ab $e6 $02
    mE_8                                               ;; 0e:63ad $84
    mSTEREOPAN $03                                     ;; 0e:63ae $e6 $03
    mDis_8                                             ;; 0e:63b0 $83
    mOCTAVE_MINUS_1                                    ;; 0e:63b1 $dc
    mSTEREOPAN $01                                     ;; 0e:63b2 $e6 $01
    mB_8                                               ;; 0e:63b4 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:63b5 $d8
.data_0e_63b6:
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:63b6 $e0 $57 $7a
    mSTEREOPAN $03                                     ;; 0e:63b9 $e6 $03
    mE_4                                               ;; 0e:63bb $44
    mOCTAVE_MINUS_1                                    ;; 0e:63bc $dc
    mB_5                                               ;; 0e:63bd $5b
    mOCTAVE_PLUS_1                                     ;; 0e:63be $d8
    mE_8                                               ;; 0e:63bf $84
    mFis_8                                             ;; 0e:63c0 $86
    mG_8                                               ;; 0e:63c1 $87
    mA_8                                               ;; 0e:63c2 $89
    mG_10                                              ;; 0e:63c3 $a7
    mA_10                                              ;; 0e:63c4 $a9
    mG_8                                               ;; 0e:63c5 $87
    mFis_10                                            ;; 0e:63c6 $a6
    mG_10                                              ;; 0e:63c7 $a7
    mFis_8                                             ;; 0e:63c8 $86
    mE_10                                              ;; 0e:63c9 $a4
    mFis_10                                            ;; 0e:63ca $a6
    mE_8                                               ;; 0e:63cb $84
    mD_10                                              ;; 0e:63cc $a2
    mE_10                                              ;; 0e:63cd $a4
    mD_4                                               ;; 0e:63ce $42
    mC_10                                              ;; 0e:63cf $a0
    mOCTAVE_MINUS_1                                    ;; 0e:63d0 $dc
    mB_10                                              ;; 0e:63d1 $ab
    mA_2                                               ;; 0e:63d2 $29
    mVOLUME_ENVELOPE data_0e_7a36                      ;; 0e:63d3 $e0 $36 $7a
    mRest_8                                            ;; 0e:63d6 $8f
    mFis_8                                             ;; 0e:63d7 $86
    mG_8                                               ;; 0e:63d8 $87
    mA_8                                               ;; 0e:63d9 $89
    mG_8                                               ;; 0e:63da $87
    mFis_8                                             ;; 0e:63db $86
    mE_8                                               ;; 0e:63dc $84
    mD_8                                               ;; 0e:63dd $82
    mC_10                                              ;; 0e:63de $a0
    mD_10                                              ;; 0e:63df $a2
    mE_10                                              ;; 0e:63e0 $a4
    mD_10                                              ;; 0e:63e1 $a2
    mE_10                                              ;; 0e:63e2 $a4
    mFis_10                                            ;; 0e:63e3 $a6
    mG_10                                              ;; 0e:63e4 $a7
    mFis_10                                            ;; 0e:63e5 $a6
    mG_8                                               ;; 0e:63e6 $87
    mOCTAVE_PLUS_1                                     ;; 0e:63e7 $d8
    mE_8                                               ;; 0e:63e8 $84
    mD_8                                               ;; 0e:63e9 $82
    mOCTAVE_MINUS_1                                    ;; 0e:63ea $dc
    mB_8                                               ;; 0e:63eb $8b
    mA_10                                              ;; 0e:63ec $a9
    mB_10                                              ;; 0e:63ed $ab
    mCPlus_10                                          ;; 0e:63ee $ac
    mB_10                                              ;; 0e:63ef $ab
    mA_10                                              ;; 0e:63f0 $a9
    mG_10                                              ;; 0e:63f1 $a7
    mFis_10                                            ;; 0e:63f2 $a6
    mG_10                                              ;; 0e:63f3 $a7
    mA_8                                               ;; 0e:63f4 $89
    mG_10                                              ;; 0e:63f5 $a7
    mA_10                                              ;; 0e:63f6 $a9
    mB_8                                               ;; 0e:63f7 $8b
    mA_10                                              ;; 0e:63f8 $a9
    mB_10                                              ;; 0e:63f9 $ab
    mJUMPIF $01, .data_0e_6412                         ;; 0e:63fa $eb $01 $12 $64
    mCPlus_8                                           ;; 0e:63fe $8c
    mB_8                                               ;; 0e:63ff $8b
    mCPlus_8                                           ;; 0e:6400 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:6401 $d8
    mD_8                                               ;; 0e:6402 $82
    mE_8                                               ;; 0e:6403 $84
    mG_8                                               ;; 0e:6404 $87
    mFis_8                                             ;; 0e:6405 $86
    mE_8                                               ;; 0e:6406 $84
    mDis_8                                             ;; 0e:6407 $83
    mCis_8                                             ;; 0e:6408 $81
    mDis_8                                             ;; 0e:6409 $83
    mE_8                                               ;; 0e:640a $84
    mFis_8                                             ;; 0e:640b $86
    mA_8                                               ;; 0e:640c $89
    mG_8                                               ;; 0e:640d $87
    mFis_8                                             ;; 0e:640e $86
    mREPEAT .data_0e_63b6                              ;; 0e:640f $e2 $b6 $63
.data_0e_6412:
    mCPlus_8                                           ;; 0e:6412 $8c
    mB_8                                               ;; 0e:6413 $8b
    mCPlus_8                                           ;; 0e:6414 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:6415 $d8
    mD_8                                               ;; 0e:6416 $82
    mE_8                                               ;; 0e:6417 $84
    mG_8                                               ;; 0e:6418 $87
    mFis_8                                             ;; 0e:6419 $86
    mE_8                                               ;; 0e:641a $84
    mDis_5                                             ;; 0e:641b $53
    mOCTAVE_MINUS_1                                    ;; 0e:641c $dc
    mB_5                                               ;; 0e:641d $5b
    mOCTAVE_PLUS_1                                     ;; 0e:641e $d8
    mB_8                                               ;; 0e:641f $8b
    mA_8                                               ;; 0e:6420 $89
    mG_8                                               ;; 0e:6421 $87
    mFis_8                                             ;; 0e:6422 $86
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:6423 $e0 $31 $7a
    mDUTYCYCLE $40                                     ;; 0e:6426 $e5 $40
    mG_2                                               ;; 0e:6428 $27
    mRest_8                                            ;; 0e:6429 $8f
    mFis_10                                            ;; 0e:642a $a6
    mG_10                                              ;; 0e:642b $a7
    mA_10                                              ;; 0e:642c $a9
    mG_10                                              ;; 0e:642d $a7
    mFis_10                                            ;; 0e:642e $a6
    mE_10                                              ;; 0e:642f $a4
    mDis_5                                             ;; 0e:6430 $53
    mE_10                                              ;; 0e:6431 $a4
    mFis_10                                            ;; 0e:6432 $a6
    mG_10                                              ;; 0e:6433 $a7
    mA_10                                              ;; 0e:6434 $a9
    mB_2                                               ;; 0e:6435 $2b
    mJUMP .data_0e_6363                                ;; 0e:6436 $e1 $63 $63

song11_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:6439 $e4 $fe $79
.data_0e_643c:
    mCOUNTER $02                                       ;; 0e:643c $e3 $02
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:643e $e0 $57 $7a
    mDUTYCYCLE $00                                     ;; 0e:6441 $e5 $00
    mSTEREOPAN $03                                     ;; 0e:6443 $e6 $03
    mOCTAVE_2                                          ;; 0e:6445 $d2
    mE_10                                              ;; 0e:6446 $a4
    mG_10                                              ;; 0e:6447 $a7
    mFis_10                                            ;; 0e:6448 $a6
    mG_10                                              ;; 0e:6449 $a7
    mSTEREOPAN $02                                     ;; 0e:644a $e6 $02
    mE_10                                              ;; 0e:644c $a4
    mG_10                                              ;; 0e:644d $a7
    mFis_10                                            ;; 0e:644e $a6
    mG_10                                              ;; 0e:644f $a7
    mSTEREOPAN $03                                     ;; 0e:6450 $e6 $03
    mFis_10                                            ;; 0e:6452 $a6
    mA_10                                              ;; 0e:6453 $a9
    mG_10                                              ;; 0e:6454 $a7
    mA_10                                              ;; 0e:6455 $a9
    mSTEREOPAN $01                                     ;; 0e:6456 $e6 $01
    mFis_10                                            ;; 0e:6458 $a6
    mA_10                                              ;; 0e:6459 $a9
    mG_10                                              ;; 0e:645a $a7
    mA_10                                              ;; 0e:645b $a9
    mSTEREOPAN $03                                     ;; 0e:645c $e6 $03
    mG_10                                              ;; 0e:645e $a7
    mB_10                                              ;; 0e:645f $ab
    mA_10                                              ;; 0e:6460 $a9
    mB_10                                              ;; 0e:6461 $ab
    mSTEREOPAN $02                                     ;; 0e:6462 $e6 $02
    mG_10                                              ;; 0e:6464 $a7
    mB_10                                              ;; 0e:6465 $ab
    mA_10                                              ;; 0e:6466 $a9
    mB_10                                              ;; 0e:6467 $ab
    mSTEREOPAN $03                                     ;; 0e:6468 $e6 $03
    mGis_10                                            ;; 0e:646a $a8
    mB_10                                              ;; 0e:646b $ab
    mA_10                                              ;; 0e:646c $a9
    mB_10                                              ;; 0e:646d $ab
    mSTEREOPAN $01                                     ;; 0e:646e $e6 $01
    mGis_10                                            ;; 0e:6470 $a8
    mB_10                                              ;; 0e:6471 $ab
    mA_10                                              ;; 0e:6472 $a9
    mB_10                                              ;; 0e:6473 $ab
    mSTEREOPAN $03                                     ;; 0e:6474 $e6 $03
    mA_10                                              ;; 0e:6476 $a9
    mCPlus_10                                          ;; 0e:6477 $ac
    mB_10                                              ;; 0e:6478 $ab
    mCPlus_10                                          ;; 0e:6479 $ac
    mSTEREOPAN $02                                     ;; 0e:647a $e6 $02
    mA_10                                              ;; 0e:647c $a9
    mCPlus_10                                          ;; 0e:647d $ac
    mB_10                                              ;; 0e:647e $ab
    mCPlus_10                                          ;; 0e:647f $ac
    mSTEREOPAN $03                                     ;; 0e:6480 $e6 $03
    mFis_10                                            ;; 0e:6482 $a6
    mA_10                                              ;; 0e:6483 $a9
    mG_10                                              ;; 0e:6484 $a7
    mA_10                                              ;; 0e:6485 $a9
    mSTEREOPAN $01                                     ;; 0e:6486 $e6 $01
    mFis_10                                            ;; 0e:6488 $a6
    mA_10                                              ;; 0e:6489 $a9
    mG_10                                              ;; 0e:648a $a7
    mA_10                                              ;; 0e:648b $a9
    mVOLUME_ENVELOPE data_0e_7a43                      ;; 0e:648c $e0 $43 $7a
    mSTEREOPAN $03                                     ;; 0e:648f $e6 $03
    mFis_2                                             ;; 0e:6491 $26
    mWait_10                                           ;; 0e:6492 $ae
    mG_10                                              ;; 0e:6493 $a7
    mSTEREOPAN $02                                     ;; 0e:6494 $e6 $02
    mA_10                                              ;; 0e:6496 $a9
    mB_10                                              ;; 0e:6497 $ab
    mSTEREOPAN $03                                     ;; 0e:6498 $e6 $03
    mA_10                                              ;; 0e:649a $a9
    mG_10                                              ;; 0e:649b $a7
    mSTEREOPAN $01                                     ;; 0e:649c $e6 $01
    mFis_10                                            ;; 0e:649e $a6
    mDis_10                                            ;; 0e:649f $a3
    mOCTAVE_MINUS_1                                    ;; 0e:64a0 $dc
.data_0e_64a1:
    mDUTYCYCLE $40                                     ;; 0e:64a1 $e5 $40
    mSTEREOPAN $02                                     ;; 0e:64a3 $e6 $02
    mG_10                                              ;; 0e:64a5 $a7
    mA_10                                              ;; 0e:64a6 $a9
    mG_10                                              ;; 0e:64a7 $a7
    mFis_10                                            ;; 0e:64a8 $a6
    mG_10                                              ;; 0e:64a9 $a7
    mRest_10                                           ;; 0e:64aa $af
    mSTEREOPAN $03                                     ;; 0e:64ab $e6 $03
    mG_10                                              ;; 0e:64ad $a7
    mA_10                                              ;; 0e:64ae $a9
    mG_10                                              ;; 0e:64af $a7
    mFis_10                                            ;; 0e:64b0 $a6
    mG_10                                              ;; 0e:64b1 $a7
    mRest_10                                           ;; 0e:64b2 $af
    mSTEREOPAN $01                                     ;; 0e:64b3 $e6 $01
    mG_10                                              ;; 0e:64b5 $a7
    mA_10                                              ;; 0e:64b6 $a9
    mG_10                                              ;; 0e:64b7 $a7
    mFis_10                                            ;; 0e:64b8 $a6
    mSTEREOPAN $02                                     ;; 0e:64b9 $e6 $02
    mG_10                                              ;; 0e:64bb $a7
    mA_10                                              ;; 0e:64bc $a9
    mG_10                                              ;; 0e:64bd $a7
    mFis_10                                            ;; 0e:64be $a6
    mG_10                                              ;; 0e:64bf $a7
    mRest_10                                           ;; 0e:64c0 $af
    mSTEREOPAN $03                                     ;; 0e:64c1 $e6 $03
    mG_10                                              ;; 0e:64c3 $a7
    mA_10                                              ;; 0e:64c4 $a9
    mG_10                                              ;; 0e:64c5 $a7
    mFis_10                                            ;; 0e:64c6 $a6
    mG_10                                              ;; 0e:64c7 $a7
    mRest_10                                           ;; 0e:64c8 $af
    mSTEREOPAN $01                                     ;; 0e:64c9 $e6 $01
    mG_10                                              ;; 0e:64cb $a7
    mA_10                                              ;; 0e:64cc $a9
    mG_10                                              ;; 0e:64cd $a7
    mFis_10                                            ;; 0e:64ce $a6
    mSTEREOPAN $02                                     ;; 0e:64cf $e6 $02
    mRest_5                                            ;; 0e:64d1 $5f
    mFis_10                                            ;; 0e:64d2 $a6
    mG_10                                              ;; 0e:64d3 $a7
    mA_10                                              ;; 0e:64d4 $a9
    mG_10                                              ;; 0e:64d5 $a7
    mSTEREOPAN $01                                     ;; 0e:64d6 $e6 $01
    mRest_5                                            ;; 0e:64d8 $5f
    mFis_10                                            ;; 0e:64d9 $a6
    mG_10                                              ;; 0e:64da $a7
    mA_10                                              ;; 0e:64db $a9
    mG_10                                              ;; 0e:64dc $a7
    mSTEREOPAN $03                                     ;; 0e:64dd $e6 $03
    mB_8                                               ;; 0e:64df $8b
    mA_8                                               ;; 0e:64e0 $89
    mB_8                                               ;; 0e:64e1 $8b
    mCPlus_8                                           ;; 0e:64e2 $8c
    mB_8                                               ;; 0e:64e3 $8b
    mA_8                                               ;; 0e:64e4 $89
    mG_8                                               ;; 0e:64e5 $87
    mFis_8                                             ;; 0e:64e6 $86
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:64e7 $e0 $31 $7a
    mSTEREOPAN $01                                     ;; 0e:64ea $e6 $01
    mDUTYCYCLE $00                                     ;; 0e:64ec $e5 $00
    mSTEREOPAN $01                                     ;; 0e:64ee $e6 $01
    mE_10                                              ;; 0e:64f0 $a4
    mG_10                                              ;; 0e:64f1 $a7
    mFis_10                                            ;; 0e:64f2 $a6
    mG_10                                              ;; 0e:64f3 $a7
    mSTEREOPAN $02                                     ;; 0e:64f4 $e6 $02
    mE_10                                              ;; 0e:64f6 $a4
    mG_10                                              ;; 0e:64f7 $a7
    mFis_10                                            ;; 0e:64f8 $a6
    mG_10                                              ;; 0e:64f9 $a7
    mSTEREOPAN $01                                     ;; 0e:64fa $e6 $01
    mE_10                                              ;; 0e:64fc $a4
    mG_10                                              ;; 0e:64fd $a7
    mFis_10                                            ;; 0e:64fe $a6
    mG_10                                              ;; 0e:64ff $a7
    mSTEREOPAN $02                                     ;; 0e:6500 $e6 $02
    mE_10                                              ;; 0e:6502 $a4
    mG_10                                              ;; 0e:6503 $a7
    mFis_10                                            ;; 0e:6504 $a6
    mG_10                                              ;; 0e:6505 $a7
    mSTEREOPAN $01                                     ;; 0e:6506 $e6 $01
    mFis_10                                            ;; 0e:6508 $a6
    mA_10                                              ;; 0e:6509 $a9
    mG_10                                              ;; 0e:650a $a7
    mA_10                                              ;; 0e:650b $a9
    mSTEREOPAN $02                                     ;; 0e:650c $e6 $02
    mFis_10                                            ;; 0e:650e $a6
    mA_10                                              ;; 0e:650f $a9
    mG_10                                              ;; 0e:6510 $a7
    mA_10                                              ;; 0e:6511 $a9
    mSTEREOPAN $01                                     ;; 0e:6512 $e6 $01
    mFis_10                                            ;; 0e:6514 $a6
    mA_10                                              ;; 0e:6515 $a9
    mG_10                                              ;; 0e:6516 $a7
    mA_10                                              ;; 0e:6517 $a9
    mSTEREOPAN $02                                     ;; 0e:6518 $e6 $02
    mFis_10                                            ;; 0e:651a $a6
    mA_10                                              ;; 0e:651b $a9
    mG_10                                              ;; 0e:651c $a7
    mA_10                                              ;; 0e:651d $a9
    mJUMPIF $01, .data_0e_6547                         ;; 0e:651e $eb $01 $47 $65
    mSTEREOPAN $01                                     ;; 0e:6522 $e6 $01
    mG_10                                              ;; 0e:6524 $a7
    mB_10                                              ;; 0e:6525 $ab
    mA_10                                              ;; 0e:6526 $a9
    mB_10                                              ;; 0e:6527 $ab
    mSTEREOPAN $02                                     ;; 0e:6528 $e6 $02
    mG_10                                              ;; 0e:652a $a7
    mB_10                                              ;; 0e:652b $ab
    mA_10                                              ;; 0e:652c $a9
    mB_10                                              ;; 0e:652d $ab
    mSTEREOPAN $01                                     ;; 0e:652e $e6 $01
    mG_10                                              ;; 0e:6530 $a7
    mB_10                                              ;; 0e:6531 $ab
    mA_10                                              ;; 0e:6532 $a9
    mB_10                                              ;; 0e:6533 $ab
    mSTEREOPAN $02                                     ;; 0e:6534 $e6 $02
    mG_10                                              ;; 0e:6536 $a7
    mB_10                                              ;; 0e:6537 $ab
    mA_10                                              ;; 0e:6538 $a9
    mB_10                                              ;; 0e:6539 $ab
    mSTEREOPAN $03                                     ;; 0e:653a $e6 $03
    mB_8                                               ;; 0e:653c $8b
    mA_8                                               ;; 0e:653d $89
    mB_8                                               ;; 0e:653e $8b
    mCisPlus_8                                         ;; 0e:653f $8d
    mB_8                                               ;; 0e:6540 $8b
    mCisPlus_8                                         ;; 0e:6541 $8d
    mB_8                                               ;; 0e:6542 $8b
    mA_8                                               ;; 0e:6543 $89
    mREPEAT .data_0e_64a1                              ;; 0e:6544 $e2 $a1 $64
.data_0e_6547:
    mSTEREOPAN $01                                     ;; 0e:6547 $e6 $01
    mDUTYCYCLE $40                                     ;; 0e:6549 $e5 $40
    mG_10                                              ;; 0e:654b $a7
    mB_10                                              ;; 0e:654c $ab
    mA_10                                              ;; 0e:654d $a9
    mB_10                                              ;; 0e:654e $ab
    mSTEREOPAN $02                                     ;; 0e:654f $e6 $02
    mG_10                                              ;; 0e:6551 $a7
    mB_10                                              ;; 0e:6552 $ab
    mA_10                                              ;; 0e:6553 $a9
    mB_10                                              ;; 0e:6554 $ab
    mSTEREOPAN $01                                     ;; 0e:6555 $e6 $01
    mG_10                                              ;; 0e:6557 $a7
    mB_10                                              ;; 0e:6558 $ab
    mA_10                                              ;; 0e:6559 $a9
    mB_10                                              ;; 0e:655a $ab
    mSTEREOPAN $02                                     ;; 0e:655b $e6 $02
    mG_10                                              ;; 0e:655d $a7
    mB_10                                              ;; 0e:655e $ab
    mA_10                                              ;; 0e:655f $a9
    mB_10                                              ;; 0e:6560 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6561 $d8
    mSTEREOPAN $01                                     ;; 0e:6562 $e6 $01
    mDis_10                                            ;; 0e:6564 $a3
    mOCTAVE_MINUS_1                                    ;; 0e:6565 $dc
    mB_10                                              ;; 0e:6566 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6567 $d8
    mDis_10                                            ;; 0e:6568 $a3
    mOCTAVE_MINUS_1                                    ;; 0e:6569 $dc
    mB_10                                              ;; 0e:656a $ab
    mOCTAVE_PLUS_1                                     ;; 0e:656b $d8
    mSTEREOPAN $02                                     ;; 0e:656c $e6 $02
    mE_10                                              ;; 0e:656e $a4
    mOCTAVE_MINUS_1                                    ;; 0e:656f $dc
    mB_10                                              ;; 0e:6570 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6571 $d8
    mE_10                                              ;; 0e:6572 $a4
    mOCTAVE_MINUS_1                                    ;; 0e:6573 $dc
    mB_10                                              ;; 0e:6574 $ab
    mSTEREOPAN $01                                     ;; 0e:6575 $e6 $01
    mOCTAVE_PLUS_1                                     ;; 0e:6577 $d8
    mF_10                                              ;; 0e:6578 $a5
    mOCTAVE_MINUS_1                                    ;; 0e:6579 $dc
    mB_10                                              ;; 0e:657a $ab
    mOCTAVE_PLUS_1                                     ;; 0e:657b $d8
    mF_10                                              ;; 0e:657c $a5
    mOCTAVE_MINUS_1                                    ;; 0e:657d $dc
    mB_10                                              ;; 0e:657e $ab
    mOCTAVE_PLUS_1                                     ;; 0e:657f $d8
    mSTEREOPAN $02                                     ;; 0e:6580 $e6 $02
    mFis_10                                            ;; 0e:6582 $a6
    mOCTAVE_MINUS_1                                    ;; 0e:6583 $dc
    mB_10                                              ;; 0e:6584 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6585 $d8
    mFis_10                                            ;; 0e:6586 $a6
    mOCTAVE_MINUS_1                                    ;; 0e:6587 $dc
    mB_10                                              ;; 0e:6588 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6589 $d8
    mSTEREOPAN $01                                     ;; 0e:658a $e6 $01
    mE_10                                              ;; 0e:658c $a4
    mFis_10                                            ;; 0e:658d $a6
    mAis_10                                            ;; 0e:658e $aa
    mE_10                                              ;; 0e:658f $a4
    mSTEREOPAN $02                                     ;; 0e:6590 $e6 $02
    mFis_10                                            ;; 0e:6592 $a6
    mAis_10                                            ;; 0e:6593 $aa
    mE_10                                              ;; 0e:6594 $a4
    mFis_10                                            ;; 0e:6595 $a6
    mSTEREOPAN $03                                     ;; 0e:6596 $e6 $03
    mAis_2                                             ;; 0e:6598 $2a
    mFis_10                                            ;; 0e:6599 $a6
    mA_10                                              ;; 0e:659a $a9
    mG_10                                              ;; 0e:659b $a7
    mFis_10                                            ;; 0e:659c $a6
    mA_10                                              ;; 0e:659d $a9
    mFis_10                                            ;; 0e:659e $a6
    mG_10                                              ;; 0e:659f $a7
    mA_10                                              ;; 0e:65a0 $a9
    mB_10                                              ;; 0e:65a1 $ab
    mCPlus_10                                          ;; 0e:65a2 $ac
    mB_10                                              ;; 0e:65a3 $ab
    mA_10                                              ;; 0e:65a4 $a9
    mG_10                                              ;; 0e:65a5 $a7
    mA_10                                              ;; 0e:65a6 $a9
    mG_10                                              ;; 0e:65a7 $a7
    mFis_10                                            ;; 0e:65a8 $a6
    mJUMP .data_0e_643c                                ;; 0e:65a9 $e1 $3c $64

song11_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:65ac $e4 $fe $79
    mWAVETABLE data_0e_7aa5                            ;; 0e:65af $e8 $a5 $7a
    mVOLUME $20                                        ;; 0e:65b2 $e0 $20
.data_0e_65b4:
    mCOUNTER $02                                       ;; 0e:65b4 $e3 $02
    mSTEREOPAN $01                                     ;; 0e:65b6 $e6 $01
    mOCTAVE_1                                          ;; 0e:65b8 $d1
    mE_2                                               ;; 0e:65b9 $24
    mSTEREOPAN $02                                     ;; 0e:65ba $e6 $02
    mFis_2                                             ;; 0e:65bc $26
    mSTEREOPAN $01                                     ;; 0e:65bd $e6 $01
    mG_2                                               ;; 0e:65bf $27
    mSTEREOPAN $02                                     ;; 0e:65c0 $e6 $02
    mGis_2                                             ;; 0e:65c2 $28
    mSTEREOPAN $01                                     ;; 0e:65c3 $e6 $01
    mA_2                                               ;; 0e:65c5 $29
    mSTEREOPAN $02                                     ;; 0e:65c6 $e6 $02
    mFis_2                                             ;; 0e:65c8 $26
    mSTEREOPAN $03                                     ;; 0e:65c9 $e6 $03
    mB_5                                               ;; 0e:65cb $5b
    mOCTAVE_PLUS_1                                     ;; 0e:65cc $d8
    mB_5                                               ;; 0e:65cd $5b
    mFis_5                                             ;; 0e:65ce $56
    mOCTAVE_MINUS_1                                    ;; 0e:65cf $dc
    mB_5                                               ;; 0e:65d0 $5b
.data_0e_65d1:
    mCPlus_8                                           ;; 0e:65d1 $8c
    mRest_5                                            ;; 0e:65d2 $5f
    mCPlus_8                                           ;; 0e:65d3 $8c
    mRest_5                                            ;; 0e:65d4 $5f
    mCPlus_8                                           ;; 0e:65d5 $8c
    mRest_8                                            ;; 0e:65d6 $8f
    mCPlus_8                                           ;; 0e:65d7 $8c
    mRest_5                                            ;; 0e:65d8 $5f
    mCPlus_8                                           ;; 0e:65d9 $8c
    mRest_5                                            ;; 0e:65da $5f
    mCPlus_8                                           ;; 0e:65db $8c
    mRest_8                                            ;; 0e:65dc $8f
    mB_10                                              ;; 0e:65dd $ab
    mRest_10                                           ;; 0e:65de $af
    mB_10                                              ;; 0e:65df $ab
    mRest_10                                           ;; 0e:65e0 $af
    mRest_5                                            ;; 0e:65e1 $5f
    mB_10                                              ;; 0e:65e2 $ab
    mRest_10                                           ;; 0e:65e3 $af
    mB_10                                              ;; 0e:65e4 $ab
    mRest_10                                           ;; 0e:65e5 $af
    mRest_5                                            ;; 0e:65e6 $5f
    mE_5                                               ;; 0e:65e7 $54
    mOCTAVE_PLUS_1                                     ;; 0e:65e8 $d8
    mE_5                                               ;; 0e:65e9 $54
    mD_5                                               ;; 0e:65ea $52
    mOCTAVE_MINUS_1                                    ;; 0e:65eb $dc
    mB_5                                               ;; 0e:65ec $5b
    mA_10                                              ;; 0e:65ed $a9
    mRest_10                                           ;; 0e:65ee $af
    mA_10                                              ;; 0e:65ef $a9
    mRest_10                                           ;; 0e:65f0 $af
    mSTEREOPAN $01                                     ;; 0e:65f1 $e6 $01
    mRest_8                                            ;; 0e:65f3 $8f
    mA_8                                               ;; 0e:65f4 $89
    mSTEREOPAN $03                                     ;; 0e:65f5 $e6 $03
    mRest_8                                            ;; 0e:65f7 $8f
    mA_8                                               ;; 0e:65f8 $89
    mSTEREOPAN $02                                     ;; 0e:65f9 $e6 $02
    mRest_8                                            ;; 0e:65fb $8f
    mA_8                                               ;; 0e:65fc $89
    mSTEREOPAN $03                                     ;; 0e:65fd $e6 $03
    mB_10                                              ;; 0e:65ff $ab
    mRest_10                                           ;; 0e:6600 $af
    mB_10                                              ;; 0e:6601 $ab
    mRest_10                                           ;; 0e:6602 $af
    mSTEREOPAN $01                                     ;; 0e:6603 $e6 $01
    mRest_8                                            ;; 0e:6605 $8f
    mB_8                                               ;; 0e:6606 $8b
    mSTEREOPAN $03                                     ;; 0e:6607 $e6 $03
    mRest_8                                            ;; 0e:6609 $8f
    mB_8                                               ;; 0e:660a $8b
    mSTEREOPAN $02                                     ;; 0e:660b $e6 $02
    mRest_8                                            ;; 0e:660d $8f
    mB_8                                               ;; 0e:660e $8b
    mJUMPIF $01, .data_0e_6632                         ;; 0e:660f $eb $01 $32 $66
    mSTEREOPAN $03                                     ;; 0e:6613 $e6 $03
    mCPlus_10                                          ;; 0e:6615 $ac
    mRest_10                                           ;; 0e:6616 $af
    mCPlus_10                                          ;; 0e:6617 $ac
    mRest_10                                           ;; 0e:6618 $af
    mSTEREOPAN $01                                     ;; 0e:6619 $e6 $01
    mRest_8                                            ;; 0e:661b $8f
    mCPlus_8                                           ;; 0e:661c $8c
    mSTEREOPAN $03                                     ;; 0e:661d $e6 $03
    mRest_8                                            ;; 0e:661f $8f
    mCPlus_8                                           ;; 0e:6620 $8c
    mSTEREOPAN $02                                     ;; 0e:6621 $e6 $02
    mRest_8                                            ;; 0e:6623 $8f
    mCPlus_8                                           ;; 0e:6624 $8c
    mSTEREOPAN $03                                     ;; 0e:6625 $e6 $03
    mB_7                                               ;; 0e:6627 $7b
    mRest_10                                           ;; 0e:6628 $af
    mB_7                                               ;; 0e:6629 $7b
    mRest_10                                           ;; 0e:662a $af
    mCisPlus_5                                         ;; 0e:662b $5d
    mOCTAVE_PLUS_1                                     ;; 0e:662c $d8
    mDis_5                                             ;; 0e:662d $53
    mOCTAVE_MINUS_1                                    ;; 0e:662e $dc
    mREPEAT .data_0e_65d1                              ;; 0e:662f $e2 $d1 $65
.data_0e_6632:
    mCOUNTER $04                                       ;; 0e:6632 $e3 $04
    mSTEREOPAN $03                                     ;; 0e:6634 $e6 $03
    mCPlus_10                                          ;; 0e:6636 $ac
    mRest_10                                           ;; 0e:6637 $af
    mSTEREOPAN $01                                     ;; 0e:6638 $e6 $01
    mCPlus_10                                          ;; 0e:663a $ac
    mRest_10                                           ;; 0e:663b $af
    mSTEREOPAN $03                                     ;; 0e:663c $e6 $03
    mCPlus_10                                          ;; 0e:663e $ac
    mRest_10                                           ;; 0e:663f $af
    mSTEREOPAN $02                                     ;; 0e:6640 $e6 $02
    mCPlus_10                                          ;; 0e:6642 $ac
    mRest_10                                           ;; 0e:6643 $af
    mSTEREOPAN $03                                     ;; 0e:6644 $e6 $03
    mCPlus_10                                          ;; 0e:6646 $ac
    mRest_10                                           ;; 0e:6647 $af
    mSTEREOPAN $01                                     ;; 0e:6648 $e6 $01
    mCPlus_10                                          ;; 0e:664a $ac
    mRest_10                                           ;; 0e:664b $af
    mSTEREOPAN $03                                     ;; 0e:664c $e6 $03
    mCPlus_10                                          ;; 0e:664e $ac
    mRest_10                                           ;; 0e:664f $af
    mSTEREOPAN $02                                     ;; 0e:6650 $e6 $02
    mCPlus_10                                          ;; 0e:6652 $ac
    mRest_10                                           ;; 0e:6653 $af
    mSTEREOPAN $03                                     ;; 0e:6654 $e6 $03
    mB_10                                              ;; 0e:6656 $ab
    mRest_10                                           ;; 0e:6657 $af
    mSTEREOPAN $01                                     ;; 0e:6658 $e6 $01
    mB_10                                              ;; 0e:665a $ab
    mRest_10                                           ;; 0e:665b $af
    mSTEREOPAN $03                                     ;; 0e:665c $e6 $03
    mB_10                                              ;; 0e:665e $ab
    mRest_10                                           ;; 0e:665f $af
    mSTEREOPAN $02                                     ;; 0e:6660 $e6 $02
    mB_10                                              ;; 0e:6662 $ab
    mRest_10                                           ;; 0e:6663 $af
    mSTEREOPAN $03                                     ;; 0e:6664 $e6 $03
    mCisPlus_10                                        ;; 0e:6666 $ad
    mRest_10                                           ;; 0e:6667 $af
    mSTEREOPAN $01                                     ;; 0e:6668 $e6 $01
    mCisPlus_10                                        ;; 0e:666a $ad
    mRest_10                                           ;; 0e:666b $af
    mSTEREOPAN $03                                     ;; 0e:666c $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:666e $d8
    mDis_10                                            ;; 0e:666f $a3
    mRest_10                                           ;; 0e:6670 $af
    mSTEREOPAN $02                                     ;; 0e:6671 $e6 $02
    mDis_10                                            ;; 0e:6673 $a3
    mRest_10                                           ;; 0e:6674 $af
    mSTEREOPAN $03                                     ;; 0e:6675 $e6 $03
    mCis_0                                             ;; 0e:6677 $01
    mSTEREOPAN $01                                     ;; 0e:6678 $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:667a $dc
    mB_5                                               ;; 0e:667b $5b
    mSTEREOPAN $02                                     ;; 0e:667c $e6 $02
    mA_5                                               ;; 0e:667e $59
    mSTEREOPAN $01                                     ;; 0e:667f $e6 $01
    mG_5                                               ;; 0e:6681 $57
    mSTEREOPAN $02                                     ;; 0e:6682 $e6 $02
    mFis_5                                             ;; 0e:6684 $56
    mJUMP .data_0e_65b4                                ;; 0e:6685 $e1 $b4 $65

song0b_channel2:
    mTEMPO $78                                         ;; 0e:6688 $e7 $78
    mVIBRATO frequencyDeltaData                        ;; 0e:668a $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:668d $e0 $55 $7a
    mDUTYCYCLE $40                                     ;; 0e:6690 $e5 $40
    mSTEREOPAN $03                                     ;; 0e:6692 $e6 $03
    mOCTAVE_2                                          ;; 0e:6694 $d2
    mA_10                                              ;; 0e:6695 $a9
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:6696 $e0 $65 $7a
    mRest_10                                           ;; 0e:6699 $af
    mA_10                                              ;; 0e:669a $a9
    mRest_10                                           ;; 0e:669b $af
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:669c $e0 $67 $7a
    mA_10                                              ;; 0e:669f $a9
    mRest_10                                           ;; 0e:66a0 $af
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:66a1 $e0 $55 $7a
    mA_10                                              ;; 0e:66a4 $a9
    mA_10                                              ;; 0e:66a5 $a9
    mA_10                                              ;; 0e:66a6 $a9
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:66a7 $e0 $65 $7a
    mRest_10                                           ;; 0e:66aa $af
    mA_10                                              ;; 0e:66ab $a9
    mA_10                                              ;; 0e:66ac $a9
    mA_10                                              ;; 0e:66ad $a9
    mRest_10                                           ;; 0e:66ae $af
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:66af $e0 $67 $7a
    mA_10                                              ;; 0e:66b2 $a9
    mA_10                                              ;; 0e:66b3 $a9
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:66b4 $e0 $55 $7a
    mA_10                                              ;; 0e:66b7 $a9
    mRest_10                                           ;; 0e:66b8 $af
    mA_10                                              ;; 0e:66b9 $a9
    mRest_10                                           ;; 0e:66ba $af
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:66bb $e0 $65 $7a
    mA_10                                              ;; 0e:66be $a9
    mRest_10                                           ;; 0e:66bf $af
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:66c0 $e0 $55 $7a
    mA_10                                              ;; 0e:66c3 $a9
    mA_10                                              ;; 0e:66c4 $a9
    mA_10                                              ;; 0e:66c5 $a9
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:66c6 $e0 $65 $7a
    mRest_10                                           ;; 0e:66c9 $af
    mA_10                                              ;; 0e:66ca $a9
    mA_10                                              ;; 0e:66cb $a9
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:66cc $e0 $53 $7a
    mOCTAVE_2                                          ;; 0e:66cf $d2
    mA_9                                               ;; 0e:66d0 $99
    mOCTAVE_PLUS_1                                     ;; 0e:66d1 $d8
    mE_9                                               ;; 0e:66d2 $94
    mA_9                                               ;; 0e:66d3 $99
.data_0e_66d4:
    mG_5                                               ;; 0e:66d4 $57
    mFis_9                                             ;; 0e:66d5 $96
    mE_9                                               ;; 0e:66d6 $94
    mG_9                                               ;; 0e:66d7 $97
    mFis_5                                             ;; 0e:66d8 $56
    mD_5                                               ;; 0e:66d9 $52
    mE_9                                               ;; 0e:66da $94
    mRest_9                                            ;; 0e:66db $9f
    mOCTAVE_MINUS_1                                    ;; 0e:66dc $dc
    mA_9                                               ;; 0e:66dd $99
    mA_2                                               ;; 0e:66de $29
    mA_9                                               ;; 0e:66df $99
    mA_9                                               ;; 0e:66e0 $99
    mB_9                                               ;; 0e:66e1 $9b
    mCPlus_4                                           ;; 0e:66e2 $4c
    mB_10                                              ;; 0e:66e3 $ab
    mA_10                                              ;; 0e:66e4 $a9
    mOCTAVE_PLUS_1                                     ;; 0e:66e5 $d8
    mD_6                                               ;; 0e:66e6 $62
    mC_6                                               ;; 0e:66e7 $60
    mOCTAVE_MINUS_1                                    ;; 0e:66e8 $dc
    mB_6                                               ;; 0e:66e9 $6b
    mA_1                                               ;; 0e:66ea $19
    mA_9                                               ;; 0e:66eb $99
    mOCTAVE_PLUS_1                                     ;; 0e:66ec $d8
    mE_9                                               ;; 0e:66ed $94
    mA_9                                               ;; 0e:66ee $99
    mG_5                                               ;; 0e:66ef $57
    mFis_9                                             ;; 0e:66f0 $96
    mE_9                                               ;; 0e:66f1 $94
    mG_9                                               ;; 0e:66f2 $97
    mFis_5                                             ;; 0e:66f3 $56
    mD_5                                               ;; 0e:66f4 $52
    mE_9                                               ;; 0e:66f5 $94
    mRest_9                                            ;; 0e:66f6 $9f
    mOCTAVE_MINUS_1                                    ;; 0e:66f7 $dc
    mA_9                                               ;; 0e:66f8 $99
    mA_2                                               ;; 0e:66f9 $29
    mA_9                                               ;; 0e:66fa $99
    mA_9                                               ;; 0e:66fb $99
    mB_9                                               ;; 0e:66fc $9b
    mCPlus_4                                           ;; 0e:66fd $4c
    mOCTAVE_PLUS_1                                     ;; 0e:66fe $d8
    mD_10                                              ;; 0e:66ff $a2
    mE_10                                              ;; 0e:6700 $a4
    mD_6                                               ;; 0e:6701 $62
    mC_6                                               ;; 0e:6702 $60
    mOCTAVE_MINUS_1                                    ;; 0e:6703 $dc
    mB_6                                               ;; 0e:6704 $6b
    mA_1                                               ;; 0e:6705 $19
    mVOLUME_ENVELOPE data_0e_7a6b                      ;; 0e:6706 $e0 $6b $7a
    mA_11                                              ;; 0e:6709 $b9
    mRest_11                                           ;; 0e:670a $bf
    mA_9                                               ;; 0e:670b $99
    mB_9                                               ;; 0e:670c $9b
    mCPlus_2                                           ;; 0e:670d $2c
    mWait_8                                            ;; 0e:670e $8e
    mCPlus_8                                           ;; 0e:670f $8c
    mB_8                                               ;; 0e:6710 $8b
    mA_8                                               ;; 0e:6711 $89
    mOCTAVE_PLUS_1                                     ;; 0e:6712 $d8
    mD_10                                              ;; 0e:6713 $a2
    mRest_8                                            ;; 0e:6714 $8f
    mOCTAVE_MINUS_1                                    ;; 0e:6715 $dc
    mA_12                                              ;; 0e:6716 $c9
    mRest_12                                           ;; 0e:6717 $cf
    mA_2                                               ;; 0e:6718 $29
    mA_8                                               ;; 0e:6719 $89
    mB_8                                               ;; 0e:671a $8b
    mCPlus_5                                           ;; 0e:671b $5c
    mOCTAVE_PLUS_1                                     ;; 0e:671c $d8
    mD_8                                               ;; 0e:671d $82
    mE_8                                               ;; 0e:671e $84
    mD_7                                               ;; 0e:671f $72
    mC_7                                               ;; 0e:6720 $70
    mOCTAVE_MINUS_1                                    ;; 0e:6721 $dc
    mB_8                                               ;; 0e:6722 $8b
    mA_1                                               ;; 0e:6723 $19
    mA_11                                              ;; 0e:6724 $b9
    mRest_11                                           ;; 0e:6725 $bf
    mA_11                                              ;; 0e:6726 $b9
    mRest_11                                           ;; 0e:6727 $bf
    mB_11                                              ;; 0e:6728 $bb
    mRest_11                                           ;; 0e:6729 $bf
    mCPlus_2                                           ;; 0e:672a $2c
    mWait_8                                            ;; 0e:672b $8e
    mCPlus_8                                           ;; 0e:672c $8c
    mB_8                                               ;; 0e:672d $8b
    mA_8                                               ;; 0e:672e $89
    mOCTAVE_PLUS_1                                     ;; 0e:672f $d8
    mD_10                                              ;; 0e:6730 $a2
    mRest_8                                            ;; 0e:6731 $8f
    mOCTAVE_MINUS_1                                    ;; 0e:6732 $dc
    mA_12                                              ;; 0e:6733 $c9
    mRest_12                                           ;; 0e:6734 $cf
    mA_2                                               ;; 0e:6735 $29
    mA_8                                               ;; 0e:6736 $89
    mB_8                                               ;; 0e:6737 $8b
    mCPlus_5                                           ;; 0e:6738 $5c
    mOCTAVE_PLUS_1                                     ;; 0e:6739 $d8
    mD_8                                               ;; 0e:673a $82
    mE_8                                               ;; 0e:673b $84
    mDis_7                                             ;; 0e:673c $73
    mF_7                                               ;; 0e:673d $75
    mG_8                                               ;; 0e:673e $87
    mA_1                                               ;; 0e:673f $19
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6740 $e0 $55 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:6743 $dc
    mA_9                                               ;; 0e:6744 $99
    mOCTAVE_PLUS_1                                     ;; 0e:6745 $d8
    mE_9                                               ;; 0e:6746 $94
    mA_9                                               ;; 0e:6747 $99
    mJUMP .data_0e_66d4                                ;; 0e:6748 $e1 $d4 $66

song0b_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:674b $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:674e $e0 $55 $7a
    mDUTYCYCLE $40                                     ;; 0e:6751 $e5 $40
    mSTEREOPAN $03                                     ;; 0e:6753 $e6 $03
    mOCTAVE_2                                          ;; 0e:6755 $d2
    mE_10                                              ;; 0e:6756 $a4
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:6757 $e0 $65 $7a
    mRest_10                                           ;; 0e:675a $af
    mE_10                                              ;; 0e:675b $a4
    mRest_10                                           ;; 0e:675c $af
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:675d $e0 $67 $7a
    mE_10                                              ;; 0e:6760 $a4
    mRest_10                                           ;; 0e:6761 $af
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6762 $e0 $55 $7a
    mE_10                                              ;; 0e:6765 $a4
    mE_10                                              ;; 0e:6766 $a4
    mE_10                                              ;; 0e:6767 $a4
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:6768 $e0 $65 $7a
    mRest_10                                           ;; 0e:676b $af
    mE_10                                              ;; 0e:676c $a4
    mE_10                                              ;; 0e:676d $a4
    mE_10                                              ;; 0e:676e $a4
    mRest_10                                           ;; 0e:676f $af
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:6770 $e0 $67 $7a
    mE_10                                              ;; 0e:6773 $a4
    mE_10                                              ;; 0e:6774 $a4
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6775 $e0 $55 $7a
    mE_10                                              ;; 0e:6778 $a4
    mRest_10                                           ;; 0e:6779 $af
    mE_10                                              ;; 0e:677a $a4
    mRest_10                                           ;; 0e:677b $af
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:677c $e0 $65 $7a
    mE_10                                              ;; 0e:677f $a4
    mRest_10                                           ;; 0e:6780 $af
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6781 $e0 $55 $7a
    mE_10                                              ;; 0e:6784 $a4
    mE_10                                              ;; 0e:6785 $a4
    mE_10                                              ;; 0e:6786 $a4
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:6787 $e0 $65 $7a
    mRest_10                                           ;; 0e:678a $af
    mE_10                                              ;; 0e:678b $a4
    mE_10                                              ;; 0e:678c $a4
    mE_10                                              ;; 0e:678d $a4
    mRest_10                                           ;; 0e:678e $af
    mVOLUME_ENVELOPE data_0e_7a67                      ;; 0e:678f $e0 $67 $7a
    mE_10                                              ;; 0e:6792 $a4
    mE_10                                              ;; 0e:6793 $a4
.data_0e_6794:
    mCOUNTER $02                                       ;; 0e:6794 $e3 $02
.data_0e_6796:
    mSTEREOPAN $02                                     ;; 0e:6796 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6798 $e0 $55 $7a
    mOCTAVE_3                                          ;; 0e:679b $d3
    mD_5                                               ;; 0e:679c $52
    mOCTAVE_MINUS_1                                    ;; 0e:679d $dc
    mB_5                                               ;; 0e:679e $5b
    mA_5                                               ;; 0e:679f $59
    mFis_5                                             ;; 0e:67a0 $56
    mE_5                                               ;; 0e:67a1 $54
    mSTEREOPAN $01                                     ;; 0e:67a2 $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:67a4 $dc
    mA_9                                               ;; 0e:67a5 $99
    mGis_9                                             ;; 0e:67a6 $98
    mA_9                                               ;; 0e:67a7 $99
    mCisPlus_9                                         ;; 0e:67a8 $9d
    mCPlus_9                                           ;; 0e:67a9 $9c
    mCisPlus_9                                         ;; 0e:67aa $9d
    mOCTAVE_PLUS_1                                     ;; 0e:67ab $d8
    mE_9                                               ;; 0e:67ac $94
    mDis_9                                             ;; 0e:67ad $93
    mE_9                                               ;; 0e:67ae $94
    mSTEREOPAN $02                                     ;; 0e:67af $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:67b1 $dc
    mE_9                                               ;; 0e:67b2 $94
    mG_9                                               ;; 0e:67b3 $97
    mCPlus_9                                           ;; 0e:67b4 $9c
    mOCTAVE_PLUS_1                                     ;; 0e:67b5 $d8
    mD_9                                               ;; 0e:67b6 $92
    mE_9                                               ;; 0e:67b7 $94
    mG_9                                               ;; 0e:67b8 $97
    mSTEREOPAN $01                                     ;; 0e:67b9 $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:67bb $dc
    mD_9                                               ;; 0e:67bc $92
    mFis_9                                             ;; 0e:67bd $96
    mA_9                                               ;; 0e:67be $99
    mOCTAVE_PLUS_1                                     ;; 0e:67bf $d8
    mD_9                                               ;; 0e:67c0 $92
    mE_9                                               ;; 0e:67c1 $94
    mFis_9                                             ;; 0e:67c2 $96
    mJUMPIF $01, .data_0e_67cf                         ;; 0e:67c3 $eb $01 $cf $67
    mE_5                                               ;; 0e:67c7 $54
    mD_9                                               ;; 0e:67c8 $92
    mE_9                                               ;; 0e:67c9 $94
    mD_9                                               ;; 0e:67ca $92
    mCis_2                                             ;; 0e:67cb $21
    mREPEAT .data_0e_6796                              ;; 0e:67cc $e2 $96 $67
.data_0e_67cf:
    mE_5                                               ;; 0e:67cf $54
    mSTEREOPAN $03                                     ;; 0e:67d0 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:67d2 $dc
    mCis_10                                            ;; 0e:67d3 $a1
    mD_10                                              ;; 0e:67d4 $a2
    mE_10                                              ;; 0e:67d5 $a4
    mFis_10                                            ;; 0e:67d6 $a6
    mGis_10                                            ;; 0e:67d7 $a8
    mA_10                                              ;; 0e:67d8 $a9
    mB_10                                              ;; 0e:67d9 $ab
    mCisPlus_10                                        ;; 0e:67da $ad
    mOCTAVE_PLUS_1                                     ;; 0e:67db $d8
    mE_5                                               ;; 0e:67dc $54
    mCOUNTER $02                                       ;; 0e:67dd $e3 $02
.data_0e_67df:
    mDUTYCYCLE $00                                     ;; 0e:67df $e5 $00
    mSTEREOPAN $02                                     ;; 0e:67e1 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:67e3 $e0 $55 $7a
    mE_10                                              ;; 0e:67e6 $a4
    mF_10                                              ;; 0e:67e7 $a5
    mE_10                                              ;; 0e:67e8 $a4
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:67e9 $e0 $61 $7a
    mC_10                                              ;; 0e:67ec $a0
    mSTEREOPAN $01                                     ;; 0e:67ed $e6 $01
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:67ef $e0 $55 $7a
    mE_10                                              ;; 0e:67f2 $a4
    mF_10                                              ;; 0e:67f3 $a5
    mE_10                                              ;; 0e:67f4 $a4
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:67f5 $e0 $61 $7a
    mC_10                                              ;; 0e:67f8 $a0
    mREPEAT .data_0e_67df                              ;; 0e:67f9 $e2 $df $67
    mCOUNTER $02                                       ;; 0e:67fc $e3 $02
.data_0e_67fe:
    mSTEREOPAN $02                                     ;; 0e:67fe $e6 $02
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6800 $e0 $55 $7a
    mD_10                                              ;; 0e:6803 $a2
    mF_10                                              ;; 0e:6804 $a5
    mD_10                                              ;; 0e:6805 $a2
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:6806 $e0 $61 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:6809 $dc
    mB_10                                              ;; 0e:680a $ab
    mOCTAVE_PLUS_1                                     ;; 0e:680b $d8
    mSTEREOPAN $01                                     ;; 0e:680c $e6 $01
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:680e $e0 $55 $7a
    mD_10                                              ;; 0e:6811 $a2
    mF_10                                              ;; 0e:6812 $a5
    mD_10                                              ;; 0e:6813 $a2
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:6814 $e0 $61 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:6817 $dc
    mB_10                                              ;; 0e:6818 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6819 $d8
    mREPEAT .data_0e_67fe                              ;; 0e:681a $e2 $fe $67
    mSTEREOPAN $02                                     ;; 0e:681d $e6 $02
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:681f $e0 $55 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:6822 $dc
    mA_10                                              ;; 0e:6823 $a9
    mB_10                                              ;; 0e:6824 $ab
    mCPlus_10                                          ;; 0e:6825 $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6826 $d8
    mD_10                                              ;; 0e:6827 $a2
    mE_10                                              ;; 0e:6828 $a4
    mF_10                                              ;; 0e:6829 $a5
    mG_10                                              ;; 0e:682a $a7
    mA_10                                              ;; 0e:682b $a9
    mSTEREOPAN $01                                     ;; 0e:682c $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:682e $dc
    mG_10                                              ;; 0e:682f $a7
    mA_10                                              ;; 0e:6830 $a9
    mB_10                                              ;; 0e:6831 $ab
    mCPlus_10                                          ;; 0e:6832 $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6833 $d8
    mD_10                                              ;; 0e:6834 $a2
    mE_10                                              ;; 0e:6835 $a4
    mF_10                                              ;; 0e:6836 $a5
    mG_10                                              ;; 0e:6837 $a7
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:6838 $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:683b $e5 $80
    mOCTAVE_PLUS_1                                     ;; 0e:683d $d8
    mFis_5                                             ;; 0e:683e $56
    mE_5                                               ;; 0e:683f $54
    mSTEREOPAN $03                                     ;; 0e:6840 $e6 $03
    mD_5                                               ;; 0e:6842 $52
    mSTEREOPAN $02                                     ;; 0e:6843 $e6 $02
    mCis_5                                             ;; 0e:6845 $51
    mOCTAVE_MINUS_1                                    ;; 0e:6846 $dc
    mCOUNTER $02                                       ;; 0e:6847 $e3 $02
.data_0e_6849:
    mSTEREOPAN $02                                     ;; 0e:6849 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:684b $e0 $55 $7a
    mDUTYCYCLE $00                                     ;; 0e:684e $e5 $00
    mE_10                                              ;; 0e:6850 $a4
    mF_10                                              ;; 0e:6851 $a5
    mE_10                                              ;; 0e:6852 $a4
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:6853 $e0 $61 $7a
    mC_10                                              ;; 0e:6856 $a0
    mSTEREOPAN $01                                     ;; 0e:6857 $e6 $01
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6859 $e0 $55 $7a
    mE_10                                              ;; 0e:685c $a4
    mF_10                                              ;; 0e:685d $a5
    mE_10                                              ;; 0e:685e $a4
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:685f $e0 $61 $7a
    mC_10                                              ;; 0e:6862 $a0
    mREPEAT .data_0e_6849                              ;; 0e:6863 $e2 $49 $68
    mCOUNTER $02                                       ;; 0e:6866 $e3 $02
.data_0e_6868:
    mSTEREOPAN $02                                     ;; 0e:6868 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:686a $e0 $55 $7a
    mD_10                                              ;; 0e:686d $a2
    mF_10                                              ;; 0e:686e $a5
    mD_10                                              ;; 0e:686f $a2
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:6870 $e0 $61 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:6873 $dc
    mB_10                                              ;; 0e:6874 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6875 $d8
    mSTEREOPAN $01                                     ;; 0e:6876 $e6 $01
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6878 $e0 $55 $7a
    mD_10                                              ;; 0e:687b $a2
    mF_10                                              ;; 0e:687c $a5
    mD_10                                              ;; 0e:687d $a2
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:687e $e0 $61 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:6881 $dc
    mB_10                                              ;; 0e:6882 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6883 $d8
    mREPEAT .data_0e_6868                              ;; 0e:6884 $e2 $68 $68
    mSTEREOPAN $02                                     ;; 0e:6887 $e6 $02
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6889 $e0 $55 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:688c $dc
    mA_10                                              ;; 0e:688d $a9
    mB_10                                              ;; 0e:688e $ab
    mCPlus_10                                          ;; 0e:688f $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6890 $d8
    mD_10                                              ;; 0e:6891 $a2
    mE_10                                              ;; 0e:6892 $a4
    mF_10                                              ;; 0e:6893 $a5
    mG_10                                              ;; 0e:6894 $a7
    mA_10                                              ;; 0e:6895 $a9
    mSTEREOPAN $01                                     ;; 0e:6896 $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:6898 $dc
    mAis_10                                            ;; 0e:6899 $aa
    mCPlus_10                                          ;; 0e:689a $ac
    mOCTAVE_PLUS_1                                     ;; 0e:689b $d8
    mD_10                                              ;; 0e:689c $a2
    mDis_10                                            ;; 0e:689d $a3
    mF_10                                              ;; 0e:689e $a5
    mG_10                                              ;; 0e:689f $a7
    mA_10                                              ;; 0e:68a0 $a9
    mAis_10                                            ;; 0e:68a1 $aa
    mSTEREOPAN $03                                     ;; 0e:68a2 $e6 $03
    mDUTYCYCLE $40                                     ;; 0e:68a4 $e5 $40
    mD_10                                              ;; 0e:68a6 $a2
    mE_10                                              ;; 0e:68a7 $a4
    mA_10                                              ;; 0e:68a8 $a9
    mE_10                                              ;; 0e:68a9 $a4
    mB_10                                              ;; 0e:68aa $ab
    mE_10                                              ;; 0e:68ab $a4
    mA_10                                              ;; 0e:68ac $a9
    mOCTAVE_PLUS_1                                     ;; 0e:68ad $d8
    mD_10                                              ;; 0e:68ae $a2
    mE_10                                              ;; 0e:68af $a4
    mCis_10                                            ;; 0e:68b0 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:68b1 $dc
    mA_10                                              ;; 0e:68b2 $a9
    mE_10                                              ;; 0e:68b3 $a4
    mCis_5                                             ;; 0e:68b4 $51
    mJUMP .data_0e_6794                                ;; 0e:68b5 $e1 $94 $67

song0b_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:68b8 $e4 $fe $79
    mWAVETABLE data_0e_7aa5                            ;; 0e:68bb $e8 $a5 $7a
    mVOLUME $20                                        ;; 0e:68be $e0 $20
    mSTEREOPAN $03                                     ;; 0e:68c0 $e6 $03
    mOCTAVE_1                                          ;; 0e:68c2 $d1
    mA_10                                              ;; 0e:68c3 $a9
    mRest_7                                            ;; 0e:68c4 $7f
    mRest_8                                            ;; 0e:68c5 $8f
    mA_12                                              ;; 0e:68c6 $c9
    mRest_12                                           ;; 0e:68c7 $cf
    mA_12                                              ;; 0e:68c8 $c9
    mRest_12                                           ;; 0e:68c9 $cf
    mA_10                                              ;; 0e:68ca $a9
    mRest_7                                            ;; 0e:68cb $7f
    mRest_5                                            ;; 0e:68cc $5f
    mA_10                                              ;; 0e:68cd $a9
    mRest_10                                           ;; 0e:68ce $af
    mA_10                                              ;; 0e:68cf $a9
    mRest_10                                           ;; 0e:68d0 $af
    mRest_8                                            ;; 0e:68d1 $8f
    mA_12                                              ;; 0e:68d2 $c9
    mRest_12                                           ;; 0e:68d3 $cf
    mA_12                                              ;; 0e:68d4 $c9
    mRest_12                                           ;; 0e:68d5 $cf
    mA_10                                              ;; 0e:68d6 $a9
    mRest_7                                            ;; 0e:68d7 $7f
    mRest_5                                            ;; 0e:68d8 $5f
.data_0e_68d9:
    mCOUNTER $02                                       ;; 0e:68d9 $e3 $02
.data_0e_68db:
    mOCTAVE_1                                          ;; 0e:68db $d1
    mA_7                                               ;; 0e:68dc $79
    mRest_10                                           ;; 0e:68dd $af
    mA_11                                              ;; 0e:68de $b9
    mRest_11                                           ;; 0e:68df $bf
    mA_11                                              ;; 0e:68e0 $b9
    mRest_11                                           ;; 0e:68e1 $bf
    mA_11                                              ;; 0e:68e2 $b9
    mRest_11                                           ;; 0e:68e3 $bf
    mA_7                                               ;; 0e:68e4 $79
    mRest_10                                           ;; 0e:68e5 $af
    mA_7                                               ;; 0e:68e6 $79
    mRest_10                                           ;; 0e:68e7 $af
    mA_11                                              ;; 0e:68e8 $b9
    mRest_11                                           ;; 0e:68e9 $bf
    mA_11                                              ;; 0e:68ea $b9
    mRest_11                                           ;; 0e:68eb $bf
    mA_11                                              ;; 0e:68ec $b9
    mRest_11                                           ;; 0e:68ed $bf
    mA_7                                               ;; 0e:68ee $79
    mRest_10                                           ;; 0e:68ef $af
    mA_7                                               ;; 0e:68f0 $79
    mRest_10                                           ;; 0e:68f1 $af
    mA_11                                              ;; 0e:68f2 $b9
    mRest_11                                           ;; 0e:68f3 $bf
    mA_11                                              ;; 0e:68f4 $b9
    mRest_11                                           ;; 0e:68f5 $bf
    mA_11                                              ;; 0e:68f6 $b9
    mRest_11                                           ;; 0e:68f7 $bf
    mCPlus_5                                           ;; 0e:68f8 $5c
    mC_11                                              ;; 0e:68f9 $b0
    mRest_11                                           ;; 0e:68fa $bf
    mC_11                                              ;; 0e:68fb $b0
    mRest_11                                           ;; 0e:68fc $bf
    mC_11                                              ;; 0e:68fd $b0
    mRest_11                                           ;; 0e:68fe $bf
    mD_5                                               ;; 0e:68ff $52
    mFis_5                                             ;; 0e:6900 $56
    mJUMPIF $01, .data_0e_690e                         ;; 0e:6901 $eb $01 $0e $69
    mA_2                                               ;; 0e:6905 $29
    mOCTAVE_PLUS_1                                     ;; 0e:6906 $d8
    mA_9                                               ;; 0e:6907 $99
    mE_9                                               ;; 0e:6908 $94
    mD_9                                               ;; 0e:6909 $92
    mCis_5                                             ;; 0e:690a $51
    mREPEAT .data_0e_68db                              ;; 0e:690b $e2 $db $68
.data_0e_690e:
    mA_7                                               ;; 0e:690e $79
    mRest_10                                           ;; 0e:690f $af
    mA_10                                              ;; 0e:6910 $a9
    mB_10                                              ;; 0e:6911 $ab
    mCisPlus_10                                        ;; 0e:6912 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:6913 $d8
    mD_10                                              ;; 0e:6914 $a2
    mE_10                                              ;; 0e:6915 $a4
    mFis_10                                            ;; 0e:6916 $a6
    mGis_10                                            ;; 0e:6917 $a8
    mA_10                                              ;; 0e:6918 $a9
    mCisPlus_5                                         ;; 0e:6919 $5d
    mD_10                                              ;; 0e:691a $a2
    mRest_10                                           ;; 0e:691b $af
    mD_10                                              ;; 0e:691c $a2
    mRest_7                                            ;; 0e:691d $7f
    mD_10                                              ;; 0e:691e $a2
    mRest_7                                            ;; 0e:691f $7f
    mD_10                                              ;; 0e:6920 $a2
    mRest_7                                            ;; 0e:6921 $7f
    mD_10                                              ;; 0e:6922 $a2
    mRest_10                                           ;; 0e:6923 $af
    mG_10                                              ;; 0e:6924 $a7
    mRest_10                                           ;; 0e:6925 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6926 $dc
    mG_5                                               ;; 0e:6927 $57
    mA_5                                               ;; 0e:6928 $59
    mB_5                                               ;; 0e:6929 $5b
    mOCTAVE_PLUS_1                                     ;; 0e:692a $d8
    mE_8                                               ;; 0e:692b $84
    mF_5                                               ;; 0e:692c $55
    mOCTAVE_MINUS_1                                    ;; 0e:692d $dc
    mF_5                                               ;; 0e:692e $55
    mG_5                                               ;; 0e:692f $57
    mOCTAVE_PLUS_1                                     ;; 0e:6930 $d8
    mG_5                                               ;; 0e:6931 $57
    mD_10                                              ;; 0e:6932 $a2
    mRest_10                                           ;; 0e:6933 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6934 $dc
    mA_8                                               ;; 0e:6935 $89
    mOCTAVE_PLUS_1                                     ;; 0e:6936 $d8
    mD_10                                              ;; 0e:6937 $a2
    mRest_10                                           ;; 0e:6938 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6939 $dc
    mA_8                                               ;; 0e:693a $89
    mOCTAVE_PLUS_1                                     ;; 0e:693b $d8
    mD_10                                              ;; 0e:693c $a2
    mRest_10                                           ;; 0e:693d $af
    mOCTAVE_MINUS_1                                    ;; 0e:693e $dc
    mA_8                                               ;; 0e:693f $89
    mOCTAVE_PLUS_1                                     ;; 0e:6940 $d8
    mD_10                                              ;; 0e:6941 $a2
    mRest_10                                           ;; 0e:6942 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6943 $dc
    mA_8                                               ;; 0e:6944 $89
    mOCTAVE_PLUS_1                                     ;; 0e:6945 $d8
    mD_10                                              ;; 0e:6946 $a2
    mRest_10                                           ;; 0e:6947 $af
    mD_10                                              ;; 0e:6948 $a2
    mRest_7                                            ;; 0e:6949 $7f
    mD_10                                              ;; 0e:694a $a2
    mRest_7                                            ;; 0e:694b $7f
    mD_10                                              ;; 0e:694c $a2
    mRest_7                                            ;; 0e:694d $7f
    mD_10                                              ;; 0e:694e $a2
    mRest_10                                           ;; 0e:694f $af
    mG_10                                              ;; 0e:6950 $a7
    mRest_10                                           ;; 0e:6951 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6952 $dc
    mG_5                                               ;; 0e:6953 $57
    mA_5                                               ;; 0e:6954 $59
    mB_5                                               ;; 0e:6955 $5b
    mOCTAVE_PLUS_1                                     ;; 0e:6956 $d8
    mE_8                                               ;; 0e:6957 $84
    mF_5                                               ;; 0e:6958 $55
    mOCTAVE_MINUS_1                                    ;; 0e:6959 $dc
    mF_5                                               ;; 0e:695a $55
    mOCTAVE_PLUS_1                                     ;; 0e:695b $d8
    mDis_5                                             ;; 0e:695c $53
    mOCTAVE_MINUS_1                                    ;; 0e:695d $dc
    mAis_5                                             ;; 0e:695e $5a
    mA_5                                               ;; 0e:695f $59
    mOCTAVE_PLUS_1                                     ;; 0e:6960 $d8
    mA_11                                              ;; 0e:6961 $b9
    mRest_11                                           ;; 0e:6962 $bf
    mA_11                                              ;; 0e:6963 $b9
    mRest_11                                           ;; 0e:6964 $bf
    mA_11                                              ;; 0e:6965 $b9
    mRest_11                                           ;; 0e:6966 $bf
    mA_5                                               ;; 0e:6967 $59
    mOCTAVE_MINUS_1                                    ;; 0e:6968 $dc
    mA_7                                               ;; 0e:6969 $79
    mRest_10                                           ;; 0e:696a $af
    mJUMP .data_0e_68d9                                ;; 0e:696b $e1 $d9 $68

song12_channel2:
    mTEMPO $96                                         ;; 0e:696e $e7 $96
    mVIBRATO frequencyDeltaData.third                  ;; 0e:6970 $e4 $12 $7a
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6973 $e0 $53 $7a
    mDUTYCYCLE $40                                     ;; 0e:6976 $e5 $40
    mCOUNTER $02                                       ;; 0e:6978 $e3 $02
.data_0e_697a:
    mSTEREOPAN $02                                     ;; 0e:697a $e6 $02
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:697c $e0 $53 $7a
    mOCTAVE_3                                          ;; 0e:697f $d3
    mF_11                                              ;; 0e:6980 $b5
    mC_11                                              ;; 0e:6981 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6982 $dc
    mF_11                                              ;; 0e:6983 $b5
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6984 $e0 $55 $7a
    mOCTAVE_3                                          ;; 0e:6987 $d3
    mF_11                                              ;; 0e:6988 $b5
    mC_11                                              ;; 0e:6989 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:698a $dc
    mF_11                                              ;; 0e:698b $b5
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:698c $e0 $57 $7a
    mOCTAVE_3                                          ;; 0e:698f $d3
    mF_11                                              ;; 0e:6990 $b5
    mC_11                                              ;; 0e:6991 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6992 $dc
    mF_11                                              ;; 0e:6993 $b5
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:6994 $e0 $59 $7a
    mOCTAVE_3                                          ;; 0e:6997 $d3
    mF_11                                              ;; 0e:6998 $b5
    mC_11                                              ;; 0e:6999 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:699a $dc
    mF_11                                              ;; 0e:699b $b5
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:699c $e0 $5b $7a
    mOCTAVE_3                                          ;; 0e:699f $d3
    mF_11                                              ;; 0e:69a0 $b5
    mC_11                                              ;; 0e:69a1 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69a2 $dc
    mF_11                                              ;; 0e:69a3 $b5
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:69a4 $e0 $5d $7a
    mOCTAVE_3                                          ;; 0e:69a7 $d3
    mF_11                                              ;; 0e:69a8 $b5
    mC_11                                              ;; 0e:69a9 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69aa $dc
    mF_11                                              ;; 0e:69ab $b5
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:69ac $e0 $5f $7a
    mOCTAVE_3                                          ;; 0e:69af $d3
    mF_11                                              ;; 0e:69b0 $b5
    mC_11                                              ;; 0e:69b1 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69b2 $dc
    mF_11                                              ;; 0e:69b3 $b5
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:69b4 $e0 $61 $7a
    mOCTAVE_3                                          ;; 0e:69b7 $d3
    mF_11                                              ;; 0e:69b8 $b5
    mC_11                                              ;; 0e:69b9 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69ba $dc
    mF_11                                              ;; 0e:69bb $b5
    mSTEREOPAN $03                                     ;; 0e:69bc $e6 $03
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:69be $e0 $63 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:69c1 $d8
    mG_11                                              ;; 0e:69c2 $b7
    mC_11                                              ;; 0e:69c3 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69c4 $dc
    mG_11                                              ;; 0e:69c5 $b7
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:69c6 $e0 $61 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:69c9 $d8
    mG_11                                              ;; 0e:69ca $b7
    mC_11                                              ;; 0e:69cb $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69cc $dc
    mG_11                                              ;; 0e:69cd $b7
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:69ce $e0 $5f $7a
    mOCTAVE_PLUS_1                                     ;; 0e:69d1 $d8
    mG_11                                              ;; 0e:69d2 $b7
    mC_11                                              ;; 0e:69d3 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69d4 $dc
    mG_11                                              ;; 0e:69d5 $b7
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:69d6 $e0 $5d $7a
    mOCTAVE_PLUS_1                                     ;; 0e:69d9 $d8
    mG_11                                              ;; 0e:69da $b7
    mC_11                                              ;; 0e:69db $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69dc $dc
    mG_11                                              ;; 0e:69dd $b7
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:69de $e0 $5b $7a
    mOCTAVE_PLUS_1                                     ;; 0e:69e1 $d8
    mG_11                                              ;; 0e:69e2 $b7
    mC_11                                              ;; 0e:69e3 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69e4 $dc
    mG_11                                              ;; 0e:69e5 $b7
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:69e6 $e0 $59 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:69e9 $d8
    mG_11                                              ;; 0e:69ea $b7
    mC_11                                              ;; 0e:69eb $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69ec $dc
    mG_11                                              ;; 0e:69ed $b7
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:69ee $e0 $57 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:69f1 $d8
    mG_11                                              ;; 0e:69f2 $b7
    mC_11                                              ;; 0e:69f3 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69f4 $dc
    mG_11                                              ;; 0e:69f5 $b7
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:69f6 $e0 $55 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:69f9 $d8
    mG_11                                              ;; 0e:69fa $b7
    mC_11                                              ;; 0e:69fb $b0
    mOCTAVE_MINUS_1                                    ;; 0e:69fc $dc
    mG_11                                              ;; 0e:69fd $b7
    mSTEREOPAN $01                                     ;; 0e:69fe $e6 $01
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6a00 $e0 $53 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a03 $d8
    mGis_11                                            ;; 0e:6a04 $b8
    mC_11                                              ;; 0e:6a05 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6a06 $dc
    mGis_11                                            ;; 0e:6a07 $b8
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6a08 $e0 $55 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a0b $d8
    mGis_11                                            ;; 0e:6a0c $b8
    mC_11                                              ;; 0e:6a0d $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6a0e $dc
    mGis_11                                            ;; 0e:6a0f $b8
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:6a10 $e0 $57 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a13 $d8
    mGis_11                                            ;; 0e:6a14 $b8
    mC_11                                              ;; 0e:6a15 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6a16 $dc
    mGis_11                                            ;; 0e:6a17 $b8
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:6a18 $e0 $59 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a1b $d8
    mGis_11                                            ;; 0e:6a1c $b8
    mC_11                                              ;; 0e:6a1d $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6a1e $dc
    mGis_11                                            ;; 0e:6a1f $b8
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:6a20 $e0 $5b $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a23 $d8
    mGis_11                                            ;; 0e:6a24 $b8
    mC_11                                              ;; 0e:6a25 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6a26 $dc
    mGis_11                                            ;; 0e:6a27 $b8
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:6a28 $e0 $5d $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a2b $d8
    mGis_11                                            ;; 0e:6a2c $b8
    mC_11                                              ;; 0e:6a2d $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6a2e $dc
    mGis_11                                            ;; 0e:6a2f $b8
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:6a30 $e0 $5f $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a33 $d8
    mGis_11                                            ;; 0e:6a34 $b8
    mC_11                                              ;; 0e:6a35 $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6a36 $dc
    mGis_11                                            ;; 0e:6a37 $b8
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:6a38 $e0 $61 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a3b $d8
    mGis_11                                            ;; 0e:6a3c $b8
    mC_11                                              ;; 0e:6a3d $b0
    mOCTAVE_MINUS_1                                    ;; 0e:6a3e $dc
    mGis_11                                            ;; 0e:6a3f $b8
    mSTEREOPAN $03                                     ;; 0e:6a40 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:6a42 $e0 $63 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a45 $d8
    mAis_11                                            ;; 0e:6a46 $ba
    mD_11                                              ;; 0e:6a47 $b2
    mOCTAVE_MINUS_1                                    ;; 0e:6a48 $dc
    mAis_11                                            ;; 0e:6a49 $ba
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:6a4a $e0 $61 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a4d $d8
    mAis_11                                            ;; 0e:6a4e $ba
    mD_11                                              ;; 0e:6a4f $b2
    mOCTAVE_MINUS_1                                    ;; 0e:6a50 $dc
    mAis_11                                            ;; 0e:6a51 $ba
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:6a52 $e0 $5f $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a55 $d8
    mAis_11                                            ;; 0e:6a56 $ba
    mD_11                                              ;; 0e:6a57 $b2
    mOCTAVE_MINUS_1                                    ;; 0e:6a58 $dc
    mAis_11                                            ;; 0e:6a59 $ba
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:6a5a $e0 $5d $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a5d $d8
    mAis_11                                            ;; 0e:6a5e $ba
    mD_11                                              ;; 0e:6a5f $b2
    mOCTAVE_MINUS_1                                    ;; 0e:6a60 $dc
    mAis_11                                            ;; 0e:6a61 $ba
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:6a62 $e0 $5b $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a65 $d8
    mAis_11                                            ;; 0e:6a66 $ba
    mD_11                                              ;; 0e:6a67 $b2
    mOCTAVE_MINUS_1                                    ;; 0e:6a68 $dc
    mAis_11                                            ;; 0e:6a69 $ba
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:6a6a $e0 $59 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a6d $d8
    mAis_11                                            ;; 0e:6a6e $ba
    mD_11                                              ;; 0e:6a6f $b2
    mOCTAVE_MINUS_1                                    ;; 0e:6a70 $dc
    mAis_11                                            ;; 0e:6a71 $ba
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:6a72 $e0 $57 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a75 $d8
    mAis_11                                            ;; 0e:6a76 $ba
    mD_11                                              ;; 0e:6a77 $b2
    mOCTAVE_MINUS_1                                    ;; 0e:6a78 $dc
    mAis_11                                            ;; 0e:6a79 $ba
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:6a7a $e0 $55 $7a
    mOCTAVE_PLUS_1                                     ;; 0e:6a7d $d8
    mAis_11                                            ;; 0e:6a7e $ba
    mD_11                                              ;; 0e:6a7f $b2
    mOCTAVE_MINUS_1                                    ;; 0e:6a80 $dc
    mAis_11                                            ;; 0e:6a81 $ba
    mREPEAT .data_0e_697a                              ;; 0e:6a82 $e2 $7a $69
    mTEMPO $9b                                         ;; 0e:6a85 $e7 $9b
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6a87 $e0 $53 $7a
    mF_10                                              ;; 0e:6a8a $a5
    mRest_10                                           ;; 0e:6a8b $af
    mF_10                                              ;; 0e:6a8c $a5
    mRest_10                                           ;; 0e:6a8d $af
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:6a8e $e0 $63 $7a
    mSTEREOPAN $02                                     ;; 0e:6a91 $e6 $02
    mF_10                                              ;; 0e:6a93 $a5
    mRest_10                                           ;; 0e:6a94 $af
    mSTEREOPAN $01                                     ;; 0e:6a95 $e6 $01
    mF_10                                              ;; 0e:6a97 $a5
    mRest_10                                           ;; 0e:6a98 $af
    mSTEREOPAN $02                                     ;; 0e:6a99 $e6 $02
    mF_10                                              ;; 0e:6a9b $a5
    mRest_10                                           ;; 0e:6a9c $af
    mSTEREOPAN $03                                     ;; 0e:6a9d $e6 $03
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6a9f $e0 $53 $7a
    mG_4                                               ;; 0e:6aa2 $47
    mGis_4                                             ;; 0e:6aa3 $48
    mAis_4                                             ;; 0e:6aa4 $4a
    mCPlus_5                                           ;; 0e:6aa5 $5c
    mF_10                                              ;; 0e:6aa6 $a5
    mRest_10                                           ;; 0e:6aa7 $af
    mF_10                                              ;; 0e:6aa8 $a5
    mRest_10                                           ;; 0e:6aa9 $af
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:6aaa $e0 $63 $7a
    mSTEREOPAN $02                                     ;; 0e:6aad $e6 $02
    mF_10                                              ;; 0e:6aaf $a5
    mRest_10                                           ;; 0e:6ab0 $af
    mSTEREOPAN $01                                     ;; 0e:6ab1 $e6 $01
    mF_10                                              ;; 0e:6ab3 $a5
    mRest_10                                           ;; 0e:6ab4 $af
    mSTEREOPAN $02                                     ;; 0e:6ab5 $e6 $02
    mF_10                                              ;; 0e:6ab7 $a5
    mRest_10                                           ;; 0e:6ab8 $af
    mSTEREOPAN $03                                     ;; 0e:6ab9 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6abb $e0 $53 $7a
    mG_4                                               ;; 0e:6abe $47
    mGis_4                                             ;; 0e:6abf $48
    mAis_4                                             ;; 0e:6ac0 $4a
    mCPlus_5                                           ;; 0e:6ac1 $5c
    mOCTAVE_PLUS_1                                     ;; 0e:6ac2 $d8
    mCOUNTER $02                                       ;; 0e:6ac3 $e3 $02
.data_0e_6ac5:
    mSTEREOPAN $02                                     ;; 0e:6ac5 $e6 $02
    mF_10                                              ;; 0e:6ac7 $a5
    mOCTAVE_PLUS_1                                     ;; 0e:6ac8 $d8
    mF_10                                              ;; 0e:6ac9 $a5
    mOCTAVE_MINUS_1                                    ;; 0e:6aca $dc
    mC_10                                              ;; 0e:6acb $a0
    mCPlus_10                                          ;; 0e:6acc $ac
    mSTEREOPAN $03                                     ;; 0e:6acd $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:6acf $dc
    mB_10                                              ;; 0e:6ad0 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6ad1 $d8
    mB_10                                              ;; 0e:6ad2 $ab
    mF_10                                              ;; 0e:6ad3 $a5
    mOCTAVE_PLUS_1                                     ;; 0e:6ad4 $d8
    mF_10                                              ;; 0e:6ad5 $a5
    mSTEREOPAN $01                                     ;; 0e:6ad6 $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:6ad8 $dc
    mE_10                                              ;; 0e:6ad9 $a4
    mOCTAVE_PLUS_1                                     ;; 0e:6ada $d8
    mE_10                                              ;; 0e:6adb $a4
    mOCTAVE_MINUS_2                                    ;; 0e:6adc $dd
    mB_10                                              ;; 0e:6add $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6ade $d8
    mB_10                                              ;; 0e:6adf $ab
    mSTEREOPAN $03                                     ;; 0e:6ae0 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:6ae2 $dc
    mAis_10                                            ;; 0e:6ae3 $aa
    mOCTAVE_PLUS_1                                     ;; 0e:6ae4 $d8
    mAis_10                                            ;; 0e:6ae5 $aa
    mE_10                                              ;; 0e:6ae6 $a4
    mOCTAVE_PLUS_1                                     ;; 0e:6ae7 $d8
    mE_10                                              ;; 0e:6ae8 $a4
    mSTEREOPAN $02                                     ;; 0e:6ae9 $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:6aeb $dc
    mDis_10                                            ;; 0e:6aec $a3
    mOCTAVE_PLUS_1                                     ;; 0e:6aed $d8
    mDis_10                                            ;; 0e:6aee $a3
    mOCTAVE_MINUS_2                                    ;; 0e:6aef $dd
    mAis_10                                            ;; 0e:6af0 $aa
    mOCTAVE_PLUS_1                                     ;; 0e:6af1 $d8
    mAis_10                                            ;; 0e:6af2 $aa
    mSTEREOPAN $03                                     ;; 0e:6af3 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:6af5 $dc
    mA_10                                              ;; 0e:6af6 $a9
    mOCTAVE_PLUS_1                                     ;; 0e:6af7 $d8
    mA_10                                              ;; 0e:6af8 $a9
    mDis_10                                            ;; 0e:6af9 $a3
    mOCTAVE_PLUS_1                                     ;; 0e:6afa $d8
    mDis_10                                            ;; 0e:6afb $a3
    mJUMPIF $01, .data_0e_6b17                         ;; 0e:6afc $eb $01 $17 $6b
    mSTEREOPAN $01                                     ;; 0e:6b00 $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:6b02 $dc
    mE_10                                              ;; 0e:6b03 $a4
    mOCTAVE_PLUS_1                                     ;; 0e:6b04 $d8
    mE_10                                              ;; 0e:6b05 $a4
    mOCTAVE_MINUS_2                                    ;; 0e:6b06 $dd
    mB_10                                              ;; 0e:6b07 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6b08 $d8
    mB_10                                              ;; 0e:6b09 $ab
    mSTEREOPAN $03                                     ;; 0e:6b0a $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:6b0c $dc
    mAis_10                                            ;; 0e:6b0d $aa
    mOCTAVE_PLUS_1                                     ;; 0e:6b0e $d8
    mAis_10                                            ;; 0e:6b0f $aa
    mE_10                                              ;; 0e:6b10 $a4
    mOCTAVE_PLUS_1                                     ;; 0e:6b11 $d8
    mE_10                                              ;; 0e:6b12 $a4
    mOCTAVE_MINUS_1                                    ;; 0e:6b13 $dc
    mREPEAT .data_0e_6ac5                              ;; 0e:6b14 $e2 $c5 $6a
.data_0e_6b17:
    mSTEREOPAN $01                                     ;; 0e:6b17 $e6 $01
    mOCTAVE_MINUS_1                                    ;; 0e:6b19 $dc
    mD_10                                              ;; 0e:6b1a $a2
    mOCTAVE_PLUS_1                                     ;; 0e:6b1b $d8
    mD_10                                              ;; 0e:6b1c $a2
    mOCTAVE_MINUS_2                                    ;; 0e:6b1d $dd
    mA_10                                              ;; 0e:6b1e $a9
    mOCTAVE_PLUS_1                                     ;; 0e:6b1f $d8
    mA_10                                              ;; 0e:6b20 $a9
    mSTEREOPAN $03                                     ;; 0e:6b21 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:6b23 $dc
    mGis_10                                            ;; 0e:6b24 $a8
    mOCTAVE_PLUS_1                                     ;; 0e:6b25 $d8
    mGis_10                                            ;; 0e:6b26 $a8
    mD_10                                              ;; 0e:6b27 $a2
    mOCTAVE_PLUS_1                                     ;; 0e:6b28 $d8
    mD_10                                              ;; 0e:6b29 $a2
    mOCTAVE_MINUS_2                                    ;; 0e:6b2a $dd
    mF_10                                              ;; 0e:6b2b $a5
    mRest_10                                           ;; 0e:6b2c $af
    mF_10                                              ;; 0e:6b2d $a5
    mRest_10                                           ;; 0e:6b2e $af
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:6b2f $e0 $63 $7a
    mSTEREOPAN $02                                     ;; 0e:6b32 $e6 $02
    mF_10                                              ;; 0e:6b34 $a5
    mRest_10                                           ;; 0e:6b35 $af
    mSTEREOPAN $01                                     ;; 0e:6b36 $e6 $01
    mF_10                                              ;; 0e:6b38 $a5
    mRest_10                                           ;; 0e:6b39 $af
    mSTEREOPAN $02                                     ;; 0e:6b3a $e6 $02
    mF_10                                              ;; 0e:6b3c $a5
    mRest_10                                           ;; 0e:6b3d $af
    mSTEREOPAN $03                                     ;; 0e:6b3e $e6 $03
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6b40 $e0 $53 $7a
    mG_4                                               ;; 0e:6b43 $47
    mGis_4                                             ;; 0e:6b44 $48
    mAis_4                                             ;; 0e:6b45 $4a
    mCPlus_5                                           ;; 0e:6b46 $5c
    mF_10                                              ;; 0e:6b47 $a5
    mRest_10                                           ;; 0e:6b48 $af
    mF_10                                              ;; 0e:6b49 $a5
    mRest_10                                           ;; 0e:6b4a $af
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:6b4b $e0 $63 $7a
    mSTEREOPAN $02                                     ;; 0e:6b4e $e6 $02
    mF_10                                              ;; 0e:6b50 $a5
    mRest_10                                           ;; 0e:6b51 $af
    mSTEREOPAN $01                                     ;; 0e:6b52 $e6 $01
    mF_10                                              ;; 0e:6b54 $a5
    mRest_10                                           ;; 0e:6b55 $af
    mSTEREOPAN $02                                     ;; 0e:6b56 $e6 $02
    mF_10                                              ;; 0e:6b58 $a5
    mRest_10                                           ;; 0e:6b59 $af
    mSTEREOPAN $03                                     ;; 0e:6b5a $e6 $03
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6b5c $e0 $53 $7a
    mG_4                                               ;; 0e:6b5f $47
    mGis_4                                             ;; 0e:6b60 $48
    mAis_4                                             ;; 0e:6b61 $4a
    mCPlus_5                                           ;; 0e:6b62 $5c
.data_0e_6b63:
    mDUTYCYCLE $40                                     ;; 0e:6b63 $e5 $40
    mVIBRATO frequencyDeltaData.third                  ;; 0e:6b65 $e4 $12 $7a
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6b68 $e0 $53 $7a
    mCPlus_5                                           ;; 0e:6b6b $5c
    mOCTAVE_PLUS_1                                     ;; 0e:6b6c $d8
    mDis_5                                             ;; 0e:6b6d $53
    mD_5                                               ;; 0e:6b6e $52
    mC_5                                               ;; 0e:6b6f $50
    mF_5                                               ;; 0e:6b70 $55
    mDis_8                                             ;; 0e:6b71 $83
    mD_5                                               ;; 0e:6b72 $52
    mD_8                                               ;; 0e:6b73 $82
    mC_5                                               ;; 0e:6b74 $50
    mG_5                                               ;; 0e:6b75 $57
    mF_5                                               ;; 0e:6b76 $55
    mDis_5                                             ;; 0e:6b77 $53
    mD_5                                               ;; 0e:6b78 $52
    mF_5                                               ;; 0e:6b79 $55
    mDis_8                                             ;; 0e:6b7a $83
    mD_5                                               ;; 0e:6b7b $52
    mD_8                                               ;; 0e:6b7c $82
    mC_5                                               ;; 0e:6b7d $50
    mOCTAVE_MINUS_1                                    ;; 0e:6b7e $dc
    mB_10                                              ;; 0e:6b7f $ab
    mCPlus_10                                          ;; 0e:6b80 $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6b81 $d8
    mD_10                                              ;; 0e:6b82 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6b83 $dc
    mB_10                                              ;; 0e:6b84 $ab
    mG_2                                               ;; 0e:6b85 $27
    mSTEREOPAN $01                                     ;; 0e:6b86 $e6 $01
    mOCTAVE_PLUS_1                                     ;; 0e:6b88 $d8
    mD_10                                              ;; 0e:6b89 $a2
    mDis_10                                            ;; 0e:6b8a $a3
    mF_10                                              ;; 0e:6b8b $a5
    mD_10                                              ;; 0e:6b8c $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6b8d $dc
    mB_8                                               ;; 0e:6b8e $8b
    mSTEREOPAN $03                                     ;; 0e:6b8f $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:6b91 $d8
    mF_10                                              ;; 0e:6b92 $a5
    mG_10                                              ;; 0e:6b93 $a7
    mGis_10                                            ;; 0e:6b94 $a8
    mF_10                                              ;; 0e:6b95 $a5
    mD_8                                               ;; 0e:6b96 $82
    mSTEREOPAN $02                                     ;; 0e:6b97 $e6 $02
    mB_10                                              ;; 0e:6b99 $ab
    mCPlus_10                                          ;; 0e:6b9a $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6b9b $d8
    mD_10                                              ;; 0e:6b9c $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6b9d $dc
    mB_10                                              ;; 0e:6b9e $ab
    mG_5                                               ;; 0e:6b9f $57
    mSTEREOPAN $03                                     ;; 0e:6ba0 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a3b                      ;; 0e:6ba2 $e0 $3b $7a
    mDUTYCYCLE $00                                     ;; 0e:6ba5 $e5 $00
    mD_10                                              ;; 0e:6ba7 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6ba8 $dc
    mG_10                                              ;; 0e:6ba9 $a7
    mB_10                                              ;; 0e:6baa $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6bab $d8
    mF_10                                              ;; 0e:6bac $a5
    mDis_10                                            ;; 0e:6bad $a3
    mCis_10                                            ;; 0e:6bae $a1
    mD_10                                              ;; 0e:6baf $a2
    mAis_10                                            ;; 0e:6bb0 $aa
    mGis_10                                            ;; 0e:6bb1 $a8
    mFis_10                                            ;; 0e:6bb2 $a6
    mG_10                                              ;; 0e:6bb3 $a7
    mOCTAVE_PLUS_1                                     ;; 0e:6bb4 $d8
    mDis_10                                            ;; 0e:6bb5 $a3
    mD_10                                              ;; 0e:6bb6 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6bb7 $dc
    mAis_10                                            ;; 0e:6bb8 $aa
    mB_10                                              ;; 0e:6bb9 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6bba $d8
    mF_10                                              ;; 0e:6bbb $a5
    mSTEREOPAN $01                                     ;; 0e:6bbc $e6 $01
    mG_8                                               ;; 0e:6bbe $87
    mOCTAVE_MINUS_1                                    ;; 0e:6bbf $dc
    mG_12                                              ;; 0e:6bc0 $c7
    mRest_12                                           ;; 0e:6bc1 $cf
    mG_12                                              ;; 0e:6bc2 $c7
    mRest_12                                           ;; 0e:6bc3 $cf
    mSTEREOPAN $02                                     ;; 0e:6bc4 $e6 $02
    mOCTAVE_PLUS_1                                     ;; 0e:6bc6 $d8
    mF_8                                               ;; 0e:6bc7 $85
    mOCTAVE_MINUS_1                                    ;; 0e:6bc8 $dc
    mG_12                                              ;; 0e:6bc9 $c7
    mRest_12                                           ;; 0e:6bca $cf
    mG_12                                              ;; 0e:6bcb $c7
    mRest_12                                           ;; 0e:6bcc $cf
    mSTEREOPAN $01                                     ;; 0e:6bcd $e6 $01
    mOCTAVE_PLUS_1                                     ;; 0e:6bcf $d8
    mDis_8                                             ;; 0e:6bd0 $83
    mOCTAVE_MINUS_1                                    ;; 0e:6bd1 $dc
    mG_12                                              ;; 0e:6bd2 $c7
    mRest_12                                           ;; 0e:6bd3 $cf
    mG_12                                              ;; 0e:6bd4 $c7
    mRest_12                                           ;; 0e:6bd5 $cf
    mSTEREOPAN $03                                     ;; 0e:6bd6 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:6bd8 $d8
    mD_10                                              ;; 0e:6bd9 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6bda $dc
    mB_10                                              ;; 0e:6bdb $ab
    mG_10                                              ;; 0e:6bdc $a7
    mB_10                                              ;; 0e:6bdd $ab
    mVOLUME_ENVELOPE data_0e_7a53                      ;; 0e:6bde $e0 $53 $7a
    mDUTYCYCLE $40                                     ;; 0e:6be1 $e5 $40
    mC_5                                               ;; 0e:6be3 $50
    mDis_5                                             ;; 0e:6be4 $53
    mD_5                                               ;; 0e:6be5 $52
    mC_5                                               ;; 0e:6be6 $50
    mF_5                                               ;; 0e:6be7 $55
    mDis_8                                             ;; 0e:6be8 $83
    mD_5                                               ;; 0e:6be9 $52
    mD_8                                               ;; 0e:6bea $82
    mC_5                                               ;; 0e:6beb $50
    mG_5                                               ;; 0e:6bec $57
    mF_5                                               ;; 0e:6bed $55
    mDis_5                                             ;; 0e:6bee $53
    mD_5                                               ;; 0e:6bef $52
    mF_5                                               ;; 0e:6bf0 $55
    mDis_8                                             ;; 0e:6bf1 $83
    mD_5                                               ;; 0e:6bf2 $52
    mD_8                                               ;; 0e:6bf3 $82
    mC_5                                               ;; 0e:6bf4 $50
    mOCTAVE_MINUS_1                                    ;; 0e:6bf5 $dc
    mB_10                                              ;; 0e:6bf6 $ab
    mCPlus_10                                          ;; 0e:6bf7 $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6bf8 $d8
    mD_10                                              ;; 0e:6bf9 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6bfa $dc
    mB_10                                              ;; 0e:6bfb $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6bfc $d8
    mG_2                                               ;; 0e:6bfd $27
    mSTEREOPAN $01                                     ;; 0e:6bfe $e6 $01
    mB_10                                              ;; 0e:6c00 $ab
    mCPlus_10                                          ;; 0e:6c01 $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6c02 $d8
    mD_10                                              ;; 0e:6c03 $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6c04 $dc
    mB_10                                              ;; 0e:6c05 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6c06 $d8
    mG_8                                               ;; 0e:6c07 $87
    mSTEREOPAN $02                                     ;; 0e:6c08 $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:6c0a $dc
    mB_10                                              ;; 0e:6c0b $ab
    mCPlus_10                                          ;; 0e:6c0c $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6c0d $d8
    mD_10                                              ;; 0e:6c0e $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6c0f $dc
    mB_10                                              ;; 0e:6c10 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6c11 $d8
    mF_8                                               ;; 0e:6c12 $85
    mSTEREOPAN $03                                     ;; 0e:6c13 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a3b                      ;; 0e:6c15 $e0 $3b $7a
    mDUTYCYCLE $00                                     ;; 0e:6c18 $e5 $00
    mOCTAVE_MINUS_1                                    ;; 0e:6c1a $dc
    mB_10                                              ;; 0e:6c1b $ab
    mCPlus_10                                          ;; 0e:6c1c $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6c1d $d8
    mD_10                                              ;; 0e:6c1e $a2
    mOCTAVE_MINUS_1                                    ;; 0e:6c1f $dc
    mB_10                                              ;; 0e:6c20 $ab
    mOCTAVE_PLUS_1                                     ;; 0e:6c21 $d8
    mDis_10                                            ;; 0e:6c22 $a3
    mD_10                                              ;; 0e:6c23 $a2
    mC_10                                              ;; 0e:6c24 $a0
    mOCTAVE_MINUS_1                                    ;; 0e:6c25 $dc
    mB_10                                              ;; 0e:6c26 $ab
    mDUTYCYCLE $80                                     ;; 0e:6c27 $e5 $80
    mG_10                                              ;; 0e:6c29 $a7
    mGis_10                                            ;; 0e:6c2a $a8
    mG_10                                              ;; 0e:6c2b $a7
    mF_10                                              ;; 0e:6c2c $a5
    mDis_10                                            ;; 0e:6c2d $a3
    mD_10                                              ;; 0e:6c2e $a2
    mF_10                                              ;; 0e:6c2f $a5
    mDis_10                                            ;; 0e:6c30 $a3
    mDUTYCYCLE $40                                     ;; 0e:6c31 $e5 $40
    mD_10                                              ;; 0e:6c33 $a2
    mDis_10                                            ;; 0e:6c34 $a3
    mD_10                                              ;; 0e:6c35 $a2
    mC_10                                              ;; 0e:6c36 $a0
    mOCTAVE_MINUS_1                                    ;; 0e:6c37 $dc
    mB_10                                              ;; 0e:6c38 $ab
    mG_10                                              ;; 0e:6c39 $a7
    mOCTAVE_PLUS_1                                     ;; 0e:6c3a $d8
    mD_10                                              ;; 0e:6c3b $a2
    mC_10                                              ;; 0e:6c3c $a0
    mDUTYCYCLE $00                                     ;; 0e:6c3d $e5 $00
    mOCTAVE_MINUS_1                                    ;; 0e:6c3f $dc
    mB_10                                              ;; 0e:6c40 $ab
    mCPlus_10                                          ;; 0e:6c41 $ac
    mB_10                                              ;; 0e:6c42 $ab
    mG_10                                              ;; 0e:6c43 $a7
    mGis_10                                            ;; 0e:6c44 $a8
    mAis_10                                            ;; 0e:6c45 $aa
    mGis_10                                            ;; 0e:6c46 $a8
    mF_10                                              ;; 0e:6c47 $a5
    mDUTYCYCLE $80                                     ;; 0e:6c48 $e5 $80
    mG_10                                              ;; 0e:6c4a $a7
    mGis_10                                            ;; 0e:6c4b $a8
    mAis_10                                            ;; 0e:6c4c $aa
    mB_10                                              ;; 0e:6c4d $ab
    mCPlus_10                                          ;; 0e:6c4e $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6c4f $d8
    mD_10                                              ;; 0e:6c50 $a2
    mDis_10                                            ;; 0e:6c51 $a3
    mF_10                                              ;; 0e:6c52 $a5
    mVIBRATO frequencyDeltaData                        ;; 0e:6c53 $e4 $fe $79
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:6c56 $e0 $31 $7a
    mDUTYCYCLE $40                                     ;; 0e:6c59 $e5 $40
    mG_8                                               ;; 0e:6c5b $87
    mF_8                                               ;; 0e:6c5c $85
    mC_8                                               ;; 0e:6c5d $80
    mOCTAVE_MINUS_1                                    ;; 0e:6c5e $dc
    mGis_8                                             ;; 0e:6c5f $88
    mG_8                                               ;; 0e:6c60 $87
    mF_8                                               ;; 0e:6c61 $85
    mOCTAVE_PLUS_1                                     ;; 0e:6c62 $d8
    mDis_8                                             ;; 0e:6c63 $83
    mD_1                                               ;; 0e:6c64 $12
    mD_8                                               ;; 0e:6c65 $82
    mDis_8                                             ;; 0e:6c66 $83
    mF_8                                               ;; 0e:6c67 $85
    mD_5                                               ;; 0e:6c68 $52
    mD_5                                               ;; 0e:6c69 $52
    mDis_5                                             ;; 0e:6c6a $53
    mF_5                                               ;; 0e:6c6b $55
    mG_5                                               ;; 0e:6c6c $57
    mGis_8                                             ;; 0e:6c6d $88
    mG_8                                               ;; 0e:6c6e $87
    mF_8                                               ;; 0e:6c6f $85
    mG_8                                               ;; 0e:6c70 $87
    mF_8                                               ;; 0e:6c71 $85
    mDis_0                                             ;; 0e:6c72 $03
    mD_10                                              ;; 0e:6c73 $a2
    mDis_10                                            ;; 0e:6c74 $a3
    mF_5                                               ;; 0e:6c75 $55
    mDis_5                                             ;; 0e:6c76 $53
    mD_8                                               ;; 0e:6c77 $82
    mC_8                                               ;; 0e:6c78 $80
    mDis_8                                             ;; 0e:6c79 $83
    mD_0                                               ;; 0e:6c7a $02
    mWait_0                                            ;; 0e:6c7b $0e
    mRest_8                                            ;; 0e:6c7c $8f
    mOCTAVE_MINUS_1                                    ;; 0e:6c7d $dc
    mJUMP .data_0e_6b63                                ;; 0e:6c7e $e1 $63 $6b

song12_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:6c81 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:6c84 $e0 $57 $7a
    mDUTYCYCLE $00                                     ;; 0e:6c87 $e5 $00
    mCOUNTER $02                                       ;; 0e:6c89 $e3 $02
.data_0e_6c8b:
    mSTEREOPAN $01                                     ;; 0e:6c8b $e6 $01
    mOCTAVE_1                                          ;; 0e:6c8d $d1
    mGis_10                                            ;; 0e:6c8e $a8
    mAis_10                                            ;; 0e:6c8f $aa
    mCPlus_8                                           ;; 0e:6c90 $8c
    mG_10                                              ;; 0e:6c91 $a7
    mGis_10                                            ;; 0e:6c92 $a8
    mAis_8                                             ;; 0e:6c93 $8a
    mGis_10                                            ;; 0e:6c94 $a8
    mAis_10                                            ;; 0e:6c95 $aa
    mCPlus_8                                           ;; 0e:6c96 $8c
    mG_10                                              ;; 0e:6c97 $a7
    mGis_10                                            ;; 0e:6c98 $a8
    mAis_10                                            ;; 0e:6c99 $aa
    mCPlus_10                                          ;; 0e:6c9a $ac
    mOCTAVE_1                                          ;; 0e:6c9b $d1
    mGis_10                                            ;; 0e:6c9c $a8
    mAis_10                                            ;; 0e:6c9d $aa
    mCPlus_8                                           ;; 0e:6c9e $8c
    mG_10                                              ;; 0e:6c9f $a7
    mGis_10                                            ;; 0e:6ca0 $a8
    mAis_8                                             ;; 0e:6ca1 $8a
    mGis_10                                            ;; 0e:6ca2 $a8
    mAis_10                                            ;; 0e:6ca3 $aa
    mCPlus_8                                           ;; 0e:6ca4 $8c
    mG_10                                              ;; 0e:6ca5 $a7
    mGis_10                                            ;; 0e:6ca6 $a8
    mAis_10                                            ;; 0e:6ca7 $aa
    mCPlus_10                                          ;; 0e:6ca8 $ac
    mSTEREOPAN $02                                     ;; 0e:6ca9 $e6 $02
    mOCTAVE_1                                          ;; 0e:6cab $d1
    mGis_10                                            ;; 0e:6cac $a8
    mAis_10                                            ;; 0e:6cad $aa
    mCPlus_8                                           ;; 0e:6cae $8c
    mG_10                                              ;; 0e:6caf $a7
    mGis_10                                            ;; 0e:6cb0 $a8
    mAis_8                                             ;; 0e:6cb1 $8a
    mGis_10                                            ;; 0e:6cb2 $a8
    mAis_10                                            ;; 0e:6cb3 $aa
    mCPlus_8                                           ;; 0e:6cb4 $8c
    mG_10                                              ;; 0e:6cb5 $a7
    mGis_10                                            ;; 0e:6cb6 $a8
    mAis_10                                            ;; 0e:6cb7 $aa
    mCPlus_10                                          ;; 0e:6cb8 $ac
    mGis_10                                            ;; 0e:6cb9 $a8
    mAis_10                                            ;; 0e:6cba $aa
    mCPlus_8                                           ;; 0e:6cbb $8c
    mG_10                                              ;; 0e:6cbc $a7
    mGis_10                                            ;; 0e:6cbd $a8
    mAis_8                                             ;; 0e:6cbe $8a
    mF_10                                              ;; 0e:6cbf $a5
    mG_10                                              ;; 0e:6cc0 $a7
    mGis_10                                            ;; 0e:6cc1 $a8
    mAis_10                                            ;; 0e:6cc2 $aa
    mCPlus_10                                          ;; 0e:6cc3 $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6cc4 $d8
    mD_10                                              ;; 0e:6cc5 $a2
    mDis_10                                            ;; 0e:6cc6 $a3
    mF_10                                              ;; 0e:6cc7 $a5
    mREPEAT .data_0e_6c8b                              ;; 0e:6cc8 $e2 $8b $6c
    mOCTAVE_MINUS_1                                    ;; 0e:6ccb $dc
    mCOUNTER $02                                       ;; 0e:6ccc $e3 $02
.data_0e_6cce:
    mSTEREOPAN $03                                     ;; 0e:6cce $e6 $03
    mDUTYCYCLE $40                                     ;; 0e:6cd0 $e5 $40
    mC_10                                              ;; 0e:6cd2 $a0
    mRest_10                                           ;; 0e:6cd3 $af
    mC_10                                              ;; 0e:6cd4 $a0
    mRest_10                                           ;; 0e:6cd5 $af
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:6cd6 $e0 $65 $7a
    mSTEREOPAN $02                                     ;; 0e:6cd9 $e6 $02
    mC_10                                              ;; 0e:6cdb $a0
    mRest_10                                           ;; 0e:6cdc $af
    mSTEREOPAN $01                                     ;; 0e:6cdd $e6 $01
    mC_10                                              ;; 0e:6cdf $a0
    mRest_10                                           ;; 0e:6ce0 $af
    mSTEREOPAN $02                                     ;; 0e:6ce1 $e6 $02
    mC_10                                              ;; 0e:6ce3 $a0
    mRest_10                                           ;; 0e:6ce4 $af
    mSTEREOPAN $03                                     ;; 0e:6ce5 $e6 $03
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:6ce7 $e0 $57 $7a
    mD_4                                               ;; 0e:6cea $42
    mDis_4                                             ;; 0e:6ceb $43
    mF_4                                               ;; 0e:6cec $45
    mGis_5                                             ;; 0e:6ced $58
    mC_10                                              ;; 0e:6cee $a0
    mRest_10                                           ;; 0e:6cef $af
    mC_10                                              ;; 0e:6cf0 $a0
    mRest_10                                           ;; 0e:6cf1 $af
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:6cf2 $e0 $65 $7a
    mSTEREOPAN $02                                     ;; 0e:6cf5 $e6 $02
    mC_10                                              ;; 0e:6cf7 $a0
    mRest_10                                           ;; 0e:6cf8 $af
    mSTEREOPAN $01                                     ;; 0e:6cf9 $e6 $01
    mC_10                                              ;; 0e:6cfb $a0
    mRest_10                                           ;; 0e:6cfc $af
    mSTEREOPAN $02                                     ;; 0e:6cfd $e6 $02
    mC_10                                              ;; 0e:6cff $a0
    mRest_10                                           ;; 0e:6d00 $af
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:6d01 $e0 $57 $7a
    mSTEREOPAN $03                                     ;; 0e:6d04 $e6 $03
    mD_4                                               ;; 0e:6d06 $42
    mDis_4                                             ;; 0e:6d07 $43
    mF_4                                               ;; 0e:6d08 $45
    mGis_5                                             ;; 0e:6d09 $58
    mJUMPIF $01, .data_0e_6d38                         ;; 0e:6d0a $eb $01 $38 $6d
    mC_10                                              ;; 0e:6d0e $a0
    mRest_10                                           ;; 0e:6d0f $af
    mC_10                                              ;; 0e:6d10 $a0
    mRest_10                                           ;; 0e:6d11 $af
    mRest_4                                            ;; 0e:6d12 $4f
    mOCTAVE_MINUS_1                                    ;; 0e:6d13 $dc
    mG_4                                               ;; 0e:6d14 $47
    mAis_10                                            ;; 0e:6d15 $aa
    mRest_10                                           ;; 0e:6d16 $af
    mAis_10                                            ;; 0e:6d17 $aa
    mRest_10                                           ;; 0e:6d18 $af
    mRest_4                                            ;; 0e:6d19 $4f
    mFis_4                                             ;; 0e:6d1a $46
    mGis_10                                            ;; 0e:6d1b $a8
    mRest_10                                           ;; 0e:6d1c $af
    mGis_10                                            ;; 0e:6d1d $a8
    mRest_10                                           ;; 0e:6d1e $af
    mRest_4                                            ;; 0e:6d1f $4f
    mB_4                                               ;; 0e:6d20 $4b
    mAis_10                                            ;; 0e:6d21 $aa
    mRest_10                                           ;; 0e:6d22 $af
    mAis_10                                            ;; 0e:6d23 $aa
    mRest_10                                           ;; 0e:6d24 $af
    mRest_5                                            ;; 0e:6d25 $5f
    mSTEREOPAN $02                                     ;; 0e:6d26 $e6 $02
    mDis_10                                            ;; 0e:6d28 $a3
    mE_10                                              ;; 0e:6d29 $a4
    mF_10                                              ;; 0e:6d2a $a5
    mSTEREOPAN $03                                     ;; 0e:6d2b $e6 $03
    mFis_10                                            ;; 0e:6d2d $a6
    mG_10                                              ;; 0e:6d2e $a7
    mGis_10                                            ;; 0e:6d2f $a8
    mSTEREOPAN $01                                     ;; 0e:6d30 $e6 $01
    mA_10                                              ;; 0e:6d32 $a9
    mAis_10                                            ;; 0e:6d33 $aa
    mOCTAVE_PLUS_1                                     ;; 0e:6d34 $d8
    mREPEAT .data_0e_6cce                              ;; 0e:6d35 $e2 $ce $6c
.data_0e_6d38:
    mCOUNTER_2 $02                                     ;; 0e:6d38 $ea $02
.data_0e_6d3a:
    mCOUNTER $0a                                       ;; 0e:6d3a $e3 $0a
.data_0e_6d3c:
    mDUTYCYCLE $00                                     ;; 0e:6d3c $e5 $00
    mVOLUME_ENVELOPE data_0e_7a43                      ;; 0e:6d3e $e0 $43 $7a
    mSTEREOPAN $02                                     ;; 0e:6d41 $e6 $02
    mDis_8                                             ;; 0e:6d43 $83
    mF_8                                               ;; 0e:6d44 $85
    mG_8                                               ;; 0e:6d45 $87
    mREPEAT .data_0e_6d3c                              ;; 0e:6d46 $e2 $3c $6d
    mDis_8                                             ;; 0e:6d49 $83
    mF_8                                               ;; 0e:6d4a $85
    mCOUNTER $0a                                       ;; 0e:6d4b $e3 $0a
.data_0e_6d4d:
    mD_8                                               ;; 0e:6d4d $82
    mDis_8                                             ;; 0e:6d4e $83
    mF_8                                               ;; 0e:6d4f $85
    mREPEAT .data_0e_6d4d                              ;; 0e:6d50 $e2 $4d $6d
    mD_8                                               ;; 0e:6d53 $82
    mDis_8                                             ;; 0e:6d54 $83
    mREPEAT_2 .data_0e_6d3a                            ;; 0e:6d55 $e9 $3a $6d
    mDUTYCYCLE $40                                     ;; 0e:6d58 $e5 $40
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:6d5a $e0 $57 $7a
    mGis_5                                             ;; 0e:6d5d $58
    mF_5                                               ;; 0e:6d5e $55
    mDis_5                                             ;; 0e:6d5f $53
    mCPlus_8                                           ;; 0e:6d60 $8c
    mAis_5                                             ;; 0e:6d61 $5a
    mCPlus_8                                           ;; 0e:6d62 $8c
    mGis_8                                             ;; 0e:6d63 $88
    mAis_8                                             ;; 0e:6d64 $8a
    mG_8                                               ;; 0e:6d65 $87
    mGis_8                                             ;; 0e:6d66 $88
    mG_8                                               ;; 0e:6d67 $87
    mF_8                                               ;; 0e:6d68 $85
    mG_8                                               ;; 0e:6d69 $87
    mB_8                                               ;; 0e:6d6a $8b
    mG_8                                               ;; 0e:6d6b $87
    mB_8                                               ;; 0e:6d6c $8b
    mA_8                                               ;; 0e:6d6d $89
    mCPlus_8                                           ;; 0e:6d6e $8c
    mB_8                                               ;; 0e:6d6f $8b
    mOCTAVE_PLUS_1                                     ;; 0e:6d70 $d8
    mD_8                                               ;; 0e:6d71 $82
    mDis_5                                             ;; 0e:6d72 $53
    mD_5                                               ;; 0e:6d73 $52
    mC_5                                               ;; 0e:6d74 $50
    mOCTAVE_MINUS_1                                    ;; 0e:6d75 $dc
    mAis_8                                             ;; 0e:6d76 $8a
    mA_5                                               ;; 0e:6d77 $59
    mFis_8                                             ;; 0e:6d78 $86
    mDis_8                                             ;; 0e:6d79 $83
    mC_8                                               ;; 0e:6d7a $80
    mOCTAVE_MINUS_1                                    ;; 0e:6d7b $dc
    mA_8                                               ;; 0e:6d7c $89
    mCPlus_8                                           ;; 0e:6d7d $8c
    mOCTAVE_PLUS_1                                     ;; 0e:6d7e $d8
    mDis_8                                             ;; 0e:6d7f $83
    mFis_8                                             ;; 0e:6d80 $86
    mD_8                                               ;; 0e:6d81 $82
    mFis_8                                             ;; 0e:6d82 $86
    mA_8                                               ;; 0e:6d83 $89
    mCPlus_8                                           ;; 0e:6d84 $8c
    mC_8                                               ;; 0e:6d85 $80
    mDis_8                                             ;; 0e:6d86 $83
    mFis_8                                             ;; 0e:6d87 $86
    mA_8                                               ;; 0e:6d88 $89
    mCPlus_8                                           ;; 0e:6d89 $8c
    mF_12                                              ;; 0e:6d8a $c5
    mRest_12                                           ;; 0e:6d8b $cf
    mG_12                                              ;; 0e:6d8c $c7
    mRest_12                                           ;; 0e:6d8d $cf
    mD_8                                               ;; 0e:6d8e $82
    mCPlus_8                                           ;; 0e:6d8f $8c
    mF_12                                              ;; 0e:6d90 $c5
    mRest_12                                           ;; 0e:6d91 $cf
    mG_12                                              ;; 0e:6d92 $c7
    mRest_12                                           ;; 0e:6d93 $cf
    mD_8                                               ;; 0e:6d94 $82
    mCPlus_10                                          ;; 0e:6d95 $ac
    mF_10                                              ;; 0e:6d96 $a5
    mG_10                                              ;; 0e:6d97 $a7
    mD_10                                              ;; 0e:6d98 $a2
    mB_8                                               ;; 0e:6d99 $8b
    mF_12                                              ;; 0e:6d9a $c5
    mRest_12                                           ;; 0e:6d9b $cf
    mG_12                                              ;; 0e:6d9c $c7
    mRest_12                                           ;; 0e:6d9d $cf
    mD_8                                               ;; 0e:6d9e $82
    mB_8                                               ;; 0e:6d9f $8b
    mF_12                                              ;; 0e:6da0 $c5
    mRest_12                                           ;; 0e:6da1 $cf
    mG_12                                              ;; 0e:6da2 $c7
    mRest_12                                           ;; 0e:6da3 $cf
    mD_8                                               ;; 0e:6da4 $82
    mB_10                                              ;; 0e:6da5 $ab
    mF_10                                              ;; 0e:6da6 $a5
    mG_10                                              ;; 0e:6da7 $a7
    mD_10                                              ;; 0e:6da8 $a2
    mJUMP .data_0e_6d38                                ;; 0e:6da9 $e1 $38 $6d

song12_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:6dac $e4 $fe $79
    mWAVETABLE data_0e_7aa5                            ;; 0e:6daf $e8 $a5 $7a
    mVOLUME $20                                        ;; 0e:6db2 $e0 $20
    mSTEREOPAN $03                                     ;; 0e:6db4 $e6 $03
    mCOUNTER $02                                       ;; 0e:6db6 $e3 $02
.data_0e_6db8:
    mOCTAVE_1                                          ;; 0e:6db8 $d1
    mF_0                                               ;; 0e:6db9 $05
    mE_0                                               ;; 0e:6dba $04
    mDis_0                                             ;; 0e:6dbb $03
    mD_2                                               ;; 0e:6dbc $22
    mWait_8                                            ;; 0e:6dbd $8e
    mAis_8                                             ;; 0e:6dbe $8a
    mOCTAVE_PLUS_1                                     ;; 0e:6dbf $d8
    mF_8                                               ;; 0e:6dc0 $85
    mD_8                                               ;; 0e:6dc1 $82
    mREPEAT .data_0e_6db8                              ;; 0e:6dc2 $e2 $b8 $6d
    mCOUNTER $02                                       ;; 0e:6dc5 $e3 $02
.data_0e_6dc7:
    mOCTAVE_MINUS_1                                    ;; 0e:6dc7 $dc
    mF_10                                              ;; 0e:6dc8 $a5
    mRest_10                                           ;; 0e:6dc9 $af
    mF_10                                              ;; 0e:6dca $a5
    mRest_10                                           ;; 0e:6dcb $af
    mGis_8                                             ;; 0e:6dcc $88
    mG_8                                               ;; 0e:6dcd $87
    mF_8                                               ;; 0e:6dce $85
    mB_8                                               ;; 0e:6dcf $8b
    mAis_8                                             ;; 0e:6dd0 $8a
    mGis_8                                             ;; 0e:6dd1 $88
    mF_8                                               ;; 0e:6dd2 $85
    mCPlus_8                                           ;; 0e:6dd3 $8c
    mAis_8                                             ;; 0e:6dd4 $8a
    mOCTAVE_PLUS_1                                     ;; 0e:6dd5 $d8
    mD_8                                               ;; 0e:6dd6 $82
    mC_8                                               ;; 0e:6dd7 $80
    mDis_8                                             ;; 0e:6dd8 $83
    mD_8                                               ;; 0e:6dd9 $82
    mF_8                                               ;; 0e:6dda $85
    mREPEAT .data_0e_6dc7                              ;; 0e:6ddb $e2 $c7 $6d
    mF_10                                              ;; 0e:6dde $a5
    mRest_10                                           ;; 0e:6ddf $af
    mF_10                                              ;; 0e:6de0 $a5
    mRest_10                                           ;; 0e:6de1 $af
    mRest_4                                            ;; 0e:6de2 $4f
    mC_4                                               ;; 0e:6de3 $40
    mDis_10                                            ;; 0e:6de4 $a3
    mRest_10                                           ;; 0e:6de5 $af
    mDis_10                                            ;; 0e:6de6 $a3
    mRest_10                                           ;; 0e:6de7 $af
    mRest_4                                            ;; 0e:6de8 $4f
    mOCTAVE_MINUS_1                                    ;; 0e:6de9 $dc
    mB_4                                               ;; 0e:6dea $4b
    mCisPlus_10                                        ;; 0e:6deb $ad
    mRest_10                                           ;; 0e:6dec $af
    mCisPlus_10                                        ;; 0e:6ded $ad
    mRest_10                                           ;; 0e:6dee $af
    mRest_4                                            ;; 0e:6def $4f
    mOCTAVE_PLUS_1                                     ;; 0e:6df0 $d8
    mE_4                                               ;; 0e:6df1 $44
    mDis_10                                            ;; 0e:6df2 $a3
    mRest_10                                           ;; 0e:6df3 $af
    mDis_10                                            ;; 0e:6df4 $a3
    mRest_10                                           ;; 0e:6df5 $af
    mRest_5                                            ;; 0e:6df6 $5f
    mSTEREOPAN $02                                     ;; 0e:6df7 $e6 $02
    mOCTAVE_MINUS_1                                    ;; 0e:6df9 $dc
    mF_10                                              ;; 0e:6dfa $a5
    mFis_10                                            ;; 0e:6dfb $a6
    mSTEREOPAN $03                                     ;; 0e:6dfc $e6 $03
    mG_10                                              ;; 0e:6dfe $a7
    mGis_10                                            ;; 0e:6dff $a8
    mA_10                                              ;; 0e:6e00 $a9
    mSTEREOPAN $01                                     ;; 0e:6e01 $e6 $01
    mAis_10                                            ;; 0e:6e03 $aa
    mB_10                                              ;; 0e:6e04 $ab
    mCPlus_10                                          ;; 0e:6e05 $ac
    mOCTAVE_PLUS_1                                     ;; 0e:6e06 $d8
    mCOUNTER $02                                       ;; 0e:6e07 $e3 $02
.data_0e_6e09:
    mSTEREOPAN $03                                     ;; 0e:6e09 $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:6e0b $dc
    mF_10                                              ;; 0e:6e0c $a5
    mRest_10                                           ;; 0e:6e0d $af
    mF_10                                              ;; 0e:6e0e $a5
    mRest_10                                           ;; 0e:6e0f $af
    mGis_8                                             ;; 0e:6e10 $88
    mG_8                                               ;; 0e:6e11 $87
    mF_8                                               ;; 0e:6e12 $85
    mB_8                                               ;; 0e:6e13 $8b
    mAis_8                                             ;; 0e:6e14 $8a
    mGis_8                                             ;; 0e:6e15 $88
    mF_8                                               ;; 0e:6e16 $85
    mCPlus_8                                           ;; 0e:6e17 $8c
    mAis_8                                             ;; 0e:6e18 $8a
    mOCTAVE_PLUS_1                                     ;; 0e:6e19 $d8
    mD_8                                               ;; 0e:6e1a $82
    mC_8                                               ;; 0e:6e1b $80
    mDis_8                                             ;; 0e:6e1c $83
    mJUMPIF $01, .data_0e_6e26                         ;; 0e:6e1d $eb $01 $26 $6e
    mD_8                                               ;; 0e:6e21 $82
    mF_8                                               ;; 0e:6e22 $85
    mREPEAT .data_0e_6e09                              ;; 0e:6e23 $e2 $09 $6e
.data_0e_6e26:
    mWAVETABLE data_0e_7a85                            ;; 0e:6e26 $e8 $85 $7a
    mD_12                                              ;; 0e:6e29 $c2
    mCis_12                                            ;; 0e:6e2a $c1
    mC_12                                              ;; 0e:6e2b $c0
    mOCTAVE_MINUS_1                                    ;; 0e:6e2c $dc
    mB_12                                              ;; 0e:6e2d $cb
    mAis_12                                            ;; 0e:6e2e $ca
    mA_12                                              ;; 0e:6e2f $c9
    mGis_12                                            ;; 0e:6e30 $c8
    mG_12                                              ;; 0e:6e31 $c7
    mOCTAVE_PLUS_1                                     ;; 0e:6e32 $d8
.data_0e_6e33:
    mCOUNTER_2 $02                                     ;; 0e:6e33 $ea $02
.data_0e_6e35:
    mCOUNTER $04                                       ;; 0e:6e35 $e3 $04
.data_0e_6e37:
    mWAVETABLE data_0e_7aa5                            ;; 0e:6e37 $e8 $a5 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:6e3a $dc
    mGis_8                                             ;; 0e:6e3b $88
    mOCTAVE_PLUS_1                                     ;; 0e:6e3c $d8
    mGis_8                                             ;; 0e:6e3d $88
    mG_8                                               ;; 0e:6e3e $87
    mGis_8                                             ;; 0e:6e3f $88
    mCPlus_8                                           ;; 0e:6e40 $8c
    mGis_8                                             ;; 0e:6e41 $88
    mG_8                                               ;; 0e:6e42 $87
    mGis_8                                             ;; 0e:6e43 $88
    mREPEAT .data_0e_6e37                              ;; 0e:6e44 $e2 $37 $6e
    mCOUNTER $04                                       ;; 0e:6e47 $e3 $04
.data_0e_6e49:
    mOCTAVE_MINUS_1                                    ;; 0e:6e49 $dc
    mG_8                                               ;; 0e:6e4a $87
    mOCTAVE_PLUS_1                                     ;; 0e:6e4b $d8
    mG_8                                               ;; 0e:6e4c $87
    mF_8                                               ;; 0e:6e4d $85
    mG_8                                               ;; 0e:6e4e $87
    mB_8                                               ;; 0e:6e4f $8b
    mG_8                                               ;; 0e:6e50 $87
    mF_8                                               ;; 0e:6e51 $85
    mG_8                                               ;; 0e:6e52 $87
    mREPEAT .data_0e_6e49                              ;; 0e:6e53 $e2 $49 $6e
    mREPEAT_2 .data_0e_6e35                            ;; 0e:6e56 $e9 $35 $6e
    mCOUNTER $04                                       ;; 0e:6e59 $e3 $04
.data_0e_6e5b:
    mOCTAVE_MINUS_1                                    ;; 0e:6e5b $dc
    mF_10                                              ;; 0e:6e5c $a5
    mRest_10                                           ;; 0e:6e5d $af
    mOCTAVE_PLUS_1                                     ;; 0e:6e5e $d8
    mF_8                                               ;; 0e:6e5f $85
    mREPEAT .data_0e_6e5b                              ;; 0e:6e60 $e2 $5b $6e
    mCOUNTER $03                                       ;; 0e:6e63 $e3 $03
.data_0e_6e65:
    mOCTAVE_MINUS_1                                    ;; 0e:6e65 $dc
    mAis_10                                            ;; 0e:6e66 $aa
    mRest_10                                           ;; 0e:6e67 $af
    mOCTAVE_PLUS_1                                     ;; 0e:6e68 $d8
    mAis_8                                             ;; 0e:6e69 $8a
    mREPEAT .data_0e_6e65                              ;; 0e:6e6a $e2 $65 $6e
    mOCTAVE_MINUS_1                                    ;; 0e:6e6d $dc
    mGis_10                                            ;; 0e:6e6e $a8
    mRest_10                                           ;; 0e:6e6f $af
    mOCTAVE_PLUS_1                                     ;; 0e:6e70 $d8
    mGis_8                                             ;; 0e:6e71 $88
    mCOUNTER $04                                       ;; 0e:6e72 $e3 $04
.data_0e_6e74:
    mOCTAVE_MINUS_1                                    ;; 0e:6e74 $dc
    mG_10                                              ;; 0e:6e75 $a7
    mRest_10                                           ;; 0e:6e76 $af
    mOCTAVE_PLUS_1                                     ;; 0e:6e77 $d8
    mG_8                                               ;; 0e:6e78 $87
    mREPEAT .data_0e_6e74                              ;; 0e:6e79 $e2 $74 $6e
    mC_10                                              ;; 0e:6e7c $a0
    mRest_10                                           ;; 0e:6e7d $af
    mCPlus_8                                           ;; 0e:6e7e $8c
    mOCTAVE_MINUS_1                                    ;; 0e:6e7f $dc
    mAis_10                                            ;; 0e:6e80 $aa
    mRest_10                                           ;; 0e:6e81 $af
    mOCTAVE_PLUS_1                                     ;; 0e:6e82 $d8
    mAis_8                                             ;; 0e:6e83 $8a
    mOCTAVE_MINUS_1                                    ;; 0e:6e84 $dc
    mGis_10                                            ;; 0e:6e85 $a8
    mRest_10                                           ;; 0e:6e86 $af
    mOCTAVE_PLUS_1                                     ;; 0e:6e87 $d8
    mGis_8                                             ;; 0e:6e88 $88
    mOCTAVE_MINUS_1                                    ;; 0e:6e89 $dc
    mG_10                                              ;; 0e:6e8a $a7
    mRest_10                                           ;; 0e:6e8b $af
    mOCTAVE_PLUS_1                                     ;; 0e:6e8c $d8
    mG_8                                               ;; 0e:6e8d $87
    mCOUNTER $04                                       ;; 0e:6e8e $e3 $04
.data_0e_6e90:
    mOCTAVE_MINUS_1                                    ;; 0e:6e90 $dc
    mFis_10                                            ;; 0e:6e91 $a6
    mRest_10                                           ;; 0e:6e92 $af
    mOCTAVE_PLUS_1                                     ;; 0e:6e93 $d8
    mFis_8                                             ;; 0e:6e94 $86
    mREPEAT .data_0e_6e90                              ;; 0e:6e95 $e2 $90 $6e
    mCOUNTER $04                                       ;; 0e:6e98 $e3 $04
.data_0e_6e9a:
    mOCTAVE_MINUS_1                                    ;; 0e:6e9a $dc
    mD_10                                              ;; 0e:6e9b $a2
    mRest_10                                           ;; 0e:6e9c $af
    mOCTAVE_PLUS_1                                     ;; 0e:6e9d $d8
    mD_8                                               ;; 0e:6e9e $82
    mREPEAT .data_0e_6e9a                              ;; 0e:6e9f $e2 $9a $6e
    mG_10                                              ;; 0e:6ea2 $a7
    mRest_10                                           ;; 0e:6ea3 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6ea4 $dc
    mG_10                                              ;; 0e:6ea5 $a7
    mRest_10                                           ;; 0e:6ea6 $af
    mG_10                                              ;; 0e:6ea7 $a7
    mRest_10                                           ;; 0e:6ea8 $af
    mOCTAVE_PLUS_1                                     ;; 0e:6ea9 $d8
    mF_10                                              ;; 0e:6eaa $a5
    mRest_10                                           ;; 0e:6eab $af
    mOCTAVE_MINUS_1                                    ;; 0e:6eac $dc
    mG_10                                              ;; 0e:6ead $a7
    mRest_10                                           ;; 0e:6eae $af
    mG_10                                              ;; 0e:6eaf $a7
    mRest_10                                           ;; 0e:6eb0 $af
    mOCTAVE_PLUS_1                                     ;; 0e:6eb1 $d8
    mDis_10                                            ;; 0e:6eb2 $a3
    mRest_10                                           ;; 0e:6eb3 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6eb4 $dc
    mG_10                                              ;; 0e:6eb5 $a7
    mRest_10                                           ;; 0e:6eb6 $af
    mOCTAVE_PLUS_1                                     ;; 0e:6eb7 $d8
    mD_10                                              ;; 0e:6eb8 $a2
    mRest_10                                           ;; 0e:6eb9 $af
    mOCTAVE_MINUS_1                                    ;; 0e:6eba $dc
    mG_10                                              ;; 0e:6ebb $a7
    mRest_10                                           ;; 0e:6ebc $af
    mG_10                                              ;; 0e:6ebd $a7
    mRest_10                                           ;; 0e:6ebe $af
    mCPlus_10                                          ;; 0e:6ebf $ac
    mRest_10                                           ;; 0e:6ec0 $af
    mG_10                                              ;; 0e:6ec1 $a7
    mRest_10                                           ;; 0e:6ec2 $af
    mG_10                                              ;; 0e:6ec3 $a7
    mRest_10                                           ;; 0e:6ec4 $af
    mB_10                                              ;; 0e:6ec5 $ab
    mRest_10                                           ;; 0e:6ec6 $af
    mG_10                                              ;; 0e:6ec7 $a7
    mRest_10                                           ;; 0e:6ec8 $af
    mOCTAVE_PLUS_1                                     ;; 0e:6ec9 $d8
    mJUMP .data_0e_6e33                                ;; 0e:6eca $e1 $33 $6e

song0c_channel2:
    mVIBRATO frequencyDeltaData                        ;; 0e:6ecd $e4 $fe $79
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:6ed0 $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:6ed3 $e5 $80
    mSTEREOPAN $03                                     ;; 0e:6ed5 $e6 $03
.data_0e_6ed7:
    mCOUNTER $02                                       ;; 0e:6ed7 $e3 $02
.data_0e_6ed9:
    mTEMPO $46                                         ;; 0e:6ed9 $e7 $46
    mOCTAVE_3                                          ;; 0e:6edb $d3
    mE_8                                               ;; 0e:6edc $84
    mDis_8                                             ;; 0e:6edd $83
    mE_8                                               ;; 0e:6ede $84
    mOCTAVE_MINUS_1                                    ;; 0e:6edf $dc
    mB_8                                               ;; 0e:6ee0 $8b
    mCisPlus_2                                         ;; 0e:6ee1 $2d
    mRest_8                                            ;; 0e:6ee2 $8f
    mOCTAVE_PLUS_1                                     ;; 0e:6ee3 $d8
    mFis_8                                             ;; 0e:6ee4 $86
    mE_8                                               ;; 0e:6ee5 $84
    mDis_8                                             ;; 0e:6ee6 $83
    mE_8                                               ;; 0e:6ee7 $84
    mDis_8                                             ;; 0e:6ee8 $83
    mE_8                                               ;; 0e:6ee9 $84
    mOCTAVE_MINUS_1                                    ;; 0e:6eea $dc
    mB_8                                               ;; 0e:6eeb $8b
    mCisPlus_2                                         ;; 0e:6eec $2d
    mA_5                                               ;; 0e:6eed $59
    mB_5                                               ;; 0e:6eee $5b
    mCPlus_8                                           ;; 0e:6eef $8c
    mB_8                                               ;; 0e:6ef0 $8b
    mCPlus_8                                           ;; 0e:6ef1 $8c
    mG_8                                               ;; 0e:6ef2 $87
    mA_2                                               ;; 0e:6ef3 $29
    mRest_8                                            ;; 0e:6ef4 $8f
    mOCTAVE_PLUS_1                                     ;; 0e:6ef5 $d8
    mD_8                                               ;; 0e:6ef6 $82
    mC_8                                               ;; 0e:6ef7 $80
    mOCTAVE_MINUS_1                                    ;; 0e:6ef8 $dc
    mB_8                                               ;; 0e:6ef9 $8b
    mCPlus_8                                           ;; 0e:6efa $8c
    mB_8                                               ;; 0e:6efb $8b
    mCPlus_8                                           ;; 0e:6efc $8c
    mG_8                                               ;; 0e:6efd $87
    mA_2                                               ;; 0e:6efe $29
    mB_5                                               ;; 0e:6eff $5b
    mCPlus_8                                           ;; 0e:6f00 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:6f01 $d8
    mD_8                                               ;; 0e:6f02 $82
    mREPEAT .data_0e_6ed9                              ;; 0e:6f03 $e2 $d9 $6e
    mCOUNTER $02                                       ;; 0e:6f06 $e3 $02
.data_0e_6f08:
    mD_8                                               ;; 0e:6f08 $82
    mCis_8                                             ;; 0e:6f09 $81
    mD_8                                               ;; 0e:6f0a $82
    mG_8                                               ;; 0e:6f0b $87
    mFis_8                                             ;; 0e:6f0c $86
    mE_8                                               ;; 0e:6f0d $84
    mOCTAVE_MINUS_1                                    ;; 0e:6f0e $dc
    mB_8                                               ;; 0e:6f0f $8b
    mCisPlus_8                                         ;; 0e:6f10 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:6f11 $d8
    mD_8                                               ;; 0e:6f12 $82
    mC_8                                               ;; 0e:6f13 $80
    mOCTAVE_MINUS_1                                    ;; 0e:6f14 $dc
    mG_8                                               ;; 0e:6f15 $87
    mOCTAVE_PLUS_1                                     ;; 0e:6f16 $d8
    mG_2                                               ;; 0e:6f17 $27
    mWait_8                                            ;; 0e:6f18 $8e
    mJUMPIF $01, .data_0e_6f2b                         ;; 0e:6f19 $eb $01 $2b $6f
    mG_8                                               ;; 0e:6f1d $87
    mF_8                                               ;; 0e:6f1e $85
    mC_8                                               ;; 0e:6f1f $80
    mDis_8                                             ;; 0e:6f20 $83
    mD_5                                               ;; 0e:6f21 $52
    mDis_8                                             ;; 0e:6f22 $83
    mF_8                                               ;; 0e:6f23 $85
    mD_5                                               ;; 0e:6f24 $52
    mOCTAVE_MINUS_1                                    ;; 0e:6f25 $dc
    mAis_1                                             ;; 0e:6f26 $1a
    mOCTAVE_PLUS_1                                     ;; 0e:6f27 $d8
    mREPEAT .data_0e_6f08                              ;; 0e:6f28 $e2 $08 $6f
.data_0e_6f2b:
    mD_8                                               ;; 0e:6f2b $82
    mC_8                                               ;; 0e:6f2c $80
    mOCTAVE_MINUS_1                                    ;; 0e:6f2d $dc
    mG_8                                               ;; 0e:6f2e $87
    mOCTAVE_PLUS_1                                     ;; 0e:6f2f $d8
    mG_4                                               ;; 0e:6f30 $47
    mF_5                                               ;; 0e:6f31 $55
    mTEMPO $45                                         ;; 0e:6f32 $e7 $45
    mG_8                                               ;; 0e:6f34 $87
    mTEMPO $44                                         ;; 0e:6f35 $e7 $44
    mWait_8                                            ;; 0e:6f37 $8e
    mTEMPO $42                                         ;; 0e:6f38 $e7 $42
    mWait_8                                            ;; 0e:6f3a $8e
    mTEMPO $40                                         ;; 0e:6f3b $e7 $40
    mWait_8                                            ;; 0e:6f3d $8e
    mTEMPO $3e                                         ;; 0e:6f3e $e7 $3e
    mWait_8                                            ;; 0e:6f40 $8e
    mTEMPO $3c                                         ;; 0e:6f41 $e7 $3c
    mWait_8                                            ;; 0e:6f43 $8e
    mTEMPO $3a                                         ;; 0e:6f44 $e7 $3a
    mWait_8                                            ;; 0e:6f46 $8e
    mTEMPO $38                                         ;; 0e:6f47 $e7 $38
    mWait_8                                            ;; 0e:6f49 $8e
    mJUMP .data_0e_6ed7                                ;; 0e:6f4a $e1 $d7 $6e

song0c_channel1:
    mVIBRATO frequencyDeltaData.second                 ;; 0e:6f4d $e4 $0b $7a
    mDUTYCYCLE $40                                     ;; 0e:6f50 $e5 $40
    mSTEREOPAN $01                                     ;; 0e:6f52 $e6 $01
.data_0e_6f54:
    mCOUNTER_2 $02                                     ;; 0e:6f54 $ea $02
.data_0e_6f56:
    mOCTAVE_2                                          ;; 0e:6f56 $d2
    mCOUNTER $03                                       ;; 0e:6f57 $e3 $03
.data_0e_6f59:
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:6f59 $e0 $65 $7a
    mE_12                                              ;; 0e:6f5c $c4
    mFis_12                                            ;; 0e:6f5d $c6
    mE_12                                              ;; 0e:6f5e $c4
    mFis_12                                            ;; 0e:6f5f $c6
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:6f60 $e0 $63 $7a
    mE_12                                              ;; 0e:6f63 $c4
    mFis_12                                            ;; 0e:6f64 $c6
    mE_12                                              ;; 0e:6f65 $c4
    mFis_12                                            ;; 0e:6f66 $c6
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:6f67 $e0 $61 $7a
    mE_12                                              ;; 0e:6f6a $c4
    mFis_12                                            ;; 0e:6f6b $c6
    mE_12                                              ;; 0e:6f6c $c4
    mFis_12                                            ;; 0e:6f6d $c6
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:6f6e $e0 $5f $7a
    mE_12                                              ;; 0e:6f71 $c4
    mFis_12                                            ;; 0e:6f72 $c6
    mE_12                                              ;; 0e:6f73 $c4
    mFis_12                                            ;; 0e:6f74 $c6
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:6f75 $e0 $5d $7a
    mE_12                                              ;; 0e:6f78 $c4
    mFis_12                                            ;; 0e:6f79 $c6
    mE_12                                              ;; 0e:6f7a $c4
    mFis_12                                            ;; 0e:6f7b $c6
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:6f7c $e0 $5b $7a
    mE_12                                              ;; 0e:6f7f $c4
    mFis_12                                            ;; 0e:6f80 $c6
    mE_12                                              ;; 0e:6f81 $c4
    mFis_12                                            ;; 0e:6f82 $c6
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:6f83 $e0 $59 $7a
    mE_12                                              ;; 0e:6f86 $c4
    mFis_12                                            ;; 0e:6f87 $c6
    mE_12                                              ;; 0e:6f88 $c4
    mFis_12                                            ;; 0e:6f89 $c6
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:6f8a $e0 $57 $7a
    mE_12                                              ;; 0e:6f8d $c4
    mFis_12                                            ;; 0e:6f8e $c6
    mE_12                                              ;; 0e:6f8f $c4
    mFis_12                                            ;; 0e:6f90 $c6
    mREPEAT .data_0e_6f59                              ;; 0e:6f91 $e2 $59 $6f
    mCOUNTER $03                                       ;; 0e:6f94 $e3 $03
.data_0e_6f96:
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:6f96 $e0 $65 $7a
    mE_12                                              ;; 0e:6f99 $c4
    mF_12                                              ;; 0e:6f9a $c5
    mE_12                                              ;; 0e:6f9b $c4
    mF_12                                              ;; 0e:6f9c $c5
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:6f9d $e0 $63 $7a
    mE_12                                              ;; 0e:6fa0 $c4
    mF_12                                              ;; 0e:6fa1 $c5
    mE_12                                              ;; 0e:6fa2 $c4
    mF_12                                              ;; 0e:6fa3 $c5
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:6fa4 $e0 $61 $7a
    mE_12                                              ;; 0e:6fa7 $c4
    mF_12                                              ;; 0e:6fa8 $c5
    mE_12                                              ;; 0e:6fa9 $c4
    mF_12                                              ;; 0e:6faa $c5
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:6fab $e0 $5f $7a
    mE_12                                              ;; 0e:6fae $c4
    mF_12                                              ;; 0e:6faf $c5
    mE_12                                              ;; 0e:6fb0 $c4
    mF_12                                              ;; 0e:6fb1 $c5
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:6fb2 $e0 $5d $7a
    mE_12                                              ;; 0e:6fb5 $c4
    mF_12                                              ;; 0e:6fb6 $c5
    mE_12                                              ;; 0e:6fb7 $c4
    mF_12                                              ;; 0e:6fb8 $c5
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:6fb9 $e0 $5b $7a
    mE_12                                              ;; 0e:6fbc $c4
    mF_12                                              ;; 0e:6fbd $c5
    mE_12                                              ;; 0e:6fbe $c4
    mF_12                                              ;; 0e:6fbf $c5
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:6fc0 $e0 $59 $7a
    mE_12                                              ;; 0e:6fc3 $c4
    mF_12                                              ;; 0e:6fc4 $c5
    mE_12                                              ;; 0e:6fc5 $c4
    mF_12                                              ;; 0e:6fc6 $c5
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:6fc7 $e0 $57 $7a
    mE_12                                              ;; 0e:6fca $c4
    mF_12                                              ;; 0e:6fcb $c5
    mE_12                                              ;; 0e:6fcc $c4
    mF_12                                              ;; 0e:6fcd $c5
    mREPEAT .data_0e_6f96                              ;; 0e:6fce $e2 $96 $6f
    mREPEAT_2 .data_0e_6f56                            ;; 0e:6fd1 $e9 $56 $6f
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:6fd4 $e0 $65 $7a
    mD_12                                              ;; 0e:6fd7 $c2
    mE_12                                              ;; 0e:6fd8 $c4
    mD_12                                              ;; 0e:6fd9 $c2
    mE_12                                              ;; 0e:6fda $c4
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:6fdb $e0 $63 $7a
    mD_12                                              ;; 0e:6fde $c2
    mE_12                                              ;; 0e:6fdf $c4
    mD_12                                              ;; 0e:6fe0 $c2
    mE_12                                              ;; 0e:6fe1 $c4
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:6fe2 $e0 $61 $7a
    mD_12                                              ;; 0e:6fe5 $c2
    mE_12                                              ;; 0e:6fe6 $c4
    mD_12                                              ;; 0e:6fe7 $c2
    mE_12                                              ;; 0e:6fe8 $c4
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:6fe9 $e0 $5f $7a
    mD_12                                              ;; 0e:6fec $c2
    mE_12                                              ;; 0e:6fed $c4
    mD_12                                              ;; 0e:6fee $c2
    mE_12                                              ;; 0e:6fef $c4
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:6ff0 $e0 $5d $7a
    mD_12                                              ;; 0e:6ff3 $c2
    mE_12                                              ;; 0e:6ff4 $c4
    mD_12                                              ;; 0e:6ff5 $c2
    mE_12                                              ;; 0e:6ff6 $c4
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:6ff7 $e0 $5b $7a
    mD_12                                              ;; 0e:6ffa $c2
    mE_12                                              ;; 0e:6ffb $c4
    mD_12                                              ;; 0e:6ffc $c2
    mE_12                                              ;; 0e:6ffd $c4
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:6ffe $e0 $59 $7a
    mD_12                                              ;; 0e:7001 $c2
    mE_12                                              ;; 0e:7002 $c4
    mD_12                                              ;; 0e:7003 $c2
    mE_12                                              ;; 0e:7004 $c4
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:7005 $e0 $57 $7a
    mD_12                                              ;; 0e:7008 $c2
    mE_12                                              ;; 0e:7009 $c4
    mD_12                                              ;; 0e:700a $c2
    mE_12                                              ;; 0e:700b $c4
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:700c $e0 $65 $7a
    mDis_12                                            ;; 0e:700f $c3
    mF_12                                              ;; 0e:7010 $c5
    mDis_12                                            ;; 0e:7011 $c3
    mF_12                                              ;; 0e:7012 $c5
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:7013 $e0 $63 $7a
    mDis_12                                            ;; 0e:7016 $c3
    mF_12                                              ;; 0e:7017 $c5
    mDis_12                                            ;; 0e:7018 $c3
    mF_12                                              ;; 0e:7019 $c5
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:701a $e0 $61 $7a
    mDis_12                                            ;; 0e:701d $c3
    mF_12                                              ;; 0e:701e $c5
    mDis_12                                            ;; 0e:701f $c3
    mF_12                                              ;; 0e:7020 $c5
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:7021 $e0 $5f $7a
    mDis_12                                            ;; 0e:7024 $c3
    mF_12                                              ;; 0e:7025 $c5
    mDis_12                                            ;; 0e:7026 $c3
    mF_12                                              ;; 0e:7027 $c5
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:7028 $e0 $5d $7a
    mDis_12                                            ;; 0e:702b $c3
    mF_12                                              ;; 0e:702c $c5
    mDis_12                                            ;; 0e:702d $c3
    mF_12                                              ;; 0e:702e $c5
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:702f $e0 $5b $7a
    mDis_12                                            ;; 0e:7032 $c3
    mF_12                                              ;; 0e:7033 $c5
    mDis_12                                            ;; 0e:7034 $c3
    mF_12                                              ;; 0e:7035 $c5
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:7036 $e0 $59 $7a
    mDis_12                                            ;; 0e:7039 $c3
    mF_12                                              ;; 0e:703a $c5
    mDis_12                                            ;; 0e:703b $c3
    mF_12                                              ;; 0e:703c $c5
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:703d $e0 $57 $7a
    mDis_12                                            ;; 0e:7040 $c3
    mF_12                                              ;; 0e:7041 $c5
    mDis_12                                            ;; 0e:7042 $c3
    mF_12                                              ;; 0e:7043 $c5
    mCOUNTER $02                                       ;; 0e:7044 $e3 $02
.data_0e_7046:
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:7046 $e0 $65 $7a
    mF_12                                              ;; 0e:7049 $c5
    mG_12                                              ;; 0e:704a $c7
    mF_12                                              ;; 0e:704b $c5
    mG_12                                              ;; 0e:704c $c7
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:704d $e0 $63 $7a
    mF_12                                              ;; 0e:7050 $c5
    mG_12                                              ;; 0e:7051 $c7
    mF_12                                              ;; 0e:7052 $c5
    mG_12                                              ;; 0e:7053 $c7
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:7054 $e0 $61 $7a
    mF_12                                              ;; 0e:7057 $c5
    mG_12                                              ;; 0e:7058 $c7
    mF_12                                              ;; 0e:7059 $c5
    mG_12                                              ;; 0e:705a $c7
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:705b $e0 $5f $7a
    mF_12                                              ;; 0e:705e $c5
    mG_12                                              ;; 0e:705f $c7
    mF_12                                              ;; 0e:7060 $c5
    mG_12                                              ;; 0e:7061 $c7
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:7062 $e0 $5d $7a
    mF_12                                              ;; 0e:7065 $c5
    mG_12                                              ;; 0e:7066 $c7
    mF_12                                              ;; 0e:7067 $c5
    mG_12                                              ;; 0e:7068 $c7
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:7069 $e0 $5b $7a
    mF_12                                              ;; 0e:706c $c5
    mG_12                                              ;; 0e:706d $c7
    mF_12                                              ;; 0e:706e $c5
    mG_12                                              ;; 0e:706f $c7
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:7070 $e0 $59 $7a
    mF_12                                              ;; 0e:7073 $c5
    mG_12                                              ;; 0e:7074 $c7
    mF_12                                              ;; 0e:7075 $c5
    mG_12                                              ;; 0e:7076 $c7
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:7077 $e0 $57 $7a
    mF_12                                              ;; 0e:707a $c5
    mG_12                                              ;; 0e:707b $c7
    mF_12                                              ;; 0e:707c $c5
    mG_12                                              ;; 0e:707d $c7
    mREPEAT .data_0e_7046                              ;; 0e:707e $e2 $46 $70
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:7081 $e0 $65 $7a
    mD_12                                              ;; 0e:7084 $c2
    mE_12                                              ;; 0e:7085 $c4
    mD_12                                              ;; 0e:7086 $c2
    mE_12                                              ;; 0e:7087 $c4
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:7088 $e0 $63 $7a
    mD_12                                              ;; 0e:708b $c2
    mE_12                                              ;; 0e:708c $c4
    mD_12                                              ;; 0e:708d $c2
    mE_12                                              ;; 0e:708e $c4
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:708f $e0 $61 $7a
    mD_12                                              ;; 0e:7092 $c2
    mE_12                                              ;; 0e:7093 $c4
    mD_12                                              ;; 0e:7094 $c2
    mE_12                                              ;; 0e:7095 $c4
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:7096 $e0 $5f $7a
    mD_12                                              ;; 0e:7099 $c2
    mE_12                                              ;; 0e:709a $c4
    mD_12                                              ;; 0e:709b $c2
    mE_12                                              ;; 0e:709c $c4
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:709d $e0 $5d $7a
    mD_12                                              ;; 0e:70a0 $c2
    mE_12                                              ;; 0e:70a1 $c4
    mD_12                                              ;; 0e:70a2 $c2
    mE_12                                              ;; 0e:70a3 $c4
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:70a4 $e0 $5b $7a
    mD_12                                              ;; 0e:70a7 $c2
    mE_12                                              ;; 0e:70a8 $c4
    mD_12                                              ;; 0e:70a9 $c2
    mE_12                                              ;; 0e:70aa $c4
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:70ab $e0 $59 $7a
    mD_12                                              ;; 0e:70ae $c2
    mE_12                                              ;; 0e:70af $c4
    mD_12                                              ;; 0e:70b0 $c2
    mE_12                                              ;; 0e:70b1 $c4
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:70b2 $e0 $57 $7a
    mD_12                                              ;; 0e:70b5 $c2
    mE_12                                              ;; 0e:70b6 $c4
    mD_12                                              ;; 0e:70b7 $c2
    mE_12                                              ;; 0e:70b8 $c4
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:70b9 $e0 $65 $7a
    mDis_12                                            ;; 0e:70bc $c3
    mF_12                                              ;; 0e:70bd $c5
    mDis_12                                            ;; 0e:70be $c3
    mF_12                                              ;; 0e:70bf $c5
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:70c0 $e0 $63 $7a
    mDis_12                                            ;; 0e:70c3 $c3
    mF_12                                              ;; 0e:70c4 $c5
    mDis_12                                            ;; 0e:70c5 $c3
    mF_12                                              ;; 0e:70c6 $c5
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:70c7 $e0 $61 $7a
    mDis_12                                            ;; 0e:70ca $c3
    mF_12                                              ;; 0e:70cb $c5
    mDis_12                                            ;; 0e:70cc $c3
    mF_12                                              ;; 0e:70cd $c5
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:70ce $e0 $5f $7a
    mDis_12                                            ;; 0e:70d1 $c3
    mF_12                                              ;; 0e:70d2 $c5
    mDis_12                                            ;; 0e:70d3 $c3
    mF_12                                              ;; 0e:70d4 $c5
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:70d5 $e0 $5d $7a
    mDis_12                                            ;; 0e:70d8 $c3
    mF_12                                              ;; 0e:70d9 $c5
    mDis_12                                            ;; 0e:70da $c3
    mF_12                                              ;; 0e:70db $c5
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:70dc $e0 $5b $7a
    mDis_12                                            ;; 0e:70df $c3
    mF_12                                              ;; 0e:70e0 $c5
    mDis_12                                            ;; 0e:70e1 $c3
    mF_12                                              ;; 0e:70e2 $c5
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:70e3 $e0 $59 $7a
    mDis_12                                            ;; 0e:70e6 $c3
    mF_12                                              ;; 0e:70e7 $c5
    mDis_12                                            ;; 0e:70e8 $c3
    mF_12                                              ;; 0e:70e9 $c5
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:70ea $e0 $57 $7a
    mDis_12                                            ;; 0e:70ed $c3
    mF_12                                              ;; 0e:70ee $c5
    mDis_12                                            ;; 0e:70ef $c3
    mF_12                                              ;; 0e:70f0 $c5
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:70f1 $e0 $65 $7a
    mD_12                                              ;; 0e:70f4 $c2
    mF_12                                              ;; 0e:70f5 $c5
    mD_12                                              ;; 0e:70f6 $c2
    mF_12                                              ;; 0e:70f7 $c5
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:70f8 $e0 $63 $7a
    mD_12                                              ;; 0e:70fb $c2
    mF_12                                              ;; 0e:70fc $c5
    mD_12                                              ;; 0e:70fd $c2
    mF_12                                              ;; 0e:70fe $c5
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:70ff $e0 $61 $7a
    mD_12                                              ;; 0e:7102 $c2
    mF_12                                              ;; 0e:7103 $c5
    mD_12                                              ;; 0e:7104 $c2
    mF_12                                              ;; 0e:7105 $c5
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:7106 $e0 $5f $7a
    mD_12                                              ;; 0e:7109 $c2
    mF_12                                              ;; 0e:710a $c5
    mD_12                                              ;; 0e:710b $c2
    mF_12                                              ;; 0e:710c $c5
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:710d $e0 $5d $7a
    mD_12                                              ;; 0e:7110 $c2
    mF_12                                              ;; 0e:7111 $c5
    mD_12                                              ;; 0e:7112 $c2
    mF_12                                              ;; 0e:7113 $c5
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:7114 $e0 $5b $7a
    mD_12                                              ;; 0e:7117 $c2
    mF_12                                              ;; 0e:7118 $c5
    mD_12                                              ;; 0e:7119 $c2
    mF_12                                              ;; 0e:711a $c5
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:711b $e0 $59 $7a
    mD_12                                              ;; 0e:711e $c2
    mF_12                                              ;; 0e:711f $c5
    mD_12                                              ;; 0e:7120 $c2
    mF_12                                              ;; 0e:7121 $c5
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:7122 $e0 $57 $7a
    mD_12                                              ;; 0e:7125 $c2
    mF_12                                              ;; 0e:7126 $c5
    mD_12                                              ;; 0e:7127 $c2
    mF_12                                              ;; 0e:7128 $c5
    mVOLUME_ENVELOPE data_0e_7a65                      ;; 0e:7129 $e0 $65 $7a
    mE_12                                              ;; 0e:712c $c4
    mF_12                                              ;; 0e:712d $c5
    mE_12                                              ;; 0e:712e $c4
    mF_12                                              ;; 0e:712f $c5
    mVOLUME_ENVELOPE data_0e_7a63                      ;; 0e:7130 $e0 $63 $7a
    mE_12                                              ;; 0e:7133 $c4
    mF_12                                              ;; 0e:7134 $c5
    mE_12                                              ;; 0e:7135 $c4
    mF_12                                              ;; 0e:7136 $c5
    mVOLUME_ENVELOPE data_0e_7a61                      ;; 0e:7137 $e0 $61 $7a
    mE_12                                              ;; 0e:713a $c4
    mF_12                                              ;; 0e:713b $c5
    mE_12                                              ;; 0e:713c $c4
    mF_12                                              ;; 0e:713d $c5
    mVOLUME_ENVELOPE data_0e_7a5f                      ;; 0e:713e $e0 $5f $7a
    mE_12                                              ;; 0e:7141 $c4
    mF_12                                              ;; 0e:7142 $c5
    mE_12                                              ;; 0e:7143 $c4
    mF_12                                              ;; 0e:7144 $c5
    mVOLUME_ENVELOPE data_0e_7a5d                      ;; 0e:7145 $e0 $5d $7a
    mE_12                                              ;; 0e:7148 $c4
    mF_12                                              ;; 0e:7149 $c5
    mE_12                                              ;; 0e:714a $c4
    mF_12                                              ;; 0e:714b $c5
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:714c $e0 $5b $7a
    mE_12                                              ;; 0e:714f $c4
    mF_12                                              ;; 0e:7150 $c5
    mE_12                                              ;; 0e:7151 $c4
    mF_12                                              ;; 0e:7152 $c5
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:7153 $e0 $59 $7a
    mE_12                                              ;; 0e:7156 $c4
    mF_12                                              ;; 0e:7157 $c5
    mE_12                                              ;; 0e:7158 $c4
    mF_12                                              ;; 0e:7159 $c5
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:715a $e0 $57 $7a
    mE_12                                              ;; 0e:715d $c4
    mF_12                                              ;; 0e:715e $c5
    mE_12                                              ;; 0e:715f $c4
    mF_12                                              ;; 0e:7160 $c5
    mJUMP .data_0e_6f54                                ;; 0e:7161 $e1 $54 $6f

song0c_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:7164 $e4 $fe $79
    mWAVETABLE data_0e_7aa5                            ;; 0e:7167 $e8 $a5 $7a
    mVOLUME $20                                        ;; 0e:716a $e0 $20
    mSTEREOPAN $02                                     ;; 0e:716c $e6 $02
.data_0e_716e:
    mCOUNTER_2 $02                                     ;; 0e:716e $ea $02
.data_0e_7170:
    mCOUNTER $03                                       ;; 0e:7170 $e3 $03
.data_0e_7172:
    mOCTAVE_1                                          ;; 0e:7172 $d1
    mA_8                                               ;; 0e:7173 $89
    mOCTAVE_PLUS_1                                     ;; 0e:7174 $d8
    mE_8                                               ;; 0e:7175 $84
    mA_8                                               ;; 0e:7176 $89
    mE_8                                               ;; 0e:7177 $84
    mCisPlus_8                                         ;; 0e:7178 $8d
    mA_8                                               ;; 0e:7179 $89
    mE_8                                               ;; 0e:717a $84
    mA_8                                               ;; 0e:717b $89
    mREPEAT .data_0e_7172                              ;; 0e:717c $e2 $72 $71
    mCOUNTER $03                                       ;; 0e:717f $e3 $03
.data_0e_7181:
    mOCTAVE_MINUS_1                                    ;; 0e:7181 $dc
    mF_8                                               ;; 0e:7182 $85
    mCPlus_8                                           ;; 0e:7183 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:7184 $d8
    mF_8                                               ;; 0e:7185 $85
    mC_8                                               ;; 0e:7186 $80
    mA_8                                               ;; 0e:7187 $89
    mF_8                                               ;; 0e:7188 $85
    mC_8                                               ;; 0e:7189 $80
    mF_8                                               ;; 0e:718a $85
    mREPEAT .data_0e_7181                              ;; 0e:718b $e2 $81 $71
    mREPEAT_2 .data_0e_7170                            ;; 0e:718e $e9 $70 $71
    mCOUNTER $02                                       ;; 0e:7191 $e3 $02
.data_0e_7193:
    mOCTAVE_MINUS_1                                    ;; 0e:7193 $dc
    mG_8                                               ;; 0e:7194 $87
    mOCTAVE_PLUS_1                                     ;; 0e:7195 $d8
    mD_8                                               ;; 0e:7196 $82
    mG_8                                               ;; 0e:7197 $87
    mD_8                                               ;; 0e:7198 $82
    mB_8                                               ;; 0e:7199 $8b
    mG_8                                               ;; 0e:719a $87
    mD_8                                               ;; 0e:719b $82
    mG_8                                               ;; 0e:719c $87
    mOCTAVE_MINUS_1                                    ;; 0e:719d $dc
    mGis_8                                             ;; 0e:719e $88
    mOCTAVE_PLUS_1                                     ;; 0e:719f $d8
    mDis_8                                             ;; 0e:71a0 $83
    mGis_8                                             ;; 0e:71a1 $88
    mDis_8                                             ;; 0e:71a2 $83
    mCPlus_8                                           ;; 0e:71a3 $8c
    mGis_8                                             ;; 0e:71a4 $88
    mDis_8                                             ;; 0e:71a5 $83
    mGis_8                                             ;; 0e:71a6 $88
    mJUMPIF $01, .data_0e_71c6                         ;; 0e:71a7 $eb $01 $c6 $71
    mOCTAVE_MINUS_1                                    ;; 0e:71ab $dc
    mF_8                                               ;; 0e:71ac $85
    mCPlus_8                                           ;; 0e:71ad $8c
    mOCTAVE_PLUS_1                                     ;; 0e:71ae $d8
    mF_8                                               ;; 0e:71af $85
    mGis_8                                             ;; 0e:71b0 $88
    mOCTAVE_MINUS_1                                    ;; 0e:71b1 $dc
    mAis_8                                             ;; 0e:71b2 $8a
    mOCTAVE_PLUS_1                                     ;; 0e:71b3 $d8
    mF_8                                               ;; 0e:71b4 $85
    mAis_8                                             ;; 0e:71b5 $8a
    mF_8                                               ;; 0e:71b6 $85
    mOCTAVE_MINUS_1                                    ;; 0e:71b7 $dc
    mDis_8                                             ;; 0e:71b8 $83
    mAis_8                                             ;; 0e:71b9 $8a
    mOCTAVE_PLUS_1                                     ;; 0e:71ba $d8
    mDis_8                                             ;; 0e:71bb $83
    mG_8                                               ;; 0e:71bc $87
    mAis_8                                             ;; 0e:71bd $8a
    mG_8                                               ;; 0e:71be $87
    mDis_8                                             ;; 0e:71bf $83
    mOCTAVE_MINUS_1                                    ;; 0e:71c0 $dc
    mAis_8                                             ;; 0e:71c1 $8a
    mOCTAVE_PLUS_1                                     ;; 0e:71c2 $d8
    mREPEAT .data_0e_7193                              ;; 0e:71c3 $e2 $93 $71
.data_0e_71c6:
    mOCTAVE_MINUS_1                                    ;; 0e:71c6 $dc
    mAis_8                                             ;; 0e:71c7 $8a
    mOCTAVE_PLUS_1                                     ;; 0e:71c8 $d8
    mF_8                                               ;; 0e:71c9 $85
    mAis_8                                             ;; 0e:71ca $8a
    mF_8                                               ;; 0e:71cb $85
    mD_8                                               ;; 0e:71cc $82
    mF_8                                               ;; 0e:71cd $85
    mAis_8                                             ;; 0e:71ce $8a
    mF_8                                               ;; 0e:71cf $85
    mOCTAVE_MINUS_1                                    ;; 0e:71d0 $dc
    mC_8                                               ;; 0e:71d1 $80
    mCPlus_8                                           ;; 0e:71d2 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:71d3 $d8
    mE_8                                               ;; 0e:71d4 $84
    mG_8                                               ;; 0e:71d5 $87
    mCPlus_8                                           ;; 0e:71d6 $8c
    mG_8                                               ;; 0e:71d7 $87
    mE_8                                               ;; 0e:71d8 $84
    mC_8                                               ;; 0e:71d9 $80
    mJUMP .data_0e_716e                                ;; 0e:71da $e1 $6e $71

song0d_channel2:
    mVIBRATO frequencyDeltaData                        ;; 0e:71dd $e4 $fe $79
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:71e0 $e0 $31 $7a
    mDUTYCYCLE $40                                     ;; 0e:71e3 $e5 $40
    mSTEREOPAN $03                                     ;; 0e:71e5 $e6 $03
.data_0e_71e7:
    mTEMPO $49                                         ;; 0e:71e7 $e7 $49
    mOCTAVE_2                                          ;; 0e:71e9 $d2
    mAis_8                                             ;; 0e:71ea $8a
    mTEMPO $46                                         ;; 0e:71eb $e7 $46
    mA_8                                               ;; 0e:71ed $89
    mTEMPO $44                                         ;; 0e:71ee $e7 $44
    mAis_8                                             ;; 0e:71f0 $8a
    mTEMPO $41                                         ;; 0e:71f1 $e7 $41
    mB_8                                               ;; 0e:71f3 $8b
    mTEMPO $3c                                         ;; 0e:71f4 $e7 $3c
    mCPlus_5                                           ;; 0e:71f6 $5c
    mB_5                                               ;; 0e:71f7 $5b
    mCOUNTER $02                                       ;; 0e:71f8 $e3 $02
.data_0e_71fa:
    mTEMPO $4e                                         ;; 0e:71fa $e7 $4e
    mVOLUME_ENVELOPE data_0e_7a6d                      ;; 0e:71fc $e0 $6d $7a
    mAis_4                                             ;; 0e:71ff $4a
    mB_10                                              ;; 0e:7200 $ab
    mCPlus_10                                          ;; 0e:7201 $ac
    mCisPlus_4                                         ;; 0e:7202 $4d
    mOCTAVE_PLUS_1                                     ;; 0e:7203 $d8
    mD_10                                              ;; 0e:7204 $a2
    mDis_10                                            ;; 0e:7205 $a3
    mE_8                                               ;; 0e:7206 $84
    mDis_11                                            ;; 0e:7207 $b3
    mE_11                                              ;; 0e:7208 $b4
    mDis_11                                            ;; 0e:7209 $b3
    mCis_4                                             ;; 0e:720a $41
    mC_11                                              ;; 0e:720b $b0
    mCis_11                                            ;; 0e:720c $b1
    mC_11                                              ;; 0e:720d $b0
    mOCTAVE_MINUS_1                                    ;; 0e:720e $dc
    mAis_8                                             ;; 0e:720f $8a
    mGis_8                                             ;; 0e:7210 $88
    mG_5                                               ;; 0e:7211 $57
    mWait_11                                           ;; 0e:7212 $be
    mAis_11                                            ;; 0e:7213 $ba
    mCPlus_11                                          ;; 0e:7214 $bc
    mAis_11                                            ;; 0e:7215 $ba
    mG_11                                              ;; 0e:7216 $b7
    mF_11                                              ;; 0e:7217 $b5
    mG_0                                               ;; 0e:7218 $07
    mJUMPIF $01, .data_0e_7229                         ;; 0e:7219 $eb $01 $29 $72
    mAis_11                                            ;; 0e:721d $ba
    mG_11                                              ;; 0e:721e $b7
    mAis_11                                            ;; 0e:721f $ba
    mCisPlus_11                                        ;; 0e:7220 $bd
    mAis_11                                            ;; 0e:7221 $ba
    mCisPlus_11                                        ;; 0e:7222 $bd
    mOCTAVE_PLUS_1                                     ;; 0e:7223 $d8
    mE_5                                               ;; 0e:7224 $54
    mOCTAVE_MINUS_1                                    ;; 0e:7225 $dc
    mREPEAT .data_0e_71fa                              ;; 0e:7226 $e2 $fa $71
.data_0e_7229:
    mAis_8                                             ;; 0e:7229 $8a
    mA_10                                              ;; 0e:722a $a9
    mGis_10                                            ;; 0e:722b $a8
    mG_5                                               ;; 0e:722c $57
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:722d $e0 $31 $7a
    mSTEREOPAN $01                                     ;; 0e:7230 $e6 $01
    mFis_11                                            ;; 0e:7232 $b6
    mA_11                                              ;; 0e:7233 $b9
    mFis_11                                            ;; 0e:7234 $b6
    mCPlus_11                                          ;; 0e:7235 $bc
    mA_11                                              ;; 0e:7236 $b9
    mCPlus_11                                          ;; 0e:7237 $bc
    mOCTAVE_PLUS_1                                     ;; 0e:7238 $d8
    mDis_5                                             ;; 0e:7239 $53
    mOCTAVE_MINUS_1                                    ;; 0e:723a $dc
    mSTEREOPAN $02                                     ;; 0e:723b $e6 $02
    mF_11                                              ;; 0e:723d $b5
    mGis_11                                            ;; 0e:723e $b8
    mF_11                                              ;; 0e:723f $b5
    mB_11                                              ;; 0e:7240 $bb
    mGis_11                                            ;; 0e:7241 $b8
    mB_11                                              ;; 0e:7242 $bb
    mOCTAVE_PLUS_1                                     ;; 0e:7243 $d8
    mD_5                                               ;; 0e:7244 $52
    mOCTAVE_MINUS_1                                    ;; 0e:7245 $dc
    mSTEREOPAN $03                                     ;; 0e:7246 $e6 $03
    mE_8                                               ;; 0e:7248 $84
    mF_8                                               ;; 0e:7249 $85
    mFis_8                                             ;; 0e:724a $86
    mG_8                                               ;; 0e:724b $87
    mGis_5                                             ;; 0e:724c $58
    mA_5                                               ;; 0e:724d $59
    mJUMP .data_0e_71e7                                ;; 0e:724e $e1 $e7 $71

song0d_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:7251 $e4 $fe $79
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:7254 $e0 $31 $7a
    mDUTYCYCLE $00                                     ;; 0e:7257 $e5 $00
    mSTEREOPAN $03                                     ;; 0e:7259 $e6 $03
.data_0e_725b:
    mOCTAVE_2                                          ;; 0e:725b $d2
    mG_8                                               ;; 0e:725c $87
    mFis_8                                             ;; 0e:725d $86
    mG_8                                               ;; 0e:725e $87
    mGis_8                                             ;; 0e:725f $88
    mA_5                                               ;; 0e:7260 $59
    mGis_5                                             ;; 0e:7261 $58
    mCOUNTER $02                                       ;; 0e:7262 $e3 $02
.data_0e_7264:
    mVOLUME_ENVELOPE data_0e_7a71                      ;; 0e:7264 $e0 $71 $7a
    mSTEREOPAN $01                                     ;; 0e:7267 $e6 $01
    mG_4                                               ;; 0e:7269 $47
    mSTEREOPAN $03                                     ;; 0e:726a $e6 $03
    mGis_10                                            ;; 0e:726c $a8
    mA_10                                              ;; 0e:726d $a9
    mSTEREOPAN $02                                     ;; 0e:726e $e6 $02
    mAis_4                                             ;; 0e:7270 $4a
    mSTEREOPAN $03                                     ;; 0e:7271 $e6 $03
    mB_10                                              ;; 0e:7273 $ab
    mCPlus_10                                          ;; 0e:7274 $ac
    mSTEREOPAN $01                                     ;; 0e:7275 $e6 $01
    mCisPlus_8                                         ;; 0e:7277 $8d
    mSTEREOPAN $03                                     ;; 0e:7278 $e6 $03
    mCPlus_11                                          ;; 0e:727a $bc
    mCisPlus_11                                        ;; 0e:727b $bd
    mCPlus_11                                          ;; 0e:727c $bc
    mSTEREOPAN $02                                     ;; 0e:727d $e6 $02
    mAis_4                                             ;; 0e:727f $4a
    mSTEREOPAN $03                                     ;; 0e:7280 $e6 $03
    mA_11                                              ;; 0e:7282 $b9
    mAis_11                                            ;; 0e:7283 $ba
    mA_11                                              ;; 0e:7284 $b9
    mSTEREOPAN $01                                     ;; 0e:7285 $e6 $01
    mG_8                                               ;; 0e:7287 $87
    mF_8                                               ;; 0e:7288 $85
    mSTEREOPAN $02                                     ;; 0e:7289 $e6 $02
    mE_10                                              ;; 0e:728b $a4
    mDis_10                                            ;; 0e:728c $a3
    mSTEREOPAN $03                                     ;; 0e:728d $e6 $03
    mD_10                                              ;; 0e:728f $a2
    mCis_10                                            ;; 0e:7290 $a1
    mSTEREOPAN $01                                     ;; 0e:7291 $e6 $01
    mE_10                                              ;; 0e:7293 $a4
    mDis_10                                            ;; 0e:7294 $a3
    mSTEREOPAN $03                                     ;; 0e:7295 $e6 $03
    mD_10                                              ;; 0e:7297 $a2
    mCis_10                                            ;; 0e:7298 $a1
    mSTEREOPAN $02                                     ;; 0e:7299 $e6 $02
    mE_10                                              ;; 0e:729b $a4
    mDis_10                                            ;; 0e:729c $a3
    mSTEREOPAN $03                                     ;; 0e:729d $e6 $03
    mD_10                                              ;; 0e:729f $a2
    mCis_10                                            ;; 0e:72a0 $a1
    mSTEREOPAN $01                                     ;; 0e:72a1 $e6 $01
    mE_10                                              ;; 0e:72a3 $a4
    mDis_10                                            ;; 0e:72a4 $a3
    mSTEREOPAN $03                                     ;; 0e:72a5 $e6 $03
    mD_10                                              ;; 0e:72a7 $a2
    mCis_10                                            ;; 0e:72a8 $a1
    mJUMPIF $01, .data_0e_72ce                         ;; 0e:72a9 $eb $01 $ce $72
    mSTEREOPAN $02                                     ;; 0e:72ad $e6 $02
    mE_10                                              ;; 0e:72af $a4
    mDis_10                                            ;; 0e:72b0 $a3
    mSTEREOPAN $03                                     ;; 0e:72b1 $e6 $03
    mD_10                                              ;; 0e:72b3 $a2
    mCis_10                                            ;; 0e:72b4 $a1
    mSTEREOPAN $01                                     ;; 0e:72b5 $e6 $01
    mE_10                                              ;; 0e:72b7 $a4
    mDis_10                                            ;; 0e:72b8 $a3
    mSTEREOPAN $02                                     ;; 0e:72b9 $e6 $02
    mD_10                                              ;; 0e:72bb $a2
    mCis_10                                            ;; 0e:72bc $a1
    mSTEREOPAN $03                                     ;; 0e:72bd $e6 $03
    mG_11                                              ;; 0e:72bf $b7
    mE_11                                              ;; 0e:72c0 $b4
    mG_11                                              ;; 0e:72c1 $b7
    mAis_11                                            ;; 0e:72c2 $ba
    mG_11                                              ;; 0e:72c3 $b7
    mAis_11                                            ;; 0e:72c4 $ba
    mSTEREOPAN $01                                     ;; 0e:72c5 $e6 $01
    mDis_10                                            ;; 0e:72c7 $a3
    mE_10                                              ;; 0e:72c8 $a4
    mF_10                                              ;; 0e:72c9 $a5
    mFis_10                                            ;; 0e:72ca $a6
    mREPEAT .data_0e_7264                              ;; 0e:72cb $e2 $64 $72
.data_0e_72ce:
    mSTEREOPAN $02                                     ;; 0e:72ce $e6 $02
    mE_10                                              ;; 0e:72d0 $a4
    mDis_10                                            ;; 0e:72d1 $a3
    mSTEREOPAN $03                                     ;; 0e:72d2 $e6 $03
    mD_10                                              ;; 0e:72d4 $a2
    mCis_10                                            ;; 0e:72d5 $a1
    mSTEREOPAN $01                                     ;; 0e:72d6 $e6 $01
    mE_10                                              ;; 0e:72d8 $a4
    mDis_10                                            ;; 0e:72d9 $a3
    mSTEREOPAN $03                                     ;; 0e:72da $e6 $03
    mD_10                                              ;; 0e:72dc $a2
    mCis_10                                            ;; 0e:72dd $a1
    mSTEREOPAN $02                                     ;; 0e:72de $e6 $02
    mE_10                                              ;; 0e:72e0 $a4
    mDis_10                                            ;; 0e:72e1 $a3
    mSTEREOPAN $03                                     ;; 0e:72e2 $e6 $03
    mD_10                                              ;; 0e:72e4 $a2
    mCis_10                                            ;; 0e:72e5 $a1
    mSTEREOPAN $01                                     ;; 0e:72e6 $e6 $01
    mE_10                                              ;; 0e:72e8 $a4
    mDis_10                                            ;; 0e:72e9 $a3
    mSTEREOPAN $03                                     ;; 0e:72ea $e6 $03
    mD_10                                              ;; 0e:72ec $a2
    mCis_10                                            ;; 0e:72ed $a1
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:72ee $e0 $31 $7a
    mSTEREOPAN $02                                     ;; 0e:72f1 $e6 $02
    mDis_2                                             ;; 0e:72f3 $23
    mSTEREOPAN $01                                     ;; 0e:72f4 $e6 $01
    mD_2                                               ;; 0e:72f6 $22
    mSTEREOPAN $03                                     ;; 0e:72f7 $e6 $03
    mCis_8                                             ;; 0e:72f9 $81
    mD_8                                               ;; 0e:72fa $82
    mDis_8                                             ;; 0e:72fb $83
    mE_8                                               ;; 0e:72fc $84
    mF_5                                               ;; 0e:72fd $55
    mFis_5                                             ;; 0e:72fe $56
    mJUMP .data_0e_725b                                ;; 0e:72ff $e1 $5b $72

song0d_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:7302 $e4 $fe $79
    mWAVETABLE data_0e_7a95                            ;; 0e:7305 $e8 $95 $7a
    mVOLUME $20                                        ;; 0e:7308 $e0 $20
    mSTEREOPAN $03                                     ;; 0e:730a $e6 $03
.data_0e_730c:
    mOCTAVE_2                                          ;; 0e:730c $d2
    mE_8                                               ;; 0e:730d $84
    mDis_8                                             ;; 0e:730e $83
    mE_8                                               ;; 0e:730f $84
    mF_8                                               ;; 0e:7310 $85
    mFis_5                                             ;; 0e:7311 $56
    mF_5                                               ;; 0e:7312 $55
    mCOUNTER $0e                                       ;; 0e:7313 $e3 $0e
.data_0e_7315:
    mE_10                                              ;; 0e:7315 $a4
    mRest_10                                           ;; 0e:7316 $af
    mREPEAT .data_0e_7315                              ;; 0e:7317 $e2 $15 $73
    mE_8                                               ;; 0e:731a $84
    mDis_10                                            ;; 0e:731b $a3
    mD_10                                              ;; 0e:731c $a2
    mCOUNTER $0e                                       ;; 0e:731d $e3 $0e
.data_0e_731f:
    mCis_10                                            ;; 0e:731f $a1
    mRest_10                                           ;; 0e:7320 $af
    mREPEAT .data_0e_731f                              ;; 0e:7321 $e2 $1f $73
    mCis_8                                             ;; 0e:7324 $81
    mD_10                                              ;; 0e:7325 $a2
    mDis_10                                            ;; 0e:7326 $a3
    mCOUNTER $0e                                       ;; 0e:7327 $e3 $0e
.data_0e_7329:
    mE_10                                              ;; 0e:7329 $a4
    mRest_10                                           ;; 0e:732a $af
    mREPEAT .data_0e_7329                              ;; 0e:732b $e2 $29 $73
    mE_8                                               ;; 0e:732e $84
    mDis_10                                            ;; 0e:732f $a3
    mD_10                                              ;; 0e:7330 $a2
    mCOUNTER $10                                       ;; 0e:7331 $e3 $10
.data_0e_7333:
    mCis_10                                            ;; 0e:7333 $a1
    mRest_10                                           ;; 0e:7334 $af
    mREPEAT .data_0e_7333                              ;; 0e:7335 $e2 $33 $73
    mC_2                                               ;; 0e:7338 $20
    mOCTAVE_MINUS_1                                    ;; 0e:7339 $dc
    mB_2                                               ;; 0e:733a $2b
    mAis_8                                             ;; 0e:733b $8a
    mB_8                                               ;; 0e:733c $8b
    mCPlus_8                                           ;; 0e:733d $8c
    mCisPlus_8                                         ;; 0e:733e $8d
    mOCTAVE_PLUS_1                                     ;; 0e:733f $d8
    mD_5                                               ;; 0e:7340 $52
    mDis_5                                             ;; 0e:7341 $53
    mJUMP .data_0e_730c                                ;; 0e:7342 $e1 $0c $73

song0e_channel2:
    mVIBRATO frequencyDeltaData                        ;; 0e:7345 $e4 $fe $79
    mSTEREOPAN $03                                     ;; 0e:7348 $e6 $03
    mTEMPO $42                                         ;; 0e:734a $e7 $42
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:734c $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:734f $e5 $80
    mOCTAVE_1                                          ;; 0e:7351 $d1
    mRest_8                                            ;; 0e:7352 $8f
    mB_8                                               ;; 0e:7353 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:7354 $d8
    mFis_8                                             ;; 0e:7355 $86
    mE_8                                               ;; 0e:7356 $84
    mB_5                                               ;; 0e:7357 $5b
    mGis_8                                             ;; 0e:7358 $88
    mA_8                                               ;; 0e:7359 $89
    mB_8                                               ;; 0e:735a $8b
    mA_8                                               ;; 0e:735b $89
    mGis_8                                             ;; 0e:735c $88
    mA_8                                               ;; 0e:735d $89
    mE_5                                               ;; 0e:735e $54
    mFis_5                                             ;; 0e:735f $56
    mOCTAVE_MINUS_1                                    ;; 0e:7360 $dc
    mRest_8                                            ;; 0e:7361 $8f
    mB_8                                               ;; 0e:7362 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:7363 $d8
    mFis_8                                             ;; 0e:7364 $86
    mE_8                                               ;; 0e:7365 $84
    mB_5                                               ;; 0e:7366 $5b
    mGis_8                                             ;; 0e:7367 $88
    mA_8                                               ;; 0e:7368 $89
    mB_8                                               ;; 0e:7369 $8b
    mA_8                                               ;; 0e:736a $89
    mGis_8                                             ;; 0e:736b $88
    mA_8                                               ;; 0e:736c $89
    mE_5                                               ;; 0e:736d $54
    mFis_5                                             ;; 0e:736e $56
    mOCTAVE_PLUS_1                                     ;; 0e:736f $d8
    mVOLUME_ENVELOPE data_0e_7a6d                      ;; 0e:7370 $e0 $6d $7a
    mDUTYCYCLE $40                                     ;; 0e:7373 $e5 $40
    mGis_8                                             ;; 0e:7375 $88
    mFis_8                                             ;; 0e:7376 $86
    mGis_8                                             ;; 0e:7377 $88
    mA_8                                               ;; 0e:7378 $89
    mB_4                                               ;; 0e:7379 $4b
    mCisPlus_8                                         ;; 0e:737a $8d
    mB_1                                               ;; 0e:737b $1b
    mA_8                                               ;; 0e:737c $89
    mGis_8                                             ;; 0e:737d $88
    mA_5                                               ;; 0e:737e $59
    mCis_5                                             ;; 0e:737f $51
    mE_5                                               ;; 0e:7380 $54
    mA_5                                               ;; 0e:7381 $59
    mGis_1                                             ;; 0e:7382 $18
    mFis_8                                             ;; 0e:7383 $86
    mE_8                                               ;; 0e:7384 $84
    mFis_2                                             ;; 0e:7385 $26
    mGis_8                                             ;; 0e:7386 $88
    mFis_8                                             ;; 0e:7387 $86
    mE_8                                               ;; 0e:7388 $84
    mFis_8                                             ;; 0e:7389 $86
    mE_2                                               ;; 0e:738a $24
    mFis_8                                             ;; 0e:738b $86
    mE_8                                               ;; 0e:738c $84
    mDis_8                                             ;; 0e:738d $83
    mE_8                                               ;; 0e:738e $84
    mCis_8                                             ;; 0e:738f $81
    mDis_8                                             ;; 0e:7390 $83
    mE_8                                               ;; 0e:7391 $84
    mFis_8                                             ;; 0e:7392 $86
    mDis_5                                             ;; 0e:7393 $53
    mOCTAVE_MINUS_1                                    ;; 0e:7394 $dc
    mB_8                                               ;; 0e:7395 $8b
    mCisPlus_8                                         ;; 0e:7396 $8d
    mCisPlus_0                                         ;; 0e:7397 $0d
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:7398 $e0 $31 $7a
    mTEMPO $3c                                         ;; 0e:739b $e7 $3c
    mA_8                                               ;; 0e:739d $89
    mGis_8                                             ;; 0e:739e $88
    mA_8                                               ;; 0e:739f $89
    mB_8                                               ;; 0e:73a0 $8b
    mTEMPO $35                                         ;; 0e:73a1 $e7 $35
    mCPlus_8                                           ;; 0e:73a3 $8c
    mB_8                                               ;; 0e:73a4 $8b
    mCPlus_8                                           ;; 0e:73a5 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:73a6 $d8
    mTEMPO $31                                         ;; 0e:73a7 $e7 $31
    mD_8                                               ;; 0e:73a9 $82
    mE_1                                               ;; 0e:73aa $14
    mTEMPO $7d                                         ;; 0e:73ab $e7 $7d
    mWait_5                                            ;; 0e:73ad $5e
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:73ae $e0 $57 $7a
    mOCTAVE_MINUS_1                                    ;; 0e:73b1 $dc
    mDis_5                                             ;; 0e:73b2 $53
    mDis_9                                             ;; 0e:73b3 $93
    mCis_9                                             ;; 0e:73b4 $91
    mDis_9                                             ;; 0e:73b5 $93
    mE_5                                               ;; 0e:73b6 $54
    mE_9                                               ;; 0e:73b7 $94
    mDis_9                                             ;; 0e:73b8 $93
    mE_9                                               ;; 0e:73b9 $94
    mF_5                                               ;; 0e:73ba $55
    mF_9                                               ;; 0e:73bb $95
    mE_9                                               ;; 0e:73bc $94
    mF_9                                               ;; 0e:73bd $95
    mFis_9                                             ;; 0e:73be $96
    mGis_9                                             ;; 0e:73bf $98
    mA_9                                               ;; 0e:73c0 $99
    mGis_9                                             ;; 0e:73c1 $98
    mFis_9                                             ;; 0e:73c2 $96
    mE_9                                               ;; 0e:73c3 $94
    mDis_5                                             ;; 0e:73c4 $53
    mDis_9                                             ;; 0e:73c5 $93
    mCis_9                                             ;; 0e:73c6 $91
    mDis_9                                             ;; 0e:73c7 $93
    mE_5                                               ;; 0e:73c8 $54
    mE_9                                               ;; 0e:73c9 $94
    mDis_9                                             ;; 0e:73ca $93
    mE_9                                               ;; 0e:73cb $94
    mF_5                                               ;; 0e:73cc $55
    mF_9                                               ;; 0e:73cd $95
    mE_9                                               ;; 0e:73ce $94
    mF_9                                               ;; 0e:73cf $95
    mDUTYCYCLE $80                                     ;; 0e:73d0 $e5 $80
    mFis_10                                            ;; 0e:73d2 $a6
    mGis_10                                            ;; 0e:73d3 $a8
    mA_10                                              ;; 0e:73d4 $a9
    mB_10                                              ;; 0e:73d5 $ab
    mCisPlus_11                                        ;; 0e:73d6 $bd
    mOCTAVE_PLUS_1                                     ;; 0e:73d7 $d8
    mDis_11                                            ;; 0e:73d8 $b3
    mE_11                                              ;; 0e:73d9 $b4
    mFis_11                                            ;; 0e:73da $b6
    mGis_11                                            ;; 0e:73db $b8
    mA_11                                              ;; 0e:73dc $b9
    mOCTAVE_MINUS_1                                    ;; 0e:73dd $dc
    mVOLUME_ENVELOPE data_0e_7a43                      ;; 0e:73de $e0 $43 $7a
    mDUTYCYCLE $40                                     ;; 0e:73e1 $e5 $40
    mB_9                                               ;; 0e:73e3 $9b
    mB_9                                               ;; 0e:73e4 $9b
    mB_9                                               ;; 0e:73e5 $9b
    mB_9                                               ;; 0e:73e6 $9b
    mFis_9                                             ;; 0e:73e7 $96
    mB_9                                               ;; 0e:73e8 $9b
    mCisPlus_9                                         ;; 0e:73e9 $9d
    mCisPlus_9                                         ;; 0e:73ea $9d
    mCisPlus_9                                         ;; 0e:73eb $9d
    mCisPlus_9                                         ;; 0e:73ec $9d
    mA_9                                               ;; 0e:73ed $99
    mCisPlus_9                                         ;; 0e:73ee $9d
    mOCTAVE_PLUS_1                                     ;; 0e:73ef $d8
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:73f0 $e0 $57 $7a
    mDis_0                                             ;; 0e:73f3 $03
    mOCTAVE_MINUS_1                                    ;; 0e:73f4 $dc
    mCOUNTER $02                                       ;; 0e:73f5 $e3 $02
.data_0e_73f7:
    mTEMPO $7d                                         ;; 0e:73f7 $e7 $7d
    mGis_2                                             ;; 0e:73f9 $28
    mWait_8                                            ;; 0e:73fa $8e
    mFis_8                                             ;; 0e:73fb $86
    mGis_8                                             ;; 0e:73fc $88
    mA_8                                               ;; 0e:73fd $89
    mFis_5                                             ;; 0e:73fe $56
    mB_5                                               ;; 0e:73ff $5b
    mCisPlus_5                                         ;; 0e:7400 $5d
    mOCTAVE_PLUS_1                                     ;; 0e:7401 $d8
    mDis_5                                             ;; 0e:7402 $53
    mD_2                                               ;; 0e:7403 $22
    mWait_8                                            ;; 0e:7404 $8e
    mD_8                                               ;; 0e:7405 $82
    mCis_8                                             ;; 0e:7406 $81
    mOCTAVE_MINUS_1                                    ;; 0e:7407 $dc
    mB_8                                               ;; 0e:7408 $8b
    mJUMPIF $01, .data_0e_742c                         ;; 0e:7409 $eb $01 $2c $74
    mB_5                                               ;; 0e:740d $5b
    mA_2                                               ;; 0e:740e $29
    mA_8                                               ;; 0e:740f $89
    mB_8                                               ;; 0e:7410 $8b
    mCPlus_2                                           ;; 0e:7411 $2c
    mWait_8                                            ;; 0e:7412 $8e
    mOCTAVE_PLUS_1                                     ;; 0e:7413 $d8
    mE_8                                               ;; 0e:7414 $84
    mD_8                                               ;; 0e:7415 $82
    mC_8                                               ;; 0e:7416 $80
    mOCTAVE_MINUS_1                                    ;; 0e:7417 $dc
    mB_5                                               ;; 0e:7418 $5b
    mG_5                                               ;; 0e:7419 $57
    mD_5                                               ;; 0e:741a $52
    mFis_5                                             ;; 0e:741b $56
    mE_2                                               ;; 0e:741c $24
    mWait_8                                            ;; 0e:741d $8e
    mG_8                                               ;; 0e:741e $87
    mFis_8                                             ;; 0e:741f $86
    mE_8                                               ;; 0e:7420 $84
    mE_4                                               ;; 0e:7421 $44
    mDis_10                                            ;; 0e:7422 $a3
    mCis_10                                            ;; 0e:7423 $a1
    mDis_5                                             ;; 0e:7424 $53
    mTEMPO $76                                         ;; 0e:7425 $e7 $76
    mE_8                                               ;; 0e:7427 $84
    mFis_8                                             ;; 0e:7428 $86
    mREPEAT .data_0e_73f7                              ;; 0e:7429 $e2 $f7 $73
.data_0e_742c:
    mB_5                                               ;; 0e:742c $5b
    mA_5                                               ;; 0e:742d $59
    mWait_10                                           ;; 0e:742e $ae
    mFis_10                                            ;; 0e:742f $a6
    mF_10                                              ;; 0e:7430 $a5
    mFis_10                                            ;; 0e:7431 $a6
    mGis_10                                            ;; 0e:7432 $a8
    mFis_10                                            ;; 0e:7433 $a6
    mF_10                                              ;; 0e:7434 $a5
    mFis_10                                            ;; 0e:7435 $a6
    mOCTAVE_PLUS_1                                     ;; 0e:7436 $d8
    mDis_2                                             ;; 0e:7437 $23
    mE_8                                               ;; 0e:7438 $84
    mDis_8                                             ;; 0e:7439 $83
    mCis_8                                             ;; 0e:743a $81
    mDis_8                                             ;; 0e:743b $83
    mE_5                                               ;; 0e:743c $54
    mOCTAVE_MINUS_1                                    ;; 0e:743d $dc
    mB_5                                               ;; 0e:743e $5b
    mCisPlus_5                                         ;; 0e:743f $5d
    mA_5                                               ;; 0e:7440 $59
    mGis_3                                             ;; 0e:7441 $38
    mA_9                                               ;; 0e:7442 $99
    mGis_9                                             ;; 0e:7443 $98
    mFis_4                                             ;; 0e:7444 $46
    mE_8                                               ;; 0e:7445 $84
    mE_5                                               ;; 0e:7446 $54
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:7447 $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:744a $e5 $80
    mTEMPO $7a                                         ;; 0e:744c $e7 $7a
    mGis_5                                             ;; 0e:744e $58
    mA_5                                               ;; 0e:744f $59
    mB_5                                               ;; 0e:7450 $5b
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:7451 $e0 $55 $7a
    mTEMPO $7d                                         ;; 0e:7454 $e7 $7d
    mA_9                                               ;; 0e:7456 $99
    mCisPlus_9                                         ;; 0e:7457 $9d
    mA_9                                               ;; 0e:7458 $99
    mOCTAVE_PLUS_1                                     ;; 0e:7459 $d8
    mE_9                                               ;; 0e:745a $94
    mCis_9                                             ;; 0e:745b $91
    mE_9                                               ;; 0e:745c $94
    mVOLUME_ENVELOPE data_0e_7a6b                      ;; 0e:745d $e0 $6b $7a
    mGis_2                                             ;; 0e:7460 $28
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:7461 $e0 $57 $7a
    mDUTYCYCLE $40                                     ;; 0e:7464 $e5 $40
    mRest_8                                            ;; 0e:7466 $8f
    mDis_10                                            ;; 0e:7467 $a3
    mCis_10                                            ;; 0e:7468 $a1
    mDis_8                                             ;; 0e:7469 $83
    mE_8                                               ;; 0e:746a $84
    mFis_10                                            ;; 0e:746b $a6
    mGis_10                                            ;; 0e:746c $a8
    mFis_10                                            ;; 0e:746d $a6
    mE_10                                              ;; 0e:746e $a4
    mDis_10                                            ;; 0e:746f $a3
    mE_10                                              ;; 0e:7470 $a4
    mDis_10                                            ;; 0e:7471 $a3
    mCis_10                                            ;; 0e:7472 $a1
    mVOLUME_ENVELOPE data_0e_7a55                      ;; 0e:7473 $e0 $55 $7a
    mDUTYCYCLE $80                                     ;; 0e:7476 $e5 $80
    mOCTAVE_MINUS_1                                    ;; 0e:7478 $dc
    mGis_9                                             ;; 0e:7479 $98
    mB_9                                               ;; 0e:747a $9b
    mGis_9                                             ;; 0e:747b $98
    mOCTAVE_PLUS_1                                     ;; 0e:747c $d8
    mDis_9                                             ;; 0e:747d $93
    mOCTAVE_MINUS_1                                    ;; 0e:747e $dc
    mB_9                                               ;; 0e:747f $9b
    mOCTAVE_PLUS_1                                     ;; 0e:7480 $d8
    mDis_9                                             ;; 0e:7481 $93
    mVOLUME_ENVELOPE data_0e_7a6b                      ;; 0e:7482 $e0 $6b $7a
    mFis_2                                             ;; 0e:7485 $26
    mVOLUME_ENVELOPE data_0e_7a57                      ;; 0e:7486 $e0 $57 $7a
    mDUTYCYCLE $40                                     ;; 0e:7489 $e5 $40
    mRest_8                                            ;; 0e:748b $8f
    mE_10                                              ;; 0e:748c $a4
    mDis_10                                            ;; 0e:748d $a3
    mCis_8                                             ;; 0e:748e $81
    mDis_8                                             ;; 0e:748f $83
    mE_10                                              ;; 0e:7490 $a4
    mFis_10                                            ;; 0e:7491 $a6
    mE_10                                              ;; 0e:7492 $a4
    mDis_10                                            ;; 0e:7493 $a3
    mCis_10                                            ;; 0e:7494 $a1
    mDis_10                                            ;; 0e:7495 $a3
    mCis_10                                            ;; 0e:7496 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:7497 $dc
    mB_10                                              ;; 0e:7498 $ab
    mVOLUME_ENVELOPE data_0e_7a6d                      ;; 0e:7499 $e0 $6d $7a
    mA_4                                               ;; 0e:749c $49
    mGis_10                                            ;; 0e:749d $a8
    mA_10                                              ;; 0e:749e $a9
    mB_4                                               ;; 0e:749f $4b
    mA_10                                              ;; 0e:74a0 $a9
    mB_10                                              ;; 0e:74a1 $ab
    mCisPlus_8                                         ;; 0e:74a2 $8d
    mB_10                                              ;; 0e:74a3 $ab
    mCisPlus_10                                        ;; 0e:74a4 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:74a5 $d8
    mDis_8                                             ;; 0e:74a6 $83
    mCis_10                                            ;; 0e:74a7 $a1
    mDis_10                                            ;; 0e:74a8 $a3
    mE_8                                               ;; 0e:74a9 $84
    mDis_10                                            ;; 0e:74aa $a3
    mE_10                                              ;; 0e:74ab $a4
    mFis_8                                             ;; 0e:74ac $86
    mE_10                                              ;; 0e:74ad $a4
    mFis_10                                            ;; 0e:74ae $a6
    mGis_4                                             ;; 0e:74af $48
    mE_10                                              ;; 0e:74b0 $a4
    mFis_10                                            ;; 0e:74b1 $a6
    mGis_8                                             ;; 0e:74b2 $88
    mFis_8                                             ;; 0e:74b3 $86
    mGis_8                                             ;; 0e:74b4 $88
    mA_8                                               ;; 0e:74b5 $89
    mFis_4                                             ;; 0e:74b6 $46
    mGis_10                                            ;; 0e:74b7 $a8
    mA_10                                              ;; 0e:74b8 $a9
    mGis_8                                             ;; 0e:74b9 $88
    mFis_8                                             ;; 0e:74ba $86
    mE_8                                               ;; 0e:74bb $84
    mDis_8                                             ;; 0e:74bc $83
    mCis_4                                             ;; 0e:74bd $41
    mOCTAVE_MINUS_1                                    ;; 0e:74be $dc
    mB_10                                              ;; 0e:74bf $ab
    mCisPlus_10                                        ;; 0e:74c0 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:74c1 $d8
    mDis_4                                             ;; 0e:74c2 $43
    mCis_10                                            ;; 0e:74c3 $a1
    mDis_10                                            ;; 0e:74c4 $a3
    mE_10                                              ;; 0e:74c5 $a4
    mDis_10                                            ;; 0e:74c6 $a3
    mCis_10                                            ;; 0e:74c7 $a1
    mDis_10                                            ;; 0e:74c8 $a3
    mDUTYCYCLE $00                                     ;; 0e:74c9 $e5 $00
    mE_10                                              ;; 0e:74cb $a4
    mDis_10                                            ;; 0e:74cc $a3
    mE_10                                              ;; 0e:74cd $a4
    mFis_10                                            ;; 0e:74ce $a6
    mDUTYCYCLE $40                                     ;; 0e:74cf $e5 $40
    mGis_10                                            ;; 0e:74d1 $a8
    mFis_10                                            ;; 0e:74d2 $a6
    mE_10                                              ;; 0e:74d3 $a4
    mFis_10                                            ;; 0e:74d4 $a6
    mDUTYCYCLE $80                                     ;; 0e:74d5 $e5 $80
    mGis_10                                            ;; 0e:74d7 $a8
    mFis_10                                            ;; 0e:74d8 $a6
    mGis_10                                            ;; 0e:74d9 $a8
    mA_10                                              ;; 0e:74da $a9
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:74db $e0 $31 $7a
    mB_0                                               ;; 0e:74de $0b
    mWait_0                                            ;; 0e:74df $0e
    mOCTAVE_MINUS_1                                    ;; 0e:74e0 $dc
    mVOLUME_ENVELOPE data_0e_7a6d                      ;; 0e:74e1 $e0 $6d $7a
    mFis_10                                            ;; 0e:74e4 $a6
    mE_10                                              ;; 0e:74e5 $a4
    mFis_10                                            ;; 0e:74e6 $a6
    mGis_10                                            ;; 0e:74e7 $a8
    mA_10                                              ;; 0e:74e8 $a9
    mGis_10                                            ;; 0e:74e9 $a8
    mA_10                                              ;; 0e:74ea $a9
    mB_10                                              ;; 0e:74eb $ab
    mCisPlus_10                                        ;; 0e:74ec $ad
    mB_10                                              ;; 0e:74ed $ab
    mCisPlus_10                                        ;; 0e:74ee $ad
    mOCTAVE_PLUS_1                                     ;; 0e:74ef $d8
    mD_10                                              ;; 0e:74f0 $a2
    mE_10                                              ;; 0e:74f1 $a4
    mFis_10                                            ;; 0e:74f2 $a6
    mGis_10                                            ;; 0e:74f3 $a8
    mA_10                                              ;; 0e:74f4 $a9
    mTEMPO $78                                         ;; 0e:74f5 $e7 $78
    mGis_10                                            ;; 0e:74f7 $a8
    mFis_10                                            ;; 0e:74f8 $a6
    mGis_10                                            ;; 0e:74f9 $a8
    mA_10                                              ;; 0e:74fa $a9
    mTEMPO $6e                                         ;; 0e:74fb $e7 $6e
    mDUTYCYCLE $40                                     ;; 0e:74fd $e5 $40
    mB_10                                              ;; 0e:74ff $ab
    mA_10                                              ;; 0e:7500 $a9
    mGis_10                                            ;; 0e:7501 $a8
    mFis_10                                            ;; 0e:7502 $a6
    mTEMPO $64                                         ;; 0e:7503 $e7 $64
    mDUTYCYCLE $00                                     ;; 0e:7505 $e5 $00
    mE_10                                              ;; 0e:7507 $a4
    mFis_10                                            ;; 0e:7508 $a6
    mTEMPO $50                                         ;; 0e:7509 $e7 $50
    mE_10                                              ;; 0e:750b $a4
    mD_10                                              ;; 0e:750c $a2
    mTEMPO $44                                         ;; 0e:750d $e7 $44
    mDUTYCYCLE $40                                     ;; 0e:750f $e5 $40
    mCis_10                                            ;; 0e:7511 $a1
    mD_10                                              ;; 0e:7512 $a2
    mCis_10                                            ;; 0e:7513 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:7514 $dc
    mB_10                                              ;; 0e:7515 $ab
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:7516 $e0 $31 $7a
    mDUTYCYCLE $80                                     ;; 0e:7519 $e5 $80
    mTEMPO $4b                                         ;; 0e:751b $e7 $4b
    mCisPlus_5                                         ;; 0e:751d $5d
    mB_8                                               ;; 0e:751e $8b
    mCisPlus_8                                         ;; 0e:751f $8d
    mOCTAVE_PLUS_1                                     ;; 0e:7520 $d8
    mD_8                                               ;; 0e:7521 $82
    mCis_8                                             ;; 0e:7522 $81
    mD_8                                               ;; 0e:7523 $82
    mFis_8                                             ;; 0e:7524 $86
    mE_5                                               ;; 0e:7525 $54
    mFis_8                                             ;; 0e:7526 $86
    mGis_8                                             ;; 0e:7527 $88
    mFis_8                                             ;; 0e:7528 $86
    mE_8                                               ;; 0e:7529 $84
    mD_8                                               ;; 0e:752a $82
    mCis_8                                             ;; 0e:752b $81
    mD_2                                               ;; 0e:752c $22
    mOCTAVE_MINUS_1                                    ;; 0e:752d $dc
    mA_5                                               ;; 0e:752e $59
    mB_5                                               ;; 0e:752f $5b
    mCisPlus_4                                         ;; 0e:7530 $4d
    mOCTAVE_PLUS_1                                     ;; 0e:7531 $d8
    mD_10                                              ;; 0e:7532 $a2
    mCis_10                                            ;; 0e:7533 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:7534 $dc
    mB_2                                               ;; 0e:7535 $2b
    mFis_5                                             ;; 0e:7536 $56
    mCisPlus_5                                         ;; 0e:7537 $5d
    mB_5                                               ;; 0e:7538 $5b
    mCisPlus_8                                         ;; 0e:7539 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:753a $d8
    mD_8                                               ;; 0e:753b $82
    mE_8                                               ;; 0e:753c $84
    mCis_8                                             ;; 0e:753d $81
    mD_8                                               ;; 0e:753e $82
    mE_8                                               ;; 0e:753f $84
    mFis_5                                             ;; 0e:7540 $56
    mCis_5                                             ;; 0e:7541 $51
    mOCTAVE_MINUS_1                                    ;; 0e:7542 $dc
    mB_2                                               ;; 0e:7543 $2b
    mFis_5                                             ;; 0e:7544 $56
    mGis_5                                             ;; 0e:7545 $58
    mA_1                                               ;; 0e:7546 $19
    mVOLUME_ENVELOPE data_0e_7a6d                      ;; 0e:7547 $e0 $6d $7a
    mDUTYCYCLE $40                                     ;; 0e:754a $e5 $40
    mTEMPO $55                                         ;; 0e:754c $e7 $55
    mG_11                                              ;; 0e:754e $b7
    mA_11                                              ;; 0e:754f $b9
    mB_11                                              ;; 0e:7550 $bb
    mOCTAVE_PLUS_1                                     ;; 0e:7551 $d8
    mC_11                                              ;; 0e:7552 $b0
    mD_11                                              ;; 0e:7553 $b2
    mDis_11                                            ;; 0e:7554 $b3
    mVOLUME_ENVELOPE data_0e_7a6b                      ;; 0e:7555 $e0 $6b $7a
    mDUTYCYCLE $80                                     ;; 0e:7558 $e5 $80
    mE_2                                               ;; 0e:755a $24
    mWait_8                                            ;; 0e:755b $8e
    mD_8                                               ;; 0e:755c $82
    mE_8                                               ;; 0e:755d $84
    mF_8                                               ;; 0e:755e $85
    mG_2                                               ;; 0e:755f $27
    mWait_8                                            ;; 0e:7560 $8e
    mA_8                                               ;; 0e:7561 $89
    mE_8                                               ;; 0e:7562 $84
    mG_8                                               ;; 0e:7563 $87
    mF_2                                               ;; 0e:7564 $25
    mWait_8                                            ;; 0e:7565 $8e
    mE_8                                               ;; 0e:7566 $84
    mF_8                                               ;; 0e:7567 $85
    mG_8                                               ;; 0e:7568 $87
    mF_2                                               ;; 0e:7569 $25
    mWait_8                                            ;; 0e:756a $8e
    mD_8                                               ;; 0e:756b $82
    mE_8                                               ;; 0e:756c $84
    mF_8                                               ;; 0e:756d $85
    mE_5                                               ;; 0e:756e $54
    mOCTAVE_MINUS_1                                    ;; 0e:756f $dc
    mB_4                                               ;; 0e:7570 $4b
    mOCTAVE_PLUS_1                                     ;; 0e:7571 $d8
    mD_8                                               ;; 0e:7572 $82
    mC_8                                               ;; 0e:7573 $80
    mOCTAVE_MINUS_1                                    ;; 0e:7574 $dc
    mB_8                                               ;; 0e:7575 $8b
    mCPlus_5                                           ;; 0e:7576 $5c
    mOCTAVE_PLUS_1                                     ;; 0e:7577 $d8
    mE_5                                               ;; 0e:7578 $54
    mD_5                                               ;; 0e:7579 $52
    mOCTAVE_MINUS_1                                    ;; 0e:757a $dc
    mA_8                                               ;; 0e:757b $89
    mB_8                                               ;; 0e:757c $8b
    mCPlus_2                                           ;; 0e:757d $2c
    mWait_8                                            ;; 0e:757e $8e
    mB_8                                               ;; 0e:757f $8b
    mCPlus_8                                           ;; 0e:7580 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:7581 $d8
    mE_8                                               ;; 0e:7582 $84
    mD_1                                               ;; 0e:7583 $12
    mC_5                                               ;; 0e:7584 $50
    mC_0                                               ;; 0e:7585 $00
    mWait_0                                            ;; 0e:7586 $0e
    mEND                                               ;; 0e:7587 $ff

song0e_channel1:
    mVIBRATO frequencyDeltaData                        ;; 0e:7588 $e4 $fe $79
    mVOLUME_ENVELOPE data_0e_7a71                      ;; 0e:758b $e0 $71 $7a
    mDUTYCYCLE $80                                     ;; 0e:758e $e5 $80
    mSTEREOPAN $03                                     ;; 0e:7590 $e6 $03
    mOCTAVE_1                                          ;; 0e:7592 $d1
    mRest_0                                            ;; 0e:7593 $0f
    mRest_0                                            ;; 0e:7594 $0f
    mRest_0                                            ;; 0e:7595 $0f
    mRest_0                                            ;; 0e:7596 $0f
    mRest_8                                            ;; 0e:7597 $8f
    mB_8                                               ;; 0e:7598 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:7599 $d8
    mE_8                                               ;; 0e:759a $84
    mFis_8                                             ;; 0e:759b $86
    mGis_4                                             ;; 0e:759c $48
    mA_8                                               ;; 0e:759d $89
    mB_5                                               ;; 0e:759e $5b
    mOCTAVE_PLUS_1                                     ;; 0e:759f $d8
    mDis_5                                             ;; 0e:75a0 $53
    mCis_5                                             ;; 0e:75a1 $51
    mOCTAVE_MINUS_1                                    ;; 0e:75a2 $dc
    mB_5                                               ;; 0e:75a3 $5b
    mRest_8                                            ;; 0e:75a4 $8f
    mCis_8                                             ;; 0e:75a5 $81
    mFis_8                                             ;; 0e:75a6 $86
    mGis_8                                             ;; 0e:75a7 $88
    mA_8                                               ;; 0e:75a8 $89
    mB_8                                               ;; 0e:75a9 $8b
    mCisPlus_5                                         ;; 0e:75aa $5d
    mB_1                                               ;; 0e:75ab $1b
    mA_8                                               ;; 0e:75ac $89
    mGis_8                                             ;; 0e:75ad $88
    mA_8                                               ;; 0e:75ae $89
    mB_8                                               ;; 0e:75af $8b
    mA_8                                               ;; 0e:75b0 $89
    mGis_8                                             ;; 0e:75b1 $88
    mA_2                                               ;; 0e:75b2 $29
    mGis_8                                             ;; 0e:75b3 $88
    mA_8                                               ;; 0e:75b4 $89
    mGis_8                                             ;; 0e:75b5 $88
    mFis_8                                             ;; 0e:75b6 $86
    mGis_2                                             ;; 0e:75b7 $28
    mE_8                                               ;; 0e:75b8 $84
    mFis_8                                             ;; 0e:75b9 $86
    mGis_8                                             ;; 0e:75ba $88
    mA_8                                               ;; 0e:75bb $89
    mFis_2                                             ;; 0e:75bc $26
    mFis_5                                             ;; 0e:75bd $56
    mGis_8                                             ;; 0e:75be $88
    mFis_8                                             ;; 0e:75bf $86
    mF_2                                               ;; 0e:75c0 $25
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:75c1 $e0 $31 $7a
    mDUTYCYCLE $40                                     ;; 0e:75c4 $e5 $40
    mFis_8                                             ;; 0e:75c6 $86
    mE_8                                               ;; 0e:75c7 $84
    mFis_8                                             ;; 0e:75c8 $86
    mGis_8                                             ;; 0e:75c9 $88
    mA_8                                               ;; 0e:75ca $89
    mG_8                                               ;; 0e:75cb $87
    mA_8                                               ;; 0e:75cc $89
    mG_8                                               ;; 0e:75cd $87
    mA_0                                               ;; 0e:75ce $09
    mOCTAVE_MINUS_1                                    ;; 0e:75cf $dc
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:75d0 $e0 $5b $7a
    mDUTYCYCLE $00                                     ;; 0e:75d3 $e5 $00
    mB_5                                               ;; 0e:75d5 $5b
    mB_9                                               ;; 0e:75d6 $9b
    mA_9                                               ;; 0e:75d7 $99
    mB_9                                               ;; 0e:75d8 $9b
    mCisPlus_5                                         ;; 0e:75d9 $5d
    mCisPlus_9                                         ;; 0e:75da $9d
    mB_9                                               ;; 0e:75db $9b
    mCisPlus_9                                         ;; 0e:75dc $9d
    mOCTAVE_PLUS_1                                     ;; 0e:75dd $d8
    mD_5                                               ;; 0e:75de $52
    mD_9                                               ;; 0e:75df $92
    mCis_9                                             ;; 0e:75e0 $91
    mD_9                                               ;; 0e:75e1 $92
    mDis_9                                             ;; 0e:75e2 $93
    mE_9                                               ;; 0e:75e3 $94
    mFis_9                                             ;; 0e:75e4 $96
    mE_9                                               ;; 0e:75e5 $94
    mDis_9                                             ;; 0e:75e6 $93
    mCis_9                                             ;; 0e:75e7 $91
    mOCTAVE_MINUS_1                                    ;; 0e:75e8 $dc
    mB_5                                               ;; 0e:75e9 $5b
    mB_9                                               ;; 0e:75ea $9b
    mA_9                                               ;; 0e:75eb $99
    mB_9                                               ;; 0e:75ec $9b
    mCisPlus_5                                         ;; 0e:75ed $5d
    mCisPlus_9                                         ;; 0e:75ee $9d
    mB_9                                               ;; 0e:75ef $9b
    mCisPlus_9                                         ;; 0e:75f0 $9d
    mOCTAVE_PLUS_1                                     ;; 0e:75f1 $d8
    mD_5                                               ;; 0e:75f2 $52
    mD_9                                               ;; 0e:75f3 $92
    mCis_9                                             ;; 0e:75f4 $91
    mD_9                                               ;; 0e:75f5 $92
    mDUTYCYCLE $80                                     ;; 0e:75f6 $e5 $80
    mDis_10                                            ;; 0e:75f8 $a3
    mE_10                                              ;; 0e:75f9 $a4
    mFis_10                                            ;; 0e:75fa $a6
    mGis_10                                            ;; 0e:75fb $a8
    mSTEREOPAN $02                                     ;; 0e:75fc $e6 $02
    mA_11                                              ;; 0e:75fe $b9
    mB_11                                              ;; 0e:75ff $bb
    mSTEREOPAN $03                                     ;; 0e:7600 $e6 $03
    mCisPlus_11                                        ;; 0e:7602 $bd
    mOCTAVE_PLUS_1                                     ;; 0e:7603 $d8
    mDis_11                                            ;; 0e:7604 $b3
    mSTEREOPAN $01                                     ;; 0e:7605 $e6 $01
    mE_11                                              ;; 0e:7607 $b4
    mFis_11                                            ;; 0e:7608 $b6
    mVOLUME_ENVELOPE data_0e_7a4b                      ;; 0e:7609 $e0 $4b $7a
    mDUTYCYCLE $00                                     ;; 0e:760c $e5 $00
    mSTEREOPAN $03                                     ;; 0e:760e $e6 $03
    mOCTAVE_MINUS_1                                    ;; 0e:7610 $dc
    mDis_9                                             ;; 0e:7611 $93
    mDis_9                                             ;; 0e:7612 $93
    mDis_9                                             ;; 0e:7613 $93
    mDis_9                                             ;; 0e:7614 $93
    mOCTAVE_MINUS_1                                    ;; 0e:7615 $dc
    mB_9                                               ;; 0e:7616 $9b
    mOCTAVE_PLUS_1                                     ;; 0e:7617 $d8
    mDis_9                                             ;; 0e:7618 $93
    mE_9                                               ;; 0e:7619 $94
    mE_9                                               ;; 0e:761a $94
    mE_9                                               ;; 0e:761b $94
    mE_9                                               ;; 0e:761c $94
    mCis_9                                             ;; 0e:761d $91
    mE_9                                               ;; 0e:761e $94
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:761f $e0 $5b $7a
    mFis_0                                             ;; 0e:7622 $06
    mOCTAVE_MINUS_1                                    ;; 0e:7623 $dc
    mCOUNTER $02                                       ;; 0e:7624 $e3 $02
.data_0e_7626:
    mB_3                                               ;; 0e:7626 $3b
    mGis_9                                             ;; 0e:7627 $98
    mA_9                                               ;; 0e:7628 $99
    mB_8                                               ;; 0e:7629 $8b
    mOCTAVE_PLUS_1                                     ;; 0e:762a $d8
    mDis_8                                             ;; 0e:762b $83
    mE_8                                               ;; 0e:762c $84
    mFis_8                                             ;; 0e:762d $86
    mOCTAVE_MINUS_1                                    ;; 0e:762e $dc
    mB_5                                               ;; 0e:762f $5b
    mOCTAVE_PLUS_1                                     ;; 0e:7630 $d8
    mDis_2                                             ;; 0e:7631 $23
    mFis_5                                             ;; 0e:7632 $56
    mFis_3                                             ;; 0e:7633 $36
    mFis_9                                             ;; 0e:7634 $96
    mGis_9                                             ;; 0e:7635 $98
    mA_8                                               ;; 0e:7636 $89
    mFis_8                                             ;; 0e:7637 $86
    mE_8                                               ;; 0e:7638 $84
    mD_8                                               ;; 0e:7639 $82
    mJUMPIF $01, .data_0e_765c                         ;; 0e:763a $eb $01 $5c $76
    mD_9                                               ;; 0e:763e $92
    mE_9                                               ;; 0e:763f $94
    mD_9                                               ;; 0e:7640 $92
    mCis_2                                             ;; 0e:7641 $21
    mE_5                                               ;; 0e:7642 $54
    mG_3                                               ;; 0e:7643 $37
    mE_9                                               ;; 0e:7644 $94
    mFis_9                                             ;; 0e:7645 $96
    mG_8                                               ;; 0e:7646 $87
    mCPlus_8                                           ;; 0e:7647 $8c
    mB_8                                               ;; 0e:7648 $8b
    mA_8                                               ;; 0e:7649 $89
    mD_2                                               ;; 0e:764a $22
    mOCTAVE_MINUS_1                                    ;; 0e:764b $dc
    mB_2                                               ;; 0e:764c $2b
    mCPlus_2                                           ;; 0e:764d $2c
    mWait_8                                            ;; 0e:764e $8e
    mOCTAVE_PLUS_1                                     ;; 0e:764f $d8
    mE_8                                               ;; 0e:7650 $84
    mD_8                                               ;; 0e:7651 $82
    mC_8                                               ;; 0e:7652 $80
    mOCTAVE_MINUS_1                                    ;; 0e:7653 $dc
    mB_5                                               ;; 0e:7654 $5b
    mA_5                                               ;; 0e:7655 $59
    mB_5                                               ;; 0e:7656 $5b
    mA_8                                               ;; 0e:7657 $89
    mB_8                                               ;; 0e:7658 $8b
    mREPEAT .data_0e_7626                              ;; 0e:7659 $e2 $26 $76
.data_0e_765c:
    mD_9                                               ;; 0e:765c $92
    mE_9                                               ;; 0e:765d $94
    mD_9                                               ;; 0e:765e $92
    mCis_5                                             ;; 0e:765f $51
    mWait_10                                           ;; 0e:7660 $ae
    mDis_10                                            ;; 0e:7661 $a3
    mCis_10                                            ;; 0e:7662 $a1
    mDis_10                                            ;; 0e:7663 $a3
    mE_10                                              ;; 0e:7664 $a4
    mDis_10                                            ;; 0e:7665 $a3
    mCis_10                                            ;; 0e:7666 $a1
    mDis_10                                            ;; 0e:7667 $a3
    mFis_4                                             ;; 0e:7668 $46
    mA_10                                              ;; 0e:7669 $a9
    mGis_10                                            ;; 0e:766a $a8
    mFis_2                                             ;; 0e:766b $26
    mE_2                                               ;; 0e:766c $24
    mFis_2                                             ;; 0e:766d $26
    mOCTAVE_MINUS_1                                    ;; 0e:766e $dc
    mB_3                                               ;; 0e:766f $3b
    mCisPlus_9                                         ;; 0e:7670 $9d
    mB_9                                               ;; 0e:7671 $9b
    mA_4                                               ;; 0e:7672 $49
    mFis_8                                             ;; 0e:7673 $86
    mGis_5                                             ;; 0e:7674 $58
    mOCTAVE_PLUS_1                                     ;; 0e:7675 $d8
    mVOLUME_ENVELOPE volumeEnvelopeData                ;; 0e:7676 $e0 $31 $7a
    mSTEREOPAN $02                                     ;; 0e:7679 $e6 $02
    mE_5                                               ;; 0e:767b $54
    mDis_5                                             ;; 0e:767c $53
    mD_5                                               ;; 0e:767d $52
    mVOLUME_ENVELOPE data_0e_7a6f                      ;; 0e:767e $e0 $6f $7a
    mE_5                                               ;; 0e:7681 $54
    mSTEREOPAN $01                                     ;; 0e:7682 $e6 $01
    mA_5                                               ;; 0e:7684 $59
    mSTEREOPAN $03                                     ;; 0e:7685 $e6 $03
    mCisPlus_2                                         ;; 0e:7687 $2d
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:7688 $e0 $5b $7a
    mRest_8                                            ;; 0e:768b $8f
    mB_10                                              ;; 0e:768c $ab
    mA_10                                              ;; 0e:768d $a9
    mB_8                                               ;; 0e:768e $8b
    mOCTAVE_PLUS_1                                     ;; 0e:768f $d8
    mCis_8                                             ;; 0e:7690 $81
    mSTEREOPAN $02                                     ;; 0e:7691 $e6 $02
    mDis_10                                            ;; 0e:7693 $a3
    mE_10                                              ;; 0e:7694 $a4
    mDis_10                                            ;; 0e:7695 $a3
    mCis_10                                            ;; 0e:7696 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:7697 $dc
    mSTEREOPAN $01                                     ;; 0e:7698 $e6 $01
    mB_10                                              ;; 0e:769a $ab
    mCisPlus_10                                        ;; 0e:769b $ad
    mB_10                                              ;; 0e:769c $ab
    mA_10                                              ;; 0e:769d $a9
    mVOLUME_ENVELOPE data_0e_7a6f                      ;; 0e:769e $e0 $6f $7a
    mDis_5                                             ;; 0e:76a1 $53
    mSTEREOPAN $02                                     ;; 0e:76a2 $e6 $02
    mGis_5                                             ;; 0e:76a4 $58
    mSTEREOPAN $03                                     ;; 0e:76a5 $e6 $03
    mB_2                                               ;; 0e:76a7 $2b
    mVOLUME_ENVELOPE data_0e_7a5b                      ;; 0e:76a8 $e0 $5b $7a
    mRest_8                                            ;; 0e:76ab $8f
    mOCTAVE_PLUS_1                                     ;; 0e:76ac $d8
    mCis_10                                            ;; 0e:76ad $a1
    mOCTAVE_MINUS_1                                    ;; 0e:76ae $dc
    mB_10                                              ;; 0e:76af $ab
    mGis_8                                             ;; 0e:76b0 $88
    mB_8                                               ;; 0e:76b1 $8b
    mSTEREOPAN $01                                     ;; 0e:76b2 $e6 $01
    mCisPlus_10                                        ;; 0e:76b4 $ad
    mOCTAVE_PLUS_1                                     ;; 0e:76b5 $d8
    mDis_10                                            ;; 0e:76b6 $a3
    mCis_10                                            ;; 0e:76b7 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:76b8 $dc
    mB_10                                              ;; 0e:76b9 $ab
    mSTEREOPAN $02                                     ;; 0e:76ba $e6 $02
    mA_10                                              ;; 0e:76bc $a9
    mB_10                                              ;; 0e:76bd $ab
    mA_10                                              ;; 0e:76be $a9
    mGis_10                                            ;; 0e:76bf $a8
    mRest_8                                            ;; 0e:76c0 $8f
    mCis_8                                             ;; 0e:76c1 $81
    mDis_8                                             ;; 0e:76c2 $83
    mCis_8                                             ;; 0e:76c3 $81
    mSTEREOPAN $01                                     ;; 0e:76c4 $e6 $01
    mRest_8                                            ;; 0e:76c6 $8f
    mDis_8                                             ;; 0e:76c7 $83
    mE_8                                               ;; 0e:76c8 $84
    mDis_8                                             ;; 0e:76c9 $83
    mSTEREOPAN $03                                     ;; 0e:76ca $e6 $03
    mE_8                                               ;; 0e:76cc $84
    mDis_10                                            ;; 0e:76cd $a3
    mE_10                                              ;; 0e:76ce $a4
    mFis_8                                             ;; 0e:76cf $86
    mE_10                                              ;; 0e:76d0 $a4
    mFis_10                                            ;; 0e:76d1 $a6
    mGis_8                                             ;; 0e:76d2 $88
    mFis_10                                            ;; 0e:76d3 $a6
    mGis_10                                            ;; 0e:76d4 $a8
    mA_8                                               ;; 0e:76d5 $89
    mGis_10                                            ;; 0e:76d6 $a8
    mA_10                                              ;; 0e:76d7 $a9
    mB_4                                               ;; 0e:76d8 $4b
    mGis_10                                            ;; 0e:76d9 $a8
    mA_10                                              ;; 0e:76da $a9
    mB_8                                               ;; 0e:76db $8b
    mOCTAVE_PLUS_1                                     ;; 0e:76dc $d8
    mDis_8                                             ;; 0e:76dd $83
    mE_8                                               ;; 0e:76de $84
    mFis_8                                             ;; 0e:76df $86
    mDis_4                                             ;; 0e:76e0 $43
    mDis_10                                            ;; 0e:76e1 $a3
    mCis_10                                            ;; 0e:76e2 $a1
    mC_5                                               ;; 0e:76e3 $50
    mCis_8                                             ;; 0e:76e4 $81
    mC_8                                               ;; 0e:76e5 $80
    mOCTAVE_MINUS_1                                    ;; 0e:76e6 $dc
    mSTEREOPAN $02                                     ;; 0e:76e7 $e6 $02
    mRest_8                                            ;; 0e:76e9 $8f
    mE_8                                               ;; 0e:76ea $84
    mFis_8                                             ;; 0e:76eb $86
    mDis_10                                            ;; 0e:76ec $a3
    mE_10                                              ;; 0e:76ed $a4
    mSTEREOPAN $01                                     ;; 0e:76ee $e6 $01
    mRest_8                                            ;; 0e:76f0 $8f
    mFis_8                                             ;; 0e:76f1 $86
    mGis_8                                             ;; 0e:76f2 $88
    mE_10                                              ;; 0e:76f3 $a4
    mFis_10                                            ;; 0e:76f4 $a6
    mDUTYCYCLE $40                                     ;; 0e:76f5 $e5 $40
    mSTEREOPAN $03                                     ;; 0e:76f7 $e6 $03
    mGis_10                                            ;; 0e:76f9 $a8
    mFis_10                                            ;; 0e:76fa $a6
    mE_10                                              ;; 0e:76fb $a4
    mFis_10                                            ;; 0e:76fc $a6
    mDUTYCYCLE $00                                     ;; 0e:76fd $e5 $00
    mGis_10                                            ;; 0e:76ff $a8
    mFis_10                                            ;; 0e:7700 $a6
    mGis_10                                            ;; 0e:7701 $a8
    mA_10                                              ;; 0e:7702 $a9
    mDUTYCYCLE $40                                     ;; 0e:7703 $e5 $40
    mB_10                                              ;; 0e:7705 $ab
    mA_10                                              ;; 0e:7706 $a9
    mGis_10                                            ;; 0e:7707 $a8
    mA_10                                              ;; 0e:7708 $a9
    mDUTYCYCLE $80                                     ;; 0e:7709 $e5 $80
    mB_10                                              ;; 0e:770b $ab
    mA_10                                              ;; 0e:770c $a9
    mB_10                                              ;; 0e:770d $ab
    mCisPlus_10                                        ;; 0e:770e $ad
    mDUTYCYCLE $00                                     ;; 0e:770f $e5 $00
    mG_10                                              ;; 0e:7711 $a7
    mA_10                                              ;; 0e:7712 $a9
    mG_10                                              ;; 0e:7713 $a7
    mFis_10                                            ;; 0e:7714 $a6
    mSTEREOPAN $01                                     ;; 0e:7715 $e6 $01
    mG_10                                              ;; 0e:7717 $a7
    mA_10                                              ;; 0e:7718 $a9
    mG_10                                              ;; 0e:7719 $a7
    mFis_10                                            ;; 0e:771a $a6
    mSTEREOPAN $03                                     ;; 0e:771b $e6 $03
    mG_10                                              ;; 0e:771d $a7
    mA_10                                              ;; 0e:771e $a9
    mG_10                                              ;; 0e:771f $a7
    mFis_10                                            ;; 0e:7720 $a6
    mSTEREOPAN $02                                     ;; 0e:7721 $e6 $02
    mG_10                                              ;; 0e:7723 $a7
    mA_10                                              ;; 0e:7724 $a9
    mG_10                                              ;; 0e:7725 $a7
    mFis_10                                            ;; 0e:7726 $a6
    mSTEREOPAN $03                                     ;; 0e:7727 $e6 $03
    mE_10                                              ;; 0e:7729 $a4
    mFis_10                                            ;; 0e:772a $a6
    mG_10                                              ;; 0e:772b $a7
    mFis_10                                            ;; 0e:772c $a6
    mSTEREOPAN $01                                     ;; 0e:772d $e6 $01
    mG_10                                              ;; 0e:772f $a7
    mA_10                                              ;; 0e:7730 $a9
    mB_10                                              ;; 0e:7731 $ab
    mA_10                                              ;; 0e:7732 $a9
    mSTEREOPAN $03                                     ;; 0e:7733 $e6 $03
    mG_10                                              ;; 0e:7735 $a7
    mA_10                                              ;; 0e:7736 $a9
    mG_10                                              ;; 0e:7737 $a7
    mFis_10                                            ;; 0e:7738 $a6
    mSTEREOPAN $02                                     ;; 0e:7739 $e6 $02
    mE_10                                              ;; 0e:773b $a4
    mFis_10                                            ;; 0e:773c $a6
    mG_10                                              ;; 0e:773d $a7
    mFis_10                                            ;; 0e:773e $a6
    mDUTYCYCLE $80                                     ;; 0e:773f $e5 $80
    mSTEREOPAN $03                                     ;; 0e:7741 $e6 $03
    mD_10                                              ;; 0e:7743 $a2
    mCis_10                                            ;; 0e:7744 $a1
    mD_10                                              ;; 0e:7745 $a2
    mE_10                                              ;; 0e:7746 $a4
    mFis_10                                            ;; 0e:7747 $a6
    mE_10                                              ;; 0e:7748 $a4
    mFis_10                                            ;; 0e:7749 $a6
    mGis_10                                            ;; 0e:774a $a8
    mA_10                                              ;; 0e:774b $a9
    mGis_10                                            ;; 0e:774c $a8
    mA_10                                              ;; 0e:774d $a9
    mB_10                                              ;; 0e:774e $ab
    mCisPlus_10                                        ;; 0e:774f $ad
    mOCTAVE_PLUS_1                                     ;; 0e:7750 $d8
    mD_10                                              ;; 0e:7751 $a2
    mE_10                                              ;; 0e:7752 $a4
    mFis_10                                            ;; 0e:7753 $a6
    mE_10                                              ;; 0e:7754 $a4
    mD_10                                              ;; 0e:7755 $a2
    mE_10                                              ;; 0e:7756 $a4
    mFis_10                                            ;; 0e:7757 $a6
    mDUTYCYCLE $40                                     ;; 0e:7758 $e5 $40
    mGis_10                                            ;; 0e:775a $a8
    mFis_10                                            ;; 0e:775b $a6
    mE_10                                              ;; 0e:775c $a4
    mD_10                                              ;; 0e:775d $a2
    mDUTYCYCLE $00                                     ;; 0e:775e $e5 $00
    mCis_10                                            ;; 0e:7760 $a1
    mD_10                                              ;; 0e:7761 $a2
    mCis_10                                            ;; 0e:7762 $a1
    mOCTAVE_MINUS_1                                    ;; 0e:7763 $dc
    mB_10                                              ;; 0e:7764 $ab
    mDUTYCYCLE $40                                     ;; 0e:7765 $e5 $40
    mA_10                                              ;; 0e:7767 $a9
    mB_10                                              ;; 0e:7768 $ab
    mA_10                                              ;; 0e:7769 $a9
    mGis_10                                            ;; 0e:776a $a8
    mVOLUME_ENVELOPE data_0e_7a59                      ;; 0e:776b $e0 $59 $7a
    mDUTYCYCLE $00                                     ;; 0e:776e $e5 $00
    mSTEREOPAN $03                                     ;; 0e:7770 $e6 $03
    mRest_8                                            ;; 0e:7772 $8f
    mE_8                                               ;; 0e:7773 $84
    mFis_8                                             ;; 0e:7774 $86
    mE_8                                               ;; 0e:7775 $84
    mFis_5                                             ;; 0e:7776 $56
    mA_5                                               ;; 0e:7777 $59
    mRest_8                                            ;; 0e:7778 $8f
    mGis_8                                             ;; 0e:7779 $88
    mA_8                                               ;; 0e:777a $89
    mB_8                                               ;; 0e:777b $8b
    mAis_2                                             ;; 0e:777c $2a
    mRest_8                                            ;; 0e:777d $8f
    mFis_8                                             ;; 0e:777e $86
    mGis_8                                             ;; 0e:777f $88
    mFis_8                                             ;; 0e:7780 $86
    mD_2                                               ;; 0e:7781 $22
    mRest_8                                            ;; 0e:7782 $8f
    mE_8                                               ;; 0e:7783 $84
    mFis_8                                             ;; 0e:7784 $86
    mE_8                                               ;; 0e:7785 $84
    mGis_8                                             ;; 0e:7786 $88
    mFis_8                                             ;; 0e:7787 $86
    mE_8                                               ;; 0e:7788 $84
    mD_8                                               ;; 0e:7789 $82
    mD_5                                               ;; 0e:778a $52
    mA_5                                               ;; 0e:778b $59
    mGis_8                                             ;; 0e:778c $88
    mFis_8                                             ;; 0e:778d $86
    mE_8                                               ;; 0e:778e $84
    mFis_8                                             ;; 0e:778f $86
    mGis_5                                             ;; 0e:7790 $58
    mB_5                                               ;; 0e:7791 $5b
    mAis_2                                             ;; 0e:7792 $2a
    mRest_8                                            ;; 0e:7793 $8f
    mD_8                                               ;; 0e:7794 $82
    mE_8                                               ;; 0e:7795 $84
    mFis_8                                             ;; 0e:7796 $86
    mD_5                                               ;; 0e:7797 $52
    mE_5                                               ;; 0e:7798 $54
    mD_4                                               ;; 0e:7799 $42
    mCis_10                                            ;; 0e:779a $a1
    mOCTAVE_MINUS_1                                    ;; 0e:779b $dc
    mB_10                                              ;; 0e:779c $ab
    mCisPlus_5                                         ;; 0e:779d $5d
    mVOLUME_ENVELOPE data_0e_7a71                      ;; 0e:779e $e0 $71 $7a
    mSTEREOPAN $02                                     ;; 0e:77a1 $e6 $02
    mB_11                                              ;; 0e:77a3 $bb
    mOCTAVE_PLUS_1                                     ;; 0e:77a4 $d8
    mC_11                                              ;; 0e:77a5 $b0
    mSTEREOPAN $03                                     ;; 0e:77a6 $e6 $03
    mD_11                                              ;; 0e:77a8 $b2
    mE_11                                              ;; 0e:77a9 $b4
    mSTEREOPAN $01                                     ;; 0e:77aa $e6 $01
    mF_11                                              ;; 0e:77ac $b5
    mFis_11                                            ;; 0e:77ad $b6
    mSTEREOPAN $03                                     ;; 0e:77ae $e6 $03
    mG_1                                               ;; 0e:77b0 $17
    mG_8                                               ;; 0e:77b1 $87
    mA_8                                               ;; 0e:77b2 $89
    mAis_5                                             ;; 0e:77b3 $5a
    mOCTAVE_PLUS_1                                     ;; 0e:77b4 $d8
    mD_5                                               ;; 0e:77b5 $52
    mCis_8                                             ;; 0e:77b6 $81
    mE_8                                               ;; 0e:77b7 $84
    mOCTAVE_MINUS_1                                    ;; 0e:77b8 $dc
    mG_8                                               ;; 0e:77b9 $87
    mCisPlus_8                                         ;; 0e:77ba $8d
    mA_2                                               ;; 0e:77bb $29
    mWait_8                                            ;; 0e:77bc $8e
    mG_8                                               ;; 0e:77bd $87
    mA_8                                               ;; 0e:77be $89
    mB_8                                               ;; 0e:77bf $8b
    mA_8                                               ;; 0e:77c0 $89
    mCPlus_8                                           ;; 0e:77c1 $8c
    mB_8                                               ;; 0e:77c2 $8b
    mA_8                                               ;; 0e:77c3 $89
    mB_5                                               ;; 0e:77c4 $5b
    mCPlus_8                                           ;; 0e:77c5 $8c
    mOCTAVE_PLUS_1                                     ;; 0e:77c6 $d8
    mD_8                                               ;; 0e:77c7 $82
    mOCTAVE_MINUS_1                                    ;; 0e:77c8 $dc
    mGis_5                                             ;; 0e:77c9 $58
    mD_4                                               ;; 0e:77ca $42
    mGis_8                                             ;; 0e:77cb $88
    mFis_8                                             ;; 0e:77cc $86
    mE_8                                               ;; 0e:77cd $84
    mE_2                                               ;; 0e:77ce $24
    mA_5                                               ;; 0e:77cf $59
    mFis_5                                             ;; 0e:77d0 $56
    mE_8                                               ;; 0e:77d1 $84
    mD_8                                               ;; 0e:77d2 $82
    mE_8                                               ;; 0e:77d3 $84
    mF_8                                               ;; 0e:77d4 $85
    mG_2                                               ;; 0e:77d5 $27
    mB_8                                               ;; 0e:77d6 $8b
    mA_8                                               ;; 0e:77d7 $89
    mG_8                                               ;; 0e:77d8 $87
    mA_8                                               ;; 0e:77d9 $89
    mG_5                                               ;; 0e:77da $57
    mF_5                                               ;; 0e:77db $55
    mE_2                                               ;; 0e:77dc $24
    mWait_8                                            ;; 0e:77dd $8e
    mF_8                                               ;; 0e:77de $85
    mE_8                                               ;; 0e:77df $84
    mD_8                                               ;; 0e:77e0 $82
    mE_0                                               ;; 0e:77e1 $04
    mEND                                               ;; 0e:77e2 $ff

song0e_channel3:
    mVIBRATO frequencyDeltaData                        ;; 0e:77e3 $e4 $fe $79
    mWAVETABLE data_0e_7a85                            ;; 0e:77e6 $e8 $85 $7a
    mVOLUME $40                                        ;; 0e:77e9 $e0 $40
    mSTEREOPAN $03                                     ;; 0e:77eb $e6 $03
    mOCTAVE_2                                          ;; 0e:77ed $d2
    mE_0                                               ;; 0e:77ee $04
    mA_0                                               ;; 0e:77ef $09
    mE_0                                               ;; 0e:77f0 $04
    mA_2                                               ;; 0e:77f1 $29
    mB_2                                               ;; 0e:77f2 $2b
    mE_1                                               ;; 0e:77f3 $14
    mWait_8                                            ;; 0e:77f4 $8e
    mFis_8                                             ;; 0e:77f5 $86
    mGis_0                                             ;; 0e:77f6 $08
    mFis_0                                             ;; 0e:77f7 $06
    mCis_5                                             ;; 0e:77f8 $51
    mGis_5                                             ;; 0e:77f9 $58
    mCisPlus_2                                         ;; 0e:77fa $2d
    mOCTAVE_PLUS_1                                     ;; 0e:77fb $d8
    mD_0                                               ;; 0e:77fc $02
    mCis_1                                             ;; 0e:77fd $11
    mOCTAVE_MINUS_1                                    ;; 0e:77fe $dc
    mB_5                                               ;; 0e:77ff $5b
    mA_2                                               ;; 0e:7800 $29
    mGis_2                                             ;; 0e:7801 $28
    mCisPlus_2                                         ;; 0e:7802 $2d
    mWait_8                                            ;; 0e:7803 $8e
    mB_8                                               ;; 0e:7804 $8b
    mA_8                                               ;; 0e:7805 $89
    mGis_8                                             ;; 0e:7806 $88
    mFis_4                                             ;; 0e:7807 $46
    mGis_8                                             ;; 0e:7808 $88
    mA_4                                               ;; 0e:7809 $49
    mB_8                                               ;; 0e:780a $8b
    mCPlus_1                                           ;; 0e:780b $1c
    mB_12                                              ;; 0e:780c $cb
    mA_12                                              ;; 0e:780d $c9
    mGis_12                                            ;; 0e:780e $c8
    mFis_12                                            ;; 0e:780f $c6
    mE_12                                              ;; 0e:7810 $c4
    mDis_12                                            ;; 0e:7811 $c3
    mCis_12                                            ;; 0e:7812 $c1
    mC_12                                              ;; 0e:7813 $c0
    mOCTAVE_MINUS_1                                    ;; 0e:7814 $dc
    mSTEREOPAN $02                                     ;; 0e:7815 $e6 $02
    mB_8                                               ;; 0e:7817 $8b
    mRest_8                                            ;; 0e:7818 $8f
    mSTEREOPAN $03                                     ;; 0e:7819 $e6 $03
    mB_11                                              ;; 0e:781b $bb
    mRest_11                                           ;; 0e:781c $bf
    mB_11                                              ;; 0e:781d $bb
    mRest_11                                           ;; 0e:781e $bf
    mB_11                                              ;; 0e:781f $bb
    mRest_11                                           ;; 0e:7820 $bf
    mSTEREOPAN $01                                     ;; 0e:7821 $e6 $01
    mB_8                                               ;; 0e:7823 $8b
    mRest_8                                            ;; 0e:7824 $8f
    mSTEREOPAN $03                                     ;; 0e:7825 $e6 $03
    mB_11                                              ;; 0e:7827 $bb
    mRest_11                                           ;; 0e:7828 $bf
    mB_11                                              ;; 0e:7829 $bb
    mRest_11                                           ;; 0e:782a $bf
    mB_11                                              ;; 0e:782b $bb
    mRest_11                                           ;; 0e:782c $bf
    mSTEREOPAN $02                                     ;; 0e:782d $e6 $02
    mB_8                                               ;; 0e:782f $8b
    mRest_8                                            ;; 0e:7830 $8f
    mSTEREOPAN $03                                     ;; 0e:7831 $e6 $03
    mB_11                                              ;; 0e:7833 $bb
    mRest_11                                           ;; 0e:7834 $bf
    mB_11                                              ;; 0e:7835 $bb
    mRest_11                                           ;; 0e:7836 $bf
    mB_11                                              ;; 0e:7837 $bb
    mRest_11                                           ;; 0e:7838 $bf
    mSTEREOPAN $01                                     ;; 0e:7839 $e6 $01
    mB_9                                               ;; 0e:783b $9b
    mWait_9                                            ;; 0e:783c $9e
    mRest_9                                            ;; 0e:783d $9f
    mOCTAVE_PLUS_1                                     ;; 0e:783e $d8
    mSTEREOPAN $03                                     ;; 0e:783f $e6 $03
    mFis_9                                             ;; 0e:7841 $96
    mRest_9                                            ;; 0e:7842 $9f
    mFis_9                                             ;; 0e:7843 $96
    mOCTAVE_MINUS_1                                    ;; 0e:7844 $dc
    mSTEREOPAN $02                                     ;; 0e:7845 $e6 $02
    mB_8                                               ;; 0e:7847 $8b
    mRest_8                                            ;; 0e:7848 $8f
    mSTEREOPAN $03                                     ;; 0e:7849 $e6 $03
    mB_11                                              ;; 0e:784b $bb
    mRest_11                                           ;; 0e:784c $bf
    mB_11                                              ;; 0e:784d $bb
    mRest_11                                           ;; 0e:784e $bf
    mB_11                                              ;; 0e:784f $bb
    mRest_11                                           ;; 0e:7850 $bf
    mSTEREOPAN $01                                     ;; 0e:7851 $e6 $01
    mB_8                                               ;; 0e:7853 $8b
    mRest_8                                            ;; 0e:7854 $8f
    mSTEREOPAN $03                                     ;; 0e:7855 $e6 $03
    mB_11                                              ;; 0e:7857 $bb
    mRest_11                                           ;; 0e:7858 $bf
    mB_11                                              ;; 0e:7859 $bb
    mRest_11                                           ;; 0e:785a $bf
    mB_11                                              ;; 0e:785b $bb
    mRest_11                                           ;; 0e:785c $bf
    mSTEREOPAN $02                                     ;; 0e:785d $e6 $02
    mB_8                                               ;; 0e:785f $8b
    mRest_8                                            ;; 0e:7860 $8f
    mSTEREOPAN $03                                     ;; 0e:7861 $e6 $03
    mB_11                                              ;; 0e:7863 $bb
    mRest_11                                           ;; 0e:7864 $bf
    mB_11                                              ;; 0e:7865 $bb
    mRest_11                                           ;; 0e:7866 $bf
    mB_11                                              ;; 0e:7867 $bb
    mRest_11                                           ;; 0e:7868 $bf
    mB_8                                               ;; 0e:7869 $8b
    mRest_4                                            ;; 0e:786a $4f
    mOCTAVE_PLUS_1                                     ;; 0e:786b $d8
    mB_2                                               ;; 0e:786c $2b
    mA_2                                               ;; 0e:786d $29
    mB_8                                               ;; 0e:786e $8b
    mRest_8                                            ;; 0e:786f $8f
    mA_8                                               ;; 0e:7870 $89
    mRest_8                                            ;; 0e:7871 $8f
    mGis_8                                             ;; 0e:7872 $88
    mRest_8                                            ;; 0e:7873 $8f
    mFis_8                                             ;; 0e:7874 $86
    mRest_8                                            ;; 0e:7875 $8f
    mCOUNTER $02                                       ;; 0e:7876 $e3 $02
.data_0e_7878:
    mSTEREOPAN $02                                     ;; 0e:7878 $e6 $02
    mE_8                                               ;; 0e:787a $84
    mRest_8                                            ;; 0e:787b $8f
    mSTEREOPAN $01                                     ;; 0e:787c $e6 $01
    mE_8                                               ;; 0e:787e $84
    mRest_8                                            ;; 0e:787f $8f
    mSTEREOPAN $02                                     ;; 0e:7880 $e6 $02
    mE_8                                               ;; 0e:7882 $84
    mRest_8                                            ;; 0e:7883 $8f
    mSTEREOPAN $01                                     ;; 0e:7884 $e6 $01
    mE_8                                               ;; 0e:7886 $84
    mRest_8                                            ;; 0e:7887 $8f
    mSTEREOPAN $02                                     ;; 0e:7888 $e6 $02
    mDis_8                                             ;; 0e:788a $83
    mRest_8                                            ;; 0e:788b $8f
    mSTEREOPAN $01                                     ;; 0e:788c $e6 $01
    mDis_8                                             ;; 0e:788e $83
    mRest_8                                            ;; 0e:788f $8f
    mSTEREOPAN $02                                     ;; 0e:7890 $e6 $02
    mDis_8                                             ;; 0e:7892 $83
    mRest_8                                            ;; 0e:7893 $8f
    mSTEREOPAN $01                                     ;; 0e:7894 $e6 $01
    mDis_8                                             ;; 0e:7896 $83
    mRest_8                                            ;; 0e:7897 $8f
    mSTEREOPAN $02                                     ;; 0e:7898 $e6 $02
    mD_8                                               ;; 0e:789a $82
    mRest_8                                            ;; 0e:789b $8f
    mSTEREOPAN $01                                     ;; 0e:789c $e6 $01
    mD_8                                               ;; 0e:789e $82
    mRest_8                                            ;; 0e:789f $8f
    mSTEREOPAN $02                                     ;; 0e:78a0 $e6 $02
    mD_8                                               ;; 0e:78a2 $82
    mRest_8                                            ;; 0e:78a3 $8f
    mSTEREOPAN $01                                     ;; 0e:78a4 $e6 $01
    mD_8                                               ;; 0e:78a6 $82
    mRest_8                                            ;; 0e:78a7 $8f
    mOCTAVE_MINUS_1                                    ;; 0e:78a8 $dc
    mJUMPIF $01, .data_0e_78f8                         ;; 0e:78a9 $eb $01 $f8 $78
    mSTEREOPAN $02                                     ;; 0e:78ad $e6 $02
    mA_8                                               ;; 0e:78af $89
    mRest_8                                            ;; 0e:78b0 $8f
    mSTEREOPAN $01                                     ;; 0e:78b1 $e6 $01
    mA_8                                               ;; 0e:78b3 $89
    mRest_8                                            ;; 0e:78b4 $8f
    mSTEREOPAN $02                                     ;; 0e:78b5 $e6 $02
    mA_8                                               ;; 0e:78b7 $89
    mRest_8                                            ;; 0e:78b8 $8f
    mSTEREOPAN $01                                     ;; 0e:78b9 $e6 $01
    mA_8                                               ;; 0e:78bb $89
    mRest_8                                            ;; 0e:78bc $8f
    mSTEREOPAN $02                                     ;; 0e:78bd $e6 $02
    mCPlus_8                                           ;; 0e:78bf $8c
    mRest_8                                            ;; 0e:78c0 $8f
    mSTEREOPAN $01                                     ;; 0e:78c1 $e6 $01
    mCPlus_8                                           ;; 0e:78c3 $8c
    mRest_8                                            ;; 0e:78c4 $8f
    mSTEREOPAN $02                                     ;; 0e:78c5 $e6 $02
    mCPlus_8                                           ;; 0e:78c7 $8c
    mRest_8                                            ;; 0e:78c8 $8f
    mSTEREOPAN $01                                     ;; 0e:78c9 $e6 $01
    mCPlus_8                                           ;; 0e:78cb $8c
    mRest_8                                            ;; 0e:78cc $8f
    mSTEREOPAN $02                                     ;; 0e:78cd $e6 $02
    mG_8                                               ;; 0e:78cf $87
    mRest_8                                            ;; 0e:78d0 $8f
    mSTEREOPAN $01                                     ;; 0e:78d1 $e6 $01
    mG_8                                               ;; 0e:78d3 $87
    mRest_8                                            ;; 0e:78d4 $8f
    mSTEREOPAN $02                                     ;; 0e:78d5 $e6 $02
    mG_8                                               ;; 0e:78d7 $87
    mRest_8                                            ;; 0e:78d8 $8f
    mSTEREOPAN $01                                     ;; 0e:78d9 $e6 $01
    mG_8                                               ;; 0e:78db $87
    mRest_8                                            ;; 0e:78dc $8f
    mSTEREOPAN $02                                     ;; 0e:78dd $e6 $02
    mCPlus_8                                           ;; 0e:78df $8c
    mRest_8                                            ;; 0e:78e0 $8f
    mSTEREOPAN $01                                     ;; 0e:78e1 $e6 $01
    mCPlus_8                                           ;; 0e:78e3 $8c
    mRest_8                                            ;; 0e:78e4 $8f
    mSTEREOPAN $02                                     ;; 0e:78e5 $e6 $02
    mCPlus_8                                           ;; 0e:78e7 $8c
    mRest_8                                            ;; 0e:78e8 $8f
    mSTEREOPAN $01                                     ;; 0e:78e9 $e6 $01
    mCPlus_8                                           ;; 0e:78eb $8c
    mRest_8                                            ;; 0e:78ec $8f
    mSTEREOPAN $03                                     ;; 0e:78ed $e6 $03
    mB_2                                               ;; 0e:78ef $2b
    mWait_8                                            ;; 0e:78f0 $8e
    mRest_8                                            ;; 0e:78f1 $8f
    mCisPlus_8                                         ;; 0e:78f2 $8d
    mOCTAVE_PLUS_1                                     ;; 0e:78f3 $d8
    mDis_8                                             ;; 0e:78f4 $83
    mREPEAT .data_0e_7878                              ;; 0e:78f5 $e2 $78 $78
.data_0e_78f8:
    mSTEREOPAN $02                                     ;; 0e:78f8 $e6 $02
    mA_8                                               ;; 0e:78fa $89
    mRest_8                                            ;; 0e:78fb $8f
    mSTEREOPAN $01                                     ;; 0e:78fc $e6 $01
    mA_8                                               ;; 0e:78fe $89
    mRest_8                                            ;; 0e:78ff $8f
    mSTEREOPAN $02                                     ;; 0e:7900 $e6 $02
    mA_8                                               ;; 0e:7902 $89
    mRest_8                                            ;; 0e:7903 $8f
    mSTEREOPAN $01                                     ;; 0e:7904 $e6 $01
    mA_8                                               ;; 0e:7906 $89
    mRest_8                                            ;; 0e:7907 $8f
    mOCTAVE_PLUS_1                                     ;; 0e:7908 $d8
    mSTEREOPAN $03                                     ;; 0e:7909 $e6 $03
    mB_2                                               ;; 0e:790b $2b
    mA_2                                               ;; 0e:790c $29
    mGis_2                                             ;; 0e:790d $28
    mA_2                                               ;; 0e:790e $29
    mSTEREOPAN $02                                     ;; 0e:790f $e6 $02
    mE_8                                               ;; 0e:7911 $84
    mRest_8                                            ;; 0e:7912 $8f
    mSTEREOPAN $01                                     ;; 0e:7913 $e6 $01
    mE_8                                               ;; 0e:7915 $84
    mRest_8                                            ;; 0e:7916 $8f
    mOCTAVE_MINUS_1                                    ;; 0e:7917 $dc
    mSTEREOPAN $02                                     ;; 0e:7918 $e6 $02
    mB_8                                               ;; 0e:791a $8b
    mRest_8                                            ;; 0e:791b $8f
    mSTEREOPAN $01                                     ;; 0e:791c $e6 $01
    mB_8                                               ;; 0e:791e $8b
    mRest_8                                            ;; 0e:791f $8f
    mSTEREOPAN $03                                     ;; 0e:7920 $e6 $03
    mOCTAVE_PLUS_1                                     ;; 0e:7922 $d8
    mE_8                                               ;; 0e:7923 $84
    mRest_8                                            ;; 0e:7924 $8f
    mSTEREOPAN $01                                     ;; 0e:7925 $e6 $01
    mE_5                                               ;; 0e:7927 $54
    mFis_5                                             ;; 0e:7928 $56
    mGis_5                                             ;; 0e:7929 $58
    mSTEREOPAN $03                                     ;; 0e:792a $e6 $03
    mA_0                                               ;; 0e:792c $09
    mB_8                                               ;; 0e:792d $8b
    mRest_8                                            ;; 0e:792e $8f
    mRest_1                                            ;; 0e:792f $1f
    mGis_0                                             ;; 0e:7930 $08
    mCisPlus_8                                         ;; 0e:7931 $8d
    mRest_4                                            ;; 0e:7932 $4f
    mB_2                                               ;; 0e:7933 $2b
    mOCTAVE_MINUS_1                                    ;; 0e:7934 $dc
    mFis_10                                            ;; 0e:7935 $a6
    mRest_10                                           ;; 0e:7936 $af
    mFis_10                                            ;; 0e:7937 $a6
    mRest_7                                            ;; 0e:7938 $7f
    mFis_8                                             ;; 0e:7939 $86
    mGis_10                                            ;; 0e:793a $a8
    mRest_10                                           ;; 0e:793b $af
    mGis_10                                            ;; 0e:793c $a8
    mRest_7                                            ;; 0e:793d $7f
    mGis_8                                             ;; 0e:793e $88
    mSTEREOPAN $02                                     ;; 0e:793f $e6 $02
    mA_5                                               ;; 0e:7941 $59
    mSTEREOPAN $01                                     ;; 0e:7942 $e6 $01
    mB_5                                               ;; 0e:7944 $5b
    mSTEREOPAN $02                                     ;; 0e:7945 $e6 $02
    mCisPlus_5                                         ;; 0e:7947 $5d
    mOCTAVE_PLUS_1                                     ;; 0e:7948 $d8
    mSTEREOPAN $01                                     ;; 0e:7949 $e6 $01
    mDis_5                                             ;; 0e:794b $53
    mSTEREOPAN $02                                     ;; 0e:794c $e6 $02
    mE_5                                               ;; 0e:794e $54
    mSTEREOPAN $01                                     ;; 0e:794f $e6 $01
    mB_5                                               ;; 0e:7951 $5b
    mOCTAVE_PLUS_1                                     ;; 0e:7952 $d8
    mSTEREOPAN $03                                     ;; 0e:7953 $e6 $03
    mE_2                                               ;; 0e:7955 $24
    mOCTAVE_MINUS_1                                    ;; 0e:7956 $dc
    mSTEREOPAN $02                                     ;; 0e:7957 $e6 $02
    mB_5                                               ;; 0e:7959 $5b
    mSTEREOPAN $01                                     ;; 0e:795a $e6 $01
    mA_5                                               ;; 0e:795c $59
    mSTEREOPAN $03                                     ;; 0e:795d $e6 $03
    mGis_2                                             ;; 0e:795f $28
    mOCTAVE_MINUS_1                                    ;; 0e:7960 $dc
    mA_10                                              ;; 0e:7961 $a9
    mRest_10                                           ;; 0e:7962 $af
    mA_10                                              ;; 0e:7963 $a9
    mRest_7                                            ;; 0e:7964 $7f
    mA_10                                              ;; 0e:7965 $a9
    mRest_10                                           ;; 0e:7966 $af
    mB_10                                              ;; 0e:7967 $ab
    mRest_10                                           ;; 0e:7968 $af
    mB_10                                              ;; 0e:7969 $ab
    mRest_7                                            ;; 0e:796a $7f
    mB_10                                              ;; 0e:796b $ab
    mRest_10                                           ;; 0e:796c $af
    mOCTAVE_PLUS_1                                     ;; 0e:796d $d8
    mCis_1                                             ;; 0e:796e $11
    mRest_5                                            ;; 0e:796f $5f
    mC_10                                              ;; 0e:7970 $a0
    mRest_10                                           ;; 0e:7971 $af
    mC_10                                              ;; 0e:7972 $a0
    mRest_7                                            ;; 0e:7973 $7f
    mC_10                                              ;; 0e:7974 $a0
    mRest_10                                           ;; 0e:7975 $af
    mC_10                                              ;; 0e:7976 $a0
    mRest_10                                           ;; 0e:7977 $af
    mC_10                                              ;; 0e:7978 $a0
    mRest_7                                            ;; 0e:7979 $7f
    mC_10                                              ;; 0e:797a $a0
    mRest_10                                           ;; 0e:797b $af
    mC_10                                              ;; 0e:797c $a0
    mRest_10                                           ;; 0e:797d $af
    mC_10                                              ;; 0e:797e $a0
    mRest_7                                            ;; 0e:797f $7f
    mC_10                                              ;; 0e:7980 $a0
    mRest_10                                           ;; 0e:7981 $af
    mC_10                                              ;; 0e:7982 $a0
    mRest_10                                           ;; 0e:7983 $af
    mC_10                                              ;; 0e:7984 $a0
    mRest_7                                            ;; 0e:7985 $7f
    mC_10                                              ;; 0e:7986 $a0
    mRest_10                                           ;; 0e:7987 $af
    mD_0                                               ;; 0e:7988 $02
    mSTEREOPAN $02                                     ;; 0e:7989 $e6 $02
    mE_5                                               ;; 0e:798b $54
    mOCTAVE_PLUS_1                                     ;; 0e:798c $d8
    mSTEREOPAN $01                                     ;; 0e:798d $e6 $01
    mD_5                                               ;; 0e:798f $52
    mSTEREOPAN $02                                     ;; 0e:7990 $e6 $02
    mCis_5                                             ;; 0e:7992 $51
    mOCTAVE_MINUS_1                                    ;; 0e:7993 $dc
    mSTEREOPAN $01                                     ;; 0e:7994 $e6 $01
    mB_5                                               ;; 0e:7996 $5b
    mSTEREOPAN $03                                     ;; 0e:7997 $e6 $03
    mA_2                                               ;; 0e:7999 $29
    mB_2                                               ;; 0e:799a $2b
    mCisPlus_2                                         ;; 0e:799b $2d
    mFis_2                                             ;; 0e:799c $26
    mB_2                                               ;; 0e:799d $2b
    mE_5                                               ;; 0e:799e $54
    mGis_5                                             ;; 0e:799f $58
    mA_2                                               ;; 0e:79a0 $29
    mE_2                                               ;; 0e:79a1 $24
    mD_2                                               ;; 0e:79a2 $22
    mE_2                                               ;; 0e:79a3 $24
    mCisPlus_4                                         ;; 0e:79a4 $4d
    mGis_8                                             ;; 0e:79a5 $88
    mFis_2                                             ;; 0e:79a6 $26
    mOCTAVE_MINUS_1                                    ;; 0e:79a7 $dc
    mB_2                                               ;; 0e:79a8 $2b
    mOCTAVE_PLUS_1                                     ;; 0e:79a9 $d8
    mE_2                                               ;; 0e:79aa $24
    mA_5                                               ;; 0e:79ab $59
    mE_5                                               ;; 0e:79ac $54
    mOCTAVE_MINUS_1                                    ;; 0e:79ad $dc
    mA_5                                               ;; 0e:79ae $59
    mG_5                                               ;; 0e:79af $57
    mCPlus_7                                           ;; 0e:79b0 $7c
    mRest_10                                           ;; 0e:79b1 $af
    mCPlus_7                                           ;; 0e:79b2 $7c
    mRest_10                                           ;; 0e:79b3 $af
    mB_7                                               ;; 0e:79b4 $7b
    mRest_10                                           ;; 0e:79b5 $af
    mB_7                                               ;; 0e:79b6 $7b
    mRest_10                                           ;; 0e:79b7 $af
    mAis_7                                             ;; 0e:79b8 $7a
    mRest_10                                           ;; 0e:79b9 $af
    mAis_7                                             ;; 0e:79ba $7a
    mRest_10                                           ;; 0e:79bb $af
    mA_7                                               ;; 0e:79bc $79
    mRest_10                                           ;; 0e:79bd $af
    mA_7                                               ;; 0e:79be $79
    mRest_10                                           ;; 0e:79bf $af
    mOCTAVE_PLUS_1                                     ;; 0e:79c0 $d8
    mD_7                                               ;; 0e:79c1 $72
    mRest_10                                           ;; 0e:79c2 $af
    mD_7                                               ;; 0e:79c3 $72
    mRest_10                                           ;; 0e:79c4 $af
    mCis_7                                             ;; 0e:79c5 $71
    mRest_10                                           ;; 0e:79c6 $af
    mCis_7                                             ;; 0e:79c7 $71
    mRest_10                                           ;; 0e:79c8 $af
    mC_7                                               ;; 0e:79c9 $70
    mRest_10                                           ;; 0e:79ca $af
    mC_7                                               ;; 0e:79cb $70
    mRest_10                                           ;; 0e:79cc $af
    mG_5                                               ;; 0e:79cd $57
    mA_8                                               ;; 0e:79ce $89
    mB_8                                               ;; 0e:79cf $8b
    mE_5                                               ;; 0e:79d0 $54
    mGis_4                                             ;; 0e:79d1 $48
    mB_8                                               ;; 0e:79d2 $8b
    mA_8                                               ;; 0e:79d3 $89
    mGis_8                                             ;; 0e:79d4 $88
    mA_5                                               ;; 0e:79d5 $59
    mG_5                                               ;; 0e:79d6 $57
    mFis_2                                             ;; 0e:79d7 $26
    mG_7                                               ;; 0e:79d8 $77
    mRest_10                                           ;; 0e:79d9 $af
    mG_7                                               ;; 0e:79da $77
    mRest_10                                           ;; 0e:79db $af
    mG_7                                               ;; 0e:79dc $77
    mRest_10                                           ;; 0e:79dd $af
    mG_7                                               ;; 0e:79de $77
    mRest_10                                           ;; 0e:79df $af
    mOCTAVE_MINUS_1                                    ;; 0e:79e0 $dc
    mG_7                                               ;; 0e:79e1 $77
    mRest_10                                           ;; 0e:79e2 $af
    mG_7                                               ;; 0e:79e3 $77
    mRest_10                                           ;; 0e:79e4 $af
    mG_7                                               ;; 0e:79e5 $77
    mRest_10                                           ;; 0e:79e6 $af
    mG_7                                               ;; 0e:79e7 $77
    mRest_10                                           ;; 0e:79e8 $af
    mOCTAVE_PLUS_1                                     ;; 0e:79e9 $d8
    mC_7                                               ;; 0e:79ea $70
    mRest_10                                           ;; 0e:79eb $af
    mC_7                                               ;; 0e:79ec $70
    mRest_10                                           ;; 0e:79ed $af
    mC_8                                               ;; 0e:79ee $80
    mSTEREOPAN $02                                     ;; 0e:79ef $e6 $02
    mA_8                                               ;; 0e:79f1 $89
    mSTEREOPAN $03                                     ;; 0e:79f2 $e6 $03
    mG_8                                               ;; 0e:79f4 $87
    mSTEREOPAN $01                                     ;; 0e:79f5 $e6 $01
    mF_8                                               ;; 0e:79f7 $85
    mSTEREOPAN $03                                     ;; 0e:79f8 $e6 $03
    mC_2                                               ;; 0e:79fa $20
    mWait_5                                            ;; 0e:79fb $5e
    mRest_5                                            ;; 0e:79fc $5f
    mEND                                               ;; 0e:79fd $ff

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

data_0e_7a3b:
    db   $63, $c2                                      ;; 0e:7a3b ?? $05
    db   $63, $10                                      ;; 0e:7a3d ?? $06

data_0e_7a3f:
    db   $63, $b2                                      ;; 0e:7a3f .. $07
    db   $63, $10                                      ;; 0e:7a41 ?? $08

data_0e_7a43:
    db   $63, $a2                                      ;; 0e:7a43 .. $09
    db   $63, $10                                      ;; 0e:7a45 ?? $0a

data_0e_7a47:
    db   $05, $92                                      ;; 0e:7a47 ?? $0b
    db   $63, $10                                      ;; 0e:7a49 ?? $0c

data_0e_7a4b:
    db   $05, $82                                      ;; 0e:7a4b ?? $0d
    db   $63, $10                                      ;; 0e:7a4d ?? $0e
    db   $63, $62                                      ;; 0e:7a4f ?? $0f
    db   $63, $10                                      ;; 0e:7a51 ?? $10

data_0e_7a53:
    db   $63, $c4                                      ;; 0e:7a53 .. $11

data_0e_7a55:
    db   $63, $b4                                      ;; 0e:7a55 .. $12

data_0e_7a57:
    db   $63, $a4                                      ;; 0e:7a57 .. $13

data_0e_7a59:
    db   $63, $94                                      ;; 0e:7a59 ?? $14

data_0e_7a5b:
    db   $63, $84                                      ;; 0e:7a5b .. $15

data_0e_7a5d:
    db   $63, $74                                      ;; 0e:7a5d ?? $16

data_0e_7a5f:
    db   $63, $64                                      ;; 0e:7a5f .. $17

data_0e_7a61:
    db   $63, $54                                      ;; 0e:7a61 .. $18

data_0e_7a63:
    db   $63, $44                                      ;; 0e:7a63 .. $19

data_0e_7a65:
    db   $63, $34                                      ;; 0e:7a65 .. $1a

data_0e_7a67:
    db   $63, $24                                      ;; 0e:7a67 .. $1b

data_0e_7a69:
    db   $63, $c7                                      ;; 0e:7a69 .. $1c

data_0e_7a6b:
    db   $63, $b7                                      ;; 0e:7a6b .. $1d

data_0e_7a6d:
    db   $63, $a7                                      ;; 0e:7a6d .. $1e

data_0e_7a6f:
    db   $63, $97                                      ;; 0e:7a6f ?? $1f

data_0e_7a71:
    db   $63, $87                                      ;; 0e:7a71 ?? $20

data_0e_7a73:
    db   $63, $67                                      ;; 0e:7a73 ?? $21

; Wave table patterns.
; 7a75: 50% duty cycle
; 7a85: 25% duty cycle
; 7a95: 50% duty cycle lower volume
; 7aa5: 25% duty cycle lower volume
; 7ab5: Weird tone
;@data format=bbbbbbbbbbbbbbbb amount=5
data_0e_7a75:
    db   $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00 ;; 0e:7a75 ................ $00

data_0e_7a85:
    db   $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;; 0e:7a85 ???????????????? $01

data_0e_7a95:
    db   $bb, $bb, $bb, $bb, $bb, $bb, $bb, $bb, $00, $00, $00, $00, $00, $00, $00, $00 ;; 0e:7a95 ???????????????? $02

data_0e_7aa5:
    db   $bb, $bb, $bb, $bb, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ;; 0e:7aa5 ................ $03

data_0e_7ab5:
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
