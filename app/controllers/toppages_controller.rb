class ToppagesController < ApplicationController
  def index
    if logged_in?
      @followings = current_user.followings.page(params[:page])
    end
  end
end
