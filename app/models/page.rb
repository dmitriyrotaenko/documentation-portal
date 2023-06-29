class Page < ApplicationRecord
  belongs_to :project
  belongs_to :parent, class_name: 'Page', optional: true
  has_many :pages, foreign_key: :parent_id, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :project_id }
end
