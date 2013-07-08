require 'securerandom'

class Invitation < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :hash_id, :mail_to, :mail_from
  belongs_to :trip

  def sendEmail(trip,email,from)
  	self.trip = trip
  	self.mail_to = email
  	self.hash_id = SecureRandom.hex(32)
    self.mail_from = from
  	self.save
  	InvitationMailer.invite(self).deliver
  end


end
