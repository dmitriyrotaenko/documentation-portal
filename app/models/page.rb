class Page < ApplicationRecord
  before_save :update_slug

  belongs_to :project
  belongs_to :parent, class_name: 'Page', optional: true
  has_many :pages, foreign_key: :parent_id, dependent: :destroy

  acts_as_list scope: :parent

  # Maybe project_id
  validates :title, presence: true, uniqueness: { scope: :project }

  def to_param
    slug
  end

  private

  def update_slug
    self.slug = title.parameterize
  end
end
