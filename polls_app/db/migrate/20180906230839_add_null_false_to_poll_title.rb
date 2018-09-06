class AddNullFalseToPollTitle < ActiveRecord::Migration[5.1]
  def change
    change_table :polls do |t|
      t.remove :title
      t.string :title, null: false
    end
  end
end
