class RemoveDateFromClicks < ActiveRecord::Migration
  def self.up
    remove_column :clicks, :date
  end

  def self.down
    add_column :clicks, :date, :date
  end
end
