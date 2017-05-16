import React from "react";
import merge from "lodash/merge";
import { Link, Redirect } from "react-router-dom";

class SessionForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      username: "",
      password: "",
    };

    this.update = this.update.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(e) {
    e.preventDefault();

    const user = merge({}, this.state);
    this.props.processForm(user);
  }

  update(e) {
    e.preventDefault();
    this.setState({ [e.currentTarget.name]: e.currentTarget.value });
  }

  render() {
    const link = this.props.formType === "/login"
      ? <Link to="/signup">Signup</Link>
      : <Link to="/login">Login</Link>;

    const errors = this.props.errors.map((error, idx) => (
      <li key={idx}>{error}</li>
    ));

    if (this.props.loggedIn) {
      return <Redirect to="/" />;
    } else {
      return (
        <div>
          <h3>
            {this.props.formType === "/login" ? "Log in" : "Sign up"}
          </h3>
          {link}
          <ul>
            {errors}
          </ul>
          <form>
            <label>
              Username
              <input
                type="text"
                name="username"
                value={this.state.username}
                onChange={this.update}
              />
            </label>
            <br />
            <label>
              Password
              <input
                type="password"
                name="password"
                value={this.state.password}
                onChange={this.update}
              />
            </label>

            <button onClick={this.handleSubmit}>Submit</button>
          </form>
        </div>
      );
    }
  }
}

export default SessionForm;
