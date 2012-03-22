class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps #creates a "created at" and a "updated at" column with relevant timestamps
    end
  end
end
