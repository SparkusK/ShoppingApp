module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.firstname, class: "gravatar")
  end

  # Returns true if the user has activated their account, false otherwise
  def activated?(user)
    if user.activated?
      return true
    else
      return false
    end
  end


end
