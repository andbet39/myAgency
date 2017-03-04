module UserHelper

  def show_avatar(user)
    if user.profile.avatarimg_url != "" && user.profile.avatarimg_url !=nil 
      image_tag(user.profile.avatarimg_url, class: 'avatar-circle')
    else
      render partial: 'partials/avatar'
    end
  end


end
