;; Disassembled with BadBoy Disassembler: https://github.com/daid/BadBoy

INCLUDE "include/hardware.inc"
INCLUDE "include/macros.inc"
INCLUDE "include/charmaps.inc"
INCLUDE "include/constants.inc"

SECTION "wram0", WRAM0[$c000]

wC000:
    ds 2                                               ;; c000

wC002:
    ds 14                                              ;; c002

wC010:
    ds 144                                             ;; c010

wC0A0:
    ds 64                                              ;; c0a0

wC0E0:
    ds 1                                               ;; c0e0

wC0E1:
    ds 4                                               ;; c0e1

wC0E5:
    ds 2                                               ;; c0e5

wC0E7:
    ds 1                                               ;; c0e7

wC0E8:
    ds 2                                               ;; c0e8

wC0EA:
    ds 22                                              ;; c0ea

wC100:
    ds 16                                              ;; c100

wC110:
    ds 144                                             ;; c110

wC1A0:
    ds 1                                               ;; c1a0

wC1A1:
    ds 1                                               ;; c1a1

wC1A2:
    ds 1                                               ;; c1a2

wC1A3:
    ds 1                                               ;; c1a3

wC1A4:
    ds 1                                               ;; c1a4

wC1A5:
    ds 1                                               ;; c1a5

wC1A6:
    ds 1                                               ;; c1a6

wC1A7:
    ds 1                                               ;; c1a7

wC1A8:
    ds 1                                               ;; c1a8

wC1A9:
    ds 1                                               ;; c1a9

wC1AA:
    ds 1                                               ;; c1aa

wC1AB:
    ds 1                                               ;; c1ab

wC1AC:
    ds 3                                               ;; c1ac

wC1AF:
    ds 1                                               ;; c1af

wC1B0:
    ds 80                                              ;; c1b0

wC200:
    ds 4                                               ;; c200

wC204:
    ds 1                                               ;; c204

wC205:
    ds 1                                               ;; c205

wC206:
    ds 1                                               ;; c206

wC207:
    ds 2                                               ;; c207

wC209:
    ds 1                                               ;; c209

wC20A:
    ds 1                                               ;; c20a

wC20B:
    ds 1                                               ;; c20b

wC20C:
    ds 1                                               ;; c20c

wC20D:
    ds 1                                               ;; c20d

wC20E:
    ds 1                                               ;; c20e

wC20F:
    ds 1                                               ;; c20f

wC210:
    ds 15                                              ;; c210

wC21F:
    ds 97                                              ;; c21f

wC280:
    ds 32                                              ;; c280

wC2A0:
    ds 1                                               ;; c2a0

wC2A1:
    ds 1                                               ;; c2a1

wC2A2:
    ds 3                                               ;; c2a2

wC2A5:
    ds 1                                               ;; c2a5

wC2A6:
    ds 1                                               ;; c2a6

wC2A7:
    ds 1                                               ;; c2a7

wC2A8:
    ds 1                                               ;; c2a8

wC2A9:
    ds 16                                              ;; c2a9

wC2B9:
    ds 1                                               ;; c2b9

wC2BA:
    ds 31                                              ;; c2ba

wC2D9:
    ds 1                                               ;; c2d9

wC2DA:
    ds 28                                              ;; c2da

wC2F6:
    ds 15                                              ;; c2f6

wC305:
    ds 1                                               ;; c305

wC306:
    ds 16                                              ;; c306

wC316:
    ds 1                                               ;; c316

wC317:
    ds 1                                               ;; c317

wC318:
    ds 1                                               ;; c318

wC319:
    ds 1                                               ;; c319

wC31A:
    ds 1                                               ;; c31a

wC31B:
    ds 1                                               ;; c31b

wC31C:
    ds 1                                               ;; c31c

wC31D:
    ds 32                                              ;; c31d

wC33D:
    ds 1                                               ;; c33d

wC33E:
    ds 1                                               ;; c33e

wC33F:
    ds 1                                               ;; c33f

wC340:
    ds 10                                              ;; c340

wC34A:
    ds 10                                              ;; c34a

wC354:
    ds 40                                              ;; c354

wC37C:
    ds 2                                               ;; c37c

wC37E:
    ds 2                                               ;; c37e

wC380:
    ds 128                                             ;; c380

wC400:
    ds 44                                              ;; c400

wC42C:
    ds 1                                               ;; c42c

wC42D:
    ds 1                                               ;; c42d

