class EmailTemplatesController < ApplicationController 
  before_action :set_email_template, only: [:show, :edit, :update, :destroy]

  # GET /email_templates
  # GET /email_templates.json
  def index
    @email_templates = EmailTemplate.all
  end

  # GET /email_templates/1
  # GET /email_templates/1.json
  def show
  end

  # GET /email_templates/1/edit
  def edit
  end

  # PATCH/PUT /email_templates/1
  # PATCH/PUT /email_templates/1.json
  def update
    if @email_template.update(email_template_params)
     flash[:notice] = 'Email template was successfully updated.'
    end

    render action: 'edit'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_template
      @template_create ||= EmailTemplate.create_templates
      @email_template = EmailTemplate.find_by(template_name: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_template_params
      params.require(:email_template).permit(:body)
    end
end
