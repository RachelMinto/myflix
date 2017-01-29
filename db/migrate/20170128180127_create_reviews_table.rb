class CreateReviewsTable < ActiveRecord::Migration
  def change
    create_table :reviews_tables do |t|
      t.integer :rating
      t.text :comment
      t.integer :user_id
      t.timestamps
    end
  end
end
