class AddDescriptionToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :description, :text
  end
end
