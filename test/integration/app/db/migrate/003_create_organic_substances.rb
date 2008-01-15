class CreateOrganicSubstances < ActiveRecord::Migration
  def self.up
    create_table :organic_substances do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :organic_substances
  end
end
