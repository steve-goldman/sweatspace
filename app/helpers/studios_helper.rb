module StudiosHelper
  def studio_options
    Studio.all.map do |studio|
      [studio.name, studio.id]
    end
  end
end
