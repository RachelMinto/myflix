require 'spec_helper'

describe ReviewsController do 
  describe "POST create" do
    let(:video) { Fabricate(:video) }

    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }      
      
      context "with invalid inputs" do
        before do
          session[:user_id] = current_user.id
          post :create, review: { rating: 3 }, video_id: video.id                 
        end

        it "does not create a review" do
          expect(Review.count).to eq(0)
        end

        it "should render video#show" do
          expect(response).to render_template 'videos/show'
        end

        it "sets @video" do
          expect(assigns(:video)).to eq(video)
        end

        it "sets @reviews" do
          expect(assigns(:reviews)).to match_array([])
        end
      end

      context "with valid inputs" do
        before do
          session[:user_id] = current_user.id
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id                 
        end

        it "creates a review" do
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)         
        end

        it "creates a review associated with the user" do
          expect(Review.first.user).to eq(current_user)
        end

        it "redirects to video show page" do           
          expect(response).to redirect_to video
        end     
      end
    end

    context "with unauthenticated user" do
      before do
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id                 
      end

      it "should redirect to root_path" do
        expect(response).to redirect_to root_path
      end
    end    
  end
end