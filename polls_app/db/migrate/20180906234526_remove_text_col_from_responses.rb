class RemoveTextColFromResponses < ActiveRecord::Migration[5.1]
  def change
    change_table :responses do |t|
      t.remove :text
    end
  end
end
