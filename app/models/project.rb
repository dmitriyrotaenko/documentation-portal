class Project < ApplicationRecord
  before_save :create_slug

  has_many :pages

  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 10 }

  def to_param
    slug
  end

  private

  def create_slug
    self.slug = title&.parameterize
  end
end
