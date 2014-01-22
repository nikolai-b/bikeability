class EmailTemplate < ActiveRecord::Base
  validates :body, presence: true
  
  def to_param
    template_name
  end

end
