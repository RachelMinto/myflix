require 'spec_helper'

feature 'user interacts with the queue' do
  background do
    User.create(full_name: 'Alice Munro', email: 'alice@hotmail.com', password: 'password')
  end

  scenario "user adds and reorders videos in the queue" do
    comedy = Fabricate(:category, name: "comedy")
    monk = Fabricate(:video, title: "Monk", category: comedy)
    futurama = Fabricate(:video, title: "Futurama", category: comedy)
    south_park = Fabricate(:video, title: "South Park", category: comedy)
    sign_in
    find("a[href='/videos/#{monk.id}']").click
    page.should have_content(monk.title)

    click_link "+ My Queue"
    page.should have_content(monk.title)

    visit video_path(monk)
    page.should_not have_content '+ My Queue'

    visit home_path
    find("a[href='/videos/#{south_park.id}']").click
    click_link "+ My Queue"

    visit home_path
    find("a[href='/videos/#{futurama.id}']").click
    click_link "+ My Queue"    
  end
end


# - [x] Login
# - [x] go to video
# - [x] click add to my queue
# - [x] visit my queue page
# - [x] check that video is present
# - [x] follow link to that video
# - [ ] make sure it is same video check that + my_queue is not visible
# - [ ] go to homepage and add more videos to queue
# - [ ] go to my_queue and reorder videos in queue
# - [ ] verify they come back in correct order
