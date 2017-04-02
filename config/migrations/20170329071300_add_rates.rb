class AddRates < ActiveRecord::Migration[5.0]
  def self.up
    create_table :rates do |t|
      t.string  :currency, null: false
      t.json    :prices, null: false
      t.date    :date, null: false

      t.index [:currency, :date], unique: true
    end
  end

  def self.down
    drop_table :rates
  end
end
