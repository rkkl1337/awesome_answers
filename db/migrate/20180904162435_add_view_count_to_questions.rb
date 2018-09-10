class AddViewCountToQuestions < ActiveRecord::Migration[5.2]
  def change
    #           table name  | column name | data type
    add_column :questions, :view_count, :integer
  end
end
