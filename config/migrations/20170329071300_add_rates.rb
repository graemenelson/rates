class AddRates < ActiveRecord::Migration[5.0]
  def self.up
    create_table :rates do |t|
      t.string  :base, null: false
      t.string  :quoted, null: false
      t.decimal :price, null: false
      t.date    :date, null: false

      t.index :base
      t.index [:base, :quoted]
      t.index :date
    end
  end

  def self.down
    drop_table :rates
  end
end
