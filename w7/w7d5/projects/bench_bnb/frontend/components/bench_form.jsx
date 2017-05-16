import React from "react";
import { Redirect } from "react-router-dom";

class BenchForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      description: "",
      seating: "",
      lat: this.props.lat,
      lng: this.props.lng,
      formComplete: false,
    };

    this.update = this.update.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update(e) {
    const val = e.currentTarget.value;
    const name = e.currentTarget.name;
    this.setState({ [name]: val });
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props
      .createBench(this.state)
      .then(() => this.setState({ formComplete: true }));
  }

  render() {
    const { lat, lng, formComplete } = this.state;

    if (formComplete) {
      return <Redirect to="/" />;
    } else {
      return (
        <form onSubmit={this.handleSubmit}>
          <label>
            Description
            <input
              type="text"
              name="description"
              value={this.state.description}
              onChange={this.update}
            />
          </label>

          <label>
            Number of Seats
            <input
              type="number"
              name="seating"
              value={this.state.seating}
              onChange={this.update}
            />
          </label>

          <label>
            Latitude
            <input disabled type="number" name="lat" value={lat} />
          </label>

          <label>
            Longitude
            <input disabled type="number" name="lng" value={lng} />
          </label>

          <button type="submit">Submit</button>
        </form>
      );
    }
  }
}

export default BenchForm;
