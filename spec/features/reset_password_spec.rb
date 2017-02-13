require 'capybara/email/rspec'

feature 'user resets password' do
  background { clear_emails }

  scenario 'user requests new password link and resets password' do
    alice = Fabricate(:user, email: 'me@hotmail.com', password: 'password')

    visit home_path
    click_link "Sign In"
    click_link "Forgot Password?"
    request_password_reset_link_email
    open_email('me@hotmail.com')
    expect_email_to_be_for_password_reset
    follow_password_reset_link
    expect_password_reset_page
    reset_password
    expect_reset_success_message
    login_with_new_password
  end

  def request_password_reset_link_email
    fill_in "Email Address", with: "me@hotmail.com"
    click_button "Send Email"    
  end

  def expect_email_to_be_for_password_reset
    expect(current_email).to have_content("Please click on the link below to reset your password.")
  end

  def follow_password_reset_link
    current_email.click_link "Reset My Password"
  end

  def expect_password_reset_page
    expect(page).should have_content("Reset Your Password")
  end

  def reset_password
    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
  end

  def expect_reset_success_message
    expect(page).should have_content("Your password has been changed. Please sign in.")
  end

  def login_with_new_password
    fill_in "Email Address", with: "me@hotmail.com"      
    fill_in "Password", with: "new_password"
    click_button "Sign In"
    expect(page).should have_content("You have successfully logged in.")   
  end
end