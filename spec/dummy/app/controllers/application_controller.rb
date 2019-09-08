class ApplicationController < ActionController::Base
  include Crudible::Controller::Base

  def show
    render html: '', layout: 'application'
  end
end
