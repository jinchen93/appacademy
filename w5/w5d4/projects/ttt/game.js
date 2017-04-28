const Board = require('./board');
const Player = require('./player');
const reader = require('./reader');

class Game {
  constructor(playerOne, playerTwo) {
    this.board = new Board;
    this.playerOne = new Player(playerOne, 'x');
    this.playerTwo = new Player(playerTwo, 'o');
    this.currentPlayer = this.playerOne;
  }

  run() {
    this.board.display();
    this.playTurn();
  }

  playTurn() {
    console.log(`It is ${this.currentPlayer.name}'s turn:'`);
    reader.question("Where do you wanna move?", res => {
      let strArr = res.split(',');
      let row = parseInt(strArr[0]);
      let col = parseInt(strArr[1]);
      if (this.validMove(row, col)) {
        this.makeMove(row, col);
      } else {
        console.log("INVALID MOVE!");
        this.playTurn();
      }
    });
  }

  validMove(row, col) {
    if (row > 2 || row < 0 || col > 2 || col < 0) {
      return false;
    } else if (this.isPiece(row, col)){
      return false;
    } else {
      return true;
    }
  }

  isPiece(row, col) {
    if (this.board.grid[row][col] !== " ") {
      return true;
    } else {
      return false;
    }
  }

  makeMove(row, col) {
    this.board.grid[row][col] = this.currentPlayer.mark;
    this.board.display();
    this.checkWinner();
  }

  checkWinner() {
    if (this.rowWinner() || this.colWinner() || this.diagWinner()) {
      console.log(`CONGRATS!! ${this.currentPlayer.name} is the winner!`);
      reader.close();
    } else if (this.board.full()) {
      console.log("Wow, what a couple of losers");
      reader.close();
    } else {
      this.changePlayer();
    }
  }

  isThreeOfAKind(arr) {
    if (arr.some( val => val === ' ')) {
      return false;
    }

    return arr.every( (ele, idx, array) => {
      return ele === array[0];
    });
  }

  rowWinner() {
    let player = null;

    this.board.grid.forEach( row => {
      if (this.isThreeOfAKind(row)) {
        player = this.currentPlayer;
      }
    });

    return player;
  }

  colWinner() {
    let player = null;
    let colboard = this.board.transposedGrid();

    colboard.forEach( col => {
      if (this.isThreeOfAKind(col)) {
        player = this.currentPlayer;
      }
    });

    return player;
  }

  diagWinner() {
    let player = null;

    let diags = this.board.diagonalGrid();
    diags.forEach( diag => {
      if (this.isThreeOfAKind(diag)) {
        player = this.currentPlayer;
      }
    });

    return player;
  }

  changePlayer() {
    if (this.currentPlayer === this.playerOne) {
      this.currentPlayer = this.playerTwo;
    } else {
      this.currentPlayer = this.playerOne;
    }
    this.playTurn();
  }
}

let g = new Game('Jin', 'Grey');
g.run();
