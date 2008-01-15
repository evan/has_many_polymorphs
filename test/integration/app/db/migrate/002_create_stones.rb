class CreateStones < ActiveRecord::Migration
  def self.up
    create_table :stones do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :stones
  end
end
