class SessionsController < ApplicationController
  before_filter :login_required, :only => :show

  def new
    @user = User.new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to_target_or_default root_url
    else
      flash[:alert] = "Invalid email address or password."
      redirect_to new_session_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end

  def show
    @restaurants = Restaurant.find(:all).shuffle!
  end
end
