class HoffsController < ApplicationController
  before_action :can_modify, only: [:edit, :update, :destroy]

  def index
    @hoff = Hoff.all
  end

  def new
    @user = current_user
    @hoff = @user.my_hoffs.build
  end

  def create
    @hoff = current_user.my_hoffs.build(hoff_params)
    if @hoff.save
      flash[:success] = "宅オフを作成しました！"
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def show
    @hoff = Hoff.find_by(id: params[:id])
  end

  def edit
    @hoff = Hoff.find_by(id: params[:id])
  end

  def update
    @hoff = Hoff.find_by(id: params[:id])
    if @hoff.update_attributes(hoff_params)
      flash[:success] = "宅オフの情報を更新しました！"
      redirect_to hoff_path(@hoff)
    else
      render 'edit'
    end
  end

  def destroy
    Hoff.find(params[:id]).delete
    flash[:success] = "宅オフを削除しました"
    redirect_to user_path(current_user)
  end

  private
    def hoff_params
      params.require(:hoff).permit(:name, :dates)
    end
end
