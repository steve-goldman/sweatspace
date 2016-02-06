class Add < ActiveRecord::Migration
  def change
    add_column :clazzs, :end_timestamp, :datetime
    add_index :clazzs, :end_timestamp
    Clazz.all.each do |clazz|
      clazz.update_attributes end_timestamp: clazz.timestamp + clazz.class_template.duration.minutes
    end
  end
end
