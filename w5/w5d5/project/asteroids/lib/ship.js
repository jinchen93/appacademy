const MovingObject = require('./moving_object');
const Utils = require('./utils');
const Bullet = require('./bullet');

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
  this.vel = DEFAULT.vel;
};

Ship.prototype.power = function(impulse) {
  let xVel = this.vel[0] + impulse[0];
  let yVel = this.vel[1] + impulse[1];
  this.vel = [xVel, yVel];
};

Ship.prototype.fireBullet = function() {
  let bullet = new Bullet({
    vel: [this.vel[0] / 100, this.vel[1] / 100],
    game: this.game,
    pos: this.pos
  });
  this.game.addBullet(bullet);
};

module.exports = Ship;
