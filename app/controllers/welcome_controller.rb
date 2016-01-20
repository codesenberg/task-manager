class WelcomeController < ApplicationController
  skip_filter :authenticate_user!

  def home
    @tasks = Task.includes(:user).order(created_at: :desc).page(params[:page])
  end
end
