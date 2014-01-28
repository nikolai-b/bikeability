class Booking < ActiveRecord::Base
  belongs_to :school
  validates_numericality_of :num_children, :only_integer => true, :greater_than_or_equal_to => 4
  validates :start_time, presence: true
  after_create :uuid
  has_many :booking_instructors, dependent: :destroy
  has_many :booking_assets, dependent: :destroy
  has_many :instructors, through: :booking_instructors
  accepts_nested_attributes_for :booking_instructors

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

  def email current_user, current_host
    EmailMailer.school_email(self, current_user, current_host)
    EmailMailer.instructor_email(self, current_user)
  end

  def self.send_reminders
    bookings_schools_untouched = Booking.where(required_bikes: nil).where("start_time < ?", 14.days.from_now).where("start_time > ?", DateTime.now)
    first_user = User.first
    bookings_schools_untouched.each do |booking|
      EmailMailer.school_email(booking, first_user, 'new')
    end

    bookings_instructors_untouched = BookingInstructor.where(available: nil)
    bookings_instructors_untouched.each do |booking_instructor|
      booking = Booking.find(booking_instructor.booking_id)
      EmailMailer.instructor_email(booking, first_user)
    end

    bookings_admin_instructor_warning = BookingInstructor.where(available: nil).where("created_at < ?", 2.days.ago)
    bookings_admin_instructor_warning.each do |booking_instructor|
      EmailMailer.admin_instructor_warning(booking_instructor, first_user)
    end

    bookings_admin_school_warning = Booking.where(required_bikes: nil).where("start_time < ?", 10.days.from_now).where("start_time > ?", DateTime.now)
    bookings_admin_school_warning.each do |booking|
      EmailMailer.admin_school_warning(booking, first_user)
    end

  end

end
