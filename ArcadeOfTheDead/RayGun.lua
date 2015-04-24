----------Ray Gun ---------
local CollisionFilters = require("CollisionFilters");
--Prototype
local RayGun =  {tag="RayGun", ammo = 999, fireSpd = 100, reloadSpd = 500, timer = nil};

--Constructor
function RayGun:new (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function RayGun:spawn(spriteSheet, costume)
	local RayGunSeqData;
	if(costume=="MegaMan")then
		RayGunSeqData = {
	  		{name = "idle", frames={31}},
	  		{name = "shoot", start=31, count= 9, time = 200}
		}
	elseif(costume=="Link")then
		RayGunSeqData = {
	  		{name = "idle", frames={49}},
	  		{name = "shoot", start=49, count= 9, time = 200}
		}
	elseif(costume=="Kirby")then
		RayGunSeqData = {
	  		{name = "idle", frames={40}},
	  		{name = "shoot", start=40, count= 9, time = 200}
		}
	elseif(costume=="Mario")then
		pistolSeqData = {
	  		{name = "idle", frames={40}},
	  		{name = "shoot", start=40, count= 9, time = 200}
		}
	else
		RayGunSeqData = {
	  		{name = "idle", frames={7}},
	  		{name = "shoot", start=7, count= 9, time = 200}
		}
	end
	self.spt = display.newSprite(spriteSheet, RayGunSeqData )
	self.spt.x =  self.spt.x  + 33;
	self.spt:setSequence( "idle" );
	return self.spt;
end

function RayGun:shoot(playerGroup)

		if (self.ammo ~= 0) then
		self.ammo = self.ammo - 1; 

		local shotsFired = audio.loadSound("sounds/Laser.mp3")
		audio.play(shotsFired, {channel = 12})
		audio.setMaxVolume(0.20, {channel = 12})

		local bullet = display.newRect(playerGroup.x + 30, playerGroup.y-16, 5, display.contentHeight-300 );
			bullet.anchorY = display.contentHeight - 300;
			bullet.anchorX = 0;
			bullet:setFillColor(1,0,0);
			self.spt:setSequence( "shoot" );
			self.spt:play( );
		if(self and self.spt~=nil) then
			timer.performWithDelay( 200, 
				function () 
					self.spt:setSequence( "idle" );
					self.spt:play( );
				end );
		end
		timer.performWithDelay(5, function() physics.addBody (bullet, "kinematic", {filter=CollisionFilters.bullet} ); end );
		--bullet.isSensor = true;
		bullet.isBullet =true;

		--audio.play( soundTable["shootSound"] );
		bullet.tag = "shot";

		local function removeLazer()
			if(bullet ~= nil) then
				display.remove( bullet );
			end
		end
		self.timer = timer.performWithDelay( 100, removeLazer);
		timer.performWithDelay(1000, 
			function() audio.stop(12); end)

		return bullet;
	end
end

function RayGun:reload()

		local shotsFired = audio.loadSound("sounds/gunCock.mp3")
		audio.play(shotsFired, {channel = 13})
		audio.setMaxVolume(0.20, {channel = 13})

		self.ammo = RayGun.ammo;

		timer.performWithDelay(1000, 
			function() audio.stop(13); end)
end

return RayGun;
