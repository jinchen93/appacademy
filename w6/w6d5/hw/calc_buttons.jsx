import React from 'react';

export default props => {
  return(
    <div>
      <button onClick={ () => props.add() }>+</button>
      <button onClick={ () => props.subtract() }>-</button>
      <button onClick={ () => props.multiply() }>*</button>
      <button onClick={ () => props.divide() }>/</button>
    </div>
  );
};