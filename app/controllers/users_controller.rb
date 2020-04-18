class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_logout, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "#{@user.email}にメールを送信しました。メールを確認して本登録を完了させてください。"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if station_datum = StationDatum.find_by(station_name: params[:station_datum][:station_name])
      params[:user][:station_datum_id] = station_datum.id
      if @user.update_attributes(user_params)
        flash[:success] = "プロフィールを更新しました！"
        redirect_to @user
      else
        render 'edit'
      end
    elsif params[:station_datum][:station_name].blank?
      if @user.update_attributes(user_params)
        flash[:success] = "プロフィールを更新しました！"
        redirect_to @user
      else
        render 'edit'
      end
    else
      flash[:danger] = "存在しない駅名、もしくは駅名が正式名称ではありません。"
      redirect_to edit_user_path(@user)
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :player_name, :email, :password, :password_confirmation, :station_datum_id, :ssbu_experience, :ssbu_skill, :using_character, :lived_prefecture)
    end
end
