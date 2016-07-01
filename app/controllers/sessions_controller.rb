class SessionsController < ApplicationController
  def new
  end

  def create
    if session[:return_to].nil?
      session[:return_to] = request.referer
    end

    if request.env['REQUEST_PATH'] == "/auth/github/callback"
      user = User.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid]) || User.create_from_omniauth(auth_hash)
    else
      if params[:session][:email].empty? || params[:session][:password].empty?
        user = nil
      else
        user = User.authenticate(params[:session][:email].downcase, params[:session][:password])
      end
    end

    if user
      sign_in user
      #session[:user_id] = user.id
      #session[:user_name] = user.name
      #redirect_to :back
      #if request.referer =~ /session|sign_in/
      #  redirect_to user || root_url
      #else
        #redirect_to $previous_url || root_url
        redirect_back_or user
      #end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render "new"
    end
  end

  def destroy
    sign_out
    #session[:user_id] = nil
    #$previous_url = nil
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
