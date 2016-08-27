class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.integer :user_id
      t.string :description
    end
  end

  def down
    drop_table :tests
  end
end
