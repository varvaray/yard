class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  respond_to :json
  # Ensure user is always authenticated
  # before_action :authenticate_user!

  # Ensure action is always authorized and properly scoped
  after_action :verify_authorized, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  # Redirect instead of raising
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def not_authorized exception
    respond_to do |format|
      format.json { render json: {errors: [message: t('errors.not_authorized')]}, status: 401 }
    end
  end
end
