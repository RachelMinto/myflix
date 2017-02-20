require "spec_helper"

describe Category do
  it { should have_many(:videos)}

  describe "#recent_videos" do
    it "returns an empty array if no videos in that category" do
      comedy = Category.create(name: 'comedy')
      clueless = Video.create(title: 'Clueless', description: 'A rich high school stu...', large_cover: '/tmp/clueless_large.jpg', small_cover: '/tmp/clueless.jpg', category_id: nil)
      
      expect(comedy.recent_videos).to eq([])
    end

    it "should return videos in that category" do
      comedy = Category.create(name: 'comedy')
      clueless = Video.create(title: 'Clueless', description: 'A rich high school stu...', large_cover: '/tmp/clueless_large.jpg', small_cover: '/tmp/clueless.jpg', category_id: comedy.id)
      
      expect(comedy.recent_videos).to eq([clueless])
    end

    it "should not return videos not in that category" do
      comedy = Category.create(name: 'comedy')
      clueless = Video.create(title: 'Clueless', description: 'A rich high school stu...', large_cover: '/tmp/clueless_large.jpg', small_cover: '/tmp/clueless.jpg', category_id: comedy.id)
      django = Video.create(title: 'Django Unchained', description: 'With the help of a German bounty hunter...', large_cover: '/tmp/django_large.jpg', small_cover: '/tmp/django.jpg', category_id: nil)
      fuzz = Video.create(title: 'Hot Fuzz', description: 'Exceptional London cop Ni...', large_cover: '/tmp/hotfuzz_large.jpg', small_cover: '/tmp/hotfuzz.jpg', category_id: comedy.id)
      
      expect(comedy.recent_videos).not_to include(django)
    end    

    it "should not return more than 6 videos in category" do
      comedy = Category.create(name: 'comedy')
      clueless = Video.create(title: 'Clueless', description: 'A rich high school stu...', large_cover: '/tmp/clueless_large.jpg', small_cover: '/tmp/clueless.jpg', category_id: comedy.id)
      django = Video.create(title: 'Django Unchained', description: 'With the help of a German bounty hunter...', large_cover: '/tmp/django_large.jpg', small_cover: '/tmp/django.jpg', category_id: comedy.id)
      fuzz = Video.create(title: 'Hot Fuzz', description: 'Exceptional London cop Ni...', large_cover: '/tmp/hotfuzz_large.jpg', small_cover: '/tmp/hotfuzz.jpg', category_id: comedy.id)
      ig = Video.create(title: 'Inglourious Basterds', description: 'As war rages in Europe, a Nazi-scalping squad of American soldier...', large_cover: '/tmp/inglouriousbasterds_large.jpg', small_cover: '/tmp/inglouriousbasterds.jpg', category_id: comedy.id)
      madmax = Video.create(title: 'Mad Max: Fury Road', description: 'A woman rebels against a tyrannical ruler in postapocalyptic...', large_cover: '/tmp/madmax_large.jpg', small_cover: '/tmp/madmax.jpg', category_id: nil)
      mr = Video.create(title: 'Minority Report', description: 'In a future where a special police unit is able to arrest murderers...', large_cover: '/tmp/minorityreport_large.jpg', small_cover: '/tmp/minority_report.jpg', category_id: comedy.id)
      office = Video.create(title: 'The Office', description: 'A mockumentary on a group of typical office workers...', large_cover: '/tmp/office_large.jpg', small_cover: '/tmp/office.jpg', category_id: comedy.id)
      slp = Video.create(title: 'Silver Linings Playbook', description: 'After a stint in a mental institution...', large_cover: '/tmp/silverlinings_large.jpg', small_cover: '/tmp/silverlinings.jpg', category_id: comedy.id)
      simpsons = Video.create(title: 'The Simpsons', description: 'The Simpsons is an America... ', large_cover: '/tmp/simpsons_large.jpg', small_cover: '/tmp/simpsons.jpg', category_id: comedy.id)      
      
      expect(comedy.recent_videos.size).to eq(6)    
    end

    it "should return the videos from most recently created to last" do
      comedy = Category.create(name: 'comedy')
      django = Video.create(title: 'Django Unchained', description: 'With the help of a German bounty hunter...', large_cover: '/tmp/django_large.jpg', small_cover: '/tmp/django.jpg', category_id: comedy.id)
      fuzz = Video.create(title: 'Hot Fuzz', description: 'Exceptional London cop Ni...', large_cover: '/tmp/hotfuzz_large.jpg', small_cover: '/tmp/hotfuzz.jpg', category_id: nil)
      ig = Video.create(title: 'Inglourious Basterds', description: 'As war rages in Europe, a Nazi-scalping squad of American soldier...', large_cover: '/tmp/inglouriousbasterds_large.jpg', small_cover: '/tmp/inglouriousbasterds.jpg', category_id: comedy.id)
      madmax = Video.create(title: 'Mad Max: Fury Road', description: 'A woman rebels against a tyrannical ruler in postapocalyptic...', large_cover: '/tmp/madmax_large.jpg', small_cover: '/tmp/madmax.jpg', category_id: comedy.id)
      mr = Video.create(title: 'Minority Report', description: 'In a future where a special police unit is able to arrest murderers...', large_cover: '/tmp/minorityreport_large.jpg', small_cover: '/tmp/minority_report.jpg', category_id: comedy.id)
      office = Video.create(title: 'The Office', description: 'A mockumentary on a group of typical office workers...', large_cover: '/tmp/office_large.jpg', small_cover: '/tmp/office.jpg', category_id: comedy.id)
      slp = Video.create(title: 'Silver Linings Playbook', description: 'After a stint in a mental institution...', large_cover: '/tmp/silverlinings_large.jpg', small_cover: '/tmp/silverlinings.jpg', category_id: comedy.id)
      simpsons = Video.create(title: 'The Simpsons', description: 'The Simpsons is an America... ', large_cover: '/tmp/simpsons_large.jpg', small_cover: '/tmp/simpsons.jpg', category_id: comedy.id)      
      
      expect(comedy.recent_videos).to eq([simpsons, slp, office, mr, madmax, ig])          
    end
  end
end