class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create

  end

  private

  def user_params
    params.require(:user).permit.require(:email, :password_digest, :full_name)
  end
end