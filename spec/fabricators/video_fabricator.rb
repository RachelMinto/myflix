Fabricator(:video) do
  title { Faker::Lorem.words(3).join(' ') }
  description { Faker::Lorem.paragraph(2) }
  large_cover_url { Faker::Internet.url }
  small_cover_url { Faker::Internet.url }
end