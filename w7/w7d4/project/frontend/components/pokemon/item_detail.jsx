import React from 'react';

const ItemDetail = props => {
  console.log(props.ownProps);
  console.log(props);
  return(
    <div className="pokemon-item-properties">
      <li><h4>{props.item.name}</h4></li>
      <li>Happiness: {props.item.happiness}</li>
      <li>Price: ${props.item.price}</li>
    </div>
  );
};

export default ItemDetail;
