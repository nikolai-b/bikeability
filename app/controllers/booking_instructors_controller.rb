class BookingInstructorsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:edit, :update] 

  # GET bookings/:id/instructors/:instructor_id/edit
  def edit
    @booking = Booking.find_by(uuid: params[:id])
    @school = School.find(@booking.school_id)
    @other_instructor
    @instructor_available

    if params[:instructor_id] == @booking.instructor1_id.to_s
      @other_instructor = Instructor.find(@booking.instructor2_id)
      @instructor_available = :instructor1_available
    elsif params[:instructor_id] == @booking.instructor2_id.to_s
      @other_instructor = Instructor.find(@booking.instructor1_id)
      @instructor_available = :instructor2_available
    else
      redirect_to @booking, notice: "#{Instructor.find(params[:instructor_id]).name} is not on this booking"
    end
  end


  # PATCH/PUT /instructors/1
  # PATCH/PUT /instructors/1.json
  def update
    if @instructor.update(instructor_params)
      format.html { redirect_to @instructor, notice: 'Instructor was successfully updated.' }
    else
      format.html { render action: 'edit' }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_instructors_params
    params.require(:instructor).permit(:name, :email, :telephone_number, :post_code)
  end
end
