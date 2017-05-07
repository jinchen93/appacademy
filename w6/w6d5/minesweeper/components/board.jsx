import React from 'react';
import Tile from './tile';

const Board = ({ board, updateGame }) => {
  const createTile = row => (
    row.map( (tile, idx) => (
      <Tile key={'tile' + idx} tile={tile} updateGame={updateGame} />
    ))
  );

  const renderBoard = () => (
    board.grid.map( (row, idx) => (
      <div className="row" key={'row' + idx}>
        {createTile(row)}
      </div>
    ))
  );

  return (
    <div>
      {renderBoard()}
    </div>
  );
};

export default Board;