class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.string :url
      t.text :description
      t.string :regex

      t.timestamps
    end
  end

  def self.down
    drop_table :partners
  end
end
