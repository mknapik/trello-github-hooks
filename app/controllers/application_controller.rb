class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  def index
  end

  # Catches AccessDenied exception thrown by access_denied! or authorize! methods
  # If redirect_path attribute was added to instance of exception
  # then try to redirect to that loacation.
  # Otherwise user is redirected to root_path
  rescue_from CanCan::AccessDenied do |exception|
    if exception.respond_to? :redirect_path
      redirect_to exception.redirect_path, :alert => exception.message
    else
      redirect_to root_path, :alert => exception.message
    end
  end

  protected

  # Methods is a helper_method which throws CanCan::AccessDenied exception.
  # If second argument is specified then redirect_path attribute is injected into exception instance.
  def access_denied!(message, path = nil)
    e = CanCan::AccessDenied.new t(message)
    unless path.nil?
      class << e
        attr_accessor :redirect_path
      end
      e.redirect_path = path
    end
    raise e
  end
end
