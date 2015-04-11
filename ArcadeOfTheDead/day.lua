local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local Brick = require("Brick");
local Pistol = require("Pistol");
local Shotgun = require("Shotgun");
local physics = require("physics");
local CollisionFilters = require("CollisionFilters");
local currentBlock=nil;
local params;


--scene:create
function scene:create( event )
	local sceneGroup = self.view;
	params = event.params
	local bg = display.newImage ("images/DayBG.png");
	bg.anchorX=0; bg.anchorY=0;
    bg:toBack();
    sceneGroup:insert( bg );
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;
	local wall = display.newGroup();
	if(params.wall~=nil)then
		wall:insert( params.wall );
	end
	local brickSize = 70;	
	local shiftNum = 0;	
	local polygon;
	
	--music
	--local bgDay = audio.loadStream("sounds/tetris.mp3")
	--audio.setMaxVolume(.015, {channel = 1})

	if ( phase == "will" ) then	
		physics.start();
		physics.setGravity(0,0);
		physics.setDrawMode( "hybrid" );
		--sceneGroup:insert(wall);
		if(params.wall~=nil)then
			sceneGroup:insert(params.wall);	
		end

		function spawnBrick( x, y, group )
			local brick = Brick:new({xPos=x, yPos=y} );
			brick:spawn(params.spriteSheet);				
			group:insert(brick.shape);		
		end

		function spawnBlock( blockNum )
			local y=brickSize;
			if (blockNum == 1)then
				local block1 = display.newGroup( );
				local x = 220;
				for i=1,4 do
					spawnBrick(x,brickSize, block1);
					x=x+brickSize;
				end
				block1.x=display.contentCenterX;block1.y=35;
				block1.anchorChildren = true;
				return block1;
			elseif (blockNum == 2)then
				local block2 = display.newGroup( );
				local x=290;				
				for i=1,2 do
					for j=1,2 do
						spawnBrick(x,y,block2);
						y=y+brickSize;
					end
					x=x+brickSize;
					y=brickSize;
				end
				block2.x=display.contentCenterX;block2.y=70;
				block2.anchorChildren = true;
				return block2;
			elseif (blockNum == 3) then
				local block3 = display.newGroup( );
				local x=290;
				spawnBrick(x,y, block3);
				y=y+brickSize;
				for i=1,3 do
					spawnBrick(x,y, block3);
					x=x+brickSize;
				end
				block3.x=display.contentCenterX-35;block3.y=70;
				block3.anchorChildren = true;
				return block3;
			elseif (blockNum == 4) then
				local block4 = display.newGroup( );
				local x=430;
				spawnBrick(x,y,block4);
				y=y+brickSize;
				x=290;
				for i=1,3 do
					spawnBrick(x,y,block4);
					x=x+brickSize;
				end
				block4.x=display.contentCenterX-35;block4.y=70;
				block4.anchorChildren = true;
				return block4;
			elseif (blockNum == 5) then
				local block5 = display.newGroup( );
				local x=360;
				spawnBrick(x,y,block5);
				y=y+brickSize;
				x=290;
				for i=1,3 do
					spawnBrick(x,y,block5);
					x=x+brickSize;
				end
				block5.x=display.contentCenterX-35;block5.y=70;
				block5.anchorChildren = true;
				return block5;
			elseif (blockNum == 6) then
				local block6 = display.newGroup();
				local x = 360;
				for i=1,2 do
					spawnBrick(x,y,block6);
					x=x+brickSize;
				end
				y=y+brickSize;
				x=290;
				for i=1,2 do
					spawnBrick(x,y,block6);
					x=x+brickSize;
				end
				block6.x=display.contentCenterX-35;block6.y=70;
				block6.anchorChildren = true;
				return block6;
			elseif (blockNum == 7) then
				local block7 = display.newGroup();
				local x = 290;
				for i=1,2 do
					spawnBrick(x,y,block7);
					x=x+brickSize;
				end
				y=y+brickSize;
				x=360;
				for i=1,2 do
					spawnBrick(x,y,block7);
					x=x+brickSize;
				end
				block7.x=display.contentCenterX-35;block7.y=70;
				block7.anchorChildren = true;
				return block7;
			elseif (blockNum == 8)then
				local block8 = display.newGroup( );
				local x = 290;
				spawnBrick(x,y,block8);
				block8.x=display.contentCenterX-35;block8.y=35;
				block8.anchorChildren = true;
				return block8;
			elseif(blockNum == 9) then
				local block9 = display.newGroup( );
				local x = 290;
				spawnBrick(x,y,block9);
				y=y+brickSize;
				spawnBrick(x,y,block9);
				block9.x=display.contentCenterX-35;block9.y=70;
				block9.anchorChildren = true;
				return block9;
			end

		end

		-----------Cross over line------------------
		local height = display.contentHeight - (display.contentHeight-180);
		local crossLine = display.newRect( sceneGroup, 0, 1050, display.contentWidth, 5 );
		crossLine.anchorX=0; crossLine.anchorY=0;
		physics.addBody( crossLine, "static", {filters=CollisionFilters.crossLine} );
		crossLine:setFillColor( 0,0,0,0.1 );

		local sidebarRight = display.newRect(sceneGroup, 0, 5, 5, display.contentHeight);
		sidebarRight.anchorX=0; sidebarRight.anchorY=0;
		--[[
			MAY NEED A COLLISON FILTER
		]]--
		physics.addBody( sidebarRight, "static" );
		sidebarRight:setFillColor( 0,0,0,0.1 );

		local sidebarLeft = display.newRect(sceneGroup, 0, 50, 5, display.contentHeight);
		sidebarLeft.anchorX=0; sidebarLeft.anchorY=0;
		--[[
			MAY NEED A COLLISON FILTER
		]]--
		physics.addBody( sidebarLeft, "static" );
		sidebarLeft:setFillColor( 0,0,0,0.1 );

		local leftArrow = display.newSprite( params.spriteSheet, {{name = "leftarrow", frames={17}}} );
		leftArrow.anchorX=0; leftArrow.anchorY=0;
		leftArrow.x = 0; leftArrow.y = display.contentHeight-180;
		leftArrow:scale( 0.75, 0.75 );
		sceneGroup:insert( leftArrow );
		leftArrow:setSequence( "leftarrow" );

		local rightArrow = display.newSprite( params.spriteSheet, {{name = "rightarrow", frames={18}}} );
		rightArrow.anchorX=0; rightArrow.anchorY=0;
		rightArrow.x = display.contentWidth-150;
		rightArrow.y = display.contentHeight-180;
		rightArrow:scale( 0.75, 0.75 );
		sceneGroup:insert( rightArrow );
		rightArrow:setSequence( "rightArrow" );

		function moveBlockLeft( event )
			if event.phase == "began" then
				if(currentBlock.x <= 115)then
					currentBlock.x=currentBlock.x;
				else
					currentBlock.x=currentBlock.x-71;
					for i=1,currentBlock.numChildren do
						local child=currentBlock[i];
						child.x=child.x-71;
					end
				end
			end
		end

		function moveBlockRight( event )
			if event.phase == "began" then
				local hits, hits2, hits3, hits4, hits5, hits6, hits7, hits8;
				if(currentBlock.num == 1) then
					hits = physics.rayCast( currentBlock.x-105, currentBlock.y, currentBlock.x-142, currentBlock.y, "closest" );
					hits2 = physics.rayCast( currentBlock.x+105, currentBlock.y, currentBlock.x+142, currentBlock.y, "closest" );
				elseif(currentBlock.num == 2) then
					hits  = physics.rayCast( currentBlock.x-35, currentBlock.y-35, currentBlock.x-72, currentBlock.y-35, "closest" );
					hits2 = physics.rayCast( currentBlock.x+35, currentBlock.y-35, currentBlock.x+72, currentBlock.y-35, "closest" );
					hits3 = physics.rayCast( currentBlock.x-35, currentBlock.y+35, currentBlock.x-72, currentBlock.y+35, "closest" );
					hits4 = physics.rayCast( currentBlock.x+35, currentBlock.y+35, currentBlock.x+72, currentBlock.y+35, "closest" );					
				elseif(currentBlock.num == 3) then

				
				elseif(currentBlock.num == 4) then

				
				elseif(currentBlock.num == 5) then

				
				elseif(currentBlock.num == 6) then

				
				elseif(currentBlock.num == 7) then

				end

				if ( hits or hits2 or hits3 or hits4 ) then

				else
					currentBlock.x=currentBlock.x+71;
					for i=1,currentBlock.numChildren do
						local child=currentBlock[i];
						child.x=child.x+71;
					end
				end
			end
		end

		function rotateBlock( event )	
			if(currentBlock.tag == "doNotRotate") then
				currentBlock:rotate(90);
			else
				if(shiftNum == 0) then
					currentBlock.x=currentBlock.x - 35;					
					currentBlock:rotate(90);
					shiftNum = 1;
				elseif (shiftNum == 1) then
					currentBlock.x=currentBlock.x + 35;
					currentBlock:rotate(90);
					shiftNum = 0;
				end
			end
		end
		leftArrow:addEventListener("touch", moveBlockLeft);
		rightArrow:addEventListener("touch", moveBlockRight);
		--

	elseif ( phase == "did" ) then
		params.level=params.level+1;
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

		---------------Next Scene-----------------
		local function next ()
			display.remove( heroGuy );
			params.wall=wall;
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}			
			composer.gotoScene( "night", sceneOpt);
		end

		local BlockTrans;
		local function checkRayCast(  )
			transition.cancel(BlockTrans);
			local hits,hits2,hits3,hits4;
				if(currentBlock.num == 1) then
					hits = physics.rayCast( currentBlock.x-105, currentBlock.y, currentBlock.x-105, currentBlock.y+37, "closest" );
					hits2 = physics.rayCast( currentBlock.x-35, currentBlock.y, currentBlock.x-35, currentBlock.y+37, "closest" );
					hits3 = physics.rayCast( currentBlock.x+35, currentBlock.y, currentBlock.x+35, currentBlock.y+37, "closest" );
					hits4 = physics.rayCast( currentBlock.x+105, currentBlock.y, currentBlock.x+105, currentBlock.y+37, "closest" );

				elseif(currentBlock.num == 2) then
					hits = physics.rayCast( currentBlock.x-35, currentBlock.y, currentBlock.x-35, currentBlock.y+72, "closest" );
					hits2 = physics.rayCast( currentBlock.x+35, currentBlock.y, currentBlock.x+35, currentBlock.y+72, "closest" );

				--elseif(currentBlock.num==3)then
			--		hits = physics.rayCast( currentBlock.x-35, currentBlock.y, currentBlock.x-35, currentBlock.y+71, "closest" );
			--		hits2 = physics.rayCast( currentBlock.x+35, currentBlock.y, currentBlock.x+35, currentBlock.y+71, "closest" );
			--		hits3 = physics.rayCast( currentBlock.x+105, currentBlock.y, currentBlock.x+105, currentBlock.y+71, "closest" );

				elseif(currentBlock.num==5 or currentBlock.num==3 or currentBlock.num==4 )then
					hits = physics.rayCast( currentBlock.x, currentBlock.y, currentBlock.x, currentBlock.y+72, "closest" );
					hits2 = physics.rayCast( currentBlock.x+70, currentBlock.y, currentBlock.x+70, currentBlock.y+72, "closest" );
					hits3 = physics.rayCast( currentBlock.x-70, currentBlock.y, currentBlock.x-70, currentBlock.y+72, "closest" );

				elseif(currentBlock.num ==7) then
					hits = physics.rayCast( currentBlock.x-70, currentBlock.y-35, currentBlock.x-70, currentBlock.y+2, "closest" );
					hits2 = physics.rayCast( currentBlock.x, currentBlock.y, currentBlock.x, currentBlock.y+72, "closest" );
					hits3 = physics.rayCast( currentBlock.x+70, currentBlock.y+35, currentBlock.x+70, currentBlock.y+72, "closest" );				
				--elseif((currentBlock.num==4) or (currentBlock.num==5)) then
				--	hits = physics.rayCast( currentBlock.x-33, currentBlock.y, currentBlock.x-33, currentBlock.y+71, "closest" );
				--	hits2 = physics.rayCast( currentBlock.x+37, currentBlock.y, currentBlock.x+37, currentBlock.y+71, "closest" );
				--	hits3 = physics.rayCast( currentBlock.x+107, currentBlock.y, currentBlock.x+107, currentBlock.y+71, "closest" );
				elseif(currentBlock.num==6) then
					hits = physics.rayCast( currentBlock.x-70, currentBlock.y+35, currentBlock.x-70, currentBlock.y+72, "closest" );
					hits2 = physics.rayCast( currentBlock.x, currentBlock.y, currentBlock.x, currentBlock.y+72, "closest" );
					hits3 = physics.rayCast( currentBlock.x+70, currentBlock.y-35, currentBlock.x+70, currentBlock.y+2, "closest" );
				else
				end

				if ( hits or hits2 or hits3 or hits4 ) then

					for i=1,currentBlock.numChildren do
						local child=currentBlock[i];
						--child.anchorY = 35;
						--child.anchorX = 35;
						physics.addBody( child, "static", {filter=CollisionFilters.brick} );
					end
					spawnNewBlock();
				else
				    for i=1,currentBlock.numChildren do
						local child=currentBlock[i];
						child.y=child.y+70;
					end
				   BlockTrans = transition.to( currentBlock, {time=1, delay=250, y=currentBlock.y+70, onComplete=checkRayCast} );
				end			
		end

		local blockCounter =1;


		function spawnNewBlock(  )
			if(blockCounter > 0) then
				blockCounter = blockCounter - 1;
				local blockNum = math.random( 1,7 );
				currentBlock = spawnBlock(blockNum);
				currentBlock.num=blockNum;
				print ("block is :" .. blockNum);
				wall:insert( currentBlock );		
				sceneGroup:insert( wall );	
				checkRayCast();
			else
				next();
			end
		end

		spawnNewBlock();
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
