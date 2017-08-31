Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger

  provider :developer unless Rails.env.production?
  provider :facebook, ENV['FACEBOOK_OAUTH_KEY'], ENV['FACEBOOK_OAUTH_SECRET']
  provider :github, ENV['GITHUB_OAUTH_KEY'], ENV['GITHUB_OAUTH_SECRET']
  provider :google_oauth2, ENV['GOOGLE_OAUTH_KEY'], ENV['GOOGLE_OAUTH_SECRET'], {
    name: "google",
  }
  provider :twitter, ENV['TWITTER_OAUTH_KEY'], ENV['TWITTER_OAUTH_SECRET'], {
    secure_image_url: true,
  }
end
