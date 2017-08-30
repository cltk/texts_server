class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true

      # https://developers.facebook.com/docs/facebook-login/access-tokens/expiration-and-extension
      t.string :facebook_access_token

      # https://developers.google.com/identity/protocols/OAuth2
      t.string :google_access_token
      t.string :google_refresh_token

      # https://dev.twitter.com/web/sign-in/implementing
      t.string :twitter_oauth_token
      t.string :twitter_oauth_token_secret

      t.timestamps
    end

    add_reference :text_nodes, :user
  end
end
