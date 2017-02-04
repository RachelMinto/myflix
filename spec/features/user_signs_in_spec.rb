require 'spec_helper'

feature "user signs in" do
  background do
    User.create(full_name: 'Alice Munro', email: 'alice@hotmail.com', password: 'password')
  end

  scenario "with valid email and password" do
    visit login_path
    fill_in("Email Address", with: "alice@hotmail.com")
    fill_in("password", with: "password")
    click_button('Sign In')
    page.should have_content 'Alice Munro'
  end
end