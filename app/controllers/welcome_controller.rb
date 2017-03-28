# WelcomeController serves home page for unregistered users
class WelcomeController < ApplicationController
  skip_action_callback :authenticate_user!

  def home
    @tasks = Task.includes(:user).order(created_at: :desc).page(params[:page])
  end
end
