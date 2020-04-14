class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_logout, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      remember user
      redirect_to user
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
