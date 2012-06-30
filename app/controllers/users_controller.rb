class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :index, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy


  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user]) #passes the params variable from the new view that are inputed in the form
  	if @user.save #if user can be saved it returns true, else it returns false
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #works without writing user_path
  	else
  		render 'new'
  	end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end

  def edit
    #@user = User.find(params[:id]) #no longer needed as it is applied by the correct_user session helper filter
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def update
    #@user = User.find(params[:id]) #no longer needed as it is applied by the correct_user session helper filter
    if @user.update_attributes(params[:user]) #updates and saves the attributes with the hash for attr_accesible attributes
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
