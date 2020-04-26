class CitiesController < ApplicationController
  def index
    @prefecture = Prefecture.find(params[:prefecture_id])
    render json: @prefecture.cities.select(:id, :name)
  end
end
