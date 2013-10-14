class AddResetPasswordTokenIndex < ActiveRecord::Migration
  def change
    add_index :users, :reset_password_token, :unique => true
  end
end
