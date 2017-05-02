class Apple {
  constructor(snake) {
    this.snake = snake;
    this.pos = this.randomPos();
  }

  randomPos() {
    let pos = [
      Math.floor(Math.random() * 25),
      Math.floor(Math.random() * 25)
    ];

    if (this.availSpot(pos)) {
      return pos;
    } else {
      this.randomPos();
    }
  }

  availSpot(pos) {
    let avail = true;

    for (let i = 0; i < this.snake.segments.length; i++) {
      if (this.snake.segments[i].pos === pos) {
        return false;
      }
    }

    return true;
  }
}

module.exports = Apple;
