local composer = require( "composer" );
local widget = require("widget");
local Brick = require("Brick");
local Zombie = require("Zombie");
local physics = require("physics");
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
	local wall = display.newGroup();
	local brickSize = 70;

	if ( phase == "will" ) then
		physics.start();
		physics.setGravity(0,0);
		local text = display.newText( sceneGroup, "night scene", display.contentCenterX, display.contentCenterY, native.systemFont, 25 );

		function spawnZombie( x, y )
			local zombie = Zombie:new({xPos=x, yPos=y});
			zombie:spawn();
			zombie:move();
			zombie:addPhysics();
		end


		function spawnBrickStyle1( x, y )
			local brick1 = Brick:new({xPos=x, yPos=y} );
			brick1:spawn();						
			--add physics collision thing here for zombies
			brick1:addPhysics();
			local function zombieDamage( event )
				brick1:hit();
				if (event.other.tag == "Zombie") then
					event.other.pp:stop();
					timer.performWithDelay( 1000, 
						function () brick1:hit(); end );
					timer.performWithDelay( 1500, 
						function () event.other.pp:movePerBlock(); end );					
				end
			end
			brick1.shape:addEventListener("collision", zombieDamage);
			--wall:insert(brick1.shape);
		end

		function spawnWall(  )
			local x = 5;
			local y = display.contentHeight-180;
			--spawn the wall of bricks. can use metatable here to wether there should be a block or not.
			for i=1,10 do
				for j=1,5 do
					--if metatable entry is not zero then spawn block
					--pass in flag/metatable data to set brick animation sequence based on health of brick
					spawnBrickStyle1(x,y);
					y=y-brickSize;
				end
				x=x+brickSize+1;
				y=display.contentHeight-180;
			end
		end

		spawnWall();
		spawnZombie(5,0);

		-----------Cross over line------------------
		local width = display.contentHeight - (display.contentHeight-180);
		local crossLine = display.newRect( sceneGroup, 0, display.contentHeight-180, display.contentWidth, width );
		crossLine.anchorX=0; crossLine.anchorY=0;
		crossLine:setFillColor(0,0,0,0.1);

	elseif ( phase == "did" ) then	
		local function next (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			Runtime:removeEventListener("tap", next);
			composer.gotoScene( "shop", sceneOpt);
		end
		--Runtime:addEventListener("tap", next);
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;