require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "sets @invitation to a new invitation" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation      
    end

    it_behaves_like "requires_authenticated_user" do
      let(:action) { get :new}
    end
  end

  describe "POST create" do
    it_behaves_like "requires_authenticated_user" do
      let(:action) { post :create}
    end

    context "with valid inputs" do
      before do
        set_current_user
        post :create, { invitation: { recipient_name: 'Joe Smith', recipient_email: "joe@example.com", message: "Join Myflix!" } }        
      end

      after { ActionMailer::Base.deliveries.clear }

      it "redirects to the invitation new page" do
        expect(response).to redirect_to new_invitation_path
      end

      it "creates the invitation" do
        expect(Invitation.count).to eq(1)
      end

      it "sends the email to the recipient" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      before do
        ActionMailer::Base.deliveries.clear        
        set_current_user
        post :create, { invitation: { recipient_email: "joe@example.com", message: "Join Myflix!" } }        
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "does not create an invitation" do
        expect(Invitation.count).to eq(0)
      end

      it "does not send out an email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "sets @invitation" do
        expect(assigns(:invitation)).to be_instance_of(Invitation)
      end
    end  
  end
end