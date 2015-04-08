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

function Zombie:spawn()
	
	self.shape=display.newRect( self.xPos, self.yPos, 70, 100 );
	self.shape.pp = self; -- parent object
	self.shape.tag = self.tag; -- “Zombie”
	self.shape:setFillColor( 1,0,0 );
	self.shape.anchorX = 0; 
	self.shape.anchorY = 100;
	return self.shape;
end

function Zombie:move ()   
   
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
		self.shape:removeSelf();
		self.shape=nil;
		self = nil;
	end
end

return Zombie;