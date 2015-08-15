class CreateRandomizators < ActiveRecord::Migration
  def change
    create_table :randomizators do |t|
      t.string :title
      t.text :text
      t.belongs_to :site, index: true

      t.timestamps null: false
    end
    add_foreign_key :randomizators, :sites
  end
end
