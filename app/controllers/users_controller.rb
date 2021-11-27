class UsersController < ApplicationController
  before_action :authenticate_user!
  # Just for making sure you can realize mistake in case you forgot to authorize your controller action
  after_action :verify_authorized, except: [:show]
  
  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to root_path, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(strong_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
  
  private
  # Because devise already sanitize the email and password and comfirmation
  # so I only strong my custom user attributes here.
  def strong_params
    params.require(:user).permit(:role,:uuid)
  end

end