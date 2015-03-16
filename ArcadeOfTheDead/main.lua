local composer = require( "composer" );

local sceneOpt = {
	effect = "fade",
	time = 800,
	params = {brickSheet = brickSheet}
}
-- load first scene
composer.gotoScene( "night", sceneOpt);