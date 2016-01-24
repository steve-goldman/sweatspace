class AddNumberOfWeeksToRepeatingClass < ActiveRecord::Migration
  def change
    add_column :repeating_classes, :number_of_weeks, :integer
  end
end
