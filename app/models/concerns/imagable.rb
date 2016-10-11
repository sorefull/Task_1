module Imagable
  extend ActiveSupport::Concern

  included do
    has_one :image, as: :imagable, dependent: :destroy
  end

end
