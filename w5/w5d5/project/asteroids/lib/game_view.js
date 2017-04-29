const Game = require('./game');
const Utils = require('./utils');
const key = require('../keymaster');

function GameView(ctx) {
  this.ctx = ctx;
  this.game = new Game();
}

GameView.prototype.start = function(ctx) {
  setInterval(() => {
    this.game.step();
    this.game.draw(ctx);
    this.bindKeyHandlers();
  }, 15);
};

GameView.prototype.bindKeyHandlers = function() {
  key('w', () => this.game.ship.power([0, -0.0005]));
  key('a', () => this.game.ship.power([-0.0005, 0]));
  key('s', () => this.game.ship.power([0, 0.0005]));
  key('d', () => this.game.ship.power([0.0005, 0]));
  key('space', () => this.game.ship.fireBullet());
};

document.addEventListener('DOMContentLoaded', () => {
  const canvasEl = document.getElementsByTagName("canvas")[0];
  canvasEl.height = Utils.height;
  canvasEl.width = Utils.width;
  const ctx = canvasEl.getContext("2d");

  window.game = new GameView(ctx);
  window.game.start(ctx);
});
