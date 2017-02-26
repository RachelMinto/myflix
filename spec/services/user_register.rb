require 'spec_helper'

describe UserRegister do
  describe "#register" do
    context "valid personal info and valid card" do
      let(:charge) { double(:charge, successful?: true) }

      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end

      after { ActionMailer::Base.deliveries.clear }

      it "creates the user" do
        UserRegister.new(Fabricate.build(:user)).register("some_stripe_token", nil)
        expect(User.count).to eq(1)
      end

      it "makes the user follow the inviter" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        UserRegister.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).register("some_stripe_token", invitation.token)
        joe = User.where(email: 'joe@example.com').first
        expect(joe.follows?(alice)).to be_true
      end

      it "makes the inviter follow the user" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        UserRegister.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).register("some_stripe_token", invitation.token)        
        joe = User.where(email: 'joe@example.com').first
        expect(alice.follows?(joe)).to be_true        
      end

      it "expires the invitation upon acceptance" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        UserRegister.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).register("some_stripe_token", invitation.token)        
        joe = User.where(email: 'joe@example.com').first
        expect(Invitation.first.token).to be_nil            
      end

      it "sends email to the user" do
        UserRegister.new(Fabricate.build(:user, email: 'joe@example.com')).register("some_stripe_token", nil)
        expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
      end

      it "includes the user's name with valid inputs" do
        ActionMailer::Base.deliveries.clear
        UserRegister.new(Fabricate.build(:user, email: 'joe@example.com', full_name: 'Alice Washington')).register("some_stripe_token", nil)                     
        message = ActionMailer::Base.deliveries.last
        expect(ActionMailer::Base.deliveries.last.body).to include('Alice Washington')
      end      
    end

    context "valid personal info and declined card" do
      it "does not create a new user record" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")      
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        UserRegister.new(Fabricate.build(:user)).register("776433", nil)              
        expect(User.count).to eq(0)
      end
    end

    context "with invalid personal info" do
      before do
        ActionMailer::Base.deliveries.clear
      end

      after { ActionMailer::Base.deliveries.clear }
            
      it "does not create the user" do
        UserRegister.new(User.new(email: 'rachel@example.com')).register("776433", nil)                 
        expect(User.count).to eq(0)
      end

      it "does not charge the card" do
        StripeWrapper::Charge.should_not_receive(:create)
        UserRegister.new(User.new(email: 'rachel@example.com')).register("776433", nil) 
      end
      
      it "does not send email when user gives invalid inputs" do
        UserRegister.new(User.new(email: 'rachel@example.com')).register("776433", nil) 
        expect(ActionMailer::Base.deliveries).to be_empty   
      end      
    end 
  end
end