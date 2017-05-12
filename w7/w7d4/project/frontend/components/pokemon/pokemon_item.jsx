import React from 'react';
import { NavLink } from 'react-router-dom';

class PokemonItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hover: false };
    this.hoverHandler = this.hoverHandler.bind(this);
  }

  hoverHandler() {
    this.setState({
      hover: !this.state.hover
    });
  }

  render() {
    const { poke } = this.props;
    const { hover } = this.state;
    return(
      <li onMouseEnter={this.hoverHandler} onMouseLeave={this.hoverHandler}>
        <NavLink to={`/pokemon/${poke.id}`}>
          {poke.id}
          <img
            className={ hover ? "animated rubberBand" : "" }
            src={poke.image_url}
            alt={poke.name}
          />
          <span
            className={ hover ? "animated fadeInLeft poke-name" : "poke-name" }
          >
            {poke.name}
          </span>
        </NavLink>
      </li>
    );
  }
}

export default PokemonItem;
