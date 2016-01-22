def stub_instagram_service
  allow(InstagramService.instance).to receive(:valid_access_token?).and_return(true)
  allow(InstagramService.instance).to receive(:profile_picture_url).and_return("/path/to/image")
end