wC42E:
    ds 1                                               ;; c42e

wC42F:
    ds 1                                               ;; c42f

wC430:
    ds 1                                               ;; c430

wC431:
    ds 1                                               ;; c431

wC432:
    ds 1                                               ;; c432

wC433:
    ds 1                                               ;; c433

wC434:
    ds 1                                               ;; c434

wC435:
    ds 1                                               ;; c435

wC436:
    ds 1                                               ;; c436

wC437:
    ds 1                                               ;; c437

wC438:
    ds 1                                               ;; c438

wC439:
    ds 1                                               ;; c439

wC43A:
    ds 1                                               ;; c43a

wC43B:
    ds 1                                               ;; c43b

wC43C:
    ds 1                                               ;; c43c

wC43D:
    ds 1                                               ;; c43d

wC43E:
    ds 1                                               ;; c43e

wC43F:
    ds 1                                               ;; c43f

wC440:
    ds 1                                               ;; c440

wC441:
    ds 1                                               ;; c441

wC442:
    ds 1                                               ;; c442

wC443:
    ds 1                                               ;; c443

wC444:
    ds 1                                               ;; c444

wC445:
    ds 1                                               ;; c445

wC446:
    ds 3                                               ;; c446

wC449:
    ds 1                                               ;; c449

wC44A:
    ds 1                                               ;; c44a

wC44B:
    ds 1                                               ;; c44b

wC44C:
    ds 1                                               ;; c44c

wC44D:
    ds 1                                               ;; c44d

wC44E:
    ds 1                                               ;; c44e

wC44F:
    ds 1                                               ;; c44f

wC450:
    ds 1                                               ;; c450

wC451:
    ds 1                                               ;; c451

wC452:
    ds 1                                               ;; c452

wC453:
    ds 1                                               ;; c453

wC454:
    ds 1                                               ;; c454

wC455:
    ds 1                                               ;; c455

wC456:
    ds 1                                               ;; c456

wC457:
    ds 1                                               ;; c457

wC458:
    ds 1                                               ;; c458

wC459:
    ds 1                                               ;; c459

wC45A:
    ds 1                                               ;; c45a

wC45B:
    ds 1                                               ;; c45b

wC45C:
    ds 1                                               ;; c45c

wC45D:
    ds 1                                               ;; c45d

wC45E:
    ds 1                                               ;; c45e

wC45F:
    ds 1                                               ;; c45f

wC460:
    ds 1                                               ;; c460

wC461:
    ds 1                                               ;; c461

wC462:
    ds 1                                               ;; c462

wC463:
    ds 1                                               ;; c463

wC464:
    ds 1                                               ;; c464

wC465:
    ds 1                                               ;; c465

wC466:
    ds 1                                               ;; c466

wC467:
    ds 1                                               ;; c467

wC468:
    ds 11                                              ;; c468

wC473:
    ds 1                                               ;; c473

wC474:
    ds 1                                               ;; c474

wC475:
    ds 1                                               ;; c475

wC476:
    ds 1                                               ;; c476

wC477:
    ds 1                                               ;; c477

wC478:
    ds 1                                               ;; c478

wC479:
    ds 1                                               ;; c479

wC47A:
    ds 1                                               ;; c47a

wC47B:
    ds 1                                               ;; c47b

wC47C:
    ds 1                                               ;; c47c

wC47D:
    ds 1                                               ;; c47d

wC47E:
    ds 1                                               ;; c47e

wC47F:
    ds 128                                             ;; c47f

wC4FF:
    ds 1                                               ;; c4ff

wC500:
    ds 32                                              ;; c500

wC520:
    ds 32                                              ;; c520

wC540:
    ds 192                                             ;; c540

wC600:
    ds 240                                             ;; c600

wC6F0:
    ds 16                                              ;; c6f0

wC700:
    ds 1                                               ;; c700

wC701:
    ds 1                                               ;; c701

wC702:
    ds 1                                               ;; c702

wVBlankInterruptHandler:
    ds 3                                               ;; c703

wLCDCInterruptHandler:
    ds 1                                               ;; c706

wC707:
    ds 1                                               ;; c707

wC708:
    ds 1                                               ;; c708

wC709:
    ds 1                                               ;; c709

wC70A:
    ds 3                                               ;; c70a

wC70D:
    ds 1                                               ;; c70d

wC70E:
    ds 15                                              ;; c70e

wC71D:
    ds 1                                               ;; c71d

