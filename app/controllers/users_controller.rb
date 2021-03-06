require 'fastercsv'

class UsersController < ApplicationController
  before_filter :login_from_cookie, :only => [:show, :all_users]
  before_filter :login_required, :except => [:new, :create]
  before_filter :admin_login, :only => [:show_all_users_csv, :all_users, :destroy]

  def new
    @user = User.new
  end

  def create
    terms = params[:terms].nil? ? "0" : "1"
    params[:user].merge!({:terms => terms}) unless params[:user].nil?
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'sessions/new'
    end
  end

  def edit
    user_being_edited = User.find(params[:id])
    @user = user_being_edited if current_user_is_admin? or current_user.email == user_being_edited.email
    flash[:referrer] = request.referrer
  end

  def admin_update
    redirect_to flash[:referrer] and return if params["cancel"]
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to all_users_url, :notice => "User details have been updated."
    else
      render :action => "users/edit", :notice => 'There were errors. Please check all values and try again.'
    end
  end

  def show
    @user = current_user
    flash[:referrer] = user_url
  end

  def all_users_csv
    users = User.all
    users_csv = FasterCSV.generate do |csv|
      csv << ["email", "first_name", "last_name", "zip_code", "created_at"]
      users.each { |u| csv << [u.email, u.first_name, u.last_name, u.zip_code, u.created_at] }
    end
    send_data users_csv, :type => 'test/plain', :filename => 'users.csv', :disposition => 'attachment'
  end

  def all_users
    @users = User.find(:all)
  end

  def destroy
    User.find(params[:id].to_i).destroy
    redirect_to all_users_url, :notice => "User deleted successfully"
  end
end
