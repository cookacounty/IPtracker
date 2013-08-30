class SiliconsController < ApplicationController
  before_action :set_silicon, only: [:show, :edit, :update, :destroy]

  # GET /silicons
  def index
    @silicons = Silicon.all
  end

  # GET /silicons/1
  def show
    @cdscells = @silicon.cdscells.paginate(:per_page => 10, page: params[:cdscell_page])
    @cdslibs  = @silicon.cdslibs.paginate(:per_page => 10, page: params[:cdslib_page])
  end

  # GET /silicons/new
  def new
    @silicon = Silicon.new
  end

  # GET /silicons/1/edit
  def edit
  end

  # POST /silicons
  def create
    @silicon = Silicon.new(silicon_params)

    if @silicon.save
      redirect_to @silicon, notice: 'Silicon was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /silicons/1
  def update
    if @silicon.update(silicon_params)
      redirect_to @silicon, notice: 'Silicon was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /silicons/1
  def destroy
    @silicon.destroy
    redirect_to silicons_url, notice: 'Silicon was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_silicon
      @silicon = Silicon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def silicon_params
      params.require(:silicon).permit(:name)
    end
end
