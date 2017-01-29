Fabricator(:review) do
  rating { Faker::Number.between(1, 5) }
  user_id { Fabricate(:user).id }
  video_id { Fabricate(:video).id }
  comment { Faker::Lorem.paragraph(1) }
end