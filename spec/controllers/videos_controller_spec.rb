require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video with authenticated user" do
      sign_in_user
      video = Fabricate(:video)
      get :show, id: video.id

     expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for authenticated users" do
      sign_in_user
      video = Fabricate(:video)      
      review1 = Fabricate(:review, video_id: video.id)
      get :show, id: video.id

      expect(assigns(:reviews)).to match_array([review1])
    end

    context "with unauthenticated user" do
      it_behaves_like "requires_authenticated_user" do
        let(:action) { get :show, id: 4 }
      end
    end    
  end

  describe "GET search" do
    it "sets @video for authenticated user" do
      sign_in_user
      futurama = Fabricate(:video, title: 'Futurama')
      get :search, search: 'rama'

     expect(assigns(:videos)).to eq([futurama])
    end

    context "with unauthenticated user" do
      it_behaves_like "requires_authenticated_user" do
        let(:action) { get :search, search: 'rama' }
      end
    end
  end
end