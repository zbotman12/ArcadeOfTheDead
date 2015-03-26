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
	--COMMENTED OUT FOR TESTING sceneGroup:insert( params.wall );

	if ( phase == "will" ) then
		physics.start();
		physics.setGravity(0,0);
		local text = display.newText( sceneGroup, "night scene", display.contentCenterX, display.contentCenterY, native.systemFont, 25 );

		-----------Cross over line------------------
		local width = display.contentHeight - (display.contentHeight-180);
		local crossLine = display.newRect( sceneGroup, 0, display.contentHeight-180, display.contentWidth, width );
		crossLine.anchorX=0; crossLine.anchorY=0;
		crossLine:setFillColor(0,0,0,0.1);


		----------Create the player display object group--------
		local playerSeqData = {
	  		{name = "idle", frames={6}}
		}

		local pistolSeqData = {
	  		{name = "idle", frames={7}},
	  		{name = "shoot", start=7, count= 9, time = 200}
		}

		local playerSpt = display.newSprite(params.spriteSheet, playerSeqData )
		playerSpt:setSequence( "idle" );

		local pistolSpt = display.newSprite(params.spriteSheet, pistolSeqData )
		pistolSpt.x =  pistolSpt.x  + 35;
		pistolSpt:setSequence( "idle" );

		local heroGuy = display.newGroup( )
		heroGuy.x =   display.contentCenterX;
		heroGuy.y = display.contentHeight-140;
		heroGuy:insert(playerSpt);
		heroGuy:insert(pistolSpt);
		sceneGroup:insert( heroGuy );

		heroGuy.anchorY=0;

		----- Shooting -------------------------------
		local cnt = 0;

		local function movePlayer( event )
			heroGuy.x = event.x;
			local bullet = display.newCircle (heroGuy.x + 30, heroGuy.y-16, 5);
			bullet.anchorY = 1;
			bullet:setFillColor(0,1,0);
			pistolSpt:setSequence( "shoot" );
			pistolSpt:play( );
			timer.performWithDelay( 200, function () pistolSpt:setSequence( "idle" ); pistolSpt:play( ); end )
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