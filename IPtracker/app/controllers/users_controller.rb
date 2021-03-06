class UsersController < ApplicationController
  
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers, :categories_json]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    #Updated with AJAX search/paginate
    @users = User.paginate(page: params[:page])
    
    #@users = User.search(params[:search]).paginate(:per_page => 10, :page => params[:page])

  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:per_page => 10, page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(:per_page => 10, page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:per_page => 10, page: params[:page])
    render 'show_follow'
  end
  
  def tracked
    @title = "Tracked Cells"
    @user = User.find(params[:id])
    @tracked_cells = @user.tracked_cells.paginate(:per_page => 10, page: params[:page])
    render 'show_tracked'
  end

  
  def categories_json
    categories = current_user.categories
    render :text => categories.to_json.to_s
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
