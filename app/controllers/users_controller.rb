class UsersController < ApplicationController


  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new, alert: "Please try again."
    end
  end

  def show
    if logged_in?
      @user = User.find_by_id(params[:id])
    else
      redirect_to '/'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :nausea, :happiness, :tickets, :height, :admin)
  end

  def logged_in?
    !!session[:user_id]
  end

  def set_user
    @user = User.find_by_id(params[:id])
  end



end