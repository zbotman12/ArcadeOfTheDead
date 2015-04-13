--ZOMBIE CLASS
local test;

--Prototype
local Zombie = {tag="Zombie", HP=1, xPos=0, yPos=0, fT=1};

--Constructor
function Zombie:new (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Zombie:spawn( spriteSheet)
	local zombieSeqData = {
		{name = "walk", start=19, count= 8, time = 400}
	}
	self.shape=display.newSprite( spriteSheet, zombieSeqData )
	self.shape.x = self.xPos;self.shape.y = self.yPos;
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “Zombie”
	self.shape.anchorX = 0; 
	self.shape.anchorY = 100;
	self.shape:setSequence( "walk" );
	self.shape:play();
	local growl = audio.loadSound("sounds/zombie.mp3")
	audio.play(growl, {channel = 10})
	audio.setMaxVolume(0.10, {channel = 10})
	return self.shape;
end

function Zombie:movePerBlock ()   
   transition.to(self.shape, {x=self.shape.x, y=display.contentHeight-180, time=1000} );
end

function Zombie:stop ()   
   transition.cancel( self.shape );
end

function Zombie:hit ()
	self.HP = self.HP - 1;
	if (self.HP > 0) then
		--audio.play( soundTable["hitSound"] );
		self.shape:setFillColor(0.75,0.75,0.75);
	else
		--audio.play( soundTable["explodeSound"] );
		if (self.timerRef ~= nil) then
			timer.cancel ( self.timerRef );
		end
		-- die
		if(self.shape ~= nil) then
			self.shape:removeSelf();
			self.shape=nil;
			self = nil;
		end
	end
end

return Zombie;
