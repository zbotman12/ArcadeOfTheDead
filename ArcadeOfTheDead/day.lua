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
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;
	local wall = display.newGroup();
	params.wall=wall;
	local brickSize = 70;	
	local shiftNum = 0;	
	local polygon;

	if ( phase == "will" ) then	
		physics.start();
		physics.setGravity(0,0);
		physics.setDrawMode( "hybrid" );
		sceneGroup:insert(wall);

		local DayBackground = display.newImage(sceneGroup, "images/Grass.jpg");
		 DayBackground.anchorX = 0;
		 DayBackground.anchorY = 0;
		 DayBackground.yScale = DayBackground.yScale * 2;
		 DayBackground:toBack();

		function spawnBrick( x, y, group )
			local brick = Brick:new({xPos=x, yPos=y} );
			brick:spawn(params.spriteSheet);				
			group:insert(brick.shape);		
		end

		function spawnWall(  )
			local x = 10;
			local y = display.contentHeight-180;
			--spawn the wall of bricks. can use metatable here to wether there should be a block or not.
			for i=1,10 do
				for j=1,5 do
					--if metatable entry is not zero then spawn block
					--pass in flag/metatable data to set brick animation sequence based on health of brick
					spawnBrick(x,y, wall);
					y=y-brickSize;
				end
				x=x+brickSize;
				y=display.contentHeight-180;
			end
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
				block2.tag="doNotRotate";
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
			end

		end

		-----------Cross over line------------------
		local height = display.contentHeight - (display.contentHeight-180);
		local crossLine = display.newRect( sceneGroup, 0, 1050, display.contentWidth, 5 );
		crossLine.anchorX=0; crossLine.anchorY=0;
		physics.addBody( crossLine, "static", {filters=CollisionFilters.crossLine} );
		crossLine:setFillColor( 0,0,0,0.1 );

		local leftArrow = display.newRect( sceneGroup, 0, display.contentHeight-180, 200, height );
		leftArrow.anchorX=0; leftArrow.anchorY=0;
		leftArrow:setFillColor(1,0,0);

		local rightArrow = display.newRect( sceneGroup, display.contentWidth-200, display.contentHeight-180, 200, height );
		rightArrow.anchorX=0; rightArrow.anchorY=0;
		rightArrow:setFillColor(0,0,1);

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
				if(currentBlock.x >= 605)then
					currentBlock.x=currentBlock.x;
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
					hits = physics.rayCast( currentBlock.x-100, currentBlock.y, currentBlock.x-100, currentBlock.y+37, "closest" );
					hits2 = physics.rayCast( currentBlock.x-35, currentBlock.y, currentBlock.x-35, currentBlock.y+37, "closest" );
					hits3 = physics.rayCast( currentBlock.x+35, currentBlock.y, currentBlock.x+35, currentBlock.y+37, "closest" );
					hits4 = physics.rayCast( currentBlock.x+100, currentBlock.y, currentBlock.x+100, currentBlock.y+37, "closest" );
				elseif(currentBlock.num ==7) then
					hits = physics.rayCast( currentBlock.x-105, currentBlock.y, currentBlock.x-105, currentBlock.y+37, "closest" );
					hits2 = physics.rayCast( currentBlock.x+35, currentBlock.y, currentBlock.x+35, currentBlock.y+71, "closest" );
					hits3 = physics.rayCast( currentBlock.x+105, currentBlock.y, currentBlock.x+105, currentBlock.y+71, "closest" );				
				elseif(currentBlock.num==3)then
					hits2 = physics.rayCast( currentBlock.x-35, currentBlock.y, currentBlock.x-35, currentBlock.y+71, "closest" );
					hits3 = physics.rayCast( currentBlock.x+35, currentBlock.y, currentBlock.x+35, currentBlock.y+71, "closest" );
					hits4 = physics.rayCast( currentBlock.x+105, currentBlock.y, currentBlock.x+105, currentBlock.y+71, "closest" );
				elseif((currentBlock.num==4) or (currentBlock.num==5)) then
					hits = physics.rayCast( currentBlock.x-33, currentBlock.y, currentBlock.x-33, currentBlock.y+71, "closest" );
					hits2 = physics.rayCast( currentBlock.x+37, currentBlock.y, currentBlock.x+37, currentBlock.y+71, "closest" );
					hits3 = physics.rayCast( currentBlock.x+107, currentBlock.y, currentBlock.x+107, currentBlock.y+71, "closest" );
				elseif(currentBlock.num==6) then
					hits = physics.rayCast( currentBlock.x-105, currentBlock.y, currentBlock.x-33, currentBlock.y+71, "closest" );
					hits2 = physics.rayCast( currentBlock.x+35, currentBlock.y, currentBlock.x+37, currentBlock.y+71, "closest" );
					hits3 = physics.rayCast( currentBlock.x+105, currentBlock.y, currentBlock.x+107, currentBlock.y+37, "closest" );
				else
					hits2 = physics.rayCast( currentBlock.x-33, currentBlock.y, currentBlock.x-35, currentBlock.y+71, "closest" );
					hits3 = physics.rayCast( currentBlock.x+33, currentBlock.y, currentBlock.x+35, currentBlock.y+71, "closest" );
				end
				--[[
				if hits then
					for i,v in ipairs( hits ) do
      				  print( "Hit: ", i, v.object, " Position: ", v.position.x, v.position.y, " Surface normal: ", v.normal.x, v.normal.y )
    				end
    			end
    			if hits2 then
					for i,v in ipairs( hits2 ) do
      				  print( "Hit2: ", i, v.object, " Position: ", v.position.x, v.position.y, " Surface normal: ", v.normal.x, v.normal.y )
    				end
    			end
   				if hits3 then
					for i,v in ipairs( hits3 ) do
      				  print( "Hit3: ", i, v.object, " Position: ", v.position.x, v.position.y, " Surface normal: ", v.normal.x, v.normal.y )
    				end
    			end
   				if hits4 then
					for i,v in ipairs( hits4 ) do
      				  print( "Hit4: ", i, v.object, " Position: ", v.position.x, v.position.y, " Surface normal: ", v.normal.x, v.normal.y )
    				end
    			end]]--

				if ( hits or hits2 or hits3 or hits4 ) then

					for i=1,currentBlock.numChildren do
						local child=currentBlock[i];
						child.anchorX = 35;
						child.anchorY = 35;
						physics.addBody( child, "static", {filter=CollisionFilters.brick} );
					end
					spawnNewBlock();
				    --[[-- There's at least one hit
				    print( "Hit count: " .. tostring( #hits ) )
				    -- Output the results
				    for i,v in ipairs( hits ) do
				        print( "Hit: ", i, v.object, " Position: ", v.position.x, v.position.y, " Surface normal: ", v.normal.x, v.normal.y )
				    end
				    print( "The first object hit is: ", hits[1].object, " at position: ", hits[1].position.x, hits[1].position.y, " where the surface normal is: ", hits[1].normal.x, hits[1].normal.y, " and where the fraction along the ray is: ", hits[1].fraction )
				    ]]--
				else
				   -- print("no hits");
				    for i=1,currentBlock.numChildren do
						local child=currentBlock[i];
						child.y=child.y+70;
					end
				    BlockTrans = transition.to( currentBlock, {time=1, delay=250, y=currentBlock.y+70, onComplete=checkRayCast} );
				end			
		end

		local blockCounter =10;
		function spawnNewBlock(  )
			if(blockCounter > 0) then
				blockCounter = blockCounter - 1;
				local blockNum = math.random( 1,7 );
				currentBlock = spawnBlock(blockNum);
				currentBlock.num=blockNum;
				print ("block is :" .. blockNum);
				wall:insert( currentBlock );				
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
