class CreateSticks < ActiveRecord::Migration
  def self.up
    create_table :sticks do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :sticks
  end
end
