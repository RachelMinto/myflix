require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should have_many(:reviews)}
  it { should have_many(:user_videos)}     
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:large_cover)}
  it { should validate_presence_of(:small_cover)}

  describe "search_by_title" do
    it "returns empty array if there is no match" do
      Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      expect(Video.search_by_title('something')).to eq([])
    end

    it "returns an array of one video for an exact match" do
      futurama = Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      expect(Video.search_by_title('futurama')).to eq([futurama])    
    end

    it "returns an array of one video for a partial match" do
      futurama = Video.create(title: 'futurama II', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      expect(Video.search_by_title('futurama')).to eq([futurama])    
    end

    it "returns an array of matches ordered by created_at DESC" do
      futurama = Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      futurama2 = Video.create(title: 'futurama II', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf", created_at: 1.day.ago)
      expect(Video.search_by_title('futurama')).to eq([futurama, futurama2])        
    end    

    it "should search_by_title and return multiple matches as an array" do
      futurama = Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      futurama2 = Video.create(title: 'futurama II', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      expect(Video.search_by_title('futurama')).to include(futurama, futurama2)        
    end

    it "should return empty array for empty search string" do
      futurama = Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      futurama2 = Video.create(title: 'futurama II', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      expect(Video.search_by_title('')).to eq([]) 
    end
  end

  describe "get video's reviews" do
    it "returns an empty array if there video has no match" do
      futurama = Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      expect(futurama.reviews).to eq([])
    end

    it "returns an array of associated reviews" do
      futurama = Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      review = Fabricate(:review, video_id: futurama.id)
      expect(futurama.reviews).to eq([review])
    end

    it "returns reviews in reverse chronological order" do
      futurama = Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      review = Fabricate(:review, video_id: futurama.id, created_at: 2.day.ago)
      review2 = Fabricate(:review, video_id: futurama.id, created_at: 4.day.ago)
      review3 = Fabricate(:review, video_id: futurama.id, created_at: 1.day.ago)
      expect(futurama.reviews).to eq([review3, review, review2])
    end
  end

  describe "#average_rating" do
    it "should return an average of all ratings with one decimal point" do
      futurama = Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      review = Fabricate(:review, video_id: futurama.id, rating: 1)
      review2 = Fabricate(:review, video_id: futurama.id, rating: 5)
      review3 = Fabricate(:review, video_id: futurama.id, rating: 5)
      expect(futurama.average_rating).to eq('3.7 / 5.0')      
    end

    it "should return 'No Rating Yet' if there are no reviews" do
      futurama = Video.create(title: 'futurama', description: 'something', small_cover_url: "asdf", large_cover_url: "asdf")
      expect(futurama.average_rating).to eq('No Rating Yet')
    end
  end
end
