class Place < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :name, :image
  has_and_belongs_to_many :trips
  has_many :images
end
