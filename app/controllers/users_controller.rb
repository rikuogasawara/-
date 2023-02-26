class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

    def index
      @users = User.all
     # @user_info = User.find(current_user.id)
      @post = Book.new
    end

  def show
    @user = User.find(params[:id])
    #@user_info = User.find(params[:id])
    @book = Book.new
    @bookers = @user.books
  end

  def edit
    #user_id = params[:id].to_i
    #unless user_id == current_user.id
     # redirect_to user_path(current_user.id)
    #end
    @user = User.find(params[:id])
  end

  def update
       #user_id = params[:id].to_i
    ## redirect_to user_path(current_user.id)
    #end
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end