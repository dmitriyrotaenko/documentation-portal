class Page < ApplicationRecord
  before_save :create_slug

  belongs_to :project
  belongs_to :parent, class_name: 'Page', optional: true
  has_many :subpages, class_name: 'Page', foreign_key: :parent_id, dependent: :destroy

  validates :title, uniqueness: { scope: :parent }
  validates :title, presence: true

  acts_as_tree scope: :project

  scope :top_level, -> { where(parent_id: nil).order(:position) }
  # In future sort by views.count
  # TODO: remove index
  scope :search_by_title, ->(title) { where('title ILIKE?', "%#{title}%") }

  def to_param
    slug
  end

  private

  def create_slug
    self.slug = title&.parameterize
  end
end
