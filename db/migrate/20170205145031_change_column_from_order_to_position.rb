class ChangeColumnFromOrderToPosition < ActiveRecord::Migration
  def change
    rename_column :user_videos, :order, :position
  end
end
