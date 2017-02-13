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
end