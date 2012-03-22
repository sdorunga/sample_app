class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true #adds an index to the email column of the users table, while checking for uniqueness.
  end
end
