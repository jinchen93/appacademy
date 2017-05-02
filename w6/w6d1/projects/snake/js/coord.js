class Coord {
  constructor(pos) {
    this.pos = pos;
  }

  plus(dir) {
    this.pos[0] += dir[0];
    this.pos[1] += dir[1];
  }

  equals(pos) {
    return this.pos[0] === pos[0] && this.pos[1] === pos[1];
  }

  isOpposite() {
  }
}

module.exports = Coord;
