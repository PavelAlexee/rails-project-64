# frozen_string_literal: true

Post.destroy_all
Category.destroy_all
User.destroy_all

categories = %w[
  Technology
  Science
  Programming
]

categories.each do |category_name|
  Category.create!(name: category_name)
end
