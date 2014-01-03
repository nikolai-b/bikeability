class BookingEmailsController < ApplicationController
  def new
    @body = BookingEmailTemplate.email_body_for(school_teacher)
  end

  def create
    #send the email
  end

  private

  def school_teacher
    SchoolTeacher.find params[:school_teacher_id]
  end

  def booking_email
    @booking_email ||= BookingEmail.singular
  end

  def booking_email_params
    params.require(:booking_email).permit(:body)
  end
end
