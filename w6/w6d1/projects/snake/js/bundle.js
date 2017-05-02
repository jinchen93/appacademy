/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
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
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const View = __webpack_require__(4);

$(() => {
  let $ele = $('.snake');
  new View($ele);
});


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const Snake = __webpack_require__(3);

class Board {
  constructor () {
    this.snake = new Snake();
  }
}

module.exports = Board;


/***/ }),
/* 2 */
/***/ (function(module, exports) {

class Coord {
  constructor(pos) {
    this.pos = pos;
  }

  plus(dir) {
    let x = this.pos[0] + dir[0];
    let y = this.pos[1] + dir[1];
    return new Coord([x, y]);
  }

  equals(pos) {
    return this.pos[0] === pos[0] && this.pos[1] === pos[1];
  }

  isOpposite() {
  }
}

module.exports = Coord;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Coord = __webpack_require__(2);

const DIRS = {
  'N': [-1, 0],
  'E': [0, 1],
  'S': [1, 0],
  'W': [0, -1]
};

class Snake {
  constructor() {
    this.direction = 'N';
    this.head = [12, 12];
    this.tailLength = 5;
    this.segments = [this.head];
  }

  move() {
    this.segments.push(this.head);
    if (this.segments.length > this.tailLength) {
      this.segments.shift(this.segments.length - this.tailLength);
    }
    this.head = [this.head[0] + DIRS[this.direction][0], this.head[1] + DIRS[this.direction][1]];
  }

  turn(dir) {
    if(this.direction === 'N' && dir !== 'S') {
      this.direction = dir;
    } else if (this.direction === 'S' && dir !== 'N') {
      this.direction = dir;
    } else if(this.direction === 'E' && dir !== 'W') {
      this.direction = dir;
    } else if (this.direction === 'W' && dir !== 'E') {
      this.direction = dir;
    }
  }
}

module.exports = Snake;


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const Board = __webpack_require__(1);

const KEYPRESSES = {
  37: 'W',
  38: 'N',
  39: 'E',
  40: 'S'
};

class View {
  constructor (rootEl) {
    this.board = new Board();
    this.$el = rootEl;
    this.bindEvents();
    setInterval(() => {
      this.step();
    }, 100);
  }

  bindEvents() {
    $(document).on("keydown", event => {
      this.handleKeyEvent(event);
    });
  }

  render() {
    this.$el.html('');
    for (let i = 0; i < 25; i++) {
      let $row = $('<div class="row"></div>');
      for (let j = 0; j < 25; j++) {
        let $square = $('<div class="square"></div>');
        this.board.snake.segments.forEach( seg => {
          if (seg[0] === i && seg[1] === j) {
            $square.addClass('segment');
          }
        });
        $row.append($square);
      }
      this.$el.append($row);
    }
  }

  handleKeyEvent(event) {
    let key = event.keyCode;
    this.board.snake.turn(KEYPRESSES[key]);
  }

  step() {
    this.board.snake.move();
    this.render();
  }
}

module.exports = View;


/***/ })
/******/ ]);