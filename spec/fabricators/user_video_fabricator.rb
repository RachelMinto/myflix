Fabricator(:user_video) do
  order { Faker::Number.between(1, 5) }
  user_id { Fabricate(:user).id }
  video_id { Fabricate(:video).id }
end