--SHOTGUN CLASS

--Prototype
local Shotgun =  {tag="Shotgun", ammo = 4, fireSpd = 500, reloadSpd = 800};

--Constructor
function Shotgun:new (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Shotgun:spawn(spriteSheet)
		local ShotgunSeqData = {
	  		{name = "idle", frames={7}},
	  		{name = "shoot", start=7, count= 9, time = 200}
		}
		self.spt = display.newSprite(spriteSheet, ShotgunSeqData )
		self.spt.x =  self.spt.x  + 33;
		self.spt:setSequence( "idle" );
	return self.spt;
end

function Shotgun:shoot(playerGroup)

	if (ammo ~= 0) then 
		local shotsFired = audio.loadSound("sounds/pistol.mp3")
		audio.play(shotsFired, {channel = 13})
		audio.setMaxVolume(0.20, {channel = 13})
		local bullet = display.newCircle (playerGroup.x + 30, playerGroup.y-16, 5);
			bullet.anchorY = 1;
			bullet:setFillColor(0,1,0);
		self.spt:setSequence( "shoot" );
		self.spt:play( );
		timer.performWithDelay( 200, function () self.spt:setSequence( "idle" ); self.spt:play( ); end )
		physics.addBody (bullet, "dynamic", {radius=5} );
		--bullet.isSensor = true;
		bullet.isBullet =true;
		bullet:applyForce(0, -2, bullet.x, bullet.y);
		--audio.play( soundTable["shootSound"] );
		bullet.tag = "shot";

		audio.stop(13)

		return bullet;
	end
end

return Shotgun;