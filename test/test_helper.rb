ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  def log_in (usuario)
    if integration_test?
      login_as(usuario, :scope => :usuario)
    else
      sign_in(usuario)
    end
  end
end
