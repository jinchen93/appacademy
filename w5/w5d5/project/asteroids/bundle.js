/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 4);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(1);

function MovingObject(params) {
  this.pos = params.pos;
  this.vel = params.vel;
  this.radius = params.radius;
  this.color = params.color;
  this.game = params.game;
}

MovingObject.prototype.draw = function(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();
  ctx.arc(
    this.pos[0],
    this.pos[1],
    this.radius,
    0,
    2 * Math.PI,
    false
  );
  ctx.fill();
};

MovingObject.prototype.move = function() {
  let wrappedPos = this.game.wrap(this.pos);
  this.pos[0] = wrappedPos[0] + this.vel[0];
  this.pos[1] = wrappedPos[1] + this.vel[1];
};

MovingObject.prototype.isCollideWith = function(otherObject) {
  let radiusSum = this.radius + otherObject.radius;
  let distance =  Util.distance(this.pos, otherObject.pos);
  return distance < radiusSum;
};

module.exports = MovingObject;


/***/ }),
/* 1 */
/***/ (function(module, exports) {

const Util = {
  inherits (childClass, parentClass) {
    childClass.prototype = Object.create(parentClass.prototype);
    childClass.prototype.constructor = childClass;
  },

  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return this.scale([Math.sin(deg), Math.cos(deg)], length);
  },

  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  },

  distance (pos1, pos2) {
    let xSquared = Math.pow(pos1[0] - pos2[0], 2);
    let ySquared = Math.pow(pos1[1] - pos2[1], 2);
    return Math.sqrt(xSquared + ySquared);
  },

  width: window.innerWidth - 20,
  height: window.innerHeight - 20

};

module.exports = Util;


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const MovingObject = __webpack_require__(0);
const Util = __webpack_require__(1);
const Asteroid = __webpack_require__(3);

function Game() {
  this.DIM_X = Util.width;
  this.DIM_Y = Util.height;
  this.NUM_ASTEROIDS = 5;
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
    this.asteroids.push(new Asteroid(this.defaultAsteroid()));
  }
};

Game.prototype.checkCollisions = function() {
  const asteroids = this.asteroids;
  for (let i = 0; i < asteroids.length; i++) {
    for (let j = 0; j < asteroids.length; j++) {
      if (i !== j) {
        const ast1 = asteroids[i];
        const ast2 = asteroids[j];
        if (ast1.isCollideWith(ast2)) {
          let distance =  Util.distance(ast1.pos, ast2.pos);
          alert(
          `COLLISION \n
          pos1: ${ast1.pos} \n
          pos2: ${ast2.pos} \n
          distance: ${distance}`
          );
        }
      }
    }
  }
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


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(1);
const MovingObject = __webpack_require__(0);

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


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(2);
const Util = __webpack_require__(1);

function GameView(ctx) {
  this.ctx = ctx;
  this.game = new Game();
}

GameView.prototype.start = function(ctx) {
  setInterval(() => {
    this.game.step();
    this.game.draw(ctx);
  }, 15);
};

document.addEventListener('DOMContentLoaded', () => {
  const canvasEl = document.getElementsByTagName("canvas")[0];
  canvasEl.height = Util.height;
  canvasEl.width = Util.width;
  const ctx = canvasEl.getContext("2d");

  window.game = new GameView(ctx);
  window.game.start(ctx);
});


/***/ })
/******/ ]);