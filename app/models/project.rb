class Project < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 10 }
end
