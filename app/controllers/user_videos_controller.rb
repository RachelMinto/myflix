class UserVideosController < ApplicationController
  before_filter :require_user
  
  def index
  end

  def create
    user_video = current_user.user_videos.build(user_video_params.merge!(video: Video.find(params[:id])))

    if user_video.save

    else

    end
  end

  def user_video_params
    params.require(:user_video).permit(:order)
  end
end



# @video.reviews.build(review_params.merge!(user: current_user))