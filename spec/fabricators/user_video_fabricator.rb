Fabricator(:user_video) do
  user_id { Fabricate(:user).id }
  order { [1, 2, 3, 4, 5].sample }  
  video_id { Fabricate(:video).id }
end