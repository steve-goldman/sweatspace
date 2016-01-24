class CreateRepeatingClasses < ActiveRecord::Migration
  def change
    create_table :repeating_classes do |t|
      t.string :day_of_week
      t.time :time
      t.integer :class_template_id
      t.integer :studio_id
      t.integer :instructor_profile_id
      t.boolean :forever
      t.date :last_created_date
      t.boolean :confirmed
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :repeating_classes, :class_template_id
    add_index :repeating_classes, :studio_id
    add_index :repeating_classes, :instructor_profile_id
    add_index :repeating_classes, :confirmed
    add_index :repeating_classes, :deleted_at
  end
end
