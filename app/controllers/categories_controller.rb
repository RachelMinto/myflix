class CategoriesController < ApplicationController
  before_action :require_user
  
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @videos = Video.where(category_id: params[:id])
  end
end