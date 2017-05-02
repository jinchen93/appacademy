class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    $('li.square').on('click', event => {
      let $square = $(event.currentTarget);
      this.makeMove($square);
    });
  }

  makeMove($square) {
    let pos = $square.data('pos');
    try {
      this.game.playMove(pos);
    }
    catch(err) {
      alert(pos + " " + err.msg);
    }
    let $mark = this.game.board.grid[pos[0]][pos[1]];
    $square.text($mark);
    $square.addClass(`checked-${$mark}`);
    if (this.game.isOver()) {
      if (this.game.winner()) {
        let winningSeq = this.game.board.winningSeq;
        winningSeq.forEach( el => {
          $(`.pos-${el[0]}-${el[1]}`).addClass('winningblock');
        });

        let $winningStatement = $('<h2></h2>');
        $winningStatement.text(`${this.game.winner()} is the winner!`);
        $winningStatement.insertAfter('figure');
      } else {
        alert('No winner!!!');
      }
    }
  }

  setupBoard() {
    for (var i = 0; i < 3; i++) {
      let $ul = $('<ul></ul>');
      for (var j = 0; j < 3; j++) {
        let $li = $('<li></li>');
        $li.data('pos', [i,j]);
        $li.addClass(`pos-${i}-${j}`)
        $li.addClass('square');
        $ul.append($li);
      }
      this.$el.append($ul);
    }
  }
}

module.exports = View;
