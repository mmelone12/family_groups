module SessionsHelper

  def add_cache_header
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

	def sign_in(user)
    	remember_token = User.new_remember_token
    	cookies.permanent[:remember_token] = remember_token
    	user.update_attribute(:remember_token, User.encrypt(remember_token))
    	self.current_user = user
    end

    def signed_in?
    	!current_user.nil?
  	end

    def current_user=(user)
    	@current_user = user
  	end

  	def current_user
  		remember_token = User.encrypt(cookies[:remember_token])
    	@current_user ||= User.find_by(remember_token: remember_token)
  	end

  	def current_user?(user)
    	user == current_user
  	end

  	def sign_out
    	self.current_user = nil
    	cookies.delete(:remember_token)
  	end

  	def redirect_back_or(default)
    	redirect_to(session[:return_to] || default)
    	session.delete(:return_to)
  	end

  	def store_location
    	session[:return_to] = request.url
  	end
end