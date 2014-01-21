class BookingEmailTemplate < EmailTemplate
  
  def self.email_body_for school
    default_body.gsub("<name>", school.teacher_name)
  end

end
