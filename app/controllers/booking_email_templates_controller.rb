class BookingEmailTemplatesController < ApplicationController
  def edit
    booking_email_template
  end

  def update
    if booking_email_template.update(booking_email_template_params)
      flash[:notice] = 'Booking email template was successfully updated.'
    end

    render action: 'edit'
  end

  private

  def booking_email_template
    @booking_email_template ||= BookingEmailTemplate.singular_template
  end

  def booking_email_template_params
    params.require(:booking_email_template).permit(:body)
  end
end
