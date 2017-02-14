class User < ActiveRecord::Base
  validates_presence_of :full_name, :password, :email
  validates_uniqueness_of :email
  has_many :reviews, -> { order "created_at DESC" }
  has_many :user_videos, -> { order :position }
  has_many :videos, through: :user_videos
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id

  has_secure_password validations: false

  before_create :generate_token

  def normalize_queue_item_positions
    user_videos.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end  

  def has_in_queue?(video)
    user_videos.includes(:video).map(&:video).include? video
  end

  def follows?(other_user)
    following_relationships.map(&:leader).include?(other_user)
  end

  def can_follow?(user)
    !(self.follows?(user) || self == user)
  end

  def follow(another_user)
    following_relationships.create(leader: another_user) if can_follow?(another_user)
  end
  
  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end