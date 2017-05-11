import React from 'react';

class PokemonItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hover: false };
    this.hoverHandler = this.hoverHandler.bind(this);
  }

  hoverHandler() {
    console.log(this.state.hover);
    this.setState({
      hover: !this.state.hover
    });
  }

  render() {
    const { poke } = this.props;
    const { hover } = this.state;
    return(
      <li onMouseEnter={this.hoverHandler} onMouseLeave={this.hoverHandler}>
        {poke.id} <img className={ hover ? "animated rubberBand" : "" } src={poke.image_url} alt={poke.name} /> <span className={ hover ? "animated fadeInLeft poke-name" : "poke-name" }>{poke.name}</span>
      </li>
    );
  }
}

export default PokemonItem;
