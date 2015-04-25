--Start Menu
if "Win" == system.getInfo( "platformName" ) then
    BlockFont = "3D Thirteen Pixel Fonts";
    CompFont = "Computer Pixel-7";
elseif "Android" == system.getInfo( "platformName" ) then
    BlockFont = "images/3D-Thirteen-Pixel-Fonts"
    CompFont = "images/computer_pixel-7"
end

local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;


--scene:create
function scene:create( event )
	local sceneGroup = self.view
	params = event.params;
	local bg = display.newImage ("images/ArcadeOfTheDeadTitle.png");
	bg.anchorX=0; bg.anchorY=0;
    bg:toBack();
    sceneGroup:insert( bg );
	print(params.newGame);
end

--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;

	if ( phase == "will" ) then
		local start = audio.loadSound("sounds/what.mp3");
		audio.setMaxVolume(.1, {channel = 1});
		local backGroundChan = audio.play(start, {channel = 1, loops = -1, fadein = 500});
			
		local function nextScene (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(1)
			composer.gotoScene( "day", sceneOpt);
		end
		local startGameBtn = widget.newButton(
		    {
		        x = display.contentCenterX-200,
		        y = display.contentCenterY + 300,    
		        id = "Start",
		        label = "Start",
		        fontSize=75,
		        font=CompFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = nextScene,
		    }
		);
		startGameBtn:setFillColor( 0,1,0 );
		sceneGroup:insert( startGameBtn );

		local function instructionScene (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(1)
			composer.gotoScene( "tutorial", sceneOpt);
		end
		local howToPlay = widget.newButton(
		    {
		        x = display.contentCenterX +200,
		        y = display.contentCenterY + 300,    
		        id = "Tutorial",
		        label = "Tutorial",
		        fontSize=75,
		        font=CompFont,
		        labelColor = { default={ 0, 0, 0}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = instructionScene,
		    }
		);
		howToPlay:setFillColor( 1,1,0 );
		sceneGroup:insert( howToPlay );
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
