class EmailTemplate < ActiveRecord::Base
  validates :body, presence: true

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
