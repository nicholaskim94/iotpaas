class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.integer :project_id

      t.string :sensorModel
      t.string :sensorType
      t.string :unit

      t.datetime :time
      t.decimal :value

      t.decimal :lat
      t.decimal :lng

      t.timestamps null: false
    end
  end
end
