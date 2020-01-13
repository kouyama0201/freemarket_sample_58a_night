# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  prepend_before_action :check_captcha, only: [:create]
  before_action :add_flag, only: [:new]

  private
    def check_captcha # reCAPTCHAのチェック
      unless verify_recaptcha
        self.resource = resource_class.new sign_in_params
        respond_with_navigational(resource) { render :new }
      end 
    end

    def add_flag # フラグ追加
      session[:devise_flag] = "signin" # ログインからのリクエストフラグ
      if session[:sns_error_flag] == "yes" || session[:sns_existed_flag] == "yes"
        session[:sns_error_flag] = nil
        session[:sns_existed_flag] = nil
      else
        session[:error] = nil
      end
    end

  # before_action :configure_sign_in_params, only: [:create]

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
