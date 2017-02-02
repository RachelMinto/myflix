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
        let(:alice) { Fabricate(:user) }
        let(:user_video) { Fabricate(:user_video, user_id: alice.id, order: 1) }        
      before do      
        session[:user_id] = alice.id
        get :index        
      end

      it "should render index template" do
        expect(response).to render_template :index
      end

      it "should set @queued_videos" do
        expect(assigns(:queued_videos)).to match_array([user_video])
      end

      it "should return @queued_videos ordered by order value" do
        video2 = Fabricate(:user_video, user_id: alice.id, order: 3)
        video3 = Fabricate(:user_video, user_id: alice.id, order: 2)
        expect(assigns(:queued_videos)).to match_array([user_video, video3, video2])        
      end
    end
  end

  describe "POST create" do
    context "unauthenticated user" do
      let(:video) { Fabricate(:video) }
      before { post :create, video_id: video.id }

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
      end

      context "with valid inputs" do
        before { post :create, video_id: video.id }

        it "should give a success message" do
          expect(flash[:success]).to eq("Video successfully added to your queue.")
        end

        it "should redirect to my_queue" do
          expect(response).to redirect_to "/my_queue"
        end

        it "should create a user_video" do
          expect(UserVideo.count).to eq(1)
        end

        it "should create a user_video associated with current_user" do
          expect(user.user_videos.count).to eq(1)
        end
      end

      it "does not add the video if it is already in the queue" do
        video1 = Fabricate(:video)          
        queue1 = Fabricate(:user_video, video_id: video1.id, user_id: user.id)
        post :create, video_id: video1.id
        expect(user.user_videos.count).to eq(1)        
      end

      it "should set order value to total of user's queued videos + 1" do
        video1 = Fabricate(:video)          
        video2 = Fabricate(:video)
        queue1 = Fabricate(:user_video, video: video1, user_id: user.id)
        post :create, video_id: video2.id
        queue2 = UserVideo.where(video_id: video2.id, user_id: user.id).first
        expect(queue2.order).to eq(2)
      end
    end
  end
end