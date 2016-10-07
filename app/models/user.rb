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
  # Registration autorization
  include Registrable

  # Posts
  has_many :posts, dependent: :destroy

  #admin
  enum role: [:user, :admin] #[:moderator, :owner, etc]

  # blocked
  enum status: [:normal, :blocked]

  # folowing
  include Followable

  # votes
  include Votable
end
