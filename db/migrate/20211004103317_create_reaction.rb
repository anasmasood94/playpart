class CreateReaction < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.belongs_to :user
      t.belongs_to :video
      t.integer :reaction

      t.timestamps
    end
  end
end
