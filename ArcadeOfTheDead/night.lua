local composer = require( "composer" );
local widget = require("widget");
local Brick = require("Brick");
local Pistol = require("Pistol");
local Shotgun = require("Shotgun");
local Zombie = require("Zombie");
local physics = require("physics");
local CollisionFilters = require("CollisionFilters");
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
	local heartGroup = display.newGroup();
	local brickSize = 70;
	local ticketNum,ticketText,life;
	--COMMENTED OUT FOR TESTING sceneGroup:insert( params.wall );

	local function newGun (guntype)
		local gun;
		if (guntype == "pistol") then
			gun = Pistol:new();
		end
		if (guntype == "shotgun") then
			gun = Shotgun:new();
		end
		return gun;
	end

	if ( phase == "will" ) then
		physics.start();
		physics.setGravity(0,0);

		-----------Cross over line------------------
		local width = display.contentHeight - (display.contentHeight-180);
		local crossLine = display.newRect( sceneGroup, 0, display.contentHeight-180, display.contentWidth, width );
		crossLine.anchorX=0; crossLine.anchorY=0;
		crossLine.tag="crossLine";
		crossLine:setFillColor(0,0,0,0.1);


		----------Create the player display object group--------
		local playerSeqData = {
	  		{name = "idle", frames={6}}
		}

		local playerSpt = display.newSprite(params.spriteSheet, playerSeqData )
		playerSpt:setSequence( "idle" );

		local gun = newGun("pistol");
		local gunSpt = gun:spawn(params.spriteSheet);

		local heroGuy = display.newGroup( )
		heroGuy.x =   display.contentCenterX;
		heroGuy.y = display.contentHeight-140;
		heroGuy:insert(playerSpt);
		heroGuy:insert(gunSpt);
		sceneGroup:insert( heroGuy );

		heroGuy.anchorY=0;

		----- Shooting -------------------------------
		local cnt = 0;

		local function movePlayer( event )
			heroGuy.x = event.x;
			gun:shoot(heroGuy);
		end
		crossLine:addEventListener("tap", movePlayer);

	elseif ( phase == "did" ) then	
		local function next (event)
			params.ticketNum=ticketNum;
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			Runtime:removeEventListener("tap", next);
			composer.gotoScene( "shop", sceneOpt);
		end
		--Runtime:addEventListener("tap", next);

		local function zombieAttackBrick( event )
			if(event.phase=="began")then
				print("hit");
				transition.cancel( event.target );
				if (event.other.tag == "Brick") then
					event.other.pp:hit();
					local function test()
						local function go( )
					   		moveZombie(event.target);
					   end
						transition.to(event.target, {x=event.target.x, y=event.target.y-1, time=1, onComplete=go} );
					end
					timer.performWithDelay(500,test,1);
				elseif(event.other.tag == "shot") then
					event.target.pp:hit();
					event.other:removeSelf();
					event.other=nil;
					ticketNum = ticketNum + 10;
					ticketText:removeSelf( );
					ticketText = display.newText( sceneGroup, "Tickets: "..ticketNum, 75, 15, native.systemFont, 25 );
				else
					life = life -1;
					display.remove(heartGroup);
					heartGroup = display.newGroup();
					if(life >= 0)then
						showHearts();
					end
					event.target.pp:hit();
				end
			end
		end

		function moveZombie( zombie )
			local hits;
			hits = physics.rayCast( zombie.x, zombie.y, zombie.x, zombie.y+1, "closest" );
			if ( hits) then
			else
			   local function go( )
			   		moveZombie(zombie);
			   end			    
			    test = transition.to( zombie, {time=self.fT, delay=1, y=zombie.y+100, onComplete=go} );
			end
		end

		function spawnZombie( x, y )
			local zombie = Zombie:new({xPos=x, yPos=y});
			zombie:spawn();
			local test = {-30,-50,-30,50,30,50,30,-50};
			physics.addBody( zombie.shape , "dynamic", {filter=CollisionFilters.zombie, shape=test} );
			sceneGroup:insert( zombie.shape );
			zombie.shape:addEventListener( "collision", zombieAttackBrick );				
			moveZombie(zombie.shape);
		end

		function spawnRandomZombie(  )
			local location = math.random(1,10);
			if (location == 1) then
				spawnZombie(10,100);
			elseif(location == 2) then
				spawnZombie(80,100);
			elseif(location == 3) then
				spawnZombie(150,100);
			elseif(location == 4) then
				spawnZombie(220,100);
			elseif(location == 5) then
				spawnZombie(290,100);
			elseif(location == 6) then
				spawnZombie(355,100);
			elseif(location == 7) then
				spawnZombie(430,100);
			elseif(location == 8) then
				spawnZombie(500,100);
			elseif(location == 9) then
				spawnZombie(570,100);
			elseif(location == 10) then
				spawnZombie(640,100);
			end
			
		end

		local totalNumZombies = 10;
		function spawnZombieHorde( )
			spawnRandomZombie();
			totalNumZombies = totalNumZombies -1;
			if(totalNumZombies >0)then
				timer.performWithDelay(1000, spawnZombieHorde,1);
			end
		end
		
		spawnZombieHorde()

		---------Status Bar ----------------
		local statusBar = display.newRect( sceneGroup, 0, 0, display.contentWidth, 35 );
		statusBar.anchorX=0; statusBar.anchorY=0;
		statusBar:setFillColor( 0,0,1,0.35 );
		statusBar:toFront( );

		-------Tickets----------------------
		ticketNum=0;
		ticketText = display.newText( sceneGroup, "Tickets: "..ticketNum, 75, 15, native.systemFont, 25 );

		--------Life Total-----------------
		life = 3;
		function showHearts(  )
			local heartX = display.contentWidth-30;
			local heart;
			for i=1,life do
				heart = display.newRect(sceneGroup, heartX, 7,25,25);
				heart.anchorX=0; heart.anchorY=0;
				heart:setFillColor(1,0,0,0.75);
				heartX = heartX - 30;
				heartGroup:insert(heart);
			end
		end		
		showHearts();

		--------Level-----------------------
		local level = display.newText(sceneGroup,"Level: "..params.level,display.contentCenterX,15,native.systemFont, 25);
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;