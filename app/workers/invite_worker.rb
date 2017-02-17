# class InviteWorker
#   include Sidekiq::Worker

#   def perform(invite_id)
#     AppMailer.send_invitation_email(invite_id).deliver
#   end
# end