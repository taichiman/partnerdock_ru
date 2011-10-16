class AddIdToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :user_id, :integer
    add_column :links, :partner_id, :integer
  end

  def self.down
    remove_column :links, :user_id
    remove_column :links, :partner_id
  end
end
