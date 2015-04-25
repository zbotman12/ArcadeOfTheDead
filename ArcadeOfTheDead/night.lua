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
local RayGun = require( "RayGun" );
local Zombie = require("Zombie");
local physics = require("physics");
local CollisionFilters = require("CollisionFilters");
local scene = composer.newScene();
local params,gun, shootTimer;
local zombieTable={};
local orphans={};
local ticketImg;

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
	local heartGroup = display.newGroup();
	local brickSize = 70;
	local zombiesKilled=0;
	local ticketNum,ticketText,life,zombiesToKill,crossLine,gun;
	table.insert( orphans, ticketText );
	local removingStuff=false;
	--local wall=display.newGroup();

	function newGun (gunType)
		local gun;
		if (gunType == "pistol") then
			gun = Pistol:new();
		elseif(gunType == "shotgun") then
				gun = Shotgun:new();
		elseif(gunType == "RayGun") then
			gun = RayGun:new();
		end
		return gun;
	end

	if ( phase == "will" ) then
		--begin music as scene loads 
		local bgNight = audio.loadStream("sounds/night.mp3");
		audio.setMaxVolume(0.1, {channel = 1});
		local backGroundChan = audio.play(bgNight, {channel = 1, loops = -1, fadein = 500});

	elseif ( phase == "did" ) then	
		physics.start();
		physics.setGravity(0,0);
		physics.setDrawMode( "hybrid" );
		if(params.wall~=nil)then			
			sceneGroup:insert(params.wall);
		end

		-----------Cross over line------------------
		local width = display.contentHeight - (display.contentHeight-180);
		crossLine = display.newRect( sceneGroup, 0, 1050, display.contentWidth, 5 ); 
		table.insert( orphans, crossline );
		crossLine.anchorX=0; crossLine.anchorY=0;
		physics.addBody( crossLine, "static", {filters=CollisionFilters.crossLine} );
		crossLine:setFillColor( 0,0,0,0.1 );

		----------Create the player display object group--------
		local heroGuy = display.newGroup( )
		local playerSeqData;
		if(params.hero==nil) then
			playerSeqData = {
		  		{name = "idle", frames={6}}
			};					
		elseif(params.hero=="MegaMan")then
			playerSeqData = {
		  		{name = "idle", frames={28}}
			};
		elseif(params.hero=="Kirby")then
			playerSeqData = {
		  		{name = "idle", frames={29}}
			};
		elseif(params.hero=="Link")then
			playerSeqData = {
		  		{name = "idle", frames={30}}
			};
		elseif(params.hero=="Mario")then
			playerSeqData = {
		  		{name = "idle", frames={70}}
			};
		end		
		local playerSpt = display.newSprite(params.spriteSheet, playerSeqData ); table.insert( orphans, playerSpt );
		playerSpt:setSequence( "idle" );
		local gunType=params.gunType;
		local gun = newGun(gunType);
		local gunSpt = gun:spawn(params.spriteSheet,params.hero); table.insert( orphans, gunSpt );
		heroGuy:insert(playerSpt);
		heroGuy:insert(gunSpt);
		heroGuy.x = display.contentCenterX;
		heroGuy.y = display.contentHeight-140;
		sceneGroup:insert( heroGuy );
		heroGuy.anchorY=0;

		local function movePlayer( event )			
			heroGuy.x = event.x;
				gun:shoot(heroGuy);
		end

		function reloadGun(event)
			if (event.isShake) then
				gun:reload()
			end
		end
		--handler for the game ending
		function gameOver (event)	
			removeStuff();
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(bgNight)
			composer.gotoScene( "GameOver", sceneOpt);
		end	
			Runtime:addEventListener("tap", movePlayer);

		Runtime:addEventListener( "accelerometer", reloadGun);

		--------Level-----------------------
		local level = display.newText(sceneGroup,"Level: "..params.level,display.contentCenterX,15,CompFont, 50); table.insert( orphans, level );
		level:setFillColor( 1,1,1,.75 );

		local function checkZombieCount(  )
			if(zombiesToKill == zombiesKilled) then						
				local function goToShop (event)							
					removeStuff(false);					
					params.newGame=false;
					local sceneOpt = {
						effect = "fade",
						time = 800,
						params = params
					}
					--composer.gotoScene( "shop", sceneOpt);							
					audio.stop(1)
					timer.performWithDelay( 500, 
						function () composer.gotoScene( "shop", sceneOpt);	end,1 );							
				end
				timer.performWithDelay(500, goToShop);
			end
		end

		local function zombieAttackBrick( event )
			if(event.phase=="began")then
				if(removingStuff==false)then
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
						zombiesKilled = zombiesKilled + 1;
						event.target.pp:hit();
						if(event.other ~= nil) then
							event.other.tag = "-";
							event.other:removeSelf();
							event.other=nil;
						end

						ticketNum = ticketNum + 10;
						display.remove(ticketText);
						ticketText = display.newText( sceneGroup, ticketNum, 150, 17, CompFont, 50 );
						ticketText:setFillColor( 1,1,1,.75 );
						checkZombieCount();
					else --crossline
						life = life -1;											
						zombiesKilled = zombiesKilled + 1;
						display.remove(heartGroup);
						heartGroup = display.newGroup();
						if(life > 0)then
							showHearts();
							checkZombieCount();
						else
							local scream = audio.loadSound("sounds/scream.mp3")
							audio.play(scream, {channel = 17})
							audio.setMaxVolume(0.20, {channel = 17})
							gameOver();
						end
						event.target.pp:hit();
					end
				end
			end
		end

		--handler for the game ending
		function gameOver (event)	
			removeStuff(true);
			params.newGame=true;
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(17)
			audio.stop(1)
			local function go(  )
				composer.gotoScene( "GameOver", sceneOpt);
			end
			timer.performWithDelay(100, go, 1);
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

		-----------SPAWN ZOMBIES-------------------
		local i = 0;
		function spawnZombie( x, y )
			i = i + 1;
			zombieTable[i] = Zombie:new({xPos=x, yPos=y});
			zombieTable[i]:spawn(params.spriteSheet);
			local test = {-30,-50,-30,50,30,50,30,-50};
			physics.addBody( zombieTable[i].shape , "dynamic", {filter=CollisionFilters.zombie, shape=test} );
			sceneGroup:insert( zombieTable[i].shape );
			zombieTable[i].shape:addEventListener( "collision", zombieAttackBrick );				
			moveZombie(zombieTable[i].shape);
		end
		--put random zombie into play
		function spawnRandomZombie(  )
			spawnZombie((math.random(0,9) * 70) + 10,100) ;
		end

		local totalNumZombies = params.level * math.random(5, 10);
		zombiesToKill = totalNumZombies;
		function spawnZombieHorde( )
			spawnRandomZombie();
			totalNumZombies = totalNumZombies -1;
			if(totalNumZombies >0)then
				timer.performWithDelay(1000, spawnZombieHorde,1);
			end
		end
		
		spawnZombieHorde();

		---------Status Bar ----------------
		local statusBar = display.newRect( sceneGroup, 0, 0, display.contentWidth, 35 ); table.insert( orphans, statusBar );
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
		ticketImg = display.newSprite( params.spriteSheet, ticketData ); table.insert( orphans, ticketImg );
		ticketImg.x=10; ticketImg.y=5;
		ticketImg.anchorX=0; ticketImg.anchorY=0;
		sceneGroup:insert( ticketImg );
		ticketText = display.newText( sceneGroup, ticketNum, 150, 17, CompFont, 50 );
		ticketText:setFillColor( 1,1,1,.75 );

		--------Life Total-----------------
		life = 3;
		function showHearts(  )
			local heartX = display.contentWidth-30;
			for i=1,life do
				local heartData={{name = "heart", frames={27}}};
				local heart = display.newSprite( params.spriteSheet, heartData ); table.insert(orphans, heart);
				heart.x=heartX; heart.y=7;
				heart.anchorX=0; heart.anchorY=0;				
				heartX = heartX - 30;
				heartGroup:insert(heart);
			end
		end		
		showHearts();

		function removeStuff( isGameOver )
			removingStuff=true;
				Runtime:removeEventListener("tap", movePlayer);
			Runtime:removeEventListener(accelerometer, reloadGun);
			for i, v in ipairs(orphans) do
				if(orphans[i] ~= nil) then
					--print(orphans[i]);
					transition.cancel( orphans[i] );
					display.remove(orphans[i]);					
				end
			end		
			for i = 1, #zombieTable do
				zombieTable[i]:hit();
			end						
			--remove groups		
			display.remove( heroGuy );
			display.remove( heartGroup );
			display.remove( crossLine );
			display.remove( ticketImg );
			display.remove( ticketText );
			if(isGameOver==true)then
				for i=1,params.wall.numChildren do
					local child=params.wall[i];
					for j=1,child.numChildren do
						local brick=child[j];
						display.remove( brick );
					end
				end
				display.remove( params.wall );
			end
			params.ticketNum=ticketNum;
			params.life=life;
		end

	end
end

--scene:hide
function scene:hide(event)
	
end
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
