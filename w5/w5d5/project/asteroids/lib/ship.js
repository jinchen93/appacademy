const MovingObject = require('./moving_object');
const Utils = require('./Utils');

const DEFAULT = {
  color: 'green',
  radius: 10,
  vel: [0,0]
};

function Ship(params) {
  params.color = DEFAULT.color;
  params.radius = DEFAULT.radius;
  params.vel = DEFAULT.vel;
  MovingObject.call(this, params);
}

Utils.inherits(Ship, MovingObject);

Ship.prototype.relocate = function() {
  this.pos = this.game.randomPosition();
};

module.exports = Ship;
