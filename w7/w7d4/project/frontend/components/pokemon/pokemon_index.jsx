import React from 'react';
import PokemonItem from './pokemon_item';
import PokemonDetailContainer from './pokemon_detail_container';
import PokemonFormContainer from './pokemon_form_container';
import { Route, Switch } from 'react-router-dom';

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
      <section className="pokedex">
        <section className="pokemon-list">
          <ul>
            {
              pokemon.map((poke) => (
                <PokemonItem key={poke.id} poke={poke} />
              ))
            }
          </ul>
        </section>
        <Switch>
          <Route path="/pokemon/:pokemonId" component={PokemonDetailContainer}/>
          <Route path="/" component={PokemonFormContainer}/>
        </Switch>
      </section>
    );
  }
}

export default PokemonIndex;
