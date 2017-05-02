class HanoiView {
  constructor(game, $ele) {
    this.game = game;
    this.$ele = $ele;
    this.fromPile = undefined;
    this.render();
  }

  render() {
    this.$ele.html('');
    for (let i = 0; i < 3; i++) {
      let tower = this.game.towers[i];
      let $ul = $(`<ul></ul>`);
      $ul.data('pos', i);
      for (let j = tower.length; j < 3; j++) {
        let $li = $('<li></li>');
        $ul.append($li);
      }

      for (var k = tower.length - 1; k >= 0; k--) {
        let $li = $(`<li class="disk-${tower[k]}"></li>`);
        $ul.append($li);
      }
      this.$ele.append($ul);
    }
    if (this.game.isWon()) {
      alert('YOU WON!');
    }
    this.bindEvents();
  }


  bindEvents() {
    $('ul').on('click', event => {
      if (!this.fromPile) {
        this.fromPile = $(event.currentTarget);
        $(event.currentTarget).addClass('from');
      } else {
        this.toPile = $(event.currentTarget);
        this.fromPile.removeClass('from');

        let fromPos = this.fromPile.data('pos');
        let toPos = this.toPile.data('pos');
        if (this.game.isValidMove(fromPos, toPos)) {
          this.game.move(fromPos, toPos);
        } else {
          alert('Invalid move!');
        }
        this.toPile = undefined;
        this.fromPile = undefined;
        this.render();
      }
    });
  }
}

module.exports = HanoiView;
