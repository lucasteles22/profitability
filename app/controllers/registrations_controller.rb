class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      render status: :created
    else
      render :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :first_name, :last_name, :password)
  end
end
