require 'rails_helper'

describe VehiclesController do

  let :vehicle_states do
    (1..4).each do |order|
      create :vehicle_state, order: order
    end
  end

  let :vehicle do
    vehicle_states
    create :vehicle

  end

  describe '#index' do

    context 'when admin' do
      before(:each) do
        vehicle
      end

      sign_in_user(role: :admin)

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'returns list of vehicles' do
        get :index
        expect(response.status).to eq(200)
      end
    end

    context 'when user' do
      before(:each) do
        vehicle
      end

      sign_in_user

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'returns list of vehicles' do
        get :index
        expect(response.status).to eq(200)
      end
    end

  end

  describe '#show' do

    context 'when admin' do
      before(:each) do
        vehicle
      end

      sign_in_user(role: :admin)

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'success' do
        get :show, params: { id: Vehicle.first.id }
        expect(response.status).to eq(200)
      end
    end

    context 'when user' do
      before(:each) do
        vehicle
      end

      sign_in_user

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'success' do
        get :show, params: { id: Vehicle.first.id }
        expect(response.status).to eq(200)
      end
    end

  end

  describe '#tick' do

    context 'when admin' do
      before(:each) do
        vehicle
      end

      sign_in_user(role: :admin)

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'success' do
        vehicle = Vehicle.first
        current_state = vehicle.vehicle_state_id
        get :tick, params: { id: vehicle.id }
        expect(response.status).to eq(200)
        result = JSON.parse(response.body)
        next_state = VehicleState.order(order: :asc).where("#{VehicleState.table_name}.order > ?", current_state).pluck(:order).first
        expect(result['vehicle']['vehicle_state_id']).to eq (next_state)
      end
    end

    context 'when user' do
      before(:each) do
        vehicle
      end

      sign_in_user

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'success' do
        vehicle = Vehicle.first
        current_state = vehicle.vehicle_state_id
        get :tick, params: { id: vehicle.id }
        expect(response.status).to eq(200)
        result = JSON.parse(response.body)
        next_state = VehicleState.order(order: :asc).where("#{VehicleState.table_name}.order > ?", current_state).pluck(:order).first
        expect(result['vehicle']['vehicle_state_id']).to eq (next_state)
      end
    end

  end
end