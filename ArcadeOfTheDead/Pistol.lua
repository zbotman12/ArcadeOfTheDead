--PISTOL CLASS
local CollisionFilters = require("CollisionFilters");

--Prototype
local Pistol =  {tag="Pistol", ammo = 9, fireSpd = 200, reloadSpd = 500};

--Constructor
function Pistol:new (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Pistol:spawn(spriteSheet)
		local pistolSeqData = {
	  		{name = "idle", frames={7}},
	  		{name = "shoot", start=7, count= 9, time = 200}
		}
		self.spt = display.newSprite(spriteSheet, pistolSeqData )
		self.spt.x =  self.spt.x  + 33;
		self.spt:setSequence( "idle" );
	return self.spt;
end

function Pistol:shoot(playerGroup)

	if (ammo ~= 0) then 
		local bullet = display.newCircle (playerGroup.x + 30, playerGroup.y-16, 5);
			bullet.anchorY = 1;
			bullet:setFillColor(1,0,0);
		self.spt:setSequence( "shoot" );
		self.spt:play( );
		timer.performWithDelay( 200, function () self.spt:setSequence( "idle" ); self.spt:play( ); end )
		physics.addBody (bullet, "dynamic", {radius=5, filter=CollisionFilters.bullet} );
		--bullet.isSensor = true;
		bullet.isBullet =true;
		bullet:applyForce(0, -2, bullet.x, bullet.y);
		--audio.play( soundTable["shootSound"] );
		bullet.tag = "shot";
		return bullet;
	end

	local function bulletHandler (event)
		-- remove the bullet
		bullet:removeSelf();
		bullet=nil;
		if (event.other.tag == "Zombie") then
			event.other:hit();
		end
	end

	bullet:addEventListener("collision", bulletHandler);

end

return Pistol;