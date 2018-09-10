class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    # knex.createTable("questions", t => {
    #   t.increments("id");
    #   t.string("title");
    #   t.text("body");
    #   t.timestamps();
    # })
    create_table :questions do |t|
      # Not shown here an "id" primary key column
      # is always included when creating a table
      t.string :title
      # Creates a column of type VARCHAR(255) with
      # the name "title"
      t.text :body
      # Creates a column of type TEXT with the name "body"

      t.timestamps
      # Creates two columns, "created_at" and "updated_at",
      # why are auto-updated by Active Record.
    end
  end
end
