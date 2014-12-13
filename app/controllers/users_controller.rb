# encoding: utf-8
class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]

  def new
    unless current_user.nil?
      flash[:error] = 'You already have account, need more? Please Sign Out first!'
      redirect_to current_user
    end
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    conversation = @user.mailbox.inbox.first
    @receipts = conversation.receipts_for @user unless conversation.nil?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to 虎 妞 网'
      #redirect_to sign_in_path
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to sign_in_url, notice: "Please Sign In."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
