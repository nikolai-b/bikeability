class BookingsController < UnauthenticatedController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_school_teacher

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
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
    @booking.school_teacher = @school_teacher

    if @booking.save
    email = AdminEmailMailer.admin_email(@booking,current_user,'new')

    email.deliver
      redirect_to [@school_teacher, @booking], notice: 'Booking requested. We will be in touch.' 
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
      redirect_to [@school_teacher, @booking], notice: 'Booking was successfully updated.' 
    else
      render action: 'edit' 
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def set_school_teacher
      @school_teacher = SchoolTeacher.find_by(uuid: params[:school_teacher_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:school_teacher_id, :start_time, :num_children, :required_bikes, :required_helmets)
    end
end
