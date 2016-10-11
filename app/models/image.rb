# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  file          :string
#  imagable_type :string
#  imagable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Image < ApplicationRecord
  belongs_to :imagable, polymorphic: true
  mount_uploader :file, AttachmentUploader

  has_many :votes, as: :votable
end
