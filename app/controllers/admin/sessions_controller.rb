# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create, :new]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(resource)
    admin_dashboards_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path
  end
  
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:admin_id])
  end
end
