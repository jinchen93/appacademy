class Board {
  constructor () {
    this.grid = [[' ',' ',' '],
                 [' ',' ',' '],
                 [' ',' ',' ']];
  }

  display() {
    for (let i = 0; i < this.grid.length; i++) {
      let row = this.grid[i];
      console.log(`${row[0]} | ${row[1]} | ${row[2]}`);
      if (i !== this.grid.length - 1) {
        console.log("---------");
      }
    }
  }

  transposedGrid() {
    let transposedboard = [];
    for (var col = 0; col < this.grid.length; col++) {
      let column = [];
      for (var row = 0; row < this.grid.length; row++) {
        column.push(this.grid[row][col]);
      }
      transposedboard.push(column);
    }
    return transposedboard;
  }

  diagonalGrid() {
    let diags = [];
    diags.push([this.grid[0][2], this.grid[1][1], this.grid[2][0]]);
    diags.push([this.grid[0][0], this.grid[1][1], this.grid[2][2]]);
    return diags;
  }

  full() {
    let isFull = true;
    this.grid.forEach ( row => {
      if (row.some((el, id, array) => el === " " )) {
        isFull = false;
      }
    });
    return isFull;
  }
}

module.exports = Board;
