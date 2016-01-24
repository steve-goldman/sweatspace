class AddDateAndTimeOfDayToClazzs < ActiveRecord::Migration
  def change
    add_column :clazzs, :date, :string
    add_column :clazzs, :time_of_day, :string
  end
end
