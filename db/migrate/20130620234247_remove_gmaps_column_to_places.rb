class RemoveGmapsColumnToPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :gmaps
      end

  def down
    add_column :places, :gmaps, :boolean
  end
end
