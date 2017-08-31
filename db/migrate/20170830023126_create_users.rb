class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      # email might be null coming through certain OAuth paths
      t.string :email
      t.string :username, null: false, unique: true

      # https://developers.facebook.com/docs/facebook-login/access-tokens/expiration-and-extension
      t.string :facebook_access_token
      t.string :facebook_uid

      t.string :github_access_token
      t.string :github_uid

      # https://developers.google.com/identity/protocols/OAuth2
      t.string :google_access_token
      t.string :google_refresh_token
      t.string :google_uid

      # https://dev.twitter.com/web/sign-in/implementing
      t.string :twitter_access_token
      t.string :twitter_secret
      t.string :twitter_uid

      t.timestamps
    end

    add_reference :text_nodes, :user
  end
end
