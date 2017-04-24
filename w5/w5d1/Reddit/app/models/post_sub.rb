# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ApplicationRecord
  belongs_to :sub,
    foreign_key: :sub_id,
    class_name: :Sub

  belongs_to :post,
    foreign_key: :post_id,
    class_name: :Post
end
