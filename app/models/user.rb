class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
    validates :job, presence: true
end
