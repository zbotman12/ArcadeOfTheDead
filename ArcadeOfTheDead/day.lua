local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;

local brickSize = 70;

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

	function spawnBrickStyle1( x, y )
		local seqData = {
		    {name = "full", frames={1}},
		    {name = "twothirds", frames={2}},
		    {name = "onethird", frames={3}},
		}
		--local brick1 = display.newSprite (params.brickSheet, seqData);
		local brick1 = display.newRect( wall, x, y, brickSize, brickSize );
		brick1:setFillColor( math.random( ), math.random(  ),math.random(  ) );
		wall:insert(brick1);
		brick1.anchorX = 0; brick1.anchorY = 60;
		--brick1.x = x; brick1.y = y;	
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
			composer.gotoScene( "night", sceneOpt);
		end
		Runtime:addEventListener("tap", next);

		local x = 10;
		local y = display.contentHeight-180;
		--spawn the wall of bricks. can use metatable here to wether there should be a block or not.
		for i=1,10 do
			for j=1,5 do
				--if metatable entry is not zero then spawn block
				--pass in flag/metatable data to set brick animation sequence based on health of brick
				spawnBrickStyle1(x,y);
				y=y-brickSize;
			end
			x=x+brickSize;
			y=display.contentHeight-180;
		end

		local crossLine = display.newRect( sceneGroup, 0, display.contentHeight-180, display.contentWidth, 2 );
		crossLine.anchorX=0; crossLine.anchorY=0;
		local heroGuy = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight-140, brickSize, 100 );
		heroGuy.anchorX=0; heroGuy.anchorY=0;
		local zombie = display.newRect( sceneGroup, display.contentCenterX, 140, brickSize, 100 );
		zombie:setFillColor( 1,0,0 );
		zombie.anchorY=0; zombie.anchorX = 0;
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
