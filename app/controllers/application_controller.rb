class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "login_please"
      redirect_to login_url
    end
  end
end
