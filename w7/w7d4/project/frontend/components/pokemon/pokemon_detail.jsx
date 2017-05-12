import React from 'react';
import { Route, NavLink } from 'react-router-dom';
import ItemDetailContainer from './item_detail_container';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    const { pokemonId } = this.props.match.params;
    this.props.requestSinglePokemon(pokemonId);
  }

  componentWillReceiveProps(newProps) {
    const newPokemonId = newProps.match.params.pokemonId;
    const oldPokemonId = this.props.match.params.pokemonId;
    if (oldPokemonId !== newPokemonId) {
      this.props.requestSinglePokemon(newPokemonId);
    }
  }

  render() {
    const { pokemonDetail } = this.props;
    const moves = pokemonDetail.moves ? pokemonDetail.moves.join(", ") : "";
    let items;
    if (pokemonDetail.items) {
      items = pokemonDetail.items.map((item) => (
        <li key={item.id}>
          <NavLink to={`/pokemon/${this.props.match.params.pokemonId}/item/${item.id}`}>
            <img src={item.image_url} alt="item"/>
          </NavLink>
        </li>
      ));
    } else {
      items = "";
    }

    return (
      <section className="pokemonDetailWrapper">
        <img src={pokemonDetail.image_url} alt="pokemon-details" />
        <ul className="pokemonDetailInfo">
          <li><h2>{pokemonDetail.name}</h2></li>
          <li>Type: {pokemonDetail.poke_type}</li>
          <li>Attack: {pokemonDetail.attack}</li>
          <li>Defense: {pokemonDetail.defense}</li>
          <li>Moves: {moves}</li>
        </ul>
        <section className="pokemonDetailItemsWrapper">
          <h3>Items</h3>
          <ul className="pokemonDetailItems">
            <div className="pokemon-items">
              {items}
            </div>
            <Route path="/pokemon/:pokemonId/item/:itemId"
              component={ItemDetailContainer}
            />
        </ul>
        </section>
      </section>
    );
  }
}

export default PokemonDetail;
