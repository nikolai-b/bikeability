class EmailTemplate < ActiveRecord::Base
  validates :body, presence: true
  
  def to_param
    template_name
  end

  def self.replace_text_holders
    {"teacher_name" => "@school.teacher_name", "instructor_name" => "@instructor.name", 
     "school_name" => "@school.school_name", "start_date" => "@booking.start_time.to_date.to_s",
     "instructor_confirm_url" => "@confirm_url"}
  end
end
