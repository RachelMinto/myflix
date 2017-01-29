class PagesController < ApplicationController
  before_action :require_user, except: [:front]

  def front
    redirect_to home_path if current_user
  end
end