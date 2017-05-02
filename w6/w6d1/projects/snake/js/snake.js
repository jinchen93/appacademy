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
    this.head = new Coord([12, 12]);
    this.segments = [this.head, new Coord([13, 12]), new Coord([14, 12])];
  }

  move() {
    let oldPos = this.head.pos.map(val => val);
    this.head.plus(DIRS[this.direction]);

    for (let i = 1; i < this.segments.length; i++) {
      let temp = this.segments[i].pos.map(val => val);
      this.segments[i].pos = oldPos;
      oldPos = temp;
    }
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
