local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local Brick = require("Brick");
local physics = require("physics");
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
	local fallingBlock;

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
		local crossLine = display.newRect( sceneGroup, 0, display.contentHeight-180, display.contentWidth, 5 );
		crossLine.anchorX=0; crossLine.anchorY=0;
		physics.addBody( crossLine , "static" );
		crossLine:setFillColor( 1,0,0 );

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
					currentBlock.x=currentBlock.x-70;
				end
			end
		end

		function moveBlockRight( event )
			if event.phase == "began" then
				if(currentBlock.x >= 605)then
					currentBlock.x=currentBlock.x;
				else
					currentBlock.x=currentBlock.x+70;
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
		--Runtime:addEventListener("tap", next);
		leftArrow:addEventListener("touch", moveBlockLeft);
		rightArrow:addEventListener("touch", moveBlockRight);
		--

	elseif ( phase == "did" ) then
		local text = display.newText( sceneGroup, "day scene", display.contentCenterX, display.contentCenterY, native.systemFont, 25 );

		local heroGuy = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight-140, brickSize, 100 );
		heroGuy.anchorX=0; heroGuy.anchorY=0;
		heroGuy:addEventListener("tap", rotateBlock);

		

		local function next (event)
			params.wall=wall;

			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			
			composer.gotoScene( "night", sceneOpt);
		end

		local blockCounter = 3;
		local function moveBlockDown(  )
			if(blockCounter > 0) then
				local blockNum = math.random( 1,7 );
				currentBlock = spawnBlock(blockNum);
				wall:insert( currentBlock );
				local function addPhysicsToBlock(  )
					physics.addBody( currentBlock , "dynamic" );
				end
				timer.performWithDelay( 50, addPhysicsToBlock );
				fallingBlock = transition.to( currentBlock, {time=3000, delay=1000, y=display.contentHeight, onComplete=moveBlockDown} );
				blockCounter = blockCounter - 1;
			end
		end

		moveBlockDown();

		--add physics collision thing here for bricks
			local function hitSomething( event )
				print("hit!");			
				local function changeBodyType(  )
					event.target.bodyType = "static";
				end	
				timer.performWithDelay( 50, changeBodyType);
				event.target.isFixedRotation = true;
				if (event.phase == "began") then
					transition.cancel( fallingBlock );
					moveBlockDown();
				end
			end
			currentBlock:addEventListener( "collision", hitSomething );
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
