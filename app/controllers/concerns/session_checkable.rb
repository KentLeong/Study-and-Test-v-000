module Session_Checkable

  # if session is true, go to /tests
  # if not, run code
  def check_if_session_(code)
    if !!session[:user_id]
      redirect to '/tests'
    else
      code
    end
  end

end
