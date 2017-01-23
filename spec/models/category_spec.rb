require "spec_helper"

describe Category do
  it { should have_many(:videos)}

  describe "#recent_videos" do
    it "returns an empty array if no videos in that category" do
      comedy = Category.create(name: 'comedy')
      clueless = Video.create(title: 'Clueless', description: 'A rich high school stu...', large_cover_url: '/tmp/clueless_large.jpg', small_cover_url: '/tmp/clueless.jpg', category_id: nil)
      
      expect(comedy.recent_videos).to eq([])
    end

    it "should return videos in that category" do
      comedy = Category.create(name: 'comedy')
      clueless = Video.create(title: 'Clueless', description: 'A rich high school stu...', large_cover_url: '/tmp/clueless_large.jpg', small_cover_url: '/tmp/clueless.jpg', category_id: comedy.id)
      
      expect(comedy.recent_videos).to eq([clueless])
    end

    it "should not return videos not in that category" do
      comedy = Category.create(name: 'comedy')
      clueless = Video.create(title: 'Clueless', description: 'A rich high school stu...', large_cover_url: '/tmp/clueless_large.jpg', small_cover_url: '/tmp/clueless.jpg', category_id: comedy.id)
      django = Video.create(title: 'Django Unchained', description: 'With the help of a German bounty hunter...', large_cover_url: '/tmp/django_large.jpg', small_cover_url: '/tmp/django.jpg', category_id: nil)
      fuzz = Video.create(title: 'Hot Fuzz', description: 'Exceptional London cop Ni...', large_cover_url: '/tmp/hotfuzz_large.jpg', small_cover_url: '/tmp/hotfuzz.jpg', category_id: comedy.id)
      
      expect(comedy.recent_videos).not_to include(django)
    end    

    it "should not return more than 6 videos in category" do
      comedy = Category.create(name: 'comedy')
      clueless = Video.create(title: 'Clueless', description: 'A rich high school stu...', large_cover_url: '/tmp/clueless_large.jpg', small_cover_url: '/tmp/clueless.jpg', category_id: comedy.id)
      django = Video.create(title: 'Django Unchained', description: 'With the help of a German bounty hunter...', large_cover_url: '/tmp/django_large.jpg', small_cover_url: '/tmp/django.jpg', category_id: comedy.id)
      fuzz = Video.create(title: 'Hot Fuzz', description: 'Exceptional London cop Ni...', large_cover_url: '/tmp/hotfuzz_large.jpg', small_cover_url: '/tmp/hotfuzz.jpg', category_id: comedy.id)
      ig = Video.create(title: 'Inglourious Basterds', description: 'As war rages in Europe, a Nazi-scalping squad of American soldier...', large_cover_url: '/tmp/inglouriousbasterds_large.jpg', small_cover_url: '/tmp/inglouriousbasterds.jpg', category_id: comedy.id)
      madmax = Video.create(title: 'Mad Max: Fury Road', description: 'A woman rebels against a tyrannical ruler in postapocalyptic...', large_cover_url: '/tmp/madmax_large.jpg', small_cover_url: '/tmp/madmax.jpg', category_id: nil)
      mr = Video.create(title: 'Minority Report', description: 'In a future where a special police unit is able to arrest murderers...', large_cover_url: '/tmp/minorityreport_large.jpg', small_cover_url: '/tmp/minority_report.jpg', category_id: comedy.id)
      office = Video.create(title: 'The Office', description: 'A mockumentary on a group of typical office workers...', large_cover_url: '/tmp/office_large.jpg', small_cover_url: '/tmp/office.jpg', category_id: comedy.id)
      slp = Video.create(title: 'Silver Linings Playbook', description: 'After a stint in a mental institution...', large_cover_url: '/tmp/silverlinings_large.jpg', small_cover_url: '/tmp/silverlinings.jpg', category_id: comedy.id)
      simpsons = Video.create(title: 'The Simpsons', description: 'The Simpsons is an America... ', large_cover_url: '/tmp/simpsons_large.jpg', small_cover_url: '/tmp/simpsons.jpg', category_id: comedy.id)      
      
      expect(comedy.recent_videos.size).to eq(6)    
    end

    it "should return the videos from most recently created to last" do
      comedy = Category.create(name: 'comedy')
      django = Video.create(title: 'Django Unchained', description: 'With the help of a German bounty hunter...', large_cover_url: '/tmp/django_large.jpg', small_cover_url: '/tmp/django.jpg', category_id: comedy.id)
      fuzz = Video.create(title: 'Hot Fuzz', description: 'Exceptional London cop Ni...', large_cover_url: '/tmp/hotfuzz_large.jpg', small_cover_url: '/tmp/hotfuzz.jpg', category_id: nil)
      ig = Video.create(title: 'Inglourious Basterds', description: 'As war rages in Europe, a Nazi-scalping squad of American soldier...', large_cover_url: '/tmp/inglouriousbasterds_large.jpg', small_cover_url: '/tmp/inglouriousbasterds.jpg', category_id: comedy.id)
      madmax = Video.create(title: 'Mad Max: Fury Road', description: 'A woman rebels against a tyrannical ruler in postapocalyptic...', large_cover_url: '/tmp/madmax_large.jpg', small_cover_url: '/tmp/madmax.jpg', category_id: comedy.id)
      mr = Video.create(title: 'Minority Report', description: 'In a future where a special police unit is able to arrest murderers...', large_cover_url: '/tmp/minorityreport_large.jpg', small_cover_url: '/tmp/minority_report.jpg', category_id: comedy.id)
      office = Video.create(title: 'The Office', description: 'A mockumentary on a group of typical office workers...', large_cover_url: '/tmp/office_large.jpg', small_cover_url: '/tmp/office.jpg', category_id: comedy.id)
      slp = Video.create(title: 'Silver Linings Playbook', description: 'After a stint in a mental institution...', large_cover_url: '/tmp/silverlinings_large.jpg', small_cover_url: '/tmp/silverlinings.jpg', category_id: comedy.id)
      simpsons = Video.create(title: 'The Simpsons', description: 'The Simpsons is an America... ', large_cover_url: '/tmp/simpsons_large.jpg', small_cover_url: '/tmp/simpsons.jpg', category_id: comedy.id)      
      
      expect(comedy.recent_videos).to eq([simpsons, slp, office, mr, madmax, ig])          
    end
  end
end