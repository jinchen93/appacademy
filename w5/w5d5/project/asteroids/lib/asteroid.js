const Util = require("./utils.js");
const MovingObject = require("./moving_object.js");

function Asteroid(params) {
  this.color = 'yellow';
  this.radius = 20;
  this.pos = params.pos;
  this.vel = randomVec(this.radius);
}


Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;

// Return a randomly oriented vector with the given length.
function randomVec (length) {
  const deg = 2 * Math.PI * Math.random();
  return scale([Math.sin(deg), Math.cos(deg)], length);
}
// Scale the length of a vector by the given amount.
function scale (vec, m) {
  return [vec[0] * m, vec[1] * m];
}
