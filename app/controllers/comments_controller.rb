class CommentsController < ApplicationController
  def new
  end

  def create
    @user = User.find(params[:user_id])
    @comment = @user.comments.build(comment_params)
    @comment.user_id = @user.id
    if @comment.save!
      redirect_to @user
      CommentMailer.received_email(@user, @comment).deliver
      flash[:success] = '質問が送信されました'
    else
      flash.now[:danger] = '質問が送信されませんでした'
      redirect_to @user
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:email, :content)
  end
end
