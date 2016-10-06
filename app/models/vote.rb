# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  votable_id   :integer
#  votable_type :string
#  vote         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user
  
  validates :user_id, presence: true
end
