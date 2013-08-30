class StaticPagesController < ApplicationController
  
  helper_method :sort_column, :sort_direction
    
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(:per_page => 10, page: params[:page])
      #@feed_items = Micropost.all.paginate(:per_page => 10, page: params[:page])
    end
  end
  
  def references
  end
  
  def help
  end
  
  def about
  end
  
  def contact
  end

  def browse
      #cells = Cdscell.all
      #libs = Cdslib.all
      
      #list = [cells,libs].flatten
      #sorted_list = list.sort_by{ |item| item[:sort_column]}

      #@cdscells = Cdscell.order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, page: params[:page])
  end
  
  def inventory
    @silicons = Silicon.paginate(:per_page => 10, page: params[:page])
    @cdslibs  = Cdslib.paginate(:per_page => 10, page: params[:page])
    @cdscells = Cdscell.paginate(:per_page => 10, page: params[:page])
    @tracked_cells = current_user.tracked_cells.paginate(:per_page => 10, page: params[:page])
  end
  
  def layout
    
  end
  
  private
  
    def sort_column  
      params[:sort] || "name"  
    end  
    
    def sort_direction  
      params[:direction] || "asc"  
    end
    
end
