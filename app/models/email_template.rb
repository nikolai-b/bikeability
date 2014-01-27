class EmailTemplate < ActiveRecord::Base
  validates :body, presence: true
  
  def to_param
    template_name
  end

  def self.replace_text_holders
    {"teacher_name" => "@school.teacher_name", "instructor_name" => "@instructor.name", 
     "school_name" => "@school.school_name", "start_date" => "@booking.start_time.to_date.to_s",
     "instructor_confirm_url" => "@confirm_url", 
     "formatted_date" => "@booking.start_time.strftime(\"%A the \#{@booking.start_time.day.ordinalize} of %B, %Y\")",
     "number_of_children" => "@booking.num_children", "booking_url" => "edit_booking_url(@booking)"}
  end

  def self.find_by(*args)
    @template_create ||= EmailTemplate.create_templates
    super *args
  end

  private

  def self.create_templates
    template_names = ["admin_booking_updated", "booking", "school", "instructor", "admin_instructor_warning", "admin_school_warning"]

    template_names.each do |template_name|
      template_exists = EmailTemplate.where(template_name: template_name).take
      EmailTemplate.create!(template_name: template_name, body: "Test") unless template_exists
    end
  end
end
