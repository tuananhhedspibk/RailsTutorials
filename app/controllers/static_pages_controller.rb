class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = feed.order_desc
        .paginate page: params[:page]
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  private

  def feed
    Micropost.feeds current_user.id
  end
end
