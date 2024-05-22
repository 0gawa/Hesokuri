class Spend < ApplicationRecord
    belongs_to :user
    has_many :spend_genres, dependent: :destroy
end
