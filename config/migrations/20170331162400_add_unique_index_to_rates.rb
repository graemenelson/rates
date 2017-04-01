class AddUniqueIndexToRates < ActiveRecord::Migration[5.0]
  def self.up
    add_index :rates, [:base, :quoted, :date], unique: true
  end

  def self.down
    remove_index :rates, [:base, :quoted, :date]
  end
end
