class SchoolEmailTemplatesController < ApplicationController

  def edit
    school_email_template
  end

  def update
    if school_email_template.update(school_email_template_params)
      flash[:notice] = 'School email template was successfully updated.' 
    end
    render action: 'edit'
  end

  private
  
  def school_email_template
    @school_email_template ||= SchoolEmailTemplate.singular_template
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def school_email_template_params
    params.require(:school_email_template).permit(:body)
  end
end
