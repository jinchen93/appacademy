class ShortenedUrl < ApplicationRecord
  include SecureRandom
  # validate :no_spamming, :nonpremium_max

  validates :long_url, presence: true, uniqueness: true
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to :submitter,
    foreign_key: :submitter_id,
    class_name: :User

  has_many :visits_ids,
    foreign_key: :link_id,
    class_name: :Visit

  has_many :taggings,
    foreign_key: :link_id,
    class_name: :Tagging

  has_many :tag_topics,
    through: :taggings,
    source: :tag

  def self.random_code
    code = SecureRandom.urlsafe_base64(5)
    while self.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64(5)
    end
    code
  end

  def self.shortenify(user, long_url)
    self.create!(
      long_url: long_url,
      submitter_id: user.id,
      short_url: "tiny.io/#{self.random_code}"
    )
  end

  def self.prune

  end

  def num_clicks
    # Visit.all.select { |visit| visit.link_id == self.id }.count
    self.visits_ids.count
  end

  def num_uniques
    self.visits_ids.select(:visitor_id).distinct.count
  end

  def num_recent_uniques
    # Visit.where({ created_at: 100.minutes.ago..Time.now })
    self.visits_ids.where({
        created_at: 10.minutes.ago..Time.now
      }).select(:visitor_id).distinct.count
  end

  def no_spamming
    all_urls = self.submitter.submitted_urls
    sorted_urls = all_urls.sort do |url1, url2|
      url2.created_at <=> url1.created_at
    end

    recent_five = sorted_urls.take(5)
    current_time = Time.now

    spammer = recent_five.all? do |url|
      url.created_at.between?(1.minutes.ago, current_time)
    end

    if spammer
      self.errors[:base] << "You are a spammer. " \
        "Can't create more than 5 shortURLs within a minute."
    end
    true
  end

  def nonpremium_max
    all_urls = self.submitter.submitted_urls
    unless self.submitter.premium
      if all_urls.count == 5
        self.errors[:base] << "Reached max free limit. " \
        "Please upgrade to premium tinyness"
      end
    end
  end

end
