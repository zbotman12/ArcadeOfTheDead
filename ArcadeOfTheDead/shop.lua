---TEMPLATE FOR ALL PAGES
--x is 240 across each time
-- need button 240 width


if "Win" == system.getInfo( "platformName" ) then
    BlockFont = "3D Thirteen Pixel Fonts";
    CompFont = "Computer Pixel-7";
elseif "Android" == system.getInfo( "platformName" ) then
    BlockFont = "3D-Thirteen-Pixel-Fonts"
    CompFont = "computer_pixel-7"
end


local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;

--scene:create
function scene:create( event )
	local sceneGroup = self.view
	params = event.params
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
	local moneyAvailable;
	local isThingBought=false;
	local buyBtn, buyBtn2, buyBtn3, buyBtn4, buyBtn5, buyBtn6, buyBtn7, buyBtn8, buyBtn9;



	if ( phase == "will" ) then
		local function nextScene (event)
			moneyAvailable:removeSelf( );
			params.purchasedBlock=purchasedBlock;
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "day", sceneOpt);
		end

		local function nextPage (event)
			moneyAvailable:removeSelf( );
			params.purchasedBlock=purchasedBlock;
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "page1", sceneOpt);
		end

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

		local function buyMe( event )
			reshowBuyBtn(isThingBought);
			isThingBought = event.target.id;
			if(event.target.id == "Buy") then
				if(params.ticketNum>=150)then
					event.target.isVisible = false;
					--update money
					purchasedBlock=8;				
					params.ticketNum=params.ticketNum-150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy2") then
				if(params.ticketNum>=300)then
					event.target.isVisible = false;
					purchasedBlock=9;
					params.ticketNum=params.ticketNum-300;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy3") then
				if(params.ticketNum>=500)then
					event.target.isVisible = false;
					purchasedBlock=1;
					params.ticketNum=params.ticketNum-500;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy4") then
				if(params.ticketNum>=400)then
					event.target.isVisible = false;
					purchasedBlock=2;
					params.ticketNum=params.ticketNum-400;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy5") then
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=3;
					params.ticketNum=params.ticketNum-250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy6") then
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=4;
					params.ticketNum=params.ticketNum-250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy7") then
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=5;
					params.ticketNum=params.ticketNum-250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy8") then
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=6;
					params.ticketNum=params.ticketNum-250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			else -- event.target.id = "Buy9"
				if(params.ticketNum>=250)then
					event.target.isVisible = false;
					purchasedBlock=7;
					params.ticketNum=params.ticketNum-250;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			end 
		end
		
		local continueBtn = widget.newButton(
		    {
		        x = display.contentCenterX,
		        y = display.contentCenterY - 600,    
		        id = "Continue",
		        label = "Continue",
		        fontSize=50,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = nextScene,
		    }
		);
		continueBtn:setFillColor( 0,0.5,0.5 );
		sceneGroup:insert( continueBtn );

		local nextPageBtn = widget.newButton(
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


		local pageTitle = display.newText("BRICK SHOP", display.contentCenterX, display.contentCenterY - 500,CompFont, 120)
		sceneGroup:insert(pageTitle)

		--DIV VERT
		--[[
		local verticalDivide = display.newRect(240,display.contentCenterY,5, display.contentCenterY *2 - 340)
		sceneGroup:insert(verticalDivide)

		local verticalDivide2 = display.newRect(480,display.contentCenterY,5, display.contentCenterY *2 - 340)
		sceneGroup:insert(verticalDivide2)
		]]--
		--DIV HOR
		local yTack = ((display.contentCenterY * 2) - 342)/3;
		--print(yTack)
		--[[
		local horionDivide1 = display.newRect(display.contentCenterX, 172, display.contentCenterX*2, 5) -- y = 172
		sceneGroup:insert(horionDivide1)

		local horionDivide2 = display.newRect(display.contentCenterX, 172 + yTack, display.contentCenterX*2, 5) -- y = 500
		sceneGroup:insert(horionDivide2)

		local horionDivide3 = display.newRect(display.contentCenterX, 172 + (2*yTack), display.contentCenterX*2, 5) -- y = 828
		sceneGroup:insert(horionDivide3)

		local horionDivide4 = display.newRect(display.contentCenterX, 172 + (3*yTack), display.contentCenterX*2, 5) -- y = 1110
		sceneGroup:insert(horionDivide4)

		--BOTTOM BAR
		]]--

		--local currentlyEquiptedShit = display.newText("Currently Equipted Shit", display.contentCenterX, display.contentCenterY + 500, native.systemFont, 50)
		--sceneGroup:insert(currentlyEquiptedShit)

		if(params.ticketNum==nil)then
			params.ticketNum=10000;
		end

		function updateMoney(  )
			moneyAvailable = display.newText("Tickets: "..params.ticketNum, display.contentCenterX, display.contentCenterY + 600, CompFont, 100)
			sceneGroup:insert(moneyAvailable)
		end
		updateMoney();
		-----ROW 1------
		local rowY = 145 + yTack;

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

	elseif ( phase == "did" ) then	

	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;