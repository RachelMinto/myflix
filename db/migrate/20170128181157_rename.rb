class Rename < ActiveRecord::Migration
  def change
    rename_table :reviews_tables, :reviews
  end
end
