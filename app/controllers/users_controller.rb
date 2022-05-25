# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :get_user, only: [:show]

  def new; end

  def show; end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      user.errors.full_messages.each do |message|
      flash[:notice] = message
      render :login_form
      end
    end
  end

  def login_form; end

  def login_auth
    user = User.find_by(email: params[:email])

    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to "/users/#{user.id}"
      else
        flash[:notice] = 'invalid password'
        render :login_form
      end

    else
      flash[:notice] = 'invalid email'
      render :login_form
    end
  end

  private

  def get_user
#    @user = User.find(params[:id])
    @user = User.find(current_user.id)
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
