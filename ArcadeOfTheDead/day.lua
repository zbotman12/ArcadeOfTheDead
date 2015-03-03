local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;

--scene:create
function scene:create( event )
	local sceneGroup = self.view;
	params = event.params
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;
	local wall = display.newGroup();
	sceneGroup:insert(wall);

	function spawnBlockStyle1( x, y )
		local seqData = {
		    {name = "full", frames={1}},
		    {name = "twothirds", frames={2}},
		    {name = "onethird", frames={3}},
		}
		local block1 = display.newSprite (params.brickSheet, seqData);
		wall:insert(block1);
		block1.anchorX = 0; block1.anchorY = 0;
		alex.x = x;
		alex.y = y;	
		--add physics collision thing here for zombies
	end

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then	
		local text = display.newText( sceneGroup, "day scene", display.contentCenterX, display.contentCenterY, native.systemFont, 25 );

		local function next (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			Runtime:removeEventListener("tap", next);
			composer.gotoScene( "shop", sceneOpt);
		end
		Runtime:addEventListener("tap", next);

		--spawn the wall of bricks. can use metatable here to wether there should be a block or not.
		for i=1,6 do
			local x = 0;
			local y = 0;
			for j=1,10 do
				--if metatable entry is not zero then spawn block
				--pass in flag/metatable data to set brick animation sequence based on health of brick
				spawnBlockStyle1(x,y);
				y=y+15
			end
			x=x+15;
			y=0;
		end
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
