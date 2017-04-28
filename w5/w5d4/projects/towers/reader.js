const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdin
});

module.exports = reader;
