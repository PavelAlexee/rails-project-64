class AddAncestryToPostComments < ActiveRecord::Migration[8.0]
  def change
    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      add_column :post_comments, :ancestry, :string, collation: 'C', null: false, default: ''
    else
      add_column :post_comments, :ancestry, :string, null: false, default: ''
    end
    
    add_index :post_comments, :ancestry
  end
end
