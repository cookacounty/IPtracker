class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(:per_page => 10, page: params[:page])
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
end
