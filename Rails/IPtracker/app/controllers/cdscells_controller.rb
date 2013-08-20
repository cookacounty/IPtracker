class CdscellsController < ApplicationController
  before_action :set_cdscell, only: [:show, :edit, :update, :destroy]

  # GET /cdscells
  # GET /cdscells.json
  def index
    @cdscells = Cdscell.all
  end

  # GET /cdscells/1
  # GET /cdscells/1.json
  def show
  end

  # GET /cdscells/new
  def new
    @cdscell = Cdscell.new
  end

  # GET /cdscells/1/edit
  def edit
  end

  # POST /cdscells
  # POST /cdscells.json
  def create
    @cdscell = Cdscell.new(cdscell_params)

    respond_to do |format|
      if @cdscell.save
        format.html { redirect_to @cdscell, notice: 'Cdscell was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cdscell }
      else
        format.html { render action: 'new' }
        format.json { render json: @cdscell.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cdscells/1
  # PATCH/PUT /cdscells/1.json
  def update
    respond_to do |format|
      if @cdscell.update(cdscell_params)
        format.html { redirect_to @cdscell, notice: 'Cdscell was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cdscell.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cdscells/1
  # DELETE /cdscells/1.json
  def destroy
    @cdscell.destroy
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cdscell
      @cdscell = Cdscell.find(params[:id])
      #@cdscell = current_cdslib.microposts.find_by(id: params[:id])
      #redirect_to root_url if @micropost.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cdscell_params
      params.require(:cdscell).permit(:name, :cdslib_id, :xsize, :ysize, :area, :libimg)
    end
end
