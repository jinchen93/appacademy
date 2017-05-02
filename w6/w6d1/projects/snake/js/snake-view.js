const Board = require('./board');

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
    this.$grid = [];
    this.setupBoard();
    this.bindEvents();
    setInterval(() => {
      this.step();
    }, 75);
  }

  bindEvents() {
    $(document).on("keydown", event => {
      this.handleKeyEvent(event);
    });
  }

  setupBoard() {
    for (let i = 0; i < 25; i++) {
      let $row = $('<div class="row"></div>');
      for (let j = 0; j < 25; j++) {
        let $square = $('<div class="square"></div>');
        $row.append($square);
      }
      this.$grid.push($row);
      this.$el.append($row);
    }
  }

  render() {
    $('.segment').removeClass('segment');
    $('.apple').removeClass('apple');
    $('.snake-head').removeClass('snake-head');
    this.board.snake.segments.forEach(coord => {
      let $row = this.$grid[coord.pos[0]].children();
      let $square = $row.eq(coord.pos[1]);

      if (coord === this.board.snake.head) {
        $square.addClass('snake-head');
      } else {
        $square.addClass('segment');
      }
    });

    let applePos = this.board.apple.pos;
    let $row = this.$grid[applePos[0]].children();
    let $square = $row.eq(applePos[1]);
    $square.addClass('apple');
  }

  handleKeyEvent(event) {
    let key = event.keyCode;
    this.board.snake.turn(KEYPRESSES[key]);
  }

  step() {
    let snake = this.board.snake;
    let apple = this.board.apple;
    snake.move();

    if (snake.head.equals(apple.pos)) {
      snake.add();
      this.board.generateApple();
    }

    if (snake.ateSelf()) {
      alert('You ate yourself.');
      this.board = new Board(this.$el);
    }

    if (snake.outOfBounds()) {
      alert('Out of bounds!');
      this.board = new Board(this.$el);
    }

    this.render();
  }
}

module.exports = View;
