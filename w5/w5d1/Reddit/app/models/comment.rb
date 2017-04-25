# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  user_id           :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ApplicationRecord
  validates :content, :user, :post, presence: true

  belongs_to :user,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :post,
    foreign_key: :post_id,
    class_name: :Post

  has_one :parent,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: self

  has_many :children,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: self
end
