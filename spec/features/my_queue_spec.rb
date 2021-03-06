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
    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)

    visit video_path(monk)
    expect_link_not_to_be_seen '+ My Queue'

    add_video_to_queue(south_park)
    add_video_to_queue(futurama)    

    set_video_position(south_park, 1)
    set_video_position(futurama, 2)
    set_video_position(monk, 3)

    update_queue

    expect_video_position(south_park, 1)
    expect_video_position(futurama, 2)
    expect_video_position(monk, 3)
  end

  def add_video_to_queue(video)
    visit home_path
    click_on_video_on_home_page(video)
    click_link "+ My Queue"
  end

  def expect_video_to_be_in_queue(video)
    page.should have_content(video.title)
  end

  def expect_link_not_to_be_seen(link)
    page.should_not have_content link
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queued_videos[][position]", with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)  
  end

  def update_queue
    click_button "Update Instant Queue"
  end
end