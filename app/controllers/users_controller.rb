class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create, :new_with_invitation_token]

  def new
    @user = User.new
  end

  def create   
    @user = User.new(user_params)
    result = UserRegister.new(@user).register(params[:stripeToken], params[:invitation_token])

    if result.successful?
      flash[:success] = "Thank you for registering with MyFlix. Please sign in now."
      redirect_to login_path
    else
      flash[:error] = result.error_message
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
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

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :token)
  end
end