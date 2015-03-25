local composer = require( "composer" );

local btnOpt =
{
    frames = {
        { x = 1, y = 1, width=79, height = 32}, --frame 1        
    }
};

local MainSheetOpt =
{

	frames = {
		{ x = 1, y = 1, width = 70, height = 70}, 	--Full Block
		{ x = 70, y = 1, width = 70, height = 70}, 	--Damage level 1
		{ x = 140, y = 1, width = 70, height = 70}, --Damage level 2
		{ x = 210, y = 1, width = 70, height = 70}, --Damage level 3
		{ x = 280, y = 1, width = 70, height = 70}, --Damage level 4
	}
}

local buttonSheet = graphics.newImageSheet( "images/button.png", btnOpt );

local spriteSheet = graphics.newImageSheet( "images/spriteSheet.png", MainSheetOpt );

local sceneOpt = {
	effect = "fade",
	time = 800,
	params = {buttonSheet = buttonSheet, spriteSheet = spriteSheet}
}
-- load first scene
composer.gotoScene( "day", sceneOpt);