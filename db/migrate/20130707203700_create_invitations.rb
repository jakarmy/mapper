class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :hash_id
      t.integer :trip_id
      t.string :mail_to
      t.string :mail_from
      t.timestamps
    end
  end
end
