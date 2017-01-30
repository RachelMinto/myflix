class CreateUserVideosTable < ActiveRecord::Migration
  def change
    create_table :user_videos do |t|
      t.integer :order
      t.integer :user_id
      t.integer :video_id
      t.timestamps
    end
  end
end
