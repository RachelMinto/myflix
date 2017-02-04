require 'spec_helper'

describe UserVideosController do
  describe "GET index" do
    it_behaves_like "requires_authenticated_user" do
      let(:action) { get :index }
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

  describe "DELETE destroy" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    let(:video2) { Fabricate(:video) }    
    let(:user_video) { Fabricate(:user_video, video_id: video.id, user_id: user.id, order: 1)}

    context "authenticated user" do
      before do
        session[:user_id] = user.id
      end

      context "with valid inputs" do
        before do
          user_video2 = Fabricate(:user_video, video_id: video2.id, user_id: user.id, order: 2)  
          delete :destroy, id: user_video.id
        end

        it "redirects to the my queue page" do
          expect(response).to redirect_to('/my_queue')
        end

        it "deletes the queue item" do
          expect(user.user_videos.count).to eq(1)
        end

        it "normalizes the position of all remaining videos" do
          expect(UserVideo.first.order).to eq(1)          
        end
      end

      it "does not delete the queue item if it does not belong to the user" do
        bob = Fabricate(:user)
        video2 = Fabricate(:video)
        user_video1 = Fabricate(:user_video, video_id: video.id, user_id: user.id)
        user_video2 = Fabricate(:user_video, video_id: video2.id, user_id: bob.id)

        delete :destroy, id: user_video2.id
        expect(user.user_videos.count).to eq(1)       
      end
    end

    it_behaves_like "requires_authenticated_user" do
      let(:action) { delete :destroy, id: user_video.id  }
    end        
  end

  describe "POST update_queue" do
    context "with authenticated user" do
      let(:alice) { Fabricate(:user) }

      before do
        session[:user_id] = alice.id
      end 

      context "with valid inputs" do
        it "redirects to my_queue page" do
          queued_video1 = Fabricate(:user_video, user: alice, order: 1)
          queued_video2 = Fabricate(:user_video, user: alice, order: 2)
          post :update_queue, queued_videos: [{id: queued_video1.id, order: 2}, {id: queued_video2.id, order: 1}]
          expect(response).to redirect_to my_queue_path
        end

        it "reorders the queued items" do
          queued_video1 = Fabricate(:user_video, user_id: alice.id, order: 1)
          queued_video2 = Fabricate(:user_video, user_id: alice.id, order: 2)
          post :update_queue, queued_videos: [{id: queued_video1.id, order: 2}, {id: queued_video2.id, order: 1}]
          expect(alice.user_videos).to match_array([queued_video2, queued_video1])
        end

        it "normalizes the queued items position numbers" do
          queued_video1 = Fabricate(:user_video, user_id: alice.id, order: 1)
          queued_video2 = Fabricate(:user_video, user_id: alice.id, order: 2)
          post :update_queue, queued_videos: [{id: queued_video1.id, order: 3}, {id: queued_video2.id, order: 2}]
          expect(alice.user_videos.map(&:order)).to match_array([1, 2])
        end

        it "should create a new rating for a video that doesn't have a current user rating" do
          queued_video1 = Fabricate(:user_video, user_id: alice.id, order: 1)
          post :update_queue, queued_videos: [{id: queued_video1.id, order: 3, rating: 3}]
          expect(queued_video1.reload.rating).to eq(3)         
        end

        it "should update a rating for a video that has a rating by current existing user" do
          queued_video1 = Fabricate(:user_video, user_id: alice.id, order: 1)
          review = Fabricate(:review, user_id: alice.id, video_id: queued_video1.id, rating: 2)
          post :update_queue, queued_videos: [{id: queued_video1.id, order: 3, rating: 1}]
          expect(queued_video1.rating).to eq(1)       
        end

        it "should not create a new review if a review already exists" do
          video = Fabricate(:video, title: "Futurama")
          review = Fabricate(:review, user_id: alice.id, video_id: video.id, rating: 2)          
          queued_video1 = Fabricate(:user_video, user_id: alice.id, order: 1, video_id: video.id)

          post :update_queue, queued_videos: [{id: queued_video1.id, order: 3, rating: 1}]
          expect(Review.count).to eq(1)              
        end
      end
    end

    context "with invalid inputs" do
      let(:alice) { Fabricate(:user) }
      let(:queued_video1) { Fabricate(:user_video, user_id: alice.id, order: 1) }

      before do
        session[:user_id] = alice.id
        queued_video2 = Fabricate(:user_video, user_id: alice.id, order: 2)
        post :update_queue, queued_videos: [{id: queued_video1.id, order: 3.5}, {id: queued_video2.id, order: 2}]
      end 

      it "redirects to my_queue" do
        expect(response).to redirect_to my_queue_path      
      end

      it "sets the flash error message" do
        expect(flash[:error]).to be_present
      end

      it "does not change the queue items" do
        expect(queued_video1.reload.order).to eq(1)             
      end
    end

    context "with unauthenticated user" do
      it_behaves_like "requires_authenticated_user" do
        let(:action) { post :update_queue, queued_videos: [{id: 1, order: 2}] }
      end
    end

    context "with queue items that do not belong to the current_user" do
      it "should not change the queue_items" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        bob = Fabricate(:user)
        queued_video1 = Fabricate(:user_video, user_id: bob.id, order: 1)
        queued_video2 = Fabricate(:user_video, user_id: alice.id, order: 2)
        post :update_queue, queued_videos: [{id: queued_video1.id, order: 2}, {id: queued_video2.id, order: 1}]
        expect(queued_video1.reload.order).to eq(1)               
      end
    end
  end
end