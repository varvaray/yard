module ControllerHelpers
  extend ActiveSupport::Concern

  class_methods do
    def sign_in_user(*args)
      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        @user = create :user, *args
        # ap @user
        sign_in @user
        @headers = @user.create_new_auth_token
        request.headers.merge!(@headers)
      end
    end

  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, type: :controller
end