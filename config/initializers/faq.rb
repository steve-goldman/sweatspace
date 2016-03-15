Rails.application.config.to_prepare do
  FaqLoader.load
end
