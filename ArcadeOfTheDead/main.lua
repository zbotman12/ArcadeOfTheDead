local composer = require( "composer" );

local btnOpt =
{
    frames = {
        { x = 1, y = 1, width=79, height = 32}, --frame 1        
    }
};

local buttonSheet = graphics.newImageSheet( "images/button.png", btnOpt );

local sceneOpt = {
	effect = "fade",
	time = 800,
	params = {buttonSheet = buttonSheet}
}
-- load first scene
composer.gotoScene( "day", sceneOpt);