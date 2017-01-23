require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:large_cover_url)}
  it { should validate_presence_of(:small_cover_url)}

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
end
