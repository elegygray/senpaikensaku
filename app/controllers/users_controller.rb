class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings]
  def index
    @users = User.all.page(params[:page])
  end
  def show
    @user = User.find(params[:id])
    @information = @user.information
    @comment = Comment.new
    @comment.user_id = current_user.id
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = '編集に成功しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = '編集できませんでした'
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
