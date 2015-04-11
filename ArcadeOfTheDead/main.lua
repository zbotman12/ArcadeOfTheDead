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
		--[[1]] { x = 1, y = 1, width = 70, height = 70}, 	--Full Block
		--[[2]] { x = 70, y = 1, width = 70, height = 70}, 	--Damage level 1
		--[[3]] { x = 140, y = 1, width = 70, height = 70}, --Damage level 2
		--[[4]] { x = 210, y = 1, width = 70, height = 70}, --Damage level 3
		--[[5]] { x = 280, y = 1, width = 70, height = 70}, --Damage level 4
		-------------------------------------------------------------
		--[[6]] { x = 1, y = 70, width = 50, height = 100}, --Default Player
		-------------------------------------------------------------
		--[[7]] { x = 1, y = 170, width = 18, height = 100}, --pistol shoot 1
		--[[8]] { x = 20, y = 170, width = 18, height = 100}, --pistol shoot 2
		--[[9]] { x = 40, y = 170, width = 18, height = 100}, --pistol shoot 3
		--[[10]] { x = 60, y = 170, width = 18, height = 100}, --pistol shoot 4
		--[[11]] { x = 80, y = 170, width = 18, height = 100}, --pistol shoot 5
		--[[12]] { x = 100, y = 170, width = 18, height = 100}, --pistol shoot 6
		--[[13]] { x = 120, y = 170, width = 18, height = 100}, --pistol shoot 7
		--[[14]] { x = 140, y = 170, width = 18, height = 100}, --pistol shoot 8
		--[[15]] { x = 160, y = 170, width = 18, height = 100}, --pistol shoot 9
		-------------------------------------------------------------
		--[[16]] { x = 1, y = 270, width = 240, height = 70}, --button
		--[[17]] { x = 1, y = 340, width = 200, height = 180}, --arrow left
		--[[18]] { x = 200, y = 340, width = 200, height = 180}, --arrow right
		-------------------------------------------------------------
		--[[19]] { x = 1, y = 520, width = 70, height = 100}, --Zombie Walk 1

	}
}

local spriteSheet = graphics.newImageSheet( "images/spriteSheet.png", MainSheetOpt );
local level = 0;
local sceneOpt = {
	effect = "fade",
	time = 800,
	params = {spriteSheet = spriteSheet,level=level}
}
-- load first scene
composer.gotoScene( "GameOver", sceneOpt);
