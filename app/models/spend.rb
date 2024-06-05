class Spend < ApplicationRecord
    belongs_to :user
    belongs_to :spend_genre

    validates :money, presence: true
end
