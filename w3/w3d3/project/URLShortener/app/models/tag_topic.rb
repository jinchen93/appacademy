class TagTopic < ApplicationRecord
  validates :topic, presence: true, uniqueness: true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_id,
    class_name: :Tagging

  has_many :tagged_links,
    through: :taggings,
    source: :link

  def popular_links
    array_of_links = self.tagged_links
    sorted_links = array_of_links.sort do |link1, link2|
      link2.num_clicks <=> link1.num_clicks
    end
    sorted_links.take(5)
  end
end
