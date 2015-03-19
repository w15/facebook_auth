class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by(uid: auth['uid'])

    if user
      # sign in existing user
      session['uid'] = user.uid
      redirect_to "/users/#{user.id}"
    else
      # create new user from facebook data
      u = User.new
      u.uid = auth['uid']
      u.email = auth['info']['email']
      u.image_url = auth['info']['image'] + "?type=large"
      u.save

      session['uid'] = u.uid
      redirect_to "/users/#{u.id}"
    end
  end

  def destroy
    reset_session

    redirect_to "/users"
  end

end
