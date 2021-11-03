class AddUsernameToUser < ActiveRecord::Migration[6.1]
  def up
    execute "UPDATE users SET username = CONCAT('user', floor(random()* (400-100 + 1) + 100)::varchar(255)) WHERE username IS NULL"
  end

  def down
  end
end
