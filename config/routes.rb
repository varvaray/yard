Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: { registrations: 'registrations' }

  scope '/api' do
    resources :vehicles, only: %i(index show) do
      get 'tick', on: :member
    end

    resources :vehicle_states, only: %i(index show create new destroy update) do
    end

  end
end
