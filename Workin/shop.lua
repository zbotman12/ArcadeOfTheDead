--[[NOTES:
	1. in this shop.lua is the first page of the shop = page0
	2. ideally there will be separate pages for weapons and blocks and other shit
	]]--




local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;

--locals
local equipText1
local unequipText1
local buyText1

local equipText2
local unequipText2
local buyText2

local equipText3
local unequipText3
local buyText3

local equipText4
local unequipText4
local buyText4


--scene:create
function scene:create( event )
	local sceneGroup = self.view
	params = event.params
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;

	if ( phase == "will" ) then
		--local text = display.newText( sceneGroup, "shop scene", display.contentCenterX, display.contentCenterY, native.systemFont, 25 );

		local function nextScene (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "day", sceneOpt);
		end

		local function nextPage (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "page1", sceneOpt);
		end

		local function prevPage (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "shop", sceneOpt);
		end

		local function equipMe( event )
			print("Equipping shit...please wait :)");
			if(event.target.id == "Equip1") then
				equipText1 = display.newText("Equipted", display.contentCenterX-170, display.contentCenterY-130, native.systemFont, 30)
				sceneGroup:insert(equipText1)
			else if (event.target.id == "Equip2") then
				equipText2 = display.newText("Equipted", display.contentCenterX-170, display.contentCenterY+340, native.systemFont, 30)
				sceneGroup:insert(equipText2)
			else if (event.target.id == "Equip3") then
				equipText3 = display.newText("Equipted", display.contentCenterX+190, display.contentCenterY-130, native.systemFont, 30)
				sceneGroup:insert(equipText3)
			else -- event.target.id = "Equip4"
				equipText4 = display.newText("Equipted", display.contentCenterX+190, display.contentCenterY+340, native.systemFont, 30)
				sceneGroup:insert(equipText4)
			end end end

		end

		local function unequipMe( event )
			print("fuck this crappy gun!");
			if(event.target.id == "Unequip1") then
				unequipText1 = display.newText("Unequipted", display.contentCenterX-160, display.contentCenterY-80, native.systemFont, 30)
				sceneGroup:insert(unequipText1)
			else if (event.target.id == "Unequip2") then
				unequipText2 = display.newText("Unequipted", display.contentCenterX-160, display.contentCenterY+390, native.systemFont, 30)
				sceneGroup:insert(unequipText2)
			else if (event.target.id == "Unequip3") then
				unequipText3 = display.newText("Unequipted", display.contentCenterX+210, display.contentCenterY-80, native.systemFont, 30)
				sceneGroup:insert(unequipText3)
			else -- event.target.id = "Unequip4"
				unequipText4 = display.newText("Unequipted", display.contentCenterX+210, display.contentCenterY+390, native.systemFont, 30)
				sceneGroup:insert(unequipText4)
			end end end
		end

		local function buyMe( event )
			print("Money, Money, money $$$")
			if(event.target.id == "Buy1") then
				buyText1.text = "Bought"
				sceneGroup:insert(buyText1)
				--update money
			else if (event.target.id == "Buy2") then
				buyText2.text = "Bought"
				sceneGroup:insert(buyText2)
				--update money
			else if (event.target.id == "Buy3") then
				buyText3.text = "Bought"
				sceneGroup:insert(buyText3)
				--update money
			else -- event.target.id = "Buy4"
				buyText4.text = "Bought"
				sceneGroup:insert(buyText4)
				--update money
			end end end
		end
		
		local continueBtn = widget.newButton(
		    {
		        x = display.contentCenterX,
		        y = display.contentCenterY - 600,    
		        id = "Continue",
		        label = "Continue",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = nextScene,
		    }
		);

		continueBtn:setFillColor( 0,0.5,0.5 );
		continueBtn:scale( 1.5, 1.5 );
		sceneGroup:insert( continueBtn );


		local nextPageBtn = widget.newButton(
		    {
		        x = display.contentCenterX + 300,
		        y = display.contentCenterY - 550,    
		        id = "Next",
		        label = "Next",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = nextPage,
		    }
		);

		nextPageBtn:setFillColor( 0,0.5,0.5 );
		nextPageBtn:scale( 1.5, 1.5 );
		sceneGroup:insert( nextPageBtn );


		local pageTitle = display.newText("PAGE TITLE", display.contentCenterX, display.contentCenterY - 550, native.systemFont, 70)
		sceneGroup:insert(pageTitle)

		--[[local prevPageBtn = widget.newButton(
		    {
		        x = display.contentCenterX - 300,
		        y = display.contentCenterY - 550,    
		        id = "Prev",
		        label = "Prev",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = prevPage,
		    }
		);

		prevPageBtn:setFillColor( 0,0.5,0.5 );
		prevPageBtn:scale( 1.5, 1.5 );
		sceneGroup:insert( prevPageBtn );
		]]--

		local horionDivide = display.newRect(display.contentCenterX, display.contentCenterY - 468, display.contentCenterX*2, 5)
		sceneGroup:insert(horionDivide)

		local verticalDivide = display.newRect(display.contentCenterX,display.contentCenterY,5, display.contentCenterY *2 - 340)
		sceneGroup:insert(verticalDivide)

		local horionDivide2 = display.newRect(display.contentCenterX, display.contentCenterY, display.contentCenterX*2, 5)
		sceneGroup:insert(horionDivide2)

		local horionDivide3 = display.newRect(display.contentCenterX, display.contentCenterY + 468, display.contentCenterX*2, 5)
		sceneGroup:insert(horionDivide3)

		local currentlyEquiptedShit = display.newText("Currently Equipted Shit", display.contentCenterX, display.contentCenterY + 500, native.systemFont, 50)
		sceneGroup:insert(currentlyEquiptedShit)

		local moneyAvailable = display.newText("MONEY YOU HAVE", display.contentCenterX, display.contentCenterY + 560, native.systemFont, 50)
		sceneGroup:insert(moneyAvailable)

		-----ITEM 1------

		local equipBtn = widget.newButton(
		    {
		        x = display.contentCenterX - 300,
		        y = display.contentCenterY - 130,    
		        id = "Equip1",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);

		equipBtn:setFillColor( 0,0.9,0.3 );
		equipBtn:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn );

		local unequipBtn = widget.newButton(
		    {
		        x = display.contentCenterX - 300,
		        y = display.contentCenterY - 80,    
		        id = "Unequip1",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);

		unequipBtn:setFillColor( 1,0,0 );
		unequipBtn:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn );

		local buyBtn = widget.newButton(
		    {
		        x = display.contentCenterX - 300,
		        y = display.contentCenterY - 30,    
		        id = "Buy1",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn:setFillColor( 0.5,0,0.5 );
		buyBtn:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn );
		buyText1 = display.newText("Price $$$", display.contentCenterX -160,display.contentCenterY - 30, native.systemFont, 30)
		sceneGroup:insert(buyText1)


		-----ITEM 2------

		local equipBtn2 = widget.newButton(
		    {
		        x = display.contentCenterX - 300,
		        y = display.contentCenterY + 340,    
		        id = "Equip2",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);

		equipBtn2:setFillColor( 0,0.9,0.3 );
		equipBtn2:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn2 );

		local unequipBtn2 = widget.newButton(
		    {
		        x = display.contentCenterX - 300,
		        y = display.contentCenterY + 390,    
		        id = "Unequip2",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);

		unequipBtn2:setFillColor( 1,0,0 );
		unequipBtn2:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn2 );

		local buyBtn2 = widget.newButton(
		    {
		        x = display.contentCenterX - 300,
		        y = display.contentCenterY + 440,    
		        id = "Buy2",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn2:setFillColor( 0.5,0,0.5 );
		buyBtn2:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn2 );
		buyText2 = display.newText("Price $$$", display.contentCenterX -160,display.contentCenterY + 440, native.systemFont, 30)
		sceneGroup:insert(buyText2)





		-----ITEM 3------

		local equipBtn3 = widget.newButton(
		    {
		        x = display.contentCenterX + 65,
		        y = display.contentCenterY - 130,    
		        id = "Equip3",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);

		equipBtn3:setFillColor( 0,0.9,0.3 );
		equipBtn3:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn3 );

		local unequipBtn3 = widget.newButton(
		    {
		        x = display.contentCenterX + 65,
		        y = display.contentCenterY - 80,    
		        id = "Unequip3",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);

		unequipBtn3:setFillColor( 1,0,0 );
		unequipBtn3:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn3 );

		local buyBtn3 = widget.newButton(
		    {
		        x = display.contentCenterX + 65,
		        y = display.contentCenterY - 30,    
		        id = "Buy3",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn3:setFillColor( 0.5,0,0.5 );
		buyBtn3:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn3 );
		buyText3 = display.newText("Price $$$", display.contentCenterX + 200,display.contentCenterY - 30, native.systemFont, 30)
		sceneGroup:insert(buyText3)





		-----ITEM 4------

		local equipBtn4 = widget.newButton(
		    {
		        x = display.contentCenterX + 65,
		        y = display.contentCenterY + 340,    
		        id = "Equip4",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);

		equipBtn4:setFillColor( 0,0.9,0.3 );
		equipBtn4:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn4 );

		local unequipBtn4 = widget.newButton(
		    {
		        x = display.contentCenterX + 65,
		        y = display.contentCenterY + 390,    
		        id = "Unequip4",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);

		unequipBtn4:setFillColor( 1,0,0 );
		unequipBtn4:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn4 );

		local buyBtn4 = widget.newButton(
		    {
		        x = display.contentCenterX + 65,
		        y = display.contentCenterY + 440,    
		        id = "Buy4",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn4:setFillColor( 0.5,0,0.5 );
		buyBtn4:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn4 );
		buyText4 = display.newText("Price $$$", display.contentCenterX + 200,display.contentCenterY + 440, native.systemFont, 30)
		sceneGroup:insert(buyText4)



	elseif ( phase == "did" ) then	

	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;