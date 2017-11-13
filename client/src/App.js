import React, { Component } from 'react';
import Login from './components/Login';

class App extends Component {
  state = {
    login:[]
  }

  render() {
    const { login } = this.state;
    return (
      <div className='row'>
        <div className='col-lg-12'>
          <div className='App'>
            <Login
              login={Login}
            />
          </div>
        </div>
      </div>
    );
  }
}


export default App;
