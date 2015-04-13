---Tutorial page 3----
local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;


--scene:create
function scene:create( event )
	local sceneGroup = self.view;
	params = event.params;
	local bg = display.newImage ("images/tut3.png");
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

		local t3 = audio.loadStream("sounds/night.mp3");
		audio.setMaxVolume(.015, {channel = 1});
		local backGroundChan = audio.play(t3, {channel = 1, loops = -1, fadein = 500});

		local function instructionScene (event)
			Runtime:removeEventListener( "tap", instructionScene );
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(1)
			composer.gotoScene( "tutorial4", sceneOpt);
		end
		Runtime:addEventListener( "tap", instructionScene );
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;