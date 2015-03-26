--BRICK CLASS

--Prototype
local Brick = {tag="Brick", HP=4, xPos=0, yPos=0};

--Constructor
function Brick:new (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Brick:spawn(spriteSheet)
	local seqData = {
	  	{name = "4", frames={1}},
	    {name = "3", frames={2}},
	    {name = "2", frames={3}},
	    {name = "1", frames={4}},
	    {name = "0", frames={5}}
	}
	self.shape = display.newSprite(spriteSheet, seqData);
	self.shape:setSequence("4");
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “brick”
	self.shape:setFillColor (math.random(), math.random(), math.random() );
	self.shape.anchorX = 0; 
	self.shape.anchorY = 60;
	self.shape.x = self.xPos;
	self.shape.y = self.yPos;
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