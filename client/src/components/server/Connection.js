/* eslint-disable no-undef */
function getVehicles(cb) {
  return fetch('api/vehicles', {
      accept: 'application/json',
  }).then(checkStatus)
      .then(parseJSON)
      .then(cb);
}

function signUp(email, password, cb) {
  console.log('in a Client');
  console.log(email);
  console.log(password);
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
  return fetch(myRequest).then(checkStatus)
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

const Client = { getVehicles, signUp };
export default Client;