wC71E:
    ds 29                                              ;; c71e

wC73B:
    ds 1                                               ;; c73b

wC73C:
    ds 1                                               ;; c73c

wC73D:
    ds 8                                               ;; c73d

wC745:
    ds 1                                               ;; c745

wC746:
    ds 26                                              ;; c746

wC760:
    ds 3                                               ;; c760

wC763:
    ds 1                                               ;; c763

wC764:
    ds 1                                               ;; c764

wC765:
    ds 11                                              ;; c765

wC770:
    ds 1                                               ;; c770

wC771:
    ds 3                                               ;; c771

wC774:
    ds 1                                               ;; c774

wC775:
    ds 1                                               ;; c775

wC776:
    ds 3                                               ;; c776

wC779:
    ds 2                                               ;; c779

wC77B:
    ds 1                                               ;; c77b

wC77C:
    ds 1                                               ;; c77c

wC77D:
    ds 1                                               ;; c77d

wC77E:
    ds 1                                               ;; c77e

wC77F:
    ds 1                                               ;; c77f

wC780:
    ds 1                                               ;; c780

wC781:
    ds 1                                               ;; c781

wC782:
    ds 1                                               ;; c782

wC783:
    ds 1                                               ;; c783

wC784:
    ds 1                                               ;; c784

wC785:
    ds 2                                               ;; c785

wC787:
    ds 1                                               ;; c787

wC788:
    ds 1                                               ;; c788

wC789:
    ds 1                                               ;; c789

wC78A:
    ds 3                                               ;; c78a

wC78D:
    ds 2                                               ;; c78d

wC78F:
    ds 2                                               ;; c78f

wC791:
    ds 1                                               ;; c791

wC792:
    ds 4                                               ;; c792

wC796:
    ds 1                                               ;; c796

wC797:
    ds 1                                               ;; c797

wC798:
    ds 1                                               ;; c798

wC799:
    ds 1                                               ;; c799

wC79A:
    ds 1                                               ;; c79a

wC79B:
    ds 2                                               ;; c79b

wC79D:
    ds 1                                               ;; c79d

wC79E:
    ds 1                                               ;; c79e

wC79F:
    ds 1                                               ;; c79f

wC7A0:
    ds 1                                               ;; c7a0

wC7A1:
    ds 2                                               ;; c7a1

wC7A3:
    ds 1                                               ;; c7a3

wC7A4:
    ds 1                                               ;; c7a4

wC7A5:
    ds 1                                               ;; c7a5

wC7A6:
    ds 2                                               ;; c7a6

wC7A8:
    ds 2                                               ;; c7a8

wC7AA:
    ds 3                                               ;; c7aa

wC7AD:
    ds 25                                              ;; c7ad

wC7C6:
    ds 1                                               ;; c7c6

wC7C7:
    ds 1                                               ;; c7c7

wC7C8:
    ds 1                                               ;; c7c8

wC7C9:
    ds 1                                               ;; c7c9

wC7CA:
    ds 1                                               ;; c7ca

wC7CB:
    ds 1                                               ;; c7cb

wC7CC:
    ds 1                                               ;; c7cc

wC7CD:
    ds 1                                               ;; c7cd

wC7CE:
    ds 1                                               ;; c7ce

wC7CF:
    ds 1                                               ;; c7cf

wC7D0:
    ds 1                                               ;; c7d0

wC7D1:
    ds 1                                               ;; c7d1

wC7D2:
    ds 1                                               ;; c7d2

wC7D3:
    ds 3                                               ;; c7d3

wC7D6:
    ds 1                                               ;; c7d6

wC7D7:
    ds 2                                               ;; c7d7

wC7D9:
    ds 1                                               ;; c7d9

wC7DA:
    ds 1                                               ;; c7da

wC7DB:
    ds 3                                               ;; c7db

wC7DE:
    ds 1                                               ;; c7de

wC7DF:
    ds 1                                               ;; c7df

wC7E0:
    ds 14                                              ;; c7e0

wC7EE:
    ds 4                                               ;; c7ee

wC7F2:
    ds 1                                               ;; c7f2

wC7F3:
    ds 13                                              ;; c7f3

wC800:
    ds 20                                              ;; c800

wC814:
    ds 748                                             ;; c814

; START OF AUDIO ENGINE WRAM
wMusicTempoTimeCounter:
    ds 1                                               ;; cb00

wMusicTempo:
    ds 1                                               ;; cb01

