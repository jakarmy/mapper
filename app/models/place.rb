class Place < ActiveRecord::Base
  attr_accessible :address, :gmaps, :latitude, :longitude, :name, :image
  has_and_belongs_to_many :trips

  #acts_as_gmappable

	def gmaps4rails_address
  		address
	end
end
