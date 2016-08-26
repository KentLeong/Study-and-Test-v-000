class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.string :name
      t.string :test_id
    end
  end

  def down
    drop_table :studies
  end
end
