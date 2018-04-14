class InformationController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  def index
  end

  def new
    if logged_in?
      if current_user.information
        redirect_to current_user
      else
        @user = current_user
        @information = current_user.build_information
      end
    end
  end

  def create
    @information = current_user.build_information(information_params)
    if @information.save
      flash[:success] = '投稿に成功しました'
      redirect_to current_user
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def destroy
    @information.destroy
    flash[:success] = '削除に成功しました'
    redirect_to root_url
  end
  
  private
  
  def information_params
    params.require(:information).permit(:highschool, :university, :faculty, :content)
  end
  
  def correct_user
    @information = current_user.information
    unless @information
      redirect_to root_url
    end
  end
end
