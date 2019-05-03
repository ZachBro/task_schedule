class UsersController < ApplicationController
  before_action :correct_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      log_in @user
      flash[:success] = "Weclome to task schedule"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def create_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
end
