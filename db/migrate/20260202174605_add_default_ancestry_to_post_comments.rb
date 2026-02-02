class AddDefaultAncestryToPostComments < ActiveRecord::Migration[8.1]
  def up
    change_column_default :post_comments, :ancestry, ''
    PostComment.where(ancestry: nil).update_all(ancestry: '')
  end

  def down
    change_column_default :post_comments, :ancestry, nil
  end
end
