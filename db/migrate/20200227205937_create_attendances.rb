class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.references :attendee, foreign_key: { to_table: :users }, index: true
      t.references :attended_event, foreign_key: { to_table: :events }, index: true

      t.timestamps
    end
  end
end
