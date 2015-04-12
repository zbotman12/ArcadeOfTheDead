----------SHOP SCENE, page 2--------------

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

--locals
local equipBtn, unequipBtn;
local equipBtn2, unequipBtn2;
local equipBtn3, unequipBtn3;
local equipBtn4, unequipBtn4;
local equipBtn5, unequipBtn5;
local equipBtn6, unequipBtn6;
local equipBtn7, unequipBtn7;
local equipBtn8, unequipBtn8;
local equipBtn9, unequipBtn9;

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
	local isThingEquipped=false;
	local wall = params.wall;
	local blockHealth = 0;
	local totalNumOfBricks = 0;
	local repairCost=0;

	if ( phase == "will" ) then

		function nextScene (event)
			moneyAvailable:removeSelf( );
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "day", sceneOpt);
		end

		function nextPage (event)
			moneyAvailable:removeSelf( );
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "page2", sceneOpt);
		end

		function prevPage (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "shop", sceneOpt);
		end

		local function removeEquip( isThingEquipped )
			if(isThingEquipped == "Equip") then
				equipBtn.isVisible = true;
				unequipBtn.isVisible = false;
			elseif (isThingEquipped== "Equip2") then
				equipBtn2.isVisible = true;
				unequipBtn2.isVisible = false;
			elseif (isThingEquipped == "Equip3") then
				equipBtn3.isVisible = true;
				unequipBtn3.isVisible = false;
			elseif (isThingEquipped == "Equip4") then
				equipBtn4.isVisible = true;
				unequipBtn4.isVisible = false;
			elseif (isThingEquipped == "Equip5") then
				equipBtn5.isVisible = true;
				unequipBtn5.isVisible = false;
			elseif (isThingEquipped == "Equip6") then
				equipBtn6.isVisible = true;
				unequipBtn6.isVisible = false;
			elseif (isThingEquipped == "Equip7") then
				equipBtn7.isVisible = true;
				unequipBtn7.isVisible = false;
			elseif (isThingEquipped == "Equip8") then
				equipBtn8.isVisible = true;
				unequipBtn8.isVisible = false;
			elseif (isThingEquipped == "Equip9") then
				equipBtn9.isVisible = true;
				unequipBtn9.isVisible = false;
			end
		end

		local function equipMe( event )			
			removeEquip(isThingEquipped);
			isThingEquipped = event.target.id;
			if(event.target.id == "Equip") then
				event.target.isVisible = false
				unequipBtn.isVisible = true
			elseif (event.target.id == "Equip2") then
				event.target.isVisible = false
				unequipBtn2.isVisible = true
			elseif (event.target.id == "Equip3") then
				event.target.isVisible = false
				unequipBtn3.isVisible = true
			elseif (event.target.id == "Equip4") then
				event.target.isVisible = false
				unequipBtn4.isVisible = true
			elseif (event.target.id == "Equip5") then
				event.target.isVisible = false
				unequipBtn5.isVisible = true
			elseif (event.target.id == "Equip6") then
				event.target.isVisible = false
				unequipBtn6.isVisible = true
			elseif (event.target.id == "Equip7") then
				event.target.isVisible = false
				unequipBtn7.isVisible = true
			elseif (event.target.id == "Equip8") then
				event.target.isVisible = false
				unequipBtn8.isVisible = true
			else -- event.target.id = "Equip9"
				event.target.isVisible = false
				unequipBtn9.isVisible = true
			end

		end

		local function unequipMe( event )
			if(event.target.id == "Unequip") then
				event.target.isVisible = false
				equipBtn.isVisible = true
			elseif (event.target.id == "Unequip2") then
				event.target.isVisible = false
				equipBtn2.isVisible = true
			elseif (event.target.id == "Unequip3") then
				event.target.isVisible = false
				equipBtn3.isVisible = true
			elseif (event.target.id == "Unequip4") then
				event.target.isVisible = false
				equipBtn4.isVisible = true
			elseif (event.target.id == "Unequip5") then
				event.target.isVisible = false
				equipBtn5.isVisible = true
			elseif (event.target.id == "Unequip6") then
				event.target.isVisible = false
				equipBtn6.isVisible = true
			elseif (event.target.id == "Unequip7") then
				event.target.isVisible = false
				equipBtn7.isVisible = true
			elseif (event.target.id == "Unequip8") then
				event.target.isVisible = false
				equipBtn8.isVisible = true
			else -- event.target.id = "Unequip9"
				event.target.isVisible = false
				equipBtn9.isVisible = true
			end
		end

		local function buyMe( event )
			if(event.target.id == "Buy") then
				if(params.ticketNum>=1000)then
					event.target.isVisible = false
					equipBtn.isVisible = true
					params.ticketNum=params.ticketNum-150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy2") then
				if(params.ticketNum>=2000)then
					event.target.isVisible = false
					equipBtn2.isVisible = true
					params.ticketNum=params.ticketNum-150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy3") then
				if(params.ticketNum>=1000)then
					event.target.isVisible = false
					equipBtn3.isVisible = true
					params.ticketNum=params.ticketNum-150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy4") then
				if(params.ticketNum>=500)then
					event.target.isVisible = false
					equipBtn4.isVisible = true
					params.ticketNum=params.ticketNum-150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy5") then
				if(params.ticketNum>=400)then
					event.target.isVisible = false
					equipBtn5.isVisible = true
					params.ticketNum=params.ticketNum-150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy6") then
				if(params.ticketNum>=250)then
					event.target.isVisible = false
					equipBtn6.isVisible = true
					params.ticketNum=params.ticketNum-150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy7") then
				if(params.ticketNum>=300)then
					event.target.isVisible = false
					equipBtn7.isVisible = true
					params.ticketNum=params.ticketNum-150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			elseif (event.target.id == "Buy8") then
				if(params.ticketNum>=300)then
					params.life=params.life+1;
					if (params.life == 3) then
						event.target.isVisible = false;
					end
					params.ticketNum=params.ticketNum-150;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			else -- event.target.id = "Buy9"
				if(params.ticketNum>=1)then
					event.target.isVisible = false;
					if(wall~=nil) then
						for i=1,wall.numChildren do
							local child = wall[i];
							for j=1,child.numChildren do
								local brick = child[j];
								if(brick.pp~=nil)then
									brick.pp.HP = 4;
									brick.pp.shape:setSequence("4");
								end
							end
						end
					end
					params.ticketNum=params.ticketNum-repairCost;
					moneyAvailable:removeSelf( );
					updateMoney();
				end
			end 
		end
		
		local pageTitle = display.newText("MISCELANEOUS", display.contentCenterX, display.contentCenterY - 550, CompFont, 60)
		pageTitle:setFillColor( 0,0,0 );
		sceneGroup:insert(pageTitle)

		--DIV VERT
		--[[
		local verticalDivide = display.newRect(240,display.contentCenterY,5, display.contentCenterY *2 - 340)
		sceneGroup:insert(verticalDivide)

		local verticalDivide2 = display.newRect(480,display.contentCenterY,5, display.contentCenterY *2 - 340)
		sceneGroup:insert(verticalDivide2)

		--DIV HOR
		]]--
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
		local currentlyEquipted = display.newText("Currently Equipted Shit", display.contentCenterX, display.contentCenterY + 500, CompFont, 75);
		currentlyEquipted:setFillColor( 0,0,0 );
		sceneGroup:insert(currentlyEquipted)

		if(params.ticketNum==nil)then
			params.ticketNum=10000;
		end

		function updateMoney(  )
			moneyAvailable = display.newText("Tickets: "..params.ticketNum, display.contentCenterX, display.contentCenterY + 600, CompFont, 100);
			moneyAvailable:setFillColor( 0,0,0 );
			sceneGroup:insert(moneyAvailable);
		end
		updateMoney();

		-----ROW 1------
		local rowY = 145 + yTack
		
		----Black Squares----
		local square1 = display.newRect(sceneGroup, 120,rowY-160,220,240);
		square1:setFillColor( 0,0,0,.6 );
		local square2 = display.newRect(sceneGroup, 360,rowY-160,220,240);
		square2:setFillColor( 0,0,0,.6 );
		local square3 = display.newRect(sceneGroup, 600,rowY-160,220,240);
		square3:setFillColor( 0,0,0,.6 );

		local buyBtn = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Buy",
		        label = 1000,
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

		equipBtn = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Equip",
		        label = "Equip",
		        fontSize=90,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = equipMe,
		    }
		);
		equipBtn.isVisible = false
		equipBtn:setFillColor(0.5,0,0.5);
		sceneGroup:insert( equipBtn );

		unequipBtn = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Unequip",
		        label = "Unequip",
		        fontSize=70,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = unequipMe,
		    }
		);
		unequipBtn.isVisible = false
		unequipBtn:setFillColor( 1,0,0 );
		sceneGroup:insert( unequipBtn );

		local buyBtn2 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Buy2",
		        label = 2000,
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

		equipBtn2 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Equip2",
		        label = "Equip",
		        fontSize=90,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = equipMe,
		    }
		);
		equipBtn2.isVisible = false
		equipBtn2:setFillColor( 0.5,0,0.5);
		sceneGroup:insert( equipBtn2 );

		unequipBtn2 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Unequip2",
		        label = "Unequip",
		        fontSize=70,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = unequipMe,
		    }
		);
		unequipBtn2.isVisible = false
		unequipBtn2:setFillColor( 1,0,0 );
		sceneGroup:insert( unequipBtn2 );

		local buyBtn3 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Buy3",
		        label = 1000,
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

		equipBtn3 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Equip3",
		        label = "Equip",
		        fontSize=90,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = equipMe,
		    }
		);
		equipBtn3.isVisible = false
		equipBtn3:setFillColor(0.5,0,0.5);
		sceneGroup:insert( equipBtn3 );

		unequipBtn3 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Unequip3",
		        label = "Unequip",
		        fontSize=70,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = unequipMe,
		    }
		);
		unequipBtn3.isVisible = false
		unequipBtn3:setFillColor( 1,0,0 );
		sceneGroup:insert( unequipBtn3 );

		--ROW 2
		rowY = 145 + (yTack*2)
		----Black Squares----
		local square4 = display.newRect(sceneGroup, 120,rowY-150,220,240);
		square4:setFillColor( 0,0,0,.6 );
		local square5 = display.newRect(sceneGroup, 360,rowY-155,220,240);
		square5:setFillColor( 0,0,0,.6 );
		local square6 = display.newRect(sceneGroup, 600,rowY-155,220,240);
		square6:setFillColor( 0,0,0,.6 );

		local buyBtn4 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Buy4",
		        label = 500,
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

		equipBtn4 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Equip4",
		        label = "Equip",
		        fontSize=90,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = equipMe,
		    }
		);
		equipBtn4.isVisible = false
		equipBtn4:setFillColor(0.5,0,0.5);
		sceneGroup:insert( equipBtn4 );

		unequipBtn4 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Unequip4",
		        label = "Unequip",
		        fontSize=70,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = unequipMe,
		    }
		);
		unequipBtn4.isVisible = false
		unequipBtn4:setFillColor( 1,0,0 );
		sceneGroup:insert( unequipBtn4 );

		local buyBtn5 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Buy5",
		        label = 400,
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

		equipBtn5 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Equip5",
		        label = "Equip",
		        fontSize=90,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = equipMe,
		    }
		);
		equipBtn5.isVisible = false
		equipBtn5:setFillColor(0.5,0,0.5);
		sceneGroup:insert( equipBtn5 );

		unequipBtn5 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Unequip5",
		        label = "Unequip",
		        fontSize=70,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = unequipMe,
		    }
		);
		unequipBtn5.isVisible = false
		unequipBtn5:setFillColor( 1,0,0 );
		sceneGroup:insert( unequipBtn5 );

		local buyBtn6 = widget.newButton(
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

		equipBtn6 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Equip6",
		        label = "Equip",
		        fontSize=90,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = equipMe,
		    }
		);
		equipBtn6.isVisible = false
		equipBtn6:setFillColor(0.5,0,0.5);
		sceneGroup:insert( equipBtn6 );

		unequipBtn6 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Unequip6",
		        label = "Unequip",
		        fontSize=70,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = unequipMe,
		    }
		);
		unequipBtn6.isVisible = false
		unequipBtn6:setFillColor( 1,0,0 );
		sceneGroup:insert( unequipBtn6 );

		--ROW 3
		rowY = 145 + (yTack*3)
		----Black Squares----
		local square7 = display.newRect(sceneGroup, 120,rowY-150,220,240);
		square7:setFillColor( 0,0,0,.6 );
		local square8 = display.newRect(sceneGroup, 360,rowY-155,220,240);
		square8:setFillColor( 0,0,0,.6 );
		local square9 = display.newRect(sceneGroup, 600,rowY-155,220,240);
		square9:setFillColor( 0,0,0,.6 );

		local buyBtn7 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Buy7",
		        label = 300,
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

		equipBtn7 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Equip7",
		        label = "Equip",
		        fontSize=90,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = equipMe,
		    }
		);
		equipBtn7.isVisible = false
		equipBtn7:setFillColor(0.5,0,0.5);
		sceneGroup:insert( equipBtn7 );

		unequipBtn7 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Unequip7",
		        label = "Unequip",
		        fontSize=70,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = unequipMe,
		    }
		);
		unequipBtn7.isVisible = false
		unequipBtn7:setFillColor( 1,0,0 );
		sceneGroup:insert( unequipBtn7 );

		local heartData={{name = "heart", frames={27}}};
		local heart = display.newSprite( params.spriteSheet, heartData );
		heart.x=330; heart.y=rowY-180;
		heart.anchorX=0; heart.anchorY=0;
		heart:scale( 3, 3 );
		sceneGroup:insert( heart );

		local buyBtn8 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Buy8",
		        label = 300,
		        fontSize=100,
		        font = BlockFont,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = buyMe,
		    }
		);
		if (params.life == 3) then
			buyBtn8.isVisible = false;
		end
		buyBtn8:setFillColor( 0,0.9,0.3 );
		sceneGroup:insert( buyBtn8 );

		if(wall~=nil) then
			for i=1,wall.numChildren do
				local child = wall[i];
				for j=1,child.numChildren do
					local brick = child[j];
					if(brick.pp~=nil)then
						print(brick.pp.HP);
						blockHealth = blockHealth + brick.pp.HP;
						totalNumOfBricks = totalNumOfBricks +1;
					end
				end
			end
		end
		totalNumOfBricks = totalNumOfBricks * 4;
		repairCost = totalNumOfBricks - blockHealth;
		repairCost= repairCost*10;

		local repairText = display.newText("Repair\n All\nBlocks", 625, rowY-160, CompFont, 70)
		repairText:setFillColor( 1,.5,0 );
		sceneGroup:insert(repairText)

		local buyBtn9 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Buy9",
		        label = repairCost,
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
		end

		function nextScene (event)
			removeObjs();
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "day", sceneOpt);
		end

		function nextPage (event)
			removeObjs();
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "page2", sceneOpt);
		end

		function prevPage (event)
			removeObjs();
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "shop", sceneOpt);
		end

		local continueBtn = widget.newButton(
		    {
		        x = display.contentCenterX,
		        y = display.contentCenterY - 600,    
		        id = "Continue",
		        label = "Continue",
		        font = CompFont,
		        fontSize=55,
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = nextScene,
		    }
		);

		continueBtn:setFillColor( 0,0.5,0.5 );
		sceneGroup:insert( continueBtn );

		local prevPageBtn = widget.newButton(
		    {
		        x = display.contentCenterX - 300,
		        y = display.contentCenterY - 550,    
		        id = "Prev",  
		        sheet = params.spriteSheet,
		        defaultFrame = 17,
		        onPress = prevPage,
		    }
		);

		prevPageBtn:scale( 0.5, 0.5 );
		sceneGroup:insert( prevPageBtn );

	elseif ( phase == "did" ) then	

	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;