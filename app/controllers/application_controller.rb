class ApplicationController < ActionController::Base
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  respond_to :json
end
