class SessionsController < ApplicationController
  def create
    session = params[:session]
    user = User.find_by email: session[:email].downcase
    if user && user.authenticate(session[:password])
      log_in user
      redirect_to user_path id: user.id
    else
      flash.now[:danger] = t "error_message"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
