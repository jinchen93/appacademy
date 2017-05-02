const Coord = require('./coord.js');

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
