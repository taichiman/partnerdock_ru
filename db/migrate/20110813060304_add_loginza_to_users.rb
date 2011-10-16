class AddLoginzaToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :loginza, :string
  end

  def self.down
    remove_column :users, :loginza
  end
end
