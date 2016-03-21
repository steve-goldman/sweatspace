class Admin::NewsletterSignupsController < Admin::ControllerBase
  def index
    @newsletter_signups = NewsletterSignup.order(created_at: :desc).decorate
    @count = @newsletter_signups.count
  end
end
