import React from "react";

class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: "",
      attack: "",
      defense: "",
      poke_type: "",
      moves: [],
      image_url: ""
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(e) {
    e.preventDefault();
    let inputName = e.currentTarget.name;
    let inputVal = e.currentTarget.value;
    if (inputName === "attack" || inputName === "defense") {
      inputVal = parseInt(inputVal);
    }
    if (inputName === "moves") {
      inputVal = inputVal.split(",");
    }
    this.setState({ [inputName]: inputVal });
  }

  renderPokeType() {
    const POKEMON_TYPES = [
      "fire",
      "electric",
      "normal",
      "ghost",
      "psychic",
      "water",
      "bug",
      "dragon",
      "grass",
      "fighting",
      "ice",
      "flying",
      "poison",
      "ground",
      "rock",
      "steel"
    ];

    return (
      <select name="poke_type" onChange={this.handleChange}>
        <option value="" disabled selected>Select type</option>
        {POKEMON_TYPES.map((poke, idx) => (
          <option key={"poke" + idx} value={poke}>{poke}</option>
        ))}
      </select>
    );
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createPokemon(this.state);
    this.setState({
      name: "",
      attack: "",
      defense: "",
      poke_type: "",
      moves: [],
      image_url: ""
    });
  }

  render() {
    const { name, attack, defense, poke_type, moves, image_url } = this.state;

    return (
      <section className="pokemonDetailWrapper">
        <h2>Create Pokemon!</h2>
        <form onSubmit={this.handleSubmit}>
          <input
            type="text"
            onChange={this.handleChange}
            name="name"
            value={name}
            placeholder="Name"
          />
          <input
            type="number"
            onChange={this.handleChange}
            name="attack"
            value={attack}
            placeholder="Attack"
          />
          <input
            type="number"
            onChange={this.handleChange}
            name="defense"
            value={defense}
            placeholder="Defense"
          />
          {this.renderPokeType()}
          <input
            type="text"
            onChange={this.handleChange}
            name="moves"
            value={moves}
            placeholder="Moves (seperated by comma)"
          />
          <input
            type="text"
            onChange={this.handleChange}
            name="image_url"
            value={image_url}
            placeholder="Image URL"
          />
          <button>Create Pokemon!</button>
        </form>
      </section>
    );
  }
}

export default PokemonForm;
