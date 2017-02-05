require 'spec_helper'

feature "user signs in" do
  background do
    User.create(full_name: 'Alice Munro', email: 'alice@hotmail.com', password: 'password')
  end

  scenario "with valid email and password" do
    alice = Fabricate(:user)
    sign_in(alice)
    page.should have_content alice.full_name
  end
end