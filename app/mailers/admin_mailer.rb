class AdminMailer < ActionMailer::Base
  default from: 'noreply@is-valid.org'

  def comment_notifier(comment)
    @admins = Admin.select(:email).subscribed.all.map(&:email)
    @comment = Comment.find_by_id(comment)
    mail(:to => @admins, :subject => "#{@comment.author} left a comment")
  end

  def subscription_notifier(subscribe)
    @conf_subscribe = Subscribe.find_by_email(subscribe.email)
    mail(:to => subscribe.email, :subject => 'Confirm your email')
  end

end