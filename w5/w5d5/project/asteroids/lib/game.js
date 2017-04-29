const MovingObject = require("./moving_object.js");
const Util = require("./utils.js");
const Asteroid = require("./asteroid.js");

function Game() {
  this.DIM_X = Util.width;
  this.DIM_Y = Util.height;
  this.NUM_ASTEROIDS = 17;
  this.asteroids = [];
  this.addAsteroids();
}

Game.prototype.defaultAsteroid = function() {
  return {
    pos: this.randomPosition(),
    game: this
  };
};

Game.prototype.addAsteroids = function() {
  for (let i = 0; i < this.NUM_ASTEROIDS; i++) {
    console.log(this.randomPosition());
    this.asteroids.push(new Asteroid(this.defaultAsteroid()));
  }
};

Game.prototype.randomPosition = function() {
  return [(this.DIM_X * Math.random()), (this.DIM_Y * Math.random())];
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
  for (let i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].draw(ctx);
  }
};

Game.prototype.moveObjects = function() {
  for (let i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].move();
  }
};

Game.prototype.wrap = function(pos) {
  let x = pos[0];
  let y = pos[1];

  if (x > this.DIM_X) {
    return [0, y];
  }

  if (x < 0) {
    return [this.DIM_X, y];
  }

  if (y > this.DIM_Y) {
    return [x, 0];
  }

  if (y < 0) {
    return [x, this.DIM_Y];
  }

  return pos;
};

module.exports = Game;
