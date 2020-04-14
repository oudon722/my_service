class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_logout, only: [:new, :create]
  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録完了！ユーザープロフィールに詳細な情報を書き込もう！"
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :player_name, :email, :password, :password_confirmation)
    end
end
