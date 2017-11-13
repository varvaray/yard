import React, { Component } from 'react';
// Authorization HOC
const Authorization = (allowedRoles) =>
  (WrappedComponent) =>
    return class WithAuthorization extends React.Component {
      constructor(props) {
        super(props)

        // In this case the user is hardcoded, but it could be loaded from anywhere.
        // Redux, MobX, RxJS, Backbone...
        this.state = {
          user: {
            email: '',
            password: '',
            role: 'user'
          }
        }
      }
  render() {
    const { role } = this.state.user;
    if (allowedRoles.includes(role)) {
      return <WrappedComponent {...this.props} />
    } else {
      return <h1>No page for you!</h1>
    }
  }
}

// Route handler
class VehicleRoute extends React.Component {
  render() {
    return <div>
    /* the rest of your page */
    </div>
  }
}

export default VehicleRoute

// Router configuration
const User = Authorization(['user', 'admin'])
const Admin = Authorization(['admin'])


<Router history={BrowserHistory}>
  <LoginRoute path='/login' component={Login} />
  <Route path="/" component={App}>
    <Route path="vehicles" component={User(Users)}>
      <Route path=":id/edit" component={User(EditVehicle)} />
    </Route>
  </Route>
</Router>