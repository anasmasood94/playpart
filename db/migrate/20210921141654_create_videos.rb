class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :result_video_url
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
