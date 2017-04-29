const MovingObject = require("./moving_object.js");
const Util = require("./utils.js");
const Asteroid = require("./asteroid.js");



function Game() {
  this.DIM_X = 500;
  this.DIM_Y = 700;
  this.NUM_ASTEROIDS = 17;
  this.asteroids = [];
  this.addAsteroids();
}

Game.prototype.addAsteroids = function() {
  for (let i = 0; i < this.NUM_ASTEROIDS; i++) {
    console.log(this.randomPosition());
    this.asteroids.push(new Asteroid({pos: this.randomPosition()}));
  }
};

Game.prototype.randomPosition = function() {
  return [(this.DIM_X * Math.random()), (this.DIM_Y * Math.random())];
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
  for (let i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].draw();
  }
};

Game.prototype.moveObjects = function() {
  for (let i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].move();
  }
};

//
// setInterval(() => {
//   window.astertwo = new Asteroid({
//     pos: [200,200]
//   });
//   window.astertwo.draw(ctx);
//   window.astertwo.move();
//   location.reload(true);
//   window.astertwo.draw(ctx);
//   window.astertwo.move();
//   location.reload(true);
//   window.astertwo.draw(ctx);
//   window.astertwo.move();
//   location.reload(true);
//   window.astertwo.draw(ctx);
//
//
//   window.aster = new Asteroid({
//     pos: [500,500]
//   });
//   window.aster.draw(ctx);
//   window.aster.move();
//   location.reload(true);
//   window.aster.draw(ctx);
//   window.aster.move();
//   location.reload(true);
//   window.aster.draw(ctx);
//   window.aster.move();
//   location.reload(true);
//   window.aster.draw(ctx);
// }, 100);

// window.asteroid = new Asteroid();

module.exports = Game;
