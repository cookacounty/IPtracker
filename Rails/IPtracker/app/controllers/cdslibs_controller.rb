class CdslibsController < ApplicationController
  before_action :set_cdslib, only: [:show, :edit, :update, :destroy]

  # GET /cdslibs
  # GET /cdslibs.json
  def index
    @cdslibs = Cdslib.all
  end

  # GET /cdslibs/1
  # GET /cdslibs/1.json
  def show
    @cdslib = Cdslib.find(params[:id])
    @cdscells = @cdslib.cdscells.paginate(:per_page => 10, page: params[:page])
  end

  # GET /cdslibs/new
  def new
    @cdslib = Cdslib.new
  end

  # GET /cdslibs/1/edit
  def edit
  end

  # POST /cdslibs
  # POST /cdslibs.json
  def create
    @cdslib = Cdslib.new(cdslib_params)

    respond_to do |format|
      if @cdslib.save
        format.html { redirect_to @cdslib, notice: 'Cdslib was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cdslib }
      else
        format.html { render action: 'new' }
        format.json { render json: @cdslib.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cdslibs/1
  # PATCH/PUT /cdslibs/1.json
  def update
    respond_to do |format|
      if @cdslib.update(cdslib_params)
        format.html { redirect_to @cdslib, notice: 'Cdslib was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cdslib.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cdslibs/1
  # DELETE /cdslibs/1.json
  def destroy
    @cdslib.destroy
    respond_to do |format|
      format.html { redirect_to cdslibs_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cdslib
      @cdslib = Cdslib.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cdslib_params
      params.require(:cdslib).permit(:name)
    end
end
