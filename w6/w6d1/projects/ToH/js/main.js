const HanoiView = require('./view.js');
const HanoiGame = require('./game.js');

$( () => {
  const rootEl = $('.ToH');
  const game = new HanoiGame();
  new HanoiView(game, rootEl);
});
