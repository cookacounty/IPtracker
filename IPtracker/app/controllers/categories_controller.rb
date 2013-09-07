class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  
  def index
    @user = current_user
    @categories = current_user.categories
    @uncategorized = current_user.uncategorized_cells
  end
  
  def show
    @cdscells = @category.cdscells.paginate(:per_page => 10, page: params[:cdscell_page])
    @cdslibs  = @category.cdslibs.paginate(:per_page => 10, page: params[:cdslib_page])
  end
  
  def new
    @category = Category.new
  end
  
  def edit
    
  end

  # DELETE /silicons/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save!
      flash[:success] = 'Category Created!'
      redirect_to categories_url
    else
      flash[:failure] = 'Category was note created. Try again!'
      render 'new'
    end
  end
  
  # PATCH/PUT /silicons/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end
    
    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name)
    end
end