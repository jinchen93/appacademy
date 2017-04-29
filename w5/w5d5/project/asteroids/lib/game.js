const MovingObject = require("./moving_object");
const Utils = require("./utils");
const Asteroid = require("./asteroid");
const Ship = require('./ship');
const Bullet = require('./bullet');

function Game() {
  this.DIM_X = Utils.width;
  this.DIM_Y = Utils.height;
  this.NUM_ASTEROIDS = 13;
  this.asteroids = [];
  this.addAsteroids();
  this.addShip();
  this.bullets = [];
}

Game.prototype.defaultAsteroid = function() {
  return {
    pos: this.randomPosition(),
    game: this
  };
};

Game.prototype.addAsteroids = function() {
  for (let i = 0; i < this.NUM_ASTEROIDS; i++) {
    this.asteroids.push(new Asteroid(this.defaultAsteroid()));
  }
};

Game.prototype.addBullet = function(bullet) {
  this.bullets.push(bullet);
};

Game.prototype.addShip = function() {
  this.ship = new Ship({
    pos: this.randomPosition(),
    game: this
  });
};

Game.prototype.allObjects = function() {
  let allObjs = this.asteroids.map(val => val);
  allObjs.push(this.ship);
  allObjs = allObjs.concat(this.bullets);
  return allObjs;
};

Game.prototype.checkCollisions = function() {
  const allObjs = this.allObjects();
  for (let i = 0; i < allObjs.length; i++) {
    for (let j = 0; j < allObjs.length; j++) {
      const obj1 = allObjs[i];
      const obj2 = allObjs[j];
      if (i !== j) {
        if (obj1.isCollideWith(obj2) && obj1 instanceof Asteroid) {
          obj1.collideWith(obj2);
        }
      }
    }
  }
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
  const allObjs = this.allObjects();
  for (let i = 0; i < allObjs.length; i++) {
    allObjs[i].draw(ctx);
  }
};

Game.prototype.moveObjects = function() {
  const allObjs = this.allObjects();
  for (let i = 0; i < allObjs.length; i++) {
    allObjs[i].move();
  }
};

Game.prototype.step = function() {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.randomPosition = function() {
  return [
    this.DIM_X * Math.random(),
    this.DIM_Y * Math.random()
  ];
};

Game.prototype.astRemove = function(astRemove) {
  let newAsteroids = [];
  this.asteroids.forEach(asteroid2 => {
    if (astRemove !== asteroid2) {
      newAsteroids.push(asteroid2);
    }
  });
  this.asteroids = newAsteroids;
};

Game.prototype.bullRemove = function(bullet) {
  let bullets = [];
  this.bullets.forEach(bullet2 => {
    if (bullet !== bullet2) {
      bullets.push(bullet2);
    }
  });
  this.bullets = bullets;
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
