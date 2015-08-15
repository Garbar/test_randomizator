class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :title
      t.string :url

      t.timestamps null: false
    end
  end
end
