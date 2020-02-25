class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.datetime :date
      t.references :creator, foreign_key: { to_table: :user }, index: true

      t.timestamps
    end
  end
end
