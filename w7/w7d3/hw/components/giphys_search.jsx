import React from 'react';
import GiphysIndex from './giphys_index';

class GiphysSearch extends React.Component {
  constructor(props) {
    super(props);

    this.state = { search: '' };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(e) {
    e.preventDefault();
    const val = e.currentTarget.value;
    this.setState({ search: val });
  }

  handleSubmit(e) {
    e.preventDefault();
    this.setState({ search: ''});
    this.props.fetchSearchGiphys(this.state.search);
  }

  render() {
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          <input
            type="text"
            onChange={this.handleChange}
            value={this.state.search}
          />
          <input type="submit" />
        </form>

        <GiphysIndex giphys={this.props.giphys} />
      </div>
    );
  }

}

export default GiphysSearch;
