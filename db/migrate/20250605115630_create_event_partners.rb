class CreateEventPartners < ActiveRecord::Migration[7.1]
  def change
    create_table :event_partners do |t|
      t.references :store, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
