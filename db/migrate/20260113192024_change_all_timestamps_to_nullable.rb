class ChangeAllTimestampsToNullable < ActiveRecord::Migration[8.1]
  def up
    # Для таблицы users
    change_column_null :users, :created_at, true
    change_column_null :users, :updated_at, true
    change_column_null :users, :first_name, true

    

  end
  
  def down
    # Можно оставить пустым или реализовать откат
  end
end
