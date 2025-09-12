# GuSprites for Boriel Basic.

This is a sprite library for Boriel Basic. Its goal is to have many animated sprites and
render them beating the scan line to avoid flickering.

It supports 1x1, 1x2 and 2x2 chars sprites and it can be configured to set how many of
each are available and can be rendered on screen to reduce as much as possible the
library footprint.

It also incorporates a tile system which can be enabled in order to create maps that are
preserved and autoredrawn. This can be also configure in replace mode or merge mode
(sprites replace tiles or sprites are merged with tiles)

In order to balance performance and memory consumption the library uses preshifted sprites but only once.
This allows the sprites to move in cells of 4 pixels resulting in an effective screen of 64x48 cells.

Sprites can be replaced resetting the sprite system and tile sets can be changed on the fly, so you can
load/unload sprites from the library as needed, you aren't restricted to a single set of sprites.

The library is completely free for use but a mention would be appreciated ;)

## UPDATE 2025-09-12

New feature: TileAnimated. Now, animated tiles can be obtained more accurately when executing RenderFrame. This has been included:

- A new parameter, MAX_ANIMATED_TILES_PER_SCREEN.
- An assembly routine, SET_TILE_ANIMATED, which changes nothing on screen when routine is called.
- Three Basic subroutines, in the spirit of TileChecked, to use the TileAnimated feature: SetTileAnimated, SetTiledObjectAnimated, and FillWithTileAnimated.
- An example program to see what this feature does: TestLib-TileAnimated.zxbas and TestLib-TileAnimated.tap. You can comment/uncomment lines 114-116 of ZXBasic program (please, check that 2 lines are commented and 1 is uncommented before compiling) to check that using SetTile/FillWithTile or SetTileChecked/FillWithTileChecked does not produce a perfect animation (you might have to slow down your emulator to see the imperfection), and that animation by SetTileAnimated/FillWithTileAnimated is accurate.
- An analysis program to understand how tiles and sprites interact when creating DrawOps, and what information is stored in DRAW_OPS_A and DRAW_OPS_B (via CURRENT_DRAW_OPS and CURRENT_CLEAR_OPS): analisis.zxbas (in Spanish) and analisis.tap.

New feature: a new mechanism to choose the features of this library. Since now, users had to define/undefine the parameters included at the beginning of GuSprites.zxbas to chose which features to use (PRECOMPUTED_SPRITES, ENABLE_PRINT, MERGE_TILES, etc.), which implied to make changes in the file GuSprites.zxbas and, more importantly, that these changes had to be manually repeated when downloading a new version of the library. Now, all user-defined parameters are left undefined so that the user should define those needed before including GuSprites.zxbas into their Boriel ZX Basic programs. These user-defined parameters are included between line 1 (CONFIG DEFINES) and line 93 (END CONFIG DEFINES) with corresponding explanations (many by Agustín Gimenez Bernad, aka Dr. Gusman). Also, programs that relied on parameters defined with default values (in previous versions of GuSprites.zxbas) will compile as before (backward compatibility). Please, note:

- The parameter ALL_NEEDED_PARAMETERS_ALREADY_DEFINED. When not defined (default), ENABLE_PRINT, ENABLE_1x1_SPRITES, ..., and ENABLE_INTERRUPTS are defined to default values in previous versions of GuSprites.zxbas (see lines 98-110 of GuSprites.zxbas). When defined, all parameters are left undefined, and you should define into your Boriel ZX Basic program (not in the library) the parameters that you need.
- Some example programs to see how to operate with ALL_NEEDED_PARAMETERS_ALREADY_DEFINED undefined (TestLib-Clipping.zxbas, TestLib-TileAnimated.zxbas, TestLib.zxbas, and TestPrintString.zxbas) and defined (TestLib-Everything.zxbas, and analisis.zxbas).

