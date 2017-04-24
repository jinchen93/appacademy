class Toy < ActiveRecord::Base
  belongs_to :toyable, polymorphic: true
  validates :name, uniqueness: { scope: :toyable_type }
end
