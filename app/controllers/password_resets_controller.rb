class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "登録されているメールアドレスにパスワード再設定用のメールを送りました。"
      redirect_to root_url
    else
      flash.now[:danger] = "登録されていないメールアドレスです。"
      render 'new'
    end
  end

  def edit

  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.apdate_attributes(user_params)
      log_in @user
      flash[:success] = "パスワードが更新されました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def get_user
      @user = User.find_by(email: params[:email])
    end

    #正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
      end
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード更新の有効期限が過ぎています"
        redirect_to new_password_reset_url
      end
    end
end