class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Welcome to Myflix!"
  end

  def send_invitation_email(invite_id)
    @invitation = Invitation.find(invite_id)   
    mail to: @invitation.recipient_email, from: "info@myflix.com", subject: "Invitation to join Myflix"        
  end

  def send_forgot_password(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Please reset your password."
  end
end