const Utils = require("./Utils");
const MovingObject = require("./moving_object");
const Ship = require('./ship');

const DEFAULTS  = {
  color: 'gray',
  radius: 20
};

function Asteroid(params) {
  params.color = DEFAULTS.color;
  params.radius = DEFAULTS.radius;
  params.vel = Utils.randomVec(3);
  MovingObject.call(this, params);
}

Utils.inherits(Asteroid, MovingObject);

Asteroid.prototype.collideWith = function(otherObject) {
  if (otherObject instanceof Ship) {
    otherObject.relocate();
  }
};

module.exports = Asteroid;
