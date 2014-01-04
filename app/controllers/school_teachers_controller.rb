class SchoolTeachersController < ApplicationController
  before_action :set_school_teacher, only: [:show, :edit, :update, :destroy]

  # GET /school_teachers
  # GET /school_teachers.json
  def index
    @school_teachers = SchoolTeacher.all
  end

  # GET /school_teachers/1
  # GET /school_teachers/1.json
  def show
  end

  # GET /school_teachers/new
  def new
    @school_teacher = SchoolTeacher.new
  end

  # GET /school_teachers/1/edit
  def edit
  end

  # POST /school_teachers
  # POST /school_teachers.json
  def create
    @school_teacher = SchoolTeacher.new(school_teacher_params)

    respond_to do |format|
      if @school_teacher.save
        format.html { redirect_to @school_teacher, notice: 'School teacher was successfully created.' }
        format.json { render action: 'show', status: :created, location: @school_teacher }
      else
        format.html { render action: 'new' }
        format.json { render json: @school_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /school_teachers/1
  # PATCH/PUT /school_teachers/1.json
  def update
    respond_to do |format|
      if @school_teacher.update(school_teacher_params)
        format.html { redirect_to @school_teacher, notice: 'School teacher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @school_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_teachers/1
  # DELETE /school_teachers/1.json
  def destroy
    @school_teacher.destroy
    respond_to do |format|
      format.html { redirect_to school_teachers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_teacher
      @school_teacher = SchoolTeacher.find_by(uuid: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_teacher_params
      params.require(:school_teacher).permit(:name, :school, :address_line_1, :address_line_2, :city, :postcode, :telephone_number, :email)
    end
end
