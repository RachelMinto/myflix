require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video with authenticated user" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id

     expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)      
      review1 = Fabricate(:review, video_id: video.id)
      get :show, id: video.id

      expect(assigns(:reviews)).to match_array([review1])
    end

    it "redirects to login_path for unauthenticated user" do
      get :show, id: 4
     expect(response).to redirect_to root_path
    end
  end

  describe "GET search" do
    it "sets @video for authenticated user" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      get :search, search: 'rama'

     expect(assigns(:videos)).to eq([futurama])
    end

    it "redirects to login_path for unauthenticated user" do
      futurama = Fabricate(:video, title: 'Futurama')
      get :search, search: 'rama'

     expect(response).to redirect_to root_path
    end
  end
end