class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    user_not_found unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome_to_app"
      redirect_to user_path(id: @user.id)
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def render_not_found
    render file: Rails.root.join("public", "404.html"),
      status: 404
  end
end