wSoundEffectDurationChannel2:
    ds 1                                               ;; cb02

wMusicNoteDurationChannel2:
    ds 1                                               ;; cb03

wMusicInstructionPointerChannel2:
    ds 1                                               ;; cb04
.high:
    ds 1                                               ;; cb05

wMusicVibratoDurationChannel2:
    ds 1                                               ;; cb06

wMusicVibratoEnvelopeChannel2:
    ds 1                                               ;; cb07
.high:
    ds 1                                               ;; cb08

wMusicVibratoEnvelopePointerChannel2:
    ds 1                                               ;; cb09
.high:
    ds 1                                               ;; cb0a

wMusicOctaveChannel2:
    ds 1                                               ;; cb0b

wMusicNR21DutyCycleChannel2:
    ds 1                                               ;; cb0c

wMusicCurrentPitchChannel2:
    ds 1                                               ;; cb0d
.high:
    ds 1                                               ;; cb0e

wMusicLoopCounter1Channel2:
    ds 1                                               ;; cb0f

wMusicNR22DefaultVolumeChannel2:
    ds 1                                               ;; cb10

wMusicNotePitchChannel2:
    ds 2                                               ;; cb11

wMusicEndedOnChannel2:
    ds 1                                               ;; cb13

wMusicVolumeDurationChannel2:
    ds 1                                               ;; cb14

wMusicVolumeEnvelopeChannel2:
    ds 1                                               ;; cb15
.high:
    ds 1                                               ;; cb16

wMusicVolumeEnvelopePointerChannel2:
    ds 1                                               ;; cb17
.high:
    ds 1                                               ;; cb18

wMusicLoopCounter2Channel2:
    ds 1                                               ;; cb19

wSoundEffectDurationChannel1:
    ds 1                                               ;; cb1a

wMusicNoteDurationChannel1:
    ds 1                                               ;; cb1b

wMusicInstructionPointerChannel1:
    ds 1                                               ;; cb1c
.high:
    ds 1                                               ;; cb1d

wMusicVibratoDurationChannel1:
    ds 1                                               ;; cb1e

wMusicVibratoEnvelopeChannel1:
    ds 1                                               ;; cb1f
.high:
    ds 1                                               ;; cb20

wMusicVibratoEnvelopePointerChannel1:
    ds 1                                               ;; cb21

.high:
    ds 1                                               ;; cb22

wMusicOctaveChannel1:
    ds 1                                               ;; cb23

wMusicNR11DutyCycleChannel1:
    ds 1                                               ;; cb24

wMusicCurrentPitchChannel1:
    ds 1                                               ;; cb25
.high:
    ds 1                                               ;; cb26

wMusicLoopCounter1Channel1:
    ds 1                                               ;; cb27

wMusicNR12DefaultVolumeChannel1:
    ds 1                                               ;; cb28

wMusicNotePitchChannel1:
    ds 1                                               ;; cb29

wMusicStereoPanChannel1:
    ds 1                                               ;; cb2a

wMusicEndedOnChannel1:
    ds 1                                               ;; cb2b

wMusicVolumeDurationChannel1:
    ds 1                                               ;; cb2c

wMusicVolumeEnvelopeChannel1:
    ds 1                                               ;; cb2d
.high:
    ds 1                                               ;; cb2e

wMusicVolumeEnvelopePointerChannel1:
    ds 1                                               ;; cb2f
.high:
    ds 2                                               ;; cb30

;wMusicLoopCounter2Channel1 is apparently unused

wSoundEffectDurationChannel3:
    ds 1                                               ;; cb32

wMusicNoteDurationChannel3:
    ds 1                                               ;; cb33

wMusicInstructionPointerChannel3:
    ds 1                                               ;; cb34
.high:
    ds 1                                               ;; cb35

wMusicVibratoDurationChannel3:
    ds 1                                               ;; cb36

wMusicVibratoEnvelopeChannel3:
    ds 1                                               ;; cb37
.high:
    ds 1                                               ;; cb38

wMusicVibratoEnvelopePointerChannel3:
    ds 1                                               ;; cb39
.high:
    ds 1                                               ;; cb3a

wMusicOctaveChannel3:
    ds 2                                               ;; cb3b

wMusicCurrentPitchChannel3:
    ds 1                                               ;; cb3d
.high:
    ds 1                                               ;; cb3e

wMusicLoopCounter1Channel3:
    ds 1                                               ;; cb3f

