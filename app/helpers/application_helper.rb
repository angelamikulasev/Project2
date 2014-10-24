module ApplicationHelper
	def intellinav
		nav = ''
		if @current_user.present?
      nav += "<li>#{ link_to('Sign Up', new_user_path) }</li>"
      nav += "<li>#{link_to('Edit profile  ', edit_user_path(@current_user))}</li>"        
      nav += "<li>#{link_to('Sign out ' + @current_user.firstname, login_path, :method => :delete, :data => {:confirm => 'Are you sure?'})}  "

    else 
      nav += "<li>#{link_to('Sign up', new_user_path) }</li>"
      nav += "<li>#{ link_to('Login', new_session_path) }</li>"
      nav += "<li>#{ link_to('About', about_path) }</li>"

	end
	nav

end
end