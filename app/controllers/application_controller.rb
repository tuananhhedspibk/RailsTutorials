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

  def render_not_found
    render file: Rails.root.join("public", "404.html"),
      status: 404
  end
end
