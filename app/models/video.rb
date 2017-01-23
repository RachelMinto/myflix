class Video < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :title, :description, :small_cover_url, :large_cover_url

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end