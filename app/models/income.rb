class Income < ApplicationRecord
    belongs_to :user

    validates :money, presence: true, numericality: { greater_than_or_equal_to: 100, less_than: 10**13}
end
