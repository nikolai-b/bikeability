class School < ActiveRecord::Base
  has_many :bookings
  after_create :uuid

  def to_param
    uuid
  end

  def uuid
    uuid = read_attribute :uuid

    if uuid.blank?
      uuid = SecureRandom.uuid
      update_attribute :uuid, uuid
    end

    uuid
  end
end
