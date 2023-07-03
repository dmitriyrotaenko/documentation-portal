FactoryBot.define do
  factory :page do
    sequence(:title) { |n| "Page #{n}"}
    project
  end
end