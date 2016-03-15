class FaqLoader
  attr_reader :faq, :config

  def self.load
    self.new(Faq.instance).load
  end

  def initialize faq
    @faq = faq
    @config = YAML.load_file("#{Rails.root}/config/faq.yml")
  end

  def load
    config["faq_items"].each do |faq_item|
      push faq_item["question"], faq_item["answer"]
    end
  end

  private

  def push question, answer
    faq.push FaqItem.new(question, answer)
  end
end
