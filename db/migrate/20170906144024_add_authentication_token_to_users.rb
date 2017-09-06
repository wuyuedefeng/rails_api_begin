class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authentication_token, :string, limit: 30
    add_index :users, :authentication_token, unique: true
  end
end
# rails g migration add_authentication_token_to_users "authentication_token:string{30}:uniq"
