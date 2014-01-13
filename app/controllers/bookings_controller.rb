class BookingsController < UnauthenticatedController
  before_action :set_booking_and_school, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:index, :new, :create, :destroy]

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
    # CODESMELL
    @booking.school_id = params[:school_id]

    if @booking.save
      files = params[:booking][:booking_asset_array]
      if files
        files.each do |file|
          @booking.booking_assets.create(booking_file: file)
        end
      end
      email = AdminEmailMailer.school_email(@booking, current_user, 'new')

      email.deliver
      redirect_to [@school, @booking], notice: 'Booking created. Email sent to teacher.' 
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:school_id, :start_time, :num_children, :required_bikes, :required_helmets, :booking_asset_array, :instructor1_id, :instructor2_id)
    end
end
