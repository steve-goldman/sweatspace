module RepeatingClassesHelper
  def number_of_weeks_options
    [["Open Ended", 0]].concat(
      11.times.map { |i| [ "#{i + 2} #{'week'.pluralize(i + 2)}", i + 2 ] })
  end
end
