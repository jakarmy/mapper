class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.string :cover_image_url

      t.timestamps
    end
  end
end
