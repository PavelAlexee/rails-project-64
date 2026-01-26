# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry

  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  before_validation :set_default_ancestry

  private

  def set_default_ancestry
    self.ancestry = '' if ancestry.nil?
  end
end
