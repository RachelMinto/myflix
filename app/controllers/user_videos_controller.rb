class UserVideosController < ApplicationController
  before_filter :require_user
  
  def index
    @queued_videos = current_user.user_videos.includes(video: :category)
  end

  def create
    if current_user.user_videos.map(&:video_id).include? video.id
      flash[:error] = "Video is already in queue."
    else
      UserVideo.create(video: video, user: current_user, order: order)
      flash[:success] = "Video successfully added to your queue."
    end

    redirect_to "/my_queue"
  end

  private

  def order
    current_user.user_videos.length + 1
  end

  def video
    Video.find(params[:video_id])
  end
end