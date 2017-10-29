import React, { Component } from 'react';
import { Button, FormGroup, FormControl, ControlLabel } from "react-bootstrap";
import "./Login.css";
import Client from './Client';

export default class Login extends Component {
  constructor(props) {
    super(props);

    this.state = {
      email: "",
      password: "",
      role: "user"
    };
  }

  validateForm() {
    return this.state.email.length > 0 && this.state.password.length > 0;
  }

  handleChange = event => {
    this.setState({
      [event.target.id]: event.target.value
    });
  }

  handleSubmit = event => {
    console.log('submit user login');
    console.log(this.state.email);
    console.log(this.state.password);
    event.preventDefault();
    Client.signUp(this.state.email, this.state.password, (user) => {
      console.log('user');
      console.log(user);
      if (user['errors']) {

      }
      else if (user['data']) {

      }
    });
  }

render() {
  return (
    <div className="Login">
      <form onSubmit={this.handleSubmit}>
        <FormGroup controlId="email" bsSize="large">
          <ControlLabel>Email</ControlLabel>
          <FormControl
            autoFocus
            type="email"
            value={this.state.email}
            onChange={this.handleChange}
          />
        </FormGroup>
        <FormGroup controlId="password" bsSize="large">
          <ControlLabel>Password</ControlLabel>
          <FormControl
            value={this.state.password}
            onChange={this.handleChange}
            type="password"
          />
          </FormGroup>
        <Button
          block
          bsSize="large"
          disabled={!this.validateForm()}
          type="submit"
          onSubmit={this.handleSubmit.bind(this)}
        >
        Login
        </Button>
      </form>
    </div>
    );
  }
}

// export default Login;