require 'spec_helper'

feature 'Admin adds new video' do
  scenario 'Admin successfully adds a new video' do
    admin = Fabricate(:admin)
    dramas = Fabricate(:category, name: 'Dramas')
    sign_in(admin)
    visit new_admin_video_path

    fill_in "Title", with: 'Clueless'
    select "Dramas", from: "Category"
    fill_in "Description", with: "A test video"
    attach_file "Large cover", "spec/support/uploads/clueless_large.jpg"
    attach_file "Small cover", "spec/support/uploads/clueless.jpg"
    fill_in "Video URL", with: "https://www.example.com/my_video.mp4"
    save_and_open_page
    click_button "Add Video"

    sign_out
    sign_in

    visit video_path(Video.first)
    save_and_open_page
    expect(page).to have_selector("img[src='/uploads/clueless_large.jpg']")
    expect(page).to have_selector("a[href='https://www.example.com/my_video.mp4']")
  end
end