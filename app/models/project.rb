class Project < ApplicationRecord
  has_many :pages

  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 10 }
end
