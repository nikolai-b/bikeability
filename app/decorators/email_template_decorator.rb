class EmailTemplateDecorator < Draper::Decorator
  include Virtus.model
  [:body, :booking, :school, :instructor, :instructor_confirm_url].each do |attr|
    attribute attr
  end

  def body
    body = @body
    MAPPINGS.each do |mapping_name|
      regex = /\<#{mapping_name}\>/
      replacement = send(mapping_name).to_s rescue ""
      body = body.gsub(regex, replacement)
    end

    body
  end

  MAPPINGS = [:teacher_name, :instructor_name, :school_name,
              :instructor_confirm_url, :formatted_date,
              :start_date, :number_of_children,
              :booking_url
  ]

  def school_name
    school.school_name
  end

  def teacher_name
    school.teacher_name
  end

  def instructor_name
    instructor.name
  end

  def number_of_children
    booking.num_children
  end

  def booking_url
    h.edit_booking_url(booking)
  end

  def start_date
    start_time.to_date.to_s
  end

  def formatted_date
    start_time.strftime("%A the #{ordinalized_date} of %B, %Y")
  end

  def ordinalized_date
    start_time.day.ordinalize
  end

  def start_time
    booking.try :start_time
  end
end
