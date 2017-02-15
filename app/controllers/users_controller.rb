class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create, :new_with_invitation_token]

  def new
    @user = User.new
  end

  def create   
    @user = User.new(user_params)
    if @user.save
      handle_invitation if params[:invitation_token].present?
      AppMailer.send_welcome_email(@user).deliver
      redirect_to login_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    # sign_out_current_user if current_user 
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render 'new'
    else
      redirect_to expired_token_path
    end
  end
  
  private

  def handle_invitation
    invitation = Invitation.where(token: params[:invitation_token]).first
    @user.follow(invitation.inviter)
    invitation.inviter.follow(@user)
    invitation.update_column(:token, nil)
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :token)
  end
end