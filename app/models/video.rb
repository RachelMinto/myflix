class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order "created_at DESC" }
  has_many :user_videos
  has_many :users, through: :user_videos
  # validates_presence_of :title, :description, :small_cover_url, :large_cover_url
  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

  def average_rating
    sum = 0
    self.reviews.each { |review| sum += review.rating }

    avg = (sum.to_f / reviews.size.to_f).round(1)

    avg.nan? ? 'No Rating Yet' : "#{avg} / 5.0"
  end
end