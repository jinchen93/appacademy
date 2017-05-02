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

  render() {
    this.$el.html('');
    for (let i = 0; i < 25; i++) {
      let $row = $('<div class="row"></div>');
      for (let j = 0; j < 25; j++) {
        let $square = $('<div class="square"></div>');
        this.board.snake.segments.forEach( seg => {
          if (seg[0] === i && seg[1] === j) {
            $square.addClass('segment');
          }
        });
        $row.append($square);
      }
      this.$el.append($row);
    }
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
