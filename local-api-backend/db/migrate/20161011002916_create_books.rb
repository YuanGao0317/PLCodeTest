class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :author
      t.string :categories
      t.string :lastCheckedOut
      t.string :lastCheckedOutBy
      t.string :publisher
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
