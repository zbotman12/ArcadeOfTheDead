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

		----------WALL -------------------------
		function spawnBrickStyle1( x, y )
			local brick1 = Brick:new({xPos=x, yPos=y} );
			brick1:spawn();						
			--add physics collision thing here for zombies
			brick1:addPhysics();
			local function zombieDamage( event )
				if (event.other.tag == "Zombie") then
					brick1:hit();
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

		-----------Cross over line------------------
		local width = display.contentHeight - (display.contentHeight-180);
		local crossLine = display.newRect( sceneGroup, 0, display.contentHeight-180, display.contentWidth, width );
		crossLine.anchorX=0; crossLine.anchorY=0;
		crossLine:setFillColor(0,0,0,0.1);

		local heroGuy = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight-140, brickSize, 100 );
		heroGuy.anchorY=0;

		----- Shooting -------------------------------
		local cnt = 0;

		local function movePlayer( event )
			heroGuy.x = event.x;
			local bullet = display.newCircle (heroGuy.x, heroGuy.y-16, 5);
			bullet.anchorY = 1;
			bullet:setFillColor(0,1,0);
			physics.addBody (bullet, "dynamic", {radius=5} );
			--bullet.isSensor = true;
			bullet.isBullet =true;
			bullet:applyForce(0, -2, bullet.x, bullet.y);
			--audio.play( soundTable["shootSound"] );

			bullet.tag = "shot";

			local function bulletHandler (event)
				-- remove the bullet
				bullet:removeSelf();
				bullet=nil;
				if (event.other.tag == "Zombie") then
					event.other.pp:hit();
				end
			end
			bullet:addEventListener("collision", bulletHandler);
		end

		crossLine:addEventListener("tap", movePlayer);


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

		function spawnZombie( x, y )
			local zombie = Zombie:new({xPos=x, yPos=y});
			zombie:spawn();			
			--zombie:move();
			zombie:addPhysics();
			sceneGroup:insert( zombie.shape );
		end

		spawnZombie(5,100);

		---------Status Bar ----------------
		local statusBar = display.newRect( sceneGroup, 0, 0, display.contentWidth, 35 );
		statusBar.anchorX=0; statusBar.anchorY=0;
		statusBar:setFillColor( 0,0,1,0.35 );
		statusBar:toFront( );
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;