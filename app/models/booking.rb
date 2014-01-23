class Booking < ActiveRecord::Base
  belongs_to :school
  validates_numericality_of :num_children, :only_integer => true, :greater_than_or_equal_to => 4
  after_create :uuid
  has_many :booking_assets, dependent: :destroy
  has_many :booking_instructors
  has_many :instructors, through: :booking_instructors

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

  def email current_user
    EmailMailer.school_email(self, current_user, 'new')
    EmailMailer.instructor_email(self, current_user, instructor1_id)
    EmailMailer.instructor_email(self, current_user, instructor2_id)
  end

end
