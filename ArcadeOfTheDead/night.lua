local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;

--scene:create
function scene:create( event )
	local sceneGroup = self.view
	params = event.params
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then	
		local text = display.newText( sceneGroup, "night scene", display.contentCenterX, display.contentCenterY, native.systemFont, 25 );
		local function next (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			Runtime:removeEventListener("tap", next);
			composer.gotoScene( "day", sceneOpt);
		end
		Runtime:addEventListener("tap", next);
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;