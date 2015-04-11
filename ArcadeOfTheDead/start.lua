--Start Menu
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
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;

	if ( phase == "will" ) then
	elseif ( phase == "did" ) then	
		local function nextScene (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "day", sceneOpt);
		end
		local startGameBtn = widget.newButton(
		    {
		        x = display.contentCenterX-200,
		        y = display.contentCenterY + 300,    
		        id = "Start Game",
		        label = "Start Game",
		        fontSize=35,
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
			composer.gotoScene( "intro", sceneOpt);
		end
		local howToPlay = widget.newButton(
		    {
		        x = display.contentCenterX +200,
		        y = display.contentCenterY + 300,    
		        id = "How To Play",
		        label = "How To Play",
		        fontSize=35,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
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