local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local Brick = require("Brick");
local block = display.newGroup( );
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
	local brickSize = 70;	
	local shiftNum = 0;	

	if ( phase == "will" ) then	

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
			block.x=display.contentCenterX;block.y=35;
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
			block.x=display.contentCenterX;block.y=700;
			block.tag="doNotRotate";
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
			block.x=display.contentCenterX-35;block.y=70;
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
			block.x=display.contentCenterX-35;block.y=70;
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
			block.x=display.contentCenterX-35;block.y=70;
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
			block.x=display.contentCenterX-35;block.y=70;	
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
			block.x=display.contentCenterX-35;block.y=70;
		end

		-----------Cross over line------------------
		local height = display.contentHeight - (display.contentHeight-180);
		local leftArrow = display.newRect( sceneGroup, 0, display.contentHeight-180, 200, height );
		leftArrow.anchorX=0; leftArrow.anchorY=0;
		leftArrow:setFillColor(1,0,0);
		local height = display.contentHeight - (display.contentHeight-180);
		local rightArrow = display.newRect( sceneGroup, display.contentWidth-200, display.contentHeight-180, 200, height );
		rightArrow.anchorX=0; rightArrow.anchorY=0;
		rightArrow:setFillColor(0,0,1);

		function moveBlockLeft( event )
			if event.phase == "began" then
				if(block.x==115)then
					block.x=block.x;
				else
					block.x=block.x-70;
				end
			end
		end

		function moveBlockRight( event )
			if event.phase == "began" then
				if(block.x==605)then
					block.x=block.x;
				else
					block.x=block.x+70;
				end
			end
		end

		function rotateBlock( event )	
			if(block.tag == "doNotRotate") then
				block:rotate(90);
			else
				if(shiftNum == 0) then
					block.x=block.x - 35;
					block:rotate(90);
					shiftNum = 1;
				elseif (shiftNum == 1) then
					block.x=block.x + 35;
					block:rotate(90);
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

		spawnWall();
		--spawnBlock1();
		--spawnBlock2();
		--spawnBlock3();
		--spawnBlock4();
		--spawnBlock5();
		--spawnBlock6();
		spawnBlock7();
		
		block.anchorChildren = true;



		--testing
		

		local heroGuy = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight-140, brickSize, 100 );
		heroGuy.anchorX=0; heroGuy.anchorY=0;
		heroGuy:addEventListener("tap", rotateBlock);

		

		local function next (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			Runtime:removeEventListener("tap", next);
			composer.gotoScene( "night", sceneOpt);
		end

		
		--transition.to( block, {time=3000, delay=1000, y=700});



	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
