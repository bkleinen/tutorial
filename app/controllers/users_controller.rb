class UsersController < ApplicationController
  
  #10.1 # 10.4
  before_filter :authenticate, :only => [:index, :edit, :update]
  #10.2
  before_filter :correct_user, :only => [:edit, :update]

  
   def index
    @title = "All users"
    # @users = User.all
    @users = User.paginate(:page => params[:page])
   end

  def new
    @title = "Sign up"
    @user = User.new
  end
  
  def show
     @user = User.find(params[:id])
     @title = @user.name
  end
 
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    # @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  
  private
    #10.1
    def authenticate
      deny_access unless signed_in?
    end
    #10.2
    def current_user?(user)
      user == current_user
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end


end
