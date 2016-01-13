class CreateClazzs < ActiveRecord::Migration
  def change
    create_table :clazzs do |t|
      t.integer :instructor_profile_id
      t.integer :studio_id
      t.datetime :time
      t.integer :duration

      t.timestamps null: false
    end
  end
end
