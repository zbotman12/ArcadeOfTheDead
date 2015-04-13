--PISTOL CLASS
local CollisionFilters = require("CollisionFilters");

--Prototype
local Pistol =  {tag="Pistol", ammo = 6, fireSpd = 200, reloadSpd = 500};

--Constructor
function Pistol:new (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Pistol:spawn(spriteSheet, costume)
	local pistolSeqData;
	if(costume=="MegaMan")then
		pistolSeqData = {
	  		{name = "idle", frames={31}},
	  		{name = "shoot", start=31, count= 9, time = 200}
		}
	elseif(costume=="Link")then
		pistolSeqData = {
	  		{name = "idle", frames={49}},
	  		{name = "shoot", start=49, count= 9, time = 200}
		}
	elseif(costume=="Kirby")then
		pistolSeqData = {
	  		{name = "idle", frames={40}},
	  		{name = "shoot", start=40, count= 9, time = 200}
		}
	elseif(costume=="Mario")then
		pistolSeqData = {
	  		{name = "idle", frames={40}},
	  		{name = "shoot", start=40, count= 9, time = 200}
		}
	else
		pistolSeqData = {
	  		{name = "idle", frames={7}},
	  		{name = "shoot", start=7, count= 9, time = 200}
		}
	end
		self.spt = display.newSprite(spriteSheet, pistolSeqData )
		self.spt.x =  self.spt.x  + 33;
		self.spt:setSequence( "idle" );
	return self.spt;
end

function Pistol:shoot(playerGroup)

	if (self.ammo ~= 0) then
		self.ammo = self.ammo - 1; 

		local shotsFired = audio.loadSound("sounds/pistol.mp3")
		audio.play(shotsFired, {channel = 12})
		audio.setMaxVolume(0.20, {channel = 12})

		local bullet = display.newCircle (playerGroup.x + 30, playerGroup.y-16, 5);
			bullet.anchorY = 1;
			bullet:setFillColor(1,0,0);
		self.spt:setSequence( "shoot" );
		self.spt:play( );
		timer.performWithDelay( 200, 
			function () 
				if(self.spt~=nil)then
					self.spt:setSequence( "idle" );
					self.spt:play( );
				end
			end );
		physics.addBody (bullet, "dynamic", {radius=5, filter=CollisionFilters.bullet} );
		--bullet.isSensor = true;
		bullet.isBullet =true;
		bullet:applyForce(0, -2, bullet.x, bullet.y);
		--audio.play( soundTable["shootSound"] );
		bullet.tag = "shot";

		timer.performWithDelay(1000, function() audio.stop(12); end)

		return bullet;
	end

end

function Pistol:reload()

		local shotsFired = audio.loadSound("sounds/gunCock.mp3")
		audio.play(shotsFired, {channel = 13})
		audio.setMaxVolume(0.20, {channel = 13})

		self.ammo = Pistol.ammo;

		timer.performWithDelay(1000, function() audio.stop(13); end)
end

return Pistol;
