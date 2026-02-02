# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry

  belongs_to :user, inverse_of: :comments
  belongs_to :post, inverse_of: :comments

  validates :content, presence: true
end
