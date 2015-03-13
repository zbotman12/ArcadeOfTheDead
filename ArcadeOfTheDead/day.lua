local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local Brick = require("Brick");
local params;
local block = display.newGroup( );
local brickSize = 70;

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
	
	local timer1;
	sceneGroup:insert(wall);
	sceneGroup:insert(block);

	function spawnBrickStyle1( x, y, group )

		local brick1 = Brick:new({xPos=x, yPos=y} );
		brick1:spawn();
		
		if(group == "wall") then
			wall:insert(brick1.shape);
		else
			block:insert(brick1.shape);
		end
			
		--add physics collision thing here for zombies
	end

	function spawnWall(  )
		local x = 10;
		local y = display.contentHeight-180;
		--spawn the wall of bricks. can use metatable here to wether there should be a block or not.
		for i=1,10 do
			for j=1,5 do
				--if metatable entry is not zero then spawn block
				--pass in flag/metatable data to set brick animation sequence based on health of brick
				spawnBrickStyle1(x,y,"wall");
				y=y-brickSize;
			end
			x=x+brickSize;
			y=display.contentHeight-180;
		end
	end

	--now has animation!! woo!
	function spawnBlock1()
		display.remove( block );
		block = display.newGroup( );
		sceneGroup:insert(block);
		local x = 220;
		for i=1,4 do
			spawnBrickStyle1(x,brickSize, "block");
			x=x+brickSize;
		end
	end

	function spawnBlock2()
		display.remove( block );
		block = display.newGroup( );
		sceneGroup:insert(block);
		local x=290;
		local y=brickSize;
		for i=1,2 do
			for j=1,2 do
				spawnBrickStyle1(x,y, "block");
				y=y+brickSize;
			end
			x=x+brickSize;
			y=brickSize;
		end
	end

	function spawnBlock3()
		display.remove( block );
		block = display.newGroup( );
		sceneGroup:insert(block);
		local x=290;
		local y=brickSize;
		spawnBrickStyle1(x,y, "block");
		y=y+brickSize;
		for i=1,3 do
			spawnBrickStyle1(x,y, "block");
			x=x+brickSize;
		end
	end

	function spawnBlock4()		
		display.remove( block );
		block = display.newGroup( );
		sceneGroup:insert(block);
		local x=430;
		local y=brickSize;
		spawnBrickStyle1(x,y,"block");
		y=y+brickSize;
		x=290;
		for i=1,3 do
			spawnBrickStyle1(x,y,"block");
			x=x+brickSize;
		end
	end

	function spawnBlock5()
		display.remove( block );
		block = display.newGroup( );
		sceneGroup:insert(block);
		local x=360;
		local y=brickSize;
		spawnBrickStyle1(x,y,"block");
		y=y+brickSize;
		x=290;
		for i=1,3 do
			spawnBrickStyle1(x,y,"block");
			x=x+brickSize;
		end
	end

	function spawnBlock6(  )
		display.remove(block);
		block = display.newGroup();
		sceneGroup: insert(block);
		local x = 360;
		local y = brickSize;
		for i=1,2 do
			spawnBrickStyle1(x,y,"block");
			x=x+brickSize;
		end
		y=y+brickSize;
		x=290;
		for i=1,2 do
			spawnBrickStyle1(x,y,"block");
			x=x+brickSize;
		end
			
	end

	function spawnBlock7(  )
		display.remove(block);
		block = display.newGroup();
		sceneGroup: insert(block);
		local x = 290;
		local y = brickSize;
		for i=1,2 do
			spawnBrickStyle1(x,y,"block");
			x=x+brickSize;
		end
		y=y+brickSize;
		x=360;
		for i=1,2 do
			spawnBrickStyle1(x,y,"block");
			x=x+brickSize;
		end
	end

	
	if ( phase == "will" ) then
		local text = display.newText( sceneGroup, "day scene", display.contentCenterX, display.contentCenterY, native.systemFont, 25 );

		spawnWall();
		--spawnBlock1();
		--spawnBlock2();
		--spawnBlock3();
		--spawnBlock4();
		--spawnBlock5();
		--spawnBlock6();
		spawnBlock7();

		--testing
		transition.to( block, {time=500, delay=1000, y=70});

		--local heroGuy = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight-140, brickSize, 100 );
		--heroGuy.anchorX=0; heroGuy.anchorY=0;
		--local zombie = display.newRect( sceneGroup, display.contentCenterX, 140, brickSize, 100 );
		--zombie:setFillColor( 1,0,0 );
		--zombie.anchorY=0; zombie.anchorX = 0;

	elseif ( phase == "did" ) then	
		local width = display.contentHeight - (display.contentHeight-180);
		local crossLine = display.newRect( sceneGroup, 0, display.contentHeight-180, display.contentWidth, width );
		crossLine.anchorX=0; crossLine.anchorY=0;
		--crossLine:setFillColor(0,0,0,0);

		local function next (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			Runtime:removeEventListener("tap", next);
			composer.gotoScene( "night", sceneOpt);
		end

		function moveBlock( event )
			if event.phase == "began" then		
				block.markX = block.x 
			elseif event.phase == "moved" then	 	
				
				local x = (event.x-event.xStart) + block.markX;
				block.x = x;		
			end
		end

		function rotateBlock( event )
			print("in here ");
			if event.phase == "began" then
				block.rotation=45;
			end
		end
		--Runtime:addEventListener("tap", next);
		crossLine:addEventListener("touch", moveBlock);
		crossLine:addEventListener("tap", rotateBlock);



	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
