FactoryBot.define do
  factory :page do
    sequence(:title) { |n| "Page #{n}" }
    content { Faker::Lorem.paragraph }
    project { Project.first || create(:project) }
  end
end
