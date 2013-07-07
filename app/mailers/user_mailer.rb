class UserMailer < ActionMailer::Base
  default :from => 'mapper.feedback@gmail.com'

  def welcome_email(user,pass)
  	@pass = pass
    @user = user
    mail(:to => @user.email, :subject => "[Welcome to Mapper] #{user.name}")
  end
end
