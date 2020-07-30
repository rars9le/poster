class ToppagesController < ApplicationController
  def index
    if logged_in?
      @simplepost = current_user.simpleposts.build
      @simpleposts = current_user.feed_simpleposts.order(id: :desc).page(params[:page])
    end
  end
end