class UsersController < ApplicationController
  WHITELIST_ATTRIBUTES = [
    :first_name,
    :last_name,
    :email,
    :phone_number,
    :password
  ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(*WHITELIST_ATTRIBUTES)
  end
end
