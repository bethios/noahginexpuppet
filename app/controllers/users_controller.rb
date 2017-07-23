class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new

    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
