local CollisionFilters = {};


CollisionFilters.currentBlock = { categoryBits=1, maskBits=11};
CollisionFilters.zombie = { categoryBits=2, maskBits=13};
CollisionFilters.bullet = { categoryBits=4, maskBits=2};
CollisionFilters.crossLine = { categoryBits=8, maskBits=3};

return CollisionFilters;