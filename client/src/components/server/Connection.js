/* eslint-disable no-undef */

function signIn(email, password, cb) {
  console.log('signIn');
  var headers = new Headers();
  headers.append("content-type", "application/json");
  var initRequest = {
    method: "POST",
    headers: headers,
    accept: 'application/json',
    body: JSON.stringify({
      email: email,
      password: password
    })
  };
  var myRequest = new Request('auth/sign_in', initRequest);
  return fetch(myRequest).then(saveSession)
      .then(cb);
}

function saveSession(response) {
  if (response.status >= 200 && response.status < 300) {
    var headers = {};
    headers['access-token'] = response.headers.get('access-token');
    headers['uid'] = response.headers.get('uid');
    headers['client'] = response.headers.get('client');
    headers['expiry'] = response.headers.get('expiry');

    localStorage.setItem('headers', JSON.stringify(headers));
    console.log(response.headers);
    console.log(response.headers.get('Content-Type'));
    console.log(response.headers.get('access-token'));
    console.log(response.headers.get('client'));
    console.log(response.headers.get('uid'));
    console.log(response.headers.get('expiry'));
    return response
    //   sessionStorage.setItem("uid", xhr.getResponseHeader("uid"));
    //   sessionStorage.setItem("client", xhr.getResponseHeader("client"));
    //   sessionStorage.setItem("access-token", xhr.getResponseHeader("access-token"));
  } else {
    return new Error(response.statusText)
  }
}

function getVehicles(cb) {
  var headers = new Headers();
  headers.append("content-type", "application/json");

  var savedSession = localStorage.getItem('headers');

  savedSession.forEach(function(entry) {
    console.log(entry);
  });

  headers.append("content-type", "application/json");
  headers.append("content-type", "application/json");
  headers.append("content-type", "application/json");
  headers.append("content-type", "application/json");

  return fetch('api/vehicles', {
    accept: 'application/json'
  }).then(checkStatus)
  .then(parseJSON)
  .then(cb);
}

function checkStatus(response) {
  if (response.status >= 200 && response.status < 300) {
    console.log(response.headers);
    console.log(response.headers.get('Content-Type'));
    console.log(response.headers.get('Date'));
    console.log(response.headers.get('access-token'));
    console.log(response.headers.get('client'));
    return Promise.resolve(response)
    //   sessionStorage.setItem("uid", xhr.getResponseHeader("uid"));
    //   sessionStorage.setItem("client", xhr.getResponseHeader("client"));
    //   sessionStorage.setItem("access-token", xhr.getResponseHeader("access-token"));
  } else {
    return Promise.reject(new Error(response.statusText))
  }
}

function parseJSON(response) {
  console.log(response);
  return response.json();
}

const Client = { getVehicles, signIn };
export default Client;
