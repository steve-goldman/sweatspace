class Faq
  include Singleton
  delegate :push, :freeze, to: :faq_items

  def faq_items
    @faq_items ||= []
  end
end
