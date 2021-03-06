--Game Over
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


--scene:create
function scene:create( event )
	local sceneGroup = self.view
	params = event.params;
	params.level=0;
	params.gunType="pistol";
	params.purchasedBlock=0;
	params.ticketNum=0;
	params.hero=nil;
	params.newGame=true;
	print(params.newGame);
	local bg = display.newImage ("images/GameOver.png");
	bg.anchorX=0; bg.anchorY=0;
    bg:toBack();
    sceneGroup:insert( bg );
end


--scene:show
function scene:show( event )
	local sceneGroup = self.view;
	local phase = event.phase;

	if ( phase == "will" ) then
		
		local GO = audio.loadStream("sounds/gameover.mp3")
		audio.setMaxVolume(0.045, {channel = 1})
		local backGroundChan = audio.play(GO, {channel = 1, loops = -1, fadein = 500})
		
	elseif ( phase == "did" ) then

		local function nextScene (event)
			local sceneOpt = {
				effect = "fade",
				time = 800,
				params = params
			}
			audio.stop(1)
			composer.gotoScene( "start", sceneOpt);
		end
		local startGameBtn = widget.newButton(
		    {
		        x = display.contentCenterX,
		        y = display.contentCenterY + 400,    
		        id = "New Game",
		        label = "New Game?",
		        fontSize=55,
		        font=CompFont;
		        labelColor = { default={ 1, 1, 1}, over={ 0, 0, 0 } },    
		        sheet = params.spriteSheet,
		        defaultFrame = 16,
		        onPress = nextScene,
		    }
		);
		startGameBtn:setFillColor( .6,0,1 );
		sceneGroup:insert( startGameBtn );
	end
end

--scene:hide
--scene:destroy


scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;