wMusicVolumeChannel3:
    ds 1                                               ;; cb40

wMusicNotePitchChannel3:
    ds 2                                               ;; cb41

wMusicEndedOnChannel3:
    ds 7                                               ;; cb43

wSoundEffectDurationChannel4:
    ds 17                                              ;; cb4a

wMusicEndedOnChannel4:
    ds 7                                               ;; cb5b

wMusicDataBackup:
    ds 98                                              ;; cb62

wSoundEffectInstructionPointerChannel1:
    ds 1                                               ;; cbc4
.high:
    ds 1                                               ;; cbc5

wSoundEffectInstructionPointerChannel4:
    ds 1                                               ;; cbc6
.high:
    ds 57                                              ;; cbc7
; END OF AUDIO ENGINE WRAM

wCC00:
    ds 128                                             ;; cc00

wCC80:
    ds 16                                              ;; cc80

wCC90:
    ds 624                                             ;; cc90

wCF00:
    ds 224                                             ;; cf00

wCFE0:
    ds 1                                               ;; cfe0

wCFE1:
    ds 5                                               ;; cfe1

wCFE6:
    ds 1                                               ;; cfe6

wCFE7:
    ds 1                                               ;; cfe7

wCFE8:
    ds 1                                               ;; cfe8

wCFE9:
    ds 1                                               ;; cfe9

wCFEA:
    ds 6                                               ;; cfea

wCFF0:
    ds 1                                               ;; cff0

wCFF1:
    ds 1                                               ;; cff1

wCFF2:
    ds 1                                               ;; cff2

wCFF3:
    ds 1                                               ;; cff3

wCFF4:
    ds 1                                               ;; cff4

wCFF5:
    ds 11                                              ;; cff5

wD000:
    ds 1                                               ;; d000

wD001:
    ds 1                                               ;; d001

wD002:
    ds 8                                               ;; d002

wD00A:
    ds 2                                               ;; d00a

wD00C:
    ds 6                                               ;; d00c

wD012:
    ds 46                                              ;; d012

wD040:
    ds 1                                               ;; d040

wD041:
    ds 4                                               ;; d041

wD045:
    ds 1                                               ;; d045

wD046:
    ds 954                                             ;; d046

wD400:
    ds 256                                             ;; d400

wD500:
    ds 1                                               ;; d500

wD501:
    ds 9                                               ;; d501

wD50A:
    ds 358                                             ;; d50a

wD670:
    ds 400                                             ;; d670

wD800:
    ds 1                                               ;; d800

wD801:
    ds 1                                               ;; d801

wD802:
    ds 1                                               ;; d802

wD803:
    ds 65                                              ;; d803

wD844:
    ds 1                                               ;; d844

wD845:
    ds 1                                               ;; d845

wD846:
    ds 1                                               ;; d846

wD847:
    ds 1                                               ;; d847

wD848:
    ds 4                                               ;; d848

wD84C:
    ds 1                                               ;; d84c

wD84D:
    ds 17                                              ;; d84d

wD85E:
    ds 162                                             ;; d85e

wD900:
    ds 6                                               ;; d900

wD906:
    ds 6                                               ;; d906

wD90C:
    ds 1                                               ;; d90c

wD90D:
    ds 3                                               ;; d90d

wD910:
    ds 16                                              ;; d910

wD920:
    ds 1                                               ;; d920

wD921:
    ds 1                                               ;; d921

wD922:
    ds 5                                               ;; d922

wD927:
    ds 1                                               ;; d927

wD928:
    ds 5                                               ;; d928

wD92D:
    ds 1                                               ;; d92d

wD92E:
    ds 5                                               ;; d92e

wD933:
    ds 3                                               ;; d933

wD936:
    ds 3                                               ;; d936

wD939:
    ds 3                                               ;; d939

wD93C:
    ds 1                                               ;; d93c

wD93D:
    ds 1                                               ;; d93d

wD93E:
    ds 1                                               ;; d93e

wD93F:
    ds 1                                               ;; d93f

wD940:
    ds 1                                               ;; d940

wD941:
    ds 1                                               ;; d941

wD942:
    ds 1                                               ;; d942

wD943:
    ds 1                                               ;; d943

wD944:
    ds 2                                               ;; d944

wD946:
    ds 2                                               ;; d946

wD948:
    ds 6                                               ;; d948

wD94E:
    ds 31                                              ;; d94e

wD96D:
    ds 6                                               ;; d96d

