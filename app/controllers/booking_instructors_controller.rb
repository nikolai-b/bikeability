class BookingInstructorsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:edit, :update] 

  # GET bookings/:id/instructors/:instructor_id/edit
  def edit
    @booking = Booking.find_by(uuid: params[:id])
    @school = @booking.school
    @other_instructor
    @instructor_available = @booking.booking_instructors.find_by_id(params[:instructor_id])

    if params[:instructor_id] == @booking.instructors.first.id.to_s
      @other_instructor = @booking.instructors.last
    elsif params[:instructor_id] == @booking.instructors.last.id.to_s
      @other_instructor = @booking.instructors.first 
    else
      redirect_to @booking, notice: "#{Instructor.find(params[:instructor_id]).name} is not on this booking"
    end
  end


  # PATCH/PUT /instructors/1
  # PATCH/PUT /instructors/1.json
  def update
    if @instructor.update(instructor_params)
      format.html { redirect_to @booking, notice: 'Instructor confirmation was successfully updated.' }
    else
      format.html { render action: 'edit' }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_instructors_params
    params.require(:instructor_available)
  end
end
