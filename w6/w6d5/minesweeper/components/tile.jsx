import React from 'react';

const Tile = ({ tile, updateGame }) => {
  const handleClick = e => {
    updateGame(tile, e.altKey);
  };

  if (tile.explored) {
    if (tile.bombed) {
      return <div className="tile bomb" />;
    } else {
      return (
        <div className="tile empty">
          {tile.adjacentBombCount() === 0 ? '' : tile.adjacentBombCount()}
        </div>
      );
    }
  } else {
    return (
      <div onClick={handleClick} className="tile unexplored" />
    );
  }

};

export default Tile;