class FeedbackMailer < ActionMailer::Base
  default :from => 'noreply@yoursite.com'

  def feedback(feedback)
    @feedback = feedback
    mail(:to => 'mapper.feedback@gmail.com', :subject => '[Feedback for Mapper] #{feedback.subject}')
  end
end
