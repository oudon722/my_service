class HoffRelationshipActivationsController < ApplicationController
  def new
    hoff_relationship = HoffRelationship.find_by(id: params[:rel_id])
    hoff_relationship.update_attribute(:activated, true)
    flash[:success] = "#{hoff_relationship.participant}さんを承認しました"
    redirect_to user_path(current_user)
  end

  def destroy
    hoff_relationship = HoffRelationship.find_by(id: params[:rel_id])
    hoff_relationship.delete
    flash[:success] = "申請を断りました。"
    redirect_to user_path(current_user)
  end
end
