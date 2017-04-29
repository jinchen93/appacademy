const MovingObject = require('./moving_object');
const Utils = require('./utils');

const DEFAULT = {
  color: 'white',
  radius: 2
};

function Bullet(params) {
  params.color = DEFAULT.color;
  params.radius = DEFAULT.radius;
  MovingObject.call(this, params);
}

Utils.inherits(Bullet, MovingObject);

module.exports = Bullet;
