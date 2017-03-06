require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    before { get :new }
    
    it "sets @user" do
      expect(assigns(:user)).to be_instance_of(User)
    end

    it "renders a new user form" do
      expect(response).to render_template('new')
    end    
  end

  describe 'POST create' do
    context "successful user sign up" do
      it "redirects to login_path" do
        result = double(:register_result, successful?: true)
        UserRegister.any_instance.should_receive(:register).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to login_path
      end
    end

    context "unsuccessful user sign up" do
      before do
        result = double(:register_result, successful?: false, error_message: "This is an error message.")
        UserRegister.any_instance.should_receive(:register).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)        
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "sets the flash error message" do
        expect(flash[:error]).to eq("This is an error message.")
      end      
    end
  end

  describe "GET show" do
    it_behaves_like "requires_authenticated_user" do
      let(:action) { get :show, id: 4 }
    end

    it "sets @user" do
      sign_in_user
      bob = Fabricate(:user)
      get :show, id: bob.id
      expect(assigns(:user)).to eq(bob)
    end       
  end

  describe "GET new_with_invitation_token" do
    it "renders the :new view template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template 'new'  
    end

    it "sets @user with recipient's email address" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it "sets @invitation_token with recipient's email address" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end    

    it "redirects to expired token page for invalid tokens" do
      get :new_with_invitation_token, token: 'asdg23'
      expect(response).to redirect_to expired_token_path      
    end
  end
end