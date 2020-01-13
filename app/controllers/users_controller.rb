class UsersController < ApplicationController
  def update # プロフィール情報更新
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    else
      redirect_to profile_mypage_path(current_user)
    end
  end

  private
  
    def user_params
      params.require(:user).permit(
        :name,
        :introduction
      )
    end

end
