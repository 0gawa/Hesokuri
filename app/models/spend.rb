class Spend < ApplicationRecord
    belongs_to :user
    belongs_to :spend_genre

    validates :money, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 10**13}
    validates :comment,length: {maximum: 140}

    scope :last_week, -> { where(created_at: Time.current.last_week.all_week) }
    scope :yesterday, -> { where(created_at: Time.zone.yesterday.all_day) }
    scope :today, -> { where(created_at: Time.current.all_day) }
    scope :this_week, -> { where(created_at: Time.current.all_week) }
    scope :this_month, -> { where(created_at: Time.current.all_month) }
end
