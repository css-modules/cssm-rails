require 'yaml'

begin
  module CSSM
    module Rails
      class Railtie < ::Rails::Railtie
        initializer :cssm_rails_view_helpers do
          ActionView::Base.send :include, CSSM::Rails::ViewHelper
        end

        if config.respond_to?(:assets) && !config.assets.nil?
          config.assets.configure do |env|
            CSSM::Rails.install(env, {})
          end
        else
          initializer :setup_cssm_rails, group: :all do |app|
            if defined? app.assets && !app.assets.nil?
              CSSM::Rails.install(app.assets, {})
            end
          end
        end
      end
    end
  rescue LoadError
  end
end
