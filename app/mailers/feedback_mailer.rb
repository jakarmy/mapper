class FeedbackMailer < ActionMailer::Base
  default :from => 'mapper.feedback@gmail.com'

  def feedback(feedback)
    @feedback = feedback
    mail(:to => 'mapper.feedback@gmail.com', :subject => "[Feedback for Mapper] #{feedback.subject}")
  end
end
