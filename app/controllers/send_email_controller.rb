class SendEmailController < ApplicationController

  def create
    school = School.find(params[:school])
    booking_template = EmailTemplate.find_by(template_name: "booking")
    EmailMailer.booking_email(school, current_user, booking_template.body)
    redirect_to school, notice: 'Booking email was sent to teacher.'
  end
end
