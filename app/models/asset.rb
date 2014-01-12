class Asset < ActiveRecord::Base
  belongs_to :booking

  has_attached_file :file
end
