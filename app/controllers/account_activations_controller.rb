class AccountActivationsController < ApplicationController
  def edit
    user = find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zome.now)
      log_in user
      flash[:success] = "本登録完了！ユーザーページから詳細な情報を書き込もう！"
      redirect_to user
    else
      flash[:danger] = "有効化の期限が切れています"
      redirect_to root_url
    end
  end
end
