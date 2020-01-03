# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook #facebook用ボタンからのメソッド呼び出し
    callback_for(:facebook)
  end

  def google_oauth2 #google用ボタンからのメソッド呼び出し
    callback_for(:google)
  end

  def callback_for(provider) 
    @sns_credential = SnsCredential.from_omniauth(request.env["omniauth.auth"]) # SNS認証情報の取得
    session[:name] = request.env["omniauth.auth"].info.name
    session[:email] = request.env["omniauth.auth"].info.email
    session[:password] = Faker::Internet.password(min_length: 8)
    session[:provider] = @sns_credential.provider
    session[:uid] = @sns_credential.uid

    if session[:devise_flag] == "signup" && @sns_credential.persisted? # 登録画面からのリクエストでSNS登録がある場合
      session[:error] = "#{provider.capitalize}ですでに登録されています。"
      session[:sns_error_flag] = "yes" # SNS登録エラーありのフラグ
      redirect_to new_user_registration_path
    elsif session[:devise_flag] == "signup" # 登録画面からのリクエストでSNS登録がない場合
      session[:sns_existed_flag] = "yes" # 認証情報ありのフラグ
      redirect_to registration_signup_index_path
    elsif session[:devise_flag] == "signin" && @sns_credential.persisted? # ログイン画面からのリクエストでSNS登録がある場合
      sign_in_and_redirect @sns_credential.user, event: :authentication
    else # ログイン画面からのリクエストでSNS登録がない場合
      session[:error] = "#{provider.capitalize}での登録情報がありません。\n他の方法でのログインをお試しください。"
      session[:sns_error_flag] = "yes" # SNS登録エラーありのフラグ
      redirect_to new_user_session_path
    end

  end

  def failure
    redirect_to root_path
  end

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
