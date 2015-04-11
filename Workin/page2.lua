---TEMPLATE FOR ALL PAGES
--x is 240 across each time
-- need button 240 width

local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;

--locals
local equipBtn
local unequipBtn

local equipBtn2
local unequipBtn2

local equipBtn3
local unequipBtn3

local equipBtn4
local unequipBtn4

local equipBtn5
local unequipBtn5

local equipBtn6
local unequipBtn6

local equipBtn7
local unequipBtn7

local equipBtn8
local unequipBtn8

local equipBtn9
local unequipBtn9


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

		local bgShop = audio.loadStream("sounds/shoply.mp3")
		audio.setMaxVolume(.015, {channel = 1})
		local backGroundChan = audio.play(bgShop, {channel = 1, loops = -1, fadein = 500})

		local function nextScene (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "day", sceneOpt);
		end

		local function prevPage (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(bgShop)
			composer.gotoScene( "page1", sceneOpt);
		end

		local function equipMe( event )
			--print("Equipping shit...please wait :)");
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
			--print("fuck this crappy gun!");
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
			--print("Money, Money, money $$$")
			if(event.target.id == "Buy") then
				event.target.isVisible = false
				equipBtn.isVisible = true
				--update money
			elseif (event.target.id == "Buy2") then
				event.target.isVisible = false
				equipBtn2.isVisible = true
			elseif (event.target.id == "Buy3") then
				event.target.isVisible = false
				equipBtn3.isVisible = true
			elseif (event.target.id == "Buy4") then
				event.target.isVisible = false
				equipBtn4.isVisible = true
			elseif (event.target.id == "Buy5") then
				event.target.isVisible = false
				equipBtn5.isVisible = true
			elseif (event.target.id == "Buy6") then
				event.target.isVisible = false
				equipBtn6.isVisible = true
			elseif (event.target.id == "Buy7") then
				event.target.isVisible = false
				equipBtn7.isVisible = true
			elseif (event.target.id == "Buy8") then
				event.target.isVisible = false
				equipBtn8.isVisible = true
			else -- event.target.id = "Buy9"
				event.target.isVisible = false
				equipBtn9.isVisible = true
			end --end end
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


		local pageTitle = display.newText("COSTUME SHOP", display.contentCenterX, display.contentCenterY - 550, native.systemFont, 60)
		sceneGroup:insert(pageTitle)

		local prevPageBtn = widget.newButton(
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

		--DIV VERT

		local verticalDivide = display.newRect(240,display.contentCenterY,5, display.contentCenterY *2 - 340)
		sceneGroup:insert(verticalDivide)

		local verticalDivide2 = display.newRect(480,display.contentCenterY,5, display.contentCenterY *2 - 340)
		sceneGroup:insert(verticalDivide2)

		--DIV HOR
		local yTack = ((display.contentCenterY * 2) - 342)/3
		--print(yTack)

		local horionDivide1 = display.newRect(display.contentCenterX, 172, display.contentCenterX*2, 5) -- y = 172
		sceneGroup:insert(horionDivide1)

		local horionDivide2 = display.newRect(display.contentCenterX, 172 + yTack, display.contentCenterX*2, 5) -- y = 500
		sceneGroup:insert(horionDivide2)

		local horionDivide3 = display.newRect(display.contentCenterX, 172 + (2*yTack), display.contentCenterX*2, 5) -- y = 828
		sceneGroup:insert(horionDivide3)

		local horionDivide4 = display.newRect(display.contentCenterX, 172 + (3*yTack), display.contentCenterX*2, 5) -- y = 1110
		sceneGroup:insert(horionDivide4)

		--BOTTOM BAR

		local currentlyEquiptedShit = display.newText("Currently Equipted Shit", display.contentCenterX, display.contentCenterY + 500, native.systemFont, 50)
		sceneGroup:insert(currentlyEquiptedShit)

		local moneyAvailable = display.newText("MONEY YOU HAVE", display.contentCenterX, display.contentCenterY + 560, native.systemFont, 50)
		sceneGroup:insert(moneyAvailable)

		-----ROW 1------
		local rowY = 145 + yTack

		local buyBtn = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Buy",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn:setFillColor( 0,0.9,0.3 );
		buyBtn:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn );

		equipBtn = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Equip",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);
		equipBtn.isVisible = false
		equipBtn:setFillColor(0.5,0,0.5);
		equipBtn:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn );

		unequipBtn = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Unequip",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);
		unequipBtn.isVisible = false
		unequipBtn:setFillColor( 1,0,0 );
		unequipBtn:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn );

		local buyBtn2 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Buy2",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);
		buyBtn2:setFillColor( 0,0.9,0.3 );
		buyBtn2:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn2 );

		equipBtn2 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Equip2",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);
		equipBtn2.isVisible = false
		equipBtn2:setFillColor( 0.5,0,0.5);
		equipBtn2:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn2 );

		unequipBtn2 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Unequip2",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);
		unequipBtn2.isVisible = false
		unequipBtn2:setFillColor( 1,0,0 );
		unequipBtn2:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn2 );

		local buyBtn3 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Buy3",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn3:setFillColor( 0,0.9,0.3 );
		buyBtn3:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn3 );

		equipBtn3 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Equip3",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);
		equipBtn3.isVisible = false
		equipBtn3:setFillColor(0.5,0,0.5);
		equipBtn3:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn3 );

		unequipBtn3 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Unequip3",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);
		unequipBtn3.isVisible = false
		unequipBtn3:setFillColor( 1,0,0 );
		unequipBtn3:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn3 );

		--ROW 2
		rowY = 145 + (yTack*2)

		local buyBtn4 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Buy4",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn4:setFillColor( 0,0.9,0.3 );
		buyBtn4:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn4 );

		equipBtn4 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Equip4",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);
		equipBtn4.isVisible = false
		equipBtn4:setFillColor(0.5,0,0.5);
		equipBtn4:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn4 );

		unequipBtn4 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Unequip4",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);
		unequipBtn4.isVisible = false
		unequipBtn4:setFillColor( 1,0,0 );
		unequipBtn4:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn4 );

		local buyBtn5 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Buy5",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn5:setFillColor( 0,0.9,0.3 );
		buyBtn5:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn5 );

		equipBtn5 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Equip5",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);
		equipBtn5.isVisible = false
		equipBtn5:setFillColor(0.5,0,0.5);
		equipBtn5:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn5 );

		unequipBtn5 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Unequip5",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);
		unequipBtn5.isVisible = false
		unequipBtn5:setFillColor( 1,0,0 );
		unequipBtn5:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn5 );

		local buyBtn6 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Buy6",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn6:setFillColor( 0,0.9,0.3 );
		buyBtn6:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn6 );

		equipBtn6 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Equip6",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);
		equipBtn6.isVisible = false
		equipBtn6:setFillColor(0.5,0,0.5);
		equipBtn6:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn6 );

		unequipBtn6 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Unequip6",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);
		unequipBtn6.isVisible = false
		unequipBtn6:setFillColor( 1,0,0 );
		unequipBtn6:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn6 );

		--ROW 3

		rowY = 145 + (yTack*3)

		local buyBtn7 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Buy7",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn7:setFillColor( 0,0.9,0.3 );
		buyBtn7:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn7 );

		equipBtn7 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Equip7",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);
		equipBtn7.isVisible = false
		equipBtn7:setFillColor(0.5,0,0.5);
		equipBtn7:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn7 );

		unequipBtn7 = widget.newButton(
		    {
		        x = 120,
		        y = rowY,    
		        id = "Unequip7",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);
		unequipBtn7.isVisible = false
		unequipBtn7:setFillColor( 1,0,0 );
		unequipBtn7:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn7 );

		local buyBtn8 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Buy8",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn8:setFillColor( 0,0.9,0.3 );
		buyBtn8:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn8 );

		equipBtn8 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Equip8",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);
		equipBtn8.isVisible = false
		equipBtn8:setFillColor(0.5,0,0.5);
		equipBtn8:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn8 );

		unequipBtn8 = widget.newButton(
		    {
		        x = 360,
		        y = rowY,    
		        id = "Unequip8",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);
		unequipBtn8.isVisible = false
		unequipBtn8:setFillColor( 1,0,0 );
		unequipBtn8:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn8 );

		local buyBtn9 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Buy9",
		        label = "Buy",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = buyMe,
		    }
		);

		buyBtn9:setFillColor( 0,0.9,0.3 );
		buyBtn9:scale( 1.5, 1.5 );
		sceneGroup:insert( buyBtn9);

		equipBtn9 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Equip9",
		        label = "Equip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = equipMe,
		    }
		);
		equipBtn9.isVisible = false
		equipBtn9:setFillColor(0.5,0,0.5);
		equipBtn9:scale( 1.5, 1.5 );
		sceneGroup:insert( equipBtn9 );

		unequipBtn9 = widget.newButton(
		    {
		        x = 600,
		        y = rowY,    
		        id = "Unequip9",
		        label = "Unequip",
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.buttonSheet,
		        defaultFrame = 1,
		        onPress = unequipMe,
		    }
		);
		unequipBtn9.isVisible = false
		unequipBtn9:setFillColor( 1,0,0 );
		unequipBtn9:scale( 1.5, 1.5 );
		sceneGroup:insert( unequipBtn9 );


	elseif ( phase == "did" ) then	

	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;