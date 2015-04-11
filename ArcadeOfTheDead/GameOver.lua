--Game Over
local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;


--scene:create
function scene:create( event )
	local sceneGroup = self.view
	params = event.params
	local bg = display.newImage ("images/GameOver.png");
	bg.anchorX=0; bg.anchorY=0;
    bg:toBack();
    sceneGroup:insert( bg );
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;

	if ( phase == "will" ) then
		
		local GO = audio.loadStream("sounds/gameover.mp3")
		audio.setMaxVolume(0.045, {channel = 1})
		local backGroundChan = audio.play(GO, {channel = 1, loops = -1, fadein = 500})
		
	elseif ( phase == "did" ) then	
		local function nextScene (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "start", sceneOpt);
		end
		local startGameBtn = widget.newButton(
		    {
		        x = display.contentCenterX,
		        y = display.contentCenterY + 400,    
		        id = "New Game",
		        label = "New Game?",
		        fontSize=35,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = nextScene,
		    }
		);
		startGameBtn:setFillColor( .6,0,1 );
		sceneGroup:insert( startGameBtn );
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
