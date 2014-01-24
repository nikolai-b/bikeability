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

  def email current_user, current_host
    EmailMailer.school_email(self, current_user, current_host)
    EmailMailer.instructor_email(self, current_user, instructor1_id)
    EmailMailer.instructor_email(self, current_user, instructor2_id)
  end

  def self.send_reminders
    bookings_schools_untouched = Booking.where(required_bikes: nil).where("start_time < ?", 14.days.from_now).where("start_time > ?", DateTime.now)
    first_user = User.first
    bookings_schools_untouched.each do |booking|
      EmailMailer.school_email(booking, first_user, 'new')
    end
    bookings_instructors_untouched = Booking.where(instructor1_available: nil)
    bookings_instructors_untouched.each do |booking|
      EmailMailer.instructor_email(booking, first_user, booking.instructor1_id)
    end

    bookings_instructors_untouched = Booking.where(instructor2_available: nil)
    bookings_instructors_untouched.each do |booking|
      EmailMailer.instructor_email(booking, first_user, booking.instructor2_id)
    end

    bookings_admin_instructor_warning = Booking.where(instructor1_available: nil).where("created_at < ?", 2.days.ago)
    bookings_admin_instructor_warning.each do |booking|
      EmailMailer.admin_instructor_warning(booking, first_user, booking.instructor1_id)
    end
     
    bookings_admin_instructor_warning = Booking.where(instructor2_available: nil).where("created_at < ?", 2.days.ago)
    bookings_admin_instructor_warning.each do |booking|
      EmailMailer.admin_instructor_warning(booking, first_user, booking.instructor2_id)
    end

    bookings_admin_school_warning = Booking.where(required_bikes: nil).where("start_time < ?", 10.days.from_now).where("start_time > ?", DateTime.now)
    bookings_admin_school_warning.each do |booking|
      EmailMailer.admin_school_warning(booking, first_user)
    end

  end

end
