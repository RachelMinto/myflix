require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:user_videos).order(:position) }  
  it { should have_many(:reviews).order("created_at DESC") }

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

  context "#follows?" do
    it "returns true if the user has a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: bob)
      expect(alice.follows?(bob)).to be_true
    end

    it "returns false if the user does not have a following relationship with the other user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      charlie = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: charlie)
      expect(alice.follows?(bob)).to be_false
    end
  end
end