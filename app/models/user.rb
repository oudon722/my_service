class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :city, optional: true
  belongs_to :prefecture, optional: true
  has_many :my_hoffs, class_name: "Hoff",
                  foreign_key: "owner_id",
                  dependent: :destroy
  has_many :hoff_relationships, class_name: "HoffRelationship", #class名は書かなくても良い
                  foreign_key: "participant_id",
                  dependent: :destroy
  has_many :others_hoffs, through: :hoff_relationships, source: :hoff
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
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

  enum ssbu_experience: {
    スマブラ初代から:1,スマブラDXから:2,スマブラXから:3,スマブラfor（3DS、WiiU）から:4,スマブラSPから（１年未満）:5,スマブラSPから（１年以上）:6
  }

  enum ssbu_skill: {
    世界戦闘力300万未満:1,世界戦闘力300万以上、vip直前未満:2,vip直前:3,vip入りたて:4,vip安定:5,vip上位:6
  }

  enum using_character: {
    マリオ:1,ドンキーコング:2,リンク:3,サムス:4,ダークサムス:5,ヨッシー:6,カービィ:7,フォックス:8,ピカチュウ:9,ルイージ:10,ネス:11,キャプテン・ファルコン:12,プリン:13,ピーチ:14,デイジー:15,クッパ:16,アイスクライマー:17,シーク:18,ゼルダ:19,ドクターマリオ:20,ピチュー:21,ファルコ:22,マルス:23,ルキナ:24,こどもリンク:25,ガノンドロフ:26,ミュウツー:27,ロイ:28,クロム:29,Mrゲーム＆ウォッチ:30,メタナイト:31,ピット:32,ブラックピット:33,ゼロスーツサムス:34,ワリオ:35,スネーク:36,アイク:37,ポケモントレーナー:38,ディディーコング:39,リュカ:40,ソニック:41,デデデ:42,ピクミン＆オリマー:43,ルカリオ:44,ロボット:45,トゥーンリンク:46,ウルフ:47,むらびと:48,ロックマン:49,WiiFitトレーナー:50,ロゼッタ＆チコ:51,リトル・マック:52,ゲッコウガ:53,Miiファイター（格闘）:54,Miiファイター（剣術）:55,Miiファイター（射撃）:56,パルテナ:57,パックマン:58,ルフレ:59,シュルク:60,クッパJr:61,ダックハント:62,リュウ:63,ケン:64,クラウド:65,カムイ:66,ベヨネッタ:67,インクリング:68,リドリー:69,シモン:70,リヒター:71,キング・クルール:72,しずえ:73,ガオガエン:74,パックンフラワー:75,ジョーカー:76,勇者:77,バンジョー＆カズーイ:78,テリー:79,ベレト／ベレス:80
  }

  #姓と名を合わせた名前を返す
  def name
    [last_name, first_name].join(' ')
  end
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
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  #パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  #パスワード再設定用のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  #パスワード再設定の有効期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    #メールアドレスをすべて小文字にする
    def downcase_email
      self.email = email.downcase
    end

    #有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
