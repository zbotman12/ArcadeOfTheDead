local CollisionFilters = {};

CollisionFilters.currentBlock = { categoryBits=1, maskBits=};
CollisionFilters.brick.shape = { categoryBits=2, maskBits=};
CollisionFilters.zombie.shape = { categoryBits=4, maskBits=};
CollisionFilters.bullet = { categoryBits=8, maskBits=};

return CollisionFilters;