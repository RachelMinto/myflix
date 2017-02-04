module ApplicationHelper
  def options_for_video_reviews(selected=nil)
    options_for_select([5, 4, 3, 2, 1].map { |num| [pluralize(num, "Star")]}, selected)
  end

  def formatted_rating(rating)
    return if rating.nil?
    rating == 1 ? "#{rating} Star" : "#{rating} Stars"
  end
end
