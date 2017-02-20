class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "You have successfully added #{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "There was an error and no video was added."      
      render :new
    end
  end

  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not allowed to do that."
      redirect_to home_path unless current_user.admin?
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :description)
  end
end