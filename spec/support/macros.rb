def clear_current_user
  session[:user_id] = nil
end

def sign_in_user
  let(:alice) { Fabricate(:user) }
  session[:user_id] = alice.id
end

def current_user
  
end