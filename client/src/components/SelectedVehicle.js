import React from 'react';
import Client from './Client';

const MATCHING_ITEM_LIMIT = 10;

export default function SelectedVehicles(props) {
  state = {
    vehicles: []
  }

  handleVehicles = () => {
    Client.getVehicles((vehicles) => {
      console.log(vehicles);
      this.setState({
        vehicles: vehicles.slice(0, MATCHING_ITEM_LIMIT),
      });
    });
  };

  onVehicleClick = (vehicle) => {
    console.log(vehicle);
  };

  render() {
    const { vehicles } = this.state;
    this.handleVehicles();
    const vehicleRows = vehicles.map((vehicle, idx) => (
        <tr
          key={idx}
          onClick={() => this.props.onVehicleClick(vehicle)}
        >
        <td className='right aligned'>{vehicle.id}</td>
          <td className='right aligned'>{vehicle.name}</td>
          </tr>
        ));

    return (
      <div className='row'>
        <div className='col-lg-6'>
          <div id='vehicles'>
            <h4>Vehicles</h4>
            <table className='ui selectable structured large table table-bordered table-hover'>
              <thead class="thead-inverse">
                <tr>
                  <th>Id</th>
                  <th>Name</th>
                </tr>
              </thead>
              <tbody>
                { vehicleRows }
              </tbody>
            </table>
          </div>
        </div>
        <div className='col-lg-6'>
          <div className='App'>
            <div className='ui text container'>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

