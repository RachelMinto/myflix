class UserVideosController < ApplicationController
  before_filter :require_user
  
  def index
    @queued_videos = current_user.user_videos.includes(:video)
  end

  def create
    queue_video
    redirect_to "/my_queue"
  end

  def destroy
    queue_item = UserVideo.find(params[:id])
    queue_item.destroy if current_user.user_videos.include? queue_item
    current_user.normalize_queue_item_positions
    redirect_to "/my_queue"
  end

  def update_queue
    begin
      update_queue_items
      current_user.normalize_queue_item_positions      
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid position numbers."
    end

    redirect_to my_queue_path
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

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queued_videos].each do |queue_item_data|
        queue_item = UserVideo.find(queue_item_data["id"])
        queue_item.update_attributes!(order: queue_item_data["order"]) if queue_item.user == current_user
      end
    end
  end
end