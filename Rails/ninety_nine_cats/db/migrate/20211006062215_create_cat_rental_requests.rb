class CreateCatRentalRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :cat_rental_requests do |t|
      t.string :status, null: false, default: "PENDING"
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :cat_id, null: false
      t.timestamps
      t.index :cat_id
    end
  end
end
