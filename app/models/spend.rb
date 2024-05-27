class Spend < ApplicationRecord
    belongs_to :user
    belongs_to :spend_genre
end
