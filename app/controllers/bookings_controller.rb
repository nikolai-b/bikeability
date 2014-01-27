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
    @booking_instructors = 2.times { @booking.booking_instructors.build }
    @school = School.find(params[:school_id])
    @form_object = [@school,@booking]
  end

  # GET /bookings/1/edit
  def edit
    @form_object = @booking
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @school = School.find(params[:school_id])
    @booking = @school.bookings.create(booking_params)
    if @booking.save
      files = params[:booking][:booking_asset_array]
      if files
        files.each do |file|
          @booking.booking_assets.create(booking_file: file)
        end
      end
      @booking.email current_user, request.host_with_port
      redirect_to @booking, notice: "Booking created. Email sent to teacher and instructors."
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
                                      booking_instructors_attributes: [:instructor_id])
    end
end
