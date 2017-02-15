def clear_current_user
  session[:user_id] = nil
end

def current_user
  User.find(session[:user_id])
end

def sign_in_user
  alice = Fabricate(:user)
  session[:user_id] = alice.id
end

def sign_out
  visit logout_path
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit login_path
  fill_in("Email Address", with: user.email)
  fill_in("Password", with: user.password)
  click_button('Sign In')
end

def set_current_user(a_user=nil)
  user = a_user || Fabricate(:user)
  session[:user_id] = user.id
end

def click_on_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click
end
