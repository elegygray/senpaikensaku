class CommentMailer < ApplicationMailer
  def received_email(user, comment)
    @user = user
    @comment = comment
    mail to: user.email, subject: "「先輩検索」から質問がありました"
  end
end
