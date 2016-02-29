class User < ActiveRecord::Base

  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(provider: oauth.provider, uid: oauth.uid)
    user.name       = oauth.info.name
    user.uid        = oauth.uid
    user.provider   = oauth.provider
    user.email      = oauth.info.email
    user.token      = oauth.credentials.token
    user.first_name = oauth.info.first_name
    user.last_name  = oauth.info.last_name
    user.image_url  = oauth.info.image
    user.save

    user
  end
end
