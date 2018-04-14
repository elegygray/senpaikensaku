class ToppagesController < ApplicationController
  def index
    if logged_in?
      @followings = current_user.followings
    end
  end
end
