local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();

--scene:create
function scene:create( event )
	local sceneGroup = self.view
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then	
		local text = display.newText( sceneGroup, "shop scene", display.contentCenterX, display.contentCenterY, native.systemFont, 25 );
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;