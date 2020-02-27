class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.references :creator, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
