class NewsletterSignupsController < ApplicationController
  def new
    @newsletter_signup = NewsletterSignup.new
    @referer = request.referer
    if @referer
      @back_link = @referer
    end
  end

  def create
    @newsletter_signup = NewsletterSignup.create create_params
    if @newsletter_signup.valid?
      flash[:success] = "Thanks for signing up!"
      redirect_to params[:referer] || root_path
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:newsletter_signup).permit(NewsletterSignup::PERMITTED_PARAMS)
  end
end
