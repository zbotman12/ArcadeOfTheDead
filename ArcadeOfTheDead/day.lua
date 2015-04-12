local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local Brick = require("Brick");
local Pistol = require("Pistol");
local Shotgun = require("Shotgun");
local MachineGun = require( "MachineGun" );
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
    --print(display.contentWidth," x ", display.contentHeight);
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
	local pushedCircle=false;
	

	if ( phase == "will" ) then	
		physics.start();
		physics.setGravity(0,0);
		physics.setDrawMode( "hybrid" );
		--sceneGroup:insert(wall);
		if(params.wall~=nil)then
			sceneGroup:insert(params.wall);	
		end
		
		--make a brick
		function spawnBrick( x, y, group )
			local brick = Brick:new({xPos=x, yPos=y} );
			brick:spawn(params.spriteSheet);				
			group:insert(brick.shape);
		end

		function updateBrickXY(group)
			for i=1,group.numChildren do
				local child=group[i];
				child.y = child.y+5;
			end
		end

		-- put a block into play
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
				block1.anchorX=0;
				block1.anchorY=0;
				block1.x=10;
				--updateBrickXY(block1);
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

		-----------Side Bar Right--------------------
		local sidebarRight = display.newRect(sceneGroup, display.contentWidth-5, 0, 5, display.contentHeight);
		sidebarRight.anchorX=0; sidebarRight.anchorY=0;
		physics.addBody( sidebarRight, "static" );
		sidebarRight:setFillColor( 0,0,0,0.1 );

		-----------Side Bar Left--------------------
		local sidebarLeft = display.newRect(sceneGroup, 0, 0, 5, display.contentHeight);
		sidebarLeft.anchorX=0; sidebarLeft.anchorY=0;
		physics.addBody( sidebarLeft, "static" );
		sidebarLeft:setFillColor( 0,0,0,0.1 );

		----------LEFT ARROW---------------------
		local leftArrow = display.newSprite( params.spriteSheet, {{name = "leftarrow", frames={17}}} );
		leftArrow.anchorX=0; leftArrow.anchorY=0;
		leftArrow.x = 0; leftArrow.y = display.contentHeight-180;
		leftArrow:scale( 0.75, 0.75 );
		leftArrow.alpha=.7;
		sceneGroup:insert( leftArrow );
		leftArrow:setSequence( "leftarrow" );

		----------RIGHT ARROW---------------------
		local rightArrow = display.newSprite( params.spriteSheet, {{name = "rightarrow", frames={18}}} );
		rightArrow.anchorX=0; rightArrow.anchorY=0;
		rightArrow.x = display.contentWidth-150;
		rightArrow.y = display.contentHeight-180;
		rightArrow:scale( 0.75, 0.75 );
		rightArrow.alpha=.7;
		sceneGroup:insert( rightArrow );
		rightArrow:setSequence( "rightArrow" );

		--moving the block
		function moveBlockLeft( event )
			if event.phase == "began" then
				local hit;
				if(currentBlock.num==1)then
					hit=physics.rayCast( currentBlock.x, currentBlock.y, currentBlock.x-10, currentBlock.y, "closest" );
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

		--function to handle moving the block right
		function moveBlockRight( event )
			if event.phase == "began" then
				local hit;
				if(currentBlock.num==1)then
					hit=physics.rayCast( currentBlock.x, currentBlock.y, currentBlock.x+290, currentBlock.y, "closest" );
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
		
		leftArrow:addEventListener("touch", moveBlockLeft);
		rightArrow:addEventListener("touch", moveBlockRight);
		--

	elseif ( phase == "did" ) then
		params.level=params.level+1;
		--create a new gun
		local function newGun (guntype)
			local gun;
			if (guntype == "pistol") then
				gun = Pistol:new();
			elseif(guntype == "shotgun") then
				gun = Shotgun:new();
			elseif(guntype == "machinegun") then
				gun = MachineGun:new();
			end
			return gun;
		end

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
		end		
		local playerSpt = display.newSprite(params.spriteSheet, playerSeqData )
		playerSpt:setSequence( "idle" );
		local gun = newGun("pistol");
		local gunSpt = gun:spawn(params.spriteSheet,params.hero);
		heroGuy:insert(playerSpt);
		heroGuy:insert(gunSpt);
		heroGuy.x = display.contentCenterX;
		heroGuy.y = display.contentHeight-140;
		sceneGroup:insert( heroGuy );
		heroGuy.anchorY=0;

		---------------Next Scene-----------------
		local function next ()
			display.remove( heroGuy );
			params.wall=wall;
			params.heroGuy=heroGuy;
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}			
			composer.gotoScene( "night", sceneOpt);
		end
	
		function addPhysicsToBricks(  )
			for i=1,currentBlock.numChildren do
				local child=currentBlock[i];
				physics.addBody( child, "static", {filter=CollisionFilters.brick} );
				--child.anchorX=10;
			end
			spawnNewBlock();
		end
		-----------MOVE BLOCK DOWN--------------
		local BlockTrans;
		local function checkRayCast(  )
			transition.cancel(BlockTrans);
			if(pushedCircle==true)then
				swapBlocks();
			end
			
			BlockTrans = transition.to( currentBlock, {time=1, delay=250, y=currentBlock.y+70--[[, onComplete=checkRayCast]]} );
			for i=1,currentBlock.numChildren do
				local child=currentBlock[i];
				child.y = child.y+70;
			end
			addPhysicsToBricks();
					
		end

		local blockCounter =1;
		function spawnNewBlock(  )
			if(blockCounter > 0) then
				blockCounter = blockCounter - 1;
				local blockNum = math.random( 1,7 );
				currentBlock = spawnBlock(1);
				currentBlock.num=1;
				wall:insert( currentBlock );		
				sceneGroup:insert( wall );	
				--addPhysicsToBricks();	
				--checkRayCast();
			else
				--timer.performWithDelay( 500, 
				--	function () next()	end,1 );
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

			blockPic= display.newSprite( params.spriteSheet, blockPicData );
			blockPic.x=display.contentWidth-90; blockPic.y=90;
			blockPic:toBack( );
			sceneGroup:insert( blockPic );
		end

		-----SWAP BUTTON CIRCLE--------------		
		local swapData={{name = "swapBtn", frames={59}}};
		local swapBtn = display.newSprite( params.spriteSheet, swapData );
		swapBtn.x=display.contentWidth-90; swapBtn.y=90;
		swapBtn.alpha=0.5;
		swapBtn:toBack( );
		sceneGroup:insert( swapBtn );

		function switchBlocks( event )
			pushedCircle = true;
		end

		swapBtn:addEventListener( "tap", switchBlocks );

		--------SWAP BLOCKS------------------
		function swapBlocks(  )
			if(params.purchasedBlock~=nil)then
				pushedCircle=false;
				display.remove( currentBlock );
				currentBlock = spawnBlock(params.purchasedBlock);
				currentBlock.num=params.purchasedBlock;
				display.remove( blockPic );
				wall:insert( currentBlock );		
				sceneGroup:insert( wall );	
				checkRayCast();
			end
		end
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
