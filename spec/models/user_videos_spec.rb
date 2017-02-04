require "spec_helper"

describe UserVideo do
  it { should belong_to(:user)}
  it { should belong_to(:video)}
  it { should validate_numericality_of(:order).only_integer }

  context "#title" do
    let(:video) { Fabricate(:video, title: 'Futurama') }
    let(:user_video) { Fabricate(:user_video, video_id: video.id) }
    it "returns title of queued video" do
      expect(user_video.title).to eq('Futurama')
    end
  end

  context "#category" do
    let(:category) { Fabricate(:category, name: 'Comedy')}
    let(:video) { Fabricate(:video, category: category) }    
    let(:user_video) { Fabricate(:user_video, video_id: video.id) }
    it "returns category of queued video" do
      expect(user_video.category).to eq('Comedy')
    end    
  end

  context "#rating" do
    let(:video) { Fabricate(:video) }
    let(:alice) { Fabricate(:user) }
    let(:user_video) { Fabricate(:user_video, user_id: alice.id, video_id: video.id) } 

    it "returns rating for video if present" do
      review = Fabricate(:review, video_id: video.id, user_id: alice.id, rating: 2)
      expect(user_video.rating).to eq(2)
    end

    it "returns nil if no rating is present" do
      expect(user_video.rating).to eq(nil)
    end
  end

  context "#rating=" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }

    it "changes the rating of the review if the review is present" do
      review = Fabricate(:review, user_id: user.id, video_id: video.id, rating: 2)
      user_video = Fabricate(:user_video, user_id: user.id, video_id: video.id)
      user_video.rating = 4
      expect(Review.first.rating).to eq(4)
    end

    it "clears the rating of the review if the review is present" do
      review = Fabricate(:review, user_id: user.id, video_id: video.id, rating: 2)
      user_video = Fabricate(:user_video, user_id: user.id, video_id: video.id)
      user_video.rating = nil
      expect(Review.first.rating).to be_nil
    end

    it "creates a review with the rating if the review is not present" do
      user_video = Fabricate(:user_video, user_id: user.id, video_id: video.id)
      user_video.rating = 3
      expect(Review.first.rating).to eq(3)   
    end
  end
end
