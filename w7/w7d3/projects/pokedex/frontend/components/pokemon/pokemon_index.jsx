import React from 'react';
import PokemonItem from './pokemon_item';

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    const { pokemon } = this.props;

    return (
      <ul>
        {
          pokemon.map((poke) => (
            <PokemonItem key={poke.id} poke={poke} />
          ))
        }
      </ul>
    );
  }
}

export default PokemonIndex;
