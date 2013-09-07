class CategoriesController < ApplicationController
  
  def index
    @user = current_user
    @categories = current_user.owned_tags.sort! {|a,b| a=="uncategorized" ? -1 : a}
  end
  def show
    @categories = current_user.owned_tags
  end

end