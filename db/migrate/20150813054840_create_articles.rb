class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.text :text
      t.belongs_to :city, index: true
      t.belongs_to :site, index: true

      t.timestamps null: false
    end
    add_foreign_key :articles, :cities
    add_foreign_key :articles, :sites
  end
end
