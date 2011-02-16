class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.column :name, :string, :limit => 100
      t.column :url, :string
      t.column :format, :string, :limit => 3
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
