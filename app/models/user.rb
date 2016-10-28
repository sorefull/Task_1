# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  role            :integer          default("user")
#  status          :integer          default("normal")
#  provider        :string
#  provider_id     :string
#  auth_token      :string
#

class User < ApplicationRecord
  # votes
  has_many :votes, dependent: :destroy

  #admin
  enum role: [:user, :admin] #[:moderator, :owner, etc]

  # Posts
  has_many :posts, dependent: :destroy

  # blocked
  enum status: [:normal, :blocked]

  # comments
  has_many :comments, dependent: :destroy

  # Registration autorization
  include Registrable

  # folowing
  include Followable

  # attachment avatar
  include Imagable
end
