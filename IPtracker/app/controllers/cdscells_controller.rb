class CdscellsController < ApplicationController
  before_action :set_cdscell,    only: [:show, :browse_show, :edit, :update, :destroy, :categories_json, :update_category]
  before_action :get_categories, only: [:show, :browse_show, :categories_json]
  
  # GET /cdscells
  # GET /cdscells.json
  def index
    @cdscells = Cdscell.all
  end

  # GET /cdscells/1
  # GET /cdscells/1.json
  def show
    @user = current_user
    @silicons = @cdscell.silicons.paginate(:per_page => 10, page: params[:silicons_page])
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
  
  def update_category
    
    category_list = params[:category_list]
    
    if category_list
      @cdscell.add_category_list!(current_user,category_list)
    end
    
    render :nothing => true
  end

  # DELETE /cdscells/1
  # DELETE /cdscells/1.json
  def destroy
    same_path = request.referrer == cdscell_url(@cdscell)
    @cdscell.destroy
    if same_path
      redirect_to cdscells_path
    else
      redirect_to :back
    end
  end
  
  def categorized_json
    
    categories = current_user.categories
    
    categories.each do |category|
      #Pass the image url
      category.cdscells.each { |cell| 
          path = ActionController::Base.helpers.asset_path(cell.image_name) #asset_path not avaible in controller
          cell.imgpath = path 
      } 
    end

    #Not that the imgpath attribute had to be included in the methods
    render :text => categories.to_json(:include => {:cdscells => { :methods => [:imgpath]}},).to_s
  end
  
  def track_json
    
    cells = current_user.tracked_cells
    
    #Pass the image url
    cells.each { |cell| 
        path = ActionController::Base.helpers.asset_path(cell.image_name) #asset_path not avaible in controller
        cell.imgpath = path 
    } 
    
    #Not that the imgpath attribute had to be included in the methods
    render :text => cells.to_json(:methods => [:imgpath]).to_s
  end
  
  def all_json
    cells = Cdscell.all
    #cells.each { |cell| cell.area = cell.area / (1000.0*1000.0) } #did not work because data is "integer"
    render :text => cells.to_json(:include => [:cdslib]).to_s
  end

  # GET /cdscells/browse_show/1/
  def browse_show
    @cdscell = Cdscell.find(params[:id])
    silicons = @cdscell.silicons
    respond_to do |format|
      format.html {render :partial => 'cdscells/cdscell_silicon', :formats => [:html], :locals => { :cdscell => @cdscell, :silicons => silicons}  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cdscell
      @cdscell = Cdscell.find(params[:id])
      #@cdscell = current_cdslib.microposts.find_by(id: params[:id])
      #redirect_to root_url if @micropost.nil?
    end
    def get_categories
      @categories = @cdscell.categories
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cdscell_params
      params.require(:cdscell).permit(:name, :cdslib_id, :xsize, :ysize, :area, :libimg)
    end
end