Old feature, made visible and definible: ROM_CHARSET. Now you can let ROM_CHARSET undefined (which defines it to be 3C00h; please, note https://skoolkid.github.io/rom/asm/3D00.html), or you can use your own character set by setting this parameter appropriately (which lets you use 256 different characters if you define them).

Some minor changes in the code and comments. If you want to track them, please visit https://github.com/ConradoBadenas/GuSprites/commit/85d9527fd6725f6e85c693fd514cff7c11b1b6b8

## UPDATE 2025-08-14

Added the "WithClipping" version of the Draw*Sprite functions.

With these new SUBs the programmer can Draw sprites that are partly off-screen.
Also, no drawing and no error are produced if sprite is completely off-screen.
This feature is only available when option SPRITE_XY_IN_PIXELS is enabled.
These new SUBs "Draw1x1SpriteWithClipping", "Draw1x2SpriteWithClipping", and "Draw2x2SpriteWithClipping"
use integer coordinates to handle negative and large positive values
(for example, a 2x2 sprite could be partly drawn at X,Y=253,-13).

This feature was suggested by ![Jose Rodriguez "Boriel"](https://github.com/boriel) on July 28th at the "Boriel ZX Basic" Telegram Group,
completed&released on July 30th, and improved&released on August 1st at the same Group.
Some extra testing by ![Sergio Morales "Menyiques"](https://github.com/Menyiques) indicates that it works fine.

## UPDATE 2025-07-25

Added option and code to draw sprites in any place of the screen by using Sprite coordinates X,Y measured In Pixels.

This feature will allow the programmer to use numbers from 0 to almost 250 for the X-coordinate,
and numbers from 0 to almost 190 for the Y-coordinate of a sprite
(0-240 and 0-176 for a 2x2 sprite),
which results in the sprite being drawn in any place of the screen.
Coordinates for tiles are measured in characters, as usual.

If the programmer enables SPRITE_XY_IN_PIXELS, unshifted sprites MUST be used:
if SXIP is enabled but SUS is not, then the library will enable SUS automatically.

Also, a file to test this new feature is added (TestLib-PS-SXIP.zxbas),
and all test files are compiled to check that all features work perfectly with this new version of the library:
each ZXBAS test file has a companion ZIP which includes resulting files (ASM, Mmap.TXT, and TAP files) from compiling.

## UPDATE 2025-07-07&12

 7th July: Added option and code to Store Unshifted Sprites (SUS from now) in the library sprite-buffer.

- This feature will allow to reduce even more the memory footprint of the library in programs that use static sprite sets:
each 1x1,1x2,2x2 sprite will be stored in 8,16,32 bytes instead of usual 48,72,120 bytes.
Therefore, the library will use much less memory, but will be a bit slower.

- SUS can be used with our without previous option for Precomputed Sprites (PS from now).
The behaviour of PS/nonPS is only affected in the kind of sprites stored in the library: unshifted with SUS, shifted without SUS.

12th July: New examples to test/check this option are included.

- TestLib-SUS.zxbas (for SUS and nonPS), and TestLib-PS-SUS.zxbas and sprites.bas (for SUS and PS).

## UPDATE 2021-05-04

Accumulative update with precomputed sprites support.

The biggest point on this update is the precomputed sprites support. This feature will allow to reduce the memory footprint
of the library in programs that use static sprite sets. Also the functionality is intended to be used wit the newly
released ![ResourceDesigner](https://github.com/gusmanb/ResourceDesigner), check it for more info.

- Now you can use precomputed sprites to reduce the memory footprint. Check the library for instructions on how to use.
- Added defines to enable/disable sprite types (reduce memory footprint)
- Corrected multiple errors in defines

## UPDATE 2021-01-28

Updated the *Checked functions.

Now the checked functions will not redraw the tile if an erase operation is found, in this case the
erase operation is replaced with the tile source address and the RenderFrame will draw it.
This avoids flickering in some scenarios.

## UPDATE 2021-01-27

Added "SetTiledObject" and "SetTiledObjectChecked" functions.

This will fill the specified area with an object splitted in tiles.
The object tiles must be added to the tileset in contiguous elements.
The order of the tiles must be top-down-left-right, like sprites.

Added "FillWithTile" and "FillWithTileChecked" functions.

This will fill the specified area with a single tile.

Added "CREATE_ATTRIB" macro.

Macro to ease the attribute creation but without wasting CPU cicles as
this will be precomputed by the compiler.

## UPDATE 2021-01-23

Added "SetTileChecked" function.

As the clear operations are created at the same time a sprite has been moved, if your game
must change that tile after the sprite leaves the tile then that cell will be rendered
incorrectly with the old tile.

To avoid this now you can use "SetTileChecked", it will check all find any clear op affecting
the tile and modify it setting the new tile as the source.

Added "CancelOps" function

If you have drawn a frame and want to preserve it as a background then you must get rid
of the clear operations or whenever you render a new frame these ops will clear the last
position of your old sprites.

This function will erase these operations.

Added "ClearScreen" function

This will clear the screen, tile map and pending operations all at once but will preserve
loaded sprites, not like ResetGFXLib,

## So, where the heck do I begin?

First, download the lib and give a look to the test program ;)
This repository contains a Visual Studio solution as I use SpectNetIDE to develop for ZX Spectrum.
The library itself is found in the "ZxBasicFiles" folder of the solution, the file called "GuSprites.zxbas".
If you are using a different IDE just copy the file to your project and add an include to it.

Second, configure the library as you need. At the begining of the library you will find some defines that you
can modify to set the required params. There are three sets of defines: defines for sprite quantity, defines
for on-screen sprites and defines to enable functions.

The first set configures how many sprites you will use. This allocates space on the shift buffer for the
specified sprites.

The second set configures the maximum number of sprites on screen at any moment. This allocates space on the
operation buffers.

The last set configures the tile system and allows you to enable/disable interrupts. The library needs to
disable the interrupts to avoid the ROM int to corrupt data so if not configured it will completely disable
the int. If you need to use it for keyboard scan or anything else you can enable the define so it will
enable/disable the int only on the required moments.

## Ok, it's configured, and now?

Of course, include the library in your program ;)

Now you must initialize the library. This is done with `InitGFXLib()`, this will initialize the buffers and
pointers of the library.

```basic
	InitGFXLib()
```
	

Next, if you want to use tiles set the tileset. A tileset is a set of 8 byte arrays that is used to render a
background on the scene. Each tileset must start with an empty char, this is used for clear purposes.

```basic
	Dim tileSet(3,8) as uByte => { _ 
		{0,0,0,0,0,0,0,0}, _
		{ 0,60,66,66,66,66,60,0 }, _
		{ 0,24,24,36,66,66,126,0 } _
	}

	SetTileset(@tileSet)
```

Then you can draw the background setting assigning tiles to the map using SetTile.
The first param indicates the sprite number, it is one-based excluding the empty one.
The second param indicates the attribute for the tile.
The third and fourth are the coordinates, zero based from the 32*24 screen chars.

```basic
	SetTile(1, 52, x, y)
	SetTile(2, 56, x, y)
```

Next you should create the sprites on the library. You can create as many you have
defined of each type (1x1, 1x2, 2x2).
Sprites are byte arrays representing chars sorted in columns, not in rows. This is very important or the sprites will not
render correctly.


	-------------
	|     |     |
	|  1  |  3  |
	|_____|_____|
	|     |     |
	|  2  |  4  |
	|     |     |
	-------------

To create a sprite call the corresponding function for the sprite type you're creating and it will return the
sprite number assigned to it.

```basic

	Dim sprite(8) as uByte => { 64,70,70,64,8,244,2,1 }
	Dim sprite2(16) as uByte => { 20,189,66,74,34,28,8,20, 50,34,70,101,58,18,19,24 }
	Dim sprite3(32) as uByte => { 73,73,73,73,73,73,73,73, 0,0,255,0,0,255,0,0, 73,73,73,73,73,73,73,73, 0,0,255,0,0,255,0,0 }

	Dim sNumber as uByte
	Dim sNumber2 as uByte
	Dim sNumber3 as uByte

	sNumber = Create1x1Sprite(@sprite)
	sNumber2 = Create1x2Sprite(@sprite2)
	sNumber3 = Create2x2Sprite(@sprite3)
```

Ok, now everything is ready, you can start your loop, draw as many sprites you like and render the final scene.

```basic

	do

	 Draw1x1Sprite(sNumber, 0, 0)
	 Draw1x2Sprite(sNumber2, 5, 5)
	 Draw2x2Sprite(sNumber3, 10, 10)

	 RenderFrame()

	loop

```

Each frame will be automatically cleaned in the next renderso you don't need to take care of anything.

## Hmmm, I want to change my sprites, what should I do?

Reset the library calling `ResetGFXLib()`, it will free all the buffers and clear all the maps.
Only the assigned tileset will be preserved.

After cleaning the lib a `clear` is recommended in order to erase the screen unless your tilemap covers
all the background.

Another option is to manually fill the tile map with the tile 0, that will clear the screen.



Well, I think for now that's all, if you need help feel free to open an issue ;)

Happy coding!
