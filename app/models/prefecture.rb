class Prefecture < ApplicationRecord
  has_many :cities
  has_many :hoffs
end
