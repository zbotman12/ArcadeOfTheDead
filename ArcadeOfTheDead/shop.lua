local composer = require( "composer" );
local widget = require("widget");
local scene = composer.newScene();
local params;

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
		local text = display.newText( sceneGroup, "shop scene", display.contentCenterX, display.contentCenterY, native.systemFont, 25 );

		local function nextScene (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			composer.gotoScene( "day", sceneOpt);
		end

		local function equipMe( event )
			print("Equipping shit...please wait :)");
		end

		local function unequipMe( event )
			print("fuck this crappy gun!");
		end

		local function buyMe( event )
			print("Money, Money, money $$$");
		end
		
		local continueBtn = widget.newButton(
		    {
		        x = display.contentCenterX,
		        y = display.contentCenterY + 100,    
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

		local equipBtn = widget.newButton(
		    {
		        x = display.contentCenterX,
		        y = display.contentCenterY + 200,    
		        id = "Equip",
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
		        x = display.contentCenterX,
		        y = display.contentCenterY + 300,    
		        id = "Unequip",
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
		        x = display.contentCenterX,
		        y = display.contentCenterY + 400,    
		        id = "Buy",
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

	elseif ( phase == "did" ) then	

	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;