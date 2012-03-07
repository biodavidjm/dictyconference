class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :firstname
      t.string :lastname
      t.string :institute
      t.text :address
      t.string :city
      t.integer :zip
      t.string :country
      t.string :email
      t.integer :phone
      t.string :passport

      t.timestamps
    end
  end
end
