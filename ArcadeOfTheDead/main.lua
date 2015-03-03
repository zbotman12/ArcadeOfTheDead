local composer = require( "composer" );

--Bricks-------------------------------
local brickOpts = {
	frames = {
		--need coordinates
		{}, --style 1 full
		{}, --style 1 2/3
		{}, --style 1 1/3
		{}, --style 2 full
		{}, --style 2 2/3
		{}, --style 2 1/3
	}
};

local brickSheet = graphics.newImageSheet("images/bricks.png", brickOpts);


local sceneOpt = {
	effect = "fade",
	time = 800,
	params = {brickSheet = brickSheet}
}
-- load first scene
composer.gotoScene( "day", sceneOpt);