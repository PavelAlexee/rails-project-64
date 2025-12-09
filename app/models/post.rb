# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  belongs_to :category
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id', inverse_of: :posts # rubocop:disable Rails/RedundantForeignKey

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 }
end
