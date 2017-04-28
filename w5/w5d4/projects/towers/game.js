const reader = require("./reader");

class Game {
  constructor() {
    this.stacks = [[3,2,1], [], []];
  }

  run() {
    //until all the disks are on moved from the initial stack to another stack
    // and are in order
    this.display();

    this.promptMove();


    // let player move one disk at a time
    // disks can't stack ontop of a smaller disk
  }

  display() {
    this.stacks.forEach(stack => console.log(`[${stack}]`));
  }

  promptMove() {
    reader.question("Move from: ", from => {
      reader.question("Move to:", to => {
        if (this.validMove(from, to)) {
          this.makeMove(from, to);
        } else {
          console.log("Invalid move!");
          this.promptMove();
        }
      });
    });
  }

  validMove(from, to) {
    let fromDisc = this.stacks[from].slice(this.stacks[from].length - 1);
    let toDisc = this.stacks[to].slice(this.stacks[to].length - 1);
    if (this.stacks[from].length === 0) {
      return false;
    } else if (this.stacks[to].length === 0) {
      return true;
    } else if (fromDisc > toDisc) {
      return false;
    } else {
      return true;
    }
  }

  makeMove(from, to) {
    let fromDisc = this.stacks[from].pop();
    this.stacks[to].push(fromDisc);
    this.display();
    if (!this.gameOver()) {
      this.promptMove();
    } else {
      console.log("CONGRATSSSS!");
      this.display();
      reader.close();
    }
  }

  gameOver() {
    if (this.stacks[1].length === 3 || this.stacks[2].length === 3) {
      return true;
    } else {
      return false;
    }
  }
}


let g = new Game();

g.run();
