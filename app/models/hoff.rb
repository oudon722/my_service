class Hoff < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :pt_relationships, class_name: "HoffRelationship",
                    foreign_key: "hoff_id",
                    dependent: :destroy
  has_many :participants, through: :pt_relationships #Hoff.participantsで配列のように扱えるようになった
  validates :owner_id, presence: true
  validates :name, presence: true
  validates :dates, presence: true
  validate :date_not_before_today

  def date_not_before_today
    errors.add(:dates, "は現在時刻以降の日時を指定してください") if !dates.nil? && dates < Time.zone.now
  end
end
