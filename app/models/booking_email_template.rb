class BookingEmailTemplate < EmailTemplate
  
  def self.email_body_for school
    default_body.gsub("<name>", school.teacher_name)
  end

  def self.singular_template
    first_or_initialize.singular_template
  end

  def self.default_body
    singular_template.body
  end

  def singular_template
    save(validate: false) if new_record?
    self
  end


end
