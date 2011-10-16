class AddLinkIdToClicks < ActiveRecord::Migration
  def self.up
    add_column :clicks, :link_id, :integer
  end

  def self.down
    remove_column :clicks, :link_id
  end
end
