class AddIndexesToClazz < ActiveRecord::Migration
  def change
    add_index :clazzs, :instructor_profile_id
    add_index :clazzs, :studio_id
  end
end
