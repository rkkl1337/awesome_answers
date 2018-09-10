class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }
      # Add an `index` to column that you query often.
      # It'll improve the performance that query significantly
      # as it grows in size.
      # An index achieves this by maintaining a seperate
      # data structure for a specific that is searchable
      # with a "binary search" like algorithm.
      t.string :password_digest
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
