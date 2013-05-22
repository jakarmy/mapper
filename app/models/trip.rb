class Trip < ActiveRecord::Base
  attr_accessible :cover_image_url, :name
  has_and_belongs_to_many :users, :places
end
