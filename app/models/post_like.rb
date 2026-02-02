# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user, inverse_of: :likes
  belongs_to :post, inverse_of: :likes
end
