require 'spec_helper'

describe UserVideosController do
  describe "GET index" do
    context "unauthenticated user" do
      before { get :index }

      it "should redirect to root path" do
        expect(response).to redirect_to root_path
      end

      it "should give an error message" do
        expect(flash[:error]).to eq("You must be logged in to do that.")
      end
    end

    context "authenticated user" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:user_video) { Fabricate(:user_video, user: user, video: video) }

      before do
        session[:user_id] = user.id
        get :index
      end

      it "should render index template" do
        expect(response).to render_template :index
      end

      it "should set @queued_videos" 

      it "should return @queued_videos ordered by order value"
    end
  end

  describe "POST create" do
    context "unauthenticated user" do
      before { post :create }

      it "should redirect to root path" do
        expect(response).to redirect_to root_path
      end

      it "should give an error message" do
        expect(flash[:error]).to eq("You must be logged in to do that.")
      end  
    end

    context "authenticated user" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }

      before do
        session[:user_id] = user.id
        get :index
      end

      context "with invalid inputs" do

        it "should give an error"
        it "should redirect to video#show"
        it "should not create a user_video"
      end

      context "with valid inputs" do
        let(:user_video) { Fabricate(:user_video) }

        it "should create a queued video" do
          expect(UserVideo.find(user_video.id)).to eq(user_video)
        end

        it "should associate queued video with user" do
          
        end
      end
    end
  end
end