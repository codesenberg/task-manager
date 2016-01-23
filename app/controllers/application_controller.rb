class ApplicationController < ActionController::Base
  include Trailblazer::Operation::Controller
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from Trailblazer::NotAuthorizedError,
              AASM::InvalidTransition,
              ActiveRecord::RecordNotFound do
    redirect_to root_url
  end

  def params_with_user
    params.merge(current_user: current_user)
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_url
    end
  end

  def after_sign_in_path_for(resource)
    return tasks_path if resource.class == User
    super
  end
end
