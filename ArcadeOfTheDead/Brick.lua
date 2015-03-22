--BRICK CLASS

--Bricks-------------------------------
--[[
local brickOpts = {
	frames = {
		--need coordinates
		{}, --style 1 full
		{}, --style 1 2/3
		{}, --style 1 1/3
		{}, --style 2 full
		{}, --style 2 2/3
		{}, --style 2 1/3
	}
};

local brickSheet = graphics.newImageSheet("images/bricks.png", brickOpts);
]]--

--Prototype
local Brick = {tag="Brick", HP=2, xPos=0, yPos=0};

--Constructor
function Brick:new (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Brick:spawn()
	--local seqData = {
	  	--{name = "full", frames={1}},
	    --{name = "twothirds", frames={2}},
	    --{name = "onethird", frames={3}},
	--}
	--local brick1 = display.newSprite (params.brickSheet, seqData);
	
	self.shape=display.newRect(self.xPos, self.yPos,70,70);
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “brick”
	self.shape:setFillColor (math.random( ), math.random(  ),math.random(  ));
	self.shape.anchorX = 0; 
	self.shape.anchorY = 60;
	--physics.addBody(self.shape, "kinematic");
	return self.shape;
end

function Brick:hit ()
	self.HP = self.HP - 1;
	if (self.HP > 0) then
		--audio.play( soundTable["hitSound"] );
		self.shape:setFillColor(0.75,0.75,0.75);
	else
		--audio.play( soundTable["explodeSound"] );
		if(self.shape ~= nil) then
			self.shape:removeSelf();
		end
		self.shape=nil;
		self = nil;
	end
end

function Brick:addPhysics(  )
	physics.addBody( self.shape , "kinematic" );
end

return Brick;