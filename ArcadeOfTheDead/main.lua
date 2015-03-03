local composer = require( "composer" );
local sceneOpt = {
	effect = "fade",
	time = 800,
	--params = {}
}
-- load first scene
composer.gotoScene( "day", sceneOpt);