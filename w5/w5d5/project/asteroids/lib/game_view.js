const Game = require('./game.js');
const Util = require('./utils.js');

function GameView(ctx) {
  this.ctx = ctx;
  this.game = new Game();
}

GameView.prototype.start = function(ctx) {
  setInterval(() => {
    this.game.moveObjects();
    this.game.draw(ctx);
  }, 15);
};

document.addEventListener('DOMContentLoaded', () => {
  const canvasEl = document.getElementsByTagName("canvas")[0];
  canvasEl.height = Util.height;
  canvasEl.width = Util.width;
  const ctx = canvasEl.getContext("2d");

  window.game = new GameView(ctx);
  window.game.start(ctx);
});
