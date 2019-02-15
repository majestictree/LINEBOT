class CreateBuses < ActiveRecord::Migration[5.2]
  def change
    create_table :buses do |t|
      t.time :time
      t.string :goto

      t.timestamps
    end
  end
end
