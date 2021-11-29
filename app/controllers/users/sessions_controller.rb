# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    if user_signed_in?
      update_session_uuid current_user.uuid

      flash[:notice] = "Successful login!"
  
    else
      flash[:notice] = "Incorrect email or password!"
      redirect_to new_session_path
    end
  end

  # DELETE /resource/sign_out
  def destroy
    cookies.delete :user_uuid
    sign_out current_user
    flash[:notice] = "Successful sign out!"
    redirect_to root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
