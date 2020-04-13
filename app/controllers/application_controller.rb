class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :require_login

  private

    def require_login
      unless logged_in?
        flash[:danger] = "ユーザーログインが必要です"
        redirect_to login_url
      end
    end

    def require_logout
      if logged_in?
        flash[:danger] = "この操作を行うにはログアウトしてください"
        redirect_to user_url(@current_user)
      end
    end
end
