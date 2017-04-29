const Util = require("./utils.js");
const MovingObject = require("./moving_object.js");

const DEFAULTS  = {
  color: 'gray',
  radius: 20
};

function Asteroid(params) {
  params.color = DEFAULTS.color;
  params.radius = DEFAULTS.radius;
  params.vel = Util.randomVec(3);
  MovingObject.call(this, params);
}

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;
