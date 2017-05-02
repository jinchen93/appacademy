const Snake = require('./snake');
const Apple = require('./apple');

class Board {
  constructor () {
    this.snake = new Snake();
    this.generateApple();
  }

  generateApple() {
    this.apple = new Apple(this.snake);
  }
}

module.exports = Board;
