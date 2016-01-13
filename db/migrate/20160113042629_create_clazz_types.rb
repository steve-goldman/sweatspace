class CreateClazzTypes < ActiveRecord::Migration
  def change
    create_table :clazz_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
