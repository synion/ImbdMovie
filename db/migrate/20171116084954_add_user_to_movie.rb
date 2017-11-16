class AddUserToMovie < ActiveRecord::Migration[5.1]
  def change
    add_reference :movies, :user, index: true
  end
end
