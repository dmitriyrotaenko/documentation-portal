class Page < ApplicationRecord
  before_save :update_slug
  after_create :create_slug

  belongs_to :project
  belongs_to :parent, class_name: 'Page', optional: true
  has_many :pages, foreign_key: :parent_id, dependent: :destroy

  acts_as_list scope: :parent

  validates :title, uniqueness: { scope: :project }

  scope :top_level, -> { where(parent_id: nil).order(:position) }

  def to_param
    slug
  end

  private

  def create_slug
    update_slug
    save!
  end

  def update_slug
    self.slug = [title&.parameterize, id].compact.join('-')
  end
end
