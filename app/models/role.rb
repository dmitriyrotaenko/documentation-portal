class Role < ApplicationRecord
  AVAILABLE_ROLES = %i[admin customer].freeze

  has_and_belongs_to_many :users, :join_table => :users_roles
  
  belongs_to :resource,
             polymorphic: true,
             optional: true
  

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  validates :name,
            presence: true,
            uniqueness: true,
            inclusion: { in: AVAILABLE_ROLES }

  scopify
end
