class SignupController < ApplicationController
  def registration
    @user = User.new
  end

  def phone
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]
    @user = User.new
  end

  def address
    session[:phone] = user_params[:phone]
    @user = User.new
  end

  def pay_way
    session[:lastname] = user_params[:lastname]
    session[:firstname] = user_params[:firstname]
    session[:lastname_kana] = user_params[:lastname_kana]
    session[:firstname_kana] = user_params[:firstname_kana]
    session[:address] = user_params[:address_attributes]
    session[:phone] = user_params[:phone]
    @user = User.new
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
    if @user.save && verify_recaptcha(model: @user)
      session[:id] = @user.id
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      if params['payjp-token'].blank?
        redirect_to action: "new"
      else
        customer = Payjp::Customer.create(
        # description: '登録テスト', #なくてもOK
        # email: current_user.email, #なくてもOK
        card: params['payjp-token'],
        # metadata: {user_id: current_user.id}
        ) #念の為metadataにuser_idを入れましたがなくてもOK
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
        :building_name
      ]
    )
  end

end
