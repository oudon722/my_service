class HoffRelationshipsController < ApplicationController
  def create
    hoff = Hoff.find(params[:hoff_id])
    hoff.participants << current_user
    flash[:success] = "#{hoff.name}に参加申請を送りました！"
    redirect_to current_user
  end

  def destroy
    hoff_relationship = HoffRelationship.find_by(id: params[:rel_id])
    hoff_relationship.delete
    flash[:success] = "申請を断りました。"
    redirect_to user_path(current_user)
  end
end
