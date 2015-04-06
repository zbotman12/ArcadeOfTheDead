local CollisionFilters = {};


CollisionFilters.brick = { categoryBits=1, maskBits=2};
CollisionFilters.zombie = { categoryBits=2, maskBits=13};
CollisionFilters.bullet = { categoryBits=4, maskBits=2};
CollisionFilters.crossLine = { categoryBits=8, maskBits=2};

return CollisionFilters;