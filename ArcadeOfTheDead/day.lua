local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local Brick = require("Brick");
local Pistol = require("Pistol");
local Shotgun = require("Shotgun");
local RayGun = require( "RayGun" );
local physics = require("physics");
local CollisionFilters = require("CollisionFilters");
local currentBlock=nil;
local params;
local crossLine;
local topCrossLine;
local sidebarRight;
local sidebarLeft;
local leftArrow;
local rightArrow, swapBtn, swapData;
local orphans={};

--scene:create
function scene:create( event )
	local sceneGroup = self.view;
	params = event.params;

	local bg = display.newImage ("images/DayBG.png");
	bg.anchorX=0; bg.anchorY=0;
    bg:toBack();
    sceneGroup:insert( bg );
    --print(display.contentWidth," x ", display.contentHeight);
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;
	local brickSize = 70;	
	local shiftNum = 0;	
	local swappedOut=false;	
	local switchingScenes=false;
	if(params.newGame==false)then
		sceneGroup:insert(params.wall);	
	else
		params.wall=display.newGroup( );
	end

	if ( phase == "will" ) then	
		--background music

		local bgDay = audio.loadStream("sounds/tetris.mp3")
		audio.setMaxVolume(.15, {channel = 1})
		local backGroundChan = audio.play(bgDay, {channel = 1, loops = -1, fadein = 500})

		physics.start();
		physics.setGravity(0,0);
		physics.setDrawMode( "hybrid" );
		
		--make a brick
		function spawnBrick( x, y, group )
			local brick = Brick:new({xPos=x, yPos=y} );
			brick:spawn(params.spriteSheet);		
			group:insert(brick.shape);
		end

		--------SPAWN BLOCKS------------------
		function spawnBlock( blockNum )
			local y=0;
			if (blockNum == 1)then
				local block1 = display.newGroup( );
				block1.anchorChildren=true;
				local x = 10;
				for i=1,4 do
					spawnBrick(x,y,block1);
					x=x+brickSize;
				end
				block1.anchorX=0;block1.anchorY=0;
				block1.x=10;
				sceneGroup:insert( block1 );
				return block1;
			elseif (blockNum == 2)then
				local block2 = display.newGroup( );
				block2.anchorChildren=true;
				local x=10;				
				for i=1,2 do
					for j=1,2 do
						spawnBrick(x,y,block2);
						y=y+brickSize;
					end
					x=x+brickSize;
					y=0;
				end
				block2.anchorX=0;block2.anchorY=0;
				block2.x=10;
				sceneGroup:insert( block2 );
				return block2;
			elseif (blockNum == 3) then
				local block3 = display.newGroup( );
				block3.anchorChildren=true;
				local x=10;
				spawnBrick(x,y, block3);
				y=y+brickSize;
				for i=1,3 do
					spawnBrick(x,y, block3);
					x=x+brickSize;
				end
				block3.anchorX=0;block3.anchorY=0;
				block3.x=10;
				sceneGroup:insert( block3 );
				return block3;
			elseif (blockNum == 4) then
				local block4 = display.newGroup( );
				block4.anchorChildren=true;
				local x=150;
				spawnBrick(x,y,block4);
				y=y+brickSize;
				x=10;
				for i=1,3 do
					spawnBrick(x,y,block4);
					x=x+brickSize;
				end
				block4.anchorX=0;block4.anchorY=0;
				block4.x=10;
				sceneGroup:insert( block4 );
				return block4;
			elseif (blockNum == 5) then
				local block5 = display.newGroup( );
				block5.anchorChildren=true;
				local x=80;
				spawnBrick(x,y,block5);
				y=y+brickSize;
				x=10;
				for i=1,3 do
					spawnBrick(x,y,block5);
					x=x+brickSize;
				end
				block5.anchorX=0;block5.anchorY=0;
				block5.x=10;
				sceneGroup:insert( block5 );
				return block5;
			elseif (blockNum == 6) then
				local block6 = display.newGroup();
				block6.anchorChildren=true;
				local x = 80;
				for i=1,2 do
					spawnBrick(x,y,block6);
					x=x+brickSize;
				end
				y=y+brickSize;
				x=10;
				for i=1,2 do
					spawnBrick(x,y,block6);
					x=x+brickSize;
				end
				block6.anchorX=0;block6.anchorY=0;
				block6.x=10;
				sceneGroup:insert( block6 );
				return block6;
			elseif (blockNum == 7) then
				local block7 = display.newGroup();
				block7.anchorChildren=true;
				local x = 10;
				for i=1,2 do
					spawnBrick(x,y,block7);
					x=x+brickSize;
				end
				y=y+brickSize;
				x=80;
				for i=1,2 do
					spawnBrick(x,y,block7);
					x=x+brickSize;
				end
				block7.anchorX=0;block7.anchorY=0;
				block7.x=10;
				sceneGroup:insert( block7 );
				return block7;
			elseif (blockNum == 8)then
				local block8 = display.newGroup( );
				block8.anchorChildren=true;
				local x = 10;
				spawnBrick(x,y,block8);
				block8.anchorX=0;block8.anchorY=0;
				block8.x=10;
				sceneGroup:insert( block8 );
				return block8;
			elseif(blockNum == 9) then
				local block9 = display.newGroup( );
				block9.anchorChildren=true;
				local x = 10;
				spawnBrick(x,y,block9);
				y=y+brickSize;
				spawnBrick(x,y,block9);
				block9.anchorX=0;block9.anchorY=0;
				block9.x=10;
				sceneGroup:insert( block9 );
				return block9;
			end
		end

		-----------Cross over line------------------
		local height = display.contentHeight - (display.contentHeight-180);
		crossLine = display.newRect( sceneGroup, 0, 1050, display.contentWidth, 5 ); 
		table.insert( orphans, crossline );
		crossLine.anchorX=0; crossLine.anchorY=0;
		physics.addBody( crossLine, "static", {filters=CollisionFilters.crossLine} );
		crossLine:setFillColor( 0,0,0,0.1 );

		------------WALL HEIGHT LIMIT----------------
		topCrossLine = display.newRect( sceneGroup, 0, display.contentCenterX, display.contentWidth, 5 );
		table.insert( orphans, topCrossLine );
		topCrossLine.anchorX=0; topCrossLine.anchorY=0;
		--physics.addBody( topCrossLine, "static", {filters=CollisionFilters.crossline} );
		topCrossLine:setFillColor( 0,0,0,0.1 );

		-----------Side Bar Right--------------------
		sidebarRight = display.newRect(sceneGroup, display.contentWidth-5, 0, 5, display.contentHeight); 
		table.insert( orphans, sidebarRight );
		sidebarRight.anchorX=0; sidebarRight.anchorY=0;
		physics.addBody( sidebarRight, "static" );
		sidebarRight:setFillColor( 0,0,0,0.1 );

		-----------Side Bar Left--------------------
		sidebarLeft = display.newRect(sceneGroup, 0, 0, 5, display.contentHeight); 
		table.insert( orphans, sidebarLeft );
		sidebarLeft.anchorX=0; sidebarLeft.anchorY=0;
		physics.addBody( sidebarLeft, "static" );
		sidebarLeft:setFillColor( 0,0,0,0.1 );

		----------LEFT ARROW---------------------
		leftArrow = display.newSprite( params.spriteSheet, {{name = "leftarrow", frames={17}}} ); 
		table.insert( orphans, leftArrow );
		leftArrow.anchorX=0; leftArrow.anchorY=0;
		leftArrow.x = 0; leftArrow.y = display.contentHeight-180;
		leftArrow:scale( 0.75, 0.75 );
		leftArrow.alpha=.7;
		sceneGroup:insert( leftArrow );
		leftArrow:setSequence( "leftarrow" );

		----------RIGHT ARROW---------------------
		rightArrow = display.newSprite( params.spriteSheet, {{name = "rightarrow", frames={18}}} ); 
		table.insert( orphans, rightArrow );
		rightArrow.anchorX=0; rightArrow.anchorY=0;
		rightArrow.x = display.contentWidth-150;
		rightArrow.y = display.contentHeight-180;
		rightArrow:scale( 0.75, 0.75 );
		rightArrow.alpha=.7;
		sceneGroup:insert( rightArrow );
		rightArrow:setSequence( "rightArrow" );

		----------MOVE BLOCK LEFT----------------------
		function moveBlockLeft( event )
			if event.phase == "began" then
				if(switchingScenes==false)then
					local hit;
					if(currentBlock.num==1)then
						hit=physics.rayCast( currentBlock.x, currentBlock.y+70, currentBlock.x-10, currentBlock.y+70, "closest" );
					elseif(currentBlock.num==2)then
						hit=physics.rayCast( currentBlock.x, currentBlock.y+70, currentBlock.x-10, currentBlock.y+70, "closest" );
						hit=physics.rayCast( currentBlock.x, currentBlock.y+140, currentBlock.x-10, currentBlock.y+140, "closest" );
					elseif(currentBlock.num==3)then
						hit=physics.rayCast( currentBlock.x, currentBlock.y+70, currentBlock.x-10, currentBlock.y+70, "closest" );
						hit=physics.rayCast( currentBlock.x, currentBlock.y+140, currentBlock.x-10, currentBlock.y+140, "closest" );
					elseif(currentBlock.num==4)then
						hit=physics.rayCast( currentBlock.x+140, currentBlock.y, currentBlock.x+130, currentBlock.y, "closest" );
						hit=physics.rayCast( currentBlock.x, currentBlock.y+140, currentBlock.x-10, currentBlock.y+140, "closest" );
					elseif(currentBlock.num==5)then
						hit=physics.rayCast( currentBlock.x+70, currentBlock.y, currentBlock.x+60, currentBlock.y, "closest" );
						hit=physics.rayCast( currentBlock.x, currentBlock.y+140, currentBlock.x-10, currentBlock.y+140, "closest" );
					elseif(currentBlock.num==6)then
						hit=physics.rayCast( currentBlock.x+70, currentBlock.y, currentBlock.x+60, currentBlock.y, "closest" );
						hit=physics.rayCast( currentBlock.x, currentBlock.y+140, currentBlock.x-10, currentBlock.y+140, "closest" );
					elseif(currentBlock.num==7)then
						hit=physics.rayCast( currentBlock.x, currentBlock.y+70, currentBlock.x-10, currentBlock.y+70, "closest" );
						hit=physics.rayCast( currentBlock.x+70, currentBlock.y+140, currentBlock.x+60, currentBlock.y+140, "closest" );
					elseif(currentBlock.num==8)then
						hit=physics.rayCast( currentBlock.x, currentBlock.y+70, currentBlock.x-10, currentBlock.y+70, "closest" );
					elseif(currentBlock.num==9)then
						hit=physics.rayCast( currentBlock.x, currentBlock.y+70, currentBlock.x-10, currentBlock.y+70, "closest" );
						hit=physics.rayCast( currentBlock.x, currentBlock.y+140, currentBlock.x-10, currentBlock.y+140, "closest" );
					end
					if(hit)then
						--stays in place
						currentBlock.x=currentBlock.x;
					else
						--moves left 70 px
						currentBlock.x=currentBlock.x-70;
						for i=1,currentBlock.numChildren do
							local child=currentBlock[i];
							child.x = child.x-70;
						end
					end
				end
			end
		end

		-----------MOVE BLOCK RIGHT----------------
		function moveBlockRight( event )
			if event.phase == "began" then
				if(switchingScenes==false)then
					local hit;
					if(currentBlock.num==1)then
						hit=physics.rayCast(currentBlock.x,currentBlock.y+70,currentBlock.x+290,currentBlock.y+70,"closest");
					elseif(currentBlock.num==2)then
						hit=physics.rayCast(currentBlock.x,currentBlock.y+70,currentBlock.x+150,currentBlock.y+70,"closest");
						hit=physics.rayCast(currentBlock.x,currentBlock.y+140,currentBlock.x+150,currentBlock.y+140,"closest");
					elseif(currentBlock.num==3)then
						hit=physics.rayCast(currentBlock.x,currentBlock.y+70,currentBlock.x+80,currentBlock.y+70,"closest");
						hit=physics.rayCast(currentBlock.x,currentBlock.y+140,currentBlock.x+220,currentBlock.y+140,"closest");
					elseif(currentBlock.num==4)then
						hit=physics.rayCast(currentBlock.x+210,currentBlock.y+70,currentBlock.x+220,currentBlock.y+70,"closest");
						hit=physics.rayCast(currentBlock.x,currentBlock.y+140,currentBlock.x+220,currentBlock.y+140,"closest");
					elseif(currentBlock.num==5)then
						hit=physics.rayCast(currentBlock.x+140,currentBlock.y+70,currentBlock.x+150,currentBlock.y+70,"closest");
						hit=physics.rayCast(currentBlock.x,currentBlock.y+140,currentBlock.x+220,currentBlock.y+140,"closest");
					elseif(currentBlock.num==6)then
						hit=physics.rayCast(currentBlock.x,currentBlock.y+70,currentBlock.x+220,currentBlock.y+70,"closest");
						hit=physics.rayCast(currentBlock.x,currentBlock.y+140,currentBlock.x+150,currentBlock.y+140,"closest");
					elseif(currentBlock.num==7)then
						hit=physics.rayCast(currentBlock.x+140,currentBlock.y+70,currentBlock.x+150,currentBlock.y+70,"closest");
						hit=physics.rayCast(currentBlock.x,currentBlock.y+140,currentBlock.x+220,currentBlock.y+140,"closest");
					elseif(currentBlock.num==8)then
						hit=physics.rayCast(currentBlock.x,currentBlock.y+70,currentBlock.x+80,currentBlock.y+70,"closest");
					elseif(currentBlock.num==9)then
						hit=physics.rayCast(currentBlock.x,currentBlock.y+70,currentBlock.x+80,currentBlock.y+70,"closest");
						hit=physics.rayCast(currentBlock.x,currentBlock.y+140,currentBlock.x+80,currentBlock.y+140,"closest");
					end
					if(hit)then
						--stays in place
						currentBlock.x=currentBlock.x;
					else
						--moves right 70 px
						currentBlock.x=currentBlock.x+70;						
						for i=1,currentBlock.numChildren do
							local child=currentBlock[i];
							child.x = child.x+70;
						end
					end
				end
			end
		end
		
		leftArrow:addEventListener("touch", moveBlockLeft);
		rightArrow:addEventListener("touch", moveBlockRight);
		--

	elseif ( phase == "did" ) then
		params.level=params.level+1;
		-------NEW GUN---------------
		local function newGun (gunType)
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

		----------Create the player--------
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
		local gun = newGun(params.gunType);
		local gunSpt = gun:spawn(params.spriteSheet,params.hero); table.insert( orphans, gunSpt );
		heroGuy:insert(playerSpt);
		heroGuy:insert(gunSpt);
		heroGuy.x = display.contentCenterX;
		heroGuy.y = display.contentHeight-140;
		sceneGroup:insert( heroGuy );
		heroGuy.anchorY=0;

		---------------Next Scene-----------------
		local function next ()
			switchingScenes=true;
			display.remove( heroGuy );
			display.remove( crossLine );
			params.heroGuy=heroGuy;
			for i, v in ipairs(orphans) do
				if(orphans[i] ~= nil) then
					--print(orphans[i]);
					transition.cancel( orphans[i] );
					display.remove(orphans[i]);					
				end
			end	
			params.newGame=false;
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(1)			
			composer.gotoScene( "night", sceneOpt);
		end
	
		-----------ADD PHYSICS TO BRICKS----------------
		function addPhysicsToBricks(  )
			--check wall height
			if(currentBlock.y <= display.contentCenterX) then
				local function deleteBlock(  )
					display.remove( currentBlock );
					params.ticketNum = params.ticketNum + 100;
				end
				timer.performWithDelay( 255, deleteBlock,1);
			else
				for i=1,currentBlock.numChildren do
					local child=currentBlock[i];
					physics.addBody( child, "static", {filter=CollisionFilters.brick} );
				end
			end

			timer.performWithDelay(300, 
					function() spawnNewBlock(); end);
			
		end

		-----------MOVE BLOCK DOWN--------------
		local function checkRayCast(  )
			transition.cancel(currentBlock);
			if(swappedOut==true)then
				swappedOut=false;
				display.remove(currentBlock);
				spawnNewBlock(params.purchasedBlock);
			end
			local hit,hit2,hit3,hit4;
			if(currentBlock.num==1)then
				hit=physics.rayCast(currentBlock.x+35,currentBlock.y+35,currentBlock.x+35,currentBlock.y+70,"closest");
				hit2=physics.rayCast(currentBlock.x+105,currentBlock.y+35,currentBlock.x+105,currentBlock.y+70,"closest");
				hit3=physics.rayCast(currentBlock.x+175,currentBlock.y+35,currentBlock.x+175,currentBlock.y+70,"closest");
				hit4=physics.rayCast(currentBlock.x+245,currentBlock.y+35,currentBlock.x+245,currentBlock.y+70,"closest");
			elseif(currentBlock.num==2)then
				hit=physics.rayCast(currentBlock.x+35,currentBlock.y+105,currentBlock.x+35,currentBlock.y+175,"closest");
				hit2=physics.rayCast(currentBlock.x+105,currentBlock.y+105,currentBlock.x+105,currentBlock.y+175,"closest");
			elseif(currentBlock.num==3)then
				hit=physics.rayCast(currentBlock.x+35,currentBlock.y+105,currentBlock.x+35,currentBlock.y+175,"closest");
				hit2=physics.rayCast(currentBlock.x+105,currentBlock.y+105,currentBlock.x+105,currentBlock.y+175,"closest");
				hit3=physics.rayCast(currentBlock.x+175,currentBlock.y+105,currentBlock.x+175,currentBlock.y+175,"closest");
			elseif(currentBlock.num==4)then
				hit=physics.rayCast(currentBlock.x+35,currentBlock.y+105,currentBlock.x+35,currentBlock.y+175,"closest");
				hit2=physics.rayCast(currentBlock.x+105,currentBlock.y+105,currentBlock.x+105,currentBlock.y+175,"closest");
				hit3=physics.rayCast(currentBlock.x+175,currentBlock.y+105,currentBlock.x+175,currentBlock.y+175,"closest");
			elseif(currentBlock.num==5)then
				hit=physics.rayCast(currentBlock.x+35,currentBlock.y+105,currentBlock.x+35,currentBlock.y+175,"closest");
				hit2=physics.rayCast(currentBlock.x+105,currentBlock.y+105,currentBlock.x+105,currentBlock.y+175,"closest");
				hit3=physics.rayCast(currentBlock.x+175,currentBlock.y+105,currentBlock.x+175,currentBlock.y+175,"closest");
			elseif(currentBlock.num==6)then
				hit=physics.rayCast(currentBlock.x+35,currentBlock.y+105,currentBlock.x+35,currentBlock.y+175,"closest");
				hit2=physics.rayCast(currentBlock.x+105,currentBlock.y+105,currentBlock.x+105,currentBlock.y+175,"closest");
				hit3=physics.rayCast(currentBlock.x+175,currentBlock.y+35,currentBlock.x+175,currentBlock.y+105,"closest");
			elseif(currentBlock.num==7)then
				hit=physics.rayCast(currentBlock.x+35,currentBlock.y+35,currentBlock.x+35,currentBlock.y+105,"closest");
				hit2=physics.rayCast(currentBlock.x+105,currentBlock.y+105,currentBlock.x+105,currentBlock.y+175,"closest");
				hit3=physics.rayCast(currentBlock.x+175,currentBlock.y+105,currentBlock.x+175,currentBlock.y+175,"closest");
			elseif(currentBlock.num==8)then
				hit=physics.rayCast(currentBlock.x+35,currentBlock.y+35,currentBlock.x+35,currentBlock.y+105,"closest");
			elseif(currentBlock.num==9)then
				hit=physics.rayCast(currentBlock.x+35,currentBlock.y+105,currentBlock.x+35,currentBlock.y+175,"closest");
			end
			if(hit or hit2 or hit3 or hit4)then
				transition.cancel(currentBlock);
				addPhysicsToBricks();
			else
				transition.to(currentBlock,{time=1, delay=250, y=currentBlock.y+70,onComplete=checkRayCast});
				for i=1,currentBlock.numChildren do
					local child=currentBlock[i];
					child.y = child.y+70;
				end
			end
					
		end

		local blockCounter =math.random(2,3);
		function spawnNewBlock( num )
			if(blockCounter > 0) then
				blockCounter = blockCounter - 1;
				local blockNum = math.random( 1,7 );
				if(num~=nil)then
					currentBlock = spawnBlock(num);
					currentBlock.num=num;
					for i=1,currentBlock.numChildren do
						local child=currentBlock[i];
						child.y = child.y-70;
					end
				else
					currentBlock = spawnBlock(blockNum);
					currentBlock.num=blockNum;
				end
				params.wall:insert(currentBlock);
				sceneGroup:insert( params.wall );
				checkRayCast();
			else
				timer.performWithDelay( 500, 
					function () next()	end,1 );
			end
		end

		spawnNewBlock();

		--------DISPLAY SWAP BLOCK PICTURE-----------------
		local blockPicData,blockPic;
		if(params.purchasedBlock~=0)then
			if(params.purchasedBlock==1)then
				blockPicData={{name = "block1", frames={60}}};
			elseif(params.purchasedBlock==2)then
				blockPicData={{name = "block2", frames={61}}};
			elseif(params.purchasedBlock==3)then
				blockPicData={{name = "block3", frames={62}}};
			elseif(params.purchasedBlock==4)then
				blockPicData={{name = "block4", frames={63}}};
			elseif(params.purchasedBlock==5)then
				blockPicData={{name = "block5", frames={64}}};
			elseif(params.purchasedBlock==6)then
				blockPicData={{name = "block6", frames={65}}};
			elseif(params.purchasedBlock==7)then
				blockPicData={{name = "block7", frames={66}}};
			elseif(params.purchasedBlock==8)then
				blockPicData={{name = "block8", frames={67}}};
			elseif(params.purchasedBlock==9)then
				blockPicData={{name = "block9", frames={68}}};
			end

			blockPic= display.newSprite( params.spriteSheet, blockPicData ); table.insert( orphans, blockPic );
			blockPic.x=display.contentWidth-90; blockPic.y=90;
			blockPic:toBack( );
			sceneGroup:insert( blockPic );
		end

		-----SWAP BUTTON CIRCLE--------------

		function switchBlocks( event )
			if(params.purchasedBlock ~= 0)then							
				display.remove( blockPic );
				swapBtn:removeEventListener( "tap", switchBlocks );	
				swappedOut=true;	
			end
		end

		if(params.purchasedBlock~=0)then			
			swapData={{name = "swapBtn", frames={59}}};
			swapBtn = display.newSprite( params.spriteSheet, swapData ); table.insert( orphans, swapBtn );
			swapBtn.x=display.contentWidth-90; swapBtn.y=90;
			swapBtn.alpha=0.5;
			swapBtn:toBack( );
			sceneGroup:insert( swapBtn );
			swapBtn:addEventListener( "tap", switchBlocks );
		end


	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
