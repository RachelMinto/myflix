Fabricator(:video) do
  title { Faker::Lorem.words(3).join(' ') }
  description { Faker::Lorem.paragraph(2) }
  large_cover { Faker::Internet.url }
  small_cover { Faker::Internet.url }
end