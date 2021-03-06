----------SHOP SCENE--------------

if "Win" == system.getInfo( "platformName" ) then
    BlockFont = "3D Thirteen Pixel Fonts";
    CompFont = "Computer Pixel-7";
elseif "Android" == system.getInfo( "platformName" ) then
    BlockFont = "images/3D-Thirteen-Pixel-Fonts"
    CompFont = "images/computer_pixel-7"
end


local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;
local buyBtn, buyBtn2, buyBtn3, buyBtn4, buyBtn5, buyBtn6, buyBtn7, buyBtn8, buyBtn9, continueBtn, nextPageBtn;
local moneyAvailable;

--scene:create
function scene:create( event )
	local sceneGroup = self.view
	params = event.params;
	local bg = display.newImage ("images/ShopBG.png");
	bg.anchorX=0; bg.anchorY=0;
    bg:toBack();
    sceneGroup:insert( bg );
end

--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;
	local purchasedBlock=0;
	local isThingBought=false;
	local refund=0;
	
	if (event.phase == " will") then 
		print("in will phase");
	elseif ( event.phase == "did" ) then
		print("in did phase")
		--music for the backgroud
		local bgShop = audio.loadStream("sounds/shoply.mp3")
		audio.setMaxVolume(.15, {channel = 1})
		local backGroundChan = audio.play(bgShop, {channel = 1, loops = -1, fadein = 500})

		local function reshowBuyBtn( isThingBought )
			if(isThingBought == "Buy") then
				buyBtn.isVisible = true;
			elseif (isThingBought== "Buy2") then
				buyBtn2.isVisible = true;
			elseif (isThingBought == "Buy3") then
				buyBtn3.isVisible = true;
			elseif (isThingBought == "Buy4") then
				buyBtn4.isVisible = true;
			elseif (isThingBought == "Buy5") then
				buyBtn5.isVisible = true;
			elseif (isThingBought == "Buy6") then
				buyBtn6.isVisible = true;
			elseif (isThingBought == "Buy7") then
				buyBtn7.isVisible = true;
			elseif (isThingBought == "Buy8") then
				buyBtn8.isVisible = true;
			elseif (isThingBought == "Buy9") then
				buyBtn9.isVisible = true;
			end
		end
		--button logic to use the buy function of the shop
		local function buyMe( event )	

			--sound effect for button
			local coinz = audio.loadSound("sounds/coin.mp3")
			audio.play(coinz, {channel = 2})
			audio.setMaxVolume(.80, {channel = 2})

			reshowBuyBtn(isThingBought);
			isThingBought = event.target.id;
			if(event.target.id == "Buy") then
				if(params.ticketNum>=150)then
					event.target.isVisible = false;
					--update money
					purchasedBlock=8;
					params.ticketNum=params.ticketNum+refund;				
					params.ticketNum=params.ticketNum-150;
					refund=150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy2") then
				if(params.ticketNum>=300)then
					event.target.isVisible = false;
					purchasedBlock=9;
					params.ticketNum=params.ticketNum+refund;
					params.ticketNum=params.ticketNum-300;
					refund=300;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy3") then
				if(params.ticketNum>=500)then
					event.target.isVisible = false;
					purchasedBlock=1;
					params.ticketNum=params.ticketNum+refund;
					params.ticketNum=params.ticketNum-500;
					refund=500;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy4") then
				if(params.ticketNum>=400)then
					event.target.isVisible = false;
					purchasedBlock=2;
					params.ticketNum=params.ticketNum+refund;
					params.ticketNum=params.ticketNum-400;
					refund=400;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy5") then
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=5;
					params.ticketNum=params.ticketNum+refund;
					params.ticketNum=params.ticketNum-250;
					refund=250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy6") then
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=3;
					params.ticketNum=params.ticketNum+refund;
					params.ticketNum=params.ticketNum-250;
					refund=250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy7") then
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=4;
					params.ticketNum=params.ticketNum+refund;
					params.ticketNum=params.ticketNum-250;
					refund=250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy8") then
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=6;
					params.ticketNum=params.ticketNum+refund;
					params.ticketNum=params.ticketNum-250;
					refund=250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			else -- event.target.id = "Buy9"
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=7;
					params.ticketNum=params.ticketNum+refund;
					params.ticketNum=params.ticketNum-250;
					refund=250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			end 
			audio.stop(2)
		end

		local yTack = ((display.contentCenterY * 2) - 342)/3;


		local blackBox = display.newRect( sceneGroup, display.contentCenterX-3, display.contentCenterY+600, 300, 75 );
		blackBox:setFillColor( 0,0,0,0.7 );
		-- update money when you buy something
		local ticketData={{name = "ticket", frames={58}}};
		local ticketImg = display.newSprite( params.spriteSheet, ticketData );
		ticketImg.x=display.contentCenterX-150; ticketImg.y=display.contentCenterY + 575;
		ticketImg.anchorX=0; ticketImg.anchorY=0;
		ticketImg:scale( 2, 2 );
		sceneGroup:insert( ticketImg );

		function updateMoney(  )
			moneyAvailable = display.newText(params.ticketNum, display.contentCenterX+50, display.contentCenterY + 600, CompFont, 100)
			moneyAvailable:setFillColor( 1,1,1 );
			sceneGroup:insert(moneyAvailable);
		end
		updateMoney();
		-----ROW 1------
		local rowY = 145 + yTack;

		----Black Squares----
		local square1 = display.newRect(sceneGroup, 120,rowY-160,220,240);
		square1:setFillColor( 0,0,0,.6 );
		local square2 = display.newRect(sceneGroup, 360,rowY-160,220,240);
		square2:setFillColor( 0,0,0,.6 );
		local square3 = display.newRect(sceneGroup, 600,rowY-160,220,240);
		square3:setFillColor( 0,0,0,.6 );

		-----BLOCK 8 --------------		
		local blockData={{name = "block8", frames={67}}};
		local block8 = display.newSprite( params.spriteSheet, blockData );
		block8.x=120; block8.y=rowY-185;
		block8.anchorY=0;
		block8:scale( 2, 2 );
		sceneGroup:insert( block8 );
		

		buyBtn = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Buy",
		        label = 150,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);

		buyBtn:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn );

		-----BLOCK 9 --------------		
		local blockData={{name = "block9", frames={68}}};
		local block9 = display.newSprite( params.spriteSheet, blockData );
		block9.x=360; block9.y=rowY-205;
		block9.anchorY=0;
		block9:scale( 2, 2 );
		sceneGroup:insert( block9 );

		buyBtn2 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Buy2",
		        label = 300,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);
		buyBtn2:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn2 );

		-----BLOCK 1 --------------		
		local blockData={{name = "block1", frames={60}}};
		local block1 = display.newSprite( params.spriteSheet, blockData );
		block1.x=600; block1.y=rowY-185;
		block1.anchorY=0;
		block1:scale( 2, 2 );
		sceneGroup:insert( block1 );

		buyBtn3 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Buy3",
		        label = 500,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);

		buyBtn3:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn3 );

		--ROW 2
		rowY = 145 + (yTack*2)

		----Black Squares----
		local square4 = display.newRect(sceneGroup, 120,rowY-150,220,240);
		square4:setFillColor( 0,0,0,.6 );
		local square5 = display.newRect(sceneGroup, 360,rowY-155,220,240);
		square5:setFillColor( 0,0,0,.6 );
		local square6 = display.newRect(sceneGroup, 600,rowY-155,220,240);
		square6:setFillColor( 0,0,0,.6 );

		-----BLOCK 2 --------------		
		local blockData={{name = "block2", frames={61}}};
		local block2 = display.newSprite( params.spriteSheet, blockData );
		block2.x=120; block2.y=rowY-190;
		block2.anchorY=0;
		block2:scale( 2, 2 );
		sceneGroup:insert( block2 );

		buyBtn4 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Buy4",
		        label = 400,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);
		buyBtn4:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn4 );

		-----BLOCK 5 --------------		
		local blockData={{name = "block5", frames={62}}};
		local block5 = display.newSprite( params.spriteSheet, blockData );
		block5.x=360; block5.y=rowY-190;
		block5.anchorY=0;
		block5:scale( 2, 2 );
		sceneGroup:insert( block5 );

		buyBtn5 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Buy5",
		        label = 250,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);
		buyBtn5:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn5 );

		-----BLOCK 4 --------------		
		local blockData={{name = "block3", frames={63}}};
		local block3 = display.newSprite( params.spriteSheet, blockData );
		block3.x=600; block3.y=rowY-190;
		block3.anchorY=0;
		block3:scale( 2, 2 );
		sceneGroup:insert( block3 );

		buyBtn6 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Buy6",
		        label = 250,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);
		buyBtn6:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn6 );

		--ROW 3
		rowY = 145 + (yTack*3)

		----Black Squares----
		local square7 = display.newRect(sceneGroup, 120,rowY-150,220,240);
		square7:setFillColor( 0,0,0,.6 );
		local square8 = display.newRect(sceneGroup, 360,rowY-155,220,240);
		square8:setFillColor( 0,0,0,.6 );
		local square9 = display.newRect(sceneGroup, 600,rowY-155,220,240);
		square9:setFillColor( 0,0,0,.6 );

		-----BLOCK 4 --------------		
		local blockData={{name = "block4", frames={64}}};
		local block4= display.newSprite( params.spriteSheet, blockData );
		block4.x=120; block4.y=rowY-190;
		block4.anchorY=0;
		block4:scale( 2, 2 );
		sceneGroup:insert( block4 );

		buyBtn7 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Buy7",
		        label = 250,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);
		buyBtn7:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn7 );

		-----BLOCK 6 --------------		
		local blockData={{name = "block6", frames={65}}};
		local block6= display.newSprite( params.spriteSheet, blockData );
		block6.x=360; block6.y=rowY-190;
		block6.anchorY=0;
		block6:scale( 2, 2 );
		sceneGroup:insert( block6 );

		buyBtn8 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Buy8",
		        label = 250,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);
		buyBtn8:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn8 );

		-----BLOCK 7 --------------		
		local blockData={{name = "block7", frames={66}}};
		local block7= display.newSprite( params.spriteSheet, blockData );
		block7.x=600; block7.y=rowY-190;
		block7.anchorY=0;
		block7:scale( 2, 2 );
		sceneGroup:insert( block7 );

		buyBtn9 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Buy9",
		        label = 250,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);
		buyBtn9:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn9);

		function removeObjs(  )		
			moneyAvailable:removeSelf( );
			display.remove( square1 );
			display.remove( square2 );
			display.remove( square3 );
			display.remove( square4 );
			display.remove( square5 );
			display.remove( square6 );
			display.remove( square7 );
			display.remove( square8 );
			display.remove( square9 );
			display.remove( buyBtn );
			display.remove( buyBtn2 );
			display.remove( buyBtn3 );
			display.remove( buyBtn4 );
			display.remove( buyBtn5 );
			display.remove( buyBtn6 );
			display.remove( buyBtn7 );
			display.remove( buyBtn8 );
			display.remove( buyBtn9 );
			display.remove( blackBox );
			display.remove( ticketImg );
			display.remove( continueBtn );
			display.remove( nextPageBtn );
		end

		local function nextScene (event)
			removeObjs( );
			params.purchasedBlock=purchasedBlock;
			print(params.purchasedBlock);
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(1)
			composer.gotoScene( "day", sceneOpt);
		end

		local function nextPage (event)
			removeObjs( );
			params.purchasedBlock=purchasedBlock;
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(1)
			composer.gotoScene( "page1", sceneOpt);
		end

		continueBtn = widget.newButton(
		    {
		        x = display.contentCenterX,
		        y = display.contentCenterY - 600,    
		        id = "Continue",
		        label = "Continue",
		        fontSize=60,
		        font = CompFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = nextScene,
		    }
		);
		continueBtn:setFillColor( 0,0.5,0.5 );
		sceneGroup:insert( continueBtn );

		nextPageBtn = widget.newButton(
		    {
		        x = display.contentCenterX + 300,
		        y = display.contentCenterY - 550,    
		        id = "Next", 
		        sheet = params.spriteSheet,
		        defaultFrame = 18,
		        onPress = nextPage,
		    }
		);
		--nextPageBtn:setFillColor( 0,0.5,0.5 );
		nextPageBtn:scale( 0.5, 0.5 );
		sceneGroup:insert( nextPageBtn );

	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
