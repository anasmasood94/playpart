class AddVideoUrlToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :video_url, :string
  end
end
