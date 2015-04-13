--SHOTGUN CLASS
local CollisionFilters = require("CollisionFilters");

--Prototype
local Shotgun =  {tag="Shotgun", ammo = 4, fireSpd = 500, reloadSpd = 800};

--Constructor
function Shotgun:new (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Shotgun:spawn(spriteSheet, costume)
	local ShotgunSeqData;
	if(costume=="MegaMan")then
		ShotgunSeqData = {
	  		{name = "idle", frames={31}},
	  		{name = "shoot", start=31, count= 9, time = 200}
		}
	elseif(costume=="Link")then
		ShotgunSeqData = {
	  		{name = "idle", frames={49}},
	  		{name = "shoot", start=49, count= 9, time = 200}
		}
	elseif(costume=="Kirby")then
		ShotgunSeqData = {
	  		{name = "idle", frames={40}},
	  		{name = "shoot", start=40, count= 9, time = 200}
		}
	elseif(costume=="Mario")then
		pistolSeqData = {
	  		{name = "idle", frames={40}},
	  		{name = "shoot", start=40, count= 9, time = 200}
		}
	else
		ShotgunSeqData = {
	  		{name = "idle", frames={7}},
	  		{name = "shoot", start=7, count= 9, time = 200}
		}
	end
	self.spt = display.newSprite(spriteSheet, ShotgunSeqData )
	self.spt.x =  self.spt.x  + 33;
	self.spt:setSequence( "idle" );
	return self.spt;
end

function Shotgun:shoot(playerGroup)

	local bullet1, bullet2, bullet3;

	local function removeBullets()
		if(bullet1 ~= nil and bullet1.tag ~= "-") then
			bullet1:removeSelf( );
			bullet1 = nil;
		end
		if(bullet2 ~= nil and bullet2.tag ~= "-") then
			bullet2:removeSelf( );
			bullet2 = nil;
		end
		if(bullet3 ~= nil and bullet3.tag ~= "-") then
			bullet3:removeSelf( );
			bullet3 = nil;
		end
	end

	if (self.ammo ~= 0) then
		removeBullets();

		--shot sound
		local shotsFired = audio.loadSound("sounds/shotgun.mp3");
		audio.play(shotsFired, {channel = 13});
		audio.setMaxVolume(0.20, {channel = 13});
		
		self.ammo = self.ammo - 1; 
		bullet1 = display.newCircle (playerGroup.x + 30, playerGroup.y-16, 5);
		bullet1.anchorY = 1;
		bullet1:setFillColor(0,1,0);
		bullet1.isBullet = true;
		physics.addBody (bullet1, "dynamic", {radius=5, filter=CollisionFilters.bullet} );
		bullet1:applyForce(-1, -2, bullet1.x, bullet1.y);
		--audio.play( soundTable["shootSound"] );
		bullet1.tag = "shot";

		bullet2 = display.newCircle (playerGroup.x + 30, playerGroup.y-16, 5);
		bullet2.anchorY = 1;
		bullet2:setFillColor(0,1,0);
		bullet2.isBullet = true;
		physics.addBody (bullet2, "dynamic", {radius=5, filter=CollisionFilters.bullet} );
		bullet2:applyForce(0, -2, bullet2.x, bullet2.y);
		--audio.play( soundTable["shootSound"] );
		bullet2.tag = "shot";

		bullet3 = display.newCircle (playerGroup.x + 30, playerGroup.y-16, 5);
		bullet3.anchorY = 1;
		bullet3:setFillColor(0,1,0);
		bullet3.isBullet = true;
		physics.addBody (bullet3, "dynamic", {radius=5, filter=CollisionFilters.bullet} );
		bullet3:applyForce(1, -2, bullet3.x, bullet3.y);
		--audio.play( soundTable["shootSound"] );
		bullet3.tag = "shot";
	


		self.spt:setSequence( "shoot" );
		self.spt:play( );
		timer.performWithDelay( 200, function () if (self.spt ~= nil) then self.spt:setSequence( "idle" ); self.spt:play( ); end end );
		timer.performWithDelay(800, removeBullets);




		local shotsFired = audio.loadSound("sounds/pistol.mp3");
		audio.play(shotsFired, {channel = 13});
		audio.setMaxVolume(0.20, {channel = 13});
		timer.performWithDelay( 200, function () self.spt:setSequence( "idle" ); self.spt:play( ); end );

		timer.performWithDelay(1000, function() audio.stop(13); end)

		return bullet1, bullet2, bullet3;
	end
end


function Shotgun:reload()
		local shotsFired = audio.loadSound("sounds/gunCock.mp3");
		audio.play(shotsFired, {channel = 14});
		audio.setMaxVolume(0.20, {channel = 14});

		self.ammo = Shotgun.ammo;

		timer.performWithDelay(1000, function() audio.stop(14); end)
end

return Shotgun;
