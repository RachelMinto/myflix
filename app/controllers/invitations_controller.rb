class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.create(invitation_params.merge!(inviter_id: current_user.id))
    if @invitation.save
      AppMailer.delay.send_invitation_email(@invitation.id)
      flash[:success] = "You have successfully invited #{@invitation.recipient_name}"
      redirect_to new_invitation_path
    else
      render :new
    end
  end

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :recipient_name, :message)
  end
end