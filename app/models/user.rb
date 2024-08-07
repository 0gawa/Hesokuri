class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line] ,:authentication_keys => [:email, :name]

  has_many :incomes, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :spends, dependent: :destroy
  has_many :spend_genres, dependent: :destroy
  has_many :per_monthes, dependent: :destroy

  enum sex: {man: 0, woman: 1, others: 2}, _prefix: true
  enum job: {agri_fish: 0, mining: 1, construction: 2, manufacturing: 3,
    elect_gas: 4, transportation: 5, retail: 6, restaurant: 7, finance_insurance: 8,
    estate: 9, service: 10, others: 11}

    validates :name, presence: true, length: {minimum: 2, maximum: 20}
    validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 131 }
    validates :save_money, presence: true, numericality: {greater_than_or_equal_to: 0, less_than: 10**13}
    validates :job, presence: true

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
