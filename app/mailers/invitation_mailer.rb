class InvitationMailer < ActionMailer::Base
  default :from => 'mapper.feedback@gmail.com'

  def invite(invitation)
    @invitation = invitation
    mail(:to => @invitation.mail_to, :subject => "[Invitation for Mapper] #{invitation.trip.name}")
  end
end