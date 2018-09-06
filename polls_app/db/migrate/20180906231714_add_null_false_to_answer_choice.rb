class AddNullFalseToAnswerChoice < ActiveRecord::Migration[5.1]
  def change
    change_table :answer_choices do |t|
      t.remove :question_id, :text
      t.integer :question_id, null: false
      t.text :text, null: false
      t.timestamps
    end
    
    add_index :answer_choices, :question_id
  end
end
