class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_logout, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "本登録が完了していません"
        message += "#{user.email}にメールが送られていないか確認してください"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end
end
