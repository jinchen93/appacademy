const Game = require('./game');
const Utils = require('./Utils');

function GameView(ctx) {
  this.ctx = ctx;
  this.game = new Game();
}

GameView.prototype.start = function(ctx) {
  setInterval(() => {
    this.game.step();
    this.game.draw(ctx);
  }, 15);
};

document.addEventListener('DOMContentLoaded', () => {
  const canvasEl = document.getElementsByTagName("canvas")[0];
  canvasEl.height = Utils.height;
  canvasEl.width = Utils.width;
  const ctx = canvasEl.getContext("2d");

  window.game = new GameView(ctx);
  window.game.start(ctx);
});
