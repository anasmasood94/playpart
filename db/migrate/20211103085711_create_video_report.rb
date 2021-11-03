class CreateVideoReport < ActiveRecord::Migration[6.1]
  def change
    create_table :video_reports do |t|
      t.belongs_to :video, foreign_key: true
      t.string :reason, null: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
