class Page < ApplicationRecord
  before_save :update_slug

  belongs_to :project
  belongs_to :parent, class_name: 'Page', optional: true
  has_many :pages, foreign_key: :parent_id, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :project_id }

  def to_param
    slug + id
  end

  private

  def update_slug
    self.slug = title.parameterize
  end
end
