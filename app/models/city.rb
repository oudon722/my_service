class City < ApplicationRecord
  has_many :users
  has_many :hoffs
  belongs_to :prefecture
end
