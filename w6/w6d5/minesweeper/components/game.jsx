import React from 'react';
import Board from './board';
import * as Minesweeper from '../minesweeper';

class Game extends React.Component {
  constructor() {
    super();
    this.state = {
      board: new Minesweeper.Board(10, 10)
    };

    this.updateGame = this.updateGame.bind(this);
  }

  updateGame(tile, isFlag) {
    isFlag ? tile.toggleFlag() : tile.explore();
    
    if (this.state.board.lost() || this.state.board.won()) {
      this.state.board.revealAll();
    }
    this.setState({ board: this.state.board });
  }

  render() {
    return (
      <div>
        <Board 
          board={this.state.board} 
          updateGame={this.updateGame} 
        />
      </div>
    );
  }
}

export default Game;