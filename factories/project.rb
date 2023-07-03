FactoryBot.define do
  factory :project do
    title { Faker::Lorem.words }
    description { Faker::Lorem.words }
  end
end