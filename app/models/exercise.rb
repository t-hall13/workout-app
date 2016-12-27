class Exercise < ApplicationRecord
  validates :duration_in_minutes, numericality: { only_integer: true }
  validates :workout, presence: true
  validates :workout_date, presence: true
  belongs_to :user
end
