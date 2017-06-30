class SessionsController < ApplicationController
  def create
    session = params[:session]
    user = User.find_by email: session[:email].downcase
    if user && user.authenticate(session[:password])
      log_in user
      session[:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user_path id: user.id
    else
      flash.now[:danger] = t "error_message"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
