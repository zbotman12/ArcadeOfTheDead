---Tutorial page 4----
local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;


--scene:create
function scene:create( event )
	local sceneGroup = self.view;
	params = event.params;
	local bg = display.newImage ("images/tut4.png");
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
		local function instructionScene (event)
			Runtime:removeEventListener( "tap", instructionScene );
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "start", sceneOpt);
		end
		Runtime:addEventListener( "tap", instructionScene );
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;