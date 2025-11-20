class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
