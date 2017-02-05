require 'spec_helper'

describe User do
  context "#has_in_queue?" do
    it "should return false if current user's queue does not include video" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      expect(user.has_in_queue?(video)).to eq(false)
    end

    it "should return true if current user's queue does include video" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      user_video = Fabricate(:user_video, user_id: user.id, video_id: video.id)
      expect(user.has_in_queue?(video)).to eq(true)      
    end
  end
end