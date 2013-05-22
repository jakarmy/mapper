module ApplicationHelper
	def getCurrentUser
    if session[:user_id]
      return User.find(session[:user_id])
  elsif params[:api_key]
    return User.find_by_api_key(params[:api_key]) 
  else
    return false
  end
end
