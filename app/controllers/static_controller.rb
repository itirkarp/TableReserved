class StaticController < ApplicationController
  before_filter :login_from_cookie
  before_filter :login_required

  def careers
  end

end
