class UserVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_presence_of :user_id, :video_id

  delegate :title, to: :video

  def category
    video.category.name
  end

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end
end