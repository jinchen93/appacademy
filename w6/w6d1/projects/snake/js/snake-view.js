const Board = require('./board.js');

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
    }, 100);
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
    $('.segment').removeClass('segment')
    this.board.snake.segments.forEach(coord => {

      let $row = this.$grid[coord.pos[0]].children();
      let $square = $row.eq(coord.pos[1]);
      $square.addClass('segment');
    });
  }

  handleKeyEvent(event) {
    let key = event.keyCode;
    this.board.snake.turn(KEYPRESSES[key]);
  }

  step() {
    this.board.snake.move();
    this.render();
  }
}

module.exports = View;
