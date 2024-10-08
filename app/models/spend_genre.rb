class SpendGenre < ApplicationRecord
    belongs_to :user
    has_many :spends, dependent: :destroy

    validates :name, presence: true, uniqueness: {scope: :user}, length: {minimum: 1, maximum: 50}
end
