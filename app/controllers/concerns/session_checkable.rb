module Session_Checkable

  # if session is true, go to /tests
  # if not, run code
  def check_if_session_true(code)
    if !!session[:user_id]
      redirect to '/tests'
    else
      code
    end
  end

  def check_if_session_false(code)
    if !session[:user_id]
      redirect to '/login'
    else
      code
    end
  end
end
