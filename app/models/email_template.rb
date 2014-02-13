class EmailTemplate < ActiveRecord::Base
  validates :body, presence: true

  def to_param
    template_name
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
