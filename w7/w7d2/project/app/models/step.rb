class Step < ApplicationRecord
  validates :title, :todo_id, presense: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :todo,
    primary_key: :id,
    foreign_key: :todo_id,
    class_name: "Todo"
end
