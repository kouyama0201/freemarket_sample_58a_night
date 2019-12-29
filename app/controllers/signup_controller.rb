class SignupController < ApplicationController
  include RedirectToTop
  before_action :redirect_to_top, only: :complete
  before_action :validates_registration, only: :phone
  before_action :validates_phone, only: :address  
  before_action :validates_address, only: :pay_way

  def registration
    @user = User.new
  end

  def phone
    @user = User.new
  end

  def address
    @user = User.new
  end

  def pay_way
    @user = User.new
    gon.payjp_key = ENV["PAYJP_KEY"]
  end
  
  def complete
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  def create
    @user = User.new(
    name: session[:name],
    email: session[:email],
    password: session[:password],
    password_confirmation: session[:password_confirmation],
    phone: session[:phone],
    lastname: session[:lastname],
    firstname: session[:firstname],
    lastname_kana: session[:lastname_kana],
    firstname_kana: session[:firstname_kana],
    birth_year: session[:birth_year],
    birth_month: session[:birth_month],
    birth_day: session[:birth_day]
    )
    @user.build_address(session[:address])
    if @user.save
      session[:id] = @user.id
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      binding.pry
      if params['payjp-token'].blank?
        redirect_to pay_way_signup_index_path
      else
        customer = Payjp::Customer.create(
        card: params['payjp-token'],
        ) 
        @card = Card.new(user_id: session[:id], customer_id: customer.id, card_id: customer.default_card)
        if @card.save
            redirect_to complete_signup_index_path
        else
          render '/signup/registration'
        end
      end
    else
      render '/signup/registration'
    end

  end


  private
  
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :avatar,
      :introduction,
      :lastname,
      :firstname,
      :lastname_kana,
      :firstname_kana,
      :birth_year,
      :birth_month,
      :birth_day,
      :phone,
      address_attributes: [
        :id,
        :postal_code,
        :prefecture_id,
        :city,
        :street,
        :building_name,
        :phone_optional
      ]
    )
  end
  
  def validates_registration
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:lastname] = user_params[:lastname]
    session[:firstname] = user_params[:firstname]
    session[:lastname_kana] = user_params[:lastname_kana]
    session[:firstname_kana] = user_params[:firstname_kana]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]
    @user = User.new(
      name: session[:name],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      phone: "0123456789",
      lastname: session[:lastname],
      firstname: session[:firstname],
      lastname_kana: session[:lastname_kana],
      firstname_kana: session[:firstname_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      address_attributes: {
        postal_code:  "1234567",
        prefecture_id:   "1",
        city:           "AAA",
        street:         "BBB",
        phone_optional:  "0123456789"
      }
    )
    render 'signup/registration' unless @user.valid?
  end

  def validates_phone
    session[:phone] = user_params[:phone]
    @user = User.new(
      name: session[:name],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      phone: session[:phone],
      lastname: session[:lastname],
      firstname: session[:firstname],
      lastname_kana: session[:lastname_kana],
      firstname_kana: session[:firstname_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      address_attributes: {
        postal_code:  "1234567",
        prefecture_id:   "1",
        city:           "AAA",
        street:         "BBB",
        phone_optional:  "0123456789"
      } 
    )
    render 'signup/phone' unless @user.valid?
  end

  def validates_address
    session[:lastname] = user_params[:lastname]
    session[:firstname] = user_params[:firstname]
    session[:lastname_kana] = user_params[:lastname_kana]
    session[:firstname_kana] = user_params[:firstname_kana]
    session[:address] = user_params[:address_attributes]
    @user = User.new(
      name: session[:name],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      phone: session[:phone],
      lastname: session[:lastname],
      firstname: session[:firstname],
      lastname_kana: session[:lastname_kana],
      firstname_kana: session[:firstname_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      address_attributes: session[:address]
    )
    render 'signup/address' unless @user.valid?
  end
end
