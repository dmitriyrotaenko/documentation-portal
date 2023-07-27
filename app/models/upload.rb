class Upload < ApplicationRecord
  belongs_to :uploadable, polymorphic: true
  mount_uploader :file, FileUploader
end
