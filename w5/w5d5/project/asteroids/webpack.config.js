const path = require('path');

module.exports = {
  entry: './lib/game_view.js',
  output: {
    filename: 'bundle.js'
  },
  watch: true,
  externals: {
    'keymaster': 'key'
  }
};
