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
		--[[7]] { x = 1, y = 170, width = 18, height = 100}, --default shoot 1
		--[[8]] { x = 20, y = 170, width = 18, height = 100}, --default shoot 2
		--[[9]] { x = 40, y = 170, width = 18, height = 100}, --default shoot 3
		--[[10]] { x = 60, y = 170, width = 18, height = 100}, --default shoot 4
		--[[11]] { x = 80, y = 170, width = 18, height = 100}, --default shoot 5
		--[[12]] { x = 100, y = 170, width = 18, height = 100}, --default shoot 6
		--[[13]] { x = 120, y = 170, width = 18, height = 100}, --default shoot 7
		--[[14]] { x = 140, y = 170, width = 18, height = 100}, --default shoot 8
		--[[15]] { x = 160, y = 170, width = 18, height = 100}, --default shoot 9
		-------------------------------------------------------------
		--[[16]] { x = 1, y = 270, width = 240, height = 70}, --button
		--[[17]] { x = 1, y = 340, width = 200, height = 178}, --arrow left
		--[[18]] { x = 200, y = 340, width = 200, height = 178}, --arrow right
		-------------------------------------------------------------
		--[[19]] { x = 1, y = 520, width = 70, height = 100}, --Zombie Walk 1
		--[[20]] { x = 70, y = 520, width = 70, height = 100}, --Zombie Walk 2
		--[[21]] { x = 140, y = 520, width = 70, height = 100}, --Zombie Walk 3
		--[[22]] { x = 210, y = 520, width = 70, height = 100}, --Zombie Walk 4
		--[[23]] { x = 280, y = 520, width = 70, height = 100}, --Zombie Walk 5
		--[[24]] { x = 350, y = 520, width = 70, height = 100}, --Zombie Walk 6
		--[[25]] { x = 420, y = 520, width = 70, height = 100}, --Zombie Walk 7
		--[[26]] { x = 490, y = 520, width = 70, height = 100}, --Zombie Walk 8
		-------------------------------------------------------------
		--[[27]] { x = 400, y = 340, width = 25, height = 25}, --Heart for GUI
		-------------------------------------------------------------
		--[[28]] { x = 50, y =  70, width = 50, height = 100}, --Megaman
		--[[29]] { x = 100, y = 70, width = 50, height = 100}, --Kirby
		--[[30]] { x = 150, y = 70, width = 50, height = 100}, --Link
		-------------------------------------------------------------
		--[[31]] { x = 180, y = 170, width = 18, height = 100}, --Megaman shoot 1
		--[[32]] { x = 200, y = 170, width = 18, height = 100}, --Megaman shoot 2
		--[[33]] { x = 220, y = 170, width = 18, height = 100}, --Megaman shoot 3
		--[[34]] { x = 240, y = 170, width = 18, height = 100}, --Megaman shoot 4
		--[[35]] { x = 260, y = 170, width = 18, height = 100}, --Megaman shoot 5
		--[[36]] { x = 280, y = 170, width = 18, height = 100}, --Megaman shoot 6
		--[[37]] { x = 300, y = 170, width = 18, height = 100}, --Megaman shoot 7
		--[[38]] { x = 320, y = 170, width = 18, height = 100}, --Megaman shoot 8
		--[[39]] { x = 340, y = 170, width = 18, height = 100}, --Megaman shoot 9
		-------------------------------------------------------------
		--[[40]] { x = 360, y = 170, width = 18, height = 100}, --Kirby shoot 1
		--[[41]] { x = 380, y = 170, width = 18, height = 100}, --Kirby shoot 2
		--[[42]] { x = 400, y = 170, width = 18, height = 100}, --Kirby shoot 3
		--[[43]] { x = 420, y = 170, width = 18, height = 100}, --Kirby shoot 4
		--[[44]] { x = 440, y = 170, width = 18, height = 100}, --Kirby shoot 5
		--[[45]] { x = 460, y = 170, width = 18, height = 100}, --Kirby shoot 6
		--[[46]] { x = 480, y = 170, width = 18, height = 100}, --Kirby shoot 7
		--[[47]] { x = 500, y = 170, width = 18, height = 100}, --Kirby shoot 8
		--[[48]] { x = 520, y = 170, width = 18, height = 100}, --Kirby shoot 9
		-------------------------------------------------------------
		--[[49]] { x = 540, y = 170, width = 18, height = 100}, --Link shoot 1
		--[[50]] { x = 560, y = 170, width = 18, height = 100}, --Link shoot 2
		--[[51]] { x = 580, y = 170, width = 18, height = 100}, --Link shoot 3
		--[[52]] { x = 600, y = 170, width = 18, height = 100}, --Link shoot 4
		--[[53]] { x = 620, y = 170, width = 18, height = 100}, --Link shoot 5
		--[[54]] { x = 640, y = 170, width = 18, height = 100}, --Link shoot 6
		--[[55]] { x = 660, y = 170, width = 18, height = 100}, --Link shoot 7
		--[[56]] { x = 680, y = 170, width = 18, height = 100}, --Link shoot 8
		--[[57]] { x = 680, y = 170, width = 18, height = 100}, --Link shoot 9
		-------------------------------------------------------------
		--[[58]] { x = 425, y = 340, width = 50, height = 25}, --Ticket for GUI
		--[[59]] { x = 476, y = 341, width = 180, height = 180}, --Block Swap Button
		-------------------------------------------------------------
		--[[60]] { x = 1,   y = 656, width = 100, height = 25}, --Block 1 icon
		--[[61]] { x = 626, y = 643, width = 50, height = 50}, --Block 2 icon
		--[[62]] { x = 313, y = 640, width = 75, height = 50}, --Block 5 icon
		--[[63]] { x = 114, y = 640, width = 75, height = 50}, --Block 3 icon
		--[[64]] { x = 213, y = 640, width = 75, height = 50}, --Block 4 icon		
		--[[65]] { x = 513, y = 643, width = 75, height = 50}, --Block 6 icon
		--[[66]] { x = 414, y = 643, width = 75, height = 50}, --Block 7 icon		
		--[[67]] { x = 36,   y = 753, width = 25, height = 25}, --Block 8 icon
		--[[68]] { x = 137, y = 744, width = 25, height = 50}, --Block 9 icon
		--------------------------------------------------------------
		--[[69]] { x = 350, y = 1, width = 70, height = 70}, --Golden Block

	}
}

local spriteSheet = graphics.newImageSheet( "images/spriteSheet.png", MainSheetOpt );
local level = 0;
local purchasedBlock = 0;
local gunType="pistol";
local sceneOpt = {
	effect = "fade",
	time = 800,
	params = {spriteSheet=spriteSheet,level=level,purchasedBlock=purchasedBlock,gunType=gunType}
}
-- load first scene
composer.gotoScene( "page1", sceneOpt);