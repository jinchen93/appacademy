const Coord = require('./coord');

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
    this.oldPos = this.head.pos.map(val => val);
    this.head.plus(DIRS[this.direction]);

    for (let i = 1; i < this.segments.length; i++) {
      let temp = this.segments[i].pos.map(val => val);
      this.segments[i].pos = this.oldPos;
      this.oldPos = temp;
    }
  }

  add() {
    this.segments.push(new Coord(this.oldPos));
  }

  ateSelf() {
    for (let i = 1; i < this.segments.length; i++) {
      if (this.head.equals(this.segments[i].pos)) {
        return true;
      }
    }
    return false;
  }

  outOfBounds() {
    if (this.head.pos[0] > 24 || this.head.pos[1] > 24) {
      return true;
    }
    if (this.head.pos[0] < 0 || this.head.pos[1] < 0) {
      return true;
    }

    return false;
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
