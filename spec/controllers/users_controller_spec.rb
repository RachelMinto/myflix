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
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to login_path" do
        expect(response).to redirect_to login_path
      end

      it "makes the user follow the inviter" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'Joe Doe'}, invitation_token: invitation.token
        joe = User.where(email: 'joe@example.com').first
        expect(joe.follows?(alice)).to be_true
      end

      it "makes the inviter follow the user" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'Joe Doe'}, invitation_token: invitation.token
        joe = User.where(email: 'joe@example.com').first
        expect(alice.follows?(joe)).to be_true        
      end

      it "expires the invitation upon acceptance" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'Joe Doe'}, invitation_token: invitation.token
        joe = User.where(email: 'joe@example.com').first
        expect(Invitation.first.token).to be_nil            
      end
    end

    context "email sending" do
      before { ActionMailer::Base.deliveries.clear }      
      after { ActionMailer::Base.deliveries.clear }

      it "sends to the user if valid inputs" do
        post :create, user: {email: 'fake@hotmail.com', full_name: "Alice W.", password: 'password'}
        message = ActionMailer::Base.deliveries.last
        message.to.should == ['fake@hotmail.com']
      end

      it "includes the user's name with valid inputs" do
        post :create, user: {email: 'fake@hotmail.com', full_name: "Alice W.", password: 'password'}
        message = ActionMailer::Base.deliveries.last
        message.body.should include("Alice W.")       
      end

      it "does not send email when user gives invalid inputs" do
        post :create, user: {email: 'fake@hotmail.com'}
        expect(ActionMailer::Base.deliveries).to be_empty   
      end
    end

    context "with invalid input" do
      before do
        post :create, :user => { full_name: 'Rachel Minto', password: 'password'}                 
      end 

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "renders new template" do
        expect(response).to render_template('new')
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
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