class FaqLoader
  attr_reader :faq, :config

  def self.load
    Rails.application.reload_routes!
    self.new(Faq.instance).load
  end

  def initialize faq
    @faq = faq
    @config = YAML.load_file("#{Rails.root}/config/faq.yml")
  end

  def load
    config["faq_items"].each do |faq_item|
      push faq_item["question"], do_substitutions(faq_item["answer"])
    end
  end

  private

  def do_substitutions answer
    answer
      .gsub("%CONTACT_ADDRESS%", ContactService.instance.contact_address)
      .gsub("%NEWSLETTER_SIGNUP_PATH%", Rails.application.routes.url_helpers.new_newsletter_signup_path)
  end

  def push question, answer
    faq.push FaqItem.new(question, answer)
  end
end
