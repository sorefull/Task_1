# == Schema Information
#
# Table name: likes
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  likable_id   :integer
#  likable_type :string
#

class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  belongs_to :user
  # belongs_to :post

  validates :user_id, presence: true
end
