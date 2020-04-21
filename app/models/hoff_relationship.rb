class HoffRelationship < ApplicationRecord
  #:{名前}_idのオブジェクトを指定したクラスから取り出す
  belongs_to :hoff, class_name: "Hoff" #このclass_nameは書かなくてもよい
  belongs_to :participant, class_name: "User" #このclass_nameは必要
  validates :hoff_id, presence: true
  validates :participant_id, presence: true
end
