class UniqueUserName < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :username, :string
    execute "UPDATE users SET username = CONCAT('user', floor(random()* (100000-100 + 1) + 100)::varchar(255)) WHERE username IS NULL"
    add_index :users, :username, unique: true
  end

  def down
    remove_column :users, :username
  end
end
