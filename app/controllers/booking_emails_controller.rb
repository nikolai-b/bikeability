class BookingEmailsController < ApplicationController
  def new
    @body = BookingEmailTemplate.email_body_for(school_teacher)
  end

  def show

  end

  def create
    body = booking_email_params[:body]
    email = BookingEmailMailer.booking_email(school_teacher, current_user, body)

    email.deliver

    flash[:notice] = "Email sent"

    redirect_to root_path
  end

  private

  def school_teacher
    @school_teacher ||= SchoolTeacher.find params[:school_teacher_id]
  end

  def booking_email_params
    params.require(:booking_email).permit(:body)
  end
end
