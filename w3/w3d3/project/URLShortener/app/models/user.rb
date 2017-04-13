class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :premium, presence: true

  has_many :submitted_urls,
    foreign_key: :submitter_id,
    class_name: :ShortenedUrl

  has_many :visited_urls_ids,
    foreign_key: :visitor_id,
    class_name: :Visit

  has_many :visited_urls,
    through: :visited_urls_ids,
    source: :link

end
