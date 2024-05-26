class SpendGenre < ApplicationRecord
    belongs_to :user
    has_many :spends, dependent: :destroy

    validates :name, presence: true, uniqueness: true
end
