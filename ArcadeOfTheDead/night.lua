----------NIGHT SCENE----------------
if "Win" == system.getInfo( "platformName" ) then
    BlockFont = "3D Thirteen Pixel Fonts";
    CompFont = "Computer Pixel-7";
elseif "Android" == system.getInfo( "platformName" ) then
    BlockFont = "3D-Thirteen-Pixel-Fonts"
    CompFont = "computer_pixel-7"
end

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
	local bg = display.newImage ("images/NightBG.png");
	bg.anchorX=0; bg.anchorY=0;
    bg:toBack();
    sceneGroup:insert( bg );
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;
	local wall = display.newGroup();
	local heartGroup = display.newGroup();
	local brickSize = 70;
	local zombiesPlayerKilled=0;
	local ticketNum,ticketText,life,zombiesToKill,crossLine,gun;
	

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
		--begin music as scene loads 
		--local bgNight = audio.loadStream("sounds/night.mp3")
		--sceneGroup:insert(bgNight)
		--audio.setMaxVolume(0.045, {channel = 1})
		--local backGroundChan = audio.play(bgNight, {channel = 1, loops = -1, fadein = 500})

	elseif ( phase == "did" ) then	
		physics.start();
		physics.setGravity(0,0);
		--physics.setDrawMode( "hybrid" );
		if(params.wall~=nil)then
			sceneGroup:insert(params.wall);	
		end

		-----------Cross over line------------------
		local width = display.contentHeight - (display.contentHeight-180);
		crossLine = display.newRect( sceneGroup, 0, 1050, display.contentWidth, 5 );
		crossLine.anchorX=0; crossLine.anchorY=0;
		physics.addBody( crossLine, "static", {filters=CollisionFilters.crossLine} );
		crossLine:setFillColor( 0,0,0,0.1 );

		----------Create the player display object group--------
		local heroGuy = display.newGroup( );
		if(params.hero==nil) then
			print( "in default" );
			local playerSeqData = {
		  		{name = "idle", frames={6}}
			};
			local playerSpt = display.newSprite(params.spriteSheet, playerSeqData );
			playerSpt:setSequence( "idle" );
			gun = newGun("pistol");
			local gunSpt = gun:spawn(params.spriteSheet);
			heroGuy:insert(playerSpt);
			heroGuy:insert(gunSpt);
			sceneGroup:insert( heroGuy );
		else
			print( params.hero );
			heroGuy=params.hero;
			sceneGroup:insert( heroGuy );
		end		
		heroGuy.x = display.contentCenterX;
		heroGuy.y = display.contentHeight-140;
		heroGuy.anchorY=0;

		local function movePlayer( event )
			heroGuy.x = event.x;
			gun:shoot(heroGuy);
		end
		Runtime:addEventListener("tap", movePlayer);

		--------Level-----------------------
		local level = display.newText(sceneGroup,"Level: "..params.level,display.contentCenterX,15,CompFont, 50);
		level:setFillColor( 1,1,1,.75 );

		local function zombieAttackBrick( event )
			if(event.phase=="began")then
				transition.cancel( event.target );
				if (event.other.tag == "Brick") then
					event.other.pp:hit();
					local function test()
						local function go( )
					   		moveZombie(event.target);
					   end
					   if(event.target.y~=nil)then
							transition.to(event.target, {x=event.target.x, y=event.target.y-1, time=1, onComplete=go} );
						end
					end
					timer.performWithDelay(500,test,1);
				elseif(event.other.tag == "shot") then
					event.target.pp:hit();
					event.other:removeSelf();
					event.other=nil;
					ticketNum = ticketNum + 10;
					ticketText:removeSelf( );
					ticketText = display.newText( sceneGroup, "Tickets: "..ticketNum, 100, 15, CompFont, 50 );
					ticketText:setFillColor( 1,1,1,.75 );
					zombiesPlayerKilled = zombiesPlayerKilled + 1;
					if(zombiesToKill == zombiesPlayerKilled) then						
						local function goToShop (event)							
							Runtime:removeEventListener( "tap", movePlayer );
							display.remove( heartGroup );							
							physics.removeBody( crossLine );
							display.remove( crossLine );
							display.remove( ticketText );
							display.remove( level );
							display.remove( heroGuy );
							params.ticketNum=ticketNum;
							params.life=life;
							local sceneOpt = {
								effect = "fade",
								time = 800,
								params = params
							}
							timer.performWithDelay( 500, 
								function () composer.gotoScene( "shop", sceneOpt);	end,1 );							
						end
						goToShop();
					end
				else --crossline
					life = life -1;
					display.remove(heartGroup);
					heartGroup = display.newGroup();
					if(life > 0)then
						showHearts();
					else
						gameOver();
					end
					event.target.pp:hit();
				end
			end
		end
		--handler for the game ending
		function gameOver (event)	
			Runtime:removeEventListener( "tap", movePlayer );
			display.remove( heartGroup );							
			physics.removeBody( crossLine );
			display.remove( crossLine );
			display.remove( ticketText );
			display.remove( level );
			display.remove( heroGuy );
			params.ticketNum=ticketNum;
			params.life=life;
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(bgNight)
			composer.gotoScene( "GameOver", sceneOpt);
		end	
		--make the zmobie move
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
		--make a new zmobie 
		function spawnZombie( x, y )
			local zombie = Zombie:new({xPos=x, yPos=y});
			zombie:spawn(params.spriteSheet);
			local test = {-30,-50,-30,50,30,50,30,-50};
			physics.addBody( zombie.shape , "dynamic", {filter=CollisionFilters.zombie, shape=test} );
			sceneGroup:insert( zombie.shape );
			zombie.shape:addEventListener( "collision", zombieAttackBrick );				
			moveZombie(zombie.shape);
		end
		--put random zombie into play
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

		local totalNumZombies = 1;
		zombiesToKill = 1;
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
		statusBar:setFillColor( 0.5,0.5,.5,0.35 );
		statusBar:toFront( );

		-------Tickets----------------------
		if(params.ticketNum==nil)then
			ticketNum=0;
		else
			ticketNum=params.ticketNum;
		end

		local ticketData={{name = "ticket", frames={58}}};
		local ticketImg = display.newSprite( params.spriteSheet, ticketData );
		ticketImg.x=10; ticketImg.y=5;
		ticketImg.anchorX=0; ticketImg.anchorY=0;
		sceneGroup:insert( ticketImg );
		ticketText = display.newText( sceneGroup, ticketNum, 100, 17, CompFont, 50 );
		ticketText:setFillColor( 1,1,1,.75 );

		--------Life Total-----------------
		life = 3;
		function showHearts(  )
			local heartX = display.contentWidth-30;
			local heart;
			for i=1,life do
				--heart = display.newRect(sceneGroup, heartX, 7,25,25);
				local heartData={{name = "heart", frames={27}}};
				heart = display.newSprite( params.spriteSheet, heartData )
				heart.x=heartX; heart.y=7;
				heart.anchorX=0; heart.anchorY=0;				
				heartX = heartX - 30;
				heartGroup:insert(heart);
			end
		end		
		showHearts();

	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
