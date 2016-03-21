class NewsletterSignupDecorator < Draper::Decorator
  delegate_all

  def display_created_at
    created_at.strftime "%Y-%m-%d"
  end
end
