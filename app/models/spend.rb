class Spend < ApplicationRecord
    belongs_to :user
    belongs_to :spend_genre

    validates :money, presence: true
    validates :comment,length: {maximum: 140}
end
