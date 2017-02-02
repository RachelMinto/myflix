class UserVideosController < ApplicationController
  before_filter :require_user
  
  def index
    @queued_videos = current_user.user_videos.includes(video: :category)
  end

  def create
    queue_video
    redirect_to "/my_queue"
  end

  def destroy
    queue_item = UserVideo.find(params[:id])
    queue_item.destroy if current_user.user_videos.include? queue_item

    redirect_to "/my_queue"
  end

  private

  def order
    current_user.user_videos.length + 1
  end

  def video
    Video.find(params[:video_id])
  end

  def queue_video
    if current_user.user_videos.map(&:video_id).include? video.id
      flash[:error] = "Video is already in queue."
    else
      UserVideo.create(video: video, user: current_user, order: order)
      flash[:success] = "Video successfully added to your queue."
    end
  end
end