class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line] ,:authentication_keys => [:email]

  has_many :incomes, dependent: :destroy
  has_many :spends, dependent: :destroy
  has_many :spend_genres, dependent: :destroy
  has_many :per_months, dependent: :destroy

  enum sex: {man: 0, woman: 1, others: 2}, _prefix: true
  enum job: {executive: 0, company_employee: 1, temporary_employee: 2,
    part_time: 3, civil_servant: 4, education: 5, medical: 6, self_employed: 7,
    house: 8, student: 9, unemployed: 10, others: 11}
  enum prefecture:{
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
    沖縄県:47
  }

  validates :kan_name, presence: true, length: {minimum: 2, maximum: 20}
  validates :kana_name, presence: true, length: {minimum: 2, maximum: 100}
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 131 }
  validates :save_money, presence: true, numericality: {greater_than_or_equal_to: 0, less_than: 10**13}
  validates :job, presence: true
  validates :prefecture, presence: true
  validates :phone_number, presence: true
  validates :region, presence: true, length: {minimum: 1, maximum: 100}

  def active_for_authentication?
    super && (is_unsubscribed == false)
  end

  #LINEログイン
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
  end
  
  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end
end
