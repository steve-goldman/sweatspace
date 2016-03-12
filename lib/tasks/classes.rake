desc "create classes for open-ended recurring classes"
task refresh_open_ended_classes: :environment do
  RecurringClass.confirmed.open_ended.each do |recurring_class|
    recurring_class.create_classes
  end
end
