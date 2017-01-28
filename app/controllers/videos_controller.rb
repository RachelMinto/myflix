class VideosController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title(params[:search])
  end

  def video_params
    params.require(:video).permit(:title, :descrption, :large_cover_url, :small_cover_url)
  end
end