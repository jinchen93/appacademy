import React from 'react';

class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      attack: '',
      defense: '',
      poke_type: '',
      moves: [],
      image_url: ''
    };

    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    e.preventDefault();
    let inputName = e.currentTarget.name;
    let inputVal = e.currentTarget.value;
    if (inputName === 'attack' || inputName === 'defense') {

      console.log(inputVal);
      inputVal =  !!parseInt(inputVal) ? parseInt(inputVal) : "";
    }
    if (inputName === 'moves') {
      inputVal = inputVal.split(",");
    }

    this.setState({ [inputName]: inputVal });
  }

  render() {
    const {
      name,
      attack,
      defense,
      poke_type,
      moves,
      image_url
    } = this.state;

    return (
      <section className="pokemonDetailWrapper">
        <h2>Create Pokemon!</h2>
        <form>
          <input type="text" onChange={this.handleChange}
            name="name" value={name} placeholder="Name" />
          <input type="number" onChange={this.handleChange}
            name="attack" value={attack} placeholder="Attack" />
          <input type="number" onChange={this.handleChange}
            name="defense" value={defense} placeholder="Defense" />
          {/* poke_type */}
          <input type="text" onChange={this.handleChange} name="moves"
            value={moves} placeholder="Moves (seperated by comma)"
          />
        <input type="text" onChange={this.handleChange} name="image_url"
              value={image_url} placeholder="Image URL"/>
          <button>Create Pokemon!</button>
        </form>
      </section>
    );
  }
}

export default PokemonForm;
