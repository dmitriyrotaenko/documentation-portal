FactoryBot.define do
  factory :page do
    sequence(:title) { |n| "Page #{n}"}
    project { Project.first || create(:project)}
  end
end