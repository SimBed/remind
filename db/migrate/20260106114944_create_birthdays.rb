class CreateBirthdays < ActiveRecord::Migration[8.0]
  def change
    create_table :birthdays do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :date, null: false

      t.timestamps
    end
    add_index :birthdays, :date
  end
end
