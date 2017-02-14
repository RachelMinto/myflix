class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :recipient_email
      t.string :recipient_name
      t.integer :inviter_id
      t.text :message
      t.timestamps
    end
  end
end
