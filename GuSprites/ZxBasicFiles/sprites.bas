'In order to use this file, make sure you define these options before including
'GuSprites.zxbas library:
' PRECOMPUTED_SPRITES
'and
' STORE_UNSHIFTED_SPRITES

Asm
SPRITE_BUFFER:
    DEFB 64,70,70,64,8,244,2,1
    DEFB 20,189,66,74,34,28,8,20, 50,34,70,101,58,18,19,24
    DEFB 73,73,73,73,73,73,73,73, 0,0,255,0,0,255,0,0, 73,73,73,73,73,73,73,73, 0,0,255,0,0,255,0,0
SPRITE_INDEX:
    DEFW (SPRITE_BUFFER + 0)
    DEFW (SPRITE_BUFFER + 8)
    DEFW (SPRITE_BUFFER + 24)
SPRITE_COUNT:
    DEFB 3
End Asm

'In this included file you have the sprites defined in TestLib.zxbas with next lines:
'Dim sprite(8) as uByte => { 64,70,70,64,8,244,2,1 }
'Dim sprite2(16) as uByte => { 20,189,66,74,34,28,8,20, 50,34,70,101,58,18,19,24 }
'Dim sprite3(32) as uByte => { 73,73,73,73,73,73,73,73, 0,0,255,0,0,255,0,0, 73,73,73,73,73,73,73,73, 0,0,255,0,0,255,0,0 }
'Dim sNumber as uByte
'Dim sNumber2 as uByte
'Dim sNumber3 as uByte
'sNumber = Create1x1Sprite(@sprite)
'sNumber2 = Create1x2Sprite(@sprite2)
'sNumber3 = Create2x2Sprite(@sprite3)
'
'When you use this included file, you will not use sprite* arrays,
'sNumber* variables, nor Create*Sprite functions: you will use
'1 instead of sNumber, 2 instead of sNumber2, and 3 instead of sNumber3.
