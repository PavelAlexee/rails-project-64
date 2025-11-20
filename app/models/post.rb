class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id' # rubocop:disable Rails/RedundantForeignKey

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :category, presence: true
end
