class AddFieldsToRandomizators < ActiveRecord::Migration
  def change
    add_column :randomizators, :stext, :text
    add_column :randomizators, :newtext, :text
    add_column :randomizators, :wheretext, :integer
  end
end
