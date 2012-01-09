require 'rails'
require 'bravo_guard'

module BravoGuard
  class Railtie < Rails::Railtie

    initializer "bravo_guard.controller" do
      ActionController::Base.send :include, Controller
    end


    initializer "bravo_guard.model" do |app|
      ActiveRecord::Base.send :extend, BravoGuard::Model::Hooks
      BravoModel::Base.send :extend, BravoGuard::Model::Hooks rescue nil
    end

  end
end
