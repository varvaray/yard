require 'rails_helper'

describe VehicleStatesController do

  let :vehicle_states do
    (1..4).each do |order|
      create :vehicle_state, order: order
    end
  end

  describe '#index' do

    before(:each) do
      vehicle_states
    end

    context 'when user' do
      sign_in_user

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'returns list of current vehicle states' do
        get :index
        expect(response.status).to eq(200)
      end
    end

    context 'when admin' do
      sign_in_user(role: :admin)

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'returns list of current vehicle states' do
        get :index
        expect(response.status).to eq(200)
      end
    end

  end

  describe '#update' do

    before(:each) do
      vehicle_states
    end

    context 'when user' do
      sign_in_user

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'returns not authorized for regular user' do
        patch :update, format: 'json', params: { vehicle_states: {}, id: VehicleState.first.id, order: 2 }
        result = JSON.parse(response.body)
        expect(response.status).to eq(401)
        expect(result['errors'].first['message']).to eq I18n.t('errors.not_authorized')
      end
    end

    context 'when admin' do
      sign_in_user(role: :admin)

      it 'success' do
        update_state = VehicleState.find_by(order: 1)
        patch :update, format: 'json', params: { id: update_state.id, order: 2 }
        result = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(result['states'].select { |state| state['id'] == update_state.id }.first['order']).to eq (2)
      end
    end

  end

  describe '#destroy' do

    before(:each) do
      vehicle_states
    end

    context 'when user' do
      sign_in_user

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'success' do
        delete :destroy, format: 'json', params: { id: VehicleState.first.id }
        result = JSON.parse(response.body)
        expect(response.status).to eq(401)
        expect(result['errors'].first['message']).to eq I18n.t('errors.not_authorized')
      end
    end

    context 'when admin' do
      sign_in_user(role: :admin)

      it 'success' do
        states_count = VehicleState.count
        delete :destroy, format: 'json', params: { id: VehicleState.first.id }
        result = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(result['states'].length).to eq (states_count - 1)
      end
    end

  end

  describe '#create' do

    before(:each) do
      vehicle_states
    end

    context 'when user' do
      sign_in_user

      it 'responds to json' do
        expect(controller.mimes_for_respond_to).to include(:json)
      end

      it 'success' do
        post :create, format: 'json', params: { name: 'new', order: 4 }
        result = JSON.parse(response.body)
        expect(response.status).to eq(401)
        expect(result['errors'].first['message']).to eq I18n.t('errors.not_authorized')
      end
    end

    context 'when admin' do
      sign_in_user(role: :admin)

      it 'return duplicated error' do
        states_count = VehicleState.count
        state = VehicleState.last
        post :create, format: 'json', params: { name: 'new', order: state.order + 1 }
        expect(response.status).to eq(200)
        expect(VehicleState.count).to eq (states_count + 1)
      end

      it 'success' do
        states_count = VehicleState.count
        state = VehicleState.first
        post :create, format: 'json', params: { name: 'new', order: state.order }
        expect(response.status).to eq(409)
        result = JSON.parse(response.body)
        expect(VehicleState.count).to eq (states_count)
        expect(result['errors'].first['message']['order'].first).to eq I18n.t('errors.duplicated_order')
      end
    end

  end
end