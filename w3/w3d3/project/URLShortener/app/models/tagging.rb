class Tagging < ApplicationRecord
  validates :tag_id, :link_id, presence: true

  belongs_to :link,
    primary_key: :id,
    foreign_key: :link_id,
    class_name: :ShortenedUrl

  belongs_to :tag,
    primary_key: :id,
    foreign_key: :tag_id,
    class_name: :TagTopic

  def self.add_tag_to_link!(tag, link)
    Tagging.create!(
      tag_id: tag.id,
      link_id: link.id
    )
  end
end
