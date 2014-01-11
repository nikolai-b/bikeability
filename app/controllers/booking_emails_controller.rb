class BookingEmailsController < ApplicationController
  def new
    @body = BookingEmailTemplate.email_body_for(school)
  end

  def show

  end

  def create
    body = booking_email_params[:body]
    email = BookingEmailMailer.booking_email(school, current_user, body)

    email.deliver

    flash[:notice] = "Email sent"

    redirect_to root_path
  end

  private

  def school
    @school ||= School.find(params[:school_id])
  end

  def booking_email_params
    params.require(:booking_email).permit(:body)
  end
end
