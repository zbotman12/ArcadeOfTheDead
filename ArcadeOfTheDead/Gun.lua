--DEFAULT GUN CLASS

--Prototype
local Gun = {tag="-", ammo = 99, fireSpd = 1, reloadSpd = 1};

--Constructor
function Gun:new (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end

return Gun;