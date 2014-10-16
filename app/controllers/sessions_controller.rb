class SessionsController < ApplicationController
  def new
  end

  def create
    if $previous_url.nil?
      $previous_url = request.referer
    end
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      session[:user_name] = user.email
      redirect_to $previous_url || root_url
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    $previous_url = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
