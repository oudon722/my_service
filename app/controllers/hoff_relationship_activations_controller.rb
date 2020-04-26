class HoffRelationshipActivationsController < ApplicationController
  def new
    hoff_relationship = HoffRelationship.find_by(id: params[:rel_id])
    if hoff_relationship.hoff.max_pt_count != hoff_relationship.hoff.participants.count
      hoff_relationship.update_attribute(:activated, true)
      flash[:success] = "#{hoff_relationship.participant.player_name}さんを承認しました"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "参加人数が上限に達しています"
      redirect_to current_user
    end
  end

  def destroy
    hoff_relationship = HoffRelationship.find_by(id: params[:rel_id])
    hoff_relationship.delete
    flash[:success] = "申請を断りました。"
    redirect_to user_path(current_user)
  end
end
