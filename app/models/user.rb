class User < ActiveRecord::Base
  validates_presence_of :full_name, :password, :email
  validates_uniqueness_of :email
  has_many :reviews
  has_many :user_videos, -> { order "position ASC" }
  has_many :videos, through: :user_videos  

  has_secure_password validations: false

  def normalize_queue_item_positions
    user_videos.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end  

  def has_in_queue?(video)
    user_videos.includes(:video).map(&:video).include? video
  end
end