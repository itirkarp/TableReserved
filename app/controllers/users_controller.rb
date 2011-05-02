require 'fastercsv'

class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  before_filter :admin_login, :only => :show_all_users_csv

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
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end

  def show
    @user = current_user
  end

  def all_users_csv
    users = User.all
    users_csv = FasterCSV.generate do |csv|
      csv << ["email", "first_name", "last_name", "zip_code", "created_at"]
      users.each { |u| csv << [u.email, u.first_name, u.last_name, u.zip_code, u.created_at]}
    end
    send_data users_csv, :type => 'test/plain', :filename => 'users.csv', :disposition => 'attachment'
  end

end
