class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :player_name, presence: true, length: { maximum: 20}
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/i
  validates :email, presence: true, uniqueness: true,
              format: {with: VALID_EMAIL_REGEX}
  #半角英字または半角数字をそれぞれ１文字は含まなければならない正規表現。
  VALID_PASSWORD_REGIX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, presence: true, length: { in: 8..16 },
              format: {with: VALID_PASSWORD_REGIX, message: :invalid_password},
              allow_blank: true
  has_secure_password

  #渡された文字列のハッシュを返す。(selfはUser classを表している。)
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  #永続化セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