wD973:
    ds 1                                               ;; d973

wD974:
    ds 1                                               ;; d974

wD975:
    ds 1                                               ;; d975

wD976:
    ds 1                                               ;; d976

wD977:
    ds 1                                               ;; d977

wD978:
    ds 2                                               ;; d978

wD97A:
    ds 1                                               ;; d97a

wD97B:
    ds 1                                               ;; d97b

wD97C:
    ds 10                                              ;; d97c

wD986:
    ds 3                                               ;; d986

wD989:
    ds 1                                               ;; d989

wD98A:
    ds 1                                               ;; d98a

wD98B:
    ds 1141                                            ;; d98b

wDE00:
    ds 16                                              ;; de00

wDE10:
    ds 496                                             ;; de10

SECTION "hram", HRAM[$ff80]

hOAM_DMAHandler:
    ds 8                                               ;; ff80

hCurrentBank:
    ds 1                                               ;; ff88

hFF89:
    ds 1                                               ;; ff89

hFF8A:
    ds 1                                               ;; ff8a

hFF8B:
    ds 1                                               ;; ff8b

hFF8C:
    ds 1                                               ;; ff8c

hFF8D:
    ds 3                                               ;; ff8d

hFF90:
    ds 1                                               ;; ff90

hFF91:
    ds 1                                               ;; ff91

hFF92:
    ds 1                                               ;; ff92

hFF93:
    ds 1                                               ;; ff93

hFF94:
    ds 1                                               ;; ff94

hFF95:
    ds 1                                               ;; ff95

hFF96:
    ds 1                                               ;; ff96

hFF97:
    ds 1                                               ;; ff97

hFF98:
    ds 1                                               ;; ff98

hFF99:
    ds 2                                               ;; ff99

hFF9B:
    ds 1                                               ;; ff9b

hFF9C:
    ds 1                                               ;; ff9c

hFF9D:
    ds 1                                               ;; ff9d

hFF9E:
    ds 1                                               ;; ff9e

hFF9F:
    ds 1                                               ;; ff9f

hFFA0:
    ds 1                                               ;; ffa0

hFFA1:
    ds 1                                               ;; ffa1

hFFA2:
    ds 1                                               ;; ffa2

hFFA3:
    ds 2                                               ;; ffa3

hFFA5:
    ds 1                                               ;; ffa5

hFFA6:
    ds 1                                               ;; ffa6

hFFA7:
    ds 1                                               ;; ffa7

hFFA8:
    ds 1                                               ;; ffa8

hFFA9:
    ds 1                                               ;; ffa9

hFFAA:
    ds 6                                               ;; ffaa

; START OF AUDIO ENGINE HRAM
hCurrentMusic:
    ds 1                                               ;; ffb0

hMusicSpecialSongRequest:
    ds 1                                               ;; ffb1

hSFX:
    ds 1                                               ;; ffb2

hPlayingMusic:
    ds 1                                               ;; ffb3

hVibratoVolumeChannelSelection:
    ds 1                                               ;; ffb4

hMusicNoteDurationChannel2Copy:
    ds 1                                               ;; ffb5

hMusicNoteDurationChannel1Copy:
    ds 1                                               ;; ffb6

hMusicNoteDurationChannel3Copy:
    ds 2                                               ;; ffb7

hMusicSpecialSongPlaying:
    ds 1                                               ;; ffb9

hWaveTablePointer:
    ds 1                                               ;; ffba
.high:
    ds 1                                               ;; ffbb

hSoundEffectLoopCounterChannel1:
    ds 1                                               ;; ffbc

; END OF AUDIO ENGINE HRAM
hSoundEffectLoopCounterChannel4:
    ds 3                                               ;; ffbd

hFFC0:
    ds 1                                               ;; ffc0

hFFC1:
    ds 1                                               ;; ffc1

hFFC2:
    ds 1                                               ;; ffc2

hFFC3:
    ds 1                                               ;; ffc3

hFFC4:
    ds 28                                              ;; ffc4

hFFE0:
    ds 30                                              ;; ffe0

hFFFE:
    ds 1                                               ;; fffe

SECTION "vram", VRAM[$8000]
    ds 8192                                            ;; 8000

SECTION "sram", SRAM[$a000]

sA000:
    ds 1536                                            ;; a000

sA600:
    ds 384                                             ;; a600

sA780:
    ds 1                                               ;; a780

sA781:
    ds 6271                                            ;; a781
