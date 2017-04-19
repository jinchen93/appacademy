class Cat < ApplicationRecord
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: { in: ["M", "F"], message: "Please enter M or F" }
  validates :color, inclusion: {
    in: %w(white black yellow orange),
    message: "Enter a valid color!"
  }

  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "CatRentalRequest",
    dependent: :destroy


end
