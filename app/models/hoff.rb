class Hoff < ApplicationRecord
  belongs_to :prefecture
  belongs_to :city
  belongs_to :owner, class_name: "User"
  has_many :pt_relationships, class_name: "HoffRelationship",
                    foreign_key: "hoff_id",
                    dependent: :destroy
  has_many :participants, through: :pt_relationships #Hoff.participantsで配列のように扱えるようになった
  validates :owner_id, presence: true
  validates :name, presence: true
  validates :dates, presence: true
  validates :prefecture_id, presence: true
  validates :city_id, presence: true
  validates :pt_cost, presence: true, numericality: true
  validates :max_pt_count, presence: true, numericality: true
  validates :parking_space, presence: true
  validates :station_name, presence: true
  validates :end_dates, presence: true
  validate :date_not_before_today
  validate :end_dates_not_before_dates

  enum required_level: {
    誰でも歓迎:1,vip入ってる人のみ:2,vip上位勢のみ:3
  }

  enum parking_space: {
    無料駐車場あり:1,有料駐車場あり:2,なし:3
  }

  enum permit_first_look: {
    許可する:1,許可しない:2
  }

  def date_not_before_today
    errors.add(:dates, "は現在時刻以降でないといけません。") if !dates.nil? && dates < Time.zone.now
  end

  def end_dates_not_before_dates
    errors.add(:end_dates, "は開始日時以降でないといけません。") if !dates.nil? && !end_dates.nil? && end_dates < dates
  end

  scope :search, -> (search_params) do
    passed_due_date.in_order if search_params.blank?

    passed_due_date.dates_from(search_params[:dates_from]).dates_to(search_params[:dates_to]).prefecture_id_is(search_params[:prefecture_id]).city_id_is(search_params[:city_id]).required_level_is(search_params[:required_level]).pt_cost_from(search_params[:pt_cost_from]).pt_cost_to(search_params[:pt_cost_to]).parking_space_is(search_params[:parking_space]).in_order
  end
  #宅オフの開始日時が現在時刻を過ぎていたら検索結果に表示されない
  scope :passed_due_date, -> { where("dates > ?", Time.zone.now) }
  #作成順に並び替え
  scope :in_order, -> { order(created_at: :desc) }
  #開催日時を範囲検索
  scope :dates_from, -> (from) { where('? <= dates', from) if from.present? }
  #toは0:00なので１日後の値にする
  scope :dates_to, -> (to) { where('dates <= ?', Date.parse(to).tomorrow.to_s) if to.present? }
  #都道府県で検索する
  scope :prefecture_id_is, -> (prefecture_id) { where(prefecture_id: prefecture_id) if prefecture_id.present? }
  #市区町村まで範囲を狭めて検索
  scope :city_id_is, -> (city_id) { where(city_id: city_id) if city_id.present? }
  #求めるレベルで検索
  scope :required_level_is, -> (required_level) { where(required_level: required_level) if required_level.present? }
  #参加費で範囲検索
  scope :pt_cost_from, -> (from) { where('? <= pt_cost', from) if from.present? }
  scope :pt_cost_to, -> (to) { where('pt_cost <= ?', to) if to.present? }
  #駐車場の有無で検索
  scope :parking_space_is, -> (parking_space) { where(parking_space: parking_space) if parking_space.present? }

end
