class BookingsController < ApplicationController
  before_action :set_booking_and_school, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:show, :edit, :update]

  # GET /bookings
  # GET /bookings.json
  def index
    if params[:sort]
      sort_column
    else
      @bookings = Booking.all
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    # CODESMELL
    @booking.school_id = params[:school_id]

    if @booking.save
      files = params[:booking][:booking_asset_array]
      if files
        files.each do |file|
          @booking.booking_assets.create(booking_file: file)
        end
      end
      @booking.email current_user, request.host_with_port
      instructor1 = Instructor.find(@booking.instructor1_id)
      instructor2 = Instructor.find(@booking.instructor2_id)
      redirect_to [@school, @booking], notice: "Booking created. Email sent to teacher. Emails sent to #{instructor1.name} and #{instructor2.name}."
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    if @booking.update(booking_params)
      email = AdminEmailMailer.admin_email(@booking,current_user,'updated')

      email.deliver
      redirect_to @booking, notice: 'Booking updated.' 
    else
      render action: 'edit' 
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to '/bookings' }
      format.json { head :no_content }
    end
  end


  #TECHDEBT move to instructor controller
  def instructor_confirm
    @other_instructor
    @instructor_available

    if :instructor_id == @booking.instructor1_id
      @other_instructor = Instructor.find(@booking.instructor2_id)
      @instructor_available = :instructor1_available
    else
      @other_instructor = Instructor.find(@booking.instructor1_id)
      @instructor_available = :instructor2_available
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking_and_school
      @booking = Booking.find_by(uuid: params[:id])
      @school = School.find(@booking.school_id)
    end

    def sort_column
      direction = !%w[asc desc].include?(params[:direction]) ? "asc" : params[:direction]
      sort = !%w[start_time].include?(params[:sort]) ? "start_time" : params[:sort]
      #TECHDEBT include school_name
      @bookings = Booking.order(sort +" " +direction)
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:school_id, :start_time, :num_children, :required_bikes, :required_helmets, 
                                      :booking_asset_array, :instructor1_id, :instructor2_id, :direction, :sort,
                                      :instructor1_available, :instructor2_available)
    end
end
